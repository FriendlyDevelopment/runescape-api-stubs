---@meta

---@class ui
ui = {}

---@class ui.Component
---@field alpha Float Controls how opaque this component appears, ranges from 0 (fully transparent) to 1 (opaque).
---@field rgb Uint Hexadecimal colour code representing the Red, Green, and Blue tints for this component.
---@field rgba Uint Hexadecimal colour code representing the Red, Green, Blue, And Alpha tints for this component.
---@field colour Vector4 Red, Green, Blue, and Alpha tints represented as a 4-channel vector, with each channel limited to a 0..1 range. On assignment, values outside of this range will be clamped.
---@field hidden Bool Controls whether this component is visible. This only applies to Lua-side visibility, and cannot be used to force built-in UI components to become visible.
---@field visible Bool (Read-only) Indicates whether this component is visible or not. This state refers only to the internal state of this component. For the global visibility state see visibleGlobal . Differs from hidden in that this also takes into account built-in UI component visibility.
---@field visibleGlobal Bool (Read-only) Indicates whether this component is visible within the UI component tree. For example, will return false if any parent of this component is not visible.
---@field stylesheetID Int ID for the StyleSheet currently in use by this component, or -1 if no StyleSheet is active.
---@field aspectRatioProportion Float (Read-only) The aspect ratio width value divided by the height value. For example, a 16:10 ratio resolves to a proportion of 1.6 .
---@field aspectRatioWidth Int (Read-only) The target width value used for aspect ratio calculations. Note this value is always 1 or higher, even when aspect ratio scaling is disabled.
---@field aspectRatioHeight Int (Read-only) The target height value used for aspect ratio calculations. Note this value is always 1 or higher, even when aspect ratio scaling is disabled.
---@field aspectRatioMode ui.AspectRatioMode (Read-only) Mode used when determining how the aspect ratio should be applied to this component, if at all.
---@field enabled Bool Controls whether this component responds to inputs and events.
---@field clickthrough Bool Controls whether mouse interactions on this component block interactions on components below it.
---@field isMouseOver Bool (Read-only) Whether the cursor is currently over this component or not.
---@field isClicked Bool (Read-only) Whether the user has clicked on this component recently or not.
---@field opConfig ui.ComponentOpConfig Identifies the action to perform when the component is interacted with.
---@field dragConfig ui.ComponentDragConfig Determines how the component reacts to drag actions.
---@field swipeConfig ui.ComponentSwipeConfig Determines how the component reacts to swipe gestures.
---@field pinchConfig ui.ComponentPinchConfig Determines how the component reacts to pinch gestures.
---@field cursorConfig ui.ComponentCursorConfig Specifies which cursors to use, if any, when interacting with this component.
---@field paramsConfig ui.ComponentParamsConfig Additional parameters attached to this component.
---@field type ui.ComponentType (Read-only) ID identifying the type of this component.
---@field parent any (Read-only) ui.Component ? The immediate parent of this component within the UI component tree. Returns nil if there is no parent.
---@field parentStatic any (Read-only) ui.Component ? The static parent of this component within the UI component tree. Returns nil if there is no static parent.
---@field parentInterface Interface (Read-only) Interface in which this component resides.
---@field interfaceID Int (Read-only) ID identifying the interface in which this component resides.
---@field staticID Int (Read-only) ID identifying the static component on which this component resides.
---@field categoryID Int (Read-only) ID identifying the dynamic ID category this component's using, or -1 if this is a static component.
---@field dynamicID Int (Read-only) ID identifying the dynamic ID category this component's using, or -1 if this is a static component.
---@field position ui.Pos Gets or sets this component's origin.
---@field size ui.Size Gets or sets the dimensions for this component.
---@field isSafeAreaRelative Bool Whether or not layout operations involving this component take into account the device's safe areas.
---@field x Int (Read-only) Current horizontal position for this component relative to its parent.
---@field y Int (Read-only) Current vertical position for this component relative to its parent.
---@field width Int (Read-only) Current width for this component.
---@field height Int (Read-only) Current height for this component.
---@field xyLocal Vector2 (Read-only) Current XY position for this component relative to its parent.
---@field xyGlobal Vector2 (Read-only) Current absolute XY position for this component.
Component = {}

---Moves this component's origin to the provided coordinates, optionally taking into account the parent's dimensions, and this component's own dimensions.
---@param x Int Absolute horizontal coordinate to move this component to in interface units
---@param parentPercentageX Float? If specified, offsets this component's horizontal origin based on a percentage of its parent's width.
---@param selfPercentageX Float? If specified, offsets this component's horizontal origin based on a percentage of its width.
function Component:SetX(x, parentPercentageX, selfPercentageX) end

---@param y Int Absolute vertical coordinate to move this component to in interface units
---@param parentPercentageY Float? If specified, offsets this component's vertical origin based on a percentage of its parent's height.
---@param selfPercentageY Float? If specified, offsets this component's vertical origin based on a percentage of its height.
function Component:SetY(y, parentPercentageY, selfPercentageY) end

