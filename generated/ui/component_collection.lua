---@meta

---@class ui
ui = {}

---@class ui.ComponentCollection : ui.Component
---@field scrollable bool (Read-only) Indicates whether this component can be scrolled.
---@field scrollX number (Read-only) Current horizontal origin for this component's scroll region.
---@field scrollY number (Read-only) Current vertical origin for this component's scroll region.
---@field scrollWidth number (Read-only) Width of this component's scroll region.
---@field scrollHeight number (Read-only) Height of this component's scroll region.
ComponentCollection = {}

---Iterates over statically defined components contained in this collection, executing the provided callback once for each component, optionally stopping based on the callback's return value.
---@param callback fun(component : ui.Component, visible : Bool):Bool Callback to execute for each component, receiving the component and its visibility status. If it returns true, iteration will stop
function ComponentCollection:IterateStaticComponents(callback) end

---@param callback fun(component : ui.Component, visible : Bool):Bool Callback to execute for each component, receiving the component and its visibility status. If it returns true, iteration will stop
function ComponentCollection:IterateDynamicComponents(callback) end

---Attempts to retrieve the static or dynamic child component corresponding to the provided IDs, returning nil if missing.
---@overload fun(self: ComponentCollection, categoryID: Int, dynamicID: Int): Component?
---@param staticID Int Value used to identify a static component.
---@return Component? # The existing component if found, or nil if missing
function ComponentCollection:GetChild(staticID) end

---Attempts to delete the dynamic child component corresponding to the provided IDs, returning true if successful.
---@param categoryID Int Value used to identify the category associated with a component.
---@param dynamicID Int Value used to identify the in-category ID associated with a component.
---@return Bool # Indicates whether or not a component was deleted.
function ComponentCollection:Delete(categoryID, dynamicID) end

---Deletes all dynamically created child components contained in the current collection.
function ComponentCollection:DeleteAll() end

---Sets the origin of this component's scroll region, if it supports scrolling.
---@param x Int Horizontal origin for this component's scroll region.
---@param y Int Vertical origin for this component's scroll region.
function ComponentCollection:SetScrollPos(x, y) end

---Sets the size of this component's scroll region, if it supports scrolling.
---@param width Int Target width for this component's scroll region.
---@param height Int Target height for this component's scroll region.
function ComponentCollection:SetScrollSize(width, height) end
