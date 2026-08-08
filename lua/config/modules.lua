local modules = {

	{ pack = "osv.nvim",        module = "osv" },
	{ pack = "mason.nvim",      module = "mason" },
	{ pack = "gitsigns.nvim",   module = "gitsigns" },

	-- { pack = "tomltools.nvim",  module = "tomltools" },
	{ pack = "tomltasks.nvim",  module = "tomltasks" },
	{ pack = "ezdap.nvim",      module = "ezdap" },
	-- { pack = "nvim-dap",        module = "dap" },

	{ pack = "dock.nvim",     module = "dock" },
	-- { pack = "snacks.nvim",     module = "snacks" },
	{ pack = "ezpick.nvim",     module = "ezpick" },
	{ pack = "keystone.nvim",   module = "keystone.filetree" },
	{ pack = "keystone.nvim",   module = "keystone.symboltree" },
	{ pack = "keystone.nvim",   module = "keystone.calltree" },
	{ pack = "keystone.nvim",   module = "keystone.explore" },
	{ pack = "keystone.nvim",   module = "keystone.notify" },
	{ pack = "keystone.nvim",   module = "keystone.animate" },
	{ pack = "keystone.nvim",   module = "keystone.completion" },
	-- { pack = "keystone.nvim",   module = "keystone.lspcomp" },
	-- { pack = "mini.nvim",   module = "mini.completion" },
	{ pack = "keystone.nvim",   module = "keystone.statusline" },
	{ pack = "keystone.nvim",   module = "keystone.bookmarks" },
	{ pack = "keystone.nvim",   module = "keystone.tsconfig" },
	{ pack = "keystone.nvim",   module = "keystone.lspconfig" },
	{ pack = "keystone.nvim",   module = "keystone.clue" },
	{ pack = "keystone.nvim",   module = "keystone.tweaks" },
	{ pack = "keystone.nvim",   module = "keystone.unsaved" },
	{ pack = "keystone.nvim",   module = "keystone.largefile" },
	{ pack = "keystone.nvim",   module = "keystone.select" },
	{ pack = "keystone.nvim",   module = "keystone.bufdelete" },
	{ pack = "keystone.nvim",   module = "keystone.marksigns" },
	{ pack = "gittools.nvim",   module = "gittools" },
	{ pack = "flash.nvim",      module = "flash" },
	{ pack = "claudecode.nvim", module = "claudecode" },
	{ pack = "cmake.nvim",      module = "cmake" },
	-- { pack = "which-key.nvim",  module = "which-key" },
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
