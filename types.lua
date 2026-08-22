---@meta

-- ── Primitive type aliases ─────────────────────────────────────────────────────
---@alias Float number
---@alias Int integer
---@alias Uint integer
---@alias Uint8 integer
---@alias Uint16 integer
---@alias Uint64 integer
---@alias uint8 integer
---@alias Numeric number
---@alias IntegerString string
---@alias String string
---@alias Bool boolean
---@alias bool boolean
---@alias Boolean boolean
---@alias Integer integer
---@alias Table table
---@alias StructuredData table
---@alias PluginURL string

-- ── Bare class stubs (referenced in HTML docs but not defined inline) ──────────
---@class RuntimeSprite
---@class PluginAudioResource
---@class ui.LabelData

-- ── Cross-reference aliases (older API names / short forms) ───────────────────
-- Component configs docs reference bare "DragRenderBehaviour" without namespace.
---@alias DragRenderBehaviour ui.DragRenderBehaviour
-- Older plugin code uses ui.UIPos; current docs use ui.Pos.
---@alias ui.UIPos ui.Pos
-- ui/combo_field.html references bare "Component"/"Combo" without namespace.
---@alias Component ui.Component
---@alias Combo ui.ComboField
-- Config typeName pattern binds the "...Type" class to a shorter global
-- (e.g. DBRowType -> DBRow = {}), but other pages cross-reference it by that
-- shorter typeName string rather than the class name.
---@alias DBRow DBRowType
---@alias DBTable DBTableType
-- VarPlayer/VarClient/etc. are typeName values of the generic VarType config
-- class, not their own classes.
---@alias VarPlayer VarType

-- ── Game runtime globals (not covered by any HTML docs page) ──────────────────
-- These are injected by the RS client and have no documentation in site/.

---Integer constant database (fonts, styles, NPCs, objects, components, …).
---Sub-tables (e.g. id.Font, id.StyleSheet) are also id instances, so nested
---access like id.Font.MUSEO_SANS_15PT_REGULAR resolves without errors.
---Extends integer so that leaf values (e.g. id.Font.X) are accepted wherever
---an integer is expected.
---@class id: integer
---@field Category id.Category
---@field Component id.Component
---@field Cursor id.Cursor
---@field Font id.Font
---@field Interface id.Interface
---@field Inv id.Inv
---@field Loc id.Loc
---@field Music id.Music
---@field NPC id.NPC
---@field Obj id.Obj
---@field Quest id.Quest
---@field Sound id.Sound
---@field Sprite id.Sprite
---@field StyleSheet id.StyleSheet
---@field VarClient id.VarClient
---@field VarPlayer id.VarPlayer
---@field VarPlayerGroup id.VarPlayerGroup
---@field [any] id
id = {}

---@class var
---@field VarPlayer any
---@field VarClient any
var = {}

---Game config lookup tables (e.g. config.Obj.BRONZE_DAGGER).
---Sub-tables are also config instances for nested access.
---@class config
---@field Category config.Category
---@field Component config.Component
---@field Cursor config.Cursor
---@field Font config.Font
---@field Interface config.Interface
---@field Inv config.Inv
---@field Loc config.Loc
---@field Music config.Music
---@field NPC config.NPC
---@field Obj config.Obj
---@field Quest config.Quest
---@field Sound config.Sound
---@field Sprite config.Sprite
---@field StyleSheet config.StyleSheet
---@field VarClient config.VarClient
---@field VarPlayer config.VarPlayer
---@field VarPlayerGroup config.VarPlayerGroup
---@field [any] config
config = {}

---@class utils
---@field CalcTextWidth fun(fontID: Int, text: string) Int
utils = {}

---Execute a client console command.
---@param command string
function ExecuteConsoleCommand(command) end
