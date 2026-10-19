---@meta

---Enumeration identifying how a component that is actively being dragged by the user should be rendered.
---@enum ui.DragRenderBehaviour
ui.DragRenderBehaviour = {
    TRANSPARENT_OVERLAY = "TRANSPARENT_OVERLAY", -- The dragged component will be rendered as semi-translucent and over other components.
    OPAQUE = "OPAQUE", -- The dragged component will be drawn as normal.
    OPAQUE_OVERLAY = "OPAQUE_OVERLAY", -- The dragged component will be drawn as normal and over other components.
    INVISIBLE = "INVISIBLE", -- The dragged component won't be drawn.
}

---Identifies the type of player that's been associated with a component.
---@enum ui.PlayerOpType
ui.PlayerOpType = {
    NONE = "NONE", -- No player is currently associated with this component.
    FRIEND = "FRIEND", -- A player in the local player's friend list is currently associated with this component.
    GROUP_MEMBER = "GROUP_MEMBER", -- A player in the local player's group list is currently associated with this component.
    GROUP_BANNED = "GROUP_BANNED", -- A player in the local player's group ban list is currently associated with this component.
    CLAN_MEMBER = "CLAN_MEMBER", -- A player in the local player's clan is currently associated with this component.
    CLAN_GUEST = "CLAN_GUEST", -- A guest player in the local player's clan is currently associated with this component.
    FRIEND_CHAT = "FRIEND_CHAT", -- A player in the local player's friend chat is currently associated with this component.
}

---Bitmasks for the available pinch axii, can be added together to combine them.
---@enum ui.PinchAxisBit
ui.PinchAxisBit = {
    HORIZONTAL = "HORIZONTAL", -- Allows horizontal pinch gestures.
    VERTICAL = "VERTICAL", -- Allows vertical pinch gestures.
}

---Bitmasks for the available swipe directions, can be added together to combine them.
---@enum ui.SwipeDirectionBit
ui.SwipeDirectionBit = {
    LEFT = "LEFT", -- Allows swipe left gestures.
    RIGHT = "RIGHT", -- Allows swipe right gestures.
    UP = "UP", -- Allows swipe up gestures.
    DOWN = "DOWN", -- Allows swipe down gestures.
}

---@class ui
ui = {}

---Helper type containing information used to filter what ops should be available on a component.
---@class ui.OpNameFilter
---@field filterString String Filtering string to compare against op names.
---@field exactMatch Bool Whether the filter string must be an exact match to the op name, otherwise the filter string is a substring.
---@field invertFilter Bool Inverts the filter results, ie. op names that don't match the filter string return true.
ui.OpNameFilter = {}

---@alias OpNameFilter ui.OpNameFilter

---Creates a new op name filter object.
---@overload fun(filterString: String, exactMatch: Bool, invertFilter: Bool): ui.OpNameFilter
---@return ui.OpNameFilter # True if the provided string would pass this filter, false otherwise.
function ui.OpNameFilter.new() end

---@param testString String String to test this filter against.
---@return Bool # True if the provided string would pass this filter, false otherwise.
function ui.OpNameFilter:Test(testString) end

---Config type containing the ingame actions available for the player to perform when interacting with this config's UI component.
---@class ui.ComponentOpConfig
---@field pauseText String Text to display for this component when an interface pause is triggered by the server. Only affects text and button components.
---@field opWikiText String Text to display for this component's Wiki op entry in the right-click menu.
---@field numOpNames Uint (Read-only) Number of ops defined for this component.
---@field numOpCursors Uint (Read-only) Number of cursors defined for this component's ops.
---@field opNames String[] (Read-only) Names for the ops available for this component.
---@field opBaseName String (Read-only) Suffix used for ops for this component. Commonly used to identify the target of an op.
---@field opCursors Int[] (Read-only) IDs for the cursors available for this component's ops.
---@field targetOpVerb String (Read-only) Prefix used for ops for this component when in target mode. Commonly used to identify the action to perform with something.
---@field targetOpCursor Int ID for the cursor to use when in target mode for this component.
ui.ComponentOpConfig = {}

---@alias ComponentOpConfig ui.ComponentOpConfig

---Retrieves the name of the op at the specified index.
---@param opIndex Int Index of the op that will be accessed.
---@return String # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:GetOpName(opIndex) end

function ui.ComponentOpConfig:ClearOpNames() end

---@param opIndex Int Index of the op that will be accessed.
---@return Int # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:GetOpCursor(opIndex) end

---@param opIndex Int Index of the op that will be accessed.
---@param cursorID Int ID of the cursor to use for this op.
function ui.ComponentOpConfig:SetOpCursor(opIndex, cursorID) end

function ui.ComponentOpConfig:ClearOpCursors() end

---@return Bool # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:HasHiddenTests() end

---@param opIndex Int Index of the op that will be accessed.
---@return Bool # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:TestOpIsHidden(opIndex) end

function ui.ComponentOpConfig:ClearHiddenOps() end

---@param opIndex Int Index of the op that will be accessed.
---@param hidden Bool Whether this op should be hidden by default or not.
function ui.ComponentOpConfig:SetOpIDHidden(opIndex, hidden) end

