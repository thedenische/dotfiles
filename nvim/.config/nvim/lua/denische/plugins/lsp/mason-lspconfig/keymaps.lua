-- local builtin = require('telescope.builtin')

local onAttachKeys = {
    { '<leader>lr', vim.lsp.buf.rename,      '[L]sp [R]ename' },
    { '<leader>la', vim.lsp.buf.code_action, '[L]sp code [A]ctions' },
    { '<leader>lf', vim.lsp.buf.format,      '[L]sp [F]ormat file' },
    { 'K',          vim.lsp.buf.hover,       'Hover Documentation' },
}

-- scrolling docs in hover/signature windows
vim.keymap.set({ "n", "i" }, "<C-f>", function() return vim.lsp.util.scroll(1) end, { silent = true, expr = true })
vim.keymap.set({ "n", "i" }, "<C-b>", function() return vim.lsp.util.scroll(-1) end, { silent = true, expr = true })

return onAttachKeys
