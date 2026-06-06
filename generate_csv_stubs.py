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


def generate_enum(enum_name: str, entries: list[tuple[int, str]]) -> str:
    lines = ["---@meta", "", f"---@enum {enum_name}", f"{enum_name} = {{"]
    for npc_id, name in entries:
        lines.append(f"    {lua_key(name)} = {npc_id},")
    lines.append("}")
    lines.append("")
    return "\n".join(lines)


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
        lua_code = generate_enum(enum_name, entries)

        out_path = out_dir / csv_path.with_suffix(".lua").name
        out_path.write_text(lua_code, encoding="utf-8")

        if verbose:
            print(f"  wrote: {out_path.name}  ({len(entries)} entries)")
        generated += 1

    print(f"Generated {generated} enum file(s) in {out_dir}.")


def main():
    process(Path("csvs"), Path("consts"), verbose=True)


if __name__ == "__main__":
    main()
