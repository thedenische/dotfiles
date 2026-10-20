local function set_highlights()
    vim.api.nvim_set_hl(0, 'BlinkCmpKindCopilot', { fg = '#6CC644' })
end

return function(_, opts)
    set_highlights()
    -- colorschemes reset highlights, so re-apply after every switch
    vim.api.nvim_create_autocmd('ColorScheme', { callback = set_highlights })

    require('blink.cmp').setup(opts)
end
