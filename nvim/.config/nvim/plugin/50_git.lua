-- loaded after startup, gitsigns attaches to already open buffers
MiniMisc.safely('later', function()
    -- editor git integration (changes, blame, etc)
    vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

    require('gitsigns').setup()
end)

local map = vim.keymap.set

-- in diff windows (diffview, merge request reviews) fall back to the built-in ]c / [c
map('n', ']h', function()
    if vim.wo.diff then return vim.cmd.normal({ ']c', bang = true }) end
    require('gitsigns').nav_hunk('next')
end, { desc = 'Next git hunk' })
map('n', '[h', function()
    if vim.wo.diff then return vim.cmd.normal({ '[c', bang = true }) end
    require('gitsigns').nav_hunk('prev')
end, { desc = 'Previous git hunk' })
map('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk<cr>', { desc = '[G]it [H]unk [P]review' })
map({ 'n', 'x' }, '<leader>ghs', ':Gitsigns stage_hunk<cr>', { desc = '[G]it [H]unk [S]tage', silent = true })
map({ 'n', 'x' }, '<leader>ghr', ':Gitsigns reset_hunk<cr>', { desc = '[G]it [H]unk [R]eset', silent = true })
map('n', '<leader>ghS', '<cmd>Gitsigns stage_buffer<cr>', { desc = '[G]it [H]unk [S]tage buffer' })
map('n', '<leader>ghR', '<cmd>Gitsigns reset_buffer<cr>', { desc = '[G]it [H]unk [R]eset buffer' })
map('n', '<leader>ghd', '<cmd>Gitsigns diffthis<cr>', { desc = '[G]it [H]unk [D]iff this' })
map({ 'o', 'x' }, 'ih', ':<C-u>Gitsigns select_hunk<cr>', { desc = 'Git hunk', silent = true })
map('n', '<leader>ghb', function() require('gitsigns').blame_line({ full = true }) end,
    { desc = '[G]it [H]unk [B]lame line' })
map('n', '<leader>ghB', function() require('gitsigns').blame() end, { desc = '[G]it [H]unk [B]lame buffer' })
map('n', '<leader>gtb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = '[G]it [T]oggle [B]lame' })
map('n', '<leader>gtw', '<cmd>Gitsigns toggle_word_diff<cr>', { desc = '[G]it [T]oggle [W]ord diff' })

--
-- GitLab (slow to load, so it is set up on first use of its keymaps)
--

local map_gitlab = Config.on_demand(function()
    vim.pack.add({
        'https://github.com/MunifTanjim/nui.nvim',
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/sindrets/diffview.nvim', -- diff views of merge requests
        'https://github.com/harrisoncramer/gitlab.nvim',
    })
    require('gitlab').setup()
end)

map_gitlab('n', '<leader>gmc', function() require('gitlab').choose_merge_request() end,
    { desc = '[G]it [M]erge request [C]hoose' })
map_gitlab('n', '<leader>gmr', function() require('gitlab').review() end, { desc = '[G]it [M]erge request [R]eview' })
