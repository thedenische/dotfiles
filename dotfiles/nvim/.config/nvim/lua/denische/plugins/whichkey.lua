return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        spec = {
            { '<leader>g', group = 'git' },
            { '<leader>f', group = 'find' },
            { '<leader>l', group = 'lsp' },
            { '<leader>d', group = 'debug' },
            { '<leader>dt', group = 'debug test' },
        }
    },
    keys = {
        {
            '<leader>?',
            function()
                require('which-key').show({ global = true })
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}
