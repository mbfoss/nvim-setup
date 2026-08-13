
local notes = require("keystone.notes")
notes.setup()

vim.keymap.set("n", "<leader>nn", "<cmd>Note <cr>", { desc = "add" })
vim.keymap.set("n", "<leader>nd", "<cmd>Note delete<cr>", { desc = "Note" })
vim.keymap.set("n", "<leader>nl", "<cmd>Note list<cr>", { desc = "Note list" })
