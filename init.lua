require("config.options")
require("config.behavior")
require("config.highlight")
require("config.keys")
require("config.autocomplete")
require("config.keyhelp")
require("config.modules")
-- do last for lua lsp to find loaded packages
require("config.lsp")
require("config.calltree")
require("config.tools")

vim.cmd("packadd nvim.difftool")

vim.cmd("colorscheme pastelstone")
