local modules = {

	-- { pack = "nvtoolkit.nvim",       module = "nvtoolkit" },
	--  { pack = "lualine.nvim",    module = "lualine" },

	{ pack = "osv.nvim",             module = "osv" },
	{ pack = "mason.nvim",           module = "mason" },
	{ pack = "gitsigns.nvim",        module = "gitsigns" },

	-- { pack = "loop.nvim",            module = "loop" },
	-- { pack = "loop-build.nvim",      module = "loop-build" },
	-- { pack = "loop-cmake.nvim",      module = "loop-cmake" },
	-- { pack = "loop-debug.nvim",      module = "loop-debug" },
	-- { pack = "loop-marks.nvim",      module = "loop-marks" },

	{ pack = "tomltools.nvim",       module = "tomltools" },
	{ pack = "easytasks.nvim",       module = "easytasks" },
	{ pack = "easytasks-debug.nvim", module = "easytasks-debug" },

	{ pack = "keystone.nvim",        module = "keystone.pick" },
	{ pack = "keystone.nvim",        module = "keystone.filetree" },
	{ pack = "keystone.nvim",        module = "keystone.explore" },
	{ pack = "keystone.nvim",        module = "keystone.lspwords" },
	{ pack = "keystone.nvim",        module = "keystone.notify" },
	{ pack = "keystone.nvim",        module = "keystone.animate" },
	{ pack = "keystone.nvim",        module = "keystone.objects" },
	{ pack = "keystone.nvim",        module = "keystone.colors" },
	{ pack = "keystone.nvim",        module = "keystone.focus" },
	{ pack = "keystone.nvim",        module = "keystone.complete" },
	{ pack = "keystone.nvim",        module = "keystone.statusline" },
	{ pack = "keystone.nvim",        module = "keystone.bookmarks" },
	{ pack = "flash.nvim",           module = "flash" },
	{ pack = "which-key.nvim",       module = "which-key" },
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
		local has_config = pcall(require, "plugins." .. entry.module)
		if not has_config then
		if type(mod.setup) == "function" then
			mod.setup({})
		end
	end
end
