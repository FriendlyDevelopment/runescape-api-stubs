---@meta

---@enum QuestType
QuestType = {
    NORMAL = 0,
    SEASONAL = 1,
    TUTORIAL = 2,
}

---@enum QuestDifficulty
QuestDifficulty = {
    NOVICE = 0,
    INTERMEDIATE = 1,
    EXPERIENCED = 2,
    MASTER = 3,
    GRANDMASTER = 4,
    MULTIDIFFICULTY = 5,
}

---@class QuestTypeConfig
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "QUEST_200" .
---@field typeName String The type of this config. Will always be "Quest" .
---@field deprecated Bool Whether this quest config has been deprecated. It has often been superseded by a different valid config. Deprecated quests are occasionally referenced in order to use their iconID .
---@field name String The display name of this config type.
---@field sortName String The string to use when sorting quest names alphabetically. For example, "Lost Tribe, The."
---@field isMembers Bool Whether this quest is for members.
---@field questPoints Int How many quest points are rewarded for completing this quest.
---@field type QuestType The type of quest.
---@field difficulty QuestDifficulty The difficulty rating of this quest.
---@field iconID Int The sprite ID to display for this quest. This is shown on any MiniMenuEntry related to this quest.
---@field startCoordGrids CoordGrid[] A list of CoordGrids used to indicate where this quest can be started.
---@field viaCoordGrid CoordGrid An optional CoordGrid to help navigate to one of the quest starting coordinates.
---@field preReqQuestPoints Int How many quest points the Player Character must have before starting this quest.
---@field preReqQuests QuestTypeConfig[] A list of quest configs the Player Character must have completed in order to start this quest.
---@field preReqSkills QuestPreReqSkill[] A list of SkillType level requirement checks. Player Characters must meet all of the given requirements to start this quest.
---@field completedPreReqQuestPoints Bool Whether the Player Character has the required number of quest points to start this quest.
---@field completedPreReqQuests Bool[] Returns a list of boolean values for each prerequisite quest, indicating whether the Player Character has completed each of them.
---@field completedPreReqSkills Bool[] Returns a list of boolean values for each prerequisite skill level check, indicating whether the Player Character has completed each of them.
---@field canStartQuest Bool Whether the Player Character is able to start this quest. This returns true if all prerequisite checks are completed.
---@field hasStartedQuest Bool Whether the Player Character has started this quest.
---@field hasFinishedQuest Bool Whether the Player Character has completed this quest.
---@field masterQuestVars MasterQuestVarPlayer[] An array holding a list of MasterQuestVarPlayer descriptors. There will always be one element in this array.
---@field params ParamType[] Returns a list of all the ParamTypes stored in this config.
local Quest = {}

---Returns the corresponding output value for the given input ParamType .
---@param param ParamType The input param value.
---@return any # The corresponding output value. Returns param.defaultValue if the param is not found in the data structure.
function Quest:GetParamValue(param) end

---Returns whether this config contains output data for the given input ParamType .
---@param param ParamType The input param value.
---@return Bool # Whether a corresponding value exists in this config for ParamType .
function Quest:HasParam(param) end

---A container table holding data about a quest's progress tracking variable. A quest will have only one of these.
---@class MasterQuestVarPlayer
---@field varPlayer VarType The var.VarPlayer which holds the current progress value.
---@field startState Int The starting variable value for this quest. Values below this indicates that the quest has not been started.
---@field endState Int The completion value for this quest. Actual variable value may be greater than this, indicating post-completion progress.

---A container table holding data about a skill prerequisite.
---@class QuestPreReqSkill
---@field skillType SkillType The skill type to check.
---@field minimumLevel Int The minimum skill level required by the Player Character to complete this prerequisite.
