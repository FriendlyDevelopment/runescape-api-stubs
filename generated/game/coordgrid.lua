---@meta

---@class CoordGrid
---@field level Int The level of this CoordGrid. Valid range is 0-3.
---@field x Int The world tile X of this CoordGrid, in Grid units . Valid range is 0-12799.
---@field z Int The world tile Z of this CoordGrid, in Grid units . Valid range is 0-12799.
---@field mapSquareX Int The mapsquare X of this CoordGrid, in Grid units . Valid range is 0-199.
---@field mapSquareZ Int The mapsquare Z of this CoordGrid, in Grid units . Valid range is 0-199.
---@field localX Int The local tile X of this CoordGrid, in Grid units . Valid range is 0-63.
---@field localZ Int The local tile Z of this CoordGrid, in Grid units . Valid range is 0-63.
CoordGrid = {}

---Constructs a CoordGrid from the provided numeric value.
---@param bitPacked Int The packed representation of a CoordGrid.
---@return CoordGrid
function CoordGrid.new(bitPacked) end

---Constructs a CoordGrid from the provided level and mapsquare X & Z values.
---@param level Int The level of the coord (0-3).
---@param mapSquareX Int The mapsquare X-dimension of the coord (0-199).
---@param mapSquareZ Int The mapsquare Z-dimension of the coord (0-199).
---@return CoordGrid
function CoordGrid.new(level, mapSquareX, mapSquareZ) end

---Constructs a CoordGrid from the provided level, mapsquare and tile X & Z values.
---@param level Int The level of the coord (0-3).
---@param mapSquareX Int The mapsquare X-dimension of the coord (0-199).
---@param mapSquareZ Int The mapsquare Z-dimension of the coord (0-199).
---@param localTileX Int The local tile X-dimension of the coord (0-63).
---@param localTileZ Int The local tile Z-dimension of the coord (0-63).
---@return CoordGrid
function CoordGrid.new(level, mapSquareX, mapSquareZ, localTileX, localTileZ) end

---Constructs a CoordGrid from the provided level and 3D world position.
---@param level Int The level of the coord (0-3).
---@param position Vector3 A 3D world position in Fine units.
---@return CoordGrid
function CoordGrid.new(level, position) end

---Constructs a CoordGrid from the provided CoordFine.
---@param coordFine CoordFine A CoordFine position.
---@return CoordGrid
function CoordGrid.new(coordFine) end

---Constructs a CoordGrid from the provided CoordGrid.
---@param coordGrid CoordGrid A CoordGrid position.
---@return CoordGrid
function CoordGrid.new(coordGrid) end

---Returns a CoordGrid constructed from the provided CoordFine.
---@param coordFine CoordFine A CoordFine position.
---@return CoordGrid # A CoordGrid position.
function CoordGrid.FromCoordFine(coordFine) end

---Returns a numeric value which is a packed representation of the coordinate, useful for storing as a single 32-bit integer. The coordinate data is packed as follows: (level << 28) | (x << 14) | (z)
---@return Int # The numeric value representing a CoordGrid.
function CoordGrid:ToPacked() end

---Returns a CoordFine using the current CoordGrid as a base.
---@param fromCentre Bool Boolean value which indicates where to centre the output CoordFine.
---@return CoordFine # A CoordFine position.
function CoordGrid:ToCoordFine(fromCentre) end
