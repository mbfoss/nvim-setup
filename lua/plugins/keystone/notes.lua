
local notes = require("keystone.notes")
notes.setup()

vim.keymap.set("n", "<leader>nn", "<cmd>Note <cr>", { desc = "add" })
vim.keymap.set("n", "<leader>md", "<cmd>Note delete<cr>", { desc = "Note" })
vim.keymap.set("n", "<leader>ml", "<cmd>Note list<cr>", { desc = "Note list" })
vim.keymap.set("n", "<leader>fm", "<cmd>Note pick<cr>", { desc = "Pick a bookmark" })
