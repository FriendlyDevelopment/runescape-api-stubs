---@meta

---Enumeration representing the type of the an entry in the persistent DB.
---@enum PersistentDBType
PersistentDBType = {
    Bool = "Bool", -- True/false entry
    Int = "Int", -- Integer entry
    Float = "Float", -- Floating point entry
    String = "String", -- Text-based entry
    StructuredData = "StructuredData", -- Entry that gets serialized directly to/from Lua tables
}

---@class PersistentDB
PersistentDB = {}

---Retrieves the entry associated with the provided key and the current plugin from the persistent DB, returning its value.
---@param key String The name associated with a persistent DB entry.
---@return Bool|Int|Float|String|Table|nil Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:Get(key) end

---@param key String The name associated with a persistent DB entry.
---@return Bool? Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:GetBool(key) end

---@param key String The name associated with a persistent DB entry.
---@return Int? Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:GetInt(key) end

---@param key String The name associated with a persistent DB entry.
---@return Float? Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:GetFloat(key) end

---@param key String The name associated with a persistent DB entry.
---@return String? Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:GetString(key) end

---@param key String The name associated with a persistent DB entry.
---@return Table? Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:GetStructuredData(key) end

---Stores the provided value in the persistent DB, associating it with the specified key and the current plugin.
---@param key String The name associated with a persistent DB entry.
---@param value Bool|Int|Float|String|Table
---@return Bool|Int|Float|String|Table|nil Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:Set(key, value) end

---@param key String The name associated with a persistent DB entry.
---@param value Bool
---@return Bool Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:SetBool(key, value) end

---@param key String The name associated with a persistent DB entry.
---@param value Int
---@return Bool Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:SetInt(key, value) end

---@param key String The name associated with a persistent DB entry.
---@param value Float
---@return Bool Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:SetFloat(key, value) end

---@param key String The name associated with a persistent DB entry.
---@param value String
---@return Bool Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:SetString(key, value) end

---@param key String The name associated with a persistent DB entry.
---@param value Table
---@return Bool Value associated with the entry matching the provided key, or nil if there is no such entry. The returned type matches the type originally used when storing that entry.
function PersistentDB:SetStructuredData(key, value) end

---Checks if an entry exists in the persistent DB with the specified key for the current plugin.
---@param key String The name associated with a persistent DB entry.
---@return Bool True if an entry with the provided key exists, false otherwise.
function PersistentDB:CheckExists(key) end

---Checks if an entry exists in the persistent DB with the specified key and is of the specified type.
---@param key String The name associated with a persistent DB entry.
---@param type PersistentDBType The type we're expecting for this entry.
---@return Bool True if an entry with the provided key exists with the provided type, false otherwise.
function PersistentDB:CheckExistsTyped(key, type) end

---Calls the provided callback once per persistent DB entry associated with this plugin.
---@param callback function (key : String, value : Bool/Int/Float/String/Table) -> Bool Function called once for each persistent DB entry for this plugin. Iteration is stopped if it returns true, and continues otherwise.
---@return Int The number of entries iterated on
function PersistentDB:IterateEntries(callback) end

---Removes an entry associated with the current plugin and matching the provided key from the persistent DB.
---@param key String The name associated with a persistent DB entry.
---@return Bool True if this operation completed successfully, false otherwise.
function PersistentDB:Delete(key) end

---Clears all persistent DB entries associated with this plugin.
---@return Bool True if this operation completed successfully, false otherwise.
function PersistentDB:Clear() end
