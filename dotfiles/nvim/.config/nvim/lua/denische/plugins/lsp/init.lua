return {
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer',
        config = function()
            require('mason-tool-installer').setup({
                auto_update = true,
            })
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim'
        },
        config = function()
            require('mason-lspconfig').setup({
                automatic_installation = true,
                handlers = require('denische.plugins.lsp.servers'),
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('denische.plugins.lsp.config')
        end
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            require('denische.plugins.lsp.nonels-config')
        end
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = { 'java' },
        dependencies = {
            'mfussenegger/nvim-dap',
            'ray-x/lsp_signature.nvim',
        },
        config = function()
            require('denische.plugins.lsp.servers.jdtls')
        end
    }
}
