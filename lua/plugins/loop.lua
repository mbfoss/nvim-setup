local loop = require('loop')

require("loop").setup({
	macros = {
		add = function(_, value1, value2)
			local n1 = tonumber(value1) or 0
			local n2 = tonumber(value2) or 0
			return tostring(n1 + n2)
		end
	},
	use_fd_find = false,
})

vim.keymap.set("n", "<leader>ll", ":Loop<CR>", { desc = "Select command", silent = true })
vim.keymap.set("n", "<leader>lf", ":Loop workspace find_files<CR>", { desc = "Find files", silent = true })
vim.keymap.set("n", "<leader>lg", ":Loop workspace grep_files<CR>", { desc = "Grep files", silent = true })
vim.keymap.set("n", "<leader>lt", ":Loop statuspanel<CR>", { desc = "Toggle status panel", silent = true })
vim.keymap.set("n", "<leader>lp", ":Loop page switch<CR>", { desc = "Switch main page", silent = true })
vim.keymap.set("n", "<leader>lP", ":Loop page open<CR>", { desc = "Open page", silent = true })
vim.keymap.set("n", "<leader>lr", ":Loop task<CR>", { desc = "Run task", silent = true })
vim.keymap.set("n", "<leader>lR", ":Loop task repeat<CR>", { desc = "Repeat last task", silent = true })
vim.keymap.set("n", "<leader>lk", ":Loop task terminate<CR>", { desc = "Terminate a task", silent = true })
vim.keymap.set("n", "<leader>lK", ":Loop task terminate_all<CR>", { desc = "Terminate all tasks", silent = true })
vim.keymap.set("n", "<leader>lc", ":Loop statuspanel clean<CR>", { desc = "Cleanup status panel", silent = true })

vim.keymap.set("n", "<leader>mm", ":Loop mark set<CR>", { desc = "Set bookmark", silent = true })
vim.keymap.set("n", "<leader>mn", ":Loop mark name<CR>", { desc = "Set named bookmark", silent = true })
vim.keymap.set("n", "<leader>md", ":Loop mark delete<CR>", { desc = "Delete bookmark", silent = true })
vim.keymap.set("n", "<leader>ml", ":Loop mark list <CR>", { desc = "Bookmarks list", silent = true })
vim.keymap.set("n", "<leader>nn", ":Loop note set<CR>", { desc = "Set note", silent = true })
vim.keymap.set("n", "<leader>nd", ":Loop note delete<CR>", { desc = "Delete note", silent = true })
vim.keymap.set("n", "<leader>nl", ":Loop note list <CR>", { desc = "Notes list", silent = true })
