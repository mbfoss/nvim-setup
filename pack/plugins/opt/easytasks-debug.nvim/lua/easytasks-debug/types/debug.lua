---@class easytasks.debug.Def : easytasks.TaskTypeDef
local M = {}

---@param task table
---@param ctx  easytasks.RunCtx
---@return boolean
M.run = function(task, ctx)
    ctx.report("debug task runner not implemented")
    return false
end

M.schema = {
    description = "Definition of a `debug` task (runs via a DAP adapter)",
    ["x-order"] = {
        "name", "type", "if_running", "depends_on", "depends_order",
        "adapter", "request", "program", "args", "cwd", "env",
        "stop_on_entry", "console",
    },
    required   = { "adapter" },
    properties = {
        adapter       = {
            type        = "string",
            minLength   = 1,
            description = "Name of the DAP adapter to use (e.g. codelldb, delve, debugpy)",
        },
        request       = {
            description = "Whether to launch a new process or attach to a running one",
            oneOf = {
                { type = "string", const = "launch", description = "Start the program under the debugger" },
                { type = "string", const = "attach", description = "Attach to an already-running process" },
            },
        },
        program       = {
            type        = { "string", "null" },
            description = "Path to the executable or script to debug",
        },
        args          = {
            type        = { "array", "null" },
            description = "Command-line arguments passed to the debugged program",
            items       = { type = "string", description = "Argument" },
        },
        cwd           = {
            type        = { "string", "null" },
            description = "Working directory for the debugged process",
        },
        env           = {
            description = "Environment variables for the debugged process",
            oneOf = {
                { type = "string",  minLength = 1,  description = "Variables in VAR=VALUE format" },
                {
                    type                 = { "object", "null" },
                    description          = "Variables as a key-value map",
                    additionalProperties = { type = "string" },
                },
            },
        },
        stop_on_entry = {
            type        = { "boolean", "null" },
            description = "Pause the program immediately on launch before executing any code",
        },
        console       = {
            description = "Where to route the program's stdin/stdout/stderr",
            oneOf = {
                { type = "string", const = "integratedTerminal", description = "Neovim integrated terminal" },
                { type = "string", const = "externalTerminal",   description = "External terminal window" },
                { type = "string", const = "internalConsole",    description = "DAP client output panel" },
            },
        },
    },
}

return M
