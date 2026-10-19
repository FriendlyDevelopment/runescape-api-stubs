---@meta

---Used by the ShapeEntity property alignType .
---@enum ShapeEntityAlignType
ShapeEntityAlignType = {
    NONE = "NONE", -- 0
    OBJECT = "OBJECT", -- 1
    MODEL = "MODEL", -- 2
}

---@class ShapeList
ShapeList = {}

---Draws a shape in the game world using the provided settings table of values.
---@param settings ShapeListDrawSettings A table of key-value pairs which describe the settings for the draw operation.
function ShapeList.Draw(settings) end

---Draws a segmented line in the game world using the provided settings table of values.
---@param settings ShapeListDrawLineSettings A table of key-value pairs which describe the settings for the draw operation.
function ShapeList.DrawLine(settings) end

---Creates a new ShapeInstance with the given name. Returns nil if an instance already exists with that name.
---@param name String The name of the instance.
---@return ShapeInstance? # The created ShapeInstance . Returns nil if the instance could not be created.
function ShapeList.CreateInstance(name) end

---Returns an existing ShapeInstance with the given name. Returns nil if no instance exists with that name.
---@param name String The name of the instance.
---@return ShapeInstance? # The ShapeInstance which was found. Returns nil if no instance was found.
function ShapeList.GetInstance(name) end

---Returns a list of all existing ShapeInstances created by the plugin.
---@return ShapeInstance[] # All existing ShapeInstances .
function ShapeList.GetAllInstances() end

---Attempts to destroy the given ShapeInstance and returns whether it was successful.
---@param instance ShapeInstance The ShapeInstance object.
---@return Bool # Whether the ShapeInstance was successfully destroyed.
function ShapeList.DestroyInstance(instance) end

---Attempts to destroy the ShapeInstance with the given name and returns whether it was successful.
---@param name String The name of the ShapeInstance object.
---@return Bool # Whether the ShapeInstance was successfully destroyed.
function ShapeList.DestroyInstance(name) end

---Creates a new ShapeEntity with the given name. Returns nil if an entity already exists with that name.
---@param name String The name of the entity.
---@return ShapeEntity? # The created ShapeEntity . Returns nil if the entity could not be created.
function ShapeList.CreateEntity(name) end

---Returns an existing ShapeEntity with the given name. Returns nil if no entity exists with that name.
---@param name String The name of the entity.
---@return ShapeEntity? # The ShapeEntity which was found. Returns nil if no entity was found.
function ShapeList.GetEntity(name) end

---Returns a list of all existing ShapeEntities created by the plugin.
---@return ShapeEntity[] # All existing ShapeEntities .
function ShapeList.GetAllEntities() end

---Attempts to destroy the given ShapeEntity and returns whether it was successful.
---@param entity ShapeEntity The ShapeEntity object.
---@return Bool # Whether the ShapeEntity was successfully destroyed.
function ShapeList.DestroyEntity(entity) end

---Attempts to destroy the ShapeEntity with the given name and returns whether it was successful.
---@param name String The name of the ShapeEntity object.
---@return Bool # Whether the ShapeEntity was successfully destroyed.
function ShapeList.DestroyEntity(name) end

---The ShapeData table provides a way to store data like positions, colours and triangle and line indices in one object.
---@class ShapeData
---@field positions Vector3[] A list of 3D positions.
---@field rgba Int[] A list of 32-bit colours. The number of colours in this array must match the number of positions, or be empty. If empty, the default colour value is 0xFFFFFFFF .
---@field tris Int[] A list of position index triplets which represent a single triangle. Indices are 0-indexed.
---@field lines Int[] A list of position index pairs which represent a single line. Indices are 0-indexed.
ShapeData = {}

---Creates and returns an empty ShapeData object.
---@return ShapeData # The newly created data object.
function ShapeData.new() end

---Returns the names of all registered ShapeData that are available to the current plugin.
---@return String[] # An array of registered ShapeData names.
function ShapeData.GetAllRegistered() end

