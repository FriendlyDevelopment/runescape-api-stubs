---@meta

---@class ObjStackEntity
---@field isValid Bool Whether this entity still exists. Dispose of this usertype object when invalid.
---@field position Vector3 The world position of this ObjStackEntity .
---@field coordGrid CoordGrid Returns the CoordGrid tile this ObjStackEntity is currently on.
---@field stackSize Int The number of ObjEntries in this ObjStackEntity .
ObjStackEntity = {}

---Returns the ObjEntry at the given index .
---@param index Int The index of the ObjEntry to return.The value of index starts at 1 .Returns nil if no entry is found at the given index.
---@return ObjEntry An ObjEntry within an ObjStackEntity .
function ObjStackEntity:GetEntry(index) end

---Returns whether an ObjStackEntity contains an ObjEntry referencing the given ObjType .
---@param objType ObjType The ObjType to search for.
---@return Bool Whether the ObjType was found.
function ObjStackEntity:HasObj(objType) end

---Returns whether an ObjStackEntity contains an ObjEntry referencing the given ObjType ID.
---@param objTypeID Int The ID of ObjType to search for.
---@return Bool Whether the ObjType was found.
function ObjStackEntity:HasObjID(objTypeID) end

---Every ObjStackEntity contains one or more instances of ObjEntry . Each ObjEntry references a single ObjType config and a count of how many there are.
---@class ObjEntry
---@field config ObjType The config that describes this entry.
---@field configID Int The config ID that describes this entry.
---@field count Int How many of this object are in this specific entry.This will always be 1 for ObjTypes that cannot stack.
ObjEntry = {}
