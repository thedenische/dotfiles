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
map('n', '<leader>n', function() Snacks.picker.notifications() end, { desc = '[N]otification history' })
map('n', '<leader>e', function() Snacks.explorer() end, { desc = '[E]xplorer' })
-- find
map('n', '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end,
    { desc = '[F]ind [C]onfig file' })
map('n', '<leader>ff', function() Snacks.picker.files() end, { desc = '[F]ind [F]iles' })
map('n', '<leader>fg', function() Snacks.picker.git_files() end, { desc = '[F]ind [G]it files' })
map('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = '[F]ind [P]rojects' })
map('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = '[F]ind [R]ecent files' })
-- git
map('n', '<leader>gg', function() Snacks.lazygit({ cwd = Snacks.git.get_root() }) end, { desc = '[G]it lazy[G]it' })
map('n', '<leader>gG', function() Snacks.lazygit() end, { desc = '[G]it lazy[G]it (cwd)' })
map('n', '<leader>gb', function() Snacks.picker.git_log_line() end, { desc = '[G]it [B]lame line' })
map('n', '<leader>gc', function() Snacks.picker.git_branches() end, { desc = '[G]it [C]heckout branch' })
map('n', '<leader>gl', function() Snacks.picker.git_log({ cwd = Snacks.git.get_root() }) end, { desc = '[G]it [L]og' })
map('n', '<leader>gL', function() Snacks.picker.git_log() end, { desc = '[G]it [L]og (cwd)' })
map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = '[G]it [S]tatus' })
map('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = '[G]it [S]tash' })
map('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = '[G]it [D]iff (hunks)' })
map('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = '[G]it log [F]ile' })
map({ 'n', 'x' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = '[G]it [B]rowse (open)' })
map({ 'n', 'x' }, '<leader>gY', function()
    Snacks.gitbrowse({ open = function(url) vim.fn.setreg('+', url) end, notify = false })
end, { desc = '[G]it browse cop[Y] URL' })
-- grep
map('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = '[S]earch [B]uffer lines' })
map('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = '[S]earch open [B]uffers (grep)' })
map({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = '[S]earch [W]ord or selection' })
-- search
map('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = '[S]earch registers' })
map('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = '[S]earch history' })
map('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = '[S]earch [A]utocmds' })
map('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = '[S]earch [C]ommands' })
map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = '[S]earch [H]elp pages' })
map('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = '[S]earch [H]ighlights' })
map('n', '<leader>si', function() Snacks.picker.icons() end, { desc = '[S]earch [I]cons' })
map('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = '[S]earch [J]umps' })
map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = '[S]earch [L]ocation list' })
map('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = '[S]earch [M]arks' })
map('n', '<leader>sM', function() Snacks.picker.man() end, { desc = '[S]earch [M]an pages' })
map('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = '[S]earch [Q]uickfix list' })
map('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = '[S]earch [R]esume' })
map('n', '<leader>su', function() Snacks.picker.undo() end, { desc = '[S]earch [U]ndo history' })
-- UI / settings (toggles show their state in which-key)
map('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = '[U]I [C]olorschemes' })
Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
Snacks.toggle.line_number():map('<leader>ul')
Snacks.toggle.option('relativenumber', { name = 'Relative number' }):map('<leader>uL')
Snacks.toggle.diagnostics():map('<leader>ud')
Snacks.toggle.inlay_hints():map('<leader>uh')
Snacks.toggle.treesitter():map('<leader>uT')
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark background' }):map('<leader>ub')
-- LSP (buffer-local, only where an attached server supports the method, so built-in gd, ga, [[, ]] keep working elsewhere)
local function map_lsp(method, lhs, rhs, opts)
    Snacks.keymap.set('n', lhs, rhs, vim.tbl_extend('force', opts, { lsp = { method = method } }))
end
map_lsp('textDocument/definition', 'gd', function() Snacks.picker.lsp_definitions() end,
    { desc = '[G]oto [D]efinition' })
map_lsp('textDocument/declaration', 'gD', function() Snacks.picker.lsp_declarations() end,
    { desc = '[G]oto [D]eclaration' })
map_lsp('textDocument/references', 'gr', function() Snacks.picker.lsp_references() end,
    { desc = '[G]oto [R]eferences', nowait = true })
map_lsp('textDocument/implementation', 'gI', function() Snacks.picker.lsp_implementations() end,
    { desc = '[G]oto [I]mplementation' })
map_lsp('textDocument/typeDefinition', 'gy', function() Snacks.picker.lsp_type_definitions() end,
    { desc = '[G]oto t[Y]pe definition' })
map_lsp('callHierarchy/incomingCalls', 'gai', function() Snacks.picker.lsp_incoming_calls() end,
    { desc = '[G]oto c[A]lls [I]ncoming' })
map_lsp('callHierarchy/outgoingCalls', 'gao', function() Snacks.picker.lsp_outgoing_calls() end,
    { desc = '[G]oto c[A]lls [O]utgoing' })
map_lsp('textDocument/documentSymbol', '<leader>sS', function() Snacks.picker.lsp_symbols() end,
    { desc = '[S]earch file [S]ymbols' })
map_lsp('workspace/symbol', '<leader>ss', function() Snacks.picker.lsp_workspace_symbols() end,
    { desc = '[S]earch workspace [S]ymbols' })
-- words (references of the word under cursor)
map_lsp('textDocument/documentHighlight', ']]', function() Snacks.words.jump(vim.v.count1) end,
    { desc = 'Next reference' })
map_lsp('textDocument/documentHighlight', '[[', function() Snacks.words.jump(-vim.v.count1) end,
    { desc = 'Previous reference' })
-- diagnostics (also from non-LSP sources)
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = '[C]ode line [D]iagnostics' })
map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = '[S]earch [D]iagnostics (workspace)' })
map('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = '[S]earch [D]iagnostics (buffer)' })
