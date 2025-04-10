return {
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = '[D]ap [B]reakpoint' },
    { '<leader>ds', function() require('dap').continue() end,          desc = '[D]ap [S]tart' },
    { '<leader>do', function() require('dapui').open() end,            desc = '[D]ap [O]pen' },
    { '<leader>dx', function() require('dapui').close() end,           desc = '[D]ap e[X]it' },
}
