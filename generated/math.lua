---@meta

---@class Math
Math = {}

---Calculates a linearly interpolated value based on starting and final values and an interpolation factor.
---@overload fun(start: Vector2, final: Vector2, t: Float): Vector2
---@overload fun(start: Vector3, final: Vector3, t: Float): Vector3
---@overload fun(start: Vector4, final: Vector4, t: Float): Vector4
---@overload fun(start: Matrix33, final: Matrix33, t: Float): Matrix33
---@param start Float|Vector2|Vector3|Vector4|Matrix33 Starting value used in interpolation.
---@param final Float|Vector2|Vector3|Vector4|Matrix33 Final value used in interpolation.
---@param t Float Interpolation percentage between start and end values.
---@return Float|Vector2|Vector3|Vector4|Matrix33 # Resulting value from interpolating between start and end.
function lerp(start, final, t) end

---Calculates a spherically interpolated value based on starting and final values and an interpolation factor.
---@overload fun(start: Quaternion, final: Quaternion, t: Float): Quaternion
---@param start Vector3|Quaternion Starting value used in interpolation.
---@param final Vector3|Quaternion Final value used in interpolation.
---@param t Float Interpolation percentage between start and end values.
---@return Vector3|Quaternion # Resulting value from interpolating between start and end.
function slerp(start, final, t) end

---Limits a value to the provided range.
---@param value Float Value to clamp.
---@param min Float Minimum value that can be returned.
---@param max Float Maximum value that can be returned.
---@return Float # The resulting value clamped to the provided min and max range.
function clamp(value, min, max) end

---Calculates a random value in the specified range.
---@param min Float Minimum value that can be returned.
---@param max Float Maximum value that can be returned.
---@return Float # The randomly calculated value within the specified range
function random(min, max) end
