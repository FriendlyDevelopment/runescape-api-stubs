---@meta

---@class Core
Core = {}

---Outputs a message containing the contents of the provided arguments separated by a space to the Lua console.
---@param ... any
function print(...) end

---Outputs a plugin-associated message containing the contents of the provided arguments separated by a space to the Lua console.
---@param format String
---@param ... any
function log(format, ...) end

---Executes the provided string as a ingame console command.
---@param command String
function ExecuteConsoleCommand(command) end

---To achieve the later you just need to call the loadfile function with the path to the file you want to load, omitting its extension. This will then return the result of executing that file, or nil if execution files or the file doesn't exist.
---@param path string
---@return any
function loadfile(path) end

