return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        -- show variable values next to the code while debugging
        {
            'theHamsta/nvim-dap-virtual-text',
            opts = {},
        },
    },
    keys = require('denische.plugins.dap.keymaps'),
    config = function()
        require('denische.plugins.dap.config')
    end,
}
