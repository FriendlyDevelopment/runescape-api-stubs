---@meta

---Achievement progress is provided by the AchievementType.progress property.
---@enum AchievementProgressType
AchievementProgressType = {
    READY = 0,
    LOCKED = -1,
    COMPLETE = -2,
    GRACE = -3,
    DEPRECATED = -4,
}

---Alternate achievement descriptions are available for various game modes.
---@enum AchievementDescriptionType
AchievementDescriptionType = {
    DEFAULT = 0,
    IRONMAN = 1,
    GROUP_IRONMAN_SIZE_2 = 2,
    GROUP_IRONMAN_SIZE_3 = 3,
    GROUP_IRONMAN_SIZE_4 = 4,
    GROUP_IRONMAN_SIZE_5 = 5,
}

---An achievement's display behaviour is controlled by this enumeration, and is provided by the AchievementType.hiddenType property.
---@enum AchievementHiddenType
AchievementHiddenType = {
    NEVER = "NEVER", -- 0
    IF_LOCKED = "IF_LOCKED", -- 1
    UNTIL_COMPLETE = "UNTIL_COMPLETE", -- 2
}

---@class AchievementType
---@field id Int The ID of this config type.
---@field configName String The name of this config, i.e. "CHEEVO_GODWARS_SOULSTONES" .
---@field typeName String The type of this config. Will always be "Achievement" .
---@field name String The display name of this config type.
---@field reward String A string containing any rewards for this achievement.Multiple rewards are delimited by "<br>".
---@field isMembers Bool Whether this achievement is for members.
---@field category Int The category type of this config.Returns -1 if none is set.Category name is available using id.Category.FromID() .
---@field subCategory Int The sub-category type of this config.Returns -1 if none is set.Category name is available using id.Category.FromID() .
---@field spriteID Int The ID of any sprite shown for this achievement.Returns -1 if not set.
---@field runeScore Int The RuneScore value of the achievement.Returns 0 if not set.
---@field hiddenType AchievementHiddenType The visibility behaviour of this achievement if its prerequisites are incomplete.
---@field graceExpiryRunedate Int The RuneDay when the grace period for this achievement expires.Before this, the achievement is always considered complete for the purpose of meta-achievements (e.g. Completion Cape).Returns -1 if not set.
---@field hasRequirementDescriptions Bool Whether any of the achievement requirements contains a description.
---@field totalPrereqCount Int How many total prerequisites this achievement contains.
---@field totalRequirementCount Int How many total requirements this achievement contains.
---@field dbRowConfig DBRow Any associated DBRow for this achievement.Returns nil if not set.
---@field tallyTarget Int For achievements with a tally (such as killing 100 monsters), this returns what the target value is.Each achievement can have only one tally.Returns -1 if not set.
---@field tallyProgress Int For achievements with a tally, this returns the current progression count.Returns -1 if not set.
---@field descriptions any Array of Table Returns a list of entries, each of which contain a AchievementDescriptionType and the text for the description, i.e.[ { "type" : AchievementDescriptionType , "text" : "Description..." }, ...]
---@field prereqs Table Returns all prerequisites for this achievement, separated into sub-lists of requirement type, i.e.{ "skills" : [ AchievementTestSkill , ... ], "quests" : [ AchievementTestQuest , ... ], "achievements" : [ AchievementTestAchievement , ... ], "varTotals" : [ AchievementTestVarTotal , ... ], "varTestBits" : [ AchievementTestVarTestBit , ... ], }
---@field achievements Table Returns all requirements for this achievement, separated into sub-lists of requirement type, i.e.{ "skills" : [ AchievementTestSkill , ... ], "quests" : [ AchievementTestQuest , ... ], "achievements" : [ AchievementTestAchievement , ... ], "varTotals" : [ AchievementTestVarTotal , ... ], "varTestBits" : [ AchievementTestVarTestBit , ... ], }
---@field progress Int Returns a progression value for this achievement.If the value is 0 or less, then it will be a AchievementProgressType .Use AchievementProgressType.FromID(config.progress) to view the type name.If the value is greater than 0 then it indicates the current completion progress, where 10000 is the maximum value.For example: local percentComplete = config.progress / 100
---@field prereqsComplete Bool Whether prerequisites are regarded as completed.This is impacted by completionCountForPrereqGroups and GetSubItemCompletionCountForPrereqGroup() whereby not every test needs to be completed for this property to return true .
---@field prereqGroupCount Int How many separate groups of prerequisite tests exist.
---@field completionCountForPrereqGroups Int How many prerequisite groups need to be complete in order to consider all prerequisites as completed.For example, if prereqGroupCount == 2 and completionCountForPrereqGroups == 1 then only one of the two groups needs to be completed.
---@field requirementGroupCount Int How many separate groups of requirement tests exist.
---@field completionCountForRequirementGroups Int How many requirement groups need to be complete in order to consider all requirements as completed.For example, if requirementGroupCount == 2 and completionCountForRequirementGroups == 1 then only one of the two groups needs to be completed.
Achievement = {}

