local normal_mode_keys = {
	{ key = "a A", desc = "append at cursor / line end" },
	{ key = "b B", desc = "back word / WORD" },
	{ key = "c C", desc = "change / to end of line" },
	{ key = "d D", desc = "delete / to end of line" },
	{ key = "e E", desc = "next word / WORD" },
	{ key = "f F", desc = "find char forward / backward" },
	{ key = "g G", desc = "prefix / go to bottom of file" },
	{ key = "g_", desc = "move to last non-blank character of line" },
	{ key = "gv", desc = "reselect last visual selection" },
	{ key = "h H", desc = "move left / to top of screen" },
	{ key = "i I", desc = "insert at cursor / line start" },
	{ key = "j J", desc = "move down / join lines" },
	{ key = "k K", desc = "move up / show keyword help" },
	{ key = "l L", desc = "move right / to bottom of screen" },
	{ key = "m M", desc = "set mark / move to middle of screen" },
	{ key = "n N", desc = "next / previous search match" },
	{ key = "o O", desc = "open line below / above" },
	{ key = "p P", desc = "paste after / before cursor" },
	{ key = "q Q", desc = "record macro / enter Ex mode" },
	{ key = "r R", desc = "replace one char / replace mode" },
	{ key = "s S", desc = "substitute char / entire line" },
	{ key = "t T", desc = "till char forward / backward" },
	{ key = "u U", desc = "undo / undo line changes" },
	{ key = "v V", desc = "visual char / line mode" },
	{ key = "w W", desc = "next word / WORD" },
	{ key = "x X", desc = "delete char / char before cursor" },
	{ key = "y Y", desc = "yank / yank entire line" },
	{ key = "z Z", desc = "view-related commands / quit" },
	{ key = "zz zt zb", desc = "center / top / bottom window line alignment" },
	{ key = "ZZ ZQ", desc = "save and quit / quit without saving" },
	{ key = "^ _ 0", desc = "move to line start (non-ws/oper/abs)" },
	{ key = "$", desc = "move to end of line" },
	{ key = "%", desc = "jump to matching (), {}, [] pairs" },
	{ key = "|", desc = "move to column N" },
	{ key = "+ -", desc = "next / previous line" },
	{ key = "[ ]", desc = "jump between sections" },
	{ key = "{ }", desc = "back / forward paragraph" },
	{ key = "` '", desc = "jump to mark / line mark" },
	{ key = "* #", desc = "search word forward / backward under cursor" },
	{ key = "/ ?", desc = "search forward / backward" },
	{ key = "; ,", desc = "repeat last f/F/t/T / reverse" },
	{ key = "&", desc = "repeat :s substitution" },
	{ key = ".", desc = "repeat last action" },
	{ key = '"', desc = 'select register (e.g. "ayy)' },
	{ key = ":", desc = "command mode" },
	{ key = "< >", desc = "shift left / right" },
	{ key = "=", desc = "auto-indent" },
	{ key = "@", desc = "play macro" },
	{ key = "~", desc = "swap case" },
	{ key = "<C-a>", desc = "increment number under cursor" },
	{ key = "<C-b>", desc = "scroll back one page" },
	{ key = "<C-c>", desc = "interrupt / cancel" },
	{ key = "<C-d>", desc = "scroll down half page" },
	{ key = "<C-e>", desc = "scroll window down" },
	{ key = "<C-f>", desc = "scroll forward one page" },
	{ key = "<C-g>", desc = "show file status" },
	{ key = "<C-h>", desc = "backspace (delete char before cursor)" },
	{ key = "<C-i>", desc = "tab / jump forward in jump list" },
	{ key = "<C-j>", desc = "newline in insert mode" },
	{ key = "<C-k>", desc = "delete to end of line" },
	{ key = "<C-l>", desc = "redraw screen" },
	{ key = "<C-m>", desc = "carriage return (Enter)" },
	{ key = "<C-n>", desc = "next line in completion" },
	{ key = "<C-o>", desc = "jump to older position" },
	{ key = "<C-p>", desc = "previous line in completion" },
	{ key = "<C-q>", desc = "quit (in some terminals)" },
	{ key = "<C-r>", desc = "redo" },
	{ key = "<C-s>", desc = "save (in some configs)" },
	{ key = "<C-t>", desc = "jump to tag" },
	{ key = "<C-u>", desc = "scroll up half page" },
	{ key = "<C-v>", desc = "visual block mode" },
	{ key = "<C-w>", desc = "window commands prefix" },
	{ key = "<C-x>", desc = "decrement number under cursor" },
	{ key = "<C-y>", desc = "scroll window up" },
	{ key = "<C-z>", desc = "suspend (background process)" },
}

local insert_mode_keys = {
	{ key = "<C-a>", desc = "line start" },
	{ key = "<C-h>", desc = "backspace" },
	{ key = "<C-j>", desc = "newline" },
	{ key = "<C-k>", desc = "digraph / delete to EOL" },
	{ key = "<C-l>", desc = "insert next char literally" },
	{ key = "<C-n>", desc = "next completion" },
	{ key = "<C-o>", desc = "run one Normal command" },
	{ key = "<C-p>", desc = "previous completion" },
	{ key = "<C-r>", desc = "insert register" },
	{ key = "<C-t>", desc = "insert indent" },
	{ key = "<C-u>", desc = "delete to line start" },
	{ key = "<C-v>", desc = "insert next char literally" },
	{ key = "<C-w>", desc = "delete previous word" },
	{ key = "<C-x>", desc = "completion prefix" },
	{ key = "<C-x><C-l>", desc = "line completion" },
	{ key = "<C-x><C-n>", desc = "buffer keyword completion" },
	{ key = "<C-x><C-p>", desc = "other buffers completion" },
	{ key = "<C-x><C-f>", desc = "file name completion" },
	{ key = "<C-x><C-o>", desc = "omni-completion" },
	{ key = "<C-x><C-u>", desc = "user-defined completion" },
	{ key = "<C-x><C-k>", desc = "dictionary completion" },
	{ key = "<C-x><C-t>", desc = "thesaurus completion" },
	{ key = "<C-x><C-i>", desc = "included file completion" },
	{ key = "<C-x><C-]>", desc = "tag completion" },
	{ key = "<C-x><C-d>", desc = "definition completion" },
	{ key = "<C-y>", desc = "insert char above" },
	{ key = "<C-z>", desc = "suspend Vim" },
}

