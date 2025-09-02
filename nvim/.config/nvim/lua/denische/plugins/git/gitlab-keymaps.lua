return {
    { '<leader>gmc', function() require('gitlab').choose_merge_request() end, desc = '[G]it [M]erge request [C]hoose' },
    { '<leader>gmr', function() require('gitlab').review() end,               desc = '[G]it [M]erge request [R]view' },
}
