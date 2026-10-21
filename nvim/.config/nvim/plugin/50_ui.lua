-- loaded after startup (the first screen is drawn first)
vim.schedule(function()
    vim.pack.add({
        -- rework nvim UI (notifications are shown by snacks.notifier)
        'https://github.com/MunifTanjim/nui.nvim',
        'https://github.com/folke/noice.nvim',
        -- LSP based breadcrumbs (for status line)
        'https://github.com/SmiteshP/nvim-navic',
        -- status line
        'https://github.com/nvim-tree/nvim-web-devicons',
        'https://github.com/AndreM222/copilot-lualine',
        'https://github.com/yavorski/lualine-macro-recording.nvim',
        'https://github.com/nvim-lualine/lualine.nvim',
        -- shortcuts help
        'https://github.com/folke/which-key.nvim',
        -- markdown rendering (also in the codecompanion chat)
        'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    })

    local map = vim.keymap.set

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

    require('nvim-navic').setup({
        highlight = true,
    })

    require('lualine').setup({
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
                'macro_recording',
                'diff',
                'diagnostics',
                'copilot',
                'encoding',
            },
        },
    })

    --
    -- Which-key
    --

    local extras = require('which-key.extras')

    require('which-key').setup({
        spec = {
            { '<leader>g', group = '[G]it', icon = { cat = 'filetype', name = 'git' } },
            { '<leader>gm', group = '[G]it [M]erge request' },
            { '<leader>gh', group = '[G]it [H]unk' },
            { '<leader>gt', group = '[G]it [T]oggle' },
            { '<leader>s', group = '[S]earch', icon = { icon = ' ', color = 'blue' } },
            { '<leader>u', group = '[U]I / settings' },
            { '<leader>a', group = '[A]I', icon = { icon = ' ', color = 'purple' } },
            { '<leader>f', group = '[F]ind', icon = { icon = ' ', color = 'green' } },
            { '<leader>c', group = '[C]ode', mode = { 'n', 'x' }, icon = { icon = ' ', color = 'orange' } },
            { '<leader>cj', group = '[C]ode [J]ava' },
            { '<leader>b', group = '[B]uffer', expand = extras.expand.buf },
            { '<leader>w', group = '[W]indow', proxy = '<c-w>', expand = extras.expand.win },
            { '<leader>x', group = 'Lists (quickfix / location)' },
            { '<leader>q', group = '[Q]uit' },
            { '<leader>d', group = '[D]ebug', icon = { icon = '󰃤 ', color = 'red' } },
            { '<leader>t', group = '[T]est', icon = { cat = 'filetype', name = 'neotest-summary' } },
        },
    })

    map('n', '<leader>?', function()
        require('which-key').show({ global = true })
    end, { desc = 'Show all keymaps (which-key)' })

    --
    -- Markdown
    --

    require('render-markdown').setup({
        file_types = { 'markdown', 'codecompanion' },
    })
end)
