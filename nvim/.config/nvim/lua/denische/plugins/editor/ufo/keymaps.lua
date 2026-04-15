local ufo = require('ufo')

-- unfold all
vim.keymap.set('n', 'zR', ufo.openAllFolds, {desc="Open all folds"})
-- fold all
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
-- show folded block under cursor
vim.keymap.set('n', 'zK', function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.bufer.hover()
    end
end, {desc = 'Peek fold'})
