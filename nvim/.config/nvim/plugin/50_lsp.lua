local map = vim.keymap.set

-- let servers update imports etc. when a file is renamed (<leader>cR), Neovim does not advertise this by default
vim.lsp.config('*', {
    capabilities = {
        workspace = {
            fileOperations = { didRename = true, willRename = true },
        },
    },
})

map('n', '<leader>cr', vim.lsp.buf.rename, { desc = '[C]ode [R]ename' })
map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ctions' })
map('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = '[C]ode [R]ename file' })
map('n', '<leader>cl', function() Snacks.picker.lsp_config() end, { desc = '[C]ode [L]SP info' })

-- use LSP folds when the server supports them, also when the buffer is later shown in another window
local function use_lsp_folds(buf)
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
end
local lsp_folds_group = vim.api.nvim_create_augroup('UserLspFolds', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_folds_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client or not client:supports_method('textDocument/foldingRange', event.buf) then
            return
        end
        vim.b[event.buf].user_lsp_folds = true
        use_lsp_folds(event.buf)
    end,
})
vim.api.nvim_create_autocmd('BufWinEnter', {
    group = lsp_folds_group,
    callback = function(event)
        if vim.b[event.buf].user_lsp_folds then
            use_lsp_folds(event.buf)
        end
    end,
})

map('n', '<leader>cm', '<cmd>Mason<cr>', { desc = '[C]ode [M]ason' })
map({ 'n', 'x' }, '<leader>cf', function()
    require('conform').format({ lsp_format = 'fallback' })
end, { desc = '[C]ode [F]ormat' })

-- format on save is on by default, this toggles it for all buffers
Snacks.toggle({
    name = 'Format on save',
    get = function() return not vim.g.disable_autoformat end,
    set = function(state) vim.g.disable_autoformat = not state end,
}):map('<leader>uf')

-- plugins are loaded after startup, servers enabled by mason-lspconfig attach to already open buffers
MiniMisc.safely('later', function()
    vim.pack.add({
        -- LSP servers configuration
        'https://github.com/neovim/nvim-lspconfig',
        'https://github.com/mfussenegger/nvim-jdtls', -- used by after/lsp/jdtls.lua
        'https://github.com/mfussenegger/nvim-dap',   -- nvim-jdtls registers the java debug adapter (rest of the debug setup: 60_debug.lua)
        -- LSP servers installation
        'https://github.com/mason-org/mason.nvim',
        -- automatic enabling of installed LSP servers
        'https://github.com/mason-org/mason-lspconfig.nvim',
        -- all Mason packages installation (LSP servers, formatters, debug adapters, test runners, ...)
        'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
        -- formatting (formatters by filetype, LSP formatting as fallback)
        'https://github.com/stevearc/conform.nvim',
        -- Lua LSP configuration for the nvim config
        'https://github.com/folke/lazydev.nvim',
    })

    --
    -- Mason
    --

    require('mason').setup()
    -- packages are installed by mason-tool-installer, mason-lspconfig only enables installed servers
    require('mason-lspconfig').setup()

    -- condition that is true when all given executables are in the PATH
    local function has(...)
        local executables = { ... }
        return function()
            for _, executable in ipairs(executables) do
                if vim.fn.executable(executable) ~= 1 then
                    return false
                end
            end
            return true
        end
    end

    -- LSP servers use lspconfig names, everything else uses Mason package names
    require('mason-tool-installer').setup({
        ensure_installed = {
            -- LSP servers
            { 'jdtls',   condition = has('java', 'python3') },            -- java (python launcher script)
            'lua_ls',                                                     -- lua (always needed for nvim config)
            { 'pyright', condition = has('python3', 'node', 'npm') },     -- python (npm package)
            { 'ruff',    condition = has('python3') },                    -- python linting and formatting
            { 'yamlls',  condition = has('node', 'npm') },                -- yaml (npm package)
            'lemminx',                                                    -- xml (standalone binary)
            { 'vtsls',                  condition = has('node', 'npm') }, -- type script (npm package)
            { 'docker_language_server', condition = has('docker') },      -- docker
            { 'gopls',                  condition = has('go') },          -- go
            'harper_ls',                                                  -- grammar checker
            { 'copilot',                condition = has('node', 'npm') }, -- AI suggestions in blink.cmp via blink-copilot (npm package)

            -- Formatters (see conform)
            { 'prettier',           condition = has('node', 'npm') },

            -- Java debug and test
            { 'java-debug-adapter', condition = has('java') },
            { 'java-test',          condition = has('java') },
        },
    })
    -- its install check runs on VimEnter, which has already fired when this is loaded
    require('mason-tool-installer').run_on_start()

    --
    -- Formatting
    --

    local prettier = { 'prettier' }

    require('conform').setup({
        formatters_by_ft = {
            javascript = prettier,
            javascriptreact = prettier,
            typescript = prettier,
            typescriptreact = prettier,
            css = prettier,
            scss = prettier,
            html = prettier,
            json = prettier,
            jsonc = prettier,
            yaml = prettier,
            markdown = prettier,
        },
        format_on_save = function()
            if vim.g.disable_autoformat then
                return
            end
            return { timeout_ms = 3000, lsp_format = 'fallback' }
        end,
    })

    --
    -- Lua
    --

    require('lazydev').setup({
        library = {
            -- load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            -- load snacks types when the `Snacks` global is used
            { path = 'snacks.nvim', words = { 'Snacks' } },
            -- load mini types when a `Mini*` global (MiniMisc, MiniIcons) is used
            { path = 'mini.nvim', words = { 'Mini%u' } },
        },
    })
end)
