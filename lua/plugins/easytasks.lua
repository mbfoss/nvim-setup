require("easytasks").setup({
})
-- run / restart
vim.keymap.set("n", "<leader>lr", ":Task run<CR>", { desc = "Run task", silent = true })
vim.keymap.set("n", "<leader>lR", ":Task rerun<CR>", { desc = "Repeat last task", silent = true })
-- status panel
vim.keymap.set("n", "<leader>lt", ":Task panel<CR>", { desc = "Toggle status panel", silent = true })
vim.keymap.set("n", "<leader>lp", function()
	vim.cmd(vim.v.count1 .. "Task panel jump")
end, { desc = "Jump to task tab N (count)", silent = true })
vim.keymap.set("n", "<leader>lc", ":Task panel clear<CR>", { desc = "Clear finished tasks", silent = true })
vim.keymap.set("n", "<leader>ld", ":Task panel remove<CR>", { desc = "Remove one finishted task", silent = true })
-- task control
vim.keymap.set("n", "<leader>lk", ":Task stop<CR>", { desc = "Stop a task", silent = true })
vim.keymap.set("n", "<leader>lK", ":Task stop_all<CR>", { desc = "Stop all tasks", silent = true })

require("easytasks").register_expression("add", function(_, a, b) return tonumber(a) + tonumber(b) end, {desc = "add 2 numbers"})
