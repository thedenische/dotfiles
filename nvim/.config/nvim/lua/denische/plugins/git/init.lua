return {
    -- editor git integration (changes, blame, etc)
    {
        'lewis6991/gitsigns.nvim',
        keys = require('denische.plugins.git.gitsigns.keymaps'),
        lazy = false,
        config = true,
    },
    -- gitlab integration
    {
        'harrisoncramer/gitlab.nvim',
        keys = require('denische.plugins.git.gitlab.keymaps'),
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-tree/nvim-web-devicons', -- Recommended but not required. Icons in discussion tree.
        },
        build = function()
            require('gitlab.server').build(true)
        end, -- Builds the Go binary
        config = true
    },
}
