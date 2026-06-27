---@meta

---These are provided as part of the following event payloads:
---@enum EntityType
EntityType = {
    NPC = 1,
    PLAYER = 2,
    OBJSTACK = 3,
    NONE = 127,
    UNKNOWN = -1,
}

---These are provided as part of the ChatMessage event payload.
---@enum ChatType
ChatType = {
    GENERAL = 0,
    MOD = 1,
    PUBLIC = 2,
    PRIVATE_INCOMING = 3,
    ENGINE = 4,
    LOGIN_LOGOUT = 5,
    PRIVATE_OUTGOING = 6,
    MOD_PRIVATE_INCOMING = 7,
    FRIEND_CHAT = 9,
    FRIEND_CHAT_NOTIFICATION = 11,
    QUICKCHAT_PUBLIC = 17,
    QUICKCHAT_PRIVATE_INCOMING = 18,
    QUICKCHAT_PRIVATE_OUTGOING = 19,
    QUICKCHAT_FRIEND_CHAT = 20,
    GROUP_SAME_TEAM = 22,
    QUICKCHAT_GROUP_SAME_TEAM = 23,
    GROUP_ALL = 24,
    QUICKCHAT_GROUP_ALL = 25,
    SNAPSHOT_FEEDBACK = 26,
    OBJ_EXAMINE = 27,
    NPC_EXAMINE = 28,
    LOC_EXAMINE = 29,
    FRIEND_NOTIFICATION = 30,
    IGNORE_NOTIFICATION = 31,
    CLANCHANNEL_AFFINED_CHAT = 41,
    CLANCHANNEL_AFFINED_QUICKCHAT = 42,
    CLANCHANNEL_AFFINED_NOTIFICATION = 43,
    CLANCHANNEL_GUEST_CHAT = 44,
    CLANCHANNEL_GUEST_QUICKCHAT = 45,
    CLANCHANNEL_GUEST_NOTIFICATION = 46,
    CONSOLE_ERROR = 96,
    CONSOLE_BUFFER_REPLACE = 98,
    CONSOLE = 99,
    TRADE_REQUEST = 100,
    CHALLENGE = 101,
    ASSIST_REQUEST = 102,
    TRADE_NOTIFICATION = 103,
    ASSIST_NOTIFICATION = 104,
    CLAN_CHALLENGE = 107,
    ALLY_REQUEST = 108,
    SPAM = 109,
    DUNGEON_INVITE = 111,
    CONQUEST_REGULAR_CHALLENGE = 113,
    SYSTEM_BROADCAST = 115,
    NPC_CHAT = 116,
    CLAN_JOIN = 117,
    RATED_CLAN_WAR = 118,
    IGNORABLE_TRADE_NOTIFICATION = 119,
    ALL_PANES = 120,
    RAID_HIGH = 122,
    RAID_DND = 123,
    BROADCAST = 125,
    WORLD_EVENT = 126,
    MISC_BROADCAST = 127,
    GROUPCHAT_NOTIFICATION = 128,
    DUEL_ANY_REQUEST = 132,
    TEMPORARY_EVENT = 133,
    HATI_FENRIR = 134,
    LATEST_NEWSPOST = 135,
    MOTD = 136,
    BROADCAST_GLOBAL = 137,
    BROADCAST_WORLD = 138,
    BROADCAST_FRIENDS = 139,
    INTERFACE_OPEN = 140,
    TIMED_EVENT = 142,
    INTERFACE_OPEN_FILTERED = 143,
    GROUP_IRONMAN_NOTIFICATION = 144,
    GENERAL_LINKABLE = 145,
}

---These are provided as part of the GameStateChanged event payload.
---@enum GameState
GameState = {
    BOOT = 0,
    INIT = 1,
    LOGINSCREEN = 10,
    LOBBY = 20,
    ACCOUNT_CREATE = 23,
    GAME = 30,
    RECONNECTING = 35,
    RECONNECTING_FULL = 36,
    SWITCH_WORLD = 37,
    LOADING = 40,
}

---Most events provide a table containing data related to the change which occurred.
---@class EventPayload
EventPayload = {}

---@param chatMessageEvent any
function addHello(chatMessageEvent) end

---@param chatMessageEvent any
function addGoodbye(chatMessageEvent) end

---Called when a Keyboard key press is first pressed, and when a key-repeat event is sent by the OS.
---@class KeyDown
KeyDown = {}

---@param keyDownEvent any
function keyDownFunc(keyDownEvent) end

---Called when a variable update is transmitted from the server to the client. The variable is not guaranteed to have changed.
---@class VarTransmit
VarTransmit = {}

---@param varTransmitEvent any
function varTest(varTransmitEvent) end

