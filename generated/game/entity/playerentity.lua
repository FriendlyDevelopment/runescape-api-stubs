---@meta

---@class PlayerEntity
---@field isValid Bool Whether this entity still exists. Dispose of this usertype object when invalid.
---@field uid Int The unique ID (UID) of this entity.
---@field displayName String The display name of this entity.
---@field position Vector3 The world position of this PlayerEntity .
---@field coordGrid CoordGrid Returns the CoordGrid tile this PlayerEntity is currently on.
---@field facing Int The current facing angle, in degrees, of this PlayerEntity .
---@field facingTarget Int The target facing angle, in degrees, of this PlayerEntity .The PlayerEntity will be turning towards this angle, if different from PlayerEntity.facing .
PlayerEntity = {}
