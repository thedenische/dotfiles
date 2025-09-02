return {
     {
      'sainnhe/everforest',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd.colorscheme('everforest')
      end
    },
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
    },
    {
        'doums/darcula',
        priority = 1000,
    },
    {
        'briones-gabriel/darcula-solid.nvim',
        priority = 1000,
        dependencies = {
            'rktjmp/lush.nvim'
        },
    },
}
