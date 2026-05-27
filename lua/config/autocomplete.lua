vim.o.pumheight = 15
vim.o.complete = ".,w,b,u"
vim.o.completeopt = "menu,menuone,noselect,fuzzy"
vim.o.updatetime = 200

-- Helper: Convert keys to termcodes
local function feedkeys(key)
	return vim.api.nvim_replace_termcodes(key, true, true, true)
end

-- Tab: Strictly for Completion Menu navigation
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return feedkeys("<C-n>")
	else
		return feedkeys("<Tab>")
	end
end, { expr = true, silent = true })

-- S-Tab: Reverse navigation in Completion Menu
vim.keymap.set("i", "<S-Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return feedkeys("<C-p>")
	else
		return feedkeys("<S-Tab>")
	end
end, { expr = true, silent = true })

-- Enter: Confirm Completion OR Jump Snippet
vim.keymap.set("i", "<CR>", function()
	if vim.snippet and vim.snippet.active({ direction = 1 }) then
		-- If a snippet is active, jump to the next placeholder
		vim.schedule(function() vim.snippet.jump(1) end)
		return ''
	else
		-- Otherwise, just a regular carriage return
		return feedkeys("<CR>")
	end
end, { expr = true, silent = true })
