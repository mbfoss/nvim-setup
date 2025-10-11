local normal_mode_keys = {
	"a A    append at cursor / line end",
	"b B    back word / WORD",
	"c C    change / to end of line",
	"d D    delete / to end of line",
	"e E    next word / WORD",
	"f F    find char forward / backward",
	"g G    prefix / go to bottom of file",
	"h H    move left / to top of screen",
	"i I    insert at cursor / line start",
	"j J    move down / join lines",
	"k K    move up / show keyword help",
	"l L    move right / to bottom of screen",
	"m M    set mark / move to middle of screen",
	"n N    next / previous search match",
	"o O    open line below / above",
	"p P    paste after / before cursor",
	"q Q    record macro / enter Ex mode",
	"r R    replace one char / replace mode",
	"s S    substitute char / entire line",
	"t T    till char forward / backward",
	"u U    undo / undo line changes",
	"v V    visual char / line mode",
	"w W    next word / WORD",
	"x X    delete char / char before cursor",
	"y Y    yank / yank entire line",
	"z Z    view-related commands / quit",
	"^ _ 0  move to line start (non-ws/oper/abs)",
	"$      move to end of line",
	"|      move to column N",
	"+  -   next / previous line",
	"[ ]    jump between sections",
	"{ }    back / forward paragraph",
	"` '    jump to mark / line mark",
	"*      search word under cursor",
	"/ ?    search forward / backward",
	"; ,    repeat last f/F/t/T / reverse",
	"&      repeat :s substitution",
	".      repeat last action",
	'"      select register (e.g. \"ayy)',
	":      command mode",
	"< >    shift left / right",
	"=      auto-indent",
	"@      play macro",
	"~      swap case",
	"<C-a>  increment number under cursor",
	"<C-b>  scroll back one page",
	"<C-c>  interrupt / cancel",
	"<C-d>  scroll down half page",
	"<C-e>  scroll window down",
	"<C-f>  scroll forward one page",
	"<C-g>  show file status",
	"<C-h>  backspace (delete char before cursor)",
	"<C-i>  tab / jump forward in jump list",
	"<C-j>  newline in insert mode",
	"<C-k>  delete to end of line",
	"<C-l>  redraw screen",
	"<C-m>  carriage return (Enter)",
	"<C-n>  next line in completion",
	"<C-o>  jump to older position",
	"<C-p>  previous line in completion",
	"<C-q>  quit (in some terminals)",
	"<C-r>  redo",
	"<C-s>  save (in some configs)",
	"<C-t>  jump to tag",
	"<C-u>  scroll up half page",
	"<C-v>  visual block mode",
	"<C-w>  window commands prefix",
	"<C-x>  decrement number under cursor",
	"<C-y>  scroll window up",
	"<C-z>  suspend (background process)",
}

local insert_mode_keys = {
	"<C-a>        line start",
	"<C-h>        backspace",
	"<C-j>        newline",
	"<C-k>        digraph / delete to EOL",
	"<C-l>        insert next char literally",
	"<C-n>        next completion",
	"<C-o>        run one Normal command",
	"<C-p>        previous completion",
	"<C-r>        insert register",
	"<C-t>        insert indent",
	"<C-u>        delete to line start",
	"<C-v>        insert next char literally",
	"<C-w>        delete previous word",
	"<C-x>        completion prefix",
	"<C-x><C-l>   line completion",
	"<C-x><C-n>   buffer keyword completion",
	"<C-x><C-p>   other buffers completion",
	"<C-x><C-f>   file name completion",
	"<C-x><C-o>   omni-completion",
	"<C-x><C-u>   user-defined completion",
	"<C-x><C-k>   dictionary completion",
	"<C-x><C-t>   thesaurus completion",
	"<C-x><C-i>   included file completion",
	"<C-x><C-]>   tag completion",
	"<C-x><C-d>   definition completion",
	"<C-y>        insert char above",
	"<C-z>        suspend Vim",
}

local cheat_bufnr = nil
local cheat_winid = nil

vim.keymap.set({ "n", "i", "v", "x", "s" }, "<F1>", function()
	if cheat_winid and vim.api.nvim_win_is_valid(cheat_winid) then
		vim.api.nvim_win_close(cheat_winid, true)
		cheat_winid = nil
		cheat_bufnr = nil
		return
	end

	local lines = vim.fn.mode() == "i" and insert_mode_keys or normal_mode_keys
	local title_text = vim.fn.mode() == "i" and "Insert mode keys" or "Normal mode keys"

	-- Two columns formatting
	local half = math.ceil(#lines / 2)
	local col1, col2 = {}, {}
	for i = 1, half do
		col1[i] = lines[i] or ""
		col2[i] = lines[i + half] or ""
	end

	local col1_width = 0
	for _, line in ipairs(col1) do
		if #line > col1_width then col1_width = #line end
	end
	col1_width = col1_width + 4

	local combined = {}
	for i = 1, half do
		local left = col1[i] or ""
		local right = col2[i] or ""
		left = left .. string.rep(" ", col1_width - #left)
		combined[i] = left .. right
	end

	local width = math.min(120, math.max(50, col1_width * 2))
	local height = #combined

	cheat_bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(cheat_bufnr, 0, -1, false, combined)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2,
		style = "minimal",
		border = "rounded",
		title = title_text,
		title_pos = "center", -- or "left", "right"
		focusable = true,
		noautocmd = true,
	}

	cheat_winid = vim.api.nvim_open_win(cheat_bufnr, true, opts)

	vim.bo[cheat_bufnr].buftype = "nofile"
	vim.bo[cheat_bufnr].bufhidden = "wipe"
	vim.bo[cheat_bufnr].swapfile = false
	vim.bo[cheat_bufnr].modifiable = false

	-- Close on <Esc> or <q>
	vim.keymap.set("n", "<Esc>", function()
		if cheat_winid and vim.api.nvim_win_is_valid(cheat_winid) then
			vim.api.nvim_win_close(cheat_winid, true)
			cheat_winid = nil
			cheat_bufnr = nil
		end
	end, { buffer = cheat_bufnr, nowait = true })

	vim.keymap.set("n", "q", function()
		if cheat_winid and vim.api.nvim_win_is_valid(cheat_winid) then
			vim.api.nvim_win_close(cheat_winid, true)
			cheat_winid = nil
			cheat_bufnr = nil
		end
	end, { buffer = cheat_bufnr, nowait = true })
end)
