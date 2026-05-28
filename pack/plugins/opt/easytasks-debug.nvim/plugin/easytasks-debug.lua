if vim.fn.has("nvim-0.10") ~= 1 then
    error("easytasks-debug.nvim requires Neovim >= 0.10")
end

local ok, easytasks = pcall(require, "easytasks")
if ok then
    easytasks.register_task_type("debug", "easytasks-debug.types.debug")
end
