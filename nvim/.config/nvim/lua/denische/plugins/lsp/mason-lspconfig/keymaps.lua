local builtin = require('telescope.builtin')

local onAttachKeys = {
    { 'gd',         builtin.lsp_definitions,               '[G]o to [D]efinition' },
    { 'gD',         vim.lsp.buf.declaration,               '[G]o to [D]eclaration' },
    { 'gr',         builtin.lsp_references,                '[G]o to [R]eferences' },
    { 'gi',         builtin.lsp_implementations,           '[G]o to [I]mplementation' },
    { 'gt',         builtin.lsp_type_definitions,          '[G]o to [T]ype definition' },
    { '<leader>ls', builtin.lsp_document_symbols,          '[L]sp [S]tructure' },
    { '<leader>fc', builtin.lsp_dynamic_workspace_symbols, '[F]ind [C]lass' },
    { '<leader>lr', vim.lsp.buf.rename,                    '[L]sp [R]ename' },
    { '<leader>la', vim.lsp.buf.code_action,               '[L]sp code [A]ctions' },
    { '<leader>lf', vim.lsp.buf.format,                    '[L]sp [F]ormat file' },
    { 'K',          vim.lsp.buf.hover,                     'Hover Documentation' },
}

-- scrolling docs in hover/signature windows
vim.keymap.set({ "n", "i" }, "<C-f>", function() return vim.lsp.util.scroll(1) end, { silent = true, expr = true })
vim.keymap.set({ "n", "i" }, "<C-b>", function() return vim.lsp.util.scroll(-1) end, { silent = true, expr = true })

return onAttachKeys
