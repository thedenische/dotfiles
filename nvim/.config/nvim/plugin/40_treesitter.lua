-- loaded right away to highlight the file opened on startup
vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } })

-- parsers use treesitter names, LSP servers / tools are installed separately via mason-tool-installer
local parsers = {
    'lua', 'vim', 'vimdoc', 'luadoc', 'query',
    'bash', 'regex', -- noice cmdline highlighting
    'diff', 'gitcommit',
    'yaml', 'json', 'xml', 'toml', 'markdown', 'markdown_inline',
    'java',
    'javascript', 'typescript', 'tsx',
    'html', 'css', 'scss',
    'python',
    'dockerfile',
    'go',
}

-- install parsers (no-op if already installed)
require('nvim-treesitter').install(parsers)

-- enable treesitter highlighting for all supported filetypes, and indentation where the parser has indent queries
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
    callback = function(args)
        -- pcall to avoid errors on filetypes without a parser
        if not pcall(vim.treesitter.start, args.buf) then
            return
        end
        local lang = vim.treesitter.language.get_lang(args.match)
        -- pcall to avoid errors on invalid queries
        local ok, indents = pcall(vim.treesitter.query.get, lang, 'indents')
        if ok and indents then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
