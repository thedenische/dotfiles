-- common
vim.o.termguicolors   = true -- colorscheme
-- vim.o.showmode = false       -- hide mode display
vim.o.cursorline      = true -- highlight current line
-- lines
vim.wo.number         = true -- display line numbers
vim.wo.relativenumber = true -- display relative line numbers
vim.o.scrolloff       = 10   -- number of lines to keep above/below the cursor
vim.o.sidescrolloff   = 5    -- number of columns to keep the the left/right to the cursor
-- tabs
vim.o.expandtab       = true -- convert tabs to spaces
vim.o.tabstop         = 4    -- number of spaces inserter for tab character
vim.o.shiftwidth      = 4    -- number of spaces for each indentention level
vim.o.smartindent     = true -- enable smart indentention
vim.o.breakindent     = true -- enable line breaking idention
-- show pairs
vim.o.showmatch       = true
-- show whitespaces
vim.o.list            = true
vim.opt.listchars     = {
    tab = '→ ',
    space = '.'
}
-- diagnostic config
local signs           = {
    ERROR = '',
    WARN = '',
    HINT = '󰌵',
    INFO = '',
}

vim.diagnostic.config {
    virtual_text = {
        prefix = function(diagnostic)
            return signs[vim.diagnostic.severity[diagnostic.severity]]
        end,
    },
    signs = {
        text = signs,
    },
}
-- for folding settings see the ufo plugin config
