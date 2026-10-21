-- the debugger and test runner are slow to load, so they are set up on first use of their keymaps
-- (nvim-dap itself is added in 50_lsp.lua, nvim-jdtls needs it)

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

local function setup_dap()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup()
    require('nvim-dap-virtual-text').setup({})

    -- breakpoint icons ({ icon, icon highlight, line highlight })
    local signs = {
        Stopped             = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
        Breakpoint          = { ' ', 'DiagnosticInfo' },
        BreakpointCondition = { ' ', 'DiagnosticInfo' },
        BreakpointRejected  = { ' ', 'DiagnosticError' },
        LogPoint            = { '.>', 'DiagnosticInfo' },
    }

    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

    for name, sign in pairs(signs) do
        vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2], linehl = sign[3], numhl = sign[3] })
    end

    -- auto open dap-ui (not for runs without the debugger)
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function(session)
        if not session.config.noDebug then
            dapui.open()
        end
    end

    -- auto close dap-ui when the program ends
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    -- java: attach to a JVM started with the debug agent, e.g.
    -- java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 ...
    -- main classes are added on dap.continue() by nvim-jdtls (see after/lsp/jdtls.lua)
    dap.configurations.java = {
        {
            type = 'java',
            request = 'attach',
            name = 'Debug (Attach) - Remote :5005',
            hostName = '127.0.0.1',
            port = 5005,
        },
    }
end

local function setup_neotest()
    require('neotest').setup({
        adapters = {
            require('neotest-java'),
        },
        status = { virtual_text = true }, -- test result next to each test
        output = { open_on_run = true },  -- show output after running a test
    })
end

local map = Config.on_demand(function()
    vim.pack.add({
        'https://github.com/nvim-neotest/nvim-nio',
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/rcarriga/nvim-dap-ui',
        -- show variable values next to the code while debugging
        'https://github.com/theHamsta/nvim-dap-virtual-text',
        'https://github.com/nvim-neotest/neotest',
        'https://github.com/rcasia/neotest-java',
    })
    setup_dap()
    setup_neotest()
end, { 'Neotest' })

--
-- DAP
--

map('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = '[D]ebug [B]reakpoint' })
map('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    { desc = '[D]ebug conditional [B]reakpoint' })
map('n', '<leader>dc', function() require('dap').continue() end, { desc = '[D]ebug run / [C]ontinue' })
map('n', '<leader>da', function() require('dap').continue({ before = with_args }) end,
    { desc = '[D]ebug run with [A]rgs' })
map('n', '<leader>dC', function() require('dap').run_to_cursor() end, { desc = '[D]ebug run to [C]ursor' })
map('n', '<leader>dl', function() require('dap').run_last() end, { desc = '[D]ebug run [L]ast' })
map('n', '<leader>di', function() require('dap').step_into() end, { desc = '[D]ebug step [I]nto' })
map('n', '<leader>dO', function() require('dap').step_over() end, { desc = '[D]ebug step [O]ver' })
map('n', '<leader>do', function() require('dap').step_out() end, { desc = '[D]ebug step [O]ut' })
map('n', '<leader>dj', function() require('dap').down() end, { desc = '[D]ebug stack down (j)' })
map('n', '<leader>dk', function() require('dap').up() end, { desc = '[D]ebug stack up (k)' })
map('n', '<leader>dP', function() require('dap').pause() end, { desc = '[D]ebug [P]ause' })
map('n', '<leader>dr', function() require('dap').repl.toggle() end, { desc = '[D]ebug [R]EPL' })
map('n', '<leader>dt', function() require('dap').terminate() end, { desc = '[D]ebug [T]erminate' })
map('n', '<leader>dw', function() require('dap.ui.widgets').hover() end, { desc = '[D]ebug [W]idgets' })
map('n', '<leader>du', function() require('dapui').toggle() end, { desc = '[D]ebug [U]I toggle' })
map({ 'n', 'x' }, '<leader>de', function() require('dapui').eval() end, { desc = '[D]ebug [E]val' })

--
-- Neotest
--

map('n', '<leader>tr', function() require('neotest').run.run() end, { desc = '[T]est [R]un nearest' })
map('n', '<leader>tt', function() require('neotest').run.run(vim.fn.expand('%')) end, { desc = '[T]est [T]his file' })
map('n', '<leader>tT', function() require('neotest').run.run(vim.uv.cwd()) end, { desc = '[T]est all files ([T])' })
map('n', '<leader>tl', function() require('neotest').run.run_last() end, { desc = '[T]est run [L]ast' })
map('n', '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end,
    { desc = '[T]est [D]ebug nearest' })
map('n', '<leader>tD', function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,
    { desc = '[T]est [D]ebug file' })
map('n', '<leader>ta', function() require('neotest').run.attach() end, { desc = '[T]est [A]ttach' })
map('n', '<leader>tS', function() require('neotest').run.stop() end, { desc = '[T]est [S]top' })
map('n', '<leader>ts', function() require('neotest').summary.toggle() end, { desc = '[T]est [S]ummary toggle' })
map('n', '<leader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end,
    { desc = '[T]est [O]utput' })
map('n', '<leader>tO', function() require('neotest').output_panel.toggle() end, { desc = '[T]est [O]utput panel toggle' })
map('n', '<leader>tw', function() require('neotest').watch.toggle(vim.fn.expand('%')) end,
    { desc = '[T]est [W]atch toggle' })
