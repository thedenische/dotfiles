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
        "jdtls",                  -- java
        "lua_ls",                 -- lua
        "pyright",                -- python
        "ruff",                   -- python linting and formatting
        "yamlls",                 -- yaml
        "vtsls",                  -- type script
        "docker_language_server", -- docker
        "harper_ls"               -- grammar checker
    },
}
