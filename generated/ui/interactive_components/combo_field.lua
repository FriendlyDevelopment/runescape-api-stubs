---@meta

---@class ui
ui = {}

---@class ui.ComboField : ui.Component
---@field hasSelection Bool (Read-only) Indicates whether or not there is an entry currently selected.
---@field selectedID Int (Read-only) The numeric ID for the currently selected entry, or -1 if there is no selection.
---@field selectedLabel String (Read-only) The label for the currently selected entry, or an empty string if there is no selection.
---@field entryHeight Uint8 Height for each displayed entry in interface units.
---@field dropdownMaxVisibleEntries Uint8 How many entries can be displayed on the combofield's dropdown.
---@field entries ComboEntry[] (Read-only) Array containing the entries present on this combofield.
---@field numEntries Int (Read-only) Indicates how many entries are present on this combofield.
---@field mouseoverForegroundColour Vector4 Colour used for the foreground when the cursor is positioned over an entry.
---@field mouseoverForegroundRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the foreground when the cursor is positioned over an entry.
---@field mouseoverBackgroundColour Vector4 Colour used for the background when the cursor is positioned over an entry.
---@field mouseoverBackgroundRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the background when the cursor is positioned over an entry.
---@field selectedForegroundColour Vector4 Colour used for the foreground for the currently selected entry.
---@field selectedForegroundRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the foreground for the currently selected entry.
---@field selectedBackgroundColour Vector4 Colour used for the background for the currently selected entry.
---@field selectedBackgroundRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the background for the currently selected entry.
---@field disabledForegroundColour Vector4 Colour used for the foreground of disabled entries.
---@field disabledForegroundRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the foreground of disabled entries.
---@field caretColour Vector4 Colour used for the input section's caret.
---@field caretRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the input section's caret.
---@field errorCaretColour Vector4 Colour used for the input section's caret when an error occurs.
---@field errorCaretRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the input section's caret when an error occurs.
---@field selectionHighlightColour Vector4 Colour used for the input selection overlay.
---@field selectionHighlightRGBA Uint Hex-encoded red/green/blue/alpha colour code used for the input selection overlay.
---@field contentMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for this component.
---@field headerMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area for this component's dropdown header.
---@field entryText ui.TextData (Modifiable Contents) Text properties used when displaying entries for this combo.
---@field entrySprite ui.SpriteData (Modifiable Contents) Sprite properties used for the background.
---@field buttonSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the combofield's button.
---@field headerSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the combofield's header.
---@field scrollbar ui.ScrollBar (Modifiable Contents) Scroll bar proprties used when vertical scrolling is required.
ui.ComboField = {}

---@alias ComboField ui.ComboField

---Creates a new combofield on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this combofield in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return ComboField The newly created combo. The caller must set its layout and visual information afterwards.
function ui.ComboField.new(parent, categoryID, dynamicID) end

---Adds an entry to this combofield with the provided label and ID.
---@param label String The text to display for this entry.
---@param id Int Unique value used to identify this entry.
---@return Bool True if the entry was added successfully, false otherwise. This function can fail and return false due to the provided ID already existing.
function ui.ComboField:Add(label, id) end

---Removes the entry associated with this ID.
---@param id Int Unique value used to identify the entry to remove.
---@return Bool Indicates whether or not an entry was successfully removed.
function ui.ComboField:Remove(id) end

---Removes all entries from this combo.
function ui.ComboField:Clear() end

---Clears the selection for this combofield.
function ui.ComboField:UnselectAll() end

---Selects the entry associated with the provided ID, and optionally triggers the corresponding ONSELECTIONCHANGED events.
---@param id Int Numeric value associated with the entry to select.
---@param triggerEvents Bool? Whether or not to emit ONSELECTIONCHANGED events for this change. Defaults to false.
---@return Bool True if there was an entry corresponding to the provided ID, false otherwise.
function ui.ComboField:Select(id, triggerEvents) end

---Returns whether or not there's an entry associated with the provided ID.
---@param id Int Numeric value associated with the entry to check.
---@return Bool True if there is an entry corresponding to the provided ID, false otherwise.
function ui.ComboField:HasEntry(id) end

---Clears existing entries from the combofield and adds all entries in the provided container to the combo, optionally selecting the one with the provided ID.
---@overload fun(self: ui.ComboField, entriesMap: table<String, Int>, selectedID: Int?): Bool
---@param entries String[] Array of entry names to add to this combo. Their respective IDs are autogenerated using an auto-incrementing integer.
---@param selectedID Int? ID for the entry to be selected afterwards. If this is an invalid ID or not specified, the first entry will be selected instead for lists that always require at least one selected entry (dropdowns for example).
---@return Bool True if the provided entries were valid and were successfully added to the combo, false otherwise. This function can fail and return false due to the provided ID already existing, or due to invalid/malformed data.
function ui.ComboField:SetEntries(entries, selectedID) end

---In most cases, entries must be modified through methods on the combofield itself, however you can also iterate through the combofield contents via the entries property, which returns a collection of entries. These are fairly limited and mostly provide an easy way to read the various properties for the various entries.
---@class ComboEntry
---@field text String The label for this entry.
---@field id Int (Read-only) The value for this entry.
---@field selectable Bool (Read-only) Whether this entry can be selected.
ComboEntry = {}
