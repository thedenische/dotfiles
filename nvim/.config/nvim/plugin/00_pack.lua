-- vim.pack build steps, run after a plugin is installed or updated
-- (defined before the first vim.pack.add() so they also run for installs from nvim-pack-lock.json)
local builds = {
    ['nvim-treesitter'] = function() vim.cmd('TSUpdate') end,
    ['gitlab.nvim'] = function() require('gitlab.server').build(true) end,
    ['mcphub.nvim'] = function(path) dofile(path .. '/bundled_build.lua') end,
}

-- wait until startup is done, so all plugins are added by vim.pack.add()
local function after_startup(fn)
    if vim.v.vim_did_enter == 1 then
        vim.schedule(fn)
    else
        vim.api.nvim_create_autocmd('VimEnter', { once = true, callback = fn })
    end
end

vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('UserPackBuild', { clear = true }),
    callback = function(ev)
        local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path
        local build = builds[name]
        if not build or (kind ~= 'install' and kind ~= 'update') then
            return
        end
        after_startup(function()
            if not vim.pack.get({ name }, { info = false })[1].active then
                vim.cmd.packadd(name)
            end
            build(path)
        end)
    end,
})
