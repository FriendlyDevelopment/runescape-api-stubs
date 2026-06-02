---@meta

---@class game
game = {}

---@class game.options
---@field hasLabels Bool (Read-only) True if there are text labels for this option's values, false otherwise.
---@field isToggle Bool (Read-only) True if this a on/off toggle setting instead of supporting arbitrary values.
---@field isModifiable Bool (Read-only) True if this option can be currently modified. Some settings may not be modified in certain cases where there's a dependency on other settings. For example, you can't change the shadow quality level if shadows are disabled.
---@field setting Int The current setting for this option.
---@field min Int (Read-only) The minimum setting this option can be set to.
---@field max Int (Read-only) The maximum setting this option can be set to.
---@field minMaxRange {[1]: Int, [2]: Int} (Read-only) Returns the minimum and maximum values this option can be set to.
game.options = {}

---@alias options game.options

---Sets this option to the specified setting.
---@param setting Int The setting to set this option to.
---@return Bool True if this option was successfully changed to the provided setting, false otherwise.
function game.options:Set(setting) end

---Checks if the specified setting is valid for this option.
---@param setting Int The setting to check for validity.
---@return Bool True if this option supports being set to the provided setting, false otherwise.
function game.options:CheckIsValidSetting(setting) end

---Gets the user-friendly text label associated with the provided setting for this option.
---@param setting Int The setting to retrieve the text label for.
---@return String? The text label associated with the provided setting, or nil if the setting is invalid or has no associated text.
function game.options:GetLabel(setting) end
