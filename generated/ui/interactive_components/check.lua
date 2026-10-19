---@meta

---Specifies how the contents of a check component should be positioned.
---@enum ui.CheckAlignMode
ui.CheckAlignMode = {
    INLINE = "INLINE", -- Contents are aligned to the left and the button appears after the label.
    INLINE_INVERTED = "INLINE_INVERTED", -- Contents are aligned to the right and the button appears before the label.
    LEFT = "LEFT", -- Contents are aligned to the left and the button appears before the label.
    RIGHT = "RIGHT", -- Contents are aligned to the right and the button appears after the label.
}

---@class ui
ui = {}

---@class ui.Check : ui.Component
---@field label String Text to display as this check's label, aliases text.content .
---@field value Bool Indicates if the check is currently ticked or not.
---@field alignment ui.CheckAlignMode Determines how the Check's label and button should be positioned. Defaults to ui.CheckAlignMode.LEFT
---@field buttonSize Int Determines the size of the Check's button in interface units. Limited to a maximum of 255 units. Defaults to the component's height if not set, or set to 0.
---@field text ui.TextData Check label parameters.
---@field sprite ui.SpriteData Check sprite parameters.
ui.Check = {}

---@alias Check ui.Check

---Creates a new check on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this check in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Check # The newly created check. The caller must set its layout and visual information afterwards.
function ui.Check.new(parent, categoryID, dynamicID) end