---Returns whether a ShapeData is registered with the given name.
---@param name String The string to match against each registered ShapeData name.
---@return Bool # Whether the name has been registered.
function ShapeData.IsRegistered(name) end

---Registers ShapeData with the given name, and returning whether the registration was successful.
---@param name String The string to register as the ShapeData name.
---@param shapeData ShapeData The data to register.
---@return Bool # Whether the ShapeData was successfully registered.
function ShapeData.Register(name, shapeData) end

---Attempts to unregister a ShapeData which is registered with the given name.
---@param name String The string to match against each registered ShapeData name.
---@return Bool # Whether the ShapeData was successfully unregistered.
function ShapeData.Unregister(name) end

---@class ShapeListDrawSettings
---@field shapeDataName String The name of a registered ShapeData to draw.
---@field shapeData ShapeData The ShapeData to draw directly.
---@field shapePositions Vector3[] The raw shape data positions to draw.
---@field shapeRGBA Int[] The raw shape data colours to draw.
---@field shapeTris Int[] The raw shape data triangle indices to draw.
---@field shapeLines Int[] The raw shape data line indices to draw.
---@field translation Vector3 A positional offset transform applied to the shape when it is drawn. Allows shape data constructed in local-space to be drawn in world-space.
---@field rotation Vector3 A rotational transform applied to the shape when it is drawn. X = Yaw, Y = Pitch, Z = Roll
---@field scale Vector3 A scaling transform applied to the shape when it is drawn.
---@field ignoreDepth Bool Controls how the shape handles depth testing when drawing: true - Always draws on top of world geometry false - Draws behind occluding world geometry.
---@field colour Int A 32-bit colour which is multiplied against the RGBA data of the shape being drawn.
---@field lineWidth Float The drawn thickness of any lines defined by the shape data. Maximum value is 10.0 .
---@field asBillboard Bool Whether the shape should always rotate to face the camera. This rotation is applied around the centre of final AABB of the drawn shape.

---@class ShapeListDrawLineSettings
---@field positions Vector3[] The list of positions to draw lines between.
---@field translation Vector3 A positional offset transform applied to the lines when they are drawn. Allows positions constructed in local-space to be drawn in world-space.
---@field rotation Vector3 A rotational transform applied to the lines when they are drawn. X = Yaw, Y = Pitch, Z = Roll
---@field scale Vector3 A scaling transform applied to the lines when they are drawn.
---@field ignoreDepth Bool Controls how the lines handle depth testing when drawing: true - Always draws on top of world geometry false - Draws behind occluding world geometry.
---@field colour Int The 32-bit colour to use as the line colour.
---@field lineWidth Float The drawn thickness of the lines. Maximum value is 10.0 .

---A ShapeInstance is a dynamic object which contains some ShapeData and automatically handles drawing itself in the game world.
---@class ShapeInstance
---@field isValid Bool Whether this instance still exists. Dispose of this usertype object when invalid.
---@field name String The name the instance was created with.
---@field hasData Bool Whether this instance has valid ShapeData or a registered shape name assigned to it.
---@field translation Vector3 A positional offset transform applied to the shape when it is drawn. Allows shape data constructed in local-space to be drawn in world-space.
---@field rotation Vector3 A rotational transform applied to the shape when it is drawn. X = Yaw, Y = Pitch, Z = Roll
---@field scale Vector3 A scaling transform applied to the shape when it is drawn.
---@field visible Bool Whether the instance should be drawn.
---@field ignoreDepth Bool Controls how the instance handles depth testing when drawing: true - Always draws on top of world geometry false - Draws behind occluding world geometry.
---@field colour Int A 32-bit colour which is multiplied against the RGBA data of the ShapeData being drawn.
---@field lineWidth Float The drawn thickness of any lines defined by the instance's ShapeData . Maximum value is 10.0 .
---@field asBillboard Bool Whether the shape should always rotate to face the camera. This rotation is applied around the centre of final AABB of the drawn shape.
local ShapeInstance = {}

