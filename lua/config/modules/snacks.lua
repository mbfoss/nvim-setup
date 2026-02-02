require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	picker = {
		enabled = true,
		win = {
			-- input window
			input = {
				keys = {
					-- to close the picker on ESC instead of going to normal mode,
					-- add the following keymap to your config
					-- ["<Esc>"] = { "close", mode = { "n", "i" } },
					["/"] = "toggle_focus",
					["<C-j>"] = { "history_forward", mode = { "i", "n" } },
					["<C-k>"] = { "history_back", mode = { "i", "n" } },
				}
			}
		},
		layout = {
			layout = {
				backdrop = false, -- disable dimming
			},
		},
	},
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = false },
	words = { enabled = true },
})

local Snacks = require("snacks")
----------------------------------------------------------------------
-- Project / search root detection
----------------------------------------------------------------------
local function find_search_root()
	local targets = { ".git/", "compile_commands.json", ".nvim_project/" }
	local buf_path = vim.bo[0].filetype == "" and vim.api.nvim_buf_get_name(0) or ""
	local start_dir = buf_path ~= "" and vim.fs.dirname(buf_path) or vim.fn.getcwd()
	local dir, stop_dir = start_dir, vim.loop.os_homedir()

	while dir and dir ~= stop_dir and dir ~= "/" do
		for _, target in ipairs(targets) do
			local is_dir = target:sub(-1) == "/"
			local path = dir .. "/" .. target:gsub("/$", "")
			local stat = vim.loop.fs_stat(path)
			if stat and ((is_dir and stat.type == "directory") or (not is_dir and stat.type == "file")) then
				return dir
			end
		end
		local parent = vim.fs.dirname(dir)
		if parent == dir then break end
		dir = parent
	end

	return start_dir
end

----------------------------------------------------------------------
-- Git difftool action for commit picker
----------------------------------------------------------------------
local function git_diff_commits(picker)
	local items = picker:selected()
	local current = picker:current()
	local cwd = picker.opts.cwd or vim.loop.cwd()

	if not current then return end

	local commit_a, commit_b
	if #items > 0 then
		commit_a = items[1].value
		commit_b = current.value
	else
		commit_a = current.value .. "^"
		commit_b = current.value
	end

	picker:close()

	local ok, jobid = pcall(vim.fn.jobstart, {
		"git", "-C", cwd, "difftool", "-d", commit_a, commit_b,
	}, { detach = false })

	if ok and jobid > 0 then
		vim.notify(
			("Running: git difftool -d %s %s"):format(commit_a, commit_b),
			vim.log.levels.INFO
		)
	else
		vim.notify("Failed to start git difftool", vim.log.levels.ERROR)
	end
end

----------------------------------------------------------------------
-- Pickers
----------------------------------------------------------------------
local function git_commits()
	Snacks.picker.git_commits({
		preview = true,
		keys = {
			["<C-g>"] = git_diff_commits,
		},
	})
end

local function show_file_picker(fuzzy)
	Snacks.picker.files({
		cwd = find_search_root(),
		fuzzy = fuzzy,
		prompt = fuzzy and "> " or "= ",
	})
end

local function show_grep_picker(opts)
	opts = opts or {}
	Snacks.picker.grep({
		cwd = find_search_root(),
		regex = opts.use_regex ~= false,
	})
end

local function find_document_symbols()
	Snacks.picker.lsp_symbols({
		symbols = { "method", "function", "constructor", "variable" },
	})
end

local function show_qf_errors()
	local qf = vim.fn.getqflist()
	local errors = {}

	for _, entry in ipairs(qf) do
		if entry.valid == 1 and (entry.type == "E" or entry.severity == vim.diagnostic.severity.ERROR) then
			table.insert(errors, entry)
		end
	end

	if #errors == 0 then
		vim.notify("No errors in quickfix", vim.log.levels.INFO)
		return
	end

	vim.ui.select(errors, {
		prompt = "Quickfix Errors:",
		format_item = function(e)
			local fname = vim.fn.bufname(e.bufnr)
			return ("%s:%d:%d  %s"):format(fname, e.lnum, e.col, vim.trim(e.text))
		end,
	}, function(choice)
		if not choice then return end
		vim.cmd.edit(vim.fn.fnameescape(vim.fn.bufname(choice.bufnr)))
		vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
	end)
end
----------------------------------------------------------------------
-- vim.ui.select override (with preview)
----------------------------------------------------------------------
vim.ui.select = function(items, opts, on_choice)
	opts = opts or {}

	Snacks.picker.new({
		title = opts.prompt or "Select",
		items = items,
		preview = true,
		format = function(item)
			return opts.format_item and opts.format_item(item) or tostring(item)
		end,
		confirm = function(picker, item)
			picker:close()
			on_choice(item)
		end,
	})
end

----------------------------------------------------------------------
-- Helpers
----------------------------------------------------------------------
local function show_search_root()
	vim.notify("Search directory: " .. find_search_root())
end

----------------------------------------------------------------------
-- Keymaps
----------------------------------------------------------------------

vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Explorer" })
vim.keymap.set("n", "<leader>N", function() Snacks.notifier.show_history() end, { desc = "Notification History" })

-- === Find ===
vim.keymap.set("n", "<leader>f?", show_search_root, { desc = "Search dir (for Find/Grep)" })
vim.keymap.set("n", "<leader>fo", function() Snacks.picker.pickers() end, { desc = "All pickers" })
vim.keymap.set("n", "<leader>ff", function() show_file_picker(true) end, { desc = "Find Files (fuzzy)" })
vim.keymap.set("n", "<leader>fF", function() show_file_picker(false) end, { desc = "Find Files (non-fuzzy)" })

vim.keymap.set("n", "<leader>fg", function()
	show_grep_picker({ use_regex = false })
end, { desc = "Grep (smart case)" })

vim.keymap.set("n", "<leader>fG", function()
	show_grep_picker({ use_regex = true })
end, { desc = "Grep (regex)" })

vim.keymap.set("n", "<leader>fb", Snacks.picker.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fp", Snacks.picker.recent, { desc = "Previous files" })
vim.keymap.set("n", "<leader>fq", Snacks.picker.qflist, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>fe", show_qf_errors, { desc = "Quickfix Errors" })
vim.keymap.set("n", "<leader>fd", function()
	Snacks.picker.diagnostics({ scope = "buffer" })
end, { desc = "Diagnostics (buffer)" })

vim.keymap.set("n", "<leader>fD", Snacks.picker.diagnostics, { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>fr", Snacks.picker.lsp_references, { desc = "LSP References" })
vim.keymap.set("n", "<leader>fS", find_document_symbols, { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>fs", Snacks.picker.spelling, { desc = "Spell Suggestions" })
vim.keymap.set("n", "<leader>fm", Snacks.picker.marks, { desc = "Marks" })

-- === Git ===
vim.keymap.set("n", "<leader>gb", Snacks.picker.git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", git_commits, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gd", Snacks.picker.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", Snacks.picker.git_stash, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gf", Snacks.picker.git_files, { desc = "Find Git Files" })

vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config"), }) end,
	{ desc = "Find Config File" })
