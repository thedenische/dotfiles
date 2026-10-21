local function augroup(name)
    return vim.api.nvim_create_augroup('User' .. name, { clear = true })
end

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('HighlightYank'),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- reload files changed outside of nvim (e.g. git checkout in another tmux pane)
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = augroup('Checktime'),
    callback = function()
        if vim.o.buftype ~= 'nofile' then
            vim.cmd('checktime')
        end
    end,
})

-- resize splits when the terminal is resized
vim.api.nvim_create_autocmd('VimResized', {
    group = augroup('ResizeSplits'),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd('tabdo wincmd =')
        vim.cmd('tabnext ' .. current_tab)
    end,
})

-- go to the last cursor position when opening a file
vim.api.nvim_create_autocmd('BufReadPost', {
    group = augroup('LastLocation'),
    callback = function(event)
        local buf = event.buf
        if vim.bo[buf].filetype == 'gitcommit' or vim.b[buf].user_last_location then
            return
        end
        vim.b[buf].user_last_location = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(buf) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- close helper windows with q
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('CloseWithQ'),
    pattern = {
        'checkhealth',
        'dap-float',
        'gitsigns-blame',
        'help',
        'neotest-output',
        'neotest-output-panel',
        'neotest-summary',
        'qf',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set('n', 'q', function()
                vim.cmd('close')
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, { buffer = event.buf, silent = true, desc = 'Quit buffer' })
        end)
    end,
})

-- wrap and check spelling in text filetypes
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('WrapSpell'),
    pattern = { 'text', 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- create missing parent directories when saving a file
vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup('AutoCreateDir'),
    callback = function(event)
        if event.match:match('^%w%w+:[\\/][\\/]') then -- skip URLs (oil://, scp://, ...)
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
})
