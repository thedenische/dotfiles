return {
    -- LSP servers configration
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        opts = require('denische.plugins.lsp.lspconfig.options'),
        config = require('denische.plugins.lsp.lspconfig.config')
    },
    -- LSP servers installation
    {
        'mason-org/mason.nvim',
        opts = {}
    },
    -- Connection between lspconfig and mason
    -- LSP servers automatic installation
    {
        'mason-org/mason-lspconfig.nvim',
        opts = require('denische.plugins.lsp.mason-lspconfig.options'),
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('denische.plugins.lsp.treesitter.config')
        end
    },
    -- Collection of code snippets
    {
        'rafamadriz/friendly-snippets'
    },
    -- Integration CLI tools to the LSP
    {
        'nvimtools/none-ls.nvim',
        config = function()
            require('denische.plugins.lsp.nonels.config')
        end
    },
    -- LSP issues navigation
    {
        'folke/trouble.nvim',
        opts = {},
        cmd = 'Trouble',
        keys = require('denische.plugins.lsp.trouble.keymaps'),
    },
    -- Additional LSP actions (like extract variable, etc.)
    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        keys = require('denische.plugins.lsp.refactoring.keymaps'),
        lazy = false,
        opts = {},
    },
    -- LSP icons for autocomplete
    {
        'onsails/lspkind.nvim',
        lazy = true,
        opts = require('denische.plugins.lsp.lspkind.options'),
        config = function()
            require('denische.plugins.lsp.lspkind.config')
        end
    },
    -- Lua LSP configration
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = require('denische.plugins.lsp.lazydev.options'),
    },
    -- java LSP configuration
    -- {
    --     'nvim-java/nvim-java',
    --     config = false,
    --     dependencies = {
    --         {
    --             'neovim/nvim-lspconfig',
    --             opts = {
    --                 servers = {
    --                     -- Your JDTLS configuration goes here
    --                     jdtls = {
    --                         -- settings = {
    --                         --   java = {
    --                         --     configuration = {
    --                         --       runtimes = {
    --                         --         {
    --                         --           name = 'JavaSE-23',
    --                         --           path = '/usr/local/sdkman/candidates/java/23-tem',
    --                         --         },
    --                         --       },
    --                         --     },
    --                         --   },
    --                         -- },
    --                     },
    --                 },
    --                 setup = {
    --                     jdtls = function()
    --                         -- Your nvim-java configuration goes here
    --                         require('java').setup({
    --                             -- root_markers = {
    --                             --   'settings.gradle',
    --                             --   'settings.gradle.kts',
    --                             --   'pom.xml',
    --                             --   'build.gradle',
    --                             --   'mvnw',
    --                             --   'gradlew',
    --                             --   'build.gradle',
    --                             --   'build.gradle.kts',
    --                             -- },
    --                         })
    --                     end,
    --                 },
    --             },
    --         },
    --     },
    -- },
}
