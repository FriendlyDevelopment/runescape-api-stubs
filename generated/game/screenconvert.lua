---@meta

---@class ScreenConvert
ScreenConvert = {}

---Returns the CoordGrid under the given screen position. Resulting coord will be on the same level as the player character.
---@param position Vector2 The XY screen position to convert.
---@return CoordGrid? # The tile coordinate to return. Returns nil if the active player or game world is unavailable, or if there is no tile beneath the given screen position.
function ScreenConvert.ScreenToCoordGrid(position) end

---Returns the CoordGrid for the specified level under the given screen position.
---@param position Vector2 The XY screen position to convert.
---@param level Int The level to output the coordinate for. The value of level must be between 0 and 3 .
---@return CoordGrid? # The tile coordinate to return. Returns nil if the game world is unavailable, the value of level is invalid, or if there is no tile beneath the given screen position.
function ScreenConvert.ScreenToCoordGrid(position, level) end

---Returns the CoordGrid under the given screen X & Y positions. Resulting coord will be on the same level as the player character.
---@param x Int The X screen position to convert.
---@param y Int The Y screen position to convert.
---@return CoordGrid? # The tile coordinate to return. Returns nil if the active player or game world is unavailable, or if there is no tile beneath the given screen position.
function ScreenConvert.ScreenToCoordGrid(x, y) end

---Returns the CoordGrid for the specified level under the given screen X & Y positions.
---@param x Int The X screen position to convert.
---@param y Int The Y screen position to convert.
---@param level Int The level to output the coordinate for. The value of level must be between 0 and 3 .
---@return CoordGrid? # The tile coordinate to return. Returns nil if the game world is unavailable, the value of level is invalid, or if there is no tile beneath the given screen position.
function ScreenConvert.ScreenToCoordGrid(x, y, level) end

---Returns the CoordFine under the given screen position. Resulting coord will be on the same level as the player character.
---@param position Vector2 The XY screen position to convert.
---@return CoordFine? # The tile coordinate to return. Returns nil if the active player or game world is unavailable, or if there is no tile beneath the given screen position.
function ScreenConvert.ScreenToCoordFine(position) end

---Returns the CoordFine for the specified level under the given screen position.
---@param position Vector2 The XY screen position to convert.
---@param level Int The level to output the coordinate for. The value of level must be between 0 and 3 .
---@return CoordFine? # The tile coordinate to return. Returns nil if the game world is unavailable, the value of level is invalid, or if there is no tile beneath the given screen position.
function ScreenConvert.ScreenToCoordFine(position, level) end

---Returns the CoordFine under the given screen X & Y positions. Resulting coord will be on the same level as the player character.
---@param x Int The X screen position to convert.
---@param y Int The Y screen position to convert.
---@return CoordFine? # The tile coordinate to return. Returns nil if the active player or game world is unavailable, or if there is no tile beneath the given screen position.
function ScreenConvert.ScreenToCoordFine(x, y) end

---Returns the CoordFine for the specified level under the given screen X & Y positions.
---@param x Int The X screen position to convert.
---@param y Int The Y screen position to convert.
---@param level Int The level to output the coordinate for. The value of level must be between 0 and 3 .
---@return CoordFine? # The tile coordinate to return. Returns nil if the game world is unavailable, the value of level is invalid, or if there is no tile beneath the given screen position.
function ScreenConvert.ScreenToCoordFine(x, y, level) end

---Returns the screen XY position, as a Vector2 , of the given CoordGrid . The position is calculated from the centre of the coordinate tile. An optional in-game vertical offset heightAboveGround , which in Fine units , can be applied to the coordinate.
---@param coordGrid CoordGrid The tile coordinate to convert to a screen position. Calculations are made from the centre of the tile.
---@param heightAboveGround Int An additional vertical offset, in Fine units , to add to the tile position before converting.
---@return Vector2? # The resulting screen XY position. Returns nil if the game world or ground data for the given coordinate is unavailable.
function ScreenConvert.CoordGridToScreen(coordGrid, heightAboveGround) end

---Returns the screen XY position, as a Vector2 , of the given CoordFine . An optional in-game vertical offset heightAboveGround , which in Fine units , can be applied to the coordinate.
---@param coordFine CoordFine The tile coordinate to convert to a screen position. The vertical position component is ignored (see above).
---@param heightAboveGround Int An additional vertical offset, in Fine units , to add to the tile position before converting.
---@return Vector2? # The resulting screen XY position. Returns nil if the game world or ground data for the given coordinate is unavailable.
function ScreenConvert.CoordFineToScreen(coordFine, heightAboveGround) end

---Returns the screen XY position, as a Vector2 , of the given Vector3 , in Fine units .
---@param vec3 Vector3 The world position, in Fine units , to convert to a screen position.
---@return Vector2? # The resulting screen XY position. Returns nil if the game world is unavailable.
function ScreenConvert.Vector3ToScreen(vec3) end
