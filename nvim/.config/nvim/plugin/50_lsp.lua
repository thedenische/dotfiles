local map = vim.keymap.set

--
-- LspAttach: keymaps, folds, breadcrumbs
--

-- buffer-local keymaps ({ key, func, desc, mode = 'n' by default, has = LSP method the server must support })
local lsp_keymaps = {
    { '<leader>cr', vim.lsp.buf.rename,                         '[C]ode [R]ename',     has = 'textDocument/rename' },
    { '<leader>ca', vim.lsp.buf.code_action,                    '[C]ode [A]ctions',    has = 'textDocument/codeAction', mode = { 'n', 'x' } },
    { '<leader>cR', function() Snacks.rename.rename_file() end, '[C]ode [R]ename file' },
    { '<leader>cl', function() Snacks.picker.lsp_config() end,  '[C]ode [L]SP info' },
}

local function set_keymaps(client, buf)
    for _, row in ipairs(lsp_keymaps) do
        -- skip keymaps the server can't handle (other clients on the buffer may still set them)
        if not row.has or client:supports_method(row.has, buf) then
            local key, func, desc = row[1], row[2], row[3]
            map(row.mode or 'n', key, func, { buffer = buf, desc = desc })
        end
    end
end

-- use LSP folds when the server supports them (in every window showing the buffer)
local function set_folds(client, buf)
    if not client:supports_method('textDocument/foldingRange', buf) then
        return
    end
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
end

-- attach navic for lsp based breadcrumbs (navic supports only one client per buffer)
local function set_navic(client, buf)
    if client:supports_method('textDocument/documentSymbol', buf) and not vim.b[buf].navic_client_id then
        require('nvim-navic').attach(client, buf)
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end
        set_keymaps(client, event.buf)
        set_folds(client, event.buf)
        set_navic(client, event.buf)
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

-- plugins are loaded after startup (the first screen is drawn first),
-- servers enabled by mason-lspconfig attach to already open buffers
vim.schedule(function()
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
            { 'jdtls',   condition = has('java') },                       -- java
            'lua_ls',                                                     -- lua (always needed for nvim config)
            { 'pyright', condition = has('python3', 'node', 'npm') },     -- python (npm package)
            { 'ruff',    condition = has('python3') },                    -- python linting and formatting
            { 'yamlls',  condition = has('node', 'npm') },                -- yaml (npm package)
            'lemminx',                                                    -- xml (standalone binary)
            { 'vtsls',                  condition = has('node', 'npm') }, -- type script (npm package)
            { 'docker_language_server', condition = has('docker') },      -- docker
            'harper_ls',                                                  -- grammar checker

            -- Formatters (see conform)
            { 'prettier',           condition = has('node', 'npm') },

            -- Java debug and test
            { 'java-debug-adapter', condition = has('java') },
            { 'java-test',          condition = has('java') },
        },
    })

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
            return { timeout_ms = 500, lsp_format = 'fallback' }
        end,
    })

    --
    -- Lua
    --

    require('lazydev').setup({
        library = {
            -- load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
    })
end)
