local modules = {

	-- { pack = "nvtoolkit.nvim",       module = "nvtoolkit" },
	--  { pack = "lualine.nvim",    module = "lualine" },
	-- { pack = "snacks.nvim",           module = "snacks" },

	{ pack = "osv.nvim",        module = "osv" },
	{ pack = "mason.nvim",      module = "mason" },
	-- { pack = "gitsigns.nvim",   module = "gitsigns" },

	-- { pack = "loop.nvim",            module = "loop" },
	-- { pack = "loop-build.nvim",      module = "loop-build" },
	-- { pack = "loop-cmake.nvim",      module = "loop-cmake" },
	-- { pack = "loop-debug.nvim",      module = "loop-debug" },
	-- { pack = "loop-marks.nvim",      module = "loop-marks" },

	-- { pack = "pastelstone.nvim",     module = "pastelstone" },
	{ pack = "tomltools.nvim",  module = "tomltools" },
	{ pack = "easytasks.nvim",  module = "easytasks" },
	{ pack = "easydap.nvim",    module = "easydap" },
	{ pack = "nvim-dap",        module = "dap" },

	{ pack = "keystone.nvim",   module = "keystone.pick" },
	{ pack = "keystone.nvim",   module = "keystone.filetree" },
	{ pack = "keystone.nvim",   module = "keystone.explore" },
	{ pack = "keystone.nvim",   module = "keystone.lspwords" },
	{ pack = "keystone.nvim",   module = "keystone.notify" },
	{ pack = "keystone.nvim",   module = "keystone.animate" },
	{ pack = "keystone.nvim",   module = "keystone.complete" },
	{ pack = "keystone.nvim",   module = "keystone.statusline" },
	{ pack = "keystone.nvim",   module = "keystone.bookmarks" },
	{ pack = "keystone.nvim",   module = "keystone.lspconfig" },
	{ pack = "flash.nvim",      module = "flash" },
	{ pack = "claudecode.nvim", module = "claudecode" },
	{ pack = "which-key.nvim",  module = "which-key" },
}

local pack_loaded = {}
for _, entry in ipairs(modules) do
	if pack_loaded[entry.pack] == nil then
		pack_loaded[entry.pack] = true
		vim.cmd('packadd! ' .. entry.pack)
	end
end

for _, entry in ipairs(modules) do
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
