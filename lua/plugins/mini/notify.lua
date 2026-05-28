local n = require('mini.notify')
n.setup()
vim.notify = n.make_notify()
