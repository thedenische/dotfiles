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
                color_correction = 'dynamic',
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
