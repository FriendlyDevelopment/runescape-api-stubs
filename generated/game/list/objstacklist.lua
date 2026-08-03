---@meta

---@class ObjStackList
ObjStackList = {}

---Returns all active ObjStackEntities in the game world in an array.
---@return ObjStackEntity[] An array of ObjStackEntities .
function ObjStackList.All() end

---Returns any ObjStackEntity which contains an ObjEntry with a display name matching the given name value.
---@param name String The string to match against ObjType.name .
---@return ObjStackEntity[] An array of ObjStackEntities .
function ObjStackList.ByName(name) end

---Returns any ObjStackEntity within range tiles of the given coordGrid value.
---@param coordGrid CoordGrid The coord at which to centre the distance search.
---@param range Int The maximum tile distance from the given coord which an ObjStackEntity must be.
---@return ObjStackEntity[] An array of ObjStackEntities .
function ObjStackList.ByDistance(coordGrid, range) end

---Returns any ObjStackEntity that contains a ObjEntry referencing the given ObjType config.
---@param objType ObjType The config to look for when testing ObjStackEntities .
---@return ObjStackEntity[] An array of ObjStackEntities .
function ObjStackList.ByConfig(objType) end

---Returns any ObjStackEntity that contains a ObjEntry referencing the given ObjType config ID.
---@param objTypeID Int The config ID to look for when testing ObjStackEntities .
---@return ObjStackEntity[] An array of ObjStackEntities .
function ObjStackList.ByConfigID(objTypeID) end

---Returns any ObjStackEntity that matches all tests in the filterSet table.
---@param filterSet ObjStackListFilterSettings A table of key-value pairs which describe individual tests to perform.
---@return ObjStackEntity[] An array of ObjStackEntities .
function ObjStackList.Filter(filterSet) end

---@param objStack any
function filterLogsObj(objStack) end

---@class ObjStackListFilterSettings
---@field name String A name to match against ObjType.name . { name = "*logs*" } See ObjStackList.ByName()
---@field coordGrid CoordGrid A coord to test entity distance from. If range is not provided, the default value of range will be 0 . { coordGrid = CoordGrid._0_50_50_32_32 } See ObjStackList.ByDistance()
---@field range Int Ignored if coordGrid key is not provided. { range = 4 } See ObjStackList.ByDistance()
---@field config ObjType The config to match against entries of ObjEntry.config . { config = config.Obj.LOGS } See ObjStackList.ByConfig()
---@field configID Int The config ID to match against entries of ObjEntry.configID . { configID = id.Obj.LOGS } See ObjStackList.ByConfigID()
---@field func Function A function which returns a boolean, and which takes an ObjStackEntity as its only parameter. This function is called for every entity, and any call that returns true will include that ObjStackEntity in the return array. function logFinder(objStackEntity) { return objStackEntity:HasObj(config.Obj.LOGS) } { func = logFinder }
ObjStackListFilterSettings = {}
