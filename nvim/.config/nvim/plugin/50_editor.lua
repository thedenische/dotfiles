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
        -- treesitter queries for functions, classes, parameters, ... (motions below and mini.ai)
        { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
        -- auto close and rename html / jsx / xml tags
        'https://github.com/windwp/nvim-ts-autotag',
        -- highlight and search TODO / FIX / HACK / NOTE comments
        'https://github.com/folke/todo-comments.nvim',
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

    --
    -- Text objects (e.g. daf, cia, vic, yag)
    --

    local ai = require('mini.ai')
    ai.setup({
        n_lines = 500,
        custom_textobjects = {
            o = ai.gen_spec.treesitter({ -- code block
                a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                i = { '@block.inner', '@conditional.inner', '@loop.inner' },
            }),
            f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
            c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),       -- class
            d = { '%f[%d]%d+' },                                                          -- digits
            e = {                                                                         -- word part of camelCase / snake_case
                { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
                '^().*()$',
            },
            g = require('mini.extra').gen_ai_spec.buffer(),                               -- whole buffer
            u = ai.gen_spec.function_call(),                                              -- function call (usage)
            U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }),                    -- function call without dot
        },
        -- keep the built-in treesitter selection an / in (and al / il in Neovim 0.13), see :h MiniAi-default-an-in
        mappings = {
            around_next = 'aN',
            inside_next = 'iN',
            around_last = 'aL',
            inside_last = 'iL',
        },
    })

    -- treesitter motions, only in buffers with textobjects queries (]c / [c still jump between changes in diff windows)
    local moves = {
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
        goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
        goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
    }
    local names = { ['@function.outer'] = 'function', ['@class.outer'] = 'class', ['@parameter.inner'] = 'parameter' }

    local function map_moves(buf)
        local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        local ok, query = pcall(vim.treesitter.query.get, lang or '', 'textobjects')
        if not ok or not query then
            return
        end
        for method, keys in pairs(moves) do
            for lhs, capture in pairs(keys) do
                local desc = (lhs:sub(1, 1) == ']' and 'Next ' or 'Previous ') .. names[capture]
                    .. (method:find('end') and ' end' or ' start')
                vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
                    if vim.wo.diff and lhs:find('[cC]') then
                        return vim.cmd.normal({ lhs, bang = true })
                    end
                    require('nvim-treesitter-textobjects.move')[method](capture, 'textobjects')
                end, { buffer = buf, desc = desc, silent = true })
            end
        end
    end

    vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('UserTextobjectsMove', { clear = true }),
        callback = function(args) map_moves(args.buf) end,
    })
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            map_moves(buf)
        end
    end

    --
    -- Tags
    --

    require('nvim-ts-autotag').setup()

    --
    -- TODO comments
    --

    require('todo-comments').setup()

    local map = vim.keymap.set
    map('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })
    map('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })
    map('n', '<leader>st', function() Snacks.picker.todo_comments() end, { desc = 'Search Todo comments' })
    map('n', '<leader>sT', function() Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end,
        { desc = 'Search Todo / fix comments' })
end)
