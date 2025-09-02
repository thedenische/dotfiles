return {
    -- LSP servers configration
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        opts = require('denische.plugins.lsp.options'),
        config = require('denische.plugins.lsp.config')
    },
    -- LSP servers installation
    {
        'mason-org/mason.nvim',
        opts = {}
    },
    -- LSP servers automatic installation and enabling
    {
        'mason-org/mason-lspconfig.nvim',
        opts = require('denische.plugins.lsp.mason-lspconfig-options'),
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
    },
    -- integration CLI tools to the LSP
    {
        'nvimtools/none-ls.nvim',
        config = function()
            require('denische.plugins.lsp.nonels-config')
        end
    },
    -- LSP issues navigation
    {
        'folke/trouble.nvim',
        opts = {},
        cmd = 'Trouble',
        keys = require('denische.plugins.lsp.trouble-keymaps'),
    },
    {
        'onsails/lspkind.nvim',
        lazy = true,
        opts = {
            symbol_map = {
                Copilot = "",
            },
        },
        config = function()
            vim.api.nvim_set_hl(0, "BlinkCmpKindCopilot", { fg = "#6CC644" })
            require('lspkind').setup({
                symbol_map = {
                    Copilot = "",
                },
            })
        end
    },
    -- lua LSP configration
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
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
