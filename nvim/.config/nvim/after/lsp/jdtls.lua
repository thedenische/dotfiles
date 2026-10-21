local jdtls_path = vim.fn.expand('$MASON/packages/jdtls')

-- Unique workspace per project path (basename alone can collide)
local function get_workspace(root)
    local name = vim.fn.fnamemodify(root, ':p:h:t') .. '-' .. vim.fn.sha256(root):sub(1, 8)
    return vim.fn.stdpath('cache') .. '/jdtls/' .. name
end

-- jdtls itself requires Java 21+, so it runs on the newest installed JDK instead of the project one
-- (JAVA_HOME / PATH can point to an older JDK), JDTLS_JAVA_HOME overrides it
local function get_java()
    local home = os.getenv('JDTLS_JAVA_HOME')
    if home and home ~= '' then
        return home .. '/bin/java'
    end

    -- newest JDK installed by mise (versions like 'openjdk-27.0.0' or 'temurin-21.0.5+11')
    local mise = vim.fn.expand('~/.local/bin/mise')
    if vim.fn.executable(mise) == 1 then
        local result = vim.system({ mise, 'ls', '--installed', '--json', 'java' }, { text = true }):wait()
        local ok, installs = pcall(vim.json.decode, result.stdout or '')
        local newest, newest_path
        for _, install in ipairs(ok and type(installs) == 'table' and installs or {}) do
            local version = vim.version.parse((install.version or ''):match('(%d[%d%.]*)[^-]*$') or '', { strict = false })
            if version and version.major >= 21 and (not newest or vim.version.gt(version, newest)) then
                newest, newest_path = version, install.install_path
            end
        end
        if newest_path then
            return newest_path .. '/bin/java'
        end
    end

    -- newest JDK registered in macOS (Homebrew cask, vendor installers)
    if vim.fn.executable('/usr/libexec/java_home') == 1 then
        local result = vim.system({ '/usr/libexec/java_home', '-v', '21+' }, { text = true }):wait()
        if result.code == 0 and result.stdout ~= '' then
            return vim.trim(result.stdout) .. '/bin/java'
        end
    end

    return 'java'
end

local function get_extended_capabilities()
    local ok, jdtls = pcall(require, 'jdtls')
    return ok and jdtls.extendedClientCapabilities or nil
end

-- jdtls extensions for debugging (java-debug-adapter) and tests (java-test), installed via Mason
local function get_bundles()
    local packages = vim.fn.expand('$MASON/packages')
    local bundles = vim.fn.glob(packages .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar',
        true, true)
    local excluded = {
        ['com.microsoft.java.test.runner-jar-with-dependencies.jar'] = true,
        ['jacocoagent.jar'] = true,
    }
    for _, jar in ipairs(vim.fn.glob(packages .. '/java-test/extension/server/*.jar', true, true)) do
        if not excluded[vim.fn.fnamemodify(jar, ':t')] then
            table.insert(bundles, jar)
        end
    end
    return bundles
end

-- Run a main class without the debugger (fast start, breakpoints are ignored)
local function run_main()
    require('jdtls.dap').fetch_main_configs({ config_overrides = { noDebug = true } }, function(configs)
        vim.schedule(function()
            if #configs == 0 then
                vim.notify('No main class found', vim.log.levels.WARN)
                return
            end
            if #configs == 1 then
                require('dap').run(configs[1])
                return
            end
            vim.ui.select(configs, {
                prompt = 'Run main class',
                format_item = function(config) return config.name end,
            }, function(config)
                if config then
                    require('dap').run(config)
                end
            end)
        end)
    end)
end

-- Java specific keymaps (nvim-jdtls helpers)
-- extract / inline / organize imports are available via code actions (<leader>ca)
local function on_attach(_, bufnr)
    local jdtls = require('jdtls')

    -- register the java debug adapter, main classes are discovered on dap.continue()
    jdtls.setup_dap({ hotcodereplace = 'auto' })

    vim.keymap.set('n', '<leader>cju', jdtls.update_project_config,
        { buffer = bufnr, desc = '[C]ode [J]ava [U]pdate config' })
    vim.keymap.set('n', '<leader>dR', run_main, { buffer = bufnr, desc = '[D]ebug [R]un without debugger' })
end

---@type vim.lsp.Config
return {
    -- Mason's jdtls launcher script adds the launcher jar, OS config and standard JVM flags
    cmd = function(dispatchers, config)
        local root = config.root_dir or vim.fn.getcwd()
        return vim.lsp.rpc.start({
            'jdtls',
            '--java-executable', get_java(),
            '--jvm-arg=-Xmx2g',
            '--jvm-arg=-javaagent:' .. jdtls_path .. '/lombok.jar',
            '-data', get_workspace(root),
        }, dispatchers, { cwd = root })
    end,
    init_options = {
        extendedClientCapabilities = get_extended_capabilities(),
        bundles = get_bundles(),
    },
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            sources = {
                organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
            },
        },
    },
    on_attach = on_attach,
}