local visual_mode_keys = {
	{ key = "v", desc = "exit visual mode / switch to charwise" },
	{ key = "V", desc = "switch to linewise visual mode" },
	{ key = "<C-v>", desc = "switch to blockwise visual mode" },
	{ key = "d / x", desc = "delete / cut selection" },
	{ key = "y", desc = "yank (copy) selection" },
	{ key = "c", desc = "change selection (delete and enter insert)" },
	{ key = "p", desc = "paste over selection (replaces content)" },
	{ key = "o", desc = "move cursor to other end of selection" },
	{ key = "O", desc = "move cursor to other corner (blockwise)" },
	{ key = "< >", desc = "shift selection left / right (drops out)" },
	{ key = "= ", desc = "auto-indent selection" },
	{ key = "~", desc = "toggle case of selection" },
	{ key = "u / U", desc = "convert selection to lower / uppercase" },
	{ key = "I / A", desc = "insert/append across block selection (blockwise)" },
	{ key = "aw / iw", desc = "select a word (around / inner)" },
	{ key = "aW / iW", desc = "select a WORD (around / inner)" },
	{ key = "ap / ip", desc = "select a paragraph (around / inner)" },
	{ key = "ab / ib", desc = "select bracketed block () (around / inner)" },
	{ key = "aB / iB", desc = "select braced block {} (around / inner)" },
	{ key = "at / it", desc = "select XML/HTML tag block (around / inner)" },
}

local cheat_bufnr = nil
local cheat_winid = nil

local function close_cheat_sheet()
	if cheat_winid and vim.api.nvim_win_is_valid(cheat_winid) then
		vim.api.nvim_win_close(cheat_winid, true)
	end
	cheat_winid = nil
	cheat_bufnr = nil
end

vim.keymap.set({ "n", "i", "v", "x", "s" }, "<F1>", function()
	if cheat_winid and vim.api.nvim_win_is_valid(cheat_winid) then
		close_cheat_sheet()
		return
	end

	local mode = vim.fn.mode()
	local active_keys, title_text

	if mode == "i" then
		active_keys = insert_mode_keys
		title_text = " Insert mode keys "
	elseif mode == "v" or mode == "V" or mode == "\22" then -- \22 is <C-v>
		active_keys = visual_mode_keys
		title_text = " Visual mode keys "
	else
		active_keys = normal_mode_keys
		title_text = " Normal mode keys "
	end

	-- Find the max width of the keys column to align everything cleanly
	local max_key_width = 0
	for _, item in ipairs(active_keys) do
		local w = vim.fn.strdisplaywidth(item.key)
		if w > max_key_width then max_key_width = w end
	end
	max_key_width = max_key_width + 2 -- Add padding after the key bind

	-- Build raw lines with consistent padding
	local formatted_lines = {}
	for _, item in ipairs(active_keys) do
		local padding = string.rep(" ", max_key_width - vim.fn.strdisplaywidth(item.key))
		table.insert(formatted_lines, string.format("%s%s%s", item.key, padding, item.desc))
	end

	-- Distribute into 2 columns
	local half = math.ceil(#formatted_lines / 2)
	local col1_max_width = 0
	for i = 1, half do
		local w = vim.fn.strdisplaywidth(formatted_lines[i])
		if w > col1_max_width then col1_max_width = w end
	end
	col1_max_width = col1_max_width + 4 -- Gap between column 1 and column 2

	local combined = {}
	for i = 1, half do
		local left = formatted_lines[i] or ""
		local right = formatted_lines[i + half] or ""
		local pad = string.rep(" ", col1_max_width - vim.fn.strdisplaywidth(left))
		combined[i] = left .. pad .. right
	end

	-- Calculate window dimension thresholds 
	local max_line_w = 0
	for _, line in ipairs(combined) do
		local w = vim.fn.strdisplaywidth(line)
		if w > max_line_w then max_line_w = w end
	end

	local width = math.min(vim.o.columns - 4, max_line_w)
	local height = math.min(vim.o.lines - 4, #combined)

	cheat_bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(cheat_bufnr, 0, -1, false, combined)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
		title = title_text,
		title_pos = "center",
		focusable = true,
		noautocmd = true,
	}

	cheat_winid = vim.api.nvim_open_win(cheat_bufnr, true, opts)

	vim.bo[cheat_bufnr].buftype = "nofile"
	vim.bo[cheat_bufnr].bufhidden = "wipe"
	vim.bo[cheat_bufnr].swapfile = false
	vim.bo[cheat_bufnr].modifiable = false

	-- Local bindings to close the window
	local map_opts = { buffer = cheat_bufnr, nowait = true, silent = true }
	vim.keymap.set("n", "<Esc>", close_cheat_sheet, map_opts)
	vim.keymap.set("n", "q", close_cheat_sheet, map_opts)

	-- Handle unexpected background window closures
	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = cheat_bufnr,
		once = true,
		callback = function()
			cheat_winid = nil
			cheat_bufnr = nil
		end,
	})
end)
