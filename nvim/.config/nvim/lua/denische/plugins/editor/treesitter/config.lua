-- parsers use treesitter names, LSP servers / tools are installed separately via mason-tool-installer
local parsers = {
    'lua', 'vim', 'vimdoc', 'luadoc',
    'yaml', 'json', 'xml', 'markdown', 'markdown_inline',
    'java',
    'javascript', 'typescript', 'tsx',
    'python',
    'dockerfile',
    'go',
}

-- Install parsers (no-op if already installed)
require('nvim-treesitter').install(parsers)

-- Enable treesitter highlighting for all supported filetypes
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
    callback = function(args)
        -- pcall to avoid errors on filetypes without a parser
        pcall(vim.treesitter.start, args.buf)
    end,
})
