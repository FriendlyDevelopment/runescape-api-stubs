---@meta

---@class VarType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "FRIEND_SORT_MODE" .
---@field typeName String The type of this config. Will one of "VarClient" , "VarPlayer" , "VarPlayerGroup" , "VarClan" , "VarClanSettings" , "VarNPC" or "VarObj" .
---@field value IntegerString Returns the current value of this variable config.The return type is determined by the variable config.
---@field isVarBit Bool Whether this config type is a VarBit .
---@field baseVar VarType Returns the base VarType , if this config is a VarBit .Otherwise returns nil .
---@field varBitMask Int Returns a bitmask showing the range of bits used, if this config is a VarBit .Otherwise returns nil .A VarBit using bits 3-5 would return a value of 56 ( 0x38 , 0b111000 ).
VarType = {}
