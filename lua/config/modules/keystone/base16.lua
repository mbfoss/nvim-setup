
local palette = {
}

require('keystone.base16').setup({ palette = palette })


-- Virtual text colors derived from the palette
-- local virtual_text_colors = {
--   error = { fg = palette.base08, bg = palette.base00 },
--   warn  = { fg = palette.base09, bg = palette.base00 },
--   info  = { fg = palette.base0C, bg = palette.base00 },
--   hint  = { fg = palette.base0B, bg = palette.base00 },
-- }
--
-- -- Override Visual highlight *after* base16 loads
-- vim.api.nvim_set_hl(0, "Visual", { bg = "#6d7391", fg = "#eeeeee" })
-- -- Apply the virtual text highlight settings
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", virtual_text_colors.error)
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  virtual_text_colors.warn)
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  virtual_text_colors.info)
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  virtual_text_colors.hint)
--
-- vim.api.nvim_set_hl(0, "@lsp.type.property",       { fg = "#b8d8f8", bg = "NONE" }) -- soft sky blue
-- vim.api.nvim_set_hl(0, "cStorageClass",            { fg = "#f1c6f0", bg = "NONE" }) -- light pink-magenta
-- vim.api.nvim_set_hl(0, "Type",                     { fg = "#cdeccf", bg = "NONE" }) -- minty green
-- vim.api.nvim_set_hl(0, "@lsp.type.parameter.cpp",  { fg = "#ffe0b8", bg = "NONE" }) -- pale apricot
-- vim.api.nvim_set_hl(0, "lsp.type.enumMember.cpp",  { fg = "#f8d5b8", bg = "NONE" }) -- warm beige/orange
--
-- vim.api.nvim_set_hl(0, "TelescopeBorder",       { fg = "#a4b8d4" })
-- --
-- -- Pastel Garden terminal colors
-- vim.opt.termguicolors = true
-- vim.g.terminal_color_0  = "#2E2A38"
-- vim.g.terminal_color_1  = "#C78284"
-- vim.g.terminal_color_2  = "#A8E6CF"
-- vim.g.terminal_color_3  = "#FFF2B2"
-- vim.g.terminal_color_4  = "#A0C4FF"
-- vim.g.terminal_color_5  = "#E0B0FF"
-- vim.g.terminal_color_6  = "#B2F2E6"
-- vim.g.terminal_color_7  = "#ECEFF4"
--
-- vim.g.terminal_color_8  = "#6D6A75"
-- vim.g.terminal_color_9  = "#C78284"
-- vim.g.terminal_color_10 = "#B7EFC5"
-- vim.g.terminal_color_11 = "#FFF7C4"
-- vim.g.terminal_color_12 = "#B8D8FF"
-- vim.g.terminal_color_13 = "#E7CFFF"
-- vim.g.terminal_color_14 = "#CAFAE3"
-- vim.g.terminal_color_15 = "#F4F6F8"
