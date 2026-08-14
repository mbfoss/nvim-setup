-- general options

vim.o.shortmess = vim.o.shortmess .. "Ic"

vim.o.termguicolors = true  -- enable rgb colors

vim.o.cursorline = true     -- enable cursor line

vim.o.number = true         -- enable line number
vim.o.relativenumber = true -- and relative line number

vim.o.signcolumn = "yes:2"  -- always show sign column
vim.o.scroll = math.min(10, vim.api.nvim_win_get_height(0))
vim.o.scrolloff = 8

vim.o.list = true    -- use special characters to represent things like tabs or trailing spaces

vim.o.confirm = true -- show dialog for unsaved file(s) before quit
vim.o.updatetime = 3000

vim.o.ignorecase = true  -- case-insensitive search
vim.o.smartcase = true   -- , until search pattern contains upper case characters

vim.o.smartindent = true -- auto-indenting when starting a new line
vim.o.shiftround = true  -- round indent to multiple of 'shiftwidth'
vim.o.shiftwidth = 0     -- 0 to follow the 'tabstop' value
vim.o.tabstop = 4        -- tab width

vim.o.undofile = true    -- enable persistent undo
vim.o.undolevels = 10000 -- 10x more undo levels

vim.o.pumheight = 15
vim.o.complete = ".,w,b,u"
vim.o.completeopt = "menu,menuone,noselect,popup"

-- define <leader> and <localleader> keys
-- you should use `vim.keycode` to translate keycodes or pass raw keycode values like `" "` instead of just `"<space>"`
vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<cr>")

-- remove netrw banner for cleaner looking
vim.g.netrw_banner = 0

-- default netrw style
vim.g.netrw_list_style = 3

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

vim.o.splitright = true

vim.opt.listchars = { -- NOTE: using `vim.opt` instead of `vim.o` to pass rich object
	tab = "  ",
	trail = " ",
	extends = "»",
	precedes = "«",
}

vim.diagnostic.config({
	virtual_text = {
		prefix = '●', -- Customize symbol
		spacing = 2,
	},
	signs = false,
	underline = false,
	update_in_insert = false,
})

vim.opt.diffopt:append("linematch:60") -- second stage diff to align lines

vim.opt.spell = true
vim.opt.spelllang = { "en" }


vim.o.equalalways = false

vim.opt.fillchars = {
	diff = "╱",
	vert = "▏",
	eob = " ",
}

vim.o.winborder = 'rounded'
