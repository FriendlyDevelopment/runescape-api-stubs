---@meta

---A LocShapeType is a usage hint found in all LocType configs. A config can have multiple of these LocShapeTypes , each of which having its own set of models to display.
---@enum LocShapeType
LocShapeType = {
    WALL_STRAIGHT = 0,
    WALL_DIAGONALCORNER = 1,
    WALL_L = 2,
    WALL_SQUARECORNER = 3,
    WALLDECOR_STRAIGHT_NOOFFSET = 4,
    WALLDECOR_STRAIGHT_OFFSET = 5,
    WALLDECOR_DIAGONAL_OFFSET = 6,
    WALLDECOR_DIAGONAL_NOOFFSET = 7,
    WALLDECOR_DIAGONAL_BOTH = 8,
    WALL_DIAGONAL = 9,
    CENTREPIECE_STRAIGHT = 10,
    CENTREPIECE_DIAGONAL = 11,
    ROOF_STRAIGHT = 12,
    ROOF_DIAGONAL_WITH_ROOFEDGE = 13,
    ROOF_DIAGONAL = 14,
    ROOF_L_CONCAVE = 15,
    ROOF_L_CONVEX = 16,
    ROOF_FLAT = 17,
    ROOFEDGE_STRAIGHT = 18,
    ROOFEDGE_DIAGONALCORNER = 19,
    ROOFEDGE_L = 20,
    ROOFEDGE_SQUARECORNER = 21,
    GROUNDDECOR = 22,
    WALL_L_ALT = 23,
    WALLDECOR_DIAGONAL_BOTH_ALT = 24,
}

---@class LocType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "WINCHLADDER1" .
---@field typeName String The type of this config. Will always be "Loc" .
---@field name String The display name of this config type.
---@field fastPicking Bool Whether a LocEntity using this config uses a lower accuracy, but faster, picking test on triangles.
---@field width Int The width of this config on the X axis, in grid units.
---@field length Int The length of this config on the Z axis, in grid units.
---@field modelOffset Vector3 A positional transform applied to the models of this config. This is applied before modelScale .
---@field modelScale Vector3 A scaling transform applied to the models of this config. This is applied after modelOffset and before modelPostOffset .
---@field modelPostOffset Vector3 A final positional transform applied to the models of this config. This is applied after modelScale .
---@field groundDecorOffset Int Returns the height offset applied to World.GetGroundHeight() by an entity using this config, if also using LocShapeType.GROUNDDECOR .
---@field hasCustomBounding Bool Whether a LocEntity using this config uses an overriding AABB bounds for picking tests. Often used by Locs which have geometry or animations that make them tricky to click.
---@field customBounding any AABB ? The AABB which describes this configs custom bounds. Returns nil if none is set.
---@field IsActive Bool Indicates whether a LocEntity using this config can be modified by the server.
---@field isExamineOnly Bool Shorthand check for whether this config type contains only an Examine op.
---@field opNames String[] A list of names shown for the available ops in this config. Use pairs() to iterate this list, which will provide both the op index and name as opIndex,opName .
---@field blockWalk Bool Whether a LocEntity using this config will block route pathing through the tile(s) it is placed on.
---@field quests QuestType[] A list of all quests related to this config.
---@field mapElement MapElementType The map element to display for this config. Returns nil if none is set.
---@field useRandomAnimationFrame Bool Whether the animation played by LocEntities using this config should start on a random frame.
---@field animations SeqType[] A list of animations this config can play.
---@field defaultAnimation SeqType The default animation played by this config. Returns nil if none is set.
---@field isMultiLoc Bool Whether this config contains a sub-list of LocTypes and a multiVar variable to use in selecting one. An LocEntity which uses a multiLoc config will expose it through LocEntity.parentConfig , while the selected LocType sub-list config is exposed through LocEntity.config .
---@field multiVar VarType The variable which controls the currently displayed LocType .
---@field locShapeTypes LocShapeType[] Returns a list of all LocShapeTypes supported by this config. Use these along with Loc:GetModelIDs() to get the model IDs used by this config.
---@field params ParamType[] Returns a list of all the ParamTypes stored in this config.
Loc = {}

---Returns the custom CursorType , if any, used for the given op index.
---@param opIndex Int The op index. Valid values are 1 -> 6
---@return Cursor? The cursor type to display. Returns nil if no op exists for this index, or no custom CursorType is set on an existing op.
function Loc:GetOpCursor(opIndex) end

---Returns the model IDs associated with the given LocShapeType .
---@param locShapeType LocShapeType The LocShapeType to gather model IDs with.
---@return Int[] The list of model IDs. Returns an empty list if the LocShapeType is not supported by this config.
function Loc:GetModelIDs(locShapeType) end

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return any The corresponding output value. Returns param.defaultValue if the param is not found in the data structure.
function Loc:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool Whether a corresponding value exists in this config for ParamType .
function Loc:HasParam(param) end
