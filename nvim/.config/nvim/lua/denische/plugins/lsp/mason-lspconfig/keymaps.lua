-- buffer-local keymaps, set on LspAttach
-- ({ key, func, desc, mode = 'n' by default, has = LSP method the server must support })
return {
    { '<leader>cr', vim.lsp.buf.rename,                          '[C]ode [R]ename',      has = 'textDocument/rename' },
    { '<leader>ca', vim.lsp.buf.code_action,                     '[C]ode [A]ctions',     has = 'textDocument/codeAction', mode = { 'n', 'x' } },
    { '<leader>cR', function() Snacks.rename.rename_file() end,  '[C]ode [R]ename file' },
    { '<leader>cl', function() Snacks.picker.lsp_config() end,   '[C]ode [L]SP info' },
}
