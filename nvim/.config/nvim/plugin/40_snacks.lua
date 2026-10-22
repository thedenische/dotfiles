vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
    -- disables LSP, treesitter, etc. in huge files
    bigfile = {},
    dashboard = {
        -- default sections without 'startup' (it needs lazy.nvim)
        sections = {
            { section = 'header' },
            { section = 'keys',  gap = 1, padding = 1 },
        },
    },
    explorer = {},
    input = {},
    notifier = {},
    picker = {
        sources = {
            files = {
                hidden = true,
            },
            grep = {
                hidden = true,
            },
            explorer = {
                follow_file = true,
                hidden = true,
                ignored = true,
            },
        },
    },
    statuscolumn = {},
    words = {},
})

local map = vim.keymap.set

-- Top Pickers & Explorer
map('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = 'Smart find files' })
map('n', '<leader>,', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
map('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
map('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command history' })
map('n', '<leader>n', function() Snacks.picker.notifications() end, { desc = 'Notification history' })
map('n', '<leader>e', function() Snacks.explorer() end, { desc = 'Explorer' })
-- find
map('n', '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end,
    { desc = 'Find Config file' })
map('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find Files' })
map('n', '<leader>fg', function() Snacks.picker.git_files() end, { desc = 'Find Git files' })
map('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = 'Find Projects' })
map('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Find Recent files' })
-- git
map('n', '<leader>gg', function() Snacks.lazygit({ cwd = Snacks.git.get_root() }) end, { desc = 'Git lazygit' })
map('n', '<leader>gG', function() Snacks.lazygit() end, { desc = 'Git lazygit (cwd)' })
map('n', '<leader>gb', function() Snacks.picker.git_log_line() end, { desc = 'Git Blame line' })
map('n', '<leader>gc', function() Snacks.picker.git_branches() end, { desc = 'Git Checkout branch' })
map('n', '<leader>gl', function() Snacks.picker.git_log({ cwd = Snacks.git.get_root() }) end, { desc = 'Git Log' })
map('n', '<leader>gL', function() Snacks.picker.git_log() end, { desc = 'Git Log (cwd)' })
map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
map('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
map('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (hunks)' })
map('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git log File' })
map({ 'n', 'x' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse (open)' })
map({ 'n', 'x' }, '<leader>gY', function()
    Snacks.gitbrowse({ open = function(url) vim.fn.setreg('+', url) end, notify = false })
end, { desc = 'Git browse copy URL' })
-- grep
map('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Search Buffer lines' })
map('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Search open Buffers (grep)' })
map({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Search Word or selection' })
-- search
map('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Search registers' })
map('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search history' })
map('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Search Autocmds' })
map('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Search Commands' })
map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Search Help pages' })
map('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Search Highlights' })
map('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Search Icons' })
map('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Search Jumps' })
map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Search Keymaps' })
map('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Search Location list' })
map('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Search Marks' })
map('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Search Man pages' })
map('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Search Quickfix list' })
map('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Search Resume' })
map('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Search Undo history' })
-- UI / settings (toggles show their state in which-key)
map('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'UI Colorschemes' })
Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
Snacks.toggle.line_number():map('<leader>ul')
Snacks.toggle.option('relativenumber', { name = 'Relative number' }):map('<leader>uL')
Snacks.toggle.diagnostics():map('<leader>ud')
Snacks.toggle.inlay_hints():map('<leader>uh')
Snacks.toggle.treesitter():map('<leader>uT')
Snacks.toggle.zoom():map('<C-w>m') -- current window full screen and back (also <leader>wm via the which-key <C-w> proxy)
-- LSP (buffer-local, only where an attached server supports the method, so built-in gd, ga, [[, ]] keep working elsewhere)
local function map_lsp(method, lhs, rhs, opts)
    Snacks.keymap.set('n', lhs, rhs, vim.tbl_extend('force', opts, { lsp = { method = method } }))
end
map_lsp('textDocument/definition', 'gd', function() Snacks.picker.lsp_definitions() end,
    { desc = 'Goto Definition' })
map_lsp('textDocument/declaration', 'gD', function() Snacks.picker.lsp_declarations() end,
    { desc = 'Goto Declaration' })
map_lsp('textDocument/references', 'gr', function() Snacks.picker.lsp_references() end,
    { desc = 'Goto References', nowait = true })
map_lsp('textDocument/implementation', 'gI', function() Snacks.picker.lsp_implementations() end,
    { desc = 'Goto Implementation' })
map_lsp('textDocument/typeDefinition', 'gy', function() Snacks.picker.lsp_type_definitions() end,
    { desc = 'Goto type definition' })
map_lsp('callHierarchy/incomingCalls', 'gai', function() Snacks.picker.lsp_incoming_calls() end,
    { desc = 'Goto calls Incoming' })
map_lsp('callHierarchy/outgoingCalls', 'gao', function() Snacks.picker.lsp_outgoing_calls() end,
    { desc = 'Goto calls Outgoing' })
map_lsp('textDocument/documentSymbol', '<leader>sS', function() Snacks.picker.lsp_symbols() end,
    { desc = 'Search file Symbols' })
map_lsp('workspace/symbol', '<leader>ss', function() Snacks.picker.lsp_workspace_symbols() end,
    { desc = 'Search workspace Symbols' })
-- words (references of the word under cursor)
map_lsp('textDocument/documentHighlight', ']]', function() Snacks.words.jump(vim.v.count1) end,
    { desc = 'Next reference' })
map_lsp('textDocument/documentHighlight', '[[', function() Snacks.words.jump(-vim.v.count1) end,
    { desc = 'Previous reference' })
-- diagnostics (also from non-LSP sources)
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Code line Diagnostics' })
map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Search Diagnostics (workspace)' })
map('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Search Diagnostics (buffer)' })
