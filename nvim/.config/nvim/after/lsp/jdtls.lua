local jdtls_path = vim.fn.expand("$MASON/packages/jdtls")

-- Platform specific configuration directory shipped with jdtls
local function get_os_config()
    local machine = vim.uv.os_uname().machine
    local arm = machine == "arm64" or machine == "aarch64"
    local os_name
    if vim.fn.has("mac") == 1 then
        os_name = "mac"
    elseif vim.fn.has("win32") == 1 then
        os_name = "win"
    else
        os_name = "linux"
    end
    if arm and os_name ~= "win" then
        os_name = os_name .. "_arm"
    end
    return jdtls_path .. "/config_" .. os_name
end

local function get_launcher()
    local jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar", true, true)[1]
    assert(jar, "jdtls launcher jar not found, is jdtls installed via Mason?")
    return jar
end

-- Unique workspace per project path (basename alone can collide)
local function get_workspace(root)
    local name = vim.fn.fnamemodify(root, ":p:h:t") .. "-" .. vim.fn.sha256(root):sub(1, 8)
    return vim.fn.stdpath("cache") .. "/jdtls/" .. name
end

-- jdtls itself requires Java 21+, prefer an explicit JDK over the one in PATH
local function get_java()
    local home = os.getenv("JDTLS_JAVA_HOME") or os.getenv("JAVA_HOME")
    if home and home ~= "" then
        return home .. "/bin/java"
    end
    local mise = vim.fn.expand("~/.local/bin/mise")
    if vim.fn.executable(mise) == 1 then
        local result = vim.system({ mise, "where", "java" }, { text = true }):wait()
        if result.code == 0 and result.stdout ~= "" then
            return vim.trim(result.stdout) .. "/bin/java"
        end
    end
    return "java"
end

local function get_extended_capabilities()
    local ok, jdtls = pcall(require, "jdtls")
    return ok and jdtls.extendedClientCapabilities or nil
end

-- Java specific keymaps (nvim-jdtls helpers)
-- extract / inline / organize imports are available via code actions (<leader>ca)
local function on_attach(_, bufnr)
    local jdtls = require("jdtls")

    vim.keymap.set("n", "<leader>cju", jdtls.update_project_config, { buffer = bufnr, desc = "[C]ode [J]ava [U]pdate config" })
end

---@type vim.lsp.Config
return {
    cmd = function(dispatchers, config)
        local root = config.root_dir or vim.fn.getcwd()
        return vim.lsp.rpc.start({
            get_java(),
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Xms256m",
            "-Xmx2g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-javaagent:" .. jdtls_path .. "/lombok.jar",
            "-jar",
            get_launcher(),
            "-configuration",
            get_os_config(),
            "-data",
            get_workspace(root),
        }, dispatchers, { cwd = root })
    end,
    init_options = {
        extendedClientCapabilities = get_extended_capabilities(),
    },
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            sources = {
                organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
            },
        },
    },
    on_attach = on_attach,
}
