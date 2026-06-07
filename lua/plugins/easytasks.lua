require("easytasks").setup({
	log = {
		enabled = true,
		level = "debug",
	}
})
-- run / restart
vim.keymap.set("n", "<leader>lr", ":Easytasks run<CR>", { desc = "Run task", silent = true })
vim.keymap.set("n", "<leader>lR", ":Easytasks restart<CR>", { desc = "Repeat last task", silent = true })
-- status panel
vim.keymap.set("n", "<leader>lt", ":Easytasks toggle<CR>", { desc = "Toggle status panel", silent = true })
vim.keymap.set("n", "<leader>lp", ":Easytasks jump<CR>", { desc = "Jump to task", silent = true })
-- task control
vim.keymap.set("n", "<leader>lk", ":Easytasks stop<CR>", { desc = "Stop a task", silent = true })
vim.keymap.set("n", "<leader>lK", ":Easytasks stop_all<CR>", { desc = "Stop all tasks", silent = true })
vim.keymap.set("n", "<leader>lc", ":Easytasks clear<CR>", { desc = "Clear finished tasks", silent = true })
vim.keymap.set("n", "<leader>ld", ":Easytasks dispose<CR>", { desc = "Dispose a task", silent = true })
