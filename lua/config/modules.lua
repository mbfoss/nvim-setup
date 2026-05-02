-- List of modules
local modules = {

	{ pack = "osv.nvim",          module = "osv",               with_config = false },
	{ pack = "mini.nvim",         module = "mini.base16",       with_config = true },
	{ pack = "mini.nvim",         module = "mini.completion",   with_config = true },
	{ pack = "mini.nvim",         module = "mini.notify",       with_config = true },
	-- { pack = "mini.nvim",         module = "mini.files",        with_config = true },
	{ pack = "mason.nvim",        module = "mason",             with_config = false },
	{ pack = "nvim-treesitter",   module = "nvim-treesitter",   with_config = false },
	{ pack = "lualine.nvim",      module = "lualine",           with_config = true },
	{ pack = "gitsigns.nvim",     module = "gitsigns",          with_config = false },
	{ pack = "loop.nvim",         module = "loop",              with_config = true },
	{ pack = "loop-build.nvim",   module = "loop-build",        with_config = false },
	{ pack = "loop-cmake.nvim",   module = "loop-cmake",        with_config = false },
	{ pack = "loop-debug.nvim",   module = "loop-debug",        with_config = true },
	{ pack = "loop-marks.nvim",   module = "loop-marks",        with_config = false },
	{ pack = "keystone.nvim",     module = "keystone.pick",     with_config = true },
	{ pack = "keystone.nvim",     module = "keystone.filetree", with_config = false },
	{ pack = "keystone.nvim",     module = "keystone.lspwords", with_config = false },
	{ pack = "keystone.nvim",     module = "keystone.animate",  with_config = false },
	{ pack = "flash.nvim",        module = "flash",             with_config = true },
	{ pack = "nvim-web-devicons", module = "nvim-web-devicons", with_config = false },

	-- keep which-key last for better loading speed
	{ pack = "which-key.nvim",    module = "which-key",         with_config = true },
}

local pack_loaded = {}

for _, entry in ipairs(modules) do
	if pack_loaded[entry.pack] == nil then
		pack_loaded[entry.pack] = true
		vim.cmd('packadd! ' .. entry.pack)
	end
end

for _, entry in ipairs(modules) do
	if entry.with_config then
		local config_path = 'config.modules.' .. entry.module
		require(config_path)
	else
		local mod = require(entry.module)
		if type(mod.setup) == 'function' then
			mod.setup({})
		end
	end
end
