vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ds", "<Plug>(DBUI_ExecuteQuery)<CR>", {})
