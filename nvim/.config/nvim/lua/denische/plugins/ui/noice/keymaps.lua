-- scroll LSP hover / signature docs, falls back to the default key when no docs are open
return {
    { '<C-f>', function() if not require('noice.lsp').scroll(4) then return '<C-f>' end end,   desc = 'Scroll docs down', mode = { 'n', 'i', 's' }, silent = true, expr = true },
    { '<C-b>', function() if not require('noice.lsp').scroll(-4) then return '<C-b>' end end,  desc = 'Scroll docs up',   mode = { 'n', 'i', 's' }, silent = true, expr = true },
}
