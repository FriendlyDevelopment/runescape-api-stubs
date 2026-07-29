---@meta

---@class ParamType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "DEFEND_SOUND_1" .
---@field typeName String The type of this config. Will always be "Param" .
---@field valueType ValueType The expected type of data this param will return.
---@field defaultValue any Returns the default value of this param config. The value data type ValueType is provided by valueType . If the param does not exist within the data structure being used, this is the value which will be returned.
ParamType = {}
