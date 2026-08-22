---@meta

---Enumeration containing flags used to control RadialProgressOverlay behaviour and visuals.
---@enum ui.RadialProgressOverlayFlag
ui.RadialProgressOverlayFlag = {
    AUTOMATIC = "AUTOMATIC", -- Indicates that once started, this overlay's progress will automatically advance over time. This is ideal for timer overlays.
    REVERSE = "REVERSE", -- Indicates the overlay starts filled and gradually depletes.
    FLIP_HORIZONTAL = "FLIP_HORIZONTAL", -- Inverts the overlay's visuals horizontally.
    FLIP_VERTICAL = "FLIP_VERTICAL", -- Inverts the overlay's visuals vertical.
}

---@class ui
ui = {}

---@class ui.RadialProgressOverlay : ui.Component
---@field curValue Float The current value for this overlay, ranging between initialValue and endValue . This can be set, allowing the creation of progress indicators that don't start at initialValue .
---@field initialValue Float (Read-only) The initial value for this overlay, as specified via Set .
---@field endValue Float (Read-only) The final value for this overlay, as specified via Set .
---@field progress Float (Read-only) The current progress percentage for this overlay, ranging from 0 to 1 , representing 0% and 100% respectively.
---@field maskSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the overlay's visuals, normally used as a transparency mask.
ui.RadialProgressOverlay = {}

---@alias RadialProgressOverlay ui.RadialProgressOverlay

---Creates a new radial progress overlay on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this radial progress overlay in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return RadialProgressOverlay # The newly created radial progress overlay. The caller must set its layout and visual information afterwards.
function ui.RadialProgressOverlay.new(parent, categoryID, dynamicID) end

---Sets the value range for this component and any additional flags to modify its behaviour.
---@param initialValue Float The starting value for this overlay.
---@param endValue Float The final value for this overlay.
---@param flags Uint8 Combination of flags used to determine how this radial is displayed and whether or not it should automatically progress after this function call.
function ui.RadialProgressOverlay:Start(initialValue, endValue, flags) end
