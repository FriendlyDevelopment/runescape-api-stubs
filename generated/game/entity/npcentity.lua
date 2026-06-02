---@meta

---@class NPCEntity
---@field isValid Bool Whether this entity still exists. Dispose of this usertype object when invalid.
---@field uid Int The unique ID (UID) of this entity.
---@field displayName String The display name of this entity.
---@field config NPCType The config used by this entity.
---@field parentConfig NPCType The parent config used by this entity, if it is a MultiNPC .
---@field configID Int The ID of the config used by this entity.
---@field parentConfigID Int The ID of the parent config used by this entity, if it is a MultiNPC .
---@field isMultiNPC Bool Whether this NPCEntity is a MultiNPC .
---@field position Vector3 The world position of this NPCEntity .
---@field coordGrid CoordGrid Returns the CoordGrid tile this NPCEntity is currently on.
---@field facing Int The current facing angle, in degrees, of this NPCEntity .
---@field facingTarget Int The target facing angle, in degrees, of this NPCEntity .The NPCEntity will be turning towards this angle, if different from NPCEntity.facing .
NPCEntity = {}
