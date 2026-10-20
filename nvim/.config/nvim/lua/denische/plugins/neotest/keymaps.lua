return {
    { '<leader>tr', function() require('neotest').run.run() end,                                                 desc = '[T]est [R]un nearest' },
    { '<leader>tt', function() require('neotest').run.run(vim.fn.expand('%')) end,                               desc = '[T]est [T]his file' },
    { '<leader>tT', function() require('neotest').run.run(vim.uv.cwd()) end,                                     desc = '[T]est all files ([T])' },
    { '<leader>tl', function() require('neotest').run.run_last() end,                                            desc = '[T]est run [L]ast' },
    { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end,                             desc = '[T]est [D]ebug nearest' },
    { '<leader>tD', function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,         desc = '[T]est [D]ebug file' },
    { '<leader>ta', function() require('neotest').run.attach() end,                                              desc = '[T]est [A]ttach' },
    { '<leader>tS', function() require('neotest').run.stop() end,                                                desc = '[T]est [S]top' },
    { '<leader>ts', function() require('neotest').summary.toggle() end,                                          desc = '[T]est [S]ummary toggle' },
    { '<leader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end,          desc = '[T]est [O]utput' },
    { '<leader>tO', function() require('neotest').output_panel.toggle() end,                                     desc = '[T]est [O]utput panel toggle' },
    { '<leader>tw', function() require('neotest').watch.toggle(vim.fn.expand('%')) end,                          desc = '[T]est [W]atch toggle' },
}
