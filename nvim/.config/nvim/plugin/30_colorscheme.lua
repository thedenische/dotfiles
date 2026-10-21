vim.pack.add({
    'https://github.com/sainnhe/everforest',
    -- alternatives, switch with <leader>uC
    'https://github.com/ellisonleao/gruvbox.nvim',
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
    'https://github.com/doums/darcula',
})

vim.cmd.colorscheme('everforest')
