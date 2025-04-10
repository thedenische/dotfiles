vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        local builtin = require('telescope.builtin')

        map('gd', builtin.lsp_definitions, '[G]o to [D]efinition')
        map('gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')
        map('gr', builtin.lsp_references, '[G]o to references')
        map('gi', builtin.lsp_implementations, '[G]o to [I]mplementation')
        map('gt', builtin.lsp_type_definitions, '[G]o to [T]ype definition')
        map('<leader>ls', builtin.lsp_document_symbols, '[F]ind in [S]tructure')
        map('<leader>fc', builtin.lsp_dynamic_workspace_symbols, '[F]ind [C]lass')
        map('<leader>lr', vim.lsp.buf.rename, '[L]sp [R]ename')
        map('<leader>la', vim.lsp.buf.code_action, '[L]sp code [A]ctions')
        map('<leader>lf', vim.lsp.buf.format, '[L]sp [F]ormat file')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

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
    end
})
