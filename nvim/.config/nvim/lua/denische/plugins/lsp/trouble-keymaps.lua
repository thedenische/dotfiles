return {
    {
        '<leader>ldx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
    },
    {
        '<leader>ldX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
    },
    {
        '<leader>ldcs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
    },
    {
        '<leader>ldcl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
        '<leader>ldL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
    },
    {
        '<leader>ldQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
    }
}
