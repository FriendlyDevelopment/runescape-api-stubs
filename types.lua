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
---@alias Table table
---@alias StructuredData table
---@alias PluginURL string

-- ── Bare class stubs (referenced in HTML docs but not defined inline) ──────────
---@class RuntimeSprite
---@class Rect
---@class PluginAudioResource
---@class ui.LabelData

-- ── Cross-reference aliases (older API names / short forms) ───────────────────
-- ComboField constructor return type is documented as "Combo" in the HTML.
---@alias Combo ui.ComboField
-- Component configs docs reference bare "DragRenderBehaviour" without namespace.
---@alias DragRenderBehaviour ui.DragRenderBehaviour
-- component.html uses "ComponentParamsConfig" but the class is ui.ComponentParams.
---@alias ui.ComponentParamsConfig ui.ComponentParams
-- Older plugin code uses ui.AlignMode; current docs use ui.Align.
---@alias ui.AlignMode ui.Align
-- Older plugin code uses ui.UIPos; current docs use ui.Pos.
---@alias ui.UIPos ui.Pos

-- ── Game runtime globals (not covered by any HTML docs page) ──────────────────
-- These are injected by the RS client and have no documentation in site/.

---Integer constant database (fonts, styles, NPCs, objects, components, …).
---Sub-tables (e.g. id.Font, id.StyleSheet) are also id instances, so nested
---access like id.Font.MUSEO_SANS_15PT_REGULAR resolves without errors.
---Extends integer so that leaf values (e.g. id.Font.X) are accepted wherever
---an integer is expected.
---@class id: integer
---@field [any] id
id = {}

---Single event subscription channel — e.g. Event.Logic, Event.EntityDraw.
---@class EventSubscription
---@field Add fun(name: string, callback: function)
---@field Remove fun(name: string)
EventSubscription = {}

---Event subscription bus. Usage: Event.<Type>.Add(name, callback).
---@class Event
---@field [any] EventSubscription
Event = {}

---Entity type enumeration used in EntityDraw events (e.g. EntityType.NPC).
---@class EntityType
---@field [any] integer
EntityType = {}

---Game config lookup tables (e.g. config.Obj.BRONZE_DAGGER).
---Sub-tables are also config instances for nested access.
---@class config
---@field [any] config
config = {}

---Execute a client console command.
---@param command string
function ExecuteConsoleCommand(command) end
