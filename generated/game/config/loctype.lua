---@meta

---@class LocType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "WINCHLADDER1" .
---@field typeName String The type of this config. Will always be "Loc" .
---@field name String The display name of this config type.
---@field fastPicking Bool Whether a LocEntity using this config uses a lower accuracy, but faster, picking test on triangles.
---@field params any Array of ParamType Returns a list of all the ParamTypes stored in this config.
Loc = {}

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return any The corresponding output value.Returns param.defaultValue if the param is not found in the data structure.
function Loc:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool Whether a corresponding value exists in this config for ParamType .
function Loc:HasParam(param) end