---Called each time the client receives a message from the server that is intended for a chat window.
---@class ChatMessage
ChatMessage = {}

---@param chatMessageEvent any
function messageFunc(chatMessageEvent) end

---Called when a player entity is added to the game world.
---@class PlayerEntityAdded
PlayerEntityAdded = {}

---@param playerEntityAddedEvent any
function playerFunc(playerEntityAddedEvent) end

---Called when a player entity is removed from the game world.
---@class PlayerEntityRemoved
PlayerEntityRemoved = {}

---@param playerEntityRemovedEvent any
function playerFunc(playerEntityRemovedEvent) end

---Called when an NPC entity is added to the game world.
---@class NPCEntityAdded
NPCEntityAdded = {}

---@param npcEntityAddedEvent any
function npcFunc(npcEntityAddedEvent) end

---Called when an NPC entity is removed from the game world.
---@class NPCEntityRemoved
NPCEntityRemoved = {}

---@param npcEntityRemovedEvent any
function npcFunc(npcEntityRemovedEvent) end

---Called when an objStack entity is added to the game world. This event provides the first object in the stack, with additional objects being provided by ObjStackEntityChanged .
---@class ObjStackEntityAdded
ObjStackEntityAdded = {}

---@param objStackEntityAddedEvent any
function objStackAddedFunc(objStackEntityAddedEvent) end

---Called when an objStack entity is removed to the game world. This event occurs when the final object in a stack is picked up, or the objStack goes out of view range.
---@class ObjStackEntityRemoved
ObjStackEntityRemoved = {}

---@param objStackEntityRemovedEvent any
function objStackRemovedFunc(objStackEntityRemovedEvent) end

---Called when an existing objStack entity has changed. This event occurs when objects are added or removed from the tile the objStack is in.
---@class ObjStackEntityChanged
ObjStackEntityChanged = {}

---@param objStackEntityChangedEvent any
function objStackChangedFunc(objStackEntityChangedEvent) end

---Called when the focus of the game window changes.
---@class WindowFocusChanged
WindowFocusChanged = {}

---@param windowFocusChangedEvent any
function focusChangedFunc(windowFocusChangedEvent) end

---Called when the client's internal state changes.
---@class GameStateChanged
GameStateChanged = {}

---@param gameStateChangedEvent any
function gameStateChangedFunc(gameStateChangedEvent) end

---Called when an entity is about to be drawn.
---@class EntityDraw
EntityDraw = {}

---@param entityDrawEvent any
function hansHiderFunc(entityDrawEvent) end

---Called when the size of the game window changes.
---@class WindowSizeChanged
WindowSizeChanged = {}

---@param windowSizeChangedEvent any
function windowSizeChangedFunc(windowSizeChangedEvent) end

---Called when a player character's skill changes in value.
---@class SkillTransmit
SkillTransmit = {}

---@param skillTransmitEvent any
function skillTransmitFunc(skillTransmitEvent) end

---Called when the player character's run energy changes in value.
---@class RunEnergyTransmit
RunEnergyTransmit = {}

---@param runEnergyTransmitEvent any
function runEnergyTransmitFunc(runEnergyTransmitEvent) end

---Called when the player character's weight changes in value.
---@class RunWeightTransmit
RunWeightTransmit = {}

---@param runWeightTransmitEvent any
function runWeightTransmitFunc(runWeightTransmitEvent) end

---Called when the MiniMenu has been opened.
---@class MiniMenuOpened
MiniMenuOpened = {}

---@param miniMenuOpenedEvent any
function miniMenuOpenedFunc(miniMenuOpenedEvent) end

---Called when the MiniMenu has been closed.
---@class MiniMenuClosed
MiniMenuClosed = {}

---@param miniMenuClosedEvent any
function miniMenuClosedFunc(miniMenuClosedEvent) end

---Called when the MiniMenu has finished adding all entries for the current Logic tick and can now be altered.
---@class MiniMenuReady
MiniMenuReady = {}

---@param miniMenuReadyEvent any
function miniMenuReadyFunc(miniMenuReadyEvent) end

---Called when a MiniMenuEntry has been added to the MiniMenu .
---@class MiniMenuEntryAdded
MiniMenuEntryAdded = {}

---@param miniMenuEntryAddedEvent any
function miniMenuEntryAddedFunc(miniMenuEntryAddedEvent) end

---Called when a MiniMenuEntry has been selected from the MiniMenu .
---@class MiniMenuEntrySelected
MiniMenuEntrySelected = {}

---@param miniMenuEntrySelectedEvent any
function miniMenuEntrySelectedFunc(miniMenuEntrySelectedEvent) end
