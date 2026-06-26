require("easydap").setup({
	persistence_dir = vim.fn.getcwd() .. '/.easytasks'
})


vim.keymap.set("n", "<leader>d",  "<Nop>", { noremap = true })

-- Breakpoints
vim.keymap.set("n", "<leader>bl", ":Debug breakpoint list<CR>",        { desc = "List breakpoints",          silent = true })
vim.keymap.set("n", "<leader>bb", ":Debug breakpoint toggle<CR>",      { desc = "Toggle breakpoint",         silent = true })
vim.keymap.set("n", "<leader>bd", ":Debug breakpoint remove<CR>",      { desc = "Delete breakpoint",         silent = true })
vim.keymap.set("n", "<leader>bc", ":Debug breakpoint condition<CR>",   { desc = "Conditional breakpoint",    silent = true })
vim.keymap.set("n", "<leader>bL", ":Debug breakpoint logpoint<CR>",    { desc = "Set logpoint",              silent = true })
vim.keymap.set("n", "<leader>bE", ":Debug breakpoint enable_all<CR>",  { desc = "Enable all breakpoints",    silent = true })
vim.keymap.set("n", "<leader>bD", ":Debug breakpoint disable_all<CR>", { desc = "Disable all breakpoints",   silent = true })

-- Debug controls
vim.keymap.set("n", "<leader>ds", ":Debug session<CR>",       { desc = "Select session",    silent = true })
vim.keymap.set("n", "<leader>dt", ":Debug thread<CR>",        { desc = "Select thread",     silent = true })
vim.keymap.set("n", "<leader>df", ":Debug frame<CR>",         { desc = "Select frame",      silent = true })
vim.keymap.set({"n", "x"}, "<leader>di", ":Debug inspect<CR>",       { desc = "Inspect value",     silent = true })
vim.keymap.set("n", "<leader>dp", ":Debug pause<CR>",         { desc = "Pause",             silent = true })
vim.keymap.set("n", "<leader>dl", ":Debug step_in<CR>",       { desc = "Step in",           silent = true })
vim.keymap.set("n", "<leader>dh", ":Debug step_out<CR>",      { desc = "Step out",          silent = true })
vim.keymap.set("n", "<leader>dj", ":Debug step_over<CR>",     { desc = "Step over",         silent = true })
vim.keymap.set("n", "<leader>dk", ":Debug step_back<CR>",     { desc = "Step back",         silent = true })
vim.keymap.set("n", "<leader>dc", ":Debug continue<CR>",      { desc = "Continue",          silent = true })
vim.keymap.set("n", "<leader>dC", ":Debug continue_all<CR>",  { desc = "Continue all",      silent = true })
vim.keymap.set("n", "<leader>dK", ":Debug terminate_all<CR>", { desc = "Terminate all",     silent = true })

-- Alt keys
vim.keymap.set("n", "<A-l>", ":Debug step_in<CR>",   { silent = true })
vim.keymap.set("n", "<A-h>", ":Debug step_out<CR>",  { silent = true })
vim.keymap.set("n", "<A-j>", ":Debug step_over<CR>", { silent = true })
vim.keymap.set("n", "<A-k>", ":Debug step_back<CR>", { silent = true })
vim.keymap.set("n", "<A-;>", ":Debug continue<CR>",  { silent = true })
vim.keymap.set("n", "<A-b>", ":Debug breakpoint toggle<CR>", { silent = true })