---@param opIndex Int Index of the op that will be accessed.
---@return Bool # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:GetOpIDHidden(opIndex) end

---@param filter ui.OpNameFilter Filter used to determine whether an op should be shown higher on the op list or not based on its name.
function ui.ComponentOpConfig:SetOpNameHidden(filter) end

---@return ui.OpNameFilter # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:GetOpNameHidden() end

---@return Bool # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:HasHighPriorityTests() end

---@param opIndex Int Index of the op that will be accessed.
---@return Bool # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:TestOpIsHighPriority(opIndex) end

function ui.ComponentOpConfig:ClearHighPriorityOps() end

---@param opIndex Int Index of the op that will be accessed.
---@param highPriority Bool Whether this op should be shown higher on the op list by default or not.
function ui.ComponentOpConfig:SetOpIDHighPriority(opIndex, highPriority) end

---@param opIndex Int Index of the op that will be accessed.
---@return Bool # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:GetOpIDHighPriority(opIndex) end

---@param filter ui.OpNameFilter Filter used to determine whether an op should be shown higher on the op list or not based on its name.
function ui.ComponentOpConfig:SetOpNameHighPriority(filter) end

---@return ui.OpNameFilter # Currently active filter used to determine whether an op should be shown higher on the op list or not based on its name. If not set previously, this will represent an always-fail filter.
function ui.ComponentOpConfig:GetOpNameHighPriority() end

---Configuration paremeters used for swipe gesture handling on components.
---@class ui.ComponentSwipeConfig
---@field directionMask Uint8 Combination of ui.SwipeDirectionBit , determines the direction used to detect swipe gestures.
---@field deadZoneHorizontal Uint8 Minimum horizontal travel distance before an input is treated as a swipe gesture.
---@field deadZoneVertical Uint8 Minimum vertical travel distance before an input is treated as a swipe gesture.
---@field deceleration Uint8 Determines how far a swipe gesture drifts based on previous motion. Ranges from 1 to 100 , representing 1% - 100% deceleration. A value of 100 results in no swipe drift being applied.
---@field stopExponent Uint8 Exponent applied to the threshold value at which we stop drifting. A value of 1 indicates drifting stops at drift speeds below 0.1 , while 2 results in stopping below 0.01 . Should generally be left at the default value of 8 for consistency.
ui.ComponentSwipeConfig = {}

---@alias ComponentSwipeConfig ui.ComponentSwipeConfig

---Sets the minimum travel distance for horizontal and vertical inputs before being treated as a swipe gesture.
---@param horizontal Uint8
---@param vertical Uint8
function ui.ComponentSwipeConfig:SetDeadZone(horizontal, vertical) end

---Configuration parameters used for drag gestures handling on components.
---@class ui.ComponentDragConfig
---@field draggedComponent ui.Component The component that's being actively dragged.
---@field renderBehaviour ui.DragRenderBehaviour Indicates how the component should be rendered while it's being dragged.
---@field dragDelayTicks Uint8 How long the user must be attempting a drag action for on a component in logic ticks, before the action actually starts.
---@field deadZone Uint8 Minimum distance in interface units before a drag gesture is triggered, assuming dragDelayTicks has been exceeded.
ui.ComponentDragConfig = {}

---@alias ComponentDragConfig ui.ComponentDragConfig

---Configuration parameters used for pinch gestures handling on components.
---@class ui.ComponentPinchConfig
---@field directionMask Uint8 Combination of ui.SwipeDirectionBit , determines the direction used to detect pinch gestures.
---@field threshold Uint8 Minimum distance in interface units before a pinch gesture is triggered.
ui.ComponentPinchConfig = {}

---@alias ComponentPinchConfig ui.ComponentPinchConfig

---Configuration parameters used for cursors associated with this component.
---@class ui.ComponentCursorConfig
---@field mouseOverCursor Int The ID of the cursor to display when the mouse is over this component. A value of -1 indicates no cursor is set.
---@field targetValidCursor Int The ID of the cursor to display when in target mode for this component and the cursor is over a valid target. A value of -1 indicates no cursor is
---@field targetInvalidCursor Int The ID of the cursor to display when in target mode for this component and the cursor is over an invalid target. A value of -1 indicates no cursor is
ui.ComponentCursorConfig = {}

---@alias ComponentCursorConfig ui.ComponentCursorConfig

---Contains arbitrary parameter data associated with the component.
---@class ui.ComponentParamsConfig
---@field valid Bool (Read-only) True if there are any parameters set on this component.
ui.ComponentParamsConfig = {}

---@alias ComponentParamsConfig ui.ComponentParamsConfig

---Retrieves the value for the parameter associated with the provided ID.
---@param paramID Int Numeric ID associated with the parameter to check.
---@return Int|String|nil # The parameter value, or nil if no parameter is associated with the provided ID.
function ui.ComponentParamsConfig:Get(paramID) end

---@param paramID Int Numeric ID associated with the parameter to check.
---@return Bool # True if a parameter with the specified ID exists, false otherwise.
function ui.ComponentParamsConfig:CheckExists(paramID) end
