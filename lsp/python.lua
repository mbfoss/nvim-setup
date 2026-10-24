---@type vim.lsp.Config
return {
	name = "pylsp",
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", ".git" },
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = { enabled = true, maxLineLength = 100 },
				pylsp_mypy = { enabled = true },
				rope_autoimport = { enabled = true },
				jedi_completion = { fuzzy = true },
			},
		},
	},
}
