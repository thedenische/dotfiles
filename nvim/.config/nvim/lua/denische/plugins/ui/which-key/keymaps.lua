return {
    {
        '<leader>?',
        function()
            require('which-key').show({ global = true })
        end,
        desc = 'Show all keymaps (which-key)',
    },
}
