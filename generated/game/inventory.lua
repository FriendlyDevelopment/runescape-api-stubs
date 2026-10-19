---@meta

---@class Inventory
Inventory = {}

---Returns the Inv associated with the supplied InvType .
---@param config InvType A valid InvType.
---@return Inv[] # The inventory container for a list of objects.
function Inventory.Find(config) end

---Returns the Inv associated with the matching ID.
---@param id Int A valid ID value.
---@return Inv[] # The inventory container for a list of objects.
function Inventory.Find(id) end

---An inventory provides access to a list of InvSlot entries, each of which contains information about the ObjType contained within it. Inventories are of a fixed size, and their slots may or may not be populated by an InvSlot .
---@class Inv
---@field id Int Unique ID associated with the inventory.
---@field config InvType InvType config used to construct the inventory.
---@field valid Bool Is the inventory object valid.
---@field slotCount Int Total number of slots.
---@field usedSlotCount Int Number of non-empty slots.
---@field freeSlotCount Int Number of empty slots.
local Inv = {}

---Returns the InvSlot at the specified index.
---@param index Int A valid slot index. Index values are 1-indexed.
---@return InvSlot # An object representing the inventory slot specified. Returns nil on failure.
function Inv:GetSlot(index) end

---Returns the current data associated for all slots in the inventory.
---@return InvSlot[] # An table of objects representing the inventory slot specified. Returns nil on failure.
function Inv:GetSlots() end

---Returns the number of objects matching a valid ObjType specified in the associated inventory.
---@param objType ObjType A valid ObjType .
---@return Int # The number of objects matching the specified ObjType .
function Inv:GetTotal(objType) end

---Returns the number of objects matching a valid ObjType ID specified in the associated inventory.
---@param id Int A valid ObjType ID.
---@return Int # The number of objects matching the id.
function Inv:GetTotal(id) end

---Returns the number of objects in the inventory that are in the category specified.
---@param category Int A valid category of object.
---@return Int # The number of objects matching the specified category.
function Inv:GetCategoryTotal(category) end

---A representation of an individual inventory slot.
---@class InvSlot
---@field obj ObjType Unique ID associated with the inventory.
---@field count Int Number of objects in the slot.
