---@meta

---A list of all the possible value types and the data type they correspond to.
---@enum ValueType
ValueType = {
    UNSUPPORTED = -1,
    ACHIEVEMENT = 131,
    AREA = 16,
    BASEANIMSET = 44,
    BOOLEAN = 1,
    CATEGORY = 41,
    CHAR = 42,
    CHATCAT = 29,
    CHATPHRASE = 24,
    COMPONENT = 9,
    COORDGRID = 22,
    CURSOR = 5,
    CUTSCENE2D = 138,
    DBTABLE = 129,
    DBROW = 74,
    ENUM = 26,
    FONT = 25,
    HITMARK = 62,
    IDKIT = 10,
    INTEGER = 0,
    INV = 39,
    LOC = 30,
    LONG = 110,
    MAPELEMENT = 59,
    MATERIAL = 102,
    MODEL = 31,
    NPC = 32,
    NPC_UID = 38,
    OBJ = 33,
    OVERLAYINTERFACE = 99,
    PLAYER_UID = 34,
    QUEST = 3,
    SEQ = 6,
    SPOTANIM = 37,
    SKILL = 17,
    SPRITE = 23,
    STRING = 36,
    STRUCT = 73,
    SYNTH = 14,
    VAR_INT = 209,
    VORBIS = 57,
}

---@class VarType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "FRIEND_SORT_MODE" .
---@field typeName String The type of this config. Will one of "VarClient" , "VarPlayer" , "VarPlayerGroup" , "VarClan" , "VarClanSettings" , "VarNPC" or "VarObj" .
---@field value ? Returns the current value of this variable config.The value data type ValueType is provided by valueType .
---@field valueType ValueType The expected type of data this variable will return.
---@field isVarBit Bool Whether this config type is a VarBit .
---@field baseVar VarType Returns the base VarType , if this config is a VarBit .Otherwise returns nil .
---@field varBitMask Int Returns a bitmask showing the range of bits used, if this config is a VarBit .Otherwise returns nil .A VarBit using bits 3-5 would return a value of 56 ( 0x38 , 0b111000 ).
VarType = {}
