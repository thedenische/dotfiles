-- vim.keymap.set("x", "<leader>lee", ":Refactor extract ")
-- vim.keymap.set("x", "<leader>leE", ":Refactor extract_to_file ")
--
-- vim.keymap.set("x", "<leader>lev", ":Refactor extract_var ")
--
-- vim.keymap.set("n", "<leader>leb", ":Refactor extract_block")
-- vim.keymap.set("n", "<leader>leB", ":Refactor extract_block_to_file")
--
-- vim.keymap.set({ "n", "x" }, "<leader>liv", ":Refactor inline_var")
-- vim.keymap.set("n", "<leader>lif", ":Refactor inline_func")

return {
    { "<leader>lee", "<cmd>Refactor extract<CR>",               mode = "x",          desc = "[L]sp [E]xtract [E]xpression" },
    { "<leader>leE", "<cmd>Refactor extract_to_file<CR>",       mode = "x",          desc = "[L]sp [E]xtract expression to file" },
    { "<leader>lev", "<cmd>Refactor extract_var<CR>",           mode = "x",          desc = "[L]sp [E]xtract [V]ariable" },
    { "<leader>leb", "<cmd>Refactor extract_block<CR>",         mode = "n",          desc = "[L]sp [E]xtract [B]lock" },
    { "<leader>leB", "<cmd>Refactor extract_block_to_file<CR>", mode = "n",          desc = "[L]sp [E]xtract block to file" },
    { "<leader>liv", "<cmd>Refactor inline_var<CR>",            mode = { "n", "x" }, desc = "[L]sp [I]nline [V]ariable" },
    { "<leader>lif", "<cmd>Refactor inline_func<CR>",           mode = "n",          desc = "[L]sp [I]nline [F]unction" },
}
