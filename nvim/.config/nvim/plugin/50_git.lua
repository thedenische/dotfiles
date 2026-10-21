-- loaded after startup (the first screen is drawn first), it attaches to already open buffers
vim.schedule(function()
    vim.pack.add({
        -- editor git integration (changes, blame, etc)
        'https://github.com/lewis6991/gitsigns.nvim',
        -- diff views (also used by gitlab.nvim)
        'https://github.com/sindrets/diffview.nvim',
    })

    require('gitsigns').setup()
end)

local map = vim.keymap.set

map('n', ']h', function() require('gitsigns').nav_hunk('next') end, { desc = 'Next git hunk' })
map('n', '[h', function() require('gitsigns').nav_hunk('prev') end, { desc = 'Previous git hunk' })
map('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk<cr>', { desc = '[G]it [H]unk [P]review' })
map({ 'n', 'x' }, '<leader>ghs', ':Gitsigns stage_hunk<cr>', { desc = '[G]it [H]unk [S]tage', silent = true })
map({ 'n', 'x' }, '<leader>ghr', ':Gitsigns reset_hunk<cr>', { desc = '[G]it [H]unk [R]eset', silent = true })
map('n', '<leader>ghb', function() require('gitsigns').blame_line({ full = true }) end,
    { desc = '[G]it [H]unk [B]lame line' })
map('n', '<leader>ghB', function() require('gitsigns').blame() end, { desc = '[G]it [H]unk [B]lame buffer' })
map('n', '<leader>gtb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = '[G]it [T]oggle [B]lame' })
map('n', '<leader>gtw', '<cmd>Gitsigns toggle_word_diff<cr>', { desc = '[G]it [T]oggle [W]ord diff' })

--
-- GitLab (slow to load, so it is set up on first use of its keymaps)
--

local gitlab_loaded = false
local function gitlab()
    if not gitlab_loaded then
        gitlab_loaded = true
        vim.pack.add({
            'https://github.com/MunifTanjim/nui.nvim',
            'https://github.com/nvim-lua/plenary.nvim',
            'https://github.com/nvim-tree/nvim-web-devicons',
            'https://github.com/harrisoncramer/gitlab.nvim',
        })
        require('gitlab').setup()
    end
    return require('gitlab')
end

map('n', '<leader>gmc', function() gitlab().choose_merge_request() end, { desc = '[G]it [M]erge request [C]hoose' })
map('n', '<leader>gmr', function() gitlab().review() end, { desc = '[G]it [M]erge request [R]eview' })
