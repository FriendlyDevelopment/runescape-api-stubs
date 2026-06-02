---@meta

---@class Quaternion
Quaternion = {}

---Constructs a quaternion from the provided yaw, pitch, and roll values.
---@param yaw Float Yaw rotation in radians.
---@param pitch Float Pitch rotation in radians.
---@param roll Float Roll rotation in radians.
---@return Quaternion Contains the absolute value representation of the provided vector.
function Quaternion.fromYawPitchRoll(yaw, pitch, roll) end

---Constructs a quaternion from the provided rotation matrix.
---@param source Matrix33 Matrix containing the rotation to convert.
---@return Quaternion Quaternion representing the rotation contained in the provided matrix.
function Quaternion.fromMatrix(source) end

---Constructs a quaternion representing the rotation of the source quaternion by the provided rotation quaternion.
---@param rotation Quaternion Represents the rotation to apply.
---@return Quaternion Result of rotating the current quaternion by the rotation quaternion.
function Quaternion:rotateBy(rotation) end
