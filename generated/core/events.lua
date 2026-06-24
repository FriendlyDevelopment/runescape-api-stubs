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

---@class Event
---@field Logic EventSubscription
---@field Draw EventSubscription
---@field KeyUp EventSubscription
---@field KeyDown EventSubscription
---@field KeyTyped EventSubscription
---@field VarTransmit EventSubscription
---@field ChatMessage EventSubscription
---@field PlayerEntityAdded EventSubscription
---@field PlayerEntityRemoved EventSubscription
---@field NPCEntityAdded EventSubscription
---@field NPCEntityRemoved EventSubscription
---@field ObjStackEntityAdded EventSubscription
---@field ObjStackEntityRemoved EventSubscription
---@field ObjStackEntityChanged EventSubscription
---@field WindowFocusChanged EventSubscription
---@field GameStateChanged EventSubscription
---@field EntityDraw EventSubscription
---@field WindowSizeChanged EventSubscription
---@field SkillTransmit EventSubscription
---@field RunEnergyTransmit EventSubscription
---@field RunWeightTransmit EventSubscription
---@field MiniMenuOpened EventSubscription
---@field MiniMenuClosed EventSubscription
---@field MiniMenuReady EventSubscription
---@field MiniMenuEntryAdded EventSubscription
---@field MiniMenuEntrySelected EventSubscription

---Each event provides a table containing data related to the change which occurred.
---@class EventPayload
EventPayload = {}

---@param chatMessageEvent any
function addHello(chatMessageEvent) end

---@param chatMessageEvent any
function addGoodbye(chatMessageEvent) end

---Called each time the client begins a logic update. The client runs at a fixed 50 logic ticks per second.
---@class Logic
---@field logicTick Int How many logic ticks have occurred since the client was started.
Logic = {}

---Called each time the client begins a draw update. The interval between draw events is determined by the frame rate.
---@class Draw
---@field timeDeltaSecs Float The time, in seconds, since the last draw event (often known as the delta).
Draw = {}

---Called when a Keyboard key press is released.
---@class KeyUp
---@field gameKey GameKey The game key which was released.
---@field systemKey SystemKey The system key equivalent to gameKey which was released.
---@field modifiers Int A bitfield containing the modifier keys currently held.
---@field timestamp Int The time, in milliseconds, when the key was released.
KeyUp = {}

---Called when a Keyboard key press is first pressed, and when a key-repeat event is sent by the OS.
---@class KeyDown
---@field isRepeat Bool Whether the key press is a repeat or not.A value of false means the key has just been pressed.A value of true means the key was already pressed and the OS has re-sent the key event as a repeat.
---@field gameKey GameKey The game key which was pressed.
---@field systemKey SystemKey The system key equivalent to gameKey which was pressed.
---@field modifiers Int A bitfield containing the modifier keys currently held.
---@field timestamp Int The time, in milliseconds, when the key was first pressed, or the repeat event was sent.
KeyDown = {}

---@param keyDownEvent any
function keyDownFunc(keyDownEvent) end

---This event provides the string character generated by the combination of keys just pressed.
---@class KeyTyped
---@field char Int The integer value of the character generated.This can be converted to a string value with: local keyStr = string.char(keyTypedEvent.char)
---@field modifiers Int A bitfield containing the modifier keys currently held.
---@field timestamp Int The time, in milliseconds, when the character was generated.
KeyTyped = {}

---Called when a variable update is transmitted from the server to the client. The variable is not guaranteed to have changed.
---@class VarTransmit
---@field var VarType The variable config that triggered the event.
---@field oldValue IntegerString The previous value of the config.The return type is determined by the variable config.
---@field newValue IntegerString The current value of the config.The return type is determined by the variable config.
VarTransmit = {}

---@param varTransmitEvent any
function varTest(varTransmitEvent) end

