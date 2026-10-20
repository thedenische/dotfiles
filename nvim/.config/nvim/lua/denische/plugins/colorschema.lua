return {
    {
        'sainnhe/everforest',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('everforest')
        end
    },
    -- alternatives, loaded on demand (e.g. via <leader>uC)
    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
    },
    {
        'doums/darcula',
        lazy = true,
    },
    {
        'briones-gabriel/darcula-solid.nvim',
        lazy = true,
        dependencies = {
            'rktjmp/lush.nvim'
        },
    },
}
