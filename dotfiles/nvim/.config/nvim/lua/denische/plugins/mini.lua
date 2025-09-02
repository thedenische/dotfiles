return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.pairs').setup()
            require('mini.diff').setup()
            require('mini.indentscope').setup()
            require('mini.pairs').setup()
        end
    }
}
