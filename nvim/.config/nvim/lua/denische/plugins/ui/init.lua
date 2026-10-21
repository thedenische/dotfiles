return {
    -- Rework nvim UI (notifications are shown by snacks.notifier)
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = require('denische.plugins.ui.noice.options'),
        keys = require('denische.plugins.ui.noice.keymaps'),
        dependencies = {
            'MunifTanjim/nui.nvim',
        }
    },
    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'AndreM222/copilot-lualine',
            'SmiteshP/nvim-navic',
            'yavorski/lualine-macro-recording.nvim'
        },
        opts = require('denische.plugins.ui.lualine.options')
    },
    -- LSP based breadcrumbs (for status line)
    {
        'SmiteshP/nvim-navic',
        lazy = true,
        opts = {
            highlight = true,
        },
    },
    -- Shortcuts help
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = require('denische.plugins.ui.which-key.options'),
        keys = require('denische.plugins.ui.which-key.keymaps'),
    }
}
