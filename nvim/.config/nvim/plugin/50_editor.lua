-- no indent scope in non-code windows (defined at startup to also catch the dashboard)
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserIndentscopeDisable', { clear = true }),
    pattern = { 'help', 'mason', 'snacks_dashboard', 'snacks_notif', 'snacks_terminal', 'snacks_win' },
    callback = function(args)
        vim.b[args.buf].miniindentscope_disable = true
    end,
})

MiniMisc.safely('later', function()
    vim.pack.add({
        -- autocomplete (a release version downloads the pre-built fuzzy matcher binary)
        { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
        'https://github.com/rafamadriz/friendly-snippets',
        'https://github.com/fang2hou/blink-copilot',
        -- tmux panes transparent navigation (default keymaps <C-h/j/k/l/\>)
        'https://github.com/christoomey/vim-tmux-navigator',
    })

    --
    -- Completion
    --

    require('blink.cmp').setup({
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            menu = {
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
                'lazydev',
                'lsp',
                'path',
                'snippets',
                'buffer',
                'copilot'
            },
            providers = {
                -- lua completion for the nvim config (lazydev is set up in plugin/50_lsp.lua)
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
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
