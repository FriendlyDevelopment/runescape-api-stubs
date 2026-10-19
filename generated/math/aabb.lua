---@meta

---Used with AABB:GetCorner() to select the position of a specific corner of an AABB .
---@enum BoxCornerType
BoxCornerType = {
    LEFT_TOP_NEAR = 0,
    RIGHT_TOP_NEAR = 1,
    LEFT_BOTTOM_NEAR = 2,
    RIGHT_BOTTOM_NEAR = 3,
    LEFT_TOP_FAR = 4,
    RIGHT_TOP_FAR = 5,
    LEFT_BOTTOM_FAR = 6,
    RIGHT_BOTTOM_FAR = 7,
}

---@class AABB
---@field minimum Vector3 The minimum values of each axis.
---@field maximum Vector3 The maximum values of each axis.
---@field dimensions Vector3 The width, height, and length values of the AABB.
---@field centre Vector3 The centre position of the AABB.
---@field minX Float The minimum value of the X axis.
---@field minY Float The minimum value of the Y axis.
---@field minZ Float The minimum value of the Z axis.
---@field maxX Float The maximum value of the X axis.
---@field maxY Float The maximum value of the Y axis.
---@field maxZ Float The maximum value of the Z axis.
---@field width Float The width of the AABB.
---@field height Float The height of the AABB.
---@field length Float The length of the AABB.
---@field radiusMinimum Float The radius of a sphere centered inside the AABB that wholly contains the AABB at any orientation
---@field radiusMinimumSq Float The squared radius of a sphere centered inside the AABB that wholly contains the AABB at any orientation
---@field radiusMaximum Float The radius of a sphere centered inside the AABB that is the largest sphere that can fit inside this AABB
---@field radiusMaximumSq Float The squared radius of a sphere centered inside the AABB that is the largest sphere that can fit inside this AABB
AABB = {}

---Creates and returns an AABB with the provided values.
---@param minimum Vector3 The minimum value on each axis.
---@param maximum Vector3 The maximum value on each axis.
---@return AABB # The newly created AABB
function AABB.new(minimum, maximum) end

---Returns the position of the given corner type in this AABB.
---@param corner BoxCornerType The corner type.
---@return Vector3 # The position of the corner.
function AABB:GetCorner(corner) end

---Returns whether the position is within the AABB
---@param position Vector3 The position to test.
---@overload fun(self: AABB, otherAABB: AABB): Bool
---@return Bool # Whether the given position is within this AABB.
function AABB:IsInside(position) end

---Returns whether the given line segment intersects with this AABB at any point.
---@param fromPosition Vector3 The line segment start position to test.
---@param toPosition Vector3 The line segment end position to test.
---@overload fun(self: AABB, otherAABB: AABB): Bool
---@return Bool # Whether an intersection occurs.
function AABB:Intersects(fromPosition, toPosition) end

---Returns the position on the AABB surface which is closest to the given position. If the position is inside the AABB then the given position will be returned.
---@param position Vector3 The position to test.
---@return Vector3 # The closest AABB surface position, or the given position if it is inside the AABB.
function AABB:GetClosestPosition(position) end

---Returns the position on the AABB surface which is furthest to the given position.
---@param position Vector3 The position to test.
---@return Vector3 # The furthest AABB surface position.
function AABB:GetFurthestPosition(position) end

---Returns the shortest distance from the given position to this AABB. Will return 0.0 if the position is inside the AABB.
---@param position Vector3 The position to test.
---@return Float # The closest distance from the position to the AABB, or 0 if the position is inside the AABB.
function AABB:GetDistanceToPosition(position) end

---Moves the AABB's minimum and maximum elements by the given offset value.
---@param offset Vector3 The offset applied to the AABB.
function AABB:Translate(offset) end

---Scales the AABB about 0,0,0 by the given amount.
---@param scale Vector3 The scaling value to apply to the AABB.
function AABB:Scale(scale) end

---Scales the AABB about the centre of the AABB by the given amount.
---@param scale Vector3 The scaling value to apply to the AABB.
function AABB:ScaleFromCentre(scale) end

---Expands this AABB to encompass the given position.
---@param position Vector3 The position to encompass.
function AABB:AddPosition(position) end

---Expands this AABB to encompass the given AABB.
---@param otherAABB AABB The AABB to encompass.
function AABB:AddAABB(otherAABB) end
