return {
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
}
