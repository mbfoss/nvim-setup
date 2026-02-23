
local palette = {
  base00 = '#2e2f33', -- background (soft charcoal, not pure black)
  base01 = '#3a3b40', -- status bar / panels
  base02 = '#505157', -- selection background
  base03 = '#6e6f77', -- comments, secondary text
  base04 = '#a0a2ad', -- subtle highlights
  base05 = '#dcdce4', -- main foreground (pastel off-white)
  base06 = '#f2f2f5', -- brighter text / UI fg
  base07 = '#ffffff', -- pure white (optional top highlight)
  base08 = '#e79c9c', -- ERROR - pastel red/pink
  base09 = '#f2c38f', -- WARN - soft orange
  base0A = '#f5e6a6', -- INFO alt - muted yellow
  base0B = '#b1d7b4', -- HINT / success - pastel green
  base0C = '#a8d8e1', -- INFO - pastel cyan
  base0D = '#a4b8e4', -- INFO alt - pastel blue
  base0E = '#cbb0e3', -- HINT alt - pastel purple
  base0F = '#e5c1c5', -- MISC - soft rose
}

-- Virtual text colors derived from the palette
local virtual_text_colors = {
  error = { fg = palette.base08, bg = palette.base00 },
  warn  = { fg = palette.base09, bg = palette.base00 },
  info  = { fg = palette.base0C, bg = palette.base00 },
  hint  = { fg = palette.base0B, bg = palette.base00 },
}

require('mini.base16').setup({ palette = palette })

-- Override Visual highlight *after* base16 loads
vim.api.nvim_set_hl(0, "Visual", { bg = "#6d7391", fg = "#eeeeee" })
-- Apply the virtual text highlight settings
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", virtual_text_colors.error)
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  virtual_text_colors.warn)
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  virtual_text_colors.info)
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  virtual_text_colors.hint)

vim.api.nvim_set_hl(0, "@lsp.type.property",       { fg = "#b8d8f8", bg = "NONE" }) -- soft sky blue
vim.api.nvim_set_hl(0, "cStorageClass",            { fg = "#f1c6f0", bg = "NONE" }) -- light pink-magenta
vim.api.nvim_set_hl(0, "Type",                     { fg = "#cdeccf", bg = "NONE" }) -- minty green
vim.api.nvim_set_hl(0, "@lsp.type.parameter.cpp",  { fg = "#ffe0b8", bg = "NONE" }) -- pale apricot
vim.api.nvim_set_hl(0, "lsp.type.enumMember.cpp",  { fg = "#f8d5b8", bg = "NONE" }) -- warm beige/orange

vim.api.nvim_set_hl(0, "TelescopeBorder",       { fg = "#a4b8d4" })

-- Catppuccin Mocha-inspired ANSI palette
vim.g.terminal_color_0  = "#1e1e2e"
vim.g.terminal_color_1  = "#f38ba8"
vim.g.terminal_color_2  = "#a6e3a1"
vim.g.terminal_color_3  = "#f9e2af"
vim.g.terminal_color_4  = "#89b4fa"
vim.g.terminal_color_5  = "#f5c2e7"
vim.g.terminal_color_6  = "#94e2d5"
vim.g.terminal_color_7  = "#bac2de"

vim.g.terminal_color_8  = "#585b70"
vim.g.terminal_color_9  = "#f38ba8"
vim.g.terminal_color_10 = "#a6e3a1"
vim.g.terminal_color_11 = "#f9e2af"
vim.g.terminal_color_12 = "#89b4fa"
vim.g.terminal_color_13 = "#f5c2e7"
vim.g.terminal_color_14 = "#94e2d5"
vim.g.terminal_color_15 = "#a6adc8"
