return {
    { ']h',          function() require('gitsigns').nav_hunk('next') end, desc = 'Next git hunk' },
    { '[h',          function() require('gitsigns').nav_hunk('prev') end, desc = 'Previous git hunk' },
    { '<leader>ghp', '<cmd>Gitsigns preview_hunk<cr>',                   desc = '[G]it [H]unk [P]review' },
    { '<leader>ghs', ':Gitsigns stage_hunk<cr>',                         desc = '[G]it [H]unk [S]tage',  mode = { 'n', 'x' }, silent = true },
    { '<leader>ghr', ':Gitsigns reset_hunk<cr>',                         desc = '[G]it [H]unk [R]eset',  mode = { 'n', 'x' }, silent = true },
    { '<leader>ghb', function() require('gitsigns').blame_line({ full = true }) end, desc = '[G]it [H]unk [B]lame line' },
    { '<leader>ghB', function() require('gitsigns').blame() end,         desc = '[G]it [H]unk [B]lame buffer' },
    { '<leader>gtb', '<cmd>Gitsigns toggle_current_line_blame<cr>',      desc = '[G]it [T]oggle [B]lame' },
    { '<leader>gtw', '<cmd>Gitsigns toggle_word_diff<cr>',               desc = '[G]it [T]oggle [W]ord diff' },
}
