return {
    {
        '<leader>ldw',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = '[L]sp [D]iagnostics [W]orkspae',
    },
    {
        '<leader>ldb',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = '[L]sp [D]iagnostics [B]uffer',
    },
    {
        '<leader>lS',
        '<cmd>Trouble symbols toggle focus=true<cr>',
        desc = '[L]sp [S]tructure',
    },
    -- todo: check how it works
    {
        '<leader>ll',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = '[L]sp Definitions / references / ... (Trouble)',
    },
    -- todo: check how it works
    {
        '<leader>lL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = '[L]sp Location List (Trouble)',
    },
    -- todo: check how it works
    {
        '<leader>lq',
        '<cmd>Trouble qflist toggle<cr>',
        desc = '[L]sp Quickfix List (Trouble)',
    }
}
