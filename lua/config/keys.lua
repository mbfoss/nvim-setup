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

local opts = { noremap = true, silent = true }
-- Navigate windows using Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

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
map("n", "<leader>we", function() require('mbo.tasks-term').toggle_window() end, { desc = "Toggle tasks window", noremap = true, silent = true })
--  others
map("n", "<leader>ol", toggle_loclist, { desc = "Toggle location list" })
map("n", "<leader>oq", toggle_qflist, { desc = "Toggle quickfix list" })
map("n", "<leader>n", "<cmd>lua MiniNotify.show_history()<cr>", { desc = "Notification History" })

vim.keymap.set('n', 'ga', '<C-^>', { noremap = true, silent = true, desc = 'Go to alternate buffer' })
vim.keymap.set("n", "<leader>s", [[:.,%s/\V<C-r><C-w>//gc<Left><Left><Left>]], { desc = "Substitute word (literal)" })

vim.keymap.set('n', '<leader>dL', function()
	vim.notify("starting luapanda listen")
	package.path = package.path .. ";" .. vim.env.HOME .. "/.luarocks/share/lua/5.4/?.lua"
	package.cpath = package.cpath .. ";" .. vim.env.HOME .. "/.luarocks/lib/lua/5.1/socket/core.so"
	local LuaPanda = require("LuaPanda")
	LuaPanda.start("127.0.0.1", 8818)
end, { noremap = true, desc = "LuaPanda listen" })


vim.keymap.set('n', '<leader>dO', function()
	vim.notify("starting OSV listen")
	local osv = require("osv")
	osv.launch({ port = 8086 })
end, { noremap = true, desc = "OSV listen" })


map("n", "<leader>dv", function()
	vim.cmd("vsplit")
	vim.cmd("vertical resize " .. math.floor(vim.o.columns / 3))
	vim.cmd("Loop open_page Variables")
end)

vim.keymap.set("n", "<leader>ll", ":Loop<CR>", { desc = "Select command", silent = true })
vim.keymap.set("n", "<leader>lt", ":Loop toggle<CR>", { desc = "Toggle tasks window", silent = true })
vim.keymap.set("n", "<leader>lp", ":Loop page switch<CR>", { desc = "Switch main page", silent = true })
vim.keymap.set("n", "<leader>lP", ":Loop page open<CR>", { desc = "Open page", silent = true })
vim.keymap.set("n", "<leader>lr", ":Loop task<CR>", { desc = "Run task", silent = true })
vim.keymap.set("n", "<leader>lR", ":Loop task repeat<CR>", { desc = "Repeat task", silent = true })

vim.keymap.set("n", "<leader>ms", ":Loop mark set<CR>", { desc = "Set bookmark", silent = true })
vim.keymap.set("n", "<leader>mn", ":Loop mark name<CR>", { desc = "Set named bookmark", silent = true })
vim.keymap.set("n", "<leader>mr", ":Loop mark remove<CR>", { desc = "Remove bookmark", silent = true })
vim.keymap.set("n", "<leader>mm", ":Loop mark list <CR>", { desc = "Bookmarks list", silent = true })
vim.keymap.set("n", "<leader>ns", ":Loop note set<CR>", { desc = "Set note", silent = true })
vim.keymap.set("n", "<leader>nr", ":Loop note remove<CR>", { desc = "Remove note", silent = true })
vim.keymap.set("n", "<leader>nn", ":Loop note list <CR>", { desc = "Notes list", silent = true })
vim.keymap.set("v", "<leader>d", "", { desc = "Debug menu§", silent = true })         -- to avoid deleting text by accident
vim.keymap.set("n", "<leader>dd", ":Loop debug <CR>", { desc = "Select LoopDebug command", silent = true })
vim.keymap.set("n", "<leader>du", ":Loop debug ui<CR>", { desc = "Toggle UI", silent = true })
vim.keymap.set("n", "<leader>dbb", ":Loop debug breakpoint<CR>", { desc = "List breakpoints", silent = true })
vim.keymap.set("n", "<leader>dbs", ":Loop debug breakpoint toggle<CR>", { desc = "Toggle breakpoint", silent = true })
vim.keymap.set("n", "<leader>dbc", ":Loop debug breakpoint conditional<CR>", { desc = "Set conditional breakpoint", silent = true })
vim.keymap.set("n", "<leader>dbl", ":Loop debug breakpoint logpoint<CR>", { desc = "Set logpoint", silent = true })
vim.keymap.set("n", "<leader>dbt", ":Loop debug breakpoint toggle_enabled<CR>", { desc = "Enable/disable breakpoint", silent = true })
vim.keymap.set("n", "<leader>dbE", ":Loop debug breakpoint enable_all<CR>", { desc = "Enable all breakpoints", silent = true })
vim.keymap.set("n", "<leader>dbD", ":Loop debug breakpoint disable_all<CR>", { desc = "Disable all breakpoints", silent = true })
vim.keymap.set("n", "<leader>ds", ":Loop debug session<CR>", { desc = "Select debug session", silent = true })
vim.keymap.set("n", "<leader>dt", ":Loop debug thread<CR>", { desc = "Select thread", silent = true })
vim.keymap.set("n", "<leader>df", ":Loop debug frame<CR>", { desc = "Select stack frame", silent = true })
vim.keymap.set("n", "<leader>di", ":Loop debug inspect<CR>", { desc = "Inspect value", silent = true })
vim.keymap.set("v", "<leader>di", ":Loop debug inspect<CR>", { desc = "Inspect value", silent = true })
vim.keymap.set("n", "<leader>dp", ":Loop debug pause<CR>", { desc = "Pause execution", silent = true })
vim.keymap.set("n", "<leader>dl", ":Loop debug step_in<CR>", { desc = "Step into", silent = true })
vim.keymap.set("n", "<leader>dh", ":Loop debug step_out<CR>", { desc = "Step out", silent = true })
vim.keymap.set("n", "<leader>dj", ":Loop debug step_over<CR>", { desc = "Step over", silent = true })
vim.keymap.set("n", "<leader>dk", ":Loop debug step_back<CR>", { desc = "Step back", silent = true })
vim.keymap.set("n", "<leader>dc", ":Loop debug continue<CR>", { desc = "Continue execution", silent = true })
vim.keymap.set("n", "<leader>dC", ":Loop debug continue_all<CR>", { desc = "Continue debug", silent = true })
vim.keymap.set("n", "<leader>dk", ":Loop debug terminate<CR>", { desc = "Terminate debug", silent = true })
vim.keymap.set("n", "<leader>dK", ":Loop debug terminate_all<CR>", { desc = "Terminate debug", silent = true })
vim.keymap.set("n", "<A-l>", ":Loop debug step_in<CR>", { desc = "Step into", silent = true })
vim.keymap.set("n", "<A-h>", ":Loop debug step_out<CR>", { desc = "Step out", silent = true })
vim.keymap.set("n", "<A-j>", ":Loop debug step_over<CR>", { desc = "Step over", silent = true })
vim.keymap.set("n", "<A-k>", ":Loop debug step_back<CR>", { desc = "Step back", silent = true })
vim.keymap.set("n", "<A-;>", ":Loop debug continue_all<CR>", { desc = "Step back", silent = true })
vim.keymap.set("n", "<A-b>", ":Loop debug breakpoint toggle<CR>", { desc = "Toggle breakpoint", silent = true })
