MiniMisc.safely('later', function()
    vim.pack.add({
        -- rework nvim UI (notifications are shown by snacks.notifier)
        'https://github.com/MunifTanjim/nui.nvim',
        'https://github.com/folke/noice.nvim',
        -- LSP based breadcrumbs (for status line)
        'https://github.com/SmiteshP/nvim-navic',
        -- status line
        'https://github.com/nvim-lualine/lualine.nvim',
        -- shortcuts help
        'https://github.com/folke/which-key.nvim',
        -- markdown rendering (also in the codecompanion chat)
        'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    })

    local map = vim.keymap.set

    -- copilot icon colored by its status (set in after/lsp/copilot.lua), hidden when not attached
    local function copilot_status()
        local client = vim.lsp.get_clients({ name = 'copilot', bufnr = 0 })[1]
        return client and (Config.copilot_status or {})[client.id]
    end
    local copilot_colors = { ok = 'Special', pending = 'DiagnosticWarn', error = 'DiagnosticError' }

    --
    -- Noice
    --

    require('noice').setup({
        lsp = {
            -- override markdown rendering so that other plugins use **Treesitter**
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
            },
        },
        presets = {
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
        },
    })

    -- scroll LSP hover / signature docs, falls back to the default key when no docs are open
    map({ 'n', 'i', 's' }, '<C-f>', function()
        if not require('noice.lsp').scroll(4) then return '<C-f>' end
    end, { desc = 'Scroll docs down', silent = true, expr = true })
    map({ 'n', 'i', 's' }, '<C-b>', function()
        if not require('noice.lsp').scroll(-4) then return '<C-b>' end
    end, { desc = 'Scroll docs up', silent = true, expr = true })

    --
    -- Status line
    --

    -- auto attaches to the first LSP client with document symbols
    require('nvim-navic').setup({
        highlight = true,
        lsp = { auto_attach = true },
    })

    require('lualine').setup({
        options = {
            globalstatus = vim.o.laststatus == 3, -- otherwise lualine resets laststatus to 2
            disabled_filetypes = { statusline = { 'snacks_dashboard' } },
        },
        sections = {
            lualine_b = {
                'branch'
            },
            lualine_c = {
                {
                    'filetype',
                    icon_only = true,
                    separator = '',
                    padding = { left = 1, right = 0 }
                },
                {
                    'filename',
                    path = 1
                },
                {
                    'navic',
                    color_correction = 'dynamic',
                }
            },
            lualine_x = {
                -- macro recording (@q), captured by noice
                {
                    require('noice').api.status.mode.get,
                    cond = require('noice').api.status.mode.has,
                },
                {
                    'diff',
                    -- counts from gitsigns instead of running git
                    source = function()
                        local gitsigns = vim.b.gitsigns_status_dict
                        if gitsigns then
                            return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
                        end
                    end,
                },
                'diagnostics',
                {
                    function() return '' end,
                    cond = function() return copilot_status() ~= nil end,
                    color = function() return copilot_colors[copilot_status()] end,
                },
                'encoding',
            },
        },
    })

    --
    -- Which-key
    --

    local extras = require('which-key.extras')

    -- descriptions of mini.ai text objects (plugin/50_editor.lua), built-in ones are described by which-key
    local textobjects = { mode = { 'o', 'x' } }
    for key, desc in pairs({
        a = 'argument',
        q = 'quote `"\'',
        ['?'] = 'user prompt',
        f = 'function',
        c = 'class',
        o = 'block, conditional, loop',
        d = 'digits',
        e = 'camelCase / snake_case part',
        g = 'entire buffer',
        u = 'function call',
        U = 'function call without dot',
    }) do
        table.insert(textobjects, { 'a' .. key, desc = desc })
        table.insert(textobjects, { 'i' .. key, desc = desc })
    end

    require('which-key').setup({
        icons = {
            -- keymaps whose description has no word from which-key's built-in icon rules
            rules = {
                { pattern = '^grep', icon = ' ', color = 'green' },
                { pattern = '^command history', icon = ' ', color = 'yellow' },
                { pattern = '^explorer', icon = '󰙅 ', color = 'cyan' },
                { pattern = 'clipboard', icon = '󰅇 ', color = 'yellow' },
            },
        },
        spec = {
            textobjects,
            { '<leader>g', group = 'Git', icon = { cat = 'filetype', name = 'git' } },
            { '<leader>gm', group = 'Git Merge request' },
            { '<leader>gh', group = 'Git Hunk' },
            { '<leader>gt', group = 'Git Toggle' },
            { '<leader>s', group = 'Search', icon = { icon = ' ', color = 'blue' } },
            { '<leader>u', group = 'UI / settings' },
            { '<leader>a', group = 'AI', icon = { icon = ' ', color = 'purple' } },
            { '<leader>f', group = 'Find', icon = { icon = ' ', color = 'green' } },
            { '<leader>c', group = 'Code', mode = { 'n', 'x' }, icon = { icon = ' ', color = 'orange' } },
            { '<leader>cj', group = 'Code Java' },
            { '<leader>b', group = 'Buffer', expand = extras.expand.buf },
            { '<leader>w', group = 'Window', proxy = '<c-w>', expand = extras.expand.win },
            { '<leader>x', group = 'Lists (quickfix / location)' },
            { '<leader>q', group = 'Quit' },
            { '<leader>d', group = 'Debug', icon = { icon = '󰃤 ', color = 'red' } },
            { '<leader>t', group = 'Test', icon = { cat = 'filetype', name = 'neotest-summary' } },
        },
    })

    map('n', '<leader>?', function()
        require('which-key').show({ global = false })
    end, { desc = 'Buffer keymaps (which-key)' })

    --
    -- Markdown
    --

    require('render-markdown').setup({
        file_types = { 'markdown', 'codecompanion' },
    })
end)
