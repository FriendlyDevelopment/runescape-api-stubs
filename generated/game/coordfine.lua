---@meta

---@class CoordFine : Thevalueofleveliscopieddirectly.Thevaluesofposition.xandposition.zareconvertedtoGridUnits.Thevalueofposition.yisdiscarded.TheFine
---@field level Int
---@field x Float
---@field y Float
---@field z Float
---@field position Vector3
---@field mapSquareX Int
---@field mapSquareZ Int
---@field localX Int
---@field localZ Int
CoordFine = {}

---Constructs a CoordFine from the provided level and X & Z world positions.
---@param level Int The level of the coord (0-3).
---@param x Float The X world position of the coord, in Fine units .
---@param z Float The Z world position of the coord, in Fine units .
---@return CoordFine
function CoordFine.new(level, x, z) end

---Constructs a CoordFine from the provided level and X, Y & Z world positions.
---@param level Int The level of the coord (0-3).
---@param x Float The X world position of the coord, in Fine units .
---@param y Float The Y world position of the coord, in Fine units .
---@param z Float The Z world position of the coord, in Fine units .
---@return CoordFine
function CoordFine.new(level, x, y, z) end

---Constructs a CoordFine from the provided level and world position vector.
---@param level Int The level of the coord (0-3).
---@param position Vector3 The world position of the coord, in Fine units .
---@return CoordFine
function CoordFine.new(level, position) end

---Constructs a CoordFine from the provided CoordGrid.
---@param coordGrid CoordGrid A coord grid position.
---@param fromCentre Bool Boolean value which indicates where to centre the constructed CoordFine.
---@return CoordFine
function CoordFine.new(coordGrid, fromCentre) end

---Constructs a CoordFine from the provided CoordFine.
---@param coordFine CoordFine A CoordFine position.
---@return CoordFine
function CoordFine.new(coordFine) end

---Returns a CoordFine constructed from the provided CoordGrid.
---@param coordGrid CoordGrid A CoordGrid position.
---@param fromCentre Bool Boolean value which indicates where to centre the output CoordFine.
---@return CoordFine A CoordFine position.
function CoordFine.FromCoordGrid(coordGrid, fromCentre) end

---Returns a CoordGrid using the current CoordFine as a base.
---@return CoordGrid A CoordGrid position.
function CoordFine:ToCoordGrid() end
