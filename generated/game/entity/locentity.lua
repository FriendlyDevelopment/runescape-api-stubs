---@meta

---Indicates the 90-degree rotation type a LocEntity is using. Also see LocEntity.rotationType .
---@enum RotationType
RotationType = {
    ZERO = 0,
    NINETY = 1,
    ONEEIGHTY = 2,
    TWOSEVENTY = 3,
}

---@class LocEntity
---@field isValid Bool Whether this entity still exists. Dispose of this usertype object when invalid.
---@field displayName String The display name of this entity.
---@field config LocType The config used by this entity.
---@field parentConfig LocType The parent config used by this entity, if it is a MultiLoc .
---@field configID Int The ID of the config used by this entity.
---@field parentConfigID Int The ID of the parent config used by this entity, if it is a MultiLoc .
---@field isMultiLoc Bool Whether this entity is a MultiLoc .
---@field position Vector3 The world position of this entity.
---@field coordGrid CoordGrid Returns the CoordGrid tile this entity is currently on.
---@field shapeType LocShapeType The LocShapeType being used by this entity.
---@field rotationType RotationType The 90-degree rotation type being used by this entity.
---@field width Int The width of this entity on the X axis, in grid units. This taken from entity's LocType config after being rotated by rotationType .
---@field length Int The length of this entity on the Z axis, in grid units. This taken from entity's LocType config after being rotated by rotationType .
---@field isHidden Bool Whether this entity has been hidden by game logic.
---@field isRoofRemoved Bool Whether this entity has been hidden by the Remove Roof system.
---@field currentAnimation SeqType The current animation being played by this entity. Returns nil if none is set.
LocEntity = {}
