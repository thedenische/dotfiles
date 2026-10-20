local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

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
