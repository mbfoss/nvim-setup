local run_commands = nil

local function run_commands_status()
	if run_commands == nil then
		run_commands = require("mbo.tasks-term")
	end
	if run_commands.is_running() then
		return "  " .. run_commands.running_job_name()
	else
		return " "
	end
end

require('lualine').setup {
	options = {
		theme = 'nord',
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename', run_commands_status },
		lualine_x = { 'lsp_status', 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
}
