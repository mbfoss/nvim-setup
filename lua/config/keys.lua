local map = vim.keymap.set

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

-- -- close quickfix menu after selecting choice
-- vim.api.nvim_create_autocmd(
-- 	"FileType", {
-- 		pattern = { "qf" },
-- 		command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
-- 	})

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

-- vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { noremap = true })
-- vim.keymap.set('n', '<C-Space>', 'a<C-x><C-o>', { noremap = true })
--
vim.keymap.set({ "n", "v" }, "gx", "<cmd>!open <cfile><cr><cr>", { noremap = true, desc = "Open file under cursor" })

-- Visual mode: move selection down/up
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Normal mode: move current line down/up
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })


vim.keymap.set("n", "[c", "[c", { desc = "Previous diff" })
vim.keymap.set("n", "]c", "]c", { desc = "Next diff" })

-- git signs
vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns blame<cr>", { desc = "Git Blame" })
vim.keymap.set("n", "<leader>e", "<cmd>FileSelector<cr>", { desc = "File Selector" })
vim.keymap.set("n", "<leader>E", "<cmd>FileTree<cr>", { desc = "File Tree" })

-- Buffer

vim.keymap.set("n", "<leader>Bl", "<cmd>ls<cr>", { desc = "List Buffers" })
vim.keymap.set("n", "<leader>Bd", function() require("mini.bufremove").delete(0, false) end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>Bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>Bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>Bw", "<cmd>w<cr>", { desc = "Save Buffer" })
vim.keymap.set("n", "<leader>Ba", "<cmd>bufdo bd<cr>", { desc = "Close All Buffers" })
vim.keymap.set("n", "<leader>Bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Close Other Buffers" }) -- keep current, close others
vim.keymap.set("n", "<leader>Bb", "<cmd>e#<cr>", { desc = "Switch to Alternate Buffer" })
vim.keymap.set("n", "<leader>Br", "<cmd>edit!<cr>", { desc = "Revert Buffer" })
vim.keymap.set("n", "<leader>Bs", "<cmd>split<cr>", { desc = "Split Buffer Horizontally" })
vim.keymap.set("n", "<leader>Bv", "<cmd>vsplit<cr>", { desc = "Split Buffer Vertically" })
vim.keymap.set("n", "<leader>Bf", "<cmd>file<cr>", { desc = "Show Buffer File Info" })
vim.keymap.set("n", "<leader>Bh", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })

vim.keymap.set("n", "<leader>+", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("Copied path: " .. path)
end, { desc = "Copy path to clipboard" })

-- windows

