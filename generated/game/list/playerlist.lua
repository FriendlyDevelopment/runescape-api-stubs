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
---@param filterSet Table A table of key-value pairs which describe individual tests to perform.
---@return PlayerEntity[] An array of PlayerEntities .
function PlayerList.Filter(filterSet) end

---@param player any
function westFacingFinder(player) end
