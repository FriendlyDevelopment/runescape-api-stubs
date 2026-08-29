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
---@field isOpen Bool Whether the MiniMenu is currently open.
---@field entryCount Int How many entries are in the MiniMenu.
---@field entries MiniMenuEntry[] A list of current entries available in the MiniMenu.
MiniMenu = {}

---Returns whether the MiniMenu is currently open. This static method be called at any time.
---@return Bool Whether the MiniMenu is currently open.
function MiniMenu.IsOpen() end

---Adds a MiniMenuEntry to the end of the current list of minimenu entries. It will be displayed with the label specified and call the Lua function specified, with any additional arguments provided in order.
---@param label String The text displayed for the entry in the minimenu.
---@param action Function A Lua function that can take any number of arguments, including none.
---@param ... Args A comma-separated list of arguments that will be passed to the function specified in the action parameter.
function MiniMenu:Add(label, action, ...) end

---@param a any
---@param b any
function logAdd(a, b) end

---@param addedEvent any
function miniMenuEntryAddedEvent(addedEvent) end

---Swaps MiniMenuEntries found at the two provided indices of MiniMenu.entries .
---@param indexA Int The index of the first MiniMenuEntry in MiniMenu.entries .
---@param indexB Int The index of the second MiniMenuEntry in MiniMenu.entries .
function MiniMenu:Swap(indexA, indexB) end

---@param miniMenuEvent any
function onMiniMenuReady(miniMenuEvent) end

---@class MiniMenuEntry
---@field actionType MiniMenuActionType The action type of this entry.
---@field actionEntryType MiniMenuEntryType The entry source type of this entry.
---@field actionVerbType MiniMenuActionVerbType The verb type of this entry.
---@field verbText String The verb name of the entry.
---@field subjectText String The subject name of the entry.
---@field extraText String An additional string appended to the entry.
---@field fullText String The full text displayed when the entry is shown in the MiniMenu if overrideText has not been set. Combines verbText , subjectText and extraText in that order.
---@field overrideText String Override text for an entry supplied by a plugin. This is displayed in place of an entry's fullText if set.
---@field cursorID Int The Cursor config ID shown when this entry is active. Use config.Cursor.FromID(cursorID) to obtain the config.
---@field iconSpriteIDs Int[] An array of sprite IDs which are drawn next to the entry text. Empty if none are drawn.
---@field subjectOnOtherLevel Bool Whether the source entity is on a different level from the Player Character. NOTE: Not always correct.
---@field subjectHash Int A (sort of) unique identifier for the entry. This identifier is only unique for entries that share the same actionEntryType .
---@field npcData? NPCData A collection of data related to this entry. Will be nil if unavailable.
---@field locData? LocData A collection of data related to this entry. Will be nil if unavailable.
---@field objData? ObjData A collection of data related to this entry. Will be nil if unavailable.
---@field playerData? PlayerData A collection of data related to this entry. Will be nil if unavailable.
---@field groundData? GroundData A collection of data related to this entry. Will be nil if unavailable.
---@field mapElementData? MapElementData A collection of data related to this entry. Will be nil if unavailable.
---@field componentData? ComponentData A collection of data related to this entry. Will be nil if unavailable.
MiniMenuEntry = {}

---@class NPCData
---@field entity NPCEntity The NPC entity source for this entry.
NPCData = {}

---@class LocData
---@field coordGridX Int The south-west tile X coordinate the Loc entity is positioned at.
---@field coordGridZ Int The south-west tile Z coordinate the Loc entity is positioned at.
---@field config LocType The config for the Loc entity.
LocData = {}

---@class ObjData
---@field entity ObjStackEntity The ObjStack entity source for this entry.
---@field stackIndex Int The specific object within the source ObjStackEntity that this MiniMenuEntry relates to. Use this with ObjStackEntity:GetEntry() .
---@field config ObjType The config for the specific object that this MiniMenuEntry relates to.
ObjData = {}

---@class PlayerData
---@field entity PlayerEntity The Player entity source for this entry.
PlayerData = {}

---@class GroundData
---@field coordGridX Int The tile X coordinate this entry is focused at.
---@field coordGridZ Int The tile Z coordinate this entry is focused at.
---@field fromMiniMap Bool true if this entry was created from the MiniMap. false if this entry was created from the 3D world view.
GroundData = {}

---@class MapElementData
---@field mapElementID Int The MapElement config ID shown when this entry is active. Use config.MapElement.FromID(mapElementID) to obtain the config. TODO: MapElement configs are not available yet.
---@field categoryID Int The Category ID belonging to this map element.
MapElementData = {}

---@class ComponentData
---@field opIndex Int The op index for this entry. Valid values are 1 -> 10 .
---@field objConfig? ObjType Some Components allow ObjType IDs to be assigned to them, such as Sprites and Models . This property provides the config, if set on the source Component. Will be nil if unavailable.
---@field component Component The Component source for this entry.
ComponentData = {}
