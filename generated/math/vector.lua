---@meta

---@class Vector
---@field isNormal Bool (Read-only) True if this is a unit-length vector.
---@field length Float (Read-only) Length value for this vector.
---@field lengthSq Float (Read-only) Squared length value for this vector. Faster to calculate than length.
---@field invLength Float (Read-only) Inverse of the length value for this vector, equivalent to 1.0 / length.
Vector = {}

---Computes the absolute value representation for the provided vector and returns it.
---@return Vector Contains the absolute value representation of the provided vector.
function Vector:Abs() end

---Returns a vector where each element is the smallest integer that's greater than the original element.
---@return Vector Contains the result from ceil'ing each of the original vector's elements.
function Vector:Ceil() end

---Returns a vector where each element is the largest integer that's not greater than the original element.
---@return Vector Contains the result from floor'ing each of the original vector's elements.
function Vector:Floor() end

---Returns the dot-product of two vectors.
---@param other Vector Vector to compare elements to.
---@return Float Contains the maximum elements of both vectors.
function Vector:Dot(other) end

---Returns an element-wise maximum between two vectors.
---@param other Vector Vector to compare elements to.
---@return Vector Contains the maximum elements of both vectors.
function Vector:Max(other) end

---Returns an element-wise minimum between two vectors.
---@param other Vector Vector to compare elements to.
---@return Vector Contains the minimum elements of both vectors.
function Vector:Min(other) end

---Normalises the current vector, rescaling its elements so it becomes a vector of length 1. Does nothing if all elements of the vector are 0.
function Vector:Normalise() end

---Returns a normalised version of the provided vector, with its elements rescaled so it becomes a vector of length 1.
---@param fallback Vector Value to return if all elements on the vector this was called on are 0.
---@return Vector Normalised version of the caller or the fallback if the caller had length 0
function Vector:Normalise(fallback) end

---Additional properties and methods provided for Vector2 types.
---@class Vector2
---@field x Float First element in this vector.
---@field y Float Second element in this vector.
---@field u Float First element in this vector, aliasing x.
---@field v Float Second element in this vector, aliasing y.
Vector2 = {}

---Creates and returns a vector with the provided values, or with all elements set to 0 if no arguments were provided.
---@overload fun(v: Float): Vector2
---@overload fun(x: Float, y: Float): Vector2
---@return Vector2 The newly created element
function Vector2.new() end

---Additional properties and methods provided for Vector3 types.
---@class Vector3
---@field x Float First element in this vector.
---@field y Float Second element in this vector.
---@field z Float Third element in this vector.
Vector3 = {}

---Creates and returns a vector with the provided values, or with all elements set to 0 if no arguments were provided.
---@overload fun(v: Float): Vector3
---@overload fun(x: Float, y: Float, z: Float): Vector3
---@return Vector3 The newly created element
function Vector3.new() end

---Returns the cross-product of two 3D vectors.
---@param other Vector3 Vector to calculate the cross-product against.
---@return Vector3 Contains the maximum elements of both vectors.
function Vector3:Cross(other) end

---Calculates the reflection of the current vector along the provided normal.
---@param normal Vector3 Vector treated as the normal for the surface to calculate the reflection on.
---@return Vector3 Contains the reflection of the source vector on the provided surface normal.
function Vector3:Cross(normal) end

---Calculates the result of rotating this vector by the provided quaternion.
---@param rotation Quaternion Quaternion describing the rotation to apply.
---@return Vector3 Contains the result of rotating the source vector by the provided quaternion.
function Vector3:Rotate(rotation) end

---Additional properties and methods provided for Vector4 types.
---@class Vector4
---@field x Float First element in this vector.
---@field y Float Second element in this vector.
---@field z Float Third element in this vector.
---@field w Float Fourth element in this vector.
---@field xyz Vector3 (Read-only) Returns x, y, and z as a separate vector.
---@field xy Vector2 (Read-only) Returns x and y as a separate vector.
---@field zw Vector2 (Read-only) Returns z and w as a separate vector.
Vector4 = {}

---Creates and returns a vector with the provided values, or with all elements set to 0 if no arguments were provided.
---@overload fun(v: Float): Vector4
---@overload fun(x: Float, y: Float, z: Float, w: Float): Vector4
---@overload fun(xy: Vector2, zw: Vector2): Vector4
---@return Vector4 The newly created element
function Vector4.new() end
