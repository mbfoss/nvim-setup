vim.o.pumheight = 15        -- max height of completion menu
vim.o.complete = ".,w,b,u"

-- Helper: Convert keys to termcodes (for expr = true mappings)
local function feedkeys(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

-- Smart <Tab>: snippet → completion → real tab
vim.keymap.set("i", "<Tab>", function()
  if vim.snippet and vim.snippet.active({direction = 1}) then
    vim.schedule(function() vim.snippet.jump(1) end)
    return ''
  elseif vim.fn.pumvisible() == 1 then
    return feedkeys("<C-n>")  -- Navigate completion menu
  else
    return feedkeys("<Tab>")  -- Insert actual Tab
  end
end, { expr = true, noremap = true, silent = true })

-- Smart <S-Tab>: snippet → completion → real shift-tab
vim.keymap.set("i", "<S-Tab>", function()
  if vim.snippet and vim.snippet.active({direction = -1}) then
    vim.schedule(function() vim.snippet.jump(-1) end)
    return ''
  elseif vim.fn.pumvisible() == 1 then
    return feedkeys("<C-p>")  -- Navigate completion menu
  else
    return feedkeys("<S-Tab>")  -- Insert actual Shift-Tab
  end
end, { expr = true, noremap = true, silent = true })
