return {
    -- LSP servers configration
    {
        "neovim/nvim-lspconfig",
    },
    -- LSP servers installation
    {
        "mason-org/mason.nvim",
        config = true,
        keys = {
            { "<leader>cm", "<cmd>Mason<cr>", desc = "[C]ode [M]ason" },
        },
    },
    -- Connection between lspconfig and mason
    -- Automatic enabling of installed LSP servers
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("denische.plugins.lsp.mason-lspconfig.config")
        end,
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-jdtls"
        },
    },
    -- All Mason packages installation (LSP servers, debug adapters, test runners, ...)
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = require("denische.plugins.lsp.mason-tool-installer.options"),
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim", -- maps lspconfig names to Mason packages
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("denische.plugins.lsp.treesitter.config")
        end,
    },
    -- Integration CLI tools to the LSP
    {
        "nvimtools/none-ls.nvim",
        config = function()
            require("denische.plugins.lsp.nonels.config")
        end,
    },
    -- Make LSP aware of file operations
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    -- Lua LSP configration
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = require("denische.plugins.lsp.lazydev.options"),
    },
}
