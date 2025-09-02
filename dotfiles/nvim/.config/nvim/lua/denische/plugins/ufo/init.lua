return {
    'kevinhwang91/nvim-ufo',
    -- lazy = true,
    config = function()
        require('denische.plugins.ufo.config')
    end,
    dependencies = {
        'kevinhwang91/promise-async'
    }
}
