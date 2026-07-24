---@meta

---@class ObjType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "STEEL_BAR" .
---@field typeName String The type of this config. Will always be "Obj" .
---@field name String The display name of this config type.
---@field cost Int The 64-bit numeric value of this object.
---@field params any Array of ParamType Returns a list of all the ParamTypes stored in this config.
Obj = {}

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return any The corresponding output value.Returns param.defaultValue if the param is not found in the data structure.
function Obj:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool Whether a corresponding value exists in this config for ParamType .
function Obj:HasParam(param) end
