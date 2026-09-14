---@meta

---@class LocList
LocList = {}

---Returns all active LocEntities in the game world in an array.
---@return LocEntity[] An array of LocEntities .
function LocList.All() end

---Returns any LocEntity with a display name matching the given name value.
---@param name String The string to match against LocEntity.displayName .
---@return LocEntity[] An array of LocEntities .
function LocList.ByName(name) end

---Returns any LocEntity within range tiles of the given coordGrid value.
---@param coordGrid CoordGrid The coordinate at which to centre the distance search.
---@param range Int The maximum tile distance from the given coord which an LocEntity must be. A value of 0 tests only the exact coordinate provided.
---@param sameLevel Bool Whether to only consider LocEntities on the same level as the given coordinate or LocEntities on all levels.
---@return LocEntity[] An array of LocEntities .
function LocList.ByDistance(coordGrid, range, sameLevel) end

---Returns any LocEntity that uses the given LocType config.
---@param locType LocType The config to look for when testing LocEntities .
---@return LocEntity[] An array of LocEntities .
function LocList.ByConfig(locType) end

---@param locTypeID Int The config ID to look for when testing LocEntities .
---@return LocEntity[] An array of LocEntities .
function LocList.ByConfigID(locTypeID) end

---Returns any LocEntity that uses the given LocType config.
---@param locType LocType The config to look for when testing LocEntities .
---@return LocEntity[] An array of LocEntities .
function LocList.ByParentConfig(locType) end

---Returns any LocEntity that uses the given LocType config ID.
---@param locTypeID Int The config ID to look for when testing LocEntities .
---@return LocEntity[] An array of LocEntities .
function LocList.ByParentConfigID(locTypeID) end

---Returns any LocEntity that matches all tests in the filterSet table.
---@param filterSet LocListFilterSettings A table of key-value pairs which describe individual tests to perform.
---@return LocEntity[] An array of LocEntities .
function LocList.Filter(filterSet) end

---@param loc any
function filterWillowLow(loc) end

---@class LocListFilterSettings
---@field name String A name to match against LocEntity.displayName . { name = "*lumbridge*" } See LocList.ByName()
---@field coordGrid CoordGrid A coordinate to test entity distance from. If range is not provided, the default value of range will be 0 . If sameLevel is not provided, the default value of sameLevel will be false . { coordGrid = CoordGrid._0_50_50_32_32 } See LocList.ByDistance()
---@field range Int Ignored if coordGrid key is not provided. { range = 4 } See LocList.ByDistance()
---@field sameLevel Bool Ignored if coordGrid key is not provided. { sameLevel = true } See LocList.ByDistance()
---@field config LocType The config to match against LocEntity.config . { config = config.Loc.FFH_WILLOW_TREE_TRUNK } See LocList.ByConfig()
---@field configID Int The config ID to match against LocEntity.configID . { configID = id.Loc.FFH_WILLOW_TREE_TRUNK } See LocList.ByConfigID()
---@field parentConfig LocType The config to match against LocEntity.parentConfig . { parentConfig = config.Loc.GARDEN_LUMBRIDGE_STATUE } See LocList.ByParentConfig()
---@field parentConfigID Int The config ID to match against LocEntity.parentConfigID . { parentConfigID = id.Loc.GARDEN_LUMBRIDGE_STATUE } See LocList.ByParentConfigID()
---@field func Function A function which returns a boolean, and which takes a LocEntity as its only parameter. This function is called for every entity, and any call that returns true will include that LocEntity in the return array. function willowFinder(locEntity) { return locEntity.config == config.Loc.FFH_WILLOW_TREE_TRUNK } { func = willowFinder }
LocListFilterSettings = {}
