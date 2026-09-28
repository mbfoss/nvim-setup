vim.keymap.set("n", "<leader>lp", function()
	vim.cmd("Dock jump " .. vim.v.count1)
end, { desc = "Jump to dock tab N (count)", silent = true })
