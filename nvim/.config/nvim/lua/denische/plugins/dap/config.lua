local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

-- auto open dap-ui
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
