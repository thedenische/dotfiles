return {
    {
        'williamboman/mason.nvim',
        config = true,
        lazy = true
    },
    -- {
    --     'WhoIsSethDaniel/mason-tool-installer',
    --     opts = {
    --         auto_update = true,
    --     }
    -- },
    -- {
    --     'williamboman/mason-lspconfig.nvim',
--    -     dependencies = {
    --         'williamboman/mason.nvim'
    --     },
    --     opts = {
    --         automatic_installation = true,
    --         handlers = require('denische.plugins.lsp.servers'),
    --     }
    -- },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('denische.plugins.lsp.config')
        end
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            require('denische.plugins.lsp.nonels-config')
        end
    },
    {
        'folke/trouble.nvim',
        opts = {},
        cmd = 'Trouble',
        keys = require('denische.plugins.lsp.trouble-keysmap'),
    },
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
    {
        'nvim-java/nvim-java',
        config = false,
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                opts = {
                    servers = {
                        -- Your JDTLS configuration goes here
                        jdtls = {
                            -- settings = {
                            --   java = {
                            --     configuration = {
                            --       runtimes = {
                            --         {
                            --           name = 'JavaSE-23',
                            --           path = '/usr/local/sdkman/candidates/java/23-tem',
                            --         },
                            --       },
                            --     },
                            --   },
                            -- },
                        },
                    },
                    setup = {
                        jdtls = function()
                            -- Your nvim-java configuration goes here
                            require('java').setup({
                                -- root_markers = {
                                --   'settings.gradle',
                                --   'settings.gradle.kts',
                                --   'pom.xml',
                                --   'build.gradle',
                                --   'mvnw',
                                --   'gradlew',
                                --   'build.gradle',
                                --   'build.gradle.kts',
                                -- },
                            })
                        end,
                    },
                },
            },
        },
    },
    -- {
    --     'mfussenegger/nvim-jdtls',
    --     ft = { 'java' },
    --     dependencies = {
    --         'mfussenegger/nvim-dap',
    --         'ray-x/lsp_signature.nvim',
    --     },
    --     config = function()
    --         require('denische.plugins.lsp.servers.jdtls')
    --     end
    -- }
}
