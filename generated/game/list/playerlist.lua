---@meta

---@class PlayerList
PlayerList = {}

---Returns the PlayerEntity belonging to the currently logged in player character.
---@return PlayerEntity A PlayerEntity .
function PlayerList.Self() end

---Returns all active PlayerEntities in the game world in an array.
---@return PlayerEntity[] An array of PlayerEntities .
function PlayerList.All() end

---Returns the PlayerEntity with the matching UID.
---@param uid Int A valid UID value.
---@return PlayerEntity[] An array of PlayerEntities .
function PlayerList.ByUID(uid) end

---Returns any PlayerEntity with a display name matching the given name value.
---@param name String The string to match against PlayerEntity.displayName .
---@return PlayerEntity[] An array of PlayerEntities .
function PlayerList.ByName(name) end

---Returns any PlayerEntity within range tiles of the given coordGrid value.
---@param coordGrid CoordGrid The coord at which to centre the distance search.
---@param range Int The maximum tile distance from the given coord which an PlayerEntity must be.
---@return PlayerEntity[] An array of PlayerEntities .
function PlayerList.ByDistance(coordGrid, range) end

---Returns any PlayerEntity that matches all tests in the filterSet table.
---@param filterSet PlayerListFilterSettings A table of key-value pairs which describe individual tests to perform.
---@return PlayerEntity[] An array of PlayerEntities .
function PlayerList.Filter(filterSet) end

---@param player any
function westFacingFinder(player) end

---@class PlayerListFilterSettings
---@field uid Int A valid entity UID. { uid = playerEntity.uid } See PlayerList.ByUID()
---@field name String A name to match against PlayerEntity.displayName . { name = "*GIM*" } See PlayerList.ByName()
---@field coordGrid CoordGrid A coord to test entity distance from. If range is not provided, the default value of range will be 0 . { coordGrid = CoordGrid._0_50_50_32_32 } See PlayerList.ByDistance()
---@field range Int Ignored if coordGrid key is not provided. { range = 4 } See PlayerList.ByDistance()
---@field func Function A function which returns a boolean, and which takes a PlayerEntity as its only parameter. This function is called for every entity, and any call that returns true will include that PlayerEntity in the return array. function eastFacingFinder(playerEntity) { return playerEntity.facing == 90 } { func = eastFacingFinder }
PlayerListFilterSettings = {}
