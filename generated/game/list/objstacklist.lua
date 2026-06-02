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
---@param filterSet Table A table of key-value pairs which describe individual tests to perform.
---@return ObjStackEntity[] An array of ObjStackEntities .
function ObjStackList.Filter(filterSet) end

---@param objStack any
function filterLogsObj(objStack) end
