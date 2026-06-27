---@meta

---@class DBRowType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "INVENT_PERK_LOOTING" .
---@field typeName String The type of this config. Will always be "DBRow" .
---@field columnCount Int The total number columns in this table.
---@field ownerDBTable DBTable The parent table config for this row config.
DBRow = {}

---Returns the number of values in the given column.
---@param columnIndex Int The column index to check.Column index values are 1-indexed.
---@return Int How many values are available for the given column index.
function DBRow:GetColumnValueCount(columnIndex) end

---Returns all ValueTypes for each value in the given column.
---@param columnIndex Int The column index to check.Column index values are 1-indexed.
---@return ValueType[] An array containing a ValueType for each value in the given column index.
function DBRow:GetColumnValueTypes(columnIndex) end

---Returns all values in the given column.
---@param columnIndex Int The column index to check.Column index values are 1-indexed.
---@return ?,...[] An array containing each value in the given column index.This array may be empty, or contain nil values.Use GetColumnValueTypes to determine the types of the values returned by this method.
function DBRow:GetColumnValues(columnIndex) end
