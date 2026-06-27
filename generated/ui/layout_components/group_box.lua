---@meta

---Specifies how the groupbox header will be positioned horizontally.
---@enum ui.GroupBoxHeaderAlignMode
ui.GroupBoxHeaderAlignMode = {
	LEFT = "LEFT", -- The header is positioned against the left side of the component.
	CENTRE = "CENTRE", -- The header is centred on the component.
	RIGHT = "RIGHT", -- The header is positioned against the right side of the component.
}

---@class ui
ui = {}

---@class ui.GroupBox : ui.ComponentCollection
---@field headerWidth Uint8 The header's width in interface units.
---@field headerHeight Uint8 The header's height in interface units.
---@field headerOffsetX Uint8 The header's offset from the left in interface units.
---@field headerOffsetY Uint8 The header's offset from the right in interface units.
---@field headerAlignment ui.GroupBoxHeaderAlignMode Defines how the header should be positioned.
---@field headerText ui.TextData (Modifiable Contents) Label properties used for the header text.
---@field contentBackgroundSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the background.
---@field headerBackgroundSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the header background.
---@field contentMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for this component.
ui.GroupBox = {}

---@alias GroupBox ui.GroupBox

---Creates a new GroupBox on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this groupbox in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return GroupBox The newly created groupbox. The caller must set its layout and visual information afterwards.
function ui.GroupBox.new(parent, categoryID, dynamicID) end

---Sets the parameters used to position and size the component's header area.
---@param width Uint8 The header's width in interface units.
---@param height Uint8 The header's height in interface units.
---@param offsetX Uint8 The header's offset from the left in interface units.
---@param offsetY Uint8 The header's offset from the right in interface units.
---@param alignment ui.GroupBoxHeaderAlignMode Defines how the header should be positioned.
function ui.GroupBox:SetHeaderLayout(width, height, offsetX, offsetY, alignment) end
