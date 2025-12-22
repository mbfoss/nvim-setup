local builtin      = require('telescope.builtin')
local sorters      = require("telescope.sorters")
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")


-- Detached difftool launcher
local function diff_commits(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	local current = action_state.get_selected_entry()
	local cwd = picker.cwd or vim.loop.cwd()

	-- Check if we're inside a git repo
	local git_check = vim.fn.system({ "git", "-C", cwd, "rev-parse", "--is-inside-work-tree" })
	if not git_check or not git_check:match("true") then
		vim.notify("Not a git repository: " .. cwd, vim.log.levels.WARN)
		return
	end

	if not current then
		return
	end

	local commit_a, commit_b

	if #multi > 0 then
		-- Diff between first selected and active commit
		commit_a = multi[1].value
		commit_b = current.value
	else
		-- Diff between current commit and its parent
		commit_a = current.value .. "^"
		commit_b = current.value
	end

	actions.close(prompt_bufnr)

	local cmd = { "git", "-C", cwd, "difftool", "-d", commit_a, commit_b }

	local ok, jobid = pcall(vim.fn.jobstart, cmd, {
		cwd = cwd,
		detach = false,
	})

	if ok and jobid > 0 then
		vim.notify("Running detached: git difftool -d " .. commit_a .. " " .. commit_b, vim.log.levels.INFO)
	else
		vim.notify("Failed to start git difftool", vim.log.levels.ERROR)
	end
end

-- Telescope setup
require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			horizontal = { prompt_position = "top" },
			vertical = { mirror = true, prompt_position = "top", preview_height = 0.45 },
		},
		sorting_strategy = "ascending",
		path_display = { "truncate" },
	},
	pickers = {
		git_commits = {
			attach_mappings = function(_, map)
				map("i", "<C-g>", diff_commits)
				map("n", "<C-g>", diff_commits)
				return true
			end,
		},
		git_status = {
			layout_config = {
				horizontal = { prompt_position = "top" },
				vertical = { mirror = true, prompt_position = "top", preview_height = 0.70 },
			},
		},
		lsp_references = {
			path_display = { "smart" },
			fname_width = 50,
		},
		quickfix = {
			path_display = { "smart" },
			fname_width = 50,
		},
	},
})


-- Completely override vim.ui.select
vim.ui.select = function(items, opts, on_choice)
	local conf = require("telescope.config").values
	opts       = opts or {}
	pickers.new({}, {
		prompt_title = opts.prompt or "Select",
		finder = finders.new_table {
			results = items,
			entry_maker = function(item)
				return {
					value   = item,
					display = opts.format_item and opts.format_item(item) or tostring(item),
					ordinal = tostring(item),
				}
			end,
		},

		sorter = conf.generic_sorter({}),

		-- *** 50% of the screen height ***
		layout_strategy = "vertical",
		layout_config = {
			height = 0.5, -- 50%
			prompt_position = "top",
		},

		-- Disable Telescope's default picker caching
		cache_picker = false,

		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				on_choice(selection and selection.value or nil)
			end)
			return true
		end,
	}):find()
end

-- === Helper to find project/search root ===
local function find_search_root()
	local targets = { ".git/", "compile_commands.json", ".nvim_project/" }
	local buf_path = vim.bo[0].filetype == '' and vim.api.nvim_buf_get_name(0) or ''
	local start_dir = buf_path ~= "" and vim.fs.dirname(buf_path) or vim.fn.getcwd()
	local dir, stop_dir = start_dir, vim.loop.os_homedir()

	while dir and dir ~= stop_dir and dir ~= "/" do
		local stat = vim.loop.fs_stat(dir)
		if not stat or stat.type ~= 'directory' then
			break
		end
		for _, target in ipairs(targets) do
			local is_dir = target:sub(-1) == "/"
			local path = dir .. "/" .. target:gsub("/$", "")
			stat = vim.loop.fs_stat(path)
			if stat and ((is_dir and stat.type == "directory") or (not is_dir and stat.type == "file")) then
				return dir
			end
		end
		local d = vim.fs.dirname(dir)
		if d == dir then
			break
		end
		dir = d
	end
	return start_dir
end

local function show_search_root()
	local root = find_search_root()
	if root then
		vim.notify("Search directory: " .. root)
	end
end

