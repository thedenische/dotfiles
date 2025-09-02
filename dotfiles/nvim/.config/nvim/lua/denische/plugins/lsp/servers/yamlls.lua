local on_attach = function(client, buffer)
    client.server_capabilities.documentFormattingProvider = true
    -- client.resolved_capabilities.document_formatting = true
end

return {
    on_attach = on_attach,
    settings = {
        yaml = {
            format = {
                enabled = true,
            }
        }
    }
}
