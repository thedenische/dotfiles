return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            -- settings for blink.cmp integration
            -- see: https://github.com/giuxtaposition/blink-cmp-copilot?tab=readme-ov-file#install
            suggestion = { enabled = true },
            panel = { enabled = false }
        },
    },
    {
        'olimorris/codecompanion.nvim',
        opts = {
            strategies = {
                chat = {
                    adapter = {
                        name = 'copilot',
                        model = 'gpt-4.1'
                    },
                }
            },
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        -- MCP Tools
                        make_tools = true,                -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
                        show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
                        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
                        show_result_in_chat = true,       -- Show tool results directly in chat buffer
                        format_tool = nil,                -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
                        -- MCP Resources
                        make_vars = false,                 -- Convert MCP resources to #variables for prompts
                        -- MCP Prompts
                        make_slash_commands = true,       -- Add MCP prompts as /slash commands
                    }
                }
            },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.diff',
            {
                'MeanderingProgrammer/render-markdown.nvim',
                ft = { 'markdown', 'codecompanion' }
            },
        },
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
        config = function()
            require("mcphub").setup()
        end
    }
}
