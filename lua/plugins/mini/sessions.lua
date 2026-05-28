local sessions = require("mini.sessions")

sessions.setup({
    -- You can change this directory to whatever you like
    directory = vim.fn.stdpath("data") .. "/sessions",
    autoread = false, -- don't load automatically on startup
    autowrite = true, -- save current session on :q if one is active
})

local function save_session_as()
  vim.ui.input({ prompt = "Save session as: " }, function(name)
    if name and name ~= "" then
      sessions.write(name)
      print("Session saved: " .. name)
    end
  end)
end

-- Keymaps
vim.keymap.set("n", "<leader>Sl", function() sessions.select('read', { prompt = "Load session:"})end, { desc = "Load session" })
vim.keymap.set("n", "<leader>Ss", function() sessions.select('write', { prompt = "Save session:"}) end, { desc = "Save session" })
vim.keymap.set("n", "<leader>Sd", function() sessions.select('delete', { prompt = "Delete session:"}) end, { desc = "Delete session" })
vim.keymap.set("n", "<leader>Sw", save_session_as, { desc = "Save session as" })
