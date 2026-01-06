return {
	-- LSP servers configration
	{
		"neovim/nvim-lspconfig",
	},
	-- LSP servers installation
	{
		"mason-org/mason.nvim",
		config = true,
	},
	-- Connection between lspconfig and mason
	-- LSP servers automatic installation and enabling
	{
		"mason-org/mason-lspconfig.nvim",
		opts = require("denische.plugins.lsp.mason-lspconfig.options"),
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
            "mfussenegger/nvim-jdtls"
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("denische.plugins.lsp.treesitter.config")
		end,
	},
	-- Collection of code snippets
	{
		"rafamadriz/friendly-snippets",
	},
	-- Integration CLI tools to the LSP
	{
		"nvimtools/none-ls.nvim",
		config = function()
			require("denische.plugins.lsp.nonels.config")
		end,
	},
	-- LSP issues navigation
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = require("denische.plugins.lsp.trouble.keymaps"),
	},
	-- Additional LSP actions (like extract variable, etc.)
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = require("denische.plugins.lsp.refactoring.keymaps"),
		lazy = false,
		opts = {},
	},
	-- LSP icons for autocomplete
	{
		"onsails/lspkind.nvim",
		lazy = true,
		opts = require("denische.plugins.lsp.lspkind.options"),
		config = function()
			require("denische.plugins.lsp.lspkind.config")
		end,
	},
	-- Lua LSP configration
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = require("denische.plugins.lsp.lazydev.options"),
	},
}
