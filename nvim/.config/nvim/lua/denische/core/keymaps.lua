vim.g.mapleader = ' '

--
-- Common
--

-- System copy/paste
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'global copy' })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', [["+Y]], { desc = 'global copy' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]], { desc = 'global paste' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+P]], { desc = 'global paste' })
-- Close buffer
vim.keymap.set({ 'n', 'v' }, '<leader>x', '<cmd>bdelete<cr>', { desc = 'close buffer' })
vim.keymap.set({ 'n', 'v' }, '<leader>X', '<cmd>only<cr>', { desc = 'close other windows' })
-- Remove search highlights after serchnig
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'hide search highlights' })
