---@meta

---@class NPCList
NPCList = {}

---Returns all active NPCEntities in the game world in an array.
---@return NPCEntity[] # An array of NPCEntities .
function NPCList.All() end

---Returns the NPCEntity with the matching UID.
---@param uid Int A valid UID value.
---@return NPCEntity[] # An array of NPCEntities .
function NPCList.ByUID(uid) end

---Returns any NPCEntity with a display name matching the given name value.
---@param name String The string to match against NPCEntity.displayName .
---@return NPCEntity[] # An array of NPCEntities .
function NPCList.ByName(name) end

---Returns any NPCEntity within range tiles of the given coordGrid value.
---@param coordGrid CoordGrid The coord at which to centre the distance search.
---@param range Int The maximum tile distance from the given coord which an NPCEntity must be.
---@return NPCEntity[] # An array of NPCEntities .
function NPCList.ByDistance(coordGrid, range) end

---Returns any NPCEntity that uses the given NPCType config.
---@param npcType NPCType The config to look for when testing NPCEntities .
---@return NPCEntity[] # An array of NPCEntities .
function NPCList.ByConfig(npcType) end

---Returns any NPCEntity that uses the given NPCType config ID.
---@param npcTypeID Int The config ID to look for when testing NPCEntities .
---@return NPCEntity[] # An array of NPCEntities .
function NPCList.ByConfigID(npcTypeID) end

---Returns any NPCEntity that matches all tests in the filterSet table.
---@param filterSet NPCListFilterSettings A table of key-value pairs which describe individual tests to perform.
---@return NPCEntity[] # An array of NPCEntities .
function NPCList.Filter(filterSet) end

---@class NPCListFilterSettings
---@field uid Int A valid entity UID. { uid = npcEntity.uid } See NPCList.ByUID()
---@field name String A name to match against NPCEntity.displayName . { name = "*lumbridge*" } See NPCList.ByName()
---@field coordGrid CoordGrid A coord to test entity distance from. If range is not provided, the default value of range will be 0 . { coordGrid = CoordGrid._0_50_50_32_32 } See NPCList.ByDistance()
---@field range Int Ignored if coordGrid key is not provided. { range = 4 } See NPCList.ByDistance()
---@field config NPCType The config to match against NPCEntity.config . { config = config.NPC.HANS } See NPCList.ByConfig()
---@field configID Int The config ID to match against NPCEntity.configID . { configID = id.NPC.HANS } See NPCList.ByConfigID()
---@field func fun(npcEntity: NPCEntity): Bool A predicate used to include matching NPC entities.
NPCListFilterSettings = {}
