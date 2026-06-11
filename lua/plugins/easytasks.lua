require("easytasks").setup({
	log = {
		enabled = true,
		level = "debug",
	}
})
-- run / restart
vim.keymap.set("n", "<leader>lr", ":Task run<CR>", { desc = "Run task", silent = true })
vim.keymap.set("n", "<leader>lR", ":Task restart<CR>", { desc = "Repeat last task", silent = true })
-- status panel
vim.keymap.set("n", "<leader>lt", ":Task panel<CR>", { desc = "Toggle status panel", silent = true })
vim.keymap.set("n", "<leader>lp", ":Task panel pick<CR>", { desc = "Jump to task/tab", silent = true })
-- task control
vim.keymap.set("n", "<leader>lk", ":Task stop<CR>", { desc = "Stop a task", silent = true })
vim.keymap.set("n", "<leader>lK", ":Task stop_all<CR>", { desc = "Stop all tasks", silent = true })
vim.keymap.set("n", "<leader>lc", ":Task clear<CR>", { desc = "Clear finished tasks", silent = true })
vim.keymap.set("n", "<leader>ld", ":Task dispose<CR>", { desc = "Dispose a task", silent = true })
