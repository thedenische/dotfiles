local function lspAttach(event)
    -- load keypams on attach
    local keys = require('denische.plugins.lsp.mason-lspconfig.keymaps')

    for i, row in ipairs(keys) do
        local key, func, desc = row[1], row[2], row[3]
        vim.keymap.set('n', key, func, { buffer = event.buf, desc = desc })
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- highligth the document on cursor hover
    if client and client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
        })
    end

    -- attach navic for lsp based breadcrumbs
    local navic = require('nvim-navic')

    if client and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, event.buf)
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = lspAttach
})
