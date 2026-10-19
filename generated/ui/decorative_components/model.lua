---@meta

---Identifies how a generic model ID should be interpreted by a model component.
---@enum ui.ModelType
ui.ModelType = {
    NONE = "NONE", -- No/invalid model.
    MODEL = "MODEL", -- Plain model with no specialized game behaviour or usage.
    NPC_HEAD = "NPC_HEAD", -- Model used in the chat interface for a NPC.
    PLAYER_HEAD = "PLAYER_HEAD", -- Model used in the chat interface for a player. 1
    OBJECT = "OBJECT", -- Model used for an object.
    PLAYER_MODEL = "PLAYER_MODEL", -- Model used for a player. 1
    NPC_MODEL = "NPC_MODEL", -- Model used for a NPC.
    PLAYER_HEAD_NOWORN = "PLAYER_HEAD_NOWORN", -- Model used in the chat interface for a player, without any items equipped. 1
    INV_MANWEAR_MODEL = "INV_MANWEAR_MODEL", -- Gendered variant of a model for a wearable inventory item. 2
    INV_WOMANWEAR_MODEL = "INV_WOMANWEAR_MODEL", -- Gendered variant of a model for a wearable inventory item. 2
}

---@class ui
ui = {}

---@class ui.Model : ui.Component
---@field npcCustomisation ui.NPCCustomisation Retrieves a copy or sets the current customisation settings used when drawing NPCs.
---@field environment ui.ModelEnvironment Retrieves a copy or sets the current environment settings used for drawing.
---@field modelType ui.ModelType (Read-only) Type of the model currently being drawn.
---@field modelID1 Int (Read-only) ID for the model currently being drawn.
---@field modelID2 Int (Read-only) ID for the secondary model currently being drawn. Only used with the playerHeadNoworn type.
---@field animID Int The animation currently playing on the model being drawn.
---@field rotation Vector3 Yaw, pitch, and roll rotation for the current model, specified in radians.
---@field viewDistance Int Controls the distance from the camera to the origin.
---@field worldOffset Vector3 Offset applied to the model prior to rendering, in world units.
---@field screenOffset Vector3 Screen offset applied to the model prior to rendering, in interface units.
---@field modelWidth Int Width for the model being drawn, used for scaling.
---@field modelHeight Int Height for the model being drawn, used for scaling.
---@field orthographic Bool Whether to use an orthographic projection when drawing this model.
---@field disableZWrite Bool Whether writing into the depth buffer should be disabled when drawing this model.
---@field associatedObjectID Int Numeric value identifying the object to draw if any. Used as an alternative to the model type and model ID system.
---@field associatedObjectQuantity Uint64 Determines which model variant to draw when associatedObjectID is set to a stackable object.
---@field usePlayerModelRecolour Bool Whether to use any recolours provided by the player model when drawing one of the player model types.
ui.Model = {}

---@alias Model ui.Model

---Creates a new model on the specified parent.
---@param parent ui.ComponentCollection Parent component to create this model in.
---@param categoryID Int? Category ID used to identify this component. Defaults to the parent's category ID if not specified.
---@param dynamicID Int? Dynamic ID used to identify this component. Defaults to auto-incrementing from the parent's dynamic ID if not specified.
---@return Model # The newly created model. The caller must set its layout and visual information afterwards.
function ui.Model.new(parent, categoryID, dynamicID) end

---Sets the model to be drawn as part of this component.
---@param type ui.ModelType The type of model that is to be drawn.
---@param modelID Int Numeric value used to identify the source for the main model to be drawn.
---@param secondaryModelID Int? Numeric value used to identify the source for the secondary model to be drawn. Only used with the playerHeadNoworn type.
function ui.Model:SetModel(type, modelID, secondaryModelID) end

---Configures the lighting parameters to use when drawing this model.
---@param ambient Float Ambient lighting intensity. Note higher ambient values can result in "flat"-looking visuals.
---@param contrast Float Contrast intensity.
---@param antiContrast Float Contrast intensity for backface lighting. Currently unused, kept for legacy reasons.
---@param sunRGB Vector3 Red, green, and blue colour for sunlight.
---@param sunDirection Vector3 The direction sunlight is coming from.
---@param envMapID Int ID for the texture to use as an environment map. Using -1 indicates no environment map is used.
function ui.Model:SetLighting(ambient, contrast, antiContrast, sunRGB, sunDirection, envMapID) end

---Sets the target model transform and starts a transition to it over the specified time.
---@param position Vector3 Desired position for the model.
---@param rotationYawPitchRoll Vector3 Desired rotation for the model, specified in radians.
---@param scale Vector3 Desired scale for the model.
---@param durationMs Uint Defines how long the transition to this transform will take in milliseconds.
function ui.Model:SetTransform(position, rotationYawPitchRoll, scale, durationMs) end

---Sets a recolour slot for this model, replacing all instances of the specified vertex colour with another.
---@param slot Int Recolour slot to set. A maximum of 16 recolour slots are available.
---@param sourceColourHSL Uint16 HSL colour to replace. 3
---@param replacementColourHSL Uint16 HSL colour to use as a replacement. 3
function ui.Model:SetRecolour(slot, sourceColourHSL, replacementColourHSL) end

---Sets a rematerial slot for this model, replacing all uses of the specified material with another.
---@param slot Int Rematerial slot to set. A maximum of 16 rematerial slots are available.
---@param sourceMaterialID Int ID for the material to replace.
---@param replacementMaterialID Int ID for the material to use as a replacement.
function ui.Model:SetRematerial(slot, sourceMaterialID, replacementMaterialID) end

---Sets the model to be drawn to match the one used by the specified object, optionally taking into account the number of instances of this object as if it were an stackable item.
---@param objectID Int Numeric value identifying the object to draw.
---@param quantity Uint64? Determines which model variant to draw when used with stackable objects.
function ui.Model:SetAssociatedObject(objectID, quantity) end

---Resets the current animation, forcing it to start again at the specified logic tick.
---@param logicTick Uint
function ui.Model:RestartAnimation(logicTick) end

---Resets all environment settings to their defaults, see here for the default values.
function ui.Model:ResetEnvironment() end

---Contains lighting and environment configuration data used for model rendering.
---@class ui.ModelEnvironment
---@field ambient Float Ambient lighting intensity. Note higher ambient values can result in "flat"-looking visuals. Defaults to 2.0 .
---@field contrast Float Contrast intensity. Defaults to 2.5 .
---@field anticontrast Float Contrast intensity for backface lighting. Currently unused, kept for legacy reasons. Defaults to 0 .
---@field sunRGB Vector3 Defaults to (1.0, 1.0, 1.0) .
---@field sunDirection Vector3 Defaults to (-0.7, 0.14, -0.7) .
---@field shadowBias Float Biasing factor used when determine what shadow map cascade to use when drawing. This should generally be left to the default values as it may change in the future. Defaults to -0.0135 on desktop and -0.0225 on mobile devices.
---@field envMapID Int Identifies the texture to use as an environment map. Defaults to -1 meaning no environment mapping.
---@field exposureKey Float Controls the target exposure, used in tonemapping. Defaults to 1.0 .
---@field minAutoExposure Float Controls the minimum calculated exposure for a scene, used in tonemapping. Defaults to 0.0 .
---@field maxAutoExposure Float Controls the maximum calculated exposure for a scene, used in tonemapping. Defaults to 1.0 .
---@field bloomScale Float Controls the intensity of bloom visuals. Defaults to 1.0 .
ui.ModelEnvironment = {}

---@return ui.ModelEnvironment
function ui.ModelEnvironment.new() end

---@alias ModelEnvironment ui.ModelEnvironment

---Contains customisation data used when drawing NPC models.
---@class ui.NPCCustomisation
---@field isPlayerClone Bool (Read-only) Indicates whether this NPC is cloning player visuals.
---@field modelList Int[] (Read-only) Collection of model IDs contained in this customisation.
---@field modelScaleList Float[] (Read-only) Collection of uniform scales applied to the various models contained in this customisation.
---@field modelRotationList Vector3[] (Read-only) Collection of yaw, pitch, and roll rotations, specified in radians, applied to the various models contained in this customisation.
---@field modelTranslationList Vector3[] (Read-only) Collection of translations applied to the various models contained in this customisation.
---@field modelRecolourList table<Int, Uint16[]> (Read-only) Map between model slots and a collection containing recolour data. Recolour data can be accessed as local sourceHSL = modelRecolourList[modelSlot][recolourSlot * 2] and local targetHSL = modelRecolourList[modelSlot][recolourSlot * 2 + 1] .
---@field modelRematerialList table<Int, Int[]> (Read-only) Map between model slots and a collection containing rematerials data. Rematerial data can be accessed as local source = modelRematerialList[modelSlot][rematerialSlot * 2] and local target = modelRematerialList[modelSlot][rematerialSlot * 2 + 1] .
---@field recolourDest Uint16[] (Read-only) Collection of HSL colours used as the target colours for multi-model recolour transforms.
---@field rematerialDest Int[] (Read-only) Collection of material IDs used as the target materials for multi-model rematerial transforms.
---@field playerIdkColour Uint8[] (Read-only) Collection of colours for the player's equipment.
ui.NPCCustomisation = {}

---@alias NPCCustomisation ui.NPCCustomisation

---Creates a customisation object for an NPC's body or head.
---@overload fun(npcID: Int, customisingBody: Bool): ui.NPCCustomisation
---@param customisingBody Bool Controls whether this customisation is applied to the NPC's body or its head.
---@return ui.NPCCustomisation
function ui.NPCCustomisation.new(customisingBody) end

---@param modelSlot Uint Model slot to set. For body customisations, up to 12 model slots may be used, while for head customisations the limit is only 5 .
---@param modelID Int ID for the model to use for this slot.
---@param scale Float? Desired scale for the model. Only applies for body customisations. Defaults to 1.0 .
---@param translation Vector3? Desired position for the model. Only applies for body customisations. Defaults to (0.0, 0.0, 0.0) .
---@param rotationYawPitchRoll Vector3? Desired rotation for the model, specified in radians. Only applies for body customisations. Defaults to (0.0, 0.0, 0.0) .
function ui.NPCCustomisation:SetModelSlot(modelSlot, modelID, scale, translation, rotationYawPitchRoll) end

---@param modelSlot Uint Model slot to set. For body customisations, up to 12 model slots may be used, while for head customisations the limit is only 5 .
---@param rematerialSlot Int Rematerial slot to set. A maximum of 16 rematerial slots are available.
---@param sourceMaterialID Int ID for the material to replace.
---@param replacementMaterialID Int ID for the material to use as a replacement.
function ui.NPCCustomisation:SetModelSlotRematerial(modelSlot, rematerialSlot, sourceMaterialID, replacementMaterialID) end

---@param modelSlot Uint Model slot to set. For body customisations, up to 12 model slots may be used, while for head customisations the limit is only 5 .
---@param recolourSlot Int
---@param sourceColourHSL Uint16 HSL colour to replace. 3
---@param replacementColourHSL Uint16 HSL colour to use as a replacement. 3
function ui.NPCCustomisation:SetModelSlotRecolour(modelSlot, recolourSlot, sourceColourHSL, replacementColourHSL) end
