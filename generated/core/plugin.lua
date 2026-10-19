---@meta

---Contains all permissions a plugin may request.
---@enum PluginPermissions
PluginPermissions = {
    httpAccess = "httpAccess", -- Allows the use of HTTP -related functionality if provided. Makes use of base URLs specified in the plugin's manifest file.
    chatAccess = "chatAccess", -- Allows the use of Chat-related functionality if provided.
    trackingAccess = "trackingAccess", -- Allows access to the Player Character's tracking ID through Player.GetTrackingID().
}

---@class Plugin
---@field urls table Table containing all URLs specified in the current plugin's metadata.
---@field resources table Table containing all custom resources stored under the current plugin's resources folder, using their filenames as table keys. See Plugin Resources for information on how to use these.
Plugin = {}

---Checks if the user has allowed the specified permission for the current plugin.
---@param permission PluginPermissions The permission to check.
---@return Bool # True if the specified permission has been given to this plugin, false otherwise.
function Plugin.HasPermission(permission) end

---@enum PluginResourceLoadResult
PluginResourceLoadResult = {
    success = "success", -- The resource has been loaded successfully.
    errorFilesystem = "errorFilesystem", -- Failed to read the resource from disk.
    errorDecode = "errorDecode", -- Failed to decode the resource, it may be using an unsupported format.
    errorExceedsLimits = "errorExceedsLimits", -- Failed to load the resource as it exceeds limits.
    errorConstruction = "errorConstruction", -- Failed to construct this resource even though loading succeeded. This can occur when attempting to load a resource during shutdown for example.
}

---Custom resources provided by plugins can be used as a alternative for built-in ones in various methods, but also provide some additional functionality.
---@class PluginResource
---@field path String (Read-only) The disk path to this resource.
---@field loaded Bool (Read-only) Whether the resource's data is currently loaded and ready to use.
---@field inUse Bool (Read-only) Whether or not the resource is being used anywhere currently.
local PluginResource = {}

---Attempts to load this resource, making it ready for immediate use afterwards if successful.
---@return PluginResourceLoadResult # Indicates whether loading succeeded, or the error in case it failed.
function PluginResource:Load() end

---Attempts to unload this resource's data.
function PluginResource:Unload() end

---@class PluginImageResource : PluginResource
PluginImageResource = {}

---@class PluginAudioResource : PluginResource
PluginAudioResource = {}
