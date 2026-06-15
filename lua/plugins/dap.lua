local dap = require("dap")

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb", -- or full path to codelldb
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch binary",
    type = "codelldb",
    request = "launch",

    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/",
        "file"
      )
    end,

    cwd = "${workspaceFolder}",
    stopOnEntry = false,

    args = function()
      local args_string = vim.fn.input("Arguments: ")
      return vim.split(args_string, " +")
    end,
  },
}

-- Reuse for C and Rust
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
