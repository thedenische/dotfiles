return {
    { '<leader>tr', function() require('neotest').run.run() end,                                         desc = '[T]est [R]un' },
    { '<leader>tR', '<cmd>Neotest run file<cr>',                                                         desc = '[T]est [R]un all' },
    { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end,                     desc = '[T]est [D]ebug' },
    { '<leader>tD', function() require('neotest').run.run(vim.fn.expand('%'), { strategy = 'dap' }) end, desc = '[T]est [D]ebug all' },
    { '<leader>ts', function() require('neotest').run.stop() end,                                        desc = '[T]est [S]top' },
    { '<leader>ta', function() require('neotest').run.attach() end,                                      desc = '[T]est [A]ttach' },
    { '<leader>ti', '<cmd>Neotest summary toggle<cr>',                                                   desc = '[T]est [I]nfo' },
}
