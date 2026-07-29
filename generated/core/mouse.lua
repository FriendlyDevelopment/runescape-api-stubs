---@meta

---@class Mouse
Mouse = {}

---Returns whether mouse data is available on the current platform.
---@return Bool Whether mouse data can be polled on the current platform. Returns false on Mobile devices, and true on all others.
function Mouse.IsAvailable() end

---Returns the current mouse X & Y position, if available.
---@return Vector2? The current mouse position. Returns nil on Mobile devices.
function Mouse.GetPosition() end

---Returns the current mouse X position, if available.
---@return Int? The current X position of the mouse. Returns nil on Mobile devices.
function Mouse.GetX() end

---Returns the current mouse Y position, if available.
---@return Int? The current Y position of the mouse. Returns nil on Mobile devices.
function Mouse.GetY() end
