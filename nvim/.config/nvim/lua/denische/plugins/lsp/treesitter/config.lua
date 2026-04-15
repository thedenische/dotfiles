local parsers = {
    'lua', 'vim', 'vimdoc', 'luadoc',
    'yaml', 'json', 'xml', 'markdown', 'markdown_inline',
    'java',
    'javascript',
    'go',
    'python',
}

-- Install parsers (no-op if already installed)
require('nvim-treesitter').install(parsers)

-- Enable treesitter highlighting for all supported filetypes
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        -- pcall to avoid errors on filetypes without a parser
        pcall(vim.treesitter.start, args.buf)
    end,
})
