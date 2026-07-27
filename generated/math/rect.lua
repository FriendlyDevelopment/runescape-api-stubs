---@meta

---@class Rect
---@field x Float
---@field y Float
---@field width Float
---@field height Float
---@field left Float
---@field top Float
---@field right Float
---@field bottom Float
---@field centreX Float
---@field centreY Float
Rect = {}

---Creates and returns a rectangle with the provided values, or with all elements set to 0 if no arguments were provided.
---@overload fun(x: Float, y: Float, width: Float, height: Float): Rect
---@return Rect The newly created rectangle
function Rect.new() end

---Moves the rectangle's X and Y elements by the given input values.
---@param offsetX Float The offset applied to the X element.
---@param offsetY Float The offset applied to the Y element.
function Rect:Translate(offsetX, offsetY) end

---Increases each edge of the rectangle by the given horizontal and vertical values.
---@param horizontal Float The expansion applied to the left and right edges of the rectangle.
---@param vertical Float The expansion applied to the top and bottom edges of the rectangle.
function Rect:Grow(horizontal, vertical) end

---Decreases each edge of the rectangle by the given horizontal and vertical values.
---@param horizontal Float The reduction applied to the left and right edges of the rectangle.
---@param vertical Float The reduction applied to the top and bottom edges of the rectangle.
function Rect:Shrink(horizontal, vertical) end

---Scales the rectangle about 0,0 by the given amount.
---@param scale Float The scaling value to apply to all elements in the rectangle.
function Rect:Scale(scale) end

---Returns whether the given X and Y position is within this rectangle
---@param x Float The X position to test.
---@param y Float The Y position to test.
---@return Bool Whether the given position is within this rectangle.
function Rect:Contains(x, y) end

---Returns whether the given other rectangle is entirely contained within this rectangle.
---@param rect Rect The rectangle to test.
---@return Bool Whether the given rectangle is within this rectangle.
function Rect:Contains(rect) end

---Returns whether the given other rectangle intersects with this rectangle.
---@param rect Rect The rectangle to test.
---@return Bool Whether the given rectangle intersects with this rectangle.
function Rect:Intersects(rect) end

---Returns a rectangle which covers where the given rectangle and this rectangle intersect.
---@param rect Rect The rectangle to intersect with.
---@return Rect? The intersection rectangle.Returns nil if there is no intersection.
function Rect:GetIntersection(rect) end

---Returns a rectangle which encompasses both the given rectangle and this rectangle.
---@param rect Rect The rectangle to union with.
---@return Rect The encompassing rectangle.
function Rect:GetUnion(rect) end

---Returns a rectangle which encompasses both the given X and Y position and this rectangle.
---@param x Float The X position to union with.
---@param y Float The Y position to union with.
---@return Rect The encompassing rectangle.
function Rect:GetUnion(x, y) end
