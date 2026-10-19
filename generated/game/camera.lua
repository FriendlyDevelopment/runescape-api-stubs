---@meta

---Provides access to a game world's active camera.
---@class Camera
Camera = {}

---Returns whether camera information is currently available.
---@return Bool # Whether camera information is available to read from.
function Camera.IsAvailable() end

---Returns the current position of the game world's camera.
---Returns {0, 0, 0} if the camera is unavailable.
---@return Vector3 # The position of the camera, in fine units.
function Camera.GetPosition() end

---Returns the current focus position of the game world's camera.
---This is typically the waist position of the Player Character during normal gameplay.
---Returns {0, 0, 0} if the camera is unavailable.
---@return Vector3 # The focus position of the camera, in fine units.
function Camera.GetFocusPosition() end
