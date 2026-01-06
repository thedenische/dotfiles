return {
    -- mini
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('denische.plugins.utils.mini.config')
        end
    },
    -- snacks
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = require('denische.plugins.utils.snacks.options')
    },
    -- tmux panels transparent navigation
    {
        'christoomey/vim-tmux-navigator',
        cmd = {
            'TmuxNavigateLeft',
            'TmuxNavigateDown',
            'TmuxNavigateUp',
            'TmuxNavigateRight',
            'TmuxNavigatePrevious',
            'TmuxNavigatorProcessList',
        },
        keys = require('denische.plugins.utils.tmux.keymaps'),
    }
}
