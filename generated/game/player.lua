---@meta

---An enum for all Skills in the game.
---@enum SkillType
SkillType = {
    ATTACK = 0,
    DEFENCE = 1,
    STRENGTH = 2,
    HITPOINTS = 3,
    RANGED = 4,
    PRAYER = 5,
    MAGIC = 6,
    COOKING = 7,
    WOODCUTTING = 8,
    FLETCHING = 9,
    FISHING = 10,
    FIREMAKING = 11,
    CRAFTING = 12,
    SMITHING = 13,
    MINING = 14,
    HERBLORE = 15,
    AGILITY = 16,
    THIEVING = 17,
    SLAYER = 18,
    FARMING = 19,
    RUNECRAFTING = 20,
    HUNTER = 21,
    CONSTRUCTION = 22,
    SUMMONING = 23,
    DUNGEONEERING = 24,
    DIVINATION = 25,
    INVENTION = 26,
    ARCHAEOLOGY = 27,
    NECROMANCY = 28,
}

---@class Player
Player = {}

---Returns whether a Player Character is logged in and exists in a game world.
---@return Bool Whether Player data is available to access.
function Player.IsAvailable() end

---Returns the current level for the given skill. This includes all skill bonuses and penalties.
---@param skill SkillType The skill to return the gameplay level for.
---@return Int The current gameplay level of the given skill.
function Player.GetLevelGameplay(skill) end

---Returns the current level for the given skill based on XP. This level is additionally capped by any Free/Member world limits on skill levels.
---@param skill SkillType The skill to return the capped level for.
---@return Int The current capped level of the given skill.
function Player.GetLevelCapped(skill) end

---Returns the current level for the given skill based on XP.
---@param skill SkillType The skill to return the level for.
---@return Int The current level of the given skill.
function Player.GetLevelUncapped(skill) end

---Returns the current XP for the given skill. This XP value is additionally capped by any Free/Member world limits on skill levels.
---@param skill SkillType The skill to return the capped XP for.
---@return Int The current capped XP of the given skill.
function Player.GetXPCapped(skill) end

---Returns the current XP for the given skill.
---@param skill SkillType The skill to return the XP for.
---@return Int The current XP of the given skill.
function Player.GetXPUncapped(skill) end

---Returns the current run energy for the Player Character. This value is a percentage.
---@return Int The current run energy.
function Player.GetRunEnergy() end

---Returns the current weight of the Player Character. This value is in kilograms.
---@return Int The current weight.
function Player.GetWeight() end

---Returns the current combat level of the Player Character.
---@return Int The current combat level.
function Player.GetCombatLevel() end

---Returns the PlayerEntity belonging to the currently logged in Player Character.
---@return PlayerEntity A PlayerEntity .
function Player.GetEntity() end
