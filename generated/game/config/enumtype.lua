---@meta

---@class EnumType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "CRAFTING_PLATINUM_TABLE" .
---@field typeName String The type of this config. Will always be "Enum" .
---@field valueCount Int The total number of key-value pairs in this enum.
---@field values ?,?[][] All data value pairs contained in this enum. Each pair in the array is a 2-element data array of [ inputValueType, outputValueType ] .
---@field inputValueType ValueType The expected type of data this enum expects as an input value.
---@field outputValueType ValueType The expected type of data this enum expects as an output value.
Enum = {}

---Returns the corresponding output value for the given input value.
---@param inputValue any The input data value. Data value type must match the ValueType of property inputValueType .
---@return any The corresponding output value. Returns nil if the input value is not found in the data structure.
function Enum:GetOutputValue(inputValue) end

---Returns the whether the given output value can be returned from this enum.
---@param outputValue any The output data value. Data value type must match the ValueType of property outputValueType .
---@return Bool Returns whether the given value was found in the list of potential output values.
function Enum:HasOutputValue(outputValue) end

---Returns all input values that will return the given output value from this enum.
---@param outputValue any The output data value. Data value type must match the ValueType of property outputValueType .
---@return any[] Returns an array of values which will result in the given output value. Returns an empty array if the output value is not found.
function Enum:GetInputValues(outputValue) end
