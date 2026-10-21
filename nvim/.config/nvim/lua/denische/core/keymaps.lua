vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

--
-- Common
--

-- System copy/paste
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', [["+Y]], { desc = '[Y]ank line to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]], { desc = '[P]aste from clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+P]], { desc = '[P]aste from clipboard before' })
-- Buffers
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bo', function() Snacks.bufdelete.other() end, { desc = '[B]uffer delete [O]thers' })
vim.keymap.set('n', '<leader>bD', '<cmd>bdelete<cr>', { desc = '[B]uffer [D]elete with window' })
-- Windows (other <C-w> commands are available as <leader>w… via which-key, e.g. <leader>wo)
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = '[W]indow [D]elete' })
-- Location / quickfix lists
vim.keymap.set('n', '<leader>xl', function()
    local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
    if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Lists: [L]ocation list toggle' })
vim.keymap.set('n', '<leader>xq', function()
    local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
    if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Lists: [Q]uickfix list toggle' })
-- Remove search highlights after searching
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })
