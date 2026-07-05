---@meta

---@class NPCType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "HANS" .
---@field typeName String The type of this config. Will always be "NPC" .
---@field name String The display name of this config type.
---@field attackOpPriority Bool Whether the Attack OP of an NPCEntity using this config is given priority.Used in combination with Player.GetAttackOpPriority .
---@field visibleCombatLevel Int The combat level presented for an entity using this config.
---@field castsShadows Bool Whether an NPCEntity using this config should cast a shadow.
---@field overlayHeight Int A custom override for how far above an NPCEntity to draw its overlays.Value is -1 if unused.
---@field walkSmoothing Bool Whether an NPCEntity using this config should follow walk routes smoothly.A smooth route uses bezier curves and acceleration.A non-smooth route travels linearly through tile centres.
---@field isExamineOnly Bool Shorthand check for whether this config type contains only an Examine OP.
---@field attackOpIndex Int The OP index for this configs Attack OP.
---@field examineOpIndex Int The OP index for this configs Examine OP.
---@field firstUniqueOpIndex Int The OP index where the first non-standard OP begins.
---@field fastPicking Bool Whether an NPCEntity using this config uses a lower accuracy, but faster, picking test on triangles.
---@field roughBounding Int Whether an NPCEntity using this config should skip triangle tests and stop at an earlier rectangular bounds test. -1 = Only if gridSize == 1 0 = Never 1 = Always
---@field resize Vector3 A scaling transform applied to the body model(s) of an NPCEntity using this config.
---@field gridSize Int The reported tile size of an NPCEntity using this config.Used in various entity logic and priority checks.
---@field turnSpeed Int The turning speed of an NPCEntity using this config.Affects facing and movement turn speeds.
---@field isActive Bool Whether an NPCEntity using this config is considered active.An inactive entity is not shown on the minimap and will not show in the minimenu.
---@field isFamiliar Bool Whether an NPCEntity using this config is considered a familiar.Familiar-type NPCs have a lower draw order priority.
---@field isAlwaysOnTop Bool Greatly advances the draw order priority of an NPCEntity using this config.Not guaranteed to be on top.
---@field isAlwaysOnBottom Bool Reduces the draw order priority of an NPCEntity using this config.Not guaranteed to be at bottom.
---@field priorityOffset Int Adjusts the draw order priority of an NPCEntity using this config.Can be positive or negative.
---@field isOnMiniMap Bool Whether an NPCEntity using this config is shown on the minimap.
---@field mapElement Int TODO: Will become a config type
---@field isMultiNPC Bool Whether this config contains a sub-list of NPCTypes and a multiVarp(Bit) variable to use in selecting one.An NPCEntity which uses a multiNPC config will expose it through NPCEntity.parentConfig , while the selected NPCType sub-list config is exposed through NPCEntity.config .
---@field multiVarp Int TODO: Will become a config type
---@field multiVarpBit Int TODO: Will become a config type
---@field hasCustomBounding Bool Whether an NPCEntity using this config uses an overriding AABB bounds for picking tests.Often used by NPCs which have geometry or animations that make them difficult to click.
---@field hasBackgroundSound Bool Whether an NPCEntity using this config should play a sound depending on its animation state.Indicates that at least one of the ready/crawl/walk/run sounds is set.
---@field backgroundSoundReady Int TODO: Will become a config type
---@field backgroundSoundCrawl Int TODO: Will become a config type
---@field backgroundSoundWalk Int TODO: Will become a config type
---@field backgroundSoundRun Int TODO: Will become a config type
---@field backgroundSoundRange Int The maximum tile range, in Grid units , of any background sounds played by an NPCEntity using this config.Distances above this range set volume to 0%.
---@field backgroundSoundDropoffRange Int The tile distance, in Grid units , at which background sounds in this config begin to drop off in volume.Distances below this range set volume to 100%.
---@field backgroundSoundVolume Int The base volume of any background sounds played by an NPCEntity using this config.
---@field params any Array of ParamType Returns a list of all the ParamTypes stored in this config.
NPC = {}

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return ? The corresponding output value.Returns param.defaultValue if the param is not found in the data structure.
function NPC:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool Whether a corresponding value exists in this config for ParamType .
function NPC:HasParam(param) end
