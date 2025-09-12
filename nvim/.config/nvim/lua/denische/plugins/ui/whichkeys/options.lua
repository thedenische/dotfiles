return {
    spec = {
        { '<leader>g', group = '[G]it', icon = { cat = "filetype", name = "git" } },
        { '<leader>gm', group = '[G]it [M]erge request' },
        { '<leader>f', group = '[F]ind', icon = { icon = " ", color = "green" } },
        { '<leader>l', group = '[L]sp', icon = { icon = " ", color = "orange" } },
        { '<leader>ld', group = '[L]sp [D]iagnostic', icon = { icon = "󱖫 ", color = "green" } },
        { '<leader>le', group = '[L]sp [E]xtract' },
        { '<leader>li', group = '[L]sp [I]nline' },
        { '<leader>d', group = '[D]ebug', icon = { icon = "󰃤 ", color = "red" } },
        { '<leader>t', group = '[T]est', icon = { cat = "filetype", name = "neotest-summary" } },
    }
}
