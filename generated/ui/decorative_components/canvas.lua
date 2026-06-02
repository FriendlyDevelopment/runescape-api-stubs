---@meta

---@class ui
ui = {}

---@class ui.Canvas : ui.Component
---@field numElements Int Returns the number of drawable elements present on this canvas.
ui.Canvas = {}

---@alias Canvas ui.Canvas

---Creates a new canvas on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this canvas in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Canvas The newly created canvas. The caller must set its layout and visual information afterwards.
function ui.Canvas.new(parent, categoryID, dynamicID) end

---Adds a line to the list of drawable elements for this canvas.
---@overload fun(self: ui.Canvas, x: Int, y: Int, endX: Int, endY: Int, thickness: Float, colour: Vector4)
---@param x Int Starting horizontal position for this element.
---@param y Int Starting vertical position for this element.
---@param endX Int Final horizontal position for this element.
---@param endY Int Final vertical position for this element.
---@param thickness Float This element's width in interface units.
---@param colourRGBA Uint Hex colour code for this element.
function ui.Canvas:AddLine(x, y, endX, endY, thickness, colourRGBA) end

---Adds a hollow rectangle to the list of drawable elements for this canvas.
---@overload fun(self: ui.Canvas, x: Int, y: Int, width: Int, height: Int, thickness: Float, colour: Vector4)
---@param x Int Horizontal position for this element.
---@param y Int Vertical position for this element.
---@param width Int Width for this element.
---@param height Int Height for this element.
---@param thickness Float Outline segment width in interface units.
---@param colourRGBA Uint Hex colour code for this element.
function ui.Canvas:AddOutline(x, y, width, height, thickness, colourRGBA) end

---Adds a filled rectangle to the list of drawable elements for this canvas.
---@overload fun(self: ui.Canvas, x: Int, y: Int, width: Int, height: Int, colour: Vector4)
---@param x Int Horizontal position for this element.
---@param y Int Vertical position for this element.
---@param width Int Width for this element.
---@param height Int Height for this element.
---@param colourRGBA Uint Hex colour code for this element.
function ui.Canvas:AddRectangle(x, y, width, height, colourRGBA) end

---Adds a rectangle containing a horizontal gradient to the list of drawable elements for this canvas.
---@overload fun(self: ui.Canvas, x: Int, y: Int, width: Int, height: Int, startColour: Vector4, endColour: Vector4)
---@param x Int Horizontal position for this element.
---@param y Int Vertical position for this element.
---@param width Int Width for this element.
---@param height Int Height for this element.
---@param startColourRGBA Uint Hex colour code for the starting colour for this element.
---@param endColourRGBA Uint Hex colour code for the end colour for this element.
function ui.Canvas:AddGradientH(x, y, width, height, startColourRGBA, endColourRGBA) end

---Adds a rectangle containing a horizontal gradient to the list of drawable elements for this canvas.
---@overload fun(self: ui.Canvas, x: Int, y: Int, width: Int, height: Int, startColour: Vector4, endColour: Vector4)
---@param x Int Horizontal position for this element.
---@param y Int Vertical position for this element.
---@param width Int Width for this element.
---@param height Int Height for this element.
---@param startColourRGBA Uint Hex colour code for the starting colour for this element.
---@param endColourRGBA Uint Hex colour code for the end colour for this element.
function ui.Canvas:AddGradientV(x, y, width, height, startColourRGBA, endColourRGBA) end

---Adds a coloured triangle to the list of drawable elements for this canvas.
---@overload fun(self: ui.Canvas, p0X: Int, p0Y: Int, p1X: Int, p1Y: Int, p2X: Int, p2Y: Int, colour: Vector4)
---@param p0X Int Horizontal position for the triangle's first vertex.
---@param p0Y Int Vertical position for the triangle's first vertex.
---@param p1X Int Horizontal position for the triangle's second vertex.
---@param p1Y Int Vertical position for the triangle's second vertex.
---@param p2X Int Horizontal position for the triangle's third vertex.
---@param p2Y Int Vertical position for the triangle's third vertex.
---@param colourRGBA Uint Hex colour code for this element.
function ui.Canvas:AddTriangle(p0X, p0Y, p1X, p1Y, p2X, p2Y, colourRGBA) end

---Adds a sprite to the list of drawable elements for this canvas.
---@overload fun(self: ui.Canvas, x: Int, y: Int, width: Int, height: Int, spriteID: Int, uvs: Rect, colourRGBA: Uint)
---@overload fun(self: ui.Canvas, x: Int, y: Int, width: Int, height: Int, spriteID: Int, uvs: Rect, spriteConfig: ui.SpriteDataConfig)
---@param x Int Horizontal position for this element.
---@param y Int Vertical position for this element.
---@param width Int Width for this element.
---@param height Int Height for this element.
---@param spriteID Int Numeric ID for the sprite to draw.
---@param colourRGBA Uint Hex colour code for this element.
function ui.Canvas:AddSprite(x, y, width, height, spriteID, colourRGBA) end

---Adds a block of text to the list of drawable elements for this canvas.
---@overload fun(self: ui.Canvas, x: Int, y: Int, text: String, fontID: Int, colour: Vector4)
---@overload fun(self: ui.Canvas, x: Int, y: Int, text: String, textConfig: ui.TextDataConfig)
---@overload fun(self: ui.Canvas, x: Int, y: Int, areaWidth: Int, areaHeight: Int, text: String, textConfig: ui.TextDataConfig)
---@param x Int Horizontal position for this element.
---@param y Int Vertical position for this element.
---@param text String The text to draw.
---@param fontID Int Numeric ID for the font used when drawing this block of text.
---@param colourRGBA Uint Hex colour code for this element.
function ui.Canvas:AddText(x, y, text, fontID, colourRGBA) end

---Removes all drawables elements from this canvas.
function ui.Canvas:Clear() end

---Removes the element most recently added to this canvas.
function ui.Canvas:Undo() end
