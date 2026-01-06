-- Get the paths to the jdtls jar, operating specific configuration directory, and lombok jar
local function get_jdtls()
	-- Find the full path to the directory where Mason has downloaded the JDTLS binaries
	local jdtls_path = vim.fn.expand("$MASON/packages/jdtls")
	-- Obtain the path to the jar which runs the language server
	local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
	-- Declare white operating system we are using, windows use win, macos use mac
	local os
	if vim.fn.has("macunix") then
		os = "mac"
	elseif vim.fn.has("win32") then
		os = "win"
	else
		os = "linux"
	end
	-- Obtain the path to configuration files for your specific operating system
	local config = jdtls_path .. "/config_" .. os
	-- Obtain the path to the Lomboc jar
	local lombok = jdtls_path .. "/lombok.jar"
	return launcher, config, lombok
end

-- Get project workdir
local function get_workspace()
	-- Get the home directory of your operating system
	local home = os.getenv("HOME")
	-- Declare a directory where you would like to store project information
	local workspace_path = home .. "/code/workspace/"
	-- Determine the project name
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	-- Create the workspace directory by concatenating the designated workspace path and the project name
	local workspace_dir = workspace_path .. project_name
	return workspace_dir
end

-- Get command to run language server
local function get_cmd()
	local launcher, os_config, lombok = get_jdtls()
	local workspace_dir = get_workspace()

	local cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok,
		"-jar",
		launcher,
		"-configuration",
		os_config,
		"-data",
		workspace_dir,
	}
	return cmd
end

---@type vim.lsp.Config
return {
	cmd = get_cmd(),
}