vim.keymap.set("n", "<leader>wh", "<cmd>wincmd h<cr>", { desc = "Move to left window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wj", "<cmd>wincmd j<cr>", { desc = "Move to below window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wk", "<cmd>wincmd k<cr>", { desc = "Move to above window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wl", "<cmd>wincmd l<cr>", { desc = "Move to right window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ws", "<cmd>wincmd s<cr>",
	{ desc = "Split window horizontally", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wv", "<cmd>wincmd v<cr>",
	{ desc = "Split window vertically", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wq", "<cmd>wincmd q<cr>", { desc = "Close current window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wo", "<cmd>wincmd o<cr>", { desc = "Close other windows", noremap = true, silent = true })
vim.keymap.set("n", "<leader>w=", "<cmd>wincmd =<cr>",
	{ desc = "Make windows equal size", noremap = true, silent = true })
vim.keymap.set("n", "<leader>w_", "<cmd>wincmd _<cr>", { desc = "Maximize window height", noremap = true, silent = true })
vim.keymap.set("n", "<leader>w|", "<cmd>wincmd |<cr>", { desc = "Maximize window width", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "Rotate windows", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wR", "<cmd>wincmd R<cr>",
	{ desc = "Rotate windows opposite", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wx", "<cmd>wincmd x<cr>",
	{ desc = "Swap current and next window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>wf", toggle_qflist, { desc = "Toggle quickfix list", noremap = true, silent = true })

vim.keymap.set('n', 'ga', '<C-^>', { noremap = true, silent = true, desc = 'Go to alternate buffer' })

vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\V<C-r>=escape(expand('<cword>'), '/\')<CR>//gc<Left><Left><Left>]],
  { desc = "Substitute word (literal)" }
)

vim.keymap.set(
  "v",
  "<leader>s",
  [[y:%s/\V<C-r>=escape(getreg('"'), '/\')<CR>//gc<Left><Left><Left>]],
  { desc = "Substitute selection" }
)

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
	osv.launch({ host = "127.0.0.1", port = 8086 })
end, { noremap = true, desc = "OSV listen" })


vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set("t", "<M-`>", function() vim.api.nvim_chan_send(vim.b.terminal_job_id, "\x1b") end,
	{ desc = "send Esc to terminal", noremap = true, silent = true })


-- lsp keys
vim.keymap.set({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>cD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
vim.keymap.set("n", "<leader>ci", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, { desc = "Show references" })
vim.keymap.set("n", "<leader>ch", function() vim.lsp.buf.hover() end, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>cs", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })
vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, { desc = "Format code" })
vim.keymap.set("n", "<leader>ct", function() vim.lsp.buf.type_definition() end, { desc = "Go to type definition" })
vim.keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>cH", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
	{ desc = "Toggle inlay hints" })
vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end,
	{ desc = "Diagnostics: Show line diagnostics" })

vim.keymap.set("n", "<leader>cc", ":CallTree<CR>", { desc = "Show call tree" })

do
	local function toggle_virtual_text()
		local current = vim.diagnostic.config().virtual_text
		vim.diagnostic.config({ virtual_text = not current })
	end
	vim.keymap.set("n", "<leader>ct", toggle_virtual_text, { desc = "Diagnostics: Toggle virtual text" })
end



-- Jump to next/previous function using built-in LSP
local function jump_func_lsp(next_func)
	local params = { textDocument = vim.lsp.util.make_text_document_params() }

	vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, function(err, result, _)
		if err or not result then return end

		local function flatten_symbols(symbols, acc)
			acc = acc or {}
			for _, sym in ipairs(symbols) do
				-- Check for Function, Method, or Constructor
				if sym.kind == 12 or sym.kind == 6 or sym.kind == 9 then
					table.insert(acc, sym)
				end
				if sym.children then flatten_symbols(sym.children, acc) end
			end
			return acc
		end

		local symbols = flatten_symbols(result)
		if #symbols == 0 then return end

		local cur_line = vim.api.nvim_win_get_cursor(0)[1] - 1

		-- Ensure symbols are sorted by their starting position
		table.sort(symbols, function(a, b)
			return a.range.start.line < b.range.start.line
		end)

		local target = nil

		if next_func then
			for _, sym in ipairs(symbols) do
				-- Jump to the next function that starts AFTER the current line
				if sym.range.start.line > cur_line then
					target = sym
					break
				end
			end
		else
			-- Iterate backwards to find the closest function above
			for i = #symbols, 1, -1 do
				local sym = symbols[i]
				-- If we are INSIDE a function, we want to jump to its start.
				-- If we are already AT the start, we want the previous one.
				if sym.range.start.line < cur_line then
					target = sym
					break
				end
			end
		end

		if target then
			vim.api.nvim_win_set_cursor(0, { target.range.start.line + 1, target.range.start.character })
		end
	end)
end


-- Keymaps
vim.keymap.set('n', ']]', function() jump_func_lsp(true) end, { desc = 'Next function (LSP)' })
vim.keymap.set('n', '[[', function() jump_func_lsp(false) end, { desc = 'Previous function (LSP)' })

vim.keymap.set('n', ']w', ":lnext<CR>", { desc = 'Next loclist item', silent = true })
vim.keymap.set('n', '[w', ":lprev<CR>", { desc = 'Previous loclist item', silent = true })
