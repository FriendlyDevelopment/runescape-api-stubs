---@meta

---@class ui
ui = {}

---@class ui.Text : ui.Component
---@field associatedObjectID Int Numeric ID for the object associated with this component, or -1 if no associated object exists.
---@field associatedObjectQuantity Int The quantity for the object associated with this component.
---@field content String The text to draw.
---@field font Int The font to use when drawing this text.
---@field lineSpacing Uint8 Spacing between text lines in interface units. Defaults to the font's spacing if set to zero.
---@field alignHorizontal ui.AlignMode Horizontal alignment for this text.
---@field alignVertical ui.AlignMode Vertical alignment for this text.
---@field maxLines Uint8 Maximum number of lines to display. Can be set to 0 to allow an unlimited number of lines.
---@field shadowColour Vector4 Colour used when drawing this text's shadow if enabled.
---@field shadowRGBA Uint Hex-encoded red/green/blue/alpha colour code used when drawing this text's shadow if enabled.
---@field isShadowed Bool Whether or not to draw this text with a shadow effect for better legibility. Defaults to false.
ui.Text = {}

---@alias Text ui.Text

---Creates a new text component on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this text component in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Text # The newly created text component. The caller must set its layout and visual information afterwards.
function ui.Text.new(parent, categoryID, dynamicID) end

---Associates an object with this component, making it use the object's name and optionally it's quantity as the displayed contents for this component.
---@param objectID Int Numeric ID for the object to associate with this component.
---@param quantity Uint64? The quantity for the object to associate with this component.
function ui.Text:SetAssociatedObject(objectID, quantity) end

---Sets the alignment for this text.
---@overload fun(self: ui.Text, horizontalAlignment: ui.AlignMode, verticalAlignment: ui.AlignMode)
---@param alignment ui.AlignMode The alignment to set as both horizontal and vertical alignments.
function ui.Text:AlignTo(alignment) end

---Sets this Text's properties based on the provided config values.
---@param config ui.TextDataConfig The config to source the various properties from.
function ui.Text:SetConfig(config) end

---Returns a copy of this Text's config, allowing it to be used elsewhere.
---@return ui.TextDataConfig # Config containing a copy of all properties set on this Text object, excluding non-config properties (eg. content )
function ui.Text:GetConfigCopy() end
