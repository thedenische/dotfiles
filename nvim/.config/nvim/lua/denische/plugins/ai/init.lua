return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            -- suggestions are shown in the blink.cmp menu via blink-copilot,
            -- so inline ghost text is disabled to avoid duplicates
            suggestion = { enabled = false },
            panel = { enabled = false }
        },
    },
    {
        'olimorris/codecompanion.nvim',
        keys = require('denische.plugins.ai.codecompanion.keymaps'),
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
                    callback = 'mcphub.extensions.codecompanion',
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
            'echasnovski/mini.nvim', -- mini.diff shows inline AI edits
            {
                'MeanderingProgrammer/render-markdown.nvim',
                ft = { 'markdown', 'codecompanion' }
            },
        },
    },
    {
        'ravitemer/mcphub.nvim',
        cmd = 'MCPHub', -- also loaded by the codecompanion extension
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        build = 'bundled_build.lua', -- installs `mcp-hub` locally in the plugin dir (no global npm package)
        opts = {
            use_bundled_binary = true,
        },
    }
}
