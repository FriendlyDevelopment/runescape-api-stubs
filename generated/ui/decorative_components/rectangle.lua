---@meta

---@class ui
ui = {}

---@class ui.Rectangle : ui.Component
---@field fill Bool If true, this rectangle will be drawn as a single block, otherwise it will be drawn as an outline. Defaults to false.
---@field outlineThickness Int The pixel thickness of the outline drawn for this rectangle. Defaults to 1. Positive values will draw inwards, while negative values will draw outwards. Outlines are clipped by parent containers, which will affect negative outlines when a rectangle fills its container space.
ui.Rectangle = {}

---@alias Rectangle ui.Rectangle

---Creates a new rectangle on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this rectangle in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Rectangle The newly created rectangle. The caller must set its layout and visual information afterwards.
function ui.Rectangle.new(parent, categoryID, dynamicID) end
