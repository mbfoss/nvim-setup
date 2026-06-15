require("config.options")
require("config.behavior")
require("config.highlight")
require("config.keys")
require("config.autocomplete")
require("config.keyhelp")
require("config.modules")
-- do last for lua lsp to find loaded packages
require("config.lsp")
require("config.calltree")
require("config.tools")

vim.cmd("packadd nvim.difftool")

-- Simple Lua Profiler for Neovim
local Profiler = {
  times = {},
  counts = {},
  stack = {},
  active = false
}

function Profiler.start()
  if Profiler.active then return print("Profiler is already running.") end
  
  local uv = vim.loop
  Profiler.times = {}
  Profiler.counts = {}
  Profiler.stack = {}
  Profiler.active = true

  debug.sethook(function(event)
    -- Get function name, source file, and line defined
    local info = debug.getinfo(2, "nS")
    if not info then return end

    -- Create a unique key to distinguish between different anonymous functions
    local id = string.format("%s:%d", info.short_src, info.linedefined or 0)
    if info.name then id = info.name .. " (" .. id .. ")" end

    if event == "call" or event == "tail call" then
      table.insert(Profiler.stack, { id = id, time = uv.hrtime() })
    else
      local entry = table.remove(Profiler.stack)
      if entry and entry.id == id then
        local elapsed = uv.hrtime() - entry.time
        Profiler.times[id] = (Profiler.times[id] or 0) + elapsed
        Profiler.counts[id] = (Profiler.counts[id] or 0) + 1
      end
    end
  end, "crt")

  print("Profiling started... Run your slow commands, then type :ProfileStop")
end

function Profiler.stop()
  if not Profiler.active then return print("Profiler is not running.") end
  
  debug.sethook() -- Disable the hook immediately
  Profiler.active = false

  local sorted = {}
  for id, t in pairs(Profiler.times) do
    table.insert(sorted, { 
      name = id, 
      total = t / 1e6, 
      calls = Profiler.counts[id],
      avg = (t / Profiler.counts[id]) / 1e6
    })
  end
  table.sort(sorted, function(a, b) return a.total > b.total end)

  -- Create a scratch buffer for results
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "Profiler_Results_" .. os.date("%H%M%S"))
  
  local lines = { 
    "Top Lua Hotspots (Times in ms):",
    string.format("%-60s | %10s | %8s | %10s", "Function/Location", "Total", "Calls", "Avg"),
    string.rep("-", 95) 
  }

  for i = 1, math.min(100, #sorted) do
    local f = sorted[i]
    table.insert(lines, string.format("%-60s | %10.2f | %8d | %10.2f", f.name, f.total, f.calls, f.avg))
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'text', { buf = buf })
  
  -- Open in a vertical split
  vim.cmd("vsplit")
  vim.api.nvim_set_current_buf(buf)
  print("Profiling complete.")
end

-- Create Neovim commands
vim.api.nvim_create_user_command("ProfileStart", Profiler.start, {})
vim.api.nvim_create_user_command("ProfileStop", Profiler.stop, {})

vim.cmd("colorscheme pastelstone")
