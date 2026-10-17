vim.keymap.set('n', ']]', function() require('lspnav.motions').next_function() end, { desc = 'Next function (LSP)' })
vim.keymap.set('n', '[[', function() require('lspnav.motions').prev_function() end, { desc = 'Previous function (LSP)' })
vim.keymap.set('n', ']t', function() require('lspnav.motions').next_type() end, { desc = 'Next type (LSP)' })
vim.keymap.set('n', '[t', function() require('lspnav.motions').prev_type() end, { desc = 'Previous type (LSP)' })

vim.keymap.set('n', '<leader>ct', '<cmd>Lspnav calltree<cr>', { desc = 'Show call tree' })
vim.keymap.set('n', '<leader>cS', '<cmd>Lspnav symboltree<cr>', { desc = 'Show symbol tree' })
vim.keymap.set('n', '<leader>cr', '<cmd>Lspnav references<cr>', { desc = 'Show references window' })