local function show_file_picker(fuzzy)
	local dir = find_search_root()
	if not dir then
		return vim.notify("Cannot find search dir")
	end

	local sorter
	if fuzzy then
		-- Fuzzy: use fzy with smart case
		sorter = sorters.get_fzy_sorter({
			case_mode = "smart_case", -- lowercase = ignore case, any UPPER = case-sensitive
		})
	else
		sorter = sorters.get_substr_matcher({})
	end

	builtin.find_files({
		cwd = dir,
		sorter = sorter,
		prompt_prefix = fuzzy and "> " or "= ",
	})
end

local function show_grep_picker(opts)
	opts = opts or {}
	local dir = find_search_root()
	if not dir then
		return vim.notify("Cannot find search dir")
	end
	local additional_args = nil
	if opts.use_regex == false then
		additional_args = { "--fixed-strings" }
	end
	local cword = vim.fn.expand("<cword>")
	builtin.live_grep({
		cwd = dir,
		additional_args = additional_args,
		default_text = cword,
	})
end

local function find_document_symbols()
	builtin.lsp_document_symbols({ symbols = { 'method', 'function', 'constructor', 'variable' }, symbol_width = 70 })
end

local function show_qf_errors()
	local conf = require('telescope.config').values
	local qf = vim.fn.getqflist()
	local errors = vim.tbl_filter(function(i)
		return (i.type == 'E') or
			(i.severity and (
				(type(i.severity) == 'string' and vim.diagnostic.severity[i.severity] or i.severity)
				== vim.diagnostic.severity.ERROR
			))
	end, qf)

	if #errors == 0 then return vim.notify('No errors in quickfix') end

	pickers.new({}, {
		prompt_title = 'Quickfix Errors',
		finder = finders.new_table({
			results = errors,
			entry_maker = function(e)
				local fname = vim.fn.bufname(e.bufnr)
				return {
					value = e,
					display = ('%s:%d:%d: %s'):format(fname, e.lnum, e.col, vim.trim(e.text or '')),
					ordinal = fname .. ' ' .. e.text,
					filename = fname,
					lnum = e.lnum,
					col = e.col,
				}
			end,
		}),
		-- FIXED: Pass {} to qflist_previewer to provide the missing 'opts'
		previewer = conf.qflist_previewer({}),
		sorter = conf.generic_sorter(),
		attach_mappings = function(bufnr)
			actions.select_default:replace(function()
				actions.close(bufnr)
				local sel = action_state.get_selected_entry()
				vim.cmd('edit ' .. vim.fn.fnameescape(sel.filename))
				vim.api.nvim_win_set_cursor(0, { sel.lnum, sel.col - 1 })
			end)
			return true
		end,
	}):find()
end


-- === Find ===
vim.keymap.set("n", "<leader>f?", show_search_root, { desc = "Search dir (for Find/Grep)" })
vim.keymap.set("n", "<leader>fa", builtin.resume, { desc = "Resume last search" })
vim.keymap.set("n", "<leader>fo", builtin.builtin, { desc = "Show all pickers" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end,
	{ desc = "Find Config File" })

vim.keymap.set("n", "<leader>ff", function() show_file_picker(true) end, { desc = "Find Files (fuzzy)" })
vim.keymap.set("n", "<leader>fF", function() show_file_picker(false) end, { desc = "Find Files (non-fuzzy)" })

vim.keymap.set("n", "<leader>fg", function() show_grep_picker({ use_regex = false }) end, { desc = "Grep (smart case)" })
vim.keymap.set("n", "<leader>fG", function() show_grep_picker({ use_regex = true }) end, { desc = "Grep text (regex)" })

vim.keymap.set("n", "<leader>fp", builtin.oldfiles, { desc = "Previous files" })
vim.keymap.set("n", '<leader>f"', builtin.registers, { desc = "Registers" })
vim.keymap.set("n", '<leader>f/', builtin.search_history, { desc = "Search History" })
vim.keymap.set("n", "<leader>ft", builtin.current_buffer_fuzzy_find, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>fh", builtin.command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Jumps" })
vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Marks" })
vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>fe", show_qf_errors, { desc = "Quickfix Errors" })
vim.keymap.set("n", "<leader>fd", function() builtin.diagnostics({bufnr = 0}) end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fD", builtin.diagnostics, { desc = "Workspace Diagnostics (cwd)" })
vim.keymap.set("n", "<leader>fB", builtin.live_grep, { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "<leader>fS", find_document_symbols, { desc = "LSP references" })
vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "Spell suggestions" })
-- === Git ===
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", builtin.git_bcommits, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gd", builtin.git_status, { desc = "Git diff" })
vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "Git stash list" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Find Git Files" })
