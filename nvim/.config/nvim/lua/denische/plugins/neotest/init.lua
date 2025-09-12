return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter'
        },
        keys = require('denische.plugins.neotest.keymaps'),
        config = function()
            require('denische.plugins.neotest.config')
        end,
    },
    {
        'rcasia/neotest-java',
        ft = 'java',
        dependencies = {
            'mfussenegger/nvim-jdtls',
            'mfussenegger/nvim-dap',           -- for the debugger
            'rcarriga/nvim-dap-ui',            -- recommended
            'theHamsta/nvim-dap-virtual-text', -- recommended
        },
    },
}
