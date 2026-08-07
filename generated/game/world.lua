---@meta

---Used with World.GetGroundHeight() to apply additional offsets to the ground height, depending on the type of LocEntity placed at the sampled position.
---@enum HeightOffsetType
HeightOffsetType = {
    NONE = "NONE", -- 0
    GROUND_DECOR = "GROUND_DECOR", -- 1
    LOCATION = "LOCATION", -- 2
}

---@class World
World = {}

---Returns whether the world data can currently be accessed.
---@return Bool Whether the world data is available to read from.
function World.IsAvailable() end

---Returns whether the current game world is a region or not.
---@return Bool Whether the current game world is a region.
function World.IsRegion() end

---Returns the source coordinate for a given region CoordGrid .
---@param coord CoordGrid The input coordinate.
---@return CoordGrid? The bottom-left CoordGrid for the input coordinate's source data. Returns nil if the Player Character is not currently in a region, or the input coordinate was outside of the region bounds.
function World.GetRegionSourceForCoordGrid(coord) end

---Returns the map square bounds for the currently loaded game world.
---@return Rect? The rectangle encompassing the current World's map square bounds.
function World.GetMapSquareBounds() end

---Returns the height for the given level and position values, along with whether the height was available for that position.
---@param level Int The coordinate level of height map data to read. The value of level must be between 0 and 3 .
---@param x Int The world-space X position, in fine units, to access the height value for.
---@param z Int The world-space Z position, in fine units, to access the height value for.
---@param heightOffsetType? : HeightOffsetType any
---@return Int The height and success pair for the input position values. Returns a height of -1 on failure.
---@return Bool
function World.GetGroundHeight(level, x, z, heightOffsetType? : HeightOffsetType) end

---If the name has already been registered then the existing coordinate, or coordinate range, is updated with the new coordinate.
---@class Functions
Functions = {}

---Adds the given coordinate to the Remove Roof system, registering it by the given name.
---@param name String The name to register the coordinate with.
---@param coord CoordGrid The coordinate to add to the Remove Roof system.
function World.RemoveRoof.Add(name, coord) end

---Adds the given coordinate range to the Remove Roof system, registering it by the given name.
---@param name String The name to register the coordinate with.
---@param coordRangeMin CoordGrid The minimum coordinate of the range to add to the Remove Roof system.
---@param coordRangeMax CoordGrid The maximum coordinate of the range to add to the Remove Roof system.
function World.RemoveRoof.Add(name, coordRangeMin, coordRangeMax) end
