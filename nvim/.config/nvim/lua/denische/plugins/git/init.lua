return {
    -- editor git integration (changes, blame, etc)
    {
        'lewis6991/gitsigns.nvim',
        keys = require('denische.plugins.git.gitsigns-keymaps'),
        lazy = false,
        config = true,
    },
    -- lazy git
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        keys = require('denische.plugins.git.lazygit-keymaps'),
        dependencies = {
            -- optional for floating window border decoration
            "nvim-lua/plenary.nvim",
        },
    },
    -- gitlab integration
    {
        'harrisoncramer/gitlab.nvim',
        keys = require('denische.plugins.git.gitlab-keymaps'),
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'stevearc/dressing.nvim',      -- Recommended but not required. Better UI for pickers.
            'nvim-tree/nvim-web-devicons', -- Recommended but not required. Icons in discussion tree.
        },
        build = function()
            require('gitlab.server').build(true)
        end, -- Builds the Go binary
        config = true
    },
}
