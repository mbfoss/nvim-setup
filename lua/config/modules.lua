local modules = {
	{ pack = "ezpick.nvim",        module = "ezpick" },
	{ pack = "notespanel.nvim",       module = "notespanel" },
	{ pack = "greplace.nvim",      module = "greplace" },
	{ pack = "keystone.nvim",      module = "keystone" },
	{ pack = "gittools.nvim",      module = "gittools" },
	{ pack = "flash.nvim",         module = "flash" },
	{ pack = "claudecode.nvim",    module = "claudecode" },
	{ pack = "cmake.nvim",         module = "cmake" },
	{ pack = "osv.nvim",           module = "osv" },
	{ pack = "mason.nvim",         module = "mason" },
	{ pack = "gitsigns.nvim",      module = "gitsigns" },
	{ pack = "tomltasks.nvim",     module = "tomltasks" },
	{ pack = "ezdap.nvim",         module = "ezdap" },
	{ pack = "ezdap-adapters.nvim" },
	{ pack = "dock.nvim",          module = "dock" },
}

local pack_loaded = {}
for _, entry in ipairs(modules) do
	if pack_loaded[entry.pack] == nil then
		pack_loaded[entry.pack] = true
		vim.cmd('packadd! ' .. entry.pack)
	end
end

for _, entry in ipairs(modules) do
	if entry.module then
		local mod = require(entry.module)
		local config_file = vim.fn.stdpath("config")
			.. "/lua/plugins/"
			.. entry.module:gsub("%.", "/")
			.. ".lua"
		if vim.uv.fs_stat(config_file) then
			require("plugins." .. entry.module)
		elseif type(mod.setup) == "function" then
			mod.setup({})
		end
	end
end
