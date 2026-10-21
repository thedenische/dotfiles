vim.pack.add({ 'https://github.com/zbirenbaum/copilot.lua' })

-- copilot starts its language server, so set it up on first insert
vim.api.nvim_create_autocmd('InsertEnter', {
    group = vim.api.nvim_create_augroup('UserCopilot', { clear = true }),
    once = true,
    callback = function()
        require('copilot').setup({
            -- suggestions are shown in the blink.cmp menu via blink-copilot,
            -- so inline ghost text is disabled to avoid duplicates
            suggestion = { enabled = false },
            panel = { enabled = false },
        })
    end,
})

--
-- CodeCompanion + MCP Hub (slow to load and mcphub starts the mcp-hub server,
-- so they are set up on first use of the keymaps or commands)
--

local loaded = false
local function load()
    if loaded then
        return
    end
    loaded = true
    vim.pack.add({
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/echasnovski/mini.nvim', -- mini.diff shows inline AI edits
        'https://github.com/olimorris/codecompanion.nvim',
        'https://github.com/ravitemer/mcphub.nvim',
    })

    require('mcphub').setup({
        use_bundled_binary = true, -- `mcp-hub` is installed in the plugin dir (see plugin/00_pack.lua)
    })

    require('codecompanion').setup({
        interactions = {
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
                    make_tools = true,                    -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
                    show_server_tools_in_chat = true,     -- Show individual tools in chat completion (when make_tools=true)
                    add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
                    show_result_in_chat = true,           -- Show tool results directly in chat buffer
                    format_tool = nil,                    -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
                    -- MCP Resources
                    make_vars = false,                    -- Convert MCP resources to #variables for prompts
                    -- MCP Prompts
                    make_slash_commands = true,           -- Add MCP prompts as /slash commands
                }
            }
        },
    })
end

vim.api.nvim_create_autocmd('CmdUndefined', {
    group = vim.api.nvim_create_augroup('UserAiLoad', { clear = true }),
    pattern = { 'CodeCompanion*', 'MCPHub' },
    callback = load,
})

local function map(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, function()
        load()
        rhs()
    end, opts)
end

map({ 'n', 'x' }, '<leader>ac', function() vim.cmd('CodeCompanionChat Toggle') end, { desc = '[A]I [C]hat toggle' })
map({ 'n', 'x' }, '<leader>aa', function() vim.cmd('CodeCompanionActions') end, { desc = '[A]I [A]ctions' })
map({ 'n', 'x' }, '<leader>ai', function() vim.api.nvim_feedkeys(':CodeCompanion ', 'n', false) end,
    { desc = '[A]I [I]nline prompt' })
map('x', '<leader>as', function() vim.cmd('CodeCompanionChat Add') end, { desc = '[A]I [S]end selection to chat' })
