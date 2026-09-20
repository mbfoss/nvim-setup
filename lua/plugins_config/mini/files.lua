require("mini.files").setup({
	windows = {
		-- Limit how many directory columns (buffers) can be visible side by side
		max_number = 2, -- try 2 or 3
		width_focus = 50,
		width_preview = 100,
		preview = true,
	},
	mappings = {
		go_in_plus = '<CR>',
	}
})

-- Open mini.files rooted at current file's directory
vim.keymap.set("n", "<leader>e", function()
	local mf = require("mini.files")
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		mf.open(vim.uv.cwd()) -- if no file, use CWD
	else
		mf.open(file)
	end
	mf.reveal_cwd() -- center around that location
end, { silent = true, desc = "Open mini.files at current file" })


vim.keymap.set("n", "<leader>E", function()
	local mf = require("mini.files")
	mf.open('~')
	mf.reveal_cwd() -- center around that location
end, { silent = true, desc = "Open mini.files at the home directory" })
