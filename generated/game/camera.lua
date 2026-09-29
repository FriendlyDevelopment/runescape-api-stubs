---@meta

---@class Camera
Camera = {}

---Returns whether camera information is currently available.
---@return Bool Whether camera information is available to read from.
function Camera.IsAvailable() end

---Returns the current position of the game world's camera.
---@return Vector3 The position of the camera, in fine units.
function Camera.GetPosition() end

---Returns the current focus position of the game world's camera. This is typically the waist position of the Player Character during normal gameplay.
---@return Vector3 The focus position of the camera, in fine units.
function Camera.GetFocusPosition() end
