---@meta

---@class NPCList
NPCList = {}

---Returns all active NPCEntities in the game world in an array.
---@return NPCEntity[] An array of NPCEntities .
function NPCList.All() end

---Returns the NPCEntity with the matching UID.
---@param uid Int A valid UID value.
---@return NPCEntity[] An array of NPCEntities .
function NPCList.ByUID(uid) end

---Returns any NPCEntity with a display name matching the given name value.
---@param name String The string to match against NPCEntity.displayName .
---@return NPCEntity[] An array of NPCEntities .
function NPCList.ByName(name) end

---Returns any NPCEntity within range tiles of the given coordGrid value.
---@param coordGrid CoordGrid The coord at which to centre the distance search.
---@param range Int The maximum tile distance from the given coord which an NPCEntity must be.
---@return NPCEntity[] An array of NPCEntities .
function NPCList.ByDistance(coordGrid, range) end

---Returns any NPCEntity that uses the given NPCType config.
---@param npcType NPCType The config to look for when testing NPCEntities .
---@return NPCEntity[] An array of NPCEntities .
function NPCList.ByConfig(npcType) end

---Returns any NPCEntity that uses the given NPCType config ID.
---@param npcTypeID Int The config ID to look for when testing NPCEntities .
---@return NPCEntity[] An array of NPCEntities .
function NPCList.ByConfigID(npcTypeID) end

---Returns any NPCEntity that matches all tests in the filterSet table.
---@param filterSet Table A table of key-value pairs which describe individual tests to perform.
---@return NPCEntity[] An array of NPCEntities .
function NPCList.Filter(filterSet) end

---@param npc any
function filterRatNPC(npc) end
