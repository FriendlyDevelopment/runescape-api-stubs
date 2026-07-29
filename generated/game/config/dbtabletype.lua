---@meta

---@class DBTableType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "INVENT_PERK_TABLE" .
---@field typeName String The type of this config. Will always be "DBTable" .
---@field columnCount Int The total number columns in this table.
DBTable = {}

---Returns the number of values in the given column.
---@param columnIndex Int The column index to check. Column index values are 1-indexed.
---@return Int How many values are available for the given column index.
function DBTable:GetColumnValueCount(columnIndex) end

---Returns all ValueTypes for each value in the given column.
---@param columnIndex Int The column index to check. Column index values are 1-indexed.
---@return ValueType[] An array containing a ValueType for each value in the given column index.
function DBTable:GetColumnValueTypes(columnIndex) end

---Returns whether a given column in the table has any default values.
---@param columnIndex Int The column index to check. Column index values are 1-indexed.
---@return Bool Whether the given column index can provide default values.
function DBTable:GetColumnHasDefaultValues(columnIndex) end

---Returns all default values in the given column.
---@param columnIndex Int The column index to check. Column index values are 1-indexed.
---@return any[] An array containing each default value in the given column index. This array may be empty, or contain nil values. Use GetColumnValueTypes to determine the types of the values returned by this method.
function DBTable:GetColumnDefaultValues(columnIndex) end
