local ndap = require("ndap")

ndap.setup({
	raw_messages = true,
	external_terminal = "tmux split-window",
})

-- Forwards the line as typed (escaped spaces survive) and the range, so
-- :'<,'>Debug inspect reads the selection.
ndap.create_cmd_alias("Debug")

---Bind `lhs` to `:Debug <sub>`. `<Cmd>` leaves the cmdline untouched, unlike `:`,
---and `vim.keymap.set` is non-recursive, so no `noremap` is needed.
---@param lhs   string
---@param sub   string  the `:Debug` subcommand, arguments included
---@param desc  string  shown by which-key, prefixed with "Debug: "
---@param modes? string|string[]  default "n"
local function dmap(lhs, sub, desc, modes)
	vim.keymap.set(modes or "n", lhs, ("<Cmd>Debug %s<CR>"):format(sub),
		{ desc = "Debug: " .. desc, silent = true })
end

-- `<leader>d` is a prefix, not a command of its own.
vim.keymap.set("n", "<leader>d", "<Nop>", { desc = "Debug" })

for _, m in ipairs({
	-- Breakpoints (b*)
	{ "<leader>bl", "breakpoint list",           "list breakpoints" },
	{ "<leader>bb", "breakpoint toggle",         "toggle breakpoint" },
	{ "<leader>bd", "breakpoint remove",         "delete breakpoint" },
	{ "<leader>bc", "breakpoint condition",      "conditional breakpoint" },
	-- Column breakpoints need a position on the line, so toggle one, then move the
	-- cursor and invoke this to relocate it there.
	{ "<leader>bC", "breakpoint column",         "column breakpoint" },
	{ "<leader>bL", "breakpoint logpoint",       "set logpoint" },
	{ "<leader>bt", "breakpoint toggle_enabled", "toggle enabled/disabled" },
	{ "<leader>bE", "breakpoint enable_all",     "enable all breakpoints" },
	{ "<leader>bD", "breakpoint disable_all",    "disable all breakpoints" },
	-- Watchpoints / data breakpoints
	{ "<leader>bw", "breakpoint data",           "toggle data breakpoint" },
	{ "<leader>bW", "breakpoint data_list",      "list data breakpoints" },
	{ "<leader>bX", "breakpoint data_clear",     "clear data breakpoints" },

	-- Execution (d*)
	{ "<leader>ds", "session",          "select session" },
	{ "<leader>dt", "thread",           "select thread" },
	{ "<leader>df", "frame",            "select frame" },
	{ "<leader>dp", "pause",            "pause" },
	{ "<leader>dl", "step_in",          "step in" },
	{ "<leader>dh", "step_out",         "step out" },
	{ "<leader>dj", "step_over",        "step over" },
	{ "<leader>dk", "stop",             "stop session" },
	{ "<leader>dJ", "jump_to_cursor",   "jump to cursor" },
	{ "<leader>dc", "continue",         "continue" },
	{ "<leader>dC", "continue_all",     "continue all" },
	{ "<leader>dX", "reverse_continue", "reverse continue" },
	{ "<leader>dT", "terminate_thread", "terminate thread" },
	{ "<leader>de", "exception_info",   "exception info" },
	{ "<leader>dR", "rerun",            "re-run" },
	{ "<leader>dA", "disassemble",      "disassemble" },
	{ "<leader>dK", "stop_all",         "stop all sessions" },
	{ "<leader>dP", "panel",            "toggle panel" },
	{ "<leader>dv", "view",             "debug view" },

	-- Alt keys mirror the step/continue maps for one-handed use.
	{ "<A-l>", "step_in",           "step in" },
	{ "<A-h>", "step_out",          "step out" },
	{ "<A-j>", "step_over",         "step over" },
	{ "<A-k>", "step_back",         "step back" },
	{ "<A-;>", "continue",          "continue" },
	{ "<A-b>", "breakpoint toggle", "toggle breakpoint" },
}) do
	dmap(m[1], m[2], m[3], m[4])
end

-- The one map that needs the command *range*: in visual mode `:` inserts `'<,'>`,
-- which `opts.range` turns into "read the selection"; `<Cmd>` cannot supply it.
vim.keymap.set({ "n", "x" }, "<leader>di", ":Debug inspect<CR>",
	{ desc = "Debug: inspect value", silent = true })
