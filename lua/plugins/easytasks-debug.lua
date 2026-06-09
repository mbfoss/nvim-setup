require("easytasks-debug").setup({
	persistence_dir = vim.fn.getcwd() .. '/.easytasks'
})


vim.keymap.set("n", "<leader>d",  "<Nop>", { noremap = true })

-- Breakpoints
vim.keymap.set("n", "<leader>bl", ":Task breakpoint list<CR>",        { desc = "List breakpoints",          silent = true })
vim.keymap.set("n", "<leader>bb", ":Task breakpoint toggle<CR>",      { desc = "Toggle breakpoint",         silent = true })
vim.keymap.set("n", "<leader>bd", ":Task breakpoint remove<CR>",      { desc = "Delete breakpoint",         silent = true })
vim.keymap.set("n", "<leader>bc", ":Task breakpoint condition<CR>",   { desc = "Conditional breakpoint",    silent = true })
vim.keymap.set("n", "<leader>bL", ":Task breakpoint logpoint<CR>",    { desc = "Set logpoint",              silent = true })
vim.keymap.set("n", "<leader>bE", ":Task breakpoint enable_all<CR>",  { desc = "Enable all breakpoints",    silent = true })
vim.keymap.set("n", "<leader>bD", ":Task breakpoint disable_all<CR>", { desc = "Disable all breakpoints",   silent = true })

-- Debug controls
vim.keymap.set("n", "<leader>ds", ":Task debug session<CR>",       { desc = "Select session",    silent = true })
vim.keymap.set("n", "<leader>dt", ":Task debug thread<CR>",        { desc = "Select thread",     silent = true })
vim.keymap.set("n", "<leader>df", ":Task debug frame<CR>",         { desc = "Select frame",      silent = true })
vim.keymap.set("n", "<leader>di", ":Task debug inspect<CR>",       { desc = "Inspect value",     silent = true })
vim.keymap.set("n", "<leader>dp", ":Task debug pause<CR>",         { desc = "Pause",             silent = true })
vim.keymap.set("n", "<leader>dl", ":Task debug step_in<CR>",       { desc = "Step in",           silent = true })
vim.keymap.set("n", "<leader>dh", ":Task debug step_out<CR>",      { desc = "Step out",          silent = true })
vim.keymap.set("n", "<leader>dj", ":Task debug step_over<CR>",     { desc = "Step over",         silent = true })
vim.keymap.set("n", "<leader>dk", ":Task debug step_back<CR>",     { desc = "Step back",         silent = true })
vim.keymap.set("n", "<leader>dc", ":Task debug continue<CR>",      { desc = "Continue",          silent = true })
vim.keymap.set("n", "<leader>dC", ":Task debug continue_all<CR>",  { desc = "Continue all",      silent = true })
vim.keymap.set("n", "<leader>dK", ":Task debug terminate_all<CR>", { desc = "Terminate all",     silent = true })

-- Alt keys
vim.keymap.set("n", "<A-l>", ":Task debug step_in<CR>",   { silent = true })
vim.keymap.set("n", "<A-h>", ":Task debug step_out<CR>",  { silent = true })
vim.keymap.set("n", "<A-j>", ":Task debug step_over<CR>", { silent = true })
vim.keymap.set("n", "<A-k>", ":Task debug step_back<CR>", { silent = true })
vim.keymap.set("n", "<A-;>", ":Task debug continue<CR>",  { silent = true })
vim.keymap.set("n", "<A-b>", ":Task breakpoint toggle<CR>", { silent = true })