---@param x Int Absolute horizontal coordinate to move this component to in interface units
---@param y Int Absolute vertical coordinate to move this component to in interface units
---@param parentPercentageX Float? If specified, offsets this component's horizontal origin based on a percentage of its parent's width.
---@param parentPercentageY Float? If specified, offsets this component's vertical origin based on a percentage of its parent's height.
---@param selfPercentageX Float? If specified, offsets this component's horizontal origin based on a percentage of its width.
---@param selfPercentageY Float? If specified, offsets this component's vertical origin based on a percentage of its height.
function Component:SetPos(x, y, parentPercentageX, parentPercentageY, selfPercentageX, selfPercentageY) end

---Sets the width/height for this component, optionally taking into account the parent's dimensions.
---@param x Int Absolute width in interface units to resize this component to.
---@param parentPercentageX Float? If specified, offsets this component's width based on a percentage of its parent's width.
function Component:SetWidth(x, parentPercentageX) end

---@param y Int Absolute height in interface units to resize this component to.
---@param parentPercentageY Float? If specified, offsets this component's height based on a percentage of its parent's height.
function Component:SetHeight(y, parentPercentageY) end

---@param x Int Absolute width in interface units to resize this component to.
---@param y Int Absolute height in interface units to resize this component to.
---@param parentPercentageX Float? If specified, offsets this component's width based on a percentage of its parent's width.
---@param parentPercentageY Float? If specified, offsets this component's height based on a percentage of its parent's height.
function Component:SetSize(x, y, parentPercentageX, parentPercentageY) end

---Sets the target aspect ratio the component should follow, and how it should be applied. Can also be used to disable aspect ratio scaling.
---@param widthRatio Int Target width aspect ratio
---@param heightRatio Int Target height aspect ratio
---@param mode ui.AspectRatioMode Indicates how the component scales based on its target aspect ratio
function Component:SetAspectRatio(widthRatio, heightRatio, mode) end

---Destroys this component, along with any other components that might have been attached to it.
function Component:Destroy() end

---Moves this component to the front/back of the render order, causing it to draw on top/below of components that have the same parent.
function Component:MoveToFront() end

function Component:MoveToBack() end

---Triggers a layout update on this component.
function Component:UpdateLayout() end

---Subscribes a listener for an event hook, setting a callback to be triggered whenever this event occurs, and optionally assigning it an ID allowing it to be referenced to in the future.
---@overload fun(self: Component, hook: ui.Hook, id: String, callback: fun(...):Bool?)
---@param hook ui.Hook The event hook to listen for.
---@param callback fun(...):Bool? The callback to trigger on this event, with parameters varying based on the event hook type. Can return a boolean indicating whether or not to continue processing listeners afterwards. If omitted, the callback is treated as if it returned true, resulting in other listeners still getting triggered.
function Component:Subscribe(hook, callback) end

---Removes the listener set for the specified hook with the provided ID, or the default listener for that hook if omitted, from that component.
---@overload fun(self: Component, hook: ui.Hook, id: String)
---@param hook ui.Hook The event hook to listen for.
function Component:Unsubscribe(hook) end

---Removes all event listeners of the specified type from this component associated with the current plugin.
---@param hook ui.Hook The event hook to clear the listeners for.
function Component:UnsubscribeAll(hook) end

