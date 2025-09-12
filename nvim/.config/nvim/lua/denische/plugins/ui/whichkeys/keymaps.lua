return {
    {
        '<leader>?',
        function()
            require('which-key').show({ global = true })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
    },
}
