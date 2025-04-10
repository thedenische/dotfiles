-- setup_handlers for mason-lspconfig
return {
    function(server_name) -- default handler (optional)
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('lspconfig')[server_name].setup({
            capabilities = capabilities,
        })
    end,
    ['jdtls'] = function ()
       -- skip configuration because of nvim-jdtls plugin
    end,
    ['lua_ls'] = function()
        require('denische.plugins.lsp.servers.luals')
    end,
    ['yamlls'] = function ()
        require('denische.plugins.lsp.servers.yamlls')
    end
}
