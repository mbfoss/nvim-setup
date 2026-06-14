
local bookmarks = require("keystone.bookmarks")
bookmarks.setup()

vim.keymap.set("n", "<leader>mm", "<cmd>Bookmark<cr>", { desc = "Set named bookmark" })
vim.keymap.set("n", "<leader>ml", "<cmd>Bookmark list<cr>", { desc = "List named bookmarks" })
vim.keymap.set("n", "<leader>md", "<cmd>Bookmark delete<cr>", { desc = "Delete named bookmarks" })
