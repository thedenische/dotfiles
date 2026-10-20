return {
    spec = {
        { '<leader>g', group = '[G]it', icon = { cat = "filetype", name = "git" } },
        { '<leader>gm', group = '[G]it [M]erge request' },
        { '<leader>gh', group = '[G]it [H]unk' },
        { '<leader>gt', group = '[G]it [T]oggle' },
        { '<leader>s', group = '[S]earch', icon = { icon = " ", color = "blue" } },
        { '<leader>u', group = '[U]I' },
        { '<leader>a', group = '[A]I', icon = { icon = " ", color = "purple" } },
        { '<leader>f', group = '[F]ind', icon = { icon = " ", color = "green" } },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' }, icon = { icon = " ", color = "orange" } },
        { '<leader>cj', group = '[C]ode [J]ava' },
        { '<leader>b', group = '[B]uffer', expand = function() return require('which-key.extras').expand.buf() end },
        { '<leader>w', group = '[W]indow', proxy = '<c-w>', expand = function() return require('which-key.extras').expand.win() end },
        { '<leader>x', group = 'Lists (quickfix / location)' },
        { '<leader>d', group = '[D]ebug', icon = { icon = "󰃤 ", color = "red" } },
        { '<leader>t', group = '[T]est', icon = { cat = "filetype", name = "neotest-summary" } },
    }
}
