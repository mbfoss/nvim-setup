vim.api.nvim_create_user_command("AutocmdDump", function()
    local ac = vim.api.nvim_get_autocmds({})
    local lines = vim.split(vim.inspect(ac), "\n")

    vim.cmd("new")
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})
