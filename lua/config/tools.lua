vim.api.nvim_create_user_command("DiffSaved", function()
  vim.cmd("vert new")
  vim.bo.buftype = "nofile"
  vim.cmd("read ++edit #")
  vim.cmd("0delete _")
  vim.cmd("diffthis")
  vim.cmd("wincmd p")
  vim.cmd("diffthis")

  vim.cmd("windo wincmd x") -- swap left/right buffers
end, {})
