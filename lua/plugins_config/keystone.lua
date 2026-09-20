require("keystone").setup({
	-- Language support
	lspconfig  = true,
	tsconfig   = true,
	completion = true,

	scope      = {
		scope = true, -- guide along the scope under the cursor
		guides = true, -- guide on every indent level
	},
	-- Editor behaviour
	tweaks     = {
		auto_nohlsearch = true,
        auto_nohlsearch_triggers = {
          on_insert     = true,  -- when entering insert mode
          on_win_change = true, -- when changing window
          delay         = 1000,     -- ms after the cursor last moved (0 = off)
        },
	},
	largefile  = true,
	marksigns  = true,
	animate    = true,

	-- Replaces something built in
	statusline = {
		sections = {
			left = { "mode", "git", "filename", "symbol_path" },
		},
	},
	select     = true,
	notify     = true,
	clue       = {
		delay = 350,    -- ms before the popup appears
		border = "rounded",
		max_desc_width = 120, -- crop long descriptions with …
		preset = true,  -- register built-in g/z/window descriptions
		builtin = { marks = true, registers = true },
		-- triggers = { ... } -- override the default trigger list
	},

	-- Adds a command, does nothing until you run it
	filetree   = true,
	explore    = true,
	symboltree = true,
	calltree   = true,
	unsaved    = true,
	bufdelete  = true,
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
