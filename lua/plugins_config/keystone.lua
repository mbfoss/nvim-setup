-- Compact live-run summary, e.g. `▶ 2 ⧗ 1 ✗ 1 ✓ 3`.
local _run_icons   = { running = "▶", waiting = "⧗", failed = "✗", succeeded = "✓" }
local _run_order   = { "running", "waiting", "failed", "succeeded" }
local _status_text = ""

local function _update_status()
	local ok, ret = pcall(function()
		local counts = { running = 0, waiting = 0, failed = 0, succeeded = 0 }
		local have_runs = false
		for _, run in ipairs(require("neotasks").list_runs()) do
			have_runs = true
			local state = run.active and run.state or run.result
			if run.primary and counts[state] then counts[state] = counts[state] + 1 end
		end

		if not have_runs then return "" end
		local parts = { "Tasks:" }
		for _, state in ipairs(_run_order) do
			if counts[state] > 0 then
				parts[#parts + 1] = _run_icons[state] .. " " .. counts[state]
			end
		end
		return table.concat(parts, " ")
	end)
	if ok then _status_text = ret end
end

-- Refresh the cached string and redraw only when neotasks' run state changes.
vim.api.nvim_create_autocmd("User", {
	pattern = "NeotasksRunsChanged",
	callback = function()
		_update_status()
		vim.cmd.redrawstatus()
	end,
})

_update_status()

require("keystone").setup({
	-- Language support
	lspsetup     = {
		servers = { "clangd", "lua", "python", "taplo", "test" },
	},
	tsconfig     = true,
	completion   = true,
	scope        = true,
	-- Editor behaviour
	tweaks       = true,
	largefile    = true,
	marksigns    = true,
	animate      = true,

	-- Replaces something built in
	statusline   = {
		sections = {
			left  = { "mode", "git", "filename", "symbol_path" },
			right = {
				"lsp_progress", "diagnostics", function() return _status_text end, "filetype", "position",
			},
		},
	},
	select       = true,
	notify       = true,
	clue         = true,
	-- Adds a command, does nothing until you run it
	filetree     = true,
	fileselector = true,
	diffunsaved  = true,
	bufdelete    = true,
})

require("keystone.clue").add({
	{ "<leader>B",  group = "+Buffer",   mode = { "n" } },
	{ "<leader>c",  group = "+Code",     mode = { "n", "v" } },
	{ "<leader>f",  group = "+Find",     mode = { "n" } },
	{ "<leader>g",  group = "+Git",      mode = { "n" } },
	{ "<leader>d",  group = "+Debug",    mode = { "n" } },
	{ "<leader>o",  group = "+Others",   mode = { "n" } },
	{ "<leader>S",  group = "+Sessions", mode = { "n" } },
	{ "<leader>p",  group = "+Project",  mode = { "n" } },
	{ "<leader>pb", group = "+Build",    mode = { "n" } },
	{ "<leader>pr", group = "+Run",      mode = { "n" } },
})
