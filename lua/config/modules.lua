local modules = {
	{ pack = "osv.nvim",        module = "osv" },
	{ pack = "mason.nvim",      module = "mason" },
	{ pack = "lualine.nvim",    module = "lualine" },
	{ pack = "gitsigns.nvim",   module = "gitsigns" },
	{ pack = "loop.nvim",       module = "loop" },
	{ pack = "loop-build.nvim", module = "loop-build" },
	{ pack = "loop-cmake.nvim", module = "loop-cmake" },
	{ pack = "loop-debug.nvim", module = "loop-debug" },
	{ pack = "loop-marks.nvim", module = "loop-marks" },
	{ pack = "keystone.nvim",   module = "keystone.pick" },
	{ pack = "keystone.nvim",   module = "keystone.filetree" },
	{ pack = "keystone.nvim",   module = "keystone.explore" },
	{ pack = "keystone.nvim",   module = "keystone.lspwords" },
	{ pack = "keystone.nvim",   module = "keystone.notify" },
	{ pack = "keystone.nvim",   module = "keystone.animate" },
	{ pack = "keystone.nvim",   module = "keystone.objects" },
	{ pack = "keystone.nvim",   module = "keystone.colors" },
	{ pack = "keystone.nvim",   module = "keystone.focus" },
	{ pack = "keystone.nvim",   module = "keystone.complete" },
	{ pack = "keystone.nvim",   module = "keystone.winbar" },
	{ pack = "easytasks.nvim",  module = "easytasks" },
	{ pack = "flash.nvim",      module = "flash" },
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
	local config_path = 'plugins.' .. entry.module
	local ok, _ = pcall(require, config_path)
	if not ok then
		local mod = require(entry.module)
		if type(mod.setup) == 'function' then
			mod.setup({})
		end
	end
end
