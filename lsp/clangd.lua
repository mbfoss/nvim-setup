-- ~/.config/nvim/lua/lsp/clangd.lua
-- Static clangd LSP configuration with dynamic -j for Neovim (vim.lsp.enable)

-- Static paths (adjust for your system)
local CLANGD_PATH = "clangd"
-- local CLANG_RESOURCE_DIR = "/usr/lib/llvm-18/lib/clang/18"

-- Function to determine number of threads
local function clangd_jobs()
  local ok, result = pcall(function()
    local cpus = vim.loop.cpu_info()
    local count = #cpus
    if count < 1 then count = 1 end
    -- Use half of cores, at least 1
    return math.max(1, math.ceil(count / 2))
  end)
  if ok then
    return result
  else
    return 4 -- fallback
  end
end

return {
  name = "clangd",
  cmd = {
    CLANGD_PATH,
    "-j=" .. clangd_jobs(),       -- dynamic number of threads
    "--background-index",         -- index project files
    "--clang-tidy",               -- enable clang-tidy diagnostics
    "--completion-style=detailed",-- detailed completion info
    "--header-insertion=iwyu",    -- include-what-you-use
    "--cross-file-rename=true",   -- rename across files
    "--pch-storage=disk",         -- store PCH on disk
    "--limit-references=500",     -- limit references returned
    "--limit-results=50",         -- limit completion results
    "--enable-config",            -- respect .clangd config files
    --"--resource-dir=" .. CLANG_RESOURCE_DIR,
  },

  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },

  init_options = {
    fallbackFlags = { "-std=c++20" },
  },

  settings = {
    clangd = {
      semanticHighlighting = true,
      inlayHints = {
        enabled = "auto",
        parameterNames = true,
        deducedTypes = true,
      },
    },
  },

  on_attach = function(client, bufnr)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gr", vim.lsp.buf.references, "Find references")
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
  end,

  capabilities = vim.lsp.protocol.make_client_capabilities(),
}
