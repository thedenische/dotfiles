local servers = require('denische.plugins.lsp.servers')

return {
    ensure_installed = vim.tbl_keys(servers),
}
