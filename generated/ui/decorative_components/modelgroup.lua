---@meta

---Determines how transitions between multiple model group cameras are handled visually.
---@enum ui.ModelCameraTransition
ui.ModelCameraTransition = {
	NONE = "NONE", -- The transition happens immediately.
	FADE = "FADE", -- The transition source fades out over time.
	CROSSFADE = "CROSSFADE", -- The transition source fades out as the transition target fades in.
}

---@class ui
ui = {}

---@class ui.ModelGroup : ui.ComponentCollection
---@field activeCameraID Int (Read-only) The index of the currently active camera.
---@field activeCamera any (Read-only) ui.ModelCamera ? A copy of the currently active camera, or nil if there isn't one.
ui.ModelGroup = {}

---@alias ModelGroup ui.ModelGroup

---Creates a new model group on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this model group in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return ModelGroup The newly created model group. The caller must set its layout and visual information afterwards.
function ui.ModelGroup.new(parent, categoryID, dynamicID) end

---Adds a new defaulted camera, or a previously configured camera to the model group, returning its index.
---@overload fun(self: ui.ModelGroup, camera: ui.ModelCamera): Int
---@return Int Index for the newly added camera.
function ui.ModelGroup:AddCamera() end

---Deletes the camera at the provided index if it exists.
---@param cameraIndex Int The index of the camera to be removed.
function ui.ModelGroup:DeleteCamera(cameraIndex) end

---Switches to the camera at the provided index if it exists, starting a transition effect with the specified parameters.
---@param cameraIndex Int The index of the camera to switch to.
---@param transition ui.ModelCameraTransition Determines how the visibility for this transition should be calculated over time.
---@param transitionMaskSpriteID Int Numeric ID associated with a sprite for use as a mask for this transition.
---@param transitionDurationMs Uint Determines how long this transition lasts for in milliseconds.
---@return Bool True if the camera exists and a transition was successfully started, false otherwise.
function ui.ModelGroup:SwitchCamera(cameraIndex, transition, transitionMaskSpriteID, transitionDurationMs) end

---Checks if there's a camera present at the specified index.
---@param cameraIndex Int The index of the camera to check.
---@return Bool
function ui.ModelGroup:IsValidCameraID(cameraIndex) end

---Retrieves a copy of the camera present at the specified index.
---@return ui.ModelCamera? A copy of the camera present at the specified index, or nil if it's missing.
function ui.ModelGroup:GetCamera() end

---Helper type representing a camera to be used by model group components for rendering.
---@class ui.ModelCamera
---@field clearColour Vector4 Colour used for the background.
---@field useLookAt Bool Determines whether the direction between position and lookAt is used for the camera, otherwise the camera defaults to looking straight ahead. Note this direction will be modified by yawPitchRoll .
---@field transitionRatio Float (Read-only) Indicates how far along the current transition is, ranging from 0 (just started) to 1 (finished).
---@field transitionType ui.ModelCameraTransition (Read-only) Type of the current transition, used to determine how the visibility for this camera should be calculated.
---@field transitionMaskSprite Int Numeric ID identifying the sprite to use as a mask for the current transition.
---@field isTransitionInProgress Bool (Read-only) True if there's a transition happening currently.
---@field isTransitionComplete Bool (Read-only) True if there's no transition currently in progress.
---@field sortModelsUsingComponentOrder Bool Controls whether each model contained in this group is rendered separately in the order their components are set to draw, or all together in a single batch. This may be required for cases where there are multiple models with transparency effects present in the same group.
---@field fov Float (Read-only) Current field-of-view in degrees for this camera.
---@field position Vector3 (Read-only) Current origin position for this camera.
---@field lookAt Vector3 (Read-only) Current target position for this camera.
---@field yawPitchRoll Vector3 (Read-only) Current rotation in radians to be applied to the camera's direction.
---@field nearPlane Float (Read-only) Current minimum distance in world units from the camera before objects are visible.
---@field farPlane Float (Read-only) Current maximum distance in world units from the camera before objects are visible.
ui.ModelCamera = {}

---@alias ModelCamera ui.ModelCamera

---Starts a transition to this camera using the provided sprite mask.
---@param transition ui.ModelCameraTransition Determines how the visibility for this transition should be calculated over time.
---@param maskSpriteID Int Numeric ID associated with a sprite for use as a mask for this transition.
---@param durationMs Uint Determines how long this change takes in milliseconds.
function ui.ModelCamera:StartTransition(transition, maskSpriteID, durationMs) end

function ui.ModelCamera:ClearTransition() end

---@param fov Float Desired field-of-view in degrees. Defaults to 90.0 .
---@param durationMs Uint Determines how long this change takes in milliseconds.
function ui.ModelCamera:SetFOV(fov, durationMs) end

---@param position Vector3 Desired target for this camera, used to determine its direction.
---@param durationMs Uint Determines how long this change takes in milliseconds.
function ui.ModelCamera:SetPosition(position, durationMs) end

---@param target Vector3
---@param durationMs Uint Determines how long this change takes in milliseconds.
function ui.ModelCamera:SetLookAt(target, durationMs) end

---@param yawPitchRoll Vector3 Desired rotations for this camera in radians. If not specified, the camera will point directly at its target as set based on SetPosition and SetLookAt .
---@param durationMs Uint Determines how long this change takes in milliseconds.
function ui.ModelCamera:SetYawPitchRoll(yawPitchRoll, durationMs) end

---@param near Float Minimum distance in world units from the camera before objects are visible.
---@param far Float Maximum distance in world units from the camera before objects are visible.
function ui.ModelCamera:SetClipPlanes(near, far) end
