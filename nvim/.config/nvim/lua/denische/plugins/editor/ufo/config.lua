-- folding settings
vim.o.foldcolumn     = '1' -- '0' is not bad
vim.o.foldlevel      = 99
vim.o.foldlevelstart = 99
vim.o.foldenable     = true
-- keymaps
require('denische.plugins.editor.ufo.keymaps')

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
})

vim.lsp.config("*", {
    capabilities = capabilities
})

require('ufo').setup()
