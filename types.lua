---@meta

-- ── Primitive type aliases ─────────────────────────────────────────────────────
---@alias Float number
---@alias Int integer
---@alias Long integer
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

--Unique integer types for all configs that are part of the `id` global

---@class DBRowId : integer
---@class VarPlayerId : integer
---@class InvId : integer
---@class CategoryId : integer
---@class MaterialId : integer
---@class LocId : integer
---@class QuestId : integer
---@class SeqId : integer
---@class VarPlayerGroupId : integer
---@class VarClientId : integer
---@class SoundId : integer
---@class ObjId : integer
---@class VarClanId : integer
---@class InterfaceId : integer
---@class MusicId : integer
---@class HeadbarId : integer
---@class SpriteId : integer
---@class EnumId : integer
---@class UIAnimCurveId : integer
---@class VarClanSettingId : integer
---@class StyleSheetId : integer
---@class StructId : integer
---@class FontId : integer
---@class HitmarkId : integer
---@class UIAnimId : integer
---@class ComponentId : integer
---@class BaseAnimSetId : integer
---@class NPCId : integer
---@class ParamId : integer
---@class CursorId : integer
---@class MapElementId : integer
---@class AchievementId : integer
---@class DBTableId : integer
---@class ModelId : integer


---@class _global.id
---@field DBRow { [string]: DBRowId, FromID: fun(id: DBRowId): string}
---@field VarPlayer { [string]: VarPlayerId, FromID: fun(id: VarPlayerId): string}
---@field Inv { [string]: InvId, FromID: fun(id: InvId): string}
---@field Category { [string]: CategoryId, FromID: fun(id: CategoryId): string}
---@field Material { [string]: MaterialId, FromID: fun(id: MaterialId): string}
---@field Loc { [string]: LocId, FromID: fun(id: LocId): string}
---@field Quest { [string]: QuestId, FromID: fun(id: QuestId): string}
---@field Seq { [string]: SeqId, FromID: fun(id: SeqId): string}
---@field VarPlayerGroup { [string]: VarPlayerGroupId, FromID: fun(id: VarPlayerGroupId): string}
---@field VarClient { [string]: VarClientId, FromID: fun(id: VarClientId): string}
---@field Sound { [string]: SoundId, FromID: fun(id: SoundId): string}
---@field Obj { [string]: ObjId, FromID: fun(id: ObjId): string}
---@field VarClan { [string]: VarClanId, FromID: fun(id: VarClanId): string}
---@field Interface { [string]: InterfaceId, FromID: fun(id: InterfaceId): string}
---@field Music { [string]: MusicId, FromID: fun(id: MusicId): string}
---@field Headbar { [string]: HeadbarId, FromID: fun(id: HeadbarId): string}
---@field Sprite { [string]: SpriteId, FromID: fun(id: SpriteId): string}
---@field Enum { [string]: EnumId, FromID: fun(id: EnumId): string}
---@field UIAnimCurve { [string]: UIAnimCurveId, FromID: fun(id: UIAnimCurveId): string}
---@field VarClanSetting { [string]: VarClanSettingId, FromID: fun(id: VarClanSettingId): string}
---@field StyleSheet { [string]: StyleSheetId, FromID: fun(id: StyleSheetId): string}
---@field Struct { [string]: StructId, FromID: fun(id: StructId): string}
---@field Font { [string]: FontId, FromID: fun(id: FontId): string}
---@field Hitmark { [string]: HitmarkId, FromID: fun(id: HitmarkId): string}
---@field UIAnim { [string]: UIAnimId, FromID: fun(id: UIAnimId): string}
---@field Component { [string]: ComponentId, FromID: fun(id: ComponentId): string}
---@field BaseAnimSet { [string]: BaseAnimSetId, FromID: fun(id: BaseAnimSetId): string}
---@field NPC { [string]: NPCId, FromID: fun(id: NPCId): string}
---@field Param { [string]: ParamId, FromID: fun(id: ParamId): string}
---@field Cursor { [string]: CursorId, FromID: fun(id: CursorId): string}
---@field MapElement { [string]: MapElementId, FromID: fun(id: MapElementId): string}
---@field Achievement { [string]: AchievementId, FromID: fun(id: AchievementId): string}
---@field DBTable { [string]: DBTableId, FromID: fun(id: DBTableId): string}
---@field Model { [string]: ModelId, FromID: fun(id: ModelId): string}

id = {}

---@class _global.var
---@field VarClient  { [string]: VarType, FromID: fun(id: VarPlayerId): VarType} Exists on the local game client, although the server is able to set its value remotely.
---@field VarPlayer { [string]: VarType, FromID: fun(id: VarPlayerId): VarType} Variables which are stored in the player character's savegame.
---@field VarPlayerGroup { [string]: VarType, FromID: fun(id: VarPlayerId): VarType} Currently unsupported
---@field VarClan { [string]: VarType, FromID: fun(id: VarPlayerId): VarType} Currently unsupported
---@field VarClanSettings { [string]: VarType, FromID: fun(id: VarPlayerId): VarType} Currently unsupported
---@field VarNPC unknown Currently unsupported
---@field VarObj unknown Currently unsupported
var = {}

---Game config lookup tables (e.g. config.Obj.BRONZE_DAGGER).
---Sub-tables are also config instances for nested access.
---@class _global.config
---@field DBRow { [string]: DBRowType, FromID: fun(id: DBRowId): DBRowType}
---@field Inv { [string]: InvType, FromID: fun(id: InvId): InvType}
---@field Headbar { [string]: HeadbarType, FromID: fun(id: HeadbarId): HeadbarType}
---@field Enum { [string]: EnumType, FromID: fun(id: EnumId): EnumType}
---@field Loc { [string]: LocType, FromID: fun(id: LocId): LocType}
---@field Quest { [string]: QuestType, FromID: fun(id: QuestId): QuestType}
---@field Seq { [string]: SeqType, FromID: fun(id: SeqId): SeqType}
---@field Achievement { [string]: AchievementType, FromID: fun(id: AchievementId): AchievementType}
---@field Font { [string]: FontType, FromID: fun(id: FontId): FontType}
---@field Hitmark { [string]: HitmarkType, FromID: fun(id: HitmarkId): HitmarkType}
---@field BaseAnimSet { [string]: BaseAnimSetType, FromID: fun(id: BaseAnimSetId): BaseAnimSetType}
---@field MapElement { [string]: MapElementType, FromID: fun(id: MapElementId): MapElementType}
---@field NPC { [string]: NPCType, FromID: fun(id: NPCId): NPCType}
---@field Cursor { [string]: CursorType, FromID: fun(id: CursorId): CursorType}
---@field Obj { [string]: ObjType, FromID: fun(id: ObjId): ObjType}
---@field Param { [string]: ParamType, FromID: fun(id: ParamId): ParamType}
---@field DBTable { [string]: DBTableType, FromID: fun(id: DBTableId): DBTableType}
---@field Struct { [string]: StructType, FromID: fun(id: StructId): StructType}
config = {}

---@class _global.utils
---@field CalcTextWidth fun(fontID: Int, text: string) Int
utils = {}

---Execute a client console command.
---@param command string
function ExecuteConsoleCommand(command) end
