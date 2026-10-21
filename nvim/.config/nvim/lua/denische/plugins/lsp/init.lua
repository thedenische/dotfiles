return {
    -- LSP servers configuration
    {
        'neovim/nvim-lspconfig',
    },
    -- LSP servers installation
    {
        'mason-org/mason.nvim',
        config = true,
        keys = {
            { '<leader>cm', '<cmd>Mason<cr>', desc = '[C]ode [M]ason' },
        },
    },
    -- Connection between lspconfig and mason
    -- Automatic enabling of installed LSP servers
    {
        'mason-org/mason-lspconfig.nvim',
        config = function()
            require('denische.plugins.lsp.mason-lspconfig.config')
        end,
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-jdtls'
        },
    },
    -- All Mason packages installation (LSP servers, formatters, debug adapters, test runners, ...)
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = require('denische.plugins.lsp.mason-tool-installer.options'),
        dependencies = {
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim', -- maps lspconfig names to Mason packages
        },
    },
    -- Formatting (formatters by filetype, LSP formatting as fallback)
    {
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        cmd = 'ConformInfo',
        keys = {
            { '<leader>cf', function() require('conform').format({ lsp_format = 'fallback' }) end, desc = '[C]ode [F]ormat', mode = { 'n', 'x' } },
        },
        opts = require('denische.plugins.lsp.conform.options'),
    },
    -- Lua LSP configuration
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = require('denische.plugins.lsp.lazydev.options'),
    },
}
