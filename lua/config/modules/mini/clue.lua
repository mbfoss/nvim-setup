local miniclue = require('mini.clue')

-- Helper to truncate descriptions
local function truncate_desc(clues, max_len)
	for _, c in ipairs(clues) do
		if c.desc and #c.desc > max_len then
			c.desc = c.desc:sub(1, max_len) .. '…'
		end
	end
	return clues
end

-- Helper to truncate and pad for columns
local function pad_for_columns(clues, max_len)
	local new_clues = {}
	local col_width = max_len + 2 -- space between columns
	local col_count = 2        -- desired number of columns

	for _, c in ipairs(clues) do
		-- truncate description
		local desc = c.desc or ''
		if #desc > max_len then desc = desc:sub(1, max_len) .. '…' end

		-- add spaces to pad column
		desc = desc .. string.rep(' ', col_width - #desc)

		-- create new clue with padded description
		table.insert(new_clues, { mode = c.mode, keys = c.keys, desc = desc })
	end

	return new_clues
end

local max_width = math.floor(vim.o.columns * 0.20)

miniclue.setup({
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
		-- Custom group name
		{ mode = 'n', keys = '<Leader>f', desc = '+Find' },
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.builtin_completion(),
		truncate_desc(miniclue.gen_clues.g(), max_width),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
	window = {
		config = {
			anchor = 'SW',
			border = 'single',
			-- row = vim.o.lines - 2,
			-- col = 0,
			width = max_width, -- wider to allow multi-column
			-- height = math.floor(vim.o.lines * 0.6),   -- taller popup
		},
		delay = 200,
	},
})

