-- All Mason packages are installed from here
-- LSP servers use lspconfig names, everything else uses Mason package names

-- condition that is true when all given executables are in the PATH
local function has(...)
    local executables = { ... }
    return function()
        for _, executable in ipairs(executables) do
            if vim.fn.executable(executable) ~= 1 then
                return false
            end
        end
        return true
    end
end

return {
    ensure_installed = {
        -- LSP servers
        { 'jdtls',                  condition = has('java') },                   -- java
        'lua_ls',                                                                -- lua (always needed for nvim config)
        { 'pyright',                condition = has('python3', 'node', 'npm') }, -- python (npm package)
        { 'ruff',                   condition = has('python3') },                -- python linting and formatting
        { 'yamlls',                 condition = has('node', 'npm') },            -- yaml (npm package)
        'lemminx',                                                               -- xml (standalone binary)
        { 'vtsls',                  condition = has('node', 'npm') },            -- type script (npm package)
        { 'docker_language_server', condition = has('docker') },                 -- docker
        'harper_ls',                                                             -- grammar checker

        -- Formatters (see conform)
        { 'prettier', condition = has('node', 'npm') },

        -- Java debug and test
        { 'java-debug-adapter', condition = has('java') },
        { 'java-test',          condition = has('java') },
    },
}