---Called each time the client receives a message from the server that is intended for a chat window.
---@class ChatMessage
---@field chatMessage String The message received.Can be edited freely, and will be passed to any subsequent subscribed functions.
---@field chatType ChatType The type of chat message.
---@field timestamp Int The time when the message was received.Timestamp is in seconds since Unix epoch.
ChatMessage = {}

---@param chatMessageEvent any
function messageFunc(chatMessageEvent) end

---Called when a player entity is added to the game world.
---@class PlayerEntityAdded
---@field playerEntity PlayerEntity The player entity.
---@field entityType EntityType The type of entity.This is always EntityType.PLAYER .
PlayerEntityAdded = {}

---@param playerEntityAddedEvent any
function playerFunc(playerEntityAddedEvent) end

---Called when a player entity is removed from the game world.
---@class PlayerEntityRemoved
---@field playerEntity PlayerEntity The player entity.
---@field entityType EntityType The type of entity.This is always EntityType.PLAYER .
PlayerEntityRemoved = {}

---@param playerEntityRemovedEvent any
function playerFunc(playerEntityRemovedEvent) end

---Called when an NPC entity is added to the game world.
---@class NPCEntityAdded
---@field npcEntity NPCEntity The NPC entity.
---@field entityType EntityType The type of entity.This is always EntityType.NPC .
NPCEntityAdded = {}

---@param npcEntityAddedEvent any
function npcFunc(npcEntityAddedEvent) end

---Called when an NPC entity is removed from the game world.
---@class NPCEntityRemoved
---@field npcEntity NPCEntity The NPC entity.
---@field entityType EntityType The type of entity.This is always EntityType.NPC .
NPCEntityRemoved = {}

---@param npcEntityRemovedEvent any
function npcFunc(npcEntityRemovedEvent) end

---Called when an objStack entity is added to the game world. This event provides the first object in the stack, with additional objects being provided by ObjStackEntityChanged .
---@class ObjStackEntityAdded
---@field objStackEntity ObjStackEntity The objStack entity.
---@field entityType EntityType The type of entity.This is always EntityType.OBJSTACK .
---@field objType ObjType The config type of the object that was added to the objStack.
---@field count Int How many of the object was added.
ObjStackEntityAdded = {}

---@param objStackEntityAddedEvent any
function objStackAddedFunc(objStackEntityAddedEvent) end

---Called when an objStack entity is removed to the game world. This event occurs when the final object in a stack is picked up, or the objStack goes out of view range.
---@class ObjStackEntityRemoved
---@field objStackEntity ObjStackEntity The objStack entity.
---@field entityType EntityType The type of entity.This is always EntityType.OBJSTACK .
---@field objType ObjType The config type of the object that was removed from the objStack.
---@field count Int How many of the object was removed.
ObjStackEntityRemoved = {}

---@param objStackEntityRemovedEvent any
function objStackRemovedFunc(objStackEntityRemovedEvent) end

---Called when an existing objStack entity has changed. This event occurs when objects are added or removed from the tile the objStack is in.
---@class ObjStackEntityChanged
---@field objStackEntity ObjStackEntity The objStack entity.
---@field entityType EntityType The type of entity.This is always EntityType.OBJSTACK .
---@field objType ObjType The config type of the object that was added or removed from the objStack.
---@field oldCount Int The previous amount of the object.
---@field newCount Int The current amount of the object.
ObjStackEntityChanged = {}

---@param objStackEntityChangedEvent any
function objStackChangedFunc(objStackEntityChangedEvent) end

---Called when the focus of the game window changes.
---@class WindowFocusChanged
---@field hasFocus Bool Whether the window has gained or lost focus.
WindowFocusChanged = {}

---@param windowFocusChangedEvent any
function focusChangedFunc(windowFocusChangedEvent) end

---Called when the client's internal state changes.
---@class GameStateChanged
---@field oldState GameState The previous game state.
---@field newState GameState The current game state.
GameStateChanged = {}

