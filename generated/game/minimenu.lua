---@meta

---A list of all the possible source types for each MiniMenuEntry.
---@enum MiniMenuEntryType
MiniMenuEntryType = {
    NONE = 0,
    INTERFACE = 1,
    OBJ = 2,
    LOC = 3,
    NPC = 4,
    OTHER = 5,
    MINIMENU = 6,
    PLAYER = 7,
    SELF = 8,
    MAP = 9,
    PLUGIN = 10,
}

---The type of action for each entry. MiniMenuActionVerbType.OP is the most common.
---@enum MiniMenuActionVerbType
MiniMenuActionVerbType = {
    ATTACK = 0,
    EXAMINE = 1,
    OP = 2,
    UNSPECIFIED = 3,
}

---All available types of action that can be found in a MiniMenuEntry .
---@enum MiniMenuActionType
MiniMenuActionType = {
    TGT_LOC = 2,
    OP_LOC1 = 3,
    OP_LOC2 = 4,
    OP_LOC3 = 5,
    OP_LOC4 = 6,
    TGT_NPC = 8,
    OP_NPC1 = 9,
    OP_NPC2 = 10,
    OP_NPC3 = 11,
    OP_NPC4 = 12,
    OP_NPC5 = 13,
    TGT_PLAYER = 15,
    TGT_SELF = 16,
    TGT_OBJ = 17,
    OP_OBJ1 = 18,
    OP_OBJ2 = 19,
    OP_OBJ3 = 20,
    OP_OBJ4 = 21,
    OP_OBJ5 = 22,
    WALK = 23,
    TGT_BUTTON = 25,
    PAUSE_BUTTON = 30,
    OP_PLAYER1 = 44,
    OP_PLAYER2 = 45,
    OP_PLAYER3 = 46,
    OP_PLAYER4 = 47,
    OP_PLAYER5 = 48,
    OP_PLAYER6 = 49,
    OP_PLAYER7 = 50,
    OP_PLAYER8 = 51,
    OP_PLAYER9 = 52,
    OP_PLAYER10 = 53,
    IF_BUTTONX1 = 57,
    IF_BUTTONT = 58,
    TGT_GROUND = 59,
    FACE_SQUARE = 60,
    OP_LOC5 = 1001,
    OP_LOC6 = 1002,
    OP_NPC6 = 1003,
    OP_OBJ6 = 1004,
    WIKI = 1005,
    CANCEL = 1006,
    IF_BUTTONX2 = 1007,
    OP_MAPELEMENT1 = 1008,
    OP_MAPELEMENT2 = 1009,
    OP_MAPELEMENT3 = 1010,
    OP_MAPELEMENT4 = 1011,
    OP_MAPELEMENT5 = 1012,
    OP_NPC1_LOWPRIORITY = 2009,
    OP_NPC2_LOWPRIORITY = 2010,
    OP_NPC3_LOWPRIORITY = 2011,
    OP_NPC4_LOWPRIORITY = 2012,
    OP_NPC5_LOWPRIORITY = 2013,
    OP_PLAYER1_LOWPRIORITY = 2044,
    OP_PLAYER2_LOWPRIORITY = 2045,
    OP_PLAYER3_LOWPRIORITY = 2046,
    OP_PLAYER4_LOWPRIORITY = 2047,
    OP_PLAYER5_LOWPRIORITY = 2048,
    OP_PLAYER6_LOWPRIORITY = 2049,
    OP_PLAYER7_LOWPRIORITY = 2050,
    OP_PLAYER8_LOWPRIORITY = 2051,
    OP_PLAYER9_LOWPRIORITY = 2052,
    OP_PLAYER10_LOWPRIORITY = 2053,
    OP_NPC6_LOWPRIORITY = 3003,
}

---@class MiniMenu
---@field isOpen Bool
---@field entryCount Int
---@field entries any Array of MiniMenuEntry
---@field actionType MiniMenuActionType
---@field actionEntryType MiniMenuEntryType
---@field actionVerbType MiniMenuActionVerbType
---@field verbText String
---@field subjectText String
---@field extraText String
---@field fullText String
---@field cursorID Int
---@field iconSpriteIDs any Array of Integer
---@field subjectOnOtherLevel Bool
---@field subjectHash Int
---@field npcData? NPCData
---@field locData? LocData
---@field objData? ObjData
---@field playerData? PlayerData
---@field groundData? GroundData
---@field mapElementData? MapElementData
---@field componentData? ComponentData
---@field entity NPCEntity
---@field coordGridX Int
---@field coordGridZ Int
---@field config LocType
---@field entity ObjStackEntity
---@field stackIndex Int
---@field config ObjType
---@field entity PlayerEntity
---@field coordGridX Int
---@field coordGridZ Int
---@field fromMiniMap Bool
---@field mapElementID Int
---@field categoryID Int
---@field opIndex Int
---@field objConfig? ObjType
---@field component Component
MiniMenu = {}

---Returns whether the MiniMenu is currently open. This static method be called at any time.
---@return Bool Whether the MiniMenu is currently open.
function MiniMenu.IsOpen() end

---Swaps MiniMenuEntries found at the two provided indices of MiniMenu.entries .
---@param indexA Int The index of the first MiniMenuEntry in MiniMenu.entries .
---@param indexB Int The index of the second MiniMenuEntry in MiniMenu.entries .
function MiniMenu:Swap(indexA, indexB) end

---@param miniMenuEvent any
function onMiniMenuReady(miniMenuEvent) end
