---@meta

---@class ui
ui = {}

---@class ui.Layer : ui.ComponentCollection
ui.Layer = {}

---@alias Layer ui.Layer

---Creates a new Layer on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this layer in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Layer The newly created layer. The caller must set its layout and visual information afterwards.
function ui.Layer.new(parent, categoryID, dynamicID) end
