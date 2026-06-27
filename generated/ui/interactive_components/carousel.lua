---@meta

---@class ui
ui = {}

---@class ui.Carousel : ui.Component
---@field selectedID Int (Read-only) The numeric ID for the currently selected entry, or -1 if there is no selection.
---@field buttonWidth Uint16 Width for the carousel's buttons in interface units.
---@field buttonHeight Uint16 Height for the carousel's buttons in interface units.
---@field buttonOffset Uint16 Offset in interface units from the left/right edges applied when positioning the carousel's buttons.
---@field contentMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for this component.
---@field entryText ui.TextData (Modifiable Contents) Text properties used when displaying entry text labels.
---@field buttonSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the carousel's buttons.
---@field backgroundSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the background.
ui.Carousel = {}

---@alias Carousel ui.Carousel

---Creates a new carousel on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this carousel in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Carousel The newly created carousel. The caller must set its layout and visual information afterwards.
function ui.Carousel.new(parent, categoryID, dynamicID) end

---Adds an entry to the carousel.
---@overload fun(self: ui.Carousel, id: Int, iconSpriteID: Int): Bool
---@param id Int Unique numeric value identifying this entry.
---@param label String Text to display for this entry.
---@return Bool True if successful, false if an entry with that ID already exists.
function ui.Carousel:Add(id, label) end

---Removes all entries from the carousel.
function ui.Carousel:Clear() end

---Returns whether or not there's an entry associated with the provided ID.
---@param id Int Numeric value associated with the entry to check.
---@return Bool True if there is an entry corresponding to the provided ID, false otherwise.
function ui.Carousel:HasEntry(id) end

---Sets whether or not the entry associated with the provided ID is enabled and can be selected.
---@param id Int Numeric value associated with the entry to modify.
---@param enabled Bool Whether or not the entry should be enabled and selectable.
---@return Bool True if there was an entry corresponding to the provided ID, false otherwise.
function ui.Carousel:SetEntryEnabled(id, enabled) end

---Returns whether or not the entry associated with the provided ID is enabled and selectable.
---@param id Int Numeric value associated with the entry to access.
---@return Bool True if there was an entry corresponding to the provided ID and it was enabled, false otherwise.
function ui.Carousel:GetEntryEnabled(id) end

---@class ui.ComboField
ui.ComboField = {}

---Selects the entry associated with the provided ID, and optionally triggers the corresponding ONSELECTIONCHANGED events.
---@param id Int Numeric value associated with the entry to select.
---@param triggerEvents Bool? Whether or not to emit ONSELECTIONCHANGED events for this change. Defaults to false.
---@return Bool True if there was an entry corresponding to the provided ID, false otherwise.
function ui.ComboField:Select(id, triggerEvents) end