---@param gameStateChangedEvent any
function gameStateChangedFunc(gameStateChangedEvent) end

---Called when an entity is about to be drawn.
---@class EntityDraw
---@field entityType EntityType The type of entity.
---@field npcEntity NPCEntity The entity being drawn.Returns one of the listed entities, use entityType to select the correct one.
---@field playerEntity PlayerEntity The entity being drawn.Returns one of the listed entities, use entityType to select the correct one.
---@field objStackEntity ObjStackEntity The entity being drawn.Returns one of the listed entities, use entityType to select the correct one.
EntityDraw = {}

---@param entityDrawEvent any
function hansHiderFunc(entityDrawEvent) end

---Called when the size of the game window changes.
---@class WindowSizeChanged
---@field oldWidth Int The old width of the window.
---@field oldHeight Int The old height of the window.
---@field newWidth Int The new width of the window.
---@field newHeight Int The new height of the window.
WindowSizeChanged = {}

---@param windowSizeChangedEvent any
function windowSizeChangedFunc(windowSizeChangedEvent) end

---Called when a player character's skill changes in value.
---@class SkillTransmit
---@field skill SkillType The skill that has changed in value.
---@field oldXP Int The previous XP value for the skill.
---@field newXP Int The current XP value for the skill.
---@field oldGameplayLevel Int The previous gameplay level for the skill.
---@field newGameplayLevel Int The current gameplay level for the skill.
SkillTransmit = {}

---@param skillTransmitEvent any
function skillTransmitFunc(skillTransmitEvent) end

---Called when the player character's run energy changes in value.
---@class RunEnergyTransmit
---@field oldRunEnergy Int The player character's previous run energy value.
---@field newRunEnergy Int The player character's current run energy value.
RunEnergyTransmit = {}

---@param runEnergyTransmitEvent any
function runEnergyTransmitFunc(runEnergyTransmitEvent) end

---Called when the player character's weight changes in value.
---@class RunWeightTransmit
---@field oldRunWeight Int The player character's previous weight value.
---@field newRunWeight Int The player character's current weight value.
RunWeightTransmit = {}

---@param runWeightTransmitEvent any
function runWeightTransmitFunc(runWeightTransmitEvent) end

---Called when the MiniMenu has been opened.
---@class MiniMenuOpened
---@field miniMenu MiniMenu The current MiniMenu and its list of entries.
MiniMenuOpened = {}

---@param miniMenuOpenedEvent any
function miniMenuOpenedFunc(miniMenuOpenedEvent) end

---Called when the MiniMenu has been closed.
---@class MiniMenuClosed
---@field miniMenu MiniMenu The current MiniMenu and its list of entries.
MiniMenuClosed = {}

---@param miniMenuClosedEvent any
function miniMenuClosedFunc(miniMenuClosedEvent) end

---Called when the MiniMenu has finished adding all entries for the current Logic tick and can now be altered.
---@class MiniMenuReady
---@field miniMenu MiniMenu The current MiniMenu and its list of entries.
MiniMenuReady = {}

---@param miniMenuReadyEvent any
function miniMenuReadyFunc(miniMenuReadyEvent) end

---Called when a MiniMenuEntry has been added to the MiniMenu .
---@class MiniMenuEntryAdded
---@field entry MiniMenuEntry The MiniMenuEntry which has been added to the MiniMenu.
MiniMenuEntryAdded = {}

---@param miniMenuEntryAddedEvent any
function miniMenuEntryAddedFunc(miniMenuEntryAddedEvent) end

---Called when a MiniMenuEntry has been selected from the MiniMenu .
---@class MiniMenuEntrySelected
---@field entry MiniMenuEntry The MiniMenuEntry which has been selected from the MiniMenu.
MiniMenuEntrySelected = {}

---@param miniMenuEntrySelectedEvent any
function miniMenuEntrySelectedFunc(miniMenuEntrySelectedEvent) end
