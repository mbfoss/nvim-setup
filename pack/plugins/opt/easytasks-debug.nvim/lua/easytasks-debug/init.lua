local M = {}

--- Register all provided task types with easytasks using lazy module paths.
---@param easytasks table easytasks public API (result of require("easytasks"))
function M.register(easytasks)
    easytasks.register_task_type("debug", "easytasks-debug.types.debug")
end

return M
