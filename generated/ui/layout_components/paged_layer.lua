---@meta

---@class ui
ui = {}

---@class ui.PagedLayer : ui.ComponentCollection
---@field activePage Uint8 The currently active page, displayed to the user.
---@field numPages Uint8
---@field numBuiltinPages Uint8 (Read-only) The number of statically built-in pages on this paged layer. Always zero for dynamically created paged layers.
---@field contentMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for this component.
---@field backgroundSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the background.
ui.PagedLayer = {}

---@alias PagedLayer ui.PagedLayer

---Creates a new PagedLayer on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this paged layer in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return PagedLayer The newly created paged layer. The caller must set its layout and visual information afterwards.
function ui.PagedLayer.new(parent, categoryID, dynamicID) end

---Sets whether the user can switch to the specified page through a paged layer header .
---@param pageIndex Uint8 Index for the page to access.
---@param enabled Bool Controls whether or not the user can switch to that page manually.
function ui.PagedLayer:SetPageEnabled(pageIndex, enabled) end

---Gets whether the user can switch to the specified page through a paged layer header .
---@param pageIndex Uint8 Index for the page to access.
---@return Bool True if the page exists and is enabled, false otherwise.
function ui.PagedLayer:GetPageEnabled(pageIndex) end

---Sets the text label displayed for the specified page in a paged layer header .
---@param pageIndex Uint8 Index for the page to access.
---@param label String Text to display for this page in a paged layer header.
function ui.PagedLayer:SetPageLabel(pageIndex, label) end

---Gets the text label displayed for the specified page in a paged layer header .
---@param pageIndex Uint8 Index for the page to access.
---@return String Text to display for this page in a paged layer header, or an empty string if not specified or if the page is missing.
function ui.PagedLayer:GetPageLabel(pageIndex) end

---Sets the ID for the sprite to display as an icon for the specified page in a paged layer header .
---@param pageIndex Uint8 Index for the page to access.
---@param iconSpriteID Int ID for the sprite to use as an icon for this page.
function ui.PagedLayer:SetPageIcon(pageIndex, iconSpriteID) end

---Gets the ID for the sprite to display as an icon for the specified page in a paged layer header .
---@param pageIndex Uint8 Index for the page to access.
---@return Int ID for the sprite to use as an icon for this page, or -1 if not specified or if the page is missing.
function ui.PagedLayer:GetPageIcon(pageIndex) end

---Creates a new PagedLayerHeader on the specified parent, and associates it with this paged layer, allowing it to retrieve labels and icons for the available pages.
---@param parent ui.ComponentCollection Parent component to create this paged layer header in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return PagedLayerHeader The newly created paged layer header associated with this paged layer. The caller must set its layout and visual information afterwards.
function ui.PagedLayer:AddHeader(parent, categoryID, dynamicID) end

---These components are directly associated with an individual PagedLayer, and provide a basic UI to allow the user to switch between the various pages.
---@class ui.PagedLayerHeader
---@field target ui.PagedLayer The paged layer associated with this header, and where page information is being sourced retrieved from.
---@field isHorizontal Bool Controls whether this header uses a horizontal or vertical layout.
---@field contentMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for this component.
---@field pageHeaderMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for each page element.
---@field entryText ui.TextData (Modifiable Contents) Text properties used when displaying entries for this combo.
---@field backgroundSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the background.
---@field disabledPageIcon ui.SpriteData (Modifiable Contents) Sprite properties used for the icon displayed on disabled pages.
---@field pageHeaderSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the the individual page elements.
ui.PagedLayerHeader = {}

---@alias PagedLayerHeader ui.PagedLayerHeader
