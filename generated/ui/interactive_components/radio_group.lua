---@meta

---@class ui
ui = {}

---@class ui.RadioGroup : ui.Component
---@field numSelected Uint8 (Read-only) The number of currently selected options.
---@field selectedValues Int[] (Read-only) Array containing the IDs or values of the currently selected entries.
---@field selectedLabels String[] (Read-only) Array containing the text labels of the currently selected entries.
---@field entryMargin ui.Margin (Modifiable Contents) Offsets used to determine the inner content area within the regions for the individual options.
---@field labelsText ui.TextData (Modifiable Contents) Text properties used when displaying option text labels.
---@field buttonSprite ui.SpriteData (Modifiable Contents) Sprite properties used for the radiogroup's buttons.
ui.RadioGroup = {}

---@alias RadioGroup ui.RadioGroup

---Creates a new radiogroup on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this radiogroup in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return RadioGroup The newly created radiogroup. The caller must set its layout and visual information afterwards.
function ui.RadioGroup.new(parent, categoryID, dynamicID) end

---Adds an option to the radiogroup.
---@param id Int Unique value identifying this option.
---@param label String Text to display for this option.
---@return Bool True if successful, false if an option with that ID already exists.
function ui.RadioGroup:Add(id, label) end

---Removes the option associated with this ID.
---@param id Int Value used to identify the option to remove.
---@return Bool Indicates whether or not an option was successfully removed.
function ui.RadioGroup:Remove(id) end

---Returns whether or not there's an option associated with the provided ID.
---@param id Int Value associated with the option to check.
---@return Bool True if there is an option corresponding to the provided ID, false otherwise.
function ui.RadioGroup:HasEntry(id) end

---Clears existing options from the radiogroup and adds all options in the provided container to the radiogroup.
---@param entries table<String, Int> Table containing a mapping between option names and their IDs to add to the radiogroup.
---@return Bool True if the provided options were valid and were successfully added to the radiogroup, false otherwise. This function can fail and return false due to the provided ID already existing, or due to invalid/malformed data.
function ui.RadioGroup:SetEntries(entries) end

---Gets the value/ID associated with the selectionIndex selected entry.
---@param selectionIndex Uint8 Index into the currently selected entries collection to access.
---@return Int The value/ID associated with the entry, or -1 if there are less than selectionIndex selected entries.
function ui.RadioGroup:GetSelectedValue(selectionIndex) end

---Gets the text label associated with the selectionIndex selected entry.
---@param selectionIndex Uint8 Index into the currently selected entries collection to access.
---@return String The text label associated with the entry, or an empty string if there are less than selectionIndex selected entries.
function ui.RadioGroup:GetSelectedLabel(selectionIndex) end

---Gets whether the option associated with the specified ID is enabled and can be selected by the user.
---@param id Int Value associated with the desired option.
---@return Bool True if the desired option exists and is enabled, false otherwise.
function ui.RadioGroup:GetOptionEnabled(id) end

---Sets whether the option associated with the specified ID is enabled and can be selected by the user.
---@param id Int Value associated with the desired option.
---@param enabled Bool Whether or not the option should be enabled and selectable by the user.
---@return Bool True if the desired option exists, false otherwise.
function ui.RadioGroup:SetOptionEnabled(id, enabled) end

---Gets whether the option associated with the specified ID is currently selected.
---@param id Int Value associated with the desired option.
---@return Bool True if the desired option exists and is selected, false otherwise.
function ui.RadioGroup:GetOptionEnabled(id) end

---Sets whether the option associated with the specified ID is currently selected, optionally triggering selection events.
---@param id Int Value associated with the desired option.
---@param selected Bool Whether or not the option should be selected currently. Defaults to false.
---@param triggerEvents Bool?
---@return Bool True if the desired option exists, false otherwise.
function ui.RadioGroup:SetOptionSelected(id, selected, triggerEvents) end

---Sets the parameters used to position and layout the various options within this radiogroup.
---@param numColumns Uint8 Number of columns to split the various radiogroup contents over.
---@param spacing Uint8 Desired horizontal and vertical spacing between each option.
---@param buttonSize Uint8 Controls whether to display options as toggle buttons or as checks. If set to 0 , options are displayed as toggle buttons, otherwise this controls the size of the checkbox for each option.
---@param buttonLabelSpacing Uint8
function ui.RadioGroup:SetVisualParams(numColumns, spacing, buttonSize, buttonLabelSpacing) end

---Changes the minimum and maximum number of selected options, without changing how many options are currently selected.
---@param minSelectedEntries Uint8 Minimum number of entries that can be selected at any one time.
---@param maxSelectedEntries Uint8 Maximum number of entries that can be selected at any one time.
---@return Bool True if the minSelectedEntries and maxSelectedEntries form a valid range, where the minimum is less than or equal to maximum, and were set successfully, false otherwise.
function ui.RadioGroup:SetSelectionLimits(minSelectedEntries, maxSelectedEntries) end
