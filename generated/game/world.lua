---@meta

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
---@return CoordGrid? The bottom-left CoordGrid for the input coordinate's source data.Returns nil if the Player Character is not currently in a region, or the input coordinate was outside of the region bounds.
function World.GetRegionSourceForCoordGrid(coord) end

---Returns the map square bounds for the currently loaded game world.
---@return Rect? The rectangle encompassing the current World's map square bounds.
function World.GetMapSquareBounds() end

---Returns the height for the given level and position values, along with whether the height was available for that position.
---@param level Int The coordinate level of height map data to read.The value of level must be between 0 and 3 .
---@param x Int The world-space X position, in fine units, to access the height value for.
---@param z Int The world-space Z position, in fine units, to access the height value for.
---@return Int The height and success pair for the input position values.Returns a height of -1 on failure.
---@return Bool
function World.GetGroundHeight(level, x, z) end
