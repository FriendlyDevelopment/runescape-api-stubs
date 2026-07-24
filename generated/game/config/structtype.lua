---@meta

---@class StructType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "BOSS_INSTANCE_STALKER_BOSS" .
---@field typeName String The type of this config. Will always be "Struct" .
---@field params any Array of ParamType Returns a list of all the ParamTypes stored in this config.
Struct = {}

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return any The corresponding output value.Returns param.defaultValue if the param is not found in the data structure.
function Struct:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool Whether a corresponding value exists in this config for ParamType .
function Struct:HasParam(param) end
