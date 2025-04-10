local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, buffer)
    client.server_capabilities.documentFormattingProvider = true
    -- client.resolved_capabilities.document_formatting = true
end

require('lspconfig').yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        yaml = {
            format = {
                enabled = true,
            }
        }
    }
})
