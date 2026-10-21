return {
    -- syntax highlighting, folds (parsers are listed in treesitter/config.lua)
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('denische.plugins.editor.treesitter.config')
        end,
    },
    -- autocomplete
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'fang2hou/blink-copilot',
        },
        -- use a release tag to download pre-built binaries
        version = '1.*',
        event = 'InsertEnter',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = require('denische.plugins.editor.cmp.options'),
        opts_extend = { 'sources.default' },
        config = require('denische.plugins.editor.cmp.config'),
    },
}
