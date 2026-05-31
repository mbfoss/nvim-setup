require("easytasks-debug").setup({
	persistence_dir = vim.fn.getcwd() .. '/.easytasks'
})


vim.keymap.set("n", "<leader>d",  "<Nop>", { noremap = true })

-- Breakpoints
vim.keymap.set("n", "<leader>bl", ":EasytasksDebugBreakpoint list<CR>",        { desc = "List breakpoints",          silent = true })
vim.keymap.set("n", "<leader>bb", ":EasytasksDebugBreakpoint toggle<CR>",      { desc = "Toggle breakpoint",         silent = true })
vim.keymap.set("n", "<leader>bd", ":EasytasksDebugBreakpoint remove<CR>",      { desc = "Delete breakpoint",         silent = true })
vim.keymap.set("n", "<leader>bc", ":EasytasksDebugBreakpoint condition<CR>",   { desc = "Conditional breakpoint",    silent = true })
vim.keymap.set("n", "<leader>bL", ":EasytasksDebugBreakpoint logpoint<CR>",    { desc = "Set logpoint",              silent = true })
vim.keymap.set("n", "<leader>bE", ":EasytasksDebugBreakpoint enable_all<CR>",  { desc = "Enable all breakpoints",    silent = true })
vim.keymap.set("n", "<leader>bD", ":EasytasksDebugBreakpoint disable_all<CR>", { desc = "Disable all breakpoints",   silent = true })

-- Debug controls
vim.keymap.set("n", "<leader>ds", ":EasytasksDebugStep session<CR>",       { desc = "Select session",    silent = true })
vim.keymap.set("n", "<leader>dt", ":EasytasksDebugStep thread<CR>",        { desc = "Select thread",     silent = true })
vim.keymap.set("n", "<leader>df", ":EasytasksDebugStep frame<CR>",         { desc = "Select frame",      silent = true })
vim.keymap.set("n", "<leader>di", ":EasytasksDebugStep inspect<CR>",       { desc = "Inspect value",     silent = true })
vim.keymap.set("n", "<leader>dp", ":EasytasksDebugStep pause<CR>",         { desc = "Pause",             silent = true })
vim.keymap.set("n", "<leader>dl", ":EasytasksDebugStep step_in<CR>",       { desc = "Step in",           silent = true })
vim.keymap.set("n", "<leader>dh", ":EasytasksDebugStep step_out<CR>",      { desc = "Step out",          silent = true })
vim.keymap.set("n", "<leader>dj", ":EasytasksDebugStep step_over<CR>",     { desc = "Step over",         silent = true })
vim.keymap.set("n", "<leader>dk", ":EasytasksDebugStep step_back<CR>",     { desc = "Step back",         silent = true })
vim.keymap.set("n", "<leader>dc", ":EasytasksDebugStep continue<CR>",      { desc = "Continue",          silent = true })
vim.keymap.set("n", "<leader>dC", ":EasytasksDebugStep continue_all<CR>",  { desc = "Continue all",      silent = true })
vim.keymap.set("n", "<leader>dK", ":EasytasksDebugStep terminate_all<CR>", { desc = "Terminate all",     silent = true })

-- Alt keys
vim.keymap.set("n", "<A-l>", ":EasytasksDebugStep step_in<CR>",   { silent = true })
vim.keymap.set("n", "<A-h>", ":EasytasksDebugStep step_out<CR>",  { silent = true })
vim.keymap.set("n", "<A-j>", ":EasytasksDebugStep step_over<CR>", { silent = true })
vim.keymap.set("n", "<A-k>", ":EasytasksDebugStep step_back<CR>", { silent = true })
vim.keymap.set("n", "<A-;>", ":EasytasksDebugStep continue<CR>",  { silent = true })
vim.keymap.set("n", "<A-b>", ":EasytasksDebugBreakpoint toggle<CR>", { silent = true })
