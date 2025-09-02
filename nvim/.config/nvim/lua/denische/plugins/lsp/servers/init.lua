function loadServers(root_mod_name)
    local servers = {}
    local root_mod_path = root_mod_name:gsub('%.', '/')
    local root_path = vim.fn.stdpath('config') .. '/lua/' .. root_mod_path

    local scan = vim.uv.fs_scandir(root_path)

    if not scan then
        vim.notify('Failed to scan directory for LSP servers: ' .. root_path, vim.log.levels.ERROR)
        return servers
    end

    while true do
        local name, t = vim.uv.fs_scandir_next(scan)

        if not name then
            break
        end

        if t == 'file' and name:match('%.lua$') and name ~= 'init.lua' then
            local module_name = name:sub(1, -5)
            local ok, mod = pcall(require, root_mod_name .. '.' .. module_name)
            if ok then
                servers[module_name] = type(mod) == 'table' and mod or {}
            end
        end
    end

    return servers
end

local root_mod_name = ...
return loadServers(root_mod_name)
