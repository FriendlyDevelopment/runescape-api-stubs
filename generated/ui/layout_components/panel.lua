---@meta

---@class ui
ui = {}

---@class ui.Panel : ui.ComponentCollection
---@field isVertical Bool If true, child components will be positioned in order from the top to the bottom, otherwise a horizontal layout will be used. Changing this will trigger a layout operation on all child components.
---@field spacing Int The size of the gap between components in interface units. Changing this will trigger a layout operation on all child components.
ui.Panel = {}

---@alias Panel ui.Panel

---Creates a new Panel on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this panel in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Panel The newly created panel. The caller must set its layout and visual information afterwards.
function ui.Panel.new(parent, categoryID, dynamicID) end
