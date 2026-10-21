-- vim.pack build steps, run after a plugin is installed or updated
-- (defined before the first vim.pack.add() so they also run for installs from nvim-pack-lock.json)
local builds = {
    ['nvim-treesitter'] = function() vim.cmd('TSUpdate') end,
    ['gitlab.nvim'] = function() require('gitlab.server').build(true) end,
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

--
-- Lazy loading with mini.misc: MiniMisc.safely('later', f) after the first screen is drawn,
-- MiniMisc.safely('event:InsertEnter', f) once on an event (errors inside are shown as warnings)
--

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
require('mini.misc').setup()

-- icons (used by snacks, which-key, ...), plugins requiring nvim-web-devicons get mini.icons instead
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

_G.Config = {}

-- once, on first use: a keymap set by the returned `map` (vim.keymap.set with a function rhs)
-- or an undefined command matching one of `cmds` (patterns of the commands that `setup` creates)
-- if `setup` fails, it is retried on the next use
Config.on_demand = function(setup, cmds)
    local loaded = false
    local function load()
        if not loaded then
            setup()
            loaded = true
        end
    end
    if cmds then
        MiniMisc.safely('event:CmdUndefined~' .. table.concat(cmds, ','), load)
    end
    return function(mode, lhs, rhs, opts)
        vim.keymap.set(mode, lhs, function()
            load()
            return rhs()
        end, opts)
    end
end
