require("mini.extra").setup()

local pick  = require("mini.pick")
local extra = require("mini.extra")

-- =========================================================
-- PICKERS (Search / Find)
-- =========================================================

-- Resume: Not a function, use the builtin picker
vim.keymap.set("n", "<leader>fa", function() pick.builtin.resume() end, { desc = "Resume picker" })

-- Builtin: List all available pickers
vim.keymap.set("n", "<leader>fo", function() pick.builtin.builtin() end, { desc = "All pickers" })

-- Files: Standard file picker
vim.keymap.set("n", "<leader>ff", function() pick.builtin.files() end, { desc = "Find files" })

-- Grep: Use grep_live for "as-you-type" search
vim.keymap.set("n", "<leader>fg", function() pick.builtin.grep_live() end, { desc = "Grep live" })

-- Buffers: Standard buffer picker
vim.keymap.set("n", "<leader>fb", function() pick.builtin.buffers() end, { desc = "Buffers" })

-- Config files
vim.keymap.set("n", "<leader>fc", function()
	pick.builtin.files(nil, {
		source = { cwd = vim.fn.stdpath("config") }
	})
end, { desc = "Find config files" })

-- Recent files: Verified in mini.extra
vim.keymap.set("n", "<leader>fp", function() extra.pickers.oldfiles() end, { desc = "Recent files" })

-- Buffer lines: Verified in mini.extra
vim.keymap.set("n", "<leader>ft", function() extra.pickers.buf_lines() end, { desc = "Buffer lines" })

-- History: Unified function in mini.extra
vim.keymap.set("n", "<leader>f/", function() extra.pickers.history({ scope = "/" }) end, { desc = "Search history" })
vim.keymap.set("n", "<leader>fh", function() extra.pickers.history({ scope = ":" }) end, { desc = "Command history" })

-- Registers: Verified in mini.extra
vim.keymap.set("n", '<leader>f"', function() extra.pickers.registers() end, { desc = "Registers" })

-- Jumplist & Quickfix: Use the 'list' function with scope
vim.keymap.set("n", "<leader>fj", function() extra.pickers.list({ scope = "jump" }) end, { desc = "Jumplist" })
vim.keymap.set("n", "<leader>fq", function() extra.pickers.list({ scope = "quickfix" }) end, { desc = "Quickfix list" })

-- Marks: Verified in mini.extra
vim.keymap.set("n", "<leader>fm", function() extra.pickers.marks() end, { desc = "Marks" })

-- Spellsuggest: Verified in mini.extra
vim.keymap.set("n", "<leader>fs", function() extra.pickers.spellsuggest() end, { desc = "Spell suggestions" })

-- =========================================================
-- LSP / DIAGNOSTICS
-- =========================================================

-- Diagnostics: The function is 'diag', not 'diagnostic'
vim.keymap.set("n", "<leader>fd", function() extra.pickers.diagnostic({ scope = "current" }) end,
	{ desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>fD", function() extra.pickers.diagnostic({ scope = "all" }) end,
	{ desc = "Workspace diagnostics" })

-- LSP: Unified function for references and symbols
vim.keymap.set("n", "<leader>fr", function() extra.pickers.lsp({ scope = "references" }) end, { desc = "LSP references" })
vim.keymap.set("n", "<leader>fS", function() extra.pickers.lsp({ scope = "document_symbol" }) end,
	{ desc = "Document symbols" })

-- =========================================================
-- GIT
-- =========================================================

-- Branches: Verified
vim.keymap.set("n", "<leader>gb", function() extra.pickers.git_branches() end, { desc = "Git branches" })

-- Commits: Verified
vim.keymap.set("n", "<leader>gl", function() extra.pickers.git_commits() end, { desc = "Git log" })

-- Files: Verified
vim.keymap.set("n", "<leader>gf", function() extra.pickers.git_files() end, { desc = "Git files" })

-- Status/Diff: Verified via git_hunks
vim.keymap.set("n", "<leader>gd", function() extra.pickers.git_hunks({ scope = "worktree" }) end,
	{ desc = "Git status (diff)" })
