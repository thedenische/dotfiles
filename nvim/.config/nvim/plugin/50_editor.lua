--
-- Treesitter (loaded right away to highlight the file opened on startup)
--

vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } })

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

-- install parsers (no-op if already installed)
require('nvim-treesitter').install(parsers)

-- enable treesitter highlighting for all supported filetypes
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
    callback = function(args)
        -- pcall to avoid errors on filetypes without a parser
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- the rest after startup (the first screen is drawn first)
vim.schedule(function()
    vim.pack.add({
        -- autocomplete (a release version downloads the pre-built fuzzy matcher binary)
        { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
        'https://github.com/rafamadriz/friendly-snippets',
        'https://github.com/fang2hou/blink-copilot',
        'https://github.com/echasnovski/mini.nvim',
        -- tmux panes transparent navigation (default keymaps <C-h/j/k/l/\>)
        'https://github.com/christoomey/vim-tmux-navigator',
    })

    --
    -- Completion
    --

    local function set_cmp_highlights()
        vim.api.nvim_set_hl(0, 'BlinkCmpKindCopilot', { fg = '#6CC644' })
    end

    set_cmp_highlights()
    -- colorschemes reset highlights, so re-apply after every switch
    vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('UserCmpHighlights', { clear = true }),
        callback = set_cmp_highlights,
    })

    require('blink.cmp').setup({
        appearance = {
            kind_icons = {
                Copilot = ''
            }
        },

        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = {
                    border = 'rounded'
                }
            },
            menu = {
                border = 'rounded',
                draw = {
                    columns = {
                        { 'label',      'label_description', gap = 1 },
                        { 'kind_icon',  gap = 1,             'kind' },
                        { 'source_name' }
                    }
                }
            }
        },

        sources = {
            default = {
                'lsp',
                'path',
                'snippets',
                'buffer',
                'copilot'
            },
            providers = {
                copilot = {
                    name = 'copilot',
                    module = 'blink-copilot',
                    score_offset = 100,
                    async = true,
                }
            },
        },
    })

    --
    -- Mini
    --

    require('mini.pairs').setup()
    require('mini.indentscope').setup()
end)
