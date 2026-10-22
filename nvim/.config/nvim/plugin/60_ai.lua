--
-- CodeCompanion (slow to load, so it is set up on first use of its commands, the keymaps below run them)
-- MCP servers can be added natively via `mcp = { servers = { ... } }`
--

Config.on_demand(function()
    vim.pack.add({
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/olimorris/codecompanion.nvim',
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
    })
end, { 'CodeCompanion*' })

local map = vim.keymap.set

map({ 'n', 'x' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'AI Chat toggle' })
map({ 'n', 'x' }, '<leader>aa', '<cmd>CodeCompanionActions<cr>', { desc = 'AI Actions' })
map({ 'n', 'x' }, '<leader>ai', ':CodeCompanion ', { desc = 'AI Inline prompt' })
map('x', '<leader>as', '<cmd>CodeCompanionChat Add<cr>', { desc = 'AI Send selection to chat' })
