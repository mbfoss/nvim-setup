local debug_adapters = { "codelldb", "lldb", "gdb", "debugpy", "js-debug" }

---@param target string
---@param ctx neotasks.DebugTargetCtx
---@return table<string, any>?
local function expand_basic_target(target, ctx)
	if ctx.mode ~= "binary" and ctx.mode ~= "script" then return nil end
	local program, args = target:match("^%s*(%S+)%s*(.*)$")
	if not program then return nil end
	args = vim.trim(args)
	return { program = program, args = args ~= "" and args or nil }
end

-- Only the enabled adapters offer `target`.
local debug_targets = {}
for _, adapter in ipairs(debug_adapters) do
	debug_targets[adapter] = expand_basic_target
end

require("neotasks").setup({
	lsp_debug_commands = true,
	debug_adapters = debug_adapters,
	debug_targets = debug_targets,
})

-- Registered as :Task, the name the keymaps below already use.
require("neotasks").create_cmd_alias("Task")


-- run / restart
vim.keymap.set("n", "<leader>lr", ":Task run<CR>", { desc = "Run task", silent = true })
vim.keymap.set("n", "<leader>lR", ":Task rerun<CR>", { desc = "Repeat last task", silent = true })
-- status panel
vim.keymap.set("n", "<leader>lt", ":Task panel<CR>", { desc = "Toggle status panel", silent = true })
vim.keymap.set("n", "<leader>lc", ":Task clean<CR>", { desc = "Clear finished tasks", silent = true })
vim.keymap.set("n", "<leader>ld", ":Task panel remove<CR>", { desc = "Remove one finishted task", silent = true })
vim.keymap.set("n", "<leader>lp", function() vim.cmd("Task panel " .. vim.v.count1) end, { desc = "Jump to dock tab N (count)", silent = true }) -- task control
vim.keymap.set("n", "<leader>lk", ":Task stop<CR>", { desc = "Stop a task", silent = true })
vim.keymap.set("n", "<leader>lK", ":Task stop_all<CR>", { desc = "Stop all tasks", silent = true })

require("neotasks").register_expression("add", function(_, a, b) return tonumber(a) + tonumber(b) end,
	{ desc = "add 2 numbers" })
