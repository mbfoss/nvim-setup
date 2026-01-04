 local miniclue = require('mini.clue')
miniclue.setup({
	-- Delay before showing clue window
	delay = 300,
	triggers = {
		-- Leader triggers
		{ mode = 'n', keys = '<Leader>' },
		{ mode = 'x', keys = '<Leader>' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = 'n', keys = 'g' },
		{ mode = 'x', keys = 'g' },

		-- Marks
		{ mode = 'n', keys = "'" },
		{ mode = 'n', keys = '`' },
		{ mode = 'x', keys = "'" },
		{ mode = 'x', keys = '`' },

		-- Registers
		{ mode = 'n', keys = '"' },
		{ mode = 'x', keys = '"' },
		{ mode = 'i', keys = '<C-r>' },
		{ mode = 'c', keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = 'n', keys = 'z' },
		{ mode = 'x', keys = 'z' },
	},

	clues = {
		-- Your Custom Leader Groups
		{ mode = 'n', keys = '<Leader>w',  desc = '+Window' },
		{ mode = 'n', keys = '<Leader>B',  desc = '+Buffer' },
		{ mode = 'n', keys = '<Leader>c',  desc = '+Code' },
		{ mode = 'v', keys = '<Leader>c',  desc = '+Code' },
		{ mode = 'n', keys = '<Leader>f',  desc = '+Find' },
		{ mode = 'n', keys = '<Leader>g',  desc = '+Git' },
		{ mode = 'n', keys = '<Leader>d',  desc = '+Debug' },
		{ mode = 'n', keys = '<Leader>dr', desc = '+Run in Debug' },
		{ mode = 'n', keys = '<Leader>o',  desc = '+Others' },
		{ mode = 'n', keys = '<Leader>S',  desc = '+Sessions' },
		{ mode = 'n', keys = '<Leader>p',  desc = '+Project' },
		{ mode = 'n', keys = '<Leader>pb', desc = '+Build' },
		{ mode = 'n', keys = '<Leader>pr', desc = '+Run' },
		{ mode = 'n', keys = '<Leader>l',  desc = '+Loop' },

		-- Built-in clue generators
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})
