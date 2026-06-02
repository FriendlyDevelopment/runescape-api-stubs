---@meta

---Enumeration identifying how the quantity of an associated object should be displayed on a sprite with an associated object.
---@enum ui.ObjectQuantityDisplayMode
ui.ObjectQuantityDisplayMode = {
    NEVER = "NEVER", -- The quantity indicator is never displayed.
    ALWAYS = "ALWAYS", -- The quantity indicator is always displayed.
    MULTIPLE = "MULTIPLE", -- The quantity indicator is displayed if there's more than one object in the stack.
}

---@class ui
ui = {}

---@class ui.Sprite : ui.Component
---@field associatedObjectID Int Numeric ID for the object associated with this component, or -1 if no associated object exists.
---@field associatedObjectQuantity Int The quantity for the object associated with this component.
---@field associatedObjectQuantityMode ui.ObjectQuantityDisplayMode Specifies when the label listing the quantity for the associated object should be displayed.
---@field sprite Int RuntimeSprite
---@field spriteID Int Gets the built-in sprite ID to draw.
---@field runtimeSprite RuntimeSprite Gets the current runtime sprite to draw or nil if it doesn't exist.
---@field visualMargins ui.Margin (Modifiable Contents) Offsets used to split this sprite's graphics into multiple segments for drawing.
---@field outlineWidth Uint8 Thickness of the sprite's outline. Only used when the containing component is associated with an object.
---@field rotationDegrees Float Rotation of this sprite in degrees.
---@field rotationRadians Float Rotation of this sprite in radians.
---@field isFlippedHorizontally Bool Flag indicating whether or not this sprite is drawn mirrored horizontally.
---@field isFlippedVertical Bool Flag indicating whether or not this sprite is drawn mirrored vertical.
---@field isTiling Bool Flag indicating whether or not this sprite uses tiled visuals.
---@field shadowColour Vector4 Colour used when drawing this sprite's shadow. If alpha is 0, no shadow will be drawn.
---@field shadowRGBA Uint Hex-encoded red/green/blue/alpha colour code used when drawing this sprite. If alpha is 0, no shadow will be drawn.
ui.Sprite = {}

---@alias Sprite ui.Sprite

---Creates a new sprite component on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this sprite component in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Sprite The newly created sprite component. The caller must set its layout and visual information afterwards.
function ui.Sprite.new(parent, categoryID, dynamicID) end

---Associates an object with this component, making it use the object's name and optionally it's quantity as the displayed contents for this component.
---@param objectID Int Numeric ID for the object to associate with this component.
---@param quantity Uint64? The quantity for the object to associate with this component.
function ui.Sprite:SetAssociatedObject(objectID, quantity) end

---Sets the alignment for this sprite.
---@overload fun(self: ui.Sprite, horizontalAlignment: ui.AlignMode, verticalAlignment: ui.AlignMode)
---@param alignment ui.AlignMode The alignment to set as both horizontal and vertical alignments.
function ui.Sprite:AlignTo(alignment) end

---Sets this Sprite's properties based on the provided config values.
---@param config ui.SpriteDataConfig The config to source the various properties from.
function ui.Sprite:SetConfig(config) end

---Returns a copy of this Sprite's config, allowing it to be used elsewhere.
---@return ui.SpriteDataConfig Config containing a copy of all properties set on this Sprite object, excluding non-config properties (eg. content )
function ui.Sprite:GetConfigCopy() end
