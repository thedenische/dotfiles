return {
    -- Rework nvim UI
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = require('denische.plugins.ui.noice.options'),
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'rcarriga/nvim-notify',
        }
    },
    -- Status line
    {
        'nvim-lualine/lualine.nvim',
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
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        lazy = true,
        opts = {
            highlight = true,
        },
    },
    -- Shortcats help
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = require('denische.plugins.ui.whichkeys.options'),
        keys = require('denische.plugins.ui.whichkeys.keymaps'),
    }
}
