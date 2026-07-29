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
---@param settings Table A table of key-value pairs which describe the settings for the draw operation.
function ShapeList.Draw(settings) end

---Draws a segmented line in the game world using the provided settings table of values.
---@param settings Table A table of key-value pairs which describe the settings for the draw operation.
function ShapeList.DrawLine(settings) end

---@param coord any
function addPlayerCoord(coord) end

---Creates a new ShapeInstance with the given name. Returns nil if an instance already exists with that name.
---@param name String The name of the instance.
---@return ShapeInstance? The created ShapeInstance . Returns nil if the instance could not be created.
function ShapeList.CreateInstance(name) end

---Returns an existing ShapeInstance with the given name. Returns nil if no instance exists with that name.
---@param name String The name of the instance.
---@return ShapeInstance? The ShapeInstance which was found. Returns nil if no instance was found.
function ShapeList.GetInstance(name) end

---Returns a list of all existing ShapeInstances created by the plugin.
---@return ShapeInstance[] All existing ShapeInstances .
function ShapeList.GetAllInstances() end

---Attempts to destroy the given ShapeInstance and returns whether it was successful.
---@param instance ShapeInstance The ShapeInstance object.
---@return Bool Whether the ShapeInstance was successfully destroyed.
function ShapeList.DestroyInstance(instance) end

---Attempts to destroy the ShapeInstance with the given name and returns whether it was successful.
---@param name String The name of the ShapeInstance object.
---@return Bool Whether the ShapeInstance was successfully destroyed.
function ShapeList.DestroyInstance(name) end

---Creates a new ShapeEntity with the given name. Returns nil if an entity already exists with that name.
---@param name String The name of the entity.
---@return ShapeEntity? The created ShapeEntity . Returns nil if the entity could not be created.
function ShapeList.CreateEntity(name) end

---Returns an existing ShapeEntity with the given name. Returns nil if no entity exists with that name.
---@param name String The name of the entity.
---@return ShapeInstance? The ShapeEntity which was found. Returns nil if no entity was found.
function ShapeList.GetEntity(name) end

---Returns a list of all existing ShapeEntities created by the plugin.
---@return ShapeEntity[] All existing ShapeEntities .
function ShapeList.GetAllEntities() end

---Attempts to destroy the given ShapeEntity and returns whether it was successful.
---@param entity ShapeEntity The ShapeEntity object.
---@return Bool Whether the ShapeEntity was successfully destroyed.
function ShapeList.DestroyEntity(entity) end

---Attempts to destroy the ShapeEntity with the given name and returns whether it was successful.
---@param name String The name of the ShapeEntity object.
---@return Bool Whether the ShapeEntity was successfully destroyed.
function ShapeList.DestroyEntity(name) end

---The ShapeData table provides a way to store data like positions, colours and triangle and line indices in one object.
---@class ShapeData
---@field positions any Array of Vector3 A list of 3D positions.
---@field rgba any Array of Integer A list of 32-bit colours. The number of colours in this array must match the number of positions, or be empty. If empty, the default colour value is 0xFFFFFFFF .
---@field tris any Array of Integer A list of position index triplets which represent a single triangle. Indices are 0-indexed.
---@field lines any Array of Integer A list of position index pairs which represent a single line. Indices are 0-indexed.
ShapeData = {}

---Creates and returns an empty ShapeData object.
---@return ShapeData The newly created data object.
function ShapeData.new() end

---Returns the names of all registered ShapeData that are available to the current plugin.
---@return String[] An array of registered ShapeData names.
function ShapeData.GetAllRegistered() end

---Returns whether a ShapeData is registered with the given name.
---@param name String The string to match against each registered ShapeData name.
---@return Bool Whether the name has been registered.
function ShapeData.IsRegistered(name) end

---Registers ShapeData with the given name, and returning whether the registration was successful.
---@param name String The string to register as the ShapeData name.
---@param shapeData ShapeData The data to register.
---@return Bool Whether the ShapeData was successfully registered.
function ShapeData.Register(name, shapeData) end

---Attempts to unregister a ShapeData which is registered with the given name.
---@param name String The string to match against each registered ShapeData name.
---@return Bool Whether the ShapeData was successfully unregistered.
function ShapeData.Unregister(name) end

---A ShapeInstance is a dynamic object which contains some ShapeData and automatically handles drawing itself in the game world.
---@class ShapeInstance
---@field isValid Bool -
---@field name String -
---@field hasData Bool -
---@field translation Vector3 0,0,0
---@field rotation Vector3 0,0,0
---@field scale Vector3 1,1,1
---@field visible Bool true
---@field ignoreDepth Bool false
---@field colour Int 0xFFFFFFFF
---@field lineWidth Float 2.0
ShapeInstance = {}

---Assigns a copy of the given shape data to the instance and returns whether the data was valid and successfully set.
---@param shapeData ShapeData The shape data to copy to the instance.
---@return Bool Whether the shape data was successfully set on the instance.
function ShapeInstance:SetShapeData(shapeData) end

---Assigns the name of a registered ShapeData to the instance and returns whether the registered name exists and was successfully set.
---@param shapeName String The name of a registered shape data ShapeData .
---@return Bool Whether the shape name was successfully set on the instance.
function ShapeInstance:SetShapeDataName(shapeName) end

---Attempts to destroy the instance. Returns false if the entity does not exist, otherwise true .
---@return Bool Whether the instance was successfully destroyed.
function ShapeInstance:Destroy() end

---A ShapeEntity is an object which contains some ShapeData , is often placed at a fixed coordinate, and automatically handles drawing itself in the game world.
---@class ShapeEntity
---@field isValid Bool -
---@field name String -
---@field hasData Bool -
---@field drawDistances Integer,Integer 10240 , 12288
---@field coordGrid CoordGrid -
---@field coordFine CoordFine -
---@field visible Bool true
---@field ignoreDepth Bool false
---@field colour Int 0xFFFFFFFF
---@field lineWidth Float 2.0
---@field alignType ShapeEntityAlignType NONE
---@field heightOffset Float 0.0
---@field rotation Float 0.0
---@field rotationSpeed Float 0.0
ShapeEntity = {}

---Assigns a copy of the given shape data to the entity and returns whether the data was valid and successfully set.
---@param shapeData ShapeData The shape data to copy to the entity.
---@return Bool Whether the shape data was successfully set on the entity.
function ShapeEntity:SetShapeData(shapeData) end

---Assigns the name of a registered ShapeData to the entity and returns whether the registered name exists and was successfully set.
---@param shapeName String The name of a registered shape data ShapeData .
---@return Bool Whether the shape name was successfully set on the entity.
function ShapeEntity:SetShapeDataName(shapeName) end

---Sets the draw distance, in fine units, for the ShapeEntity .
---@param distance Float The distance, in fine units, from the Player Character at which the entity will stop drawing.
function ShapeEntity:SetDrawDistance(distance) end

---Sets the draw distance range, in fine units, for the ShapeEntity , allowing the entity to fade out gradually over distance.
---@param nearDistance Float The near draw distance, in fine units.
---@param farDistance Float The far draw distance, in fine units.
function ShapeEntity:SetDrawDistance(nearDistance, farDistance) end

---Attempts to destroy the entity. Returns false if the entity does not exist, otherwise true .
---@return Bool Whether the entity was successfully destroyed.
function ShapeEntity:Destroy() end
