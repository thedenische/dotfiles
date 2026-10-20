-- ask for program arguments before starting (java expects a single string)
local function with_args(config)
    local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
    local args_str = type(args) == 'table' and table.concat(args, ' ') or args

    config = vim.deepcopy(config)
    config.args = function()
        local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str))
        if config.type == 'java' then
            return new_args
        end
        return require('dap.utils').splitstr(new_args)
    end
    return config
end

return {
    { '<leader>db', function() require('dap').toggle_breakpoint() end,                                     desc = '[D]ebug [B]reakpoint' },
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = '[D]ebug conditional [B]reakpoint' },
    { '<leader>dc', function() require('dap').continue() end,                                              desc = '[D]ebug run / [C]ontinue' },
    { '<leader>da', function() require('dap').continue({ before = with_args }) end,                        desc = '[D]ebug run with [A]rgs' },
    { '<leader>dC', function() require('dap').run_to_cursor() end,                                         desc = '[D]ebug run to [C]ursor' },
    { '<leader>dl', function() require('dap').run_last() end,                                              desc = '[D]ebug run [L]ast' },
    { '<leader>di', function() require('dap').step_into() end,                                             desc = '[D]ebug step [I]nto' },
    { '<leader>dO', function() require('dap').step_over() end,                                             desc = '[D]ebug step [O]ver' },
    { '<leader>do', function() require('dap').step_out() end,                                              desc = '[D]ebug step [O]ut' },
    { '<leader>dj', function() require('dap').down() end,                                                  desc = '[D]ebug stack down (j)' },
    { '<leader>dk', function() require('dap').up() end,                                                    desc = '[D]ebug stack up (k)' },
    { '<leader>dP', function() require('dap').pause() end,                                                 desc = '[D]ebug [P]ause' },
    { '<leader>dr', function() require('dap').repl.toggle() end,                                           desc = '[D]ebug [R]EPL' },
    { '<leader>dt', function() require('dap').terminate() end,                                             desc = '[D]ebug [T]erminate' },
    { '<leader>dw', function() require('dap.ui.widgets').hover() end,                                      desc = '[D]ebug [W]idgets' },
    { '<leader>du', function() require('dapui').toggle() end,                                              desc = '[D]ebug [U]I toggle' },
    { '<leader>de', function() require('dapui').eval() end,                                                desc = '[D]ebug [E]val',                   mode = { 'n', 'x' } },
}
