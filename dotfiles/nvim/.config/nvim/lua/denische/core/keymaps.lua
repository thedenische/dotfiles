vim.g.mapleader = ' '

--
-- Common
--

-- Remove search highlights after serchnig
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'hide search highlights' })
