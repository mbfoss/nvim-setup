
local bookmarks = require("keystone.bookmarks")
bookmarks.setup()

vim.keymap.set("n", "<leader>mm", "<cmd>Bookmark<cr>", { desc = "Set named bookmark" })
vim.keymap.set("n", "<leader>mM", "<cmd>Bookmark setlabel<cr>", { desc = "Set named bookmark" })
vim.keymap.set("n", "<leader>md", "<cmd>Bookmark delete<cr>", { desc = "Bookmark" })
vim.keymap.set("n", "<leader>ml", "<cmd>Bookmark list<cr>", { desc = "Bookmark list" })
vim.keymap.set("n", "<leader>fm", "<cmd>Bookmark pick<cr>", { desc = "Pick a bookmark" })
