vim.api.nvim_set_hl(0, 'BlinkCmpKindCopilot', { fg = '#6CC644' })

require('lspkind').setup({
    symbol_map = {
        Copilot = '',
    },
})
