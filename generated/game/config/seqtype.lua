---@meta

---@enum PreAnimMove
PreAnimMove = {
    DELAY_MOVE = 0,
    DELAY_ANIMATION = 1,
    MOVE_MERGE = 2,
    ABORT_ANIMATION = 3,
    DEFAULT = 4,
}

---@enum PostAnimMove
PostAnimMove = {
    DELAY_MOVE = 0,
    ABORT_ANIMATION = 1,
    MOVE_MERGE = 2,
    DEFAULT = 3,
}

---@enum AnimationDuplicateBehaviour
AnimationDuplicateBehaviour = {
    CONTINUE = 0,
    RESET = 1,
    LOOP_RESET = 2,
}

---@class SeqType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "ARDRAGON_DRAGON_BASIC_ICE_ATTACK" .
---@field typeName String The type of this config. Will always be "Seq" .
---@field preAnimMove PreAnimMove Behaviour of the animation if the entity is moving when it starts playing.
---@field postAnimMove PostAnimMove Behaviour of the animation if the entity is wants to move after it starts playing.
---@field length Int Number of client ticks the associated animation will run for.
---@field loop Int How many more loops the animation will run for.
---@field priority Int Priority of the animation. Higher is more important.
---@field replaceHeldLeft Obj Object of what to replace the entity's left hand is holding with.
---@field replaceHeldRight Obj Object of what to replace the entity's right hand is holding with.
---@field maxLoop Int Maximum number of loops this animation can run for.
---@field animDuplicateBehaviour AnimationDuplicateBehaviour Determines what happens if the same animation is requested to be played while it is already being played.
local Seq = {}

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return any # The corresponding output value. Returns param.defaultValue if the param is not found in the data structure.
function Seq:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool # Whether a corresponding value exists in this config for ParamType .
function Seq:HasParam(param) end
