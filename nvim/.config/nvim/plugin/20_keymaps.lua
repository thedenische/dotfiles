local map = vim.keymap.set

-- System copy/paste
map({ 'n', 'x' }, '<leader>y', [["+y]], { desc = '[Y]ank to clipboard' })
map({ 'n', 'x' }, '<leader>Y', [["+Y]], { desc = '[Y]ank line to clipboard' })
map({ 'n', 'x' }, '<leader>p', [["+p]], { desc = '[P]aste from clipboard' })
map({ 'n', 'x' }, '<leader>P', [["+P]], { desc = '[P]aste from clipboard before' })
-- Buffers
map('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[B]uffer [D]elete' })
map('n', '<leader>bo', function() Snacks.bufdelete.other() end, { desc = '[B]uffer delete [O]thers' })
map('n', '<leader>bD', '<cmd>bdelete<cr>', { desc = '[B]uffer [D]elete with window' })
-- Windows (other <C-w> commands are available as <leader>w… via which-key, e.g. <leader>wo)
map('n', '<leader>wd', '<C-w>c', { desc = '[W]indow [D]elete' })
-- Location / quickfix lists
map('n', '<leader>xl', function()
    local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
    if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Lists: [L]ocation list toggle' })
map('n', '<leader>xq', function()
    local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
    if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Lists: [Q]uickfix list toggle' })
-- Quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit all' })
-- Remove search highlights after searching
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })
-- Plugins (vim.pack): status shows installed plugins without downloading, update opens a review buffer (:write applies)
map('n', '<leader>up', function() vim.pack.update(nil, { offline = true }) end, { desc = '[U]I [P]lugins status' })
map('n', '<leader>uP', function() vim.pack.update() end, { desc = '[U]I [P]lugins update' })
