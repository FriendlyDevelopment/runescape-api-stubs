---@meta

---@class ui
ui = {}

---@class ui.Line : ui.Component
---@field invert Bool If true, inverts diagonal lines vertically. Defaults to false.
---@field width Uint Width used for this line in interface units. May differ from actual visible width due to anti-aliasing. Defaults to 1 .
ui.Line = {}

---@alias Line ui.Line

---Creates a new line on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this line in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Line # The newly created line. The caller must set its layout and visual information afterwards.
function ui.Line.new(parent, categoryID, dynamicID) end
