---@meta

---@class Rect
---@field x Float The X position of the rectangle.
---@field y Float The Y position of the rectangle.
---@field width Float The width of the rectangle.
---@field height Float The height of the rectangle.
---@field left Float The left edge of the rectangle. left = x
---@field top Float The upper edge of the rectangle. top = y
---@field right Float The right edge of the rectangle. right = x + width
---@field bottom Float The lower edge of the rectangle. bottom = y + height
---@field centreX Float The X position of the centre point of the rectangle. centreX = x + (width / 2)
---@field centreY Float The Y position of the centre point of the rectangle. centreY = y + (height / 2)
Rect = {}

---Creates and returns a rectangle with the provided values, or with all elements set to 0 if no arguments were provided.
---@overload fun(x: Float, y: Float, width: Float, height: Float): Rect
---@return Rect # The newly created rectangle
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
---@overload fun(self: Rect, rect: Rect): Bool
---@return Bool # Whether the given position is within this rectangle.
function Rect:Contains(x, y) end

---Returns whether the given other rectangle intersects with this rectangle.
---@param rect Rect The rectangle to test.
---@return Bool # Whether the given rectangle intersects with this rectangle.
function Rect:Intersects(rect) end

---Returns a rectangle which covers where the given rectangle and this rectangle intersect.
---@param rect Rect The rectangle to intersect with.
---@return Rect? # The intersection rectangle. Returns nil if there is no intersection.
function Rect:GetIntersection(rect) end

---Returns a rectangle which encompasses both the given rectangle and this rectangle.
---@param rect Rect The rectangle to union with.
---@overload fun(self: Rect, x: Float, y: Float): Rect
---@return Rect # The encompassing rectangle.
function Rect:GetUnion(rect) end
