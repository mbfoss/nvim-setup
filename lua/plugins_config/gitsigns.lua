local fillchars = vim.opt.fillchars
require("gitsigns").setup({})
vim.opt.fillchars = fillchars

vim.keymap.set("n", "]h", function()
	require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })


vim.keymap.set("n", "[h", function()
	require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
