---@meta

---@enum id.VarPlayerGroup
id.VarPlayerGroup = {
    GROUP_TYPE = 16,
    GROUP_WANTS_MEMBERS = 17,
    GROUP_LOOTSHARE = 21,
}

---@param id integer
---@return string
function id.VarPlayerGroup.FromID(id) end

config.VarPlayerGroup = {
    GROUP_TYPE = 16,
    GROUP_WANTS_MEMBERS = 17,
    GROUP_LOOTSHARE = 21,
}

---@param id integer
---@return string
function config.VarPlayerGroup.FromID(id) end
