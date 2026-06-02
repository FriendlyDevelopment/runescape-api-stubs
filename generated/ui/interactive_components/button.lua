---@meta

---Contains the various options for how a button could be triggered by a user or the application.
---@enum ui.TriggerMode
ui.TriggerMode = {
    ONPRESS_FINISH = "ONPRESS_FINISH", -- The button's action will be triggered once the button press animation finishes.
    ONPRESS = "ONPRESS", -- The button's action will be triggered immediately after the user clicks/taps on the button.
    ONRELEASE = "ONRELEASE", -- The button's action will only be triggered once the user releases the click/tap on the button.
    REPEAT = "REPEAT", -- The button's action will trigger similarly to ONPRESS and will repeat every so often while held down.
}

---@class ui
ui = {}

---@class ui.Button : ui.Component
---@field label String Text to display as this button's label, aliases text.content .
---@field isToggled Bool Whether or not the button is toggled currently. Always false for non-toggle buttons.
---@field canToggle Bool Controls whether this button can be toggled or not.
---@field mode ui.TriggerMode Describes how user interactions are handled by this button.
---@field associatedObjectID Int Numeric ID for the object associated with this component, or -1 if no associated object exists.
---@field associatedObjectQuantity Int The quantity for the object associated with this component.
---@field showAssociatedObjectText Bool Controls whether the button's label should be replaced with the associated object's text. Defaults to the actual label text if there's no associated object, or if it's invalid.
---@field showAssociatedObjectSprite Bool Controls whether the sprite for the associated object will be displayed on top of the button's sprite. Does nothing if there's no associated object, or if it's invalid.
---@field contentMargin ui.Margin Margin used to determine the label region for the button.
---@field text ui.TextData Button label parameters.
---@field sprite ui.SpriteData Button sprite parameters.
ui.Button = {}

---@alias Button ui.Button

---Creates a new button on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this button in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Button The newly created button. The caller must set its layout and visual information afterwards.
function ui.Button.new(parent, categoryID, dynamicID) end

---Associates an object with this component, making it use the object's name and optionally it's quantity as the displayed contents for this component.
---@param objectID Int Numeric ID for the object to associate with this component.
---@param quantity Uint64? The quantity for the object to associate with this component.
function ui.Button:SetAssociatedObject(objectID, quantity) end
