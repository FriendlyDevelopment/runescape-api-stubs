---@meta

---@class StructType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "BOSS_INSTANCE_STALKER_BOSS" .
---@field typeName String The type of this config. Will always be "Struct" .
---@field paramCount Int The total number of param-data pairs in this struct.
---@field paramValues Array of [ ParamType , ? ] All param-data pairs contained in this struct.Each pair in the array is a 2-element data array of [ ParamType, paramValueType ] .
Struct = {}

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return ? The corresponding output value.Returns param.defaultValue if the param is not found in the data structure.
function Struct:GetParamValue(param) end
