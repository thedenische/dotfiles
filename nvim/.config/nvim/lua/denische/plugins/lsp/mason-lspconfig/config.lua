local function set_keymaps(client, buf)
    for _, row in ipairs(require('denische.plugins.lsp.mason-lspconfig.keymaps')) do
        -- skip keymaps the server can't handle (other clients on the buffer may still set them)
        if not row.has or client:supports_method(row.has, buf) then
            local key, func, desc = row[1], row[2], row[3]
            vim.keymap.set(row.mode or 'n', key, func, { buffer = buf, desc = desc })
        end
    end
end

-- use LSP folds when the server supports them (in every window showing the buffer)
local function set_folds(client, buf)
    if not client:supports_method('textDocument/foldingRange', buf) then
        return
    end
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
end

-- attach navic for lsp based breadcrumbs (navic supports only one client per buffer)
local function set_navic(client, buf)
    if client:supports_method('textDocument/documentSymbol', buf) and not vim.b[buf].navic_client_id then
        require('nvim-navic').attach(client, buf)
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end
        set_keymaps(client, event.buf)
        set_folds(client, event.buf)
        set_navic(client, event.buf)
    end,
})

-- packages are installed by mason-tool-installer, mason-lspconfig only enables installed servers
require('mason-lspconfig').setup()
