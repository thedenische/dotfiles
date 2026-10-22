local map = vim.keymap.set

-- System copy/paste
map({ 'n', 'x' }, '<leader>y', [["+y]], { desc = 'Yank to clipboard' })
map({ 'n', 'x' }, '<leader>Y', [["+Y]], { desc = 'Yank line to clipboard' })
map({ 'n', 'x' }, '<leader>p', [["+p]], { desc = 'Paste from clipboard' })
map({ 'n', 'x' }, '<leader>P', [["+P]], { desc = 'Paste from clipboard before' })
-- Buffers
map('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Buffer Delete' })
map('n', '<leader>bo', function() Snacks.bufdelete.other() end, { desc = 'Buffer delete Others' })
map('n', '<leader>bD', '<cmd>bdelete<cr>', { desc = 'Buffer Delete with window' })
-- Windows (other <C-w> commands are available as <leader>w… via which-key, e.g. <leader>wo)
map('n', '<leader>wd', '<C-w>c', { desc = 'Window Delete' })
-- resize mode: h/j/k/l move the split border in that direction (like tmux prefix + h/j/k/l), = equalizes,
-- m toggles zoom, other keys exit
map('n', '<C-w><Space>', function()
    local function resize(key)
        if vim.api.nvim_win_get_config(0).relative ~= '' then
            return -- zoomed (floating) window has no split border
        end
        local vertical = key == 'h' or key == 'l'
        local has_neighbor = vim.fn.winnr(vertical and 'l' or 'j') ~= vim.fn.winnr() -- split to the right / below
        local grow = (key == 'l' or key == 'j') == has_neighbor
        vim.cmd((vertical and 'vertical ' or '') .. 'resize ' .. (grow and '+2' or '-2'))
    end
    vim.api.nvim_echo({ { '-- RESIZE -- h/j/k/l move border, = equalize, m zoom, any other key exits', 'ModeMsg' } },
        false, {})
    while true do
        vim.cmd.redraw()
        local ok, key = pcall(vim.fn.getcharstr)
        if ok and key:match('^[hjkl]$') then
            resize(key)
        elseif ok and key == '=' then
            vim.cmd.wincmd('=')
        elseif ok and key == 'm' then
            Snacks.zen.zoom()
        else
            break
        end
    end
end, { desc = 'Resize mode (h/j/k/l, m zoom)' })
-- Location / quickfix lists
map('n', '<leader>xl', function()
    local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
    if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Lists: Location list toggle' })
map('n', '<leader>xq', function()
    local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
    if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'Lists: Quickfix list toggle' })
-- Quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })
-- Remove search highlights after searching
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })
-- Plugins (vim.pack): status shows installed plugins without downloading, update opens a review buffer (:write applies)
map('n', '<leader>up', function() vim.pack.update(nil, { offline = true }) end, { desc = 'UI Plugins status' })
map('n', '<leader>uP', function() vim.pack.update() end, { desc = 'UI Plugins update' })
