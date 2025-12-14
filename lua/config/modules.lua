-- List of modules
local modules = {

	{ pack = "telescope.nvim",  module = "telescope",       with_config = true },
	-- {pack = "snacks.nvim",      module = "snacks",		    with_config = false },
	{ pack = "mini.nvim",       module = "mini.completion", with_config = true },
	{ pack = "mini.nvim",       module = "mini.base16",     with_config = true },
	{ pack = "mini.nvim",       module = "mini.sessions",   with_config = true },
	{ pack = "mini.nvim",       module = "mini.notify",     with_config = true },
	{ pack = "mini.nvim",       module = "mini.animate",    with_config = true },
	{ pack = "mini.nvim",       module = "mini.files",      with_config = true },
	{ pack = "lualine.nvim",    module = "lualine",         with_config = true },
	{ pack = "gitsigns.nvim",   module = "gitsigns",        with_config = false },
	{ pack = "which-key.nvim",  module = "which-key",       with_config = true },
	{ pack = "mason.nvim",      module = "mason",           with_config = false },
	{ pack = "loop.nvim",       module = "loop",            with_config = false },
	{ pack = "loop-cmake.nvim", module = "loop-cmake",      with_config = false },
}

local pack_loaded = {}

for _, entry in ipairs(modules) do
	if pack_loaded[entry.pack] == nil then
		pack_loaded[entry.pack] = true
		vim.cmd('packadd ' .. entry.pack)
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
