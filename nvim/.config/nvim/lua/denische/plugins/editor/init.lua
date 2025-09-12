return {
    -- autocomplete
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = {
            'rafamadriz/friendly-snippets',
            'fang2hou/blink-copilot',
            'onsails/lspkind.nvim'
        },
        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = require('denische.plugins.editor.cmp.options'),
        opts_extend = { 'sources.default' }
    },
    -- blocks folding
    {
        'kevinhwang91/nvim-ufo',
        -- lazy = true,
        config = function()
            require('denische.plugins.editor.ufo.config')
        end,
        dependencies = {
            'kevinhwang91/promise-async'
        }
    }
}
