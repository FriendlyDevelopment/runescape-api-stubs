---@meta

---@class Matrix33
Matrix33 = {}

---Constructs a 3x3 rotation matrix representing a rotation around the y-axis.
---@param rotationAmount Float Amount to rotate the y-axis about, in radians.
---@return Matrix33 # The resulting rotation matrix.
function Matrix33.rotationY(rotationAmount) end

---Constructs a 3x3 rotation matrix representing the provided quaternion.
---@param rotation Quaternion Rotation to convert.
---@return Matrix33 # The provided rotation converted to a matrix.
function Matrix33.fromQuaternion(rotation) end
