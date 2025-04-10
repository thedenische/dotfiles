return {
    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        event = 'InsertEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'rafamadriz/friendly-snippets',
            },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-cmdline' },
        },
        config = function()
            require('denische.plugins.cmp.config')
        end
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets'
        },
    }
}
