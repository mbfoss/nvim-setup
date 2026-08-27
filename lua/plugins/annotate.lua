require("annotate").setup({
	virt_text_pos = "eol", -- or "right_align", "inline", ...
	auto_save     = true, -- write the store as notes change
	root          = nil, -- function returning the project root
	storage_file  = nil, -- path, or a function returning one;
	-- defaults to stdpath("data")/annotate.json
})
vim.keymap.set("n", "<leader>nn", "<cmd>Annotate set<cr>", { desc = "set annotation" })
vim.keymap.set("n", "<leader>nd", "<cmd>Annotate delete<cr>", { desc = "delete annotation" })
vim.keymap.set("n", "<leader>nl", "<cmd>Annotate list<cr>", { desc = "List annotations" })