---Assigns a copy of the given shape data to the instance and returns whether the data was valid and successfully set.
---@param shapeData ShapeData The shape data to copy to the instance.
---@return Bool # Whether the shape data was successfully set on the instance.
function ShapeInstance:SetShapeData(shapeData) end

---Assigns the name of a registered ShapeData to the instance and returns whether the registered name exists and was successfully set.
---@param shapeName String The name of a registered shape data ShapeData .
---@return Bool # Whether the shape name was successfully set on the instance.
function ShapeInstance:SetShapeDataName(shapeName) end

---Attempts to destroy the instance. Returns false if the entity does not exist, otherwise true .
---@return Bool # Whether the instance was successfully destroyed.
function ShapeInstance:Destroy() end

---A ShapeEntity is an object which contains some ShapeData , is often placed at a fixed coordinate, and automatically handles drawing itself in the game world.
---@class ShapeEntity
---@field isValid Bool Whether this entity still exists. Dispose of this usertype object when invalid.
---@field name String The name the entity was created with.
---@field hasData Bool Whether this entity has valid ShapeData or a registered shape name assigned to it.
---@field drawDistances {[1]: Int, [2]: Int} Returns the near and far draw distances for the entity as a value pair. Use SetDrawDistance() to set these value(s).
---@field coordGrid CoordGrid The coordinate at which the entity is placed. The entity will be placed at the centre of the coordinate, and automatically sets its height to align with the ground. Replaces any value set for coordFine .
---@field coordFine CoordFine The coordinate at which the entity is placed. Automatically sets its height to align with the ground. Replaces any value set for coordGrid .
---@field visible Bool Whether the entity should be drawn.
---@field ignoreDepth Bool Controls how the entity handles depth testing when drawing: true - Always draws on top of world geometry false - Draws behind occluding world geometry.
---@field colour Int A 32-bit colour which is multiplied against the RGBA data of the ShapeData being drawn.
---@field lineWidth Float The drawn thickness of any lines defined by the entity's ShapeData . Maximum value is 10.0 .
---@field alignType ShapeEntityAlignType How the entity's shape data should align with the ground. See ShapeEntityAlignType .
---@field heightOffset Float How high above the ground level the entity should be drawn.
---@field rotation Float The starting rotation of the entity. Rotation occurs around the vertical Y axis. Units are in degrees.
---@field rotationSpeed Float How far the entity rotates in a clockwise direction in one second. Rotation occurs around the vertical Y axis. Units are in degrees.
---@field asBillboard Bool Whether the shape should always rotate to face the camera. This rotation is applied around the centre of final AABB of the drawn shape. This setting often conflicts with alignType - it is recommended to use ShapeEntityAlignType.NONE when drawing a shape entity as a billboard.
local ShapeEntity = {}

---Assigns a copy of the given shape data to the entity and returns whether the data was valid and successfully set.
---@param shapeData ShapeData The shape data to copy to the entity.
---@return Bool # Whether the shape data was successfully set on the entity.
function ShapeEntity:SetShapeData(shapeData) end

---Assigns the name of a registered ShapeData to the entity and returns whether the registered name exists and was successfully set.
---@param shapeName String The name of a registered shape data ShapeData .
---@return Bool # Whether the shape name was successfully set on the entity.
function ShapeEntity:SetShapeDataName(shapeName) end

---Sets the draw distance, in fine units, for the ShapeEntity .
---@param distance Float The distance, in fine units, from the Player Character at which the entity will stop drawing.
function ShapeEntity:SetDrawDistance(distance) end

---Sets the draw distance range, in fine units, for the ShapeEntity , allowing the entity to fade out gradually over distance.
---@param nearDistance Float The near draw distance, in fine units.
---@param farDistance Float The far draw distance, in fine units.
function ShapeEntity:SetDrawDistance(nearDistance, farDistance) end

---Attempts to destroy the entity. Returns false if the entity does not exist, otherwise true .
---@return Bool # Whether the entity was successfully destroyed.
function ShapeEntity:Destroy() end
