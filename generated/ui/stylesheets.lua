---@meta

---@class ui
ui = {}

---@class ui.StyleSheet
---@field [Uint] Int?
---@field id Int Numeric ID associated with this stylesheet.
---@field parent ui.StyleSheet Parent stylesheet for this.
---@field parentID Int Numeric ID associated with the parent for this stylesheet, or -1 if no parent is specified.
ui.StyleSheet = {}

---@alias StyleSheet ui.StyleSheet

---Attempts to retrieve the value for the specified property from this stylesheet, or if missing, from its parent.
---@param property Uint Number representing the style property to search for. Can be an arbitrary number but prefer using a property listed in the ui.StyleValue table for consistency and safety, as the underlying property IDs may change in the future.
---@return Int? # The value of the specified property, or nil if not found.
function ui.StyleSheet:GetValue(property) end

---Sets the value for the specified property on this stylesheet.
---@param property Uint Number representing the style property to search for. Can be an arbitrary number but prefer using a property listed in the ui.StyleValue table for consistency and safety, as the underlying property IDs may change in the future.
---@param value Int The value to set for that property.
function ui.StyleSheet:SetValue(property, value) end

---Checks if the specified property exists on this stylesheet or its parents.
---@param property Uint Number representing the style property to search for. Can be an arbitrary number but prefer using a property listed in the ui.StyleValue table for consistency and safety, as the underlying property IDs may change in the future.
---@return Bool # True if the property exists, false otherwise.
function ui.StyleSheet:HasValue(property) end

---The container of all available stylesheets, can be indexed into using IDs to retrieve existing stylesheets or create new ones.
---@class ui.StyleSheets
---@field [Int] ui.StyleSheet
ui.StyleSheets = {}

---@alias StyleSheets ui.StyleSheets

---Attempts to retrieve the existing stylesheet associated with the provided ID.
---@param styleSheetID Int Numeric ID associated with the stylesheet to be retrieved.
---@return ui.StyleSheet? # The stylesheet associated with the provided ID, or nil if missing.
function ui.StyleSheets:Find(styleSheetID) end

---@param styleSheetID Int Numeric ID associated with the stylesheet.
---@return Bool # Whether a stylesheet exists for the ID.
function ui.StyleSheets:Contains(styleSheetID) end
