return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
    },
    keys = require('denische.plugins.dap.keymaps'),
    config = function()
        require('denische.plugins.dap.config')
    end,
}
