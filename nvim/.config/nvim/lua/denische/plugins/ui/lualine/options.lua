return {
    sections = {
        lualine_b = {
            'branch'
        },
        lualine_c = {
            {
                'filetype',
                icon_only = true,
                separator = '',
                padding = { left = 1, right = 0 }
            },
            {
                'filename',
                path = 1
            },
            {
                'navic',
                color_correction = 'dynamic', -- Can be nil, 'static' or 'dynamic'. This option is useful only when you have highlights enabled.
                navic_opts = nil              -- lua table with same format as setup's option. All options except 'lsp' options take effect when set here.
            }
        },
        lualine_x = {
            'macro_recording',
            'diff',
            'diagnostics',
            'copilot',
            'encoding',
        },
    }
}
