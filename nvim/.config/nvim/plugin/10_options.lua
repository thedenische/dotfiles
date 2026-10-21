-- common
vim.o.showmode       = false     -- mode is shown in the status line
vim.o.cursorline     = true      -- highlight current line
vim.o.winborder      = 'rounded' -- border of floating windows
vim.o.undofile       = true      -- persist undo history between sessions
vim.o.confirm        = true      -- ask to save changes instead of failing (e.g. on :q)
vim.o.laststatus     = 3         -- single status line for all windows
vim.o.virtualedit    = 'block'   -- allow the cursor past the end of line in visual block mode
vim.o.jumpoptions    = 'view'    -- restore the view (scroll position) when jumping back
-- windows
vim.o.splitright     = true      -- open vertical splits to the right
vim.o.splitbelow     = true      -- open horizontal splits below
vim.o.splitkeep      = 'screen'  -- keep the text in place when splitting
-- search
vim.o.ignorecase     = true      -- case insensitive search...
vim.o.smartcase      = true      -- ...unless the pattern contains uppercase
-- lines
vim.o.number         = true      -- display line numbers
vim.o.relativenumber = true      -- display relative line numbers
vim.o.signcolumn     = 'yes'     -- always show the sign column, so text does not shift when signs appear
vim.o.scrolloff      = 10        -- number of lines to keep above/below the cursor
vim.o.sidescrolloff  = 5         -- number of columns to keep to the left/right of the cursor
vim.o.smoothscroll   = true      -- scroll wrapped lines by screen line
-- tabs
vim.o.expandtab      = true      -- convert tabs to spaces
vim.o.tabstop        = 4         -- number of spaces inserter for tab character
vim.o.shiftwidth     = 4         -- number of spaces for each indentention level
vim.o.breakindent    = true      -- enable line breaking idention
-- show whitespaces
vim.o.list           = true
vim.opt.listchars    = {
    tab = '→ ',
    space = '.',
    trail = '-',
    nbsp = '+',
}
-- diagnostic config
local signs          = {
    ERROR = '',
    WARN = '',
    HINT = '󰌵',
    INFO = '',
}

vim.diagnostic.config {
    severity_sort = true,
    virtual_text = {
        source = 'if_many', -- show which server reported it when several are attached (e.g. harper_ls + jdtls)
        prefix = function(diagnostic)
            return signs[vim.diagnostic.severity[diagnostic.severity]]
        end,
    },
    signs = {
        text = signs,
    },
}
-- folding: treesitter by default, LSP folds where the server supports them (see plugin/50_lsp.lua)
vim.o.foldmethod     = 'expr'
vim.o.foldexpr       = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext       = '' -- keep syntax highlighting on folded lines
vim.o.foldcolumn     = '1'
vim.o.foldlevel      = 99
vim.o.foldlevelstart = 99
vim.opt.fillchars:append({ foldopen = '', foldclose = '' }) -- fold icons (shown by snacks.statuscolumn)
