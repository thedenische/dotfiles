return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        spec = {
            { '<leader>g',  group = '[G]it' },
            { '<leader>gm', group = '[G]it [M]erge request' },
            { '<leader>f',  group = '[F]ind' },
            { '<leader>l',  group = '[L]sp' },
            { '<leader>ld', group = '[L]sp [D]iagnostic' },
            { '<leader>d',  group = '[D]ebug' },
            { '<leader>dt', group = '[D]ebug [T]est' },
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
