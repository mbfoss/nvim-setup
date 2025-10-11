---@type vim.lsp.Config
return {
  name = "pylsp",
  cmd = { "pylsp" },
  filetypes = { "python", "py" },
  root_dir = vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true })[1]),
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
