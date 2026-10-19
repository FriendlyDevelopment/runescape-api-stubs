---@meta

---@class ui
ui = {}

---@class ui.Interface
---@field id Uint Unique numeric value used to identify this specific interface.
---@field clientOnly Bool True if this interface is managed entirely by the client and doesn't interact with the server.
ui.Interface = {}

---@alias Interface ui.Interface

---Attempts to retrieve the component associated with the various provided IDs contained within this interface.
---@overload fun(self: ui.Interface, interfaceID: Int, staticID: Uint, categoryID: Uint, dynamicID: Uint): ui.Component?
---@param interfaceID Int
---@param staticID Uint ID value used to identify the static component that's being retrieved, or that contains the dynamic component that's being retrieved.
---@return ui.Component? # The component of the appropriate type associated with the specified interface and component IDs, or nil if there's no component with these IDs.
function ui.Interface:GetComponent(interfaceID, staticID) end

---The ui.Interfaces object provides helper methods for quickly retrieving loaded interfaces and their components.
---@class ui.Interfaces
ui.Interfaces = {}

---@alias Interfaces ui.Interfaces

---Retrieves the loaded interface matching the specified ID.
---@param interfaceID Int ID value used to identify the interface containing the component that's being retrieved.
---@return ui.Interface? # The interface associated with the specified ID, or nil if missing or not loaded.
function ui.Interfaces:GetInterface(interfaceID) end

---Retrieves the loaded interface matching the specified ID, and searches within for a component associated with the various provided IDs.
---@overload fun(self: ui.Interfaces, interfaceID: Int, staticID: Uint): ui.Component?
---@overload fun(self: ui.Interfaces, interfaceID: Int, staticID: Uint, categoryID: Uint, dynamicID: Uint): ui.Component?
---@overload fun(self: ui.Interfaces, combinedID: Uint, categoryID: Uint, dynamicID: Uint): ui.Component?
---@param combinedID Uint The combined ID ( (interfaceID << 16) | staticID ) used to identify the component that's being retrieved. Combined IDs are available via lookups such as id.Component.TOPLEVEL_V2__GAME_AREA where the double-underscore separates the interface name ( TOPLEVEL_V2 ) and the name of the component within it ( GAME_AREA )
---@return ui.Component? # The component of the appropriate type associated with the specified interface and component IDs, or nil if there's no component with these IDs or the interface isn't loaded.
function ui.Interfaces:GetComponent(combinedID) end
