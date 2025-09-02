local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

-- vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug toggle [B]reakpoint', })
-- vim.keymap.set('n', '<leader>ds', dap.continue, { desc = '[D]ebug [S]tart', })

-- auto open dap-ui
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
-- dap.listeners.before.event_terminated.dapui_config = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--     dapui.close()
-- end
