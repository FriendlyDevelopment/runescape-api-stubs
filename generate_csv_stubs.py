import csv
import re
import sys
from pathlib import Path

LUA_KEYWORDS = frozenset(
    {
        "and",
        "break",
        "do",
        "else",
        "elseif",
        "end",
        "false",
        "for",
        "function",
        "goto",
        "if",
        "in",
        "local",
        "nil",
        "not",
        "or",
        "repeat",
        "return",
        "then",
        "true",
        "until",
        "while",
    }
)

_IDENT_RE = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")

# Types that are exposed under the config global.
CONFIG_TYPES = {
    "DBRow": "DBRowType", "Inv": "InvType", "Headbar": "HeadbarType",
    "Enum": "EnumType", "Loc": "LocType", "Quest": "QuestType",
    "Seq": "SeqType", "Achievement": "AchievementType", "Font": "FontType",
    "Hitmark": "HitmarkType", "BaseAnimSet": "BaseAnimSetType",
    "MapElement": "MapElementType", "NPC": "NPCType", "Cursor": "CursorType",
    "Obj": "ObjType", "Param": "ParamType", "DBTable": "DBTableType",
    "Struct": "StructType",
}

# Types that are exposed under the var global.
VAR_CONFIG_TYPES = {"VarPlayer", "VarClient"}


def sanitise_name(raw: str) -> str:
    """Convert an arbitrary string to a valid Lua identifier."""
    s = re.sub(r"[^A-Za-z0-9_]", "_", raw)
    if s and s[0].isdigit():
        s = "_" + s
    return s or "_"


def lua_key(name: str) -> str:
    """Return the table-key form, quoting if needed."""
    if _IDENT_RE.match(name) and name not in LUA_KEYWORDS:
        return name
    return f'["{name}"]'


def load_csv(path: Path) -> list[tuple[int, str]]:
    """Return sorted (id, name) pairs, skipping blank names and exact duplicates."""
    seen: set[tuple[int, str]] = set()  # (id, sanitised_name) already emitted
    name_to_id: dict[str, int] = {}  # sanitised_name -> first id seen
    id_name: list[tuple[int, str]] = []

    with path.open(encoding="utf-8", errors="replace") as fh:
        reader = csv.reader(fh)
        for row in reader:
            if len(row) < 2:
                continue
            id_str, raw_name = row[0].strip(), row[1].strip()
            if not id_str or not raw_name:
                continue
            try:
                entry_id = int(id_str)
            except ValueError:
                continue

            name = sanitise_name(raw_name)

            # Skip exact duplicates (same id AND same name)
            if (entry_id, name) in seen:
                continue

            seen.add((entry_id, name))
            name_to_id.setdefault(name, entry_id)
            id_name.append((entry_id, name))

    id_name.sort(key=lambda x: x[0])
    return id_name


# LuaLS seems to have a hard file limit of 10MiB, we use 8MiB just to be safe.
# Even with preloadFileSize set this can't be avoided and seemingly won't get changed: https://github.com/LuaLS/lua-language-server/issues/2399
# We'll make sure to split id.X and config.X into separate files
def _enum_block(prefix: str, enum_name: str, kv_block: str) -> str:
    lines = [
        "---@meta",
        "",
        f"---@enum {prefix}.{enum_name}",
        f"{prefix}.{enum_name} = {{",
        kv_block,
        "}",
        "",
        "---@param id integer",
        "---@return string",
        f"function {prefix}.{enum_name}.FromID(id) end",
        "",
    ]
    return "\n".join(lines)


def _config_enum_block(enum_name: str, entries: list[tuple[int, str]]) -> str:
    object_type = CONFIG_TYPES[enum_name]
    fields = [f"    {lua_key(name)} = {{}},"
              for name in dict.fromkeys(name for _, name in entries)]
    lines = [
        "---@meta",
        "---@diagnostic disable: missing-fields",
        "",
        f"config.{enum_name} = {{",
        *fields,
        "}",
        "",
        f"---@param id {enum_name}Id",
        f"---@return {object_type}",
        f"function config.{enum_name}.FromID(id) end",
        "",
    ]
    return "\n".join(lines)


def _var_enum_block(enum_name: str, entries: list[tuple[int, str]]) -> str:
    fields = [f"    {lua_key(name)} = {{}},"
              for name in dict.fromkeys(name for _, name in entries)]
    lines = [
        "---@meta",
        "---@diagnostic disable: missing-fields",
        "",
        f"var.{enum_name} = {{",
        *fields,
        "}",
        "",
        f"---@param id {enum_name}Id",
        "---@return VarType",
        f"function var.{enum_name}.FromID(id) end",
        "",
    ]
    return "\n".join(lines)


def generate_stub_files(
    enum_name: str, entries: list[tuple[int, str]]
) -> dict[str, str]:
    """Generate numeric IDs and supported config or variable object fields."""
    kv_lines = [f"    {lua_key(name)} = {entry_id}," for entry_id, name in entries]
    kv_block = "\n".join(kv_lines)

    files = {
        f"{enum_name}.lua": _enum_block("id", enum_name, kv_block),
    }
    if enum_name in CONFIG_TYPES:
        files[f"{enum_name}.config.lua"] = _config_enum_block(enum_name, entries)
    if enum_name in VAR_CONFIG_TYPES:
        files[f"{enum_name}.var.lua"] = _var_enum_block(enum_name, entries)
    return files


def process(csv_dir: Path, out_dir: Path, verbose: bool = False):
    csv_files = sorted(csv_dir.glob("*.csv"))
    if not csv_files:
        print(f"No CSV files found in {csv_dir}", file=sys.stderr)
        sys.exit(1)

    out_dir.mkdir(parents=True, exist_ok=True)
    generated = 0

    for csv_path in csv_files:
        entries = load_csv(csv_path)
        if not entries:
            if verbose:
                print(f"  skip (empty): {csv_path.name}")
            continue

        enum_name = csv_path.stem
        for filename, lua_code in generate_stub_files(enum_name, entries).items():
            out_path = out_dir / filename
            out_path.write_text(lua_code, encoding="utf-8")

            if verbose:
                print(f"  wrote: {out_path.name}  ({len(entries)} entries)")
            generated += 1

    print(f"Generated {generated} stub file(s) in {out_dir}.")


def main():
    process(Path("csvs"), Path("consts"), verbose=True)


if __name__ == "__main__":
    main()