---Returns whether the given prerequisite group is considered complete.
---@param group Int The group ID to be tested for completion. group is 0-indexed.
---@return Bool Whether the prerequisite group is considered complete.
function Achievement:GetPrereqGroupComplete(group) end

---Returns how many individual prerequisites, each with the same group, must be completed for that group to be considered complete.
---@param group Int The group ID to be checked. group is 0-indexed.
---@return Bool How many items in the prerequisite group need to be completed for the entire group to be considered complete.
function Achievement:GetSubItemCompletionCountForPrereqGroup(group) end

---Returns how many individual requirements, each with the same group, must be completed for that group to be considered complete.
---@param group Int The group ID to be checked. group is 0-indexed.
---@return Bool How many items in the requirement group need to be completed for the entire group to be considered complete.
function Achievement:GetSubItemCompletionCountForRequirementGroup(group) end

---This test collects Player Character's levels in the given SkillTypes into one cumulative total, and compares it against the target total level.
---@class AchievementTestSkill
---@field group Int The group ID of this test.
---@field skillTypes any Array of SkillType All skill types to be tested.The levels of each skill type are added together.
---@field totalLevels Int The target total skill levels which must be achieved.
---@field description String The description for this test, if supplied.
---@field isComplete Bool Whether the Player Character has completed this test.
AchievementTestSkill = {}

---This test checks whether the Player Character has completed the given quest.
---@class AchievementTestQuest
---@field group Int The group ID of this test.
---@field quest QuestType The quest config to test for completion.
---@field description String The description for this test, if supplied.
---@field isComplete Bool Whether the Player Character has completed this test.
AchievementTestQuest = {}

---This test checks whether the Player Character has completed the given achievement.
---@class AchievementTestAchievement
---@field group Int The group ID of this test.
---@field achievement AchievementType The achievement config to test for completion.
---@field description String The description for this test, if supplied.
---@field isComplete Bool Whether the Player Character has completed this test.
AchievementTestAchievement = {}

---This test checks whether the cumulative total of a given list of VarPlayers values meets or exceeds a given total value.
---@class AchievementTestVarTotal
---@field group Int The group ID of this test.
---@field vars any Array of VarPlayer The list of VarPlayer variables to accumulate the values of.
---@field totalValue Int The target value which must be met or exceeded.
---@field description String The description for this test, if supplied.
---@field isComplete Bool Whether the Player Character has completed this test.
AchievementTestVarTotal = {}

---This test checks whether a specific bit in a VarPlayer value matches a given value of 0 or 1 .
---@class AchievementTestVarTestBit
---@field group Int The group ID of this test.
---@field var VarPlayer The VarPlayer variable holding the value which is tested.
---@field bitIndex Int The bit index of the tested value. bitIndex is 0-indexed.
---@field bitValue Int The target value which must be matched.This is typically always 1 .
---@field description String The description for this test, if supplied.
---@field isComplete Bool Whether the Player Character has completed this test.
AchievementTestVarTestBit = {}
