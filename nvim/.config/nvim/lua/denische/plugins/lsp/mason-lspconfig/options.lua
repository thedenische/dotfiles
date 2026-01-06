-- config LSP Attach function
require("denische.plugins.lsp.mason-lspconfig.attach")

-- additional capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

vim.lsp.config("*", {
	capabilities = capabilities,
})

return {
	ensure_installed = {
		"jdtls",
		"lua_ls",
		"pyright",
		"ruff",
		"yamlls",
		"vtsls",
		"docker_language_server",
	},
}
