---@meta

---These are provided as part of the following event payloads:
---@enum EntityType
EntityType = {
    LOCATION = 0,
    NPC = 1,
    PLAYER = 2,
    OBJSTACK = 3,
    COMBINED_LOCATION_SECTION = 12,
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
---In some cases, the payload data can be modified before it is further processed by the client. These modifications are then passed to the next subscribed function.
---@class EventSubscription<T, RetT>
---@field Subscribe fun(name: string, callback: fun(event: T): RetT)
---@field Unsubscribe fun(name: string)
EventSubscription = {}

---Called each time the client begins a logic update. The client runs at a fixed 50 logic ticks per second.
---@class Logic
---@field logicTick Int (Read-only) How many logic ticks have occurred since the client was started.
Logic = {}

---Called each time the client begins a draw update. The interval between draw events is determined by the frame rate.
---@class Draw
---@field timeDeltaSecs Float (Read-only) The time, in seconds, since the last draw event (often known as the delta).
Draw = {}

---Called when an optional dependency plugin is enabled or disabled. This event is only sent to plugins which have registered the changing plugin as an optional dependency . This event is automatically created for plugins that use the built-in PluginDependencyUpdate method.
---@class OptionalDependencyChanged
---@field pluginIdentifier String (Read-only) The identifier name of the optional dependency plugin.
---@field enabled Bool (Read-only) Whether the optional dependency plugin is now enabled or disabled.
OptionalDependencyChanged = {}

---Called when a Keyboard key press is released.
---@class KeyUp
---@field gameKey GameKey (Read-only) The game key which was released.
---@field systemKey SystemKey (Read-only) The system key equivalent to gameKey which was released.
---@field modifiers Int (Read-only) A bitfield containing the modifier keys currently held.
---@field timestamp Int (Read-only) The time, in milliseconds, when the key was released.
KeyUp = {}

---Called when a Keyboard key press is first pressed, and when a key-repeat event is sent by the OS. An equivalent KeyTyped event is always sent immediately after this event.
---@class KeyDown
---@field isRepeat Bool (Read-only) Whether the key press is a repeat or not. A value of false means the key has just been pressed. A value of true means the key was already pressed and the OS has re-sent the key event as a repeat.
---@field gameKey GameKey (Read-only) The game key which was pressed.
---@field systemKey SystemKey (Read-only) The system key equivalent to gameKey which was pressed.
---@field modifiers Int (Read-only) A bitfield containing the modifier keys currently held.
---@field timestamp Int (Read-only) The time, in milliseconds, when the key was first pressed, or the repeat event was sent.
KeyDown = {}

---This event provides the string character generated by the combination of keys just pressed. The character value provided may not be a printable one once converted to a string value. This event always follows an equivalent KeyDown event.
---@class KeyTyped
---@field char Int (Read-only) The integer value of the character generated. This can be converted to a string value with: local keyStr = string.char(keyTypedEvent.char)
---@field modifiers Int (Read-only) A bitfield containing the modifier keys currently held.
---@field timestamp Int (Read-only) The time, in milliseconds, when the character was generated.
KeyTyped = {}

---Called when a variable update is transmitted from the server to the client. The variable is not guaranteed to have changed. This event is called immediately after the variable has been set.
---@class VarTransmit
---@field var VarType (Read-only) The variable config that triggered the event.
---@field oldValue Int|String (Read-only) The previous value of the config. The return type is determined by the variable config.
---@field newValue Int|String (Read-only) The current value of the config. The return type is determined by the variable config.
VarTransmit = {}

---Called each time the client receives a message from the server that is intended for a chat window. There are a variety of chat message types that can be received, see ChatType .
---@class ChatMessage
---@field chatMessage String The message received. Can be edited freely, and will be passed to any subsequent subscribed functions.
---@field chatType ChatType (Read-only) The type of chat message.
---@field timestamp Int (Read-only) The time when the message was received. Timestamp is in seconds since Unix epoch.
ChatMessage = {}

---Called when a player entity is added to the game world.
---@class PlayerEntityAdded
---@field playerEntity PlayerEntity (Read-only) The player entity.
---@field entityType EntityType (Read-only) The type of entity. This is always EntityType.PLAYER .
PlayerEntityAdded = {}

---Called when a player entity is removed from the game world.
---@class PlayerEntityRemoved
---@field playerEntity PlayerEntity (Read-only) The player entity.
---@field entityType EntityType (Read-only) The type of entity. This is always EntityType.PLAYER .
PlayerEntityRemoved = {}

---Called when an NPC entity is added to the game world.
---@class NPCEntityAdded
---@field npcEntity NPCEntity (Read-only) The NPC entity.
---@field entityType EntityType (Read-only) The type of entity. This is always EntityType.NPC .
NPCEntityAdded = {}

---Called when an NPC entity is removed from the game world.
---@class NPCEntityRemoved
---@field npcEntity NPCEntity (Read-only) The NPC entity.
---@field entityType EntityType (Read-only) The type of entity. This is always EntityType.NPC .
NPCEntityRemoved = {}

---Called when an objStack entity is added to the game world. This event provides the first object in the stack, with additional objects being provided by ObjStackEntityChanged .
---@class ObjStackEntityAdded
---@field objStackEntity ObjStackEntity (Read-only) The objStack entity.
---@field entityType EntityType (Read-only) The type of entity. This is always EntityType.OBJSTACK .
---@field objType ObjType (Read-only) The config type of the object that was added to the objStack.
---@field count Int (Read-only) How many of the object was added.
ObjStackEntityAdded = {}

---Called when an objStack entity is removed to the game world. This event occurs when the final object in a stack is picked up, or the objStack goes out of view range.
---@class ObjStackEntityRemoved
---@field objStackEntity ObjStackEntity (Read-only) The objStack entity.
---@field entityType EntityType (Read-only) The type of entity. This is always EntityType.OBJSTACK .
---@field objType ObjType (Read-only) The config type of the object that was removed from the objStack.
---@field count Int (Read-only) How many of the object was removed.
ObjStackEntityRemoved = {}

---Called when an existing objStack entity has changed. This event occurs when objects are added or removed from the tile the objStack is in.
---@class ObjStackEntityChanged
---@field objStackEntity ObjStackEntity (Read-only) The objStack entity.
---@field entityType EntityType (Read-only) The type of entity. This is always EntityType.OBJSTACK .
---@field objType ObjType (Read-only) The config type of the object that was added or removed from the objStack.
---@field oldCount Int (Read-only) The previous amount of the object.
---@field newCount Int (Read-only) The current amount of the object.
ObjStackEntityChanged = {}

---Called when the focus of the game window changes.
---@class WindowFocusChanged
---@field hasFocus Bool (Read-only) Whether the window has gained or lost focus.
WindowFocusChanged = {}

---Called when the client's internal state changes. See GameState for the list of possible states.
---@class GameStateChanged
---@field oldState GameState (Read-only) The previous game state.
---@field newState GameState (Read-only) The current game state.
GameStateChanged = {}

---Called when an entity is about to be drawn. Warning: This event requires a boolean return value to indicate whether the entity should continue drawing. See below for an example.
---@class EntityDraw
---@field entityType EntityType (Read-only) The type of entity.
---@field npcEntity NPCEntity (Read-only) The entity being drawn. Returns one of the listed entities, use entityType to select the correct one.
---@field playerEntity PlayerEntity (Read-only) The entity being drawn. Returns one of the listed entities, use entityType to select the correct one.
---@field objStackEntity ObjStackEntity (Read-only) The entity being drawn. Returns one of the listed entities, use entityType to select the correct one.
EntityDraw = {}

---Called when the size of the game window changes.
---@class WindowSizeChanged
---@field oldWidth Int (Read-only) The old width of the window.
---@field oldHeight Int (Read-only) The old height of the window.
---@field newWidth Int (Read-only) The new width of the window.
---@field newHeight Int (Read-only) The new height of the window.
WindowSizeChanged = {}

---Called when a player character's skill changes in value.
---@class SkillTransmit
---@field skill SkillType (Read-only) The skill that has changed in value.
---@field oldXP Int (Read-only) The previous XP value for the skill.
---@field newXP Int (Read-only) The current XP value for the skill.
---@field oldGameplayLevel Int (Read-only) The previous gameplay level for the skill.
---@field newGameplayLevel Int (Read-only) The current gameplay level for the skill.
SkillTransmit = {}

---Called when the player character's run energy changes in value.
---@class RunEnergyTransmit
---@field oldRunEnergy Int (Read-only) The player character's previous run energy value.
---@field newRunEnergy Int (Read-only) The player character's current run energy value.
RunEnergyTransmit = {}

---Called when the player character's weight changes in value.
---@class RunWeightTransmit
---@field oldRunWeight Int (Read-only) The player character's previous weight value.
---@field newRunWeight Int (Read-only) The player character's current weight value.
RunWeightTransmit = {}

---Called when the MiniMenu has been opened. Access to the MiniMenu's list of entries is available from this event's payload, but cannot be edited. Use Event.MiniMenuReady to make changes to the list of entries.
---@class MiniMenuOpened
---@field miniMenu MiniMenu (Read-only) The current MiniMenu and its list of entries.
MiniMenuOpened = {}

---Called when the MiniMenu has been closed. This is called both when a MiniMenuEntry is selected and when the MiniMenu closes without selecting a MiniMenuEntry . Access to the MiniMenu's list of entries is available from this event's payload, but cannot be edited. Use Event.MiniMenuReady to make changes to the list of entries.
---@class MiniMenuClosed
---@field miniMenu MiniMenu (Read-only) The current MiniMenu and its list of entries.
MiniMenuClosed = {}

---Called when the MiniMenu has finished adding all entries for the current Logic tick and can now be altered.
---@class MiniMenuReady
---@field miniMenu MiniMenu (Read-only) The current MiniMenu and its list of entries. (Using Swap())
MiniMenuReady = {}

---Called when a MiniMenuEntry has been added to the MiniMenu .
---@class MiniMenuEntryAdded
---@field entry MiniMenuEntry (Read-only) The MiniMenuEntry which has been added to the MiniMenu.
MiniMenuEntryAdded = {}

---Called when a MiniMenuEntry has been selected from the MiniMenu .
---@class MiniMenuEntrySelected
---@field entry MiniMenuEntry (Read-only) The MiniMenuEntry which has been selected from the MiniMenu.
MiniMenuEntrySelected = {}

---Called when a location is added to the game world, or changed from one location ito another, by the server. A location will only be changed to another if the both shapeType and coordGrid match. If a custom transform is not provided in the event, then the new location will inherit any pre-existing custom transform from any location it is changing. Warning: If a location is changed via its MultiLoc variable state, then this event is not called.
---@class LocAdded
---@field config LocType (Read-only) The location config.
---@field shapeType LocShapeType (Read-only) The LocShapeType of the location being added.
---@field rotationType RotationType (Read-only) The 90-degree rotation type being used by this location.
---@field coordGrid CoordGrid (Read-only) The coordinate the location is being added to.
---@field overrideTransform Bool (Read-only) Whether an overriding transformation should be applied to this location.
---@field transformTranslate Vector3 (Read-only) The overriding translation transformation.
---@field transformRotation Vector3 (Read-only) The overriding rotation transformation.
---@field transformScale Vector3 (Read-only) The overriding scale transformation.
LocAdded = {}

---Called when a location is removed from the game world by the server. No config is provided with this event, and only existing locations with a matching shapeType and coordGrid will be removed.
---@class LocRemoved
---@field shapeType LocShapeType (Read-only) The LocShapeType of the location being removed.
---@field rotationType RotationType (Read-only) The 90-degree rotation type of the location being removed.
---@field coordGrid CoordGrid (Read-only) The coordinate the location is being removed from.
LocRemoved = {}

---Called when an existing location has an appearance customisation applied to it by the server. This event retains any existing custom transformation the location already has.
---@class LocCustomised
---@field config LocType (Read-only) The location config.
---@field shapeType LocShapeType (Read-only) The LocShapeType of the location being removed.
---@field rotationType RotationType (Read-only) The 90-degree rotation type of the location being removed.
---@field coordGrid CoordGrid (Read-only) The coordinate the location is being removed from.
---@field customModels Int[] (Read-only) A list of model IDs to overwrite the base LocType model IDs. Use id.Model.FromID(id) to see the overriding material.
---@field customColours Int[] (Read-only) A list of 16-bit HSL colours to overwrite the base LocType HSL colours.
---@field customMaterials Int[] (Read-only) A list of material IDs to overwrite the base LocType material IDs. Use id.Material.FromID(id) to see the overriding material.
LocCustomised = {}

---Called when an animation SeqType is started on a location by the server. No config is provided with this event, and only existing locations with a matching shapeType and coordGrid will be animated.
---@class LocAnimation
---@field shapeType LocShapeType (Read-only) The LocShapeType of the location being animated.
---@field rotationType RotationType (Read-only) The 90-degree rotation type of the location being animated.
---@field coordGrid CoordGrid (Read-only) The coordinate the location being animated.
---@field animation SeqType (Read-only) The animation to be played. Will be nil if an existing animation is being stopped by this event.
---@field animationDelay Int (Read-only) How many client logic ticks to wait before starting the animation. There are 50 logic ticks per second.
LocAnimation = {}

---Called after an inventory and its contents have been populated by the server.
---@class InventoryAdded
---@field inv InvTypeProxy (Read-only) Config of the inventory added. (x)
InventoryAdded = {}

---Called when an inventory and its contents have been updated by the server.
---@class InventoryUpdated
---@field inv InvTypeProxy (Read-only) Config of the inventory updated. (x)
---@field slotsUpdated Int[] (Read-only) List of slot ids that have been updated. (x)
InventoryUpdated = {}

---Called when the server stops transmitting the inventory and its contents to the client, signalling its removal. After being removed, the inventory and its contents are no longer available to the client or the API.
---@class InventoryRemoved
---@field inv InvTypeProxy (Read-only) Config of the inventory removed. (x)
InventoryRemoved = {}

---Called when one of a player character's Grand Exchange trade offers receives an update from the server.
---@class GrandExchangeOfferUpdated
---@field slot Int (Read-only) Number of the offer slot that has been updated. 1-indexed.
---@field listing GrandExchangeOffer (Read-only) The offer data.
GrandExchangeOfferUpdated = {}

---@class Event
---@field Logic EventSubscription<Logic, nil> Called each time the client begins a logic update.
---@field ServerLogic EventSubscription<nil, nil> Called each time the client finishes processing a data packet sent from the server.
---@field Draw EventSubscription<Draw, nil> Called each time the client begins a draw update.
---@field OptionalDependencyChanged EventSubscription<OptionalDependencyChanged, nil> Called when an optional dependency plugin is enabled or disabled.
---@field KeyUp EventSubscription<KeyUp, nil> Called when a Keyboard key press is released.
---@field KeyDown EventSubscription<KeyDown, nil> Called when a Keyboard key press is first pressed, and when a key-repeat event is sent by the OS.
---@field KeyTyped EventSubscription<KeyTyped, nil> This event provides the string character generated by the combination of keys just pressed.
---@field VarTransmit EventSubscription<VarTransmit, nil> Called when a variable update is transmitted from the server to the client.
---@field ChatMessage EventSubscription<ChatMessage, nil> Called each time the client receives a message from the server that is intended for a chat window.
---@field PlayerEntityAdded EventSubscription<PlayerEntityAdded, nil> Called when a player entity is added to the game world.
---@field PlayerEntityRemoved EventSubscription<PlayerEntityRemoved, nil> Called when a player entity is removed from the game world.
---@field NPCEntityAdded EventSubscription<NPCEntityAdded, nil> Called when an NPC entity is added to the game world.
---@field NPCEntityRemoved EventSubscription<NPCEntityRemoved, nil> Called when an NPC entity is removed from the game world.
---@field ObjStackEntityAdded EventSubscription<ObjStackEntityAdded, nil> Called when an objStack entity is added to the game world.
---@field ObjStackEntityRemoved EventSubscription<ObjStackEntityRemoved, nil> Called when an objStack entity is removed to the game world.
---@field ObjStackEntityChanged EventSubscription<ObjStackEntityChanged, nil> Called when an existing objStack entity has changed.
---@field WindowFocusChanged EventSubscription<WindowFocusChanged, nil> Called when the focus of the game window changes.
---@field GameStateChanged EventSubscription<GameStateChanged, nil> Called when the client's internal state changes.
---@field EntityDraw EventSubscription<EntityDraw, boolean> Called when an entity is about to be drawn.
---@field WindowSizeChanged EventSubscription<WindowSizeChanged, nil> Called when the size of the game window changes.
---@field SkillTransmit EventSubscription<SkillTransmit, nil> Called when a player character's skill changes in value.
---@field RunEnergyTransmit EventSubscription<RunEnergyTransmit, nil> Called when the player character's run energy changes in value.
---@field RunWeightTransmit EventSubscription<RunWeightTransmit, nil> Called when the player character's weight changes in value.
---@field MiniMenuOpened EventSubscription<MiniMenuOpened, nil> Called when the MiniMenu has been opened.
---@field MiniMenuClosed EventSubscription<MiniMenuClosed, nil> Called when the MiniMenu has been closed.
---@field MiniMenuReady EventSubscription<MiniMenuReady, nil> Called when the MiniMenu has finished adding all entries for the current Logic tick and can now be altered.
---@field MiniMenuEntryAdded EventSubscription<MiniMenuEntryAdded, nil> Called when a MiniMenuEntry has been added to the MiniMenu .
---@field MiniMenuEntrySelected EventSubscription<MiniMenuEntrySelected, nil> Called when a MiniMenuEntry has been selected from the MiniMenu .
---@field LocAdded EventSubscription<LocAdded, nil> Called when a location is added to the game world, or changed from one location ito another, by the server.
---@field LocRemoved EventSubscription<LocRemoved, nil> Called when a location is removed from the game world by the server.
---@field LocCustomised EventSubscription<LocCustomised, nil> Called when an existing location has an appearance customisation applied to it by the server.
---@field LocAnimation EventSubscription<LocAnimation, nil> Called when an animation SeqType is started on a location by the server.
---@field InventoryAdded EventSubscription<InventoryAdded, nil> Called after an inventory and its contents have been populated by the server.
---@field InventoryUpdated EventSubscription<InventoryUpdated, nil> Called when an inventory and its contents have been updated by the server.
---@field InventoryRemoved EventSubscription<InventoryRemoved, nil> Called when the server stops transmitting the inventory and its contents to the client, signalling its removal.
---@field GrandExchangeOfferUpdated EventSubscription<GrandExchangeOfferUpdated, nil> Called when one of a player character's Grand Exchange trade offers receives an update from the server.
Event = {}
