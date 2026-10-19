---@meta

---Determines how individual objects stack with objects of the same type.
---@enum ObjStackType
ObjStackType = {
    SOMETIMES = "SOMETIMES", -- 0
    ALWAYS = "ALWAYS", -- 1
    NEVER = "NEVER", -- 2
}

---@class ObjType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "STEEL_BAR" .
---@field typeName String The type of this config. Will always be "Obj" .
---@field name String The display name of this config type.
---@field isMembers Bool Whether this object is for members.
---@field category Int The category type of this config. Returns -1 if none is set. Category name is available using id.Category.FromID() .
---@field teamID Int Assigns this team ID to a PlayerEntity if the object is worn.
---@field cost Int The 64-bit numeric value of this object.
---@field stackType ObjStackType The stacking behaviour of this config.
---@field isStockmarket Bool Whether this object can be traded on the Grand Exchange.
---@field stockmarketBuyLimit Int How many of this item can be bought on the Grand Exchage during a 4-hour period.
---@field isTradeable Bool Whether the object can be traded between players and to shops.
---@field quests QuestTypeConfig[] A list of all quests related to this config.
---@field groundOpNames String[] A list of names displayed for the available ops when the object is shown on the ground. Use pairs() to iterate this list, which will provide both the op index and name as opIndex,opName .
---@field interfaceOpNames String[] A list of names displayed for the available ops when the object is shown in an interface component. Use pairs() to iterate this list, which will provide both the op index and name as opIndex,opName .
---@field stackCountAltObjs {[1]: Int, [2]: ObjType}[] A list of count/config pairs used to select which ObjType config is used to draw the current object.
---@field params ParamType[] Returns a list of all the ParamTypes stored in this config.
local Obj = {}

---Returns the custom CursorType , if any, used for the given op index when the ObjType is on the ground.
---@param opIndex Int The op index.
---@return CursorType? # The cursor type to display. Returns nil if no op exists for this index, or no custom CursorType is set on an existing op.
function Obj:GetGroundOpCursor(opIndex) end

---Returns the custom CursorType , if any, used for the given op index when the ObjType is shown in an interface component.
---@param opIndex Int The op index.
---@return CursorType? # The cursor type to display. Returns nil if no op exists for this index, or no custom CursorType is set on an existing op.
function Obj:GetInterfaceOpCursor(opIndex) end

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return any # The corresponding output value. Returns param.defaultValue if the param is not found in the data structure.
function Obj:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool # Whether a corresponding value exists in this config for ParamType .
function Obj:HasParam(param) end