---These events are only triggered when using a touchscreen.
---@enum ui.Hook
ui.Hook = {
    ONBUTTONPRESSED = "ONBUTTONPRESSED", -- Triggered whenever the user interacts with this button/check. Non-toggle buttons will always receive 1 and 0 for current/previous values respectively.
    ONCONTENTCHANGED = "ONCONTENTCHANGED", -- Triggered whenever a user interacts with an input field component in a way that may affect its contents.
    ONSELECTIONCHANGED = "ONSELECTIONCHANGED", -- entryID represents the component's entry that's had its selected status changed, while a selectedStatus of 1 indicates this entry has been selected and 0 indicates it has been deselected.
    ONCUTSCENEFINISHED = "ONCUTSCENEFINISHED", -- Triggered when a cutscene finishes playing on a cutscene layer component.
    ONCLICK = "ONCLICK", -- Triggered when the user clicks the left mouse button or taps on this component.
    ONCLICKREPEAT = "ONCLICKREPEAT", -- Triggered when the user clicks the left mouse button or taps on this component.
    ONRELEASE = "ONRELEASE", -- Triggered when the user stops clicking on this component or stops a tap gesture.
    ONHOLD = "ONHOLD", -- Triggered while the user is clicking on this component.
    ONMOUSEOVER = "ONMOUSEOVER", -- Triggered when the cursor enters this component's region.
    ONMOUSEREPEAT = "ONMOUSEREPEAT", -- Triggered while the cursor is over this component's region.
    ONMOUSELEAVE = "ONMOUSELEAVE", -- Triggered when the cursor leaves this component's region.
    ONDRAG = "ONDRAG", -- Triggered when the user starts dragging this component.
    ONDRAGCOMPLETE = "ONDRAGCOMPLETE", -- Triggered when the user finishes dragging this component.
    ONSCROLLWHEEL = "ONSCROLLWHEEL", -- Triggered when the user moves the mouse's scrollwheel.
    ONKEY = "ONKEY", -- Triggered when the user inputs a key on their keyboard.
    ONSWIPEVERTICAL = "ONSWIPEVERTICAL", -- Triggered whenever a horizontal swipe motion occurs.
    ONSWIPEHORIZONTAL = "ONSWIPEHORIZONTAL", -- Triggered whenever a vertical swipe motion occurs.
    ONSWIPECOMPLETE = "ONSWIPECOMPLETE", -- Triggered when a swipe gesture terminates.
    ONPINCHHORIZONTAL = "ONPINCHHORIZONTAL", -- Triggered whenever a horizontal pinch motion occurs. Direction is -1 for inwards pinch gestures, and 1 for outwards.
    ONPINCHVERTICAL = "ONPINCHVERTICAL", -- Triggered whenever a vertical pinch motion occurs. Direction is -1 for inwards pinch gestures, and 1 for outwards.
    ONPINCHCOMPLETE = "ONPINCHCOMPLETE", -- Triggered when a pinch gesture terminates.
    ONGAMEPADBUTTON = "ONGAMEPADBUTTON",
    ONGAMEPADBUTTONHELD = "ONGAMEPADBUTTONHELD",
    ONGAMEPADAXIS = "ONGAMEPADAXIS",
    ONGAMEPADTRIGGER = "ONGAMEPADTRIGGER",
    ONOP = "ONOP", -- Triggered whenever the user interacts with something in the game world, or with a UI component that has ops specified for its interactions.
    ONOPT = "ONOPT", -- Triggered when the user selects another UI component while in target selection mode.
    ONTARGETENTER = "ONTARGETENTER", -- Triggered when the component enters target selection mode.
    ONTARGETLEAVE = "ONTARGETLEAVE", -- Triggered when the component leaves target selection mode.
    ONVARPTRANSMIT = "ONVARPTRANSMIT", -- Triggered when the game client receives a server transmission for player variables.
    ONINVTRANSMIT = "ONINVTRANSMIT", -- Triggered when the game client receives a server transmission for inventories.
    ONSTATTRANSMIT = "ONSTATTRANSMIT", -- Triggered when the game client receives a server transmission for stats.
    ONVARCTRANSMIT = "ONVARCTRANSMIT", -- Triggered when the game client receives a server transmission for client variables.
    ONVARCSTRTRANSMIT = "ONVARCSTRTRANSMIT", -- Triggered when the game client receives a server transmission for client string variables.
    ONVARCLANTRANSMIT = "ONVARCLANTRANSMIT", -- Triggered when the game client receives a server transmission for clan variables.
    ONCHATTRANSMIT = "ONCHATTRANSMIT", -- Triggered when the game client receives a server transmission for chat messages.
    ONFRIENDTRANSMIT = "ONFRIENDTRANSMIT", -- Triggered when the game client receives a server transmission for friends data.
    ONCLANTRANSMIT = "ONCLANTRANSMIT", -- Triggered when the game client receives a server transmission for clan data.
    ONCLANSETTINGSTRANSMIT = "ONCLANSETTINGSTRANSMIT", -- Triggered when the game client receives a server transmission for clan settings data.
    ONCLANCHANNELTRANSMIT = "ONCLANCHANNELTRANSMIT", -- Triggered when the game client receives a server transmission for clan chat messages.
    ONRELATIONSHIPSETTRANSMIT = "ONRELATIONSHIPSETTRANSMIT", -- Triggered when the game client receives a server transmission for friends/clans/ignore lists.
    ONMISCTRANSMIT = "ONMISCTRANSMIT", -- Triggered when the game client receives a server transmission for miscellaneous data.
    ONSTOCKTRANSMIT = "ONSTOCKTRANSMIT", -- Triggered when the game client receives a server transmission for stock data.
    ONPLAYERGROUPTRANSMIT = "ONPLAYERGROUPTRANSMIT", -- Triggered when the game client receives a server transmission involving the current player group state.
    ONPLAYERGROUPVARPTRANSMIT = "ONPLAYERGROUPVARPTRANSMIT", -- Triggered when the game client receives a server transmission for the current group's player variable.
    ONCAMERAUPDATETRANSMIT = "ONCAMERAUPDATETRANSMIT", -- Triggered when the game client receives a server transmission involving camera changes.
    ONTIMER = "ONTIMER", -- Triggered once per logic tick. Prefer using PluginLogic over this as it's a more general solution.
    ONDIALOGABORT = "ONDIALOGABORT", -- Triggered manually by the server.
    ONSUBCHANGE = "ONSUBCHANGE", -- Triggered whenever a sub-interface loads.
    ONCAMFINISHED = "ONCAMFINISHED", -- Triggered whenever a server-controlled camera motion finishes.
    ONRESIZE = "ONRESIZE", -- Triggered whenever this component has its dimensions changed.
}
