require('denische.plugins.lsp.lspconfig.attach')

return function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
    end
end
