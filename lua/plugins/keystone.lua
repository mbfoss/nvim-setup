require("keystone").setup({
	-- Language support
	lspconfig  = true,
	tsconfig   = true,
	completion = true,

	-- Editor behaviour
	tweaks     = true,
	largefile  = true,
	marksigns  = true,
	animate    = true,

	-- Replaces something built in
	statusline = true,
	select     = true,
	notify     = true,
	clue       = true,

	-- Adds a command, does nothing until you run it
	filetree   = true,
	explore    = true,
	symboltree = true,
	calltree   = true,
	notes      = true,
	unsaved    = true,
	bufdelete  = true,
})

require("keystone.clue").add({
	{ "<leader>B",  group = "+Buffer",   mode = { "n" } },
	{ "<leader>c",  group = "+Code",     mode = { "n", "v" } },
	{ "<leader>f",  group = "+Find",     mode = { "n" } },
	{ "<leader>g",  group = "+Git",      mode = { "n" } },
	{ "<leader>d",  group = "+Debug",    mode = { "n" } },
	{ "<leader>o",  group = "+Others",   mode = { "n" } },
	{ "<leader>S",  group = "+Sessions", mode = { "n" } },
	{ "<leader>p",  group = "+Project",  mode = { "n" } },
	{ "<leader>pb", group = "+Build",    mode = { "n" } },
	{ "<leader>pr", group = "+Run",      mode = { "n" } },
})

vim.keymap.set("n", "<leader>nn", "<cmd>Note <cr>", { desc = "add" })
vim.keymap.set("n", "<leader>nd", "<cmd>Note delete<cr>", { desc = "Note" })
vim.keymap.set("n", "<leader>nl", "<cmd>Note list<cr>", { desc = "Note list" })
