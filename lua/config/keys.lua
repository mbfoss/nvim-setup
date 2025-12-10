local map = vim.keymap.set


local function toggle_loclist()
	local loclist_open = false
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.loclist == 1 then
			loclist_open = true
			vim.cmd("lclose")
			break
		end
	end
	if not loclist_open then
		vim.cmd("lopen")
	end
end

local function toggle_qflist()
	local qflist_open = false
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			qflist_open = true
			vim.cmd("cclose")
			break
		end
	end
	if not qflist_open then
		vim.cmd("copen")
	end
end

-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
	"FileType", {
		pattern = { "qf" },
		command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
	})
vim.keymap.set('x', 'p', '"_dP', { noremap = true, silent = true })

-- Save with Ctrl+S
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', function()
	-- If in insert mode, save and return to insert
	if vim.api.nvim_get_mode().mode == 'i' then
		vim.cmd('stopinsert')
		vim.cmd('write')
		vim.cmd('startinsert')
	else
		vim.cmd('write')
	end
end, { desc = 'Save file' })

map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map('i', '<C-Space>', '<C-x><C-o>', { noremap = true })
map('n', '<C-Space>', 'a<C-x><C-o>', { noremap = true })

map({ "n", "v" }, "gx", "<cmd>!open <cfile><cr><cr>", { noremap = true, desc = "Open file under cursor" })

-- Visual mode: move selection down/up
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Normal mode: move current line down/up
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })


map("n", "[c", "[c", { desc = "Previous diff" })
map("n", "]c", "]c", { desc = "Next diff", })

-- git signs
map("n", "<leader>gB", "<cmd>Gitsigns blame<cr>", { desc = "Git blame" })

-- Buffer

map("n", "<leader>bl", "<cmd>ls<cr>", { desc = "List Buffers" })
map("n", "<leader>bd", function() require("mini.bufremove").delete(0, false) end, { desc = "Delete Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bw", "<cmd>w<cr>", { desc = "Save Buffer" })
map("n", "<leader>ba", "<cmd>bufdo bd<cr>", { desc = "Close All Buffers" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Close Other Buffers" }) -- keep current, close others
map("n", "<leader>bb", "<cmd>e#<cr>", { desc = "Switch to Alternate Buffer" })
map("n", "<leader>br", "<cmd>edit!<cr>", { desc = "Revert Buffer" })
map("n", "<leader>bs", "<cmd>split<cr>", { desc = "Split Buffer Horizontally" })
map("n", "<leader>bv", "<cmd>vsplit<cr>", { desc = "Split Buffer Vertically" })
map("n", "<leader>bf", "<cmd>file<cr>", { desc = "Show Buffer File Info" })
map("n", "<leader>bh", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })

-- windows

map("n", "<leader>wh", "<cmd>wincmd h<cr>", { desc = "Move to left window", noremap = true, silent = true })
map("n", "<leader>wj", "<cmd>wincmd j<cr>", { desc = "Move to below window", noremap = true, silent = true })
map("n", "<leader>wk", "<cmd>wincmd k<cr>", { desc = "Move to above window", noremap = true, silent = true })
map("n", "<leader>wl", "<cmd>wincmd l<cr>", { desc = "Move to right window", noremap = true, silent = true })
map("n", "<leader>ws", "<cmd>wincmd s<cr>", { desc = "Split window horizontally", noremap = true, silent = true })
map("n", "<leader>wv", "<cmd>wincmd v<cr>", { desc = "Split window vertically", noremap = true, silent = true })
map("n", "<leader>wq", "<cmd>wincmd q<cr>", { desc = "Close current window", noremap = true, silent = true })
map("n", "<leader>wo", "<cmd>wincmd o<cr>", { desc = "Close other windows", noremap = true, silent = true })
map("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Make windows equal size", noremap = true, silent = true })
map("n", "<leader>w_", "<cmd>wincmd _<cr>", { desc = "Maximize window height", noremap = true, silent = true })
map("n", "<leader>w|", "<cmd>wincmd |<cr>", { desc = "Maximize window width", noremap = true, silent = true })
map("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "Rotate windows", noremap = true, silent = true })
map("n", "<leader>wR", "<cmd>wincmd R<cr>", { desc = "Rotate windows opposite", noremap = true, silent = true })
map("n", "<leader>wx", "<cmd>wincmd x<cr>", { desc = "Swap current and next window", noremap = true, silent = true })
map("n", "<leader>wt", function() require('mbo.term').toggle_window() end,
	{ desc = "Toggle terminal window", noremap = true, silent = true })
map("n", "<leader>we", function() require('mbo.tasks-term').toggle_window() end,
	{ desc = "Toggle tasks window", noremap = true, silent = true })

--  others
map("n", "<leader>ol", toggle_loclist, { desc = "Toggle location list" })
map("n", "<leader>oq", toggle_qflist, { desc = "Toggle quickfix list" })
map("n", "<leader>n", "<cmd>lua MiniNotify.show_history()<cr>", { desc = "Notification History" })

vim.keymap.set('n', 'ga', '<C-^>', { noremap = true, silent = true, desc = 'Go to alternate buffer' })
vim.keymap.set("n", "<leader>s", [[:%s/\V<C-r><C-w>//gc<Left><Left><Left>]], { desc = "Substitute word (literal)" })

vim.keymap.set('n', '<leader>dl', function()
	vim.notify("starting luapanda listen")
	local LuaPanda = require("LuaPanda")
	LuaPanda.start("127.0.0.1", 8818)
end, { noremap = true, desc = "LuaPanda listen" })


vim.keymap.set('n', '<leader>dL', function()
	vim.notify("starting OSV listen")
	local osv = require("osv")
	osv.launch({ port = 8086 })
end, { noremap = true, desc = "OSV listen" })



vim.keymap.set("n", "<leader>dm",  ":Loop debug_mode<CR>", {desc = "Toggle debug mode"})
vim.keymap.set("n", "<leader>db",  ":Loop breakpoint<CR>", {desc = "Toggle breakpoint"})
vim.keymap.set("n", "<leader>dc",  ":Loop debug continue<CR>", {desc = "Debug continue", silent = true})
vim.keymap.set("n", "<leader>dT",  ":Loop debug terminate<CR>", {desc = "Debug terminate session", silent = true})
vim.keymap.set("n", "<leader>ts", ":Loop task<CR>", {desc = "Run task", silent = true})
vim.keymap.set("n", "<leader>tr", ":Loop task repeat<CR>", {desc = "Repeat last task", silent = true})

