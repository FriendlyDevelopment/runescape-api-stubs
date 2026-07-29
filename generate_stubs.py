import os
import re
from collections import Counter
from pathlib import Path
from html.parser import HTMLParser
from dataclasses import dataclass, field
from typing import Optional


class Node:
    VOID = {
        "br",
        "hr",
        "img",
        "input",
        "link",
        "meta",
        "area",
        "base",
        "col",
        "embed",
        "param",
        "source",
        "track",
        "wbr",
    }

    def __init__(self, tag: str, attrs: dict, parent=None):
        self.tag = tag
        self.cls: str = attrs.get("class", "")
        self.attrs = attrs
        self.parent = parent
        self.children: list = []  # Node | str

    def _append_text(self, text: str):
        if self.children and isinstance(self.children[-1], str):
            self.children[-1] += text
        else:
            self.children.append(text)

    def text(self, sep: str = " ") -> str:
        """All text content, recursively joined and whitespace-normalised."""
        parts = []
        for c in self.children:
            if isinstance(c, str):
                parts.append(c)
            else:
                parts.append(c.text(sep))
        raw = sep.join(parts)
        return re.sub(r"\s+", " ", raw).strip()

    def raw_text(self) -> str:
        """All text content joined with no whitespace normalisation."""
        parts = []
        for c in self.children:
            if isinstance(c, str):
                parts.append(c)
            else:
                parts.append(c.raw_text())
        return "".join(parts)

    def find_all(
        self, tag: Optional[str] = None, cls: Optional[str] = None
    ) -> list["Node"]:
        out = []
        for c in self.children:
            if isinstance(c, Node):
                match = (tag is None or c.tag == tag) and (cls is None or cls in c.cls)
                if match:
                    out.append(c)
                out.extend(c.find_all(tag, cls))
        return out

    def find(
        self, tag: Optional[str] = None, cls: Optional[str] = None
    ) -> Optional["Node"]:
        r = self.find_all(tag, cls)
        return r[0] if r else None

    def find_children(
        self, tag: Optional[str] = None, cls: Optional[str] = None
    ) -> list["Node"]:
        """Direct children only."""
        return [
            c
            for c in self.children
            if isinstance(c, Node)
            and (tag is None or c.tag == tag)
            and (cls is None or cls in c.cls)
        ]


class DOMBuilder(HTMLParser):
    def __init__(self):
        super().__init__()
        self.root = Node("root", {})
        self._cur = self.root

    def handle_starttag(self, tag, attrs):
        d = dict(attrs)
        node = Node(tag, d, self._cur)
        self._cur.children.append(node)
        if tag not in Node.VOID:
            self._cur = node

    def handle_endtag(self, tag):
        if tag in Node.VOID:
            # Malformed-but-common stray end tags for void elements (e.g.
            # `</br>` instead of `<br>`) still represent the element itself -
            # insert it rather than silently dropping it, matching browser
            # behaviour. Without this, text on either side of a `</br>` gets
            # merged into one run with no separator (e.g. table cells split
            # across lines collapse into "IntegerString").
            self._cur.children.append(Node(tag, {}, self._cur))
            return
        n = self._cur
        while n.parent and n.tag != tag:
            n = n.parent
        if n.tag == tag and n.parent:
            self._cur = n.parent

    def handle_data(self, data):
        self._cur._append_text(data)


def parse_dom(html: str) -> Node:
    b = DOMBuilder()
    b.feed(html)
    return b.root


# Structured page model


@dataclass
class Param:
    name: str
    type: str
    description: str = ""


@dataclass
class ReturnVal:
    type: str
    description: str = ""


@dataclass
class Signature:
    raw: str
    class_name: str
    method_name: str
    separator: str  # "." or ":"
    params: list[Param] = field(default_factory=list)
    returns: list[ReturnVal] = field(default_factory=list)


@dataclass
class EnumValue:
    name: str
    value: str = ""
    description: str = ""


@dataclass
class Enum:
    name: str
    description: str = ""
    values: list[EnumValue] = field(default_factory=list)
    is_int_enum: bool = False  # True = Name/Value (integer), False = Value/Description


@dataclass
class Property:
    name: str
    type: str
    description: str = ""
    read_only: bool = False


@dataclass
class Method:
    name: str
    description: str = ""
    signatures: list[Signature] = field(default_factory=list)


@dataclass
class TypeBlock:
    """A type/class defined within a page (e.g. PluginResource<T> in plugin.html)."""

    name: str
    description: str = ""
    enums: list[Enum] = field(default_factory=list)
    properties: list[Property] = field(default_factory=list)
    methods: list[Method] = field(default_factory=list)


@dataclass
class PageModel:
    title: str = ""
    file_path: str = ""
    overview: str = ""
    enums: list[Enum] = field(default_factory=list)
    properties: list[Property] = field(default_factory=list)
    methods: list[Method] = field(default_factory=list)
    extra_types: list[TypeBlock] = field(default_factory=list)
    # Fully-qualified class names that need a bare ---@class declaration but
    # have no methods or properties (e.g. ui.TextDataConfig).
    bare_classes: list[str] = field(default_factory=list)
    # Immediate parent class for the main class (from inheritance chain paragraph).
    parent_class: str = ""
    # Fully-qualified class names seen as `Qualified.Name.new()` inside example
    # code blocks (e.g. Usage/Example sections, which are otherwise skipped).
    # Some docs pages only show a value type's constructor in prose examples
    # rather than a formal Functions/Constructor section (e.g.
    # audio.SoundPlaybackParams, ui.TextDataConfig); this lets us still emit a
    # `.new()` stub for those classes.
    example_constructors: set[str] = field(default_factory=set)


# HTML to PageModel

# h2 sections to fully skip (no API items inside)
SKIP_SECTIONS = {
    "overview",
    "examples",
    "example",
    "requirements",
    "usage",
    "notes",
    "note",
    "dependencies",
}

# Lua reserved keywords — these cannot be used as bare identifiers in table constructors.
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

# h2 sections that introduce API items at the top-level
API_SECTIONS = {
    "enumerations",
    "enum",
    "enums",
    "methods",
    "static methods",
    "instance methods",
    "constructor",
    "constructors",
    "properties",
    "fields",
    "property",
    "types",
    "functions",
    "methods and properties",
    "common methods and properties",
}


def _table_headers(table_node: Node) -> list[str]:
    thead = table_node.find("thead")
    if not thead:
        return []
    return [th.text() for th in thead.find_all("th")]


def _table_rows(table_node: Node) -> list[list[str]]:
    tbody = table_node.find("tbody")
    if not tbody:
        return []
    rows = []
    for tr in tbody.find_all("tr"):
        rows.append([td.text() for td in tr.find_all("td")])
    return rows


def _extract_code_text(code_div: Node) -> str:
    pre = code_div.find("pre")
    target = pre if pre else code_div
    # raw_text preserves spaces from <span class="w"> elements
    raw = target.raw_text()
    return raw.replace("\r\n", "\n").replace("\r", "\n")


_EXAMPLE_CTOR_RE = re.compile(r"\b((?:[A-Za-z_]\w*\.)+[A-Za-z_]\w*)\.new\(\s*\)")


def _find_example_constructors(article: Node) -> set[str]:
    """Scan every code block in the article for zero-arg `Qualified.Name.new()` calls.

    This runs independently of the section state machine so it also picks up
    constructors that only ever appear inside skipped sections (Overview,
    Example, Usage, ...).
    """
    names: set[str] = set()
    for code_div in article.find_all("div", "language-lua"):
        text = _extract_code_text(code_div)
        names.update(m.group(1) for m in _EXAMPLE_CTOR_RE.finditer(text))
    return names


def _normalise_table_call_sig(sig: str) -> str:
    """Convert table-constructor call syntax to normal parenthesis syntax.

    RS docs sometimes document functions called as ``F{ key : T }`` (a single
    table argument) rather than ``F(key : T)``.  Normalise so the rest of the
    parser sees ordinary ``(…)`` syntax.
    """
    # function Name.Method{ param : Type } -> RetType
    m = re.match(r"^(function\s+[\w.:]+)\{([^}]*)\}(.*)$", sig)
    if m:
        sig = f"{m.group(1)}({m.group(2).strip()}){m.group(3)}"
    return sig


def _parse_signatures(raw_code: str) -> list[str]:
    """Split a code block containing one or more function signatures."""
    lines = raw_code.split("\n")
    sigs: list[str] = []
    current: list[str] = []
    paren_depth = 0

    for line in lines:
        stripped = line.strip()
        if not stripped:
            if current and paren_depth == 0:
                sigs.append(" ".join(current).strip())
                current = []
            continue

        if current or stripped.startswith("function "):
            current.append(stripped)
            paren_depth += stripped.count("(") - stripped.count(")")
            if paren_depth <= 0:
                paren_depth = 0
                sigs.append(" ".join(current).strip())
                current = []

    if current:
        sigs.append(" ".join(current).strip())

    return [_normalise_table_call_sig(s) for s in sigs if s.startswith("function ")]


def _parse_signature(raw: str) -> Optional[Signature]:
    """
    Parse a Lua function signature like:
      function ClassName.MethodName(param : Type, ...) -> ReturnType
      function ClassName:MethodName(param : Type) -> ReturnType
    """
    raw = raw.strip()
    if not raw.startswith("function "):
        return None
    body = raw[len("function ") :].strip()

    # Match: qualifiedName(sep)methodName(params)(->return)?
    # class_name may contain dots and angle brackets (including spaces inside <>),
    # e.g. ui.Pos, PluginResource<T>, game.options.<option name>
    _CLASS = r"[\w.]+(?:<[^>]*>)?"
    m = re.match(
        rf"^({_CLASS})([.:])([\w]+)\s*\((.*)\)\s*(?:->\s*(.+))?$",
        body,
        re.DOTALL,
    )
    if not m:
        # Bare function without class prefix
        m2 = re.match(r"^([\w]+)\s*\((.*)\)\s*(?:->\s*(.+))?$", body, re.DOTALL)
        if not m2:
            return None
        sig = Signature(raw=raw, class_name="", method_name=m2.group(1), separator=".")
        params_str = m2.group(2).strip()
        return_str = (m2.group(3) or "").strip()
        if return_str:
            sig.returns = _parse_return_types(return_str)
        if params_str:
            sig.params = _parse_params(params_str)
        return sig

    class_name = m.group(1)
    separator = m.group(2)
    method_name = m.group(3)
    params_str = m.group(4).strip()
    return_str = (m.group(5) or "").strip()

    sig = Signature(
        raw=raw, class_name=class_name, method_name=method_name, separator=separator
    )
    if return_str:
        sig.returns = _parse_return_types(return_str)
    if params_str:
        sig.params = _parse_params(params_str)
    return sig


def _parse_return_types(returns_str: str) -> list[ReturnVal]:
    """Parse return type string, handling [ Type, ... ] RS array notation."""
    returns_str = returns_str.strip()
    # RS array notation: [ Type, ... ] becomes Type[] ("?" for a genuinely
    # varying/dynamic element type, e.g. Enum:GetInputValues, is also accepted).
    m = re.match(r"^\[\s*(\?|[\w.]+(?:<[^>]*>)?)\s*,\s*\.\.\.\s*\]$", returns_str)
    if m:
        return [ReturnVal(type=f"{m.group(1)}[]")]
    # Comma-separate, but respect [...] brackets
    parts: list[ReturnVal] = []
    depth = 0
    current: list[str] = []
    for ch in returns_str:
        if ch == "[":
            depth += 1
            current.append(ch)
        elif ch == "]":
            depth -= 1
            current.append(ch)
        elif ch == "," and depth == 0:
            token = "".join(current).strip()
            if token:
                parts.append(ReturnVal(type=token))
            current = []
        else:
            current.append(ch)
    token = "".join(current).strip()
    if token:
        parts.append(ReturnVal(type=token))
    return parts


def _parse_params(params_str: str) -> list[Param]:
    """Parse a parameter list, respecting nested parens."""
    params: list[Param] = []
    depth = 0
    current: list[str] = []
    for ch in params_str:
        if ch == "(":
            depth += 1
            current.append(ch)
        elif ch == ")":
            depth -= 1
            current.append(ch)
        elif ch == "," and depth == 0:
            token = "".join(current).strip()
            if token:
                params.append(_parse_single_param(token))
            current = []
        else:
            current.append(ch)
    token = "".join(current).strip()
    if token:
        params.append(_parse_single_param(token))
    return params


def _parse_single_param(token: str) -> Param:
    """Parse 'name : Type?' into a Param.

    If the type is '...' (vararg notation), the param is normalised to
    Param(name='...', type='any') so that _render_method can emit the
    correct LuaLS annotation and function signature.
    """
    m = re.match(r"^(\w+)\s*:\s*(.+)$", token)
    if m:
        ptype = m.group(2).strip()
        if ptype == "...":
            return Param(name="...", type="any")
        return Param(name=m.group(1), type=ptype)
    # Bare '...' with no name
    if token.strip() == "...":
        return Param(name="...", type="any")
    return Param(name=token.strip(), type="any")


def _fill_param_descriptions(sigs: list[Signature], param_table: Node):
    rows = _table_rows(param_table)
    if not rows:
        return
    headers = [h.lower() for h in _table_headers(param_table)]
    name_col = next(
        (i for i, h in enumerate(headers) if h in ("parameter", "name", "param")), 0
    )
    type_col = next(
        (i for i, h in enumerate(headers) if h == "type"), 1 if len(headers) > 1 else 0
    )
    desc_col = next(
        (i for i, h in enumerate(headers) if h in ("description", "desc")),
        2 if len(headers) > 2 else len(headers) - 1,
    )

    for row in rows:
        if len(row) < 1:
            continue
        pname = row[name_col] if name_col < len(row) else ""
        ptype = row[type_col] if type_col < len(row) else ""
        pdesc = row[desc_col] if desc_col < len(row) else ""
        for sig in sigs:
            for param in sig.params:
                if param.name == pname:
                    if not param.type or param.type == "any":
                        param.type = ptype
                    elif sig is sigs[0] and len(sigs) > 1 and ptype and "/" in ptype:
                        # The code block has per-overload types; the table provides
                        # the combined union (e.g. Float/Vector2/Vector3).  Apply that
                        # union to the primary sig so its @param annotation is complete.
                        # Only do this for multi-sig (overloaded) methods — for
                        # single-sig functions the code-block type is authoritative.
                        param.type = ptype
                    param.description = pdesc


def _fill_return_descriptions(sigs: list[Signature], return_table: Node):
    rows = _table_rows(return_table)
    if not rows:
        return
    headers = [h.lower() for h in _table_headers(return_table)]
    type_col = next(
        (i for i, h in enumerate(headers) if h in ("returns", "return", "type")), 0
    )
    desc_col = next(
        (i for i, h in enumerate(headers) if h in ("description", "desc")),
        1 if len(headers) > 1 else 0,
    )

    for i, row in enumerate(rows):
        if len(row) < 1:
            continue
        rtype = row[type_col] if type_col < len(row) else ""
        rdesc = row[desc_col] if desc_col < len(row) else ""
        # Skip stray rows that look like code-fence delimiters or empty types
        if not rtype.strip() or rtype.startswith("`"):
            continue
        for sig in sigs:
            if i < len(sig.returns):
                sig.returns[i].description = rdesc
                if sig is sigs[0] and len(sigs) > 1 and rtype and "/" in rtype:
                    # The code block has per-overload return types; the table
                    # provides the combined union (e.g. Float/Vector2/Vector3).
                    # Apply that union to the primary sig so its @return annotation
                    # is complete.  Only do this for multi-sig (overloaded) methods
                    # — for single-sig functions the code-block type is authoritative
                    # (the table may contain a stale copy-paste of another method).
                    sig.returns[i].type = rtype
            elif rtype:
                sig.returns.append(ReturnVal(type=rtype, description=rdesc))


def _title_to_type_name(title: str) -> str:
    """Convert a section title to a valid Lua identifier / type name.

    - Single-word names that are already CamelCase, qualified (contain a dot),
      or start with an uppercase letter are preserved as-is.
    - Multi-word names are joined with each word capitalised.
    - Hyphens within words (e.g. "Built-in") are removed and the adjacent
      letter capitalised so the result is a valid identifier.
    - A trailing plural 's' is stripped for multi-word names.
    """
    # Split on spaces then hyphens, e.g. "Recommend Built-in Style" -> ["Recommend", "Built", "in", "Style"].
    raw_words = title.split()
    if len(raw_words) == 1:
        word = raw_words[0]
        # Preserve qualified names (e.g. "ui.PagedLayerHeader") and CamelCase
        # (e.g. "ObjEntry", "ObjStackEntity").
        if "." in word or word[0].isupper():
            return word
        return word.capitalize()

    words: list[str] = []
    for w in raw_words:
        words.extend(p for p in w.split("-") if p)

    # Multi-word: capitalise each word and join
    camel = "".join(w.capitalize() for w in words)
    # Remove trailing 's' only if it's clearly a plural (ends in lowercase 's')
    if camel.endswith("s") and len(camel) > 3 and camel[-2].islower():
        camel = camel[:-1]
    return camel


def _article(root: Node) -> Optional[Node]:
    return root.find("article", "md-content__inner")


def _child_nodes(node: Node) -> list[Node]:
    return [c for c in node.children if isinstance(c, Node)]


def _flatten_article_nodes(article: Node) -> list[Node]:
    """Return the article's direct child nodes with <details> elements unwrapped.

    MkDocs renders collapsible sections as <details><summary>…</summary>…</details>.
    The API-relevant content (tables, code blocks) lives inside these elements, so
    we inline their children (skipping the <summary>) to make the state machine see
    them as normal top-level nodes.

    Admonition callouts (<div class="admonition …">) may contain extra function
    signatures in nested code blocks (e.g. GetBool/GetInt aliases documented
    alongside the generic Get).  We hoist those language-lua divs into the
    flattened list so the state machine processes them as additional signatures
    for the current method.
    """
    result: list[Node] = []
    for child in article.children:
        if not isinstance(child, Node):
            continue
        if child.tag == "details":
            for inner in child.children:
                if isinstance(inner, Node) and inner.tag != "summary":
                    result.append(inner)
        elif child.tag == "div" and "admonition" in child.cls:
            # Hoist any code blocks out of admonition callouts so they reach
            # the state machine as if they were normal top-level code blocks.
            for code_div in child.find_all("div"):
                if "language-lua" in code_div.cls:
                    result.append(code_div)
        else:
            result.append(child)
    return result


def _is_enum_section(sec: str) -> bool:
    return "enum" in sec


def _is_method_section(sec: str) -> bool:
    return any(
        k in sec for k in ("method", "function", "constructor", "static", "instance")
    )


def _is_prop_section(sec: str) -> bool:
    return any(k in sec for k in ("propert", "field"))


def _is_skip_section(sec: str) -> bool:
    return sec in SKIP_SECTIONS


def _sanitise_type_name(name: str) -> str:
    """Strip generic params like <T> and fix trailing punctuation in type names."""
    name = re.sub(r"<[^>]*>", "", name)
    return name.strip(".")


def extract_page(html: str, file_path: str = "") -> PageModel:
    root = parse_dom(html)
    article = _article(root)
    if article is None:
        return PageModel(file_path=file_path)

    model = PageModel(file_path=file_path)
    model.example_constructors = _find_example_constructors(article)
    children = _flatten_article_nodes(article)

    # Heading ids that are actually cross-referenced elsewhere in the page
    # body (e.g. a field's description linking to "#minimenuentry-properties").
    # Excludes each heading's own auto-generated "headerlink" permalink icon,
    # which would otherwise make every heading trivially "self-referenced".
    referenced_heading_ids = {
        a.attrs.get("href", "")[1:]
        for a in article.find_all("a")
        if a.attrs.get("href", "").startswith("#") and "headerlink" not in a.cls
    }

    # pass 1: title and inheritance
    _ARROW_RE = re.compile(r"->")
    for node in children:
        if node.tag == "h1":
            model.title = node.text().replace("¶", "").strip()
        elif node.tag == "p" and not model.parent_class:
            # Detect inheritance paragraph: "ui.Component -> ui.Sprite"
            # This must be a bare breadcrumb of dotted identifiers - a normal
            # sentence that happens to contain "->" (e.g. "The Fine -> Grid
            # unit conversion is as follows") is NOT inheritance and must be
            # rejected, rather than stripped down into a garbled "identifier".
            raw_text = node.text()
            if _ARROW_RE.search(raw_text):
                parts = [p.strip() for p in _ARROW_RE.split(raw_text)]
                if len(parts) >= 2 and all(
                    re.fullmatch(r"\w+(?:\.\w+)*", p) for p in parts
                ):
                    # The page describes the last class; its parent is second-to-last.
                    model.parent_class = parts[-2]

    # pass 2: state machine walk
    section_h2 = "overview"
    h2_context = "overview"  # tracks the H2-level context; unlike section_h2
    # it is NOT overridden by H3/H4 sub-sections
    section_h3 = ""

    current_method: Optional[Method] = None
    current_enum: Optional[Enum] = None
    current_typeblock: Optional[TypeBlock] = None

    def _target() -> tuple:
        """Return (methods, enums, props) lists for the current context."""
        if current_typeblock is not None:
            return (
                current_typeblock.methods,
                current_typeblock.enums,
                current_typeblock.properties,
            )
        return (model.methods, model.enums, model.properties)

    def flush_method():
        nonlocal current_method
        if current_method is not None:
            methods, _, _ = _target()
            if current_method not in methods:
                methods.append(current_method)
        current_method = None

    def flush_enum():
        nonlocal current_enum
        if current_enum is not None:
            if current_enum.values:
                _, enums, _ = _target()
                if current_enum not in enums:
                    enums.append(current_enum)
            else:
                # No value table found for this enum heading.
                name = current_enum.name
                if "." in name or (name and name[0].isupper()):
                    # Looks like a qualified class/type name (e.g. "ui.AspectRatioMode").
                    # Record as a bare class rather than a spurious property.
                    model.bare_classes.append(name)
                else:
                    # Simple lowercase name (e.g. Plugin.urls) — table-typed property.
                    _, _, props = _target()
                    prop = Property(
                        name=name,
                        type="table",
                        description=current_enum.description,
                    )
                    props.append(prop)
        current_enum = None

    def flush_typeblock():
        nonlocal current_typeblock
        if current_typeblock is not None:
            if current_typeblock not in model.extra_types:
                model.extra_types.append(current_typeblock)
        current_typeblock = None

    # Section keywords that introduce sub-sections within a type block
    SUB_SECTION_KEYWORDS = {
        "enumerations",
        "enum",
        "enums",
        "methods",
        "static methods",
        "instance methods",
        "constructor",
        "constructors",
        "properties",
        "fields",
        "methods and properties",
    }

    # Root class name (from the page's own H1) - used to tell a "<Name>
    # Properties" section that enriches the page's own main class (the
    # common case) apart from one that names a second, distinct class (e.g.
    # minimenu.html has both "MiniMenu Properties" and "MiniMenuEntry
    # Properties" - only the latter should become its own TypeBlock).
    root_class_name = _title_to_type_name(model.title) if model.title else ""
    _PROPERTIES_HEADING_RE = re.compile(r"^(.+?)\s+propert(?:y|ies)$", re.IGNORECASE)

    i = 0
    while i < len(children):
        node = children[i]

        if node.tag == "h2":
            flush_method()
            flush_enum()
            flush_typeblock()
            h2_raw = node.text().replace("¶", "").strip()
            section_h2 = h2_raw.lower()
            h2_context = section_h2  # H2 always resets both
            section_h3 = ""

            prop_match = _PROPERTIES_HEADING_RE.match(h2_raw)
            if (
                prop_match
                and _title_to_type_name(prop_match.group(1)) != root_class_name
                and node.attrs.get("id", "") in referenced_heading_ids
            ):
                # Names a distinct class's properties, not the page's own main
                # class (e.g. "MiniMenuEntry Properties" on minimenu.html).
                # The heading-id check rejects purely cosmetic category
                # groupings of the SAME class's properties (e.g. component.html's
                # "Visual/State/Interface Properties"), which nothing links to.
                current_typeblock = TypeBlock(
                    name=_title_to_type_name(prop_match.group(1))
                )
                i += 1
                continue

            # Unknown h2 sections become TypeBlocks (e.g. "Plugin Resources" -> PluginResource),
            # except "propert"/"field" sections which stay on the main class.
            if (
                not _is_skip_section(section_h2)
                and section_h2 not in API_SECTIONS
                and not any(k in section_h2 for k in ("propert", "field"))
            ):
                tb_name = _title_to_type_name(h2_raw)
                current_typeblock = TypeBlock(name=tb_name)

            i += 1
            continue

        if node.tag == "h3":
            flush_method()
            flush_enum()
            section_h3 = node.text().replace("¶", "").strip()
            sec3_lower = section_h3.lower()

            # Skip headings like "Overview" inside type sections
            if sec3_lower in SKIP_SECTIONS:
                i += 1
                continue

            if sec3_lower in SUB_SECTION_KEYWORDS:
                # This h3 is a sub-section header inside a type block
                # (e.g. h3 "Methods" inside h3 PluginResource<T>)
                # Update section context but keep current_typeblock
                section_h2 = sec3_lower
                i += 1
                continue

            if _is_enum_section(section_h2):
                # Could be a real enum or a "field" described under Enumerations
                # Defer creation — we create the enum only if a value table follows
                current_enum = Enum(name=section_h3)
            elif "types" in h2_context:
                # h3 under "Types" h2: introduce a new type/class block
                # (e.g. audio.SoundInstance, ui.Pos, ui.ComponentDragConfig …)
                flush_typeblock()
                current_typeblock = TypeBlock(name=section_h3)
                section_h2 = h2_context  # Reset any h4-level sub-section override
            elif _is_method_section(section_h2):
                current_method = Method(name=section_h3)
            elif _is_prop_section(section_h2):
                # Usually an h3 under a Properties section is just a cosmetic
                # subgroup label for the SAME class (e.g. vector.html's
                # trailing "Properties" marker). But when the heading itself
                # names a distinct nested type - matching the same "<Name>
                # Properties" shape as the parent section (e.g. "NPCData
                # Properties" under "MiniMenuEntry Properties") - it
                # introduces a separate class, not a subgroup of this one.
                nested_match = _PROPERTIES_HEADING_RE.match(section_h3)
                if nested_match and node.attrs.get("id", "") in referenced_heading_ids:
                    flush_typeblock()
                    current_typeblock = TypeBlock(
                        name=_title_to_type_name(nested_match.group(1))
                    )
            elif "." in h2_context and current_typeblock is not None:
                # h3 under a dotted h2 class name (e.g. h3 "GetInterface" under
                # h2 "ui.Interfaces") — treat as a method on the current TypeBlock
                # rather than introducing a new TypeBlock.
                current_method = Method(name=section_h3)
            elif not _is_skip_section(section_h2):
                # h3 that doesn't match known sections within main content —
                # treat as a new type block (e.g. PluginResource<T>)
                flush_typeblock()
                current_typeblock = TypeBlock(name=section_h3)

            i += 1
            continue

        if node.tag == "h4":
            flush_method()
            h4_text = node.text().replace("¶", "").strip()
            h4_lower = h4_text.lower()
            # H4 with a dotted name in a "types" H2 context is a nested class
            # declaration (e.g. ui.TextDataConfig under ui.TextData).
            # Record it for a bare ---@class stub without making it the active
            # context — subsequent methods still belong to the surrounding H3 class.
            if "." in h4_text and "types" in h2_context:
                model.bare_classes.append(h4_text)
            elif h4_lower in SUB_SECTION_KEYWORDS:
                # Sub-section keyword at H4 level (e.g. "Properties", "Methods")
                # updates section context like an H3 sub-section would.
                section_h2 = h4_lower
            elif _is_method_section(section_h2) or "types" in h2_context:
                current_method = Method(name=h4_text)
            elif _is_enum_section(section_h2):
                current_enum = Enum(name=h4_text)
            i += 1
            continue

        if _is_skip_section(section_h2):
            i += 1
            continue

        if node.tag == "p" and "admonition" not in node.cls:
            text = node.text()
            if not text:
                i += 1
                continue
            if section_h2 == "overview":
                if not model.overview:
                    model.overview = text
            elif current_method is not None and not current_method.description:
                current_method.description = text
            elif current_enum is not None and not current_enum.description:
                current_enum.description = text
            elif current_typeblock is not None and not current_typeblock.description:
                current_typeblock.description = text
            i += 1
            continue

        if node.tag == "div" and "language-lua" in node.cls:
            code_text = _extract_code_text(node)
            raw_sigs = _parse_signatures(code_text)
            parsed = [
                s for s in (_parse_signature(r) for r in raw_sigs) if s is not None
            ]

            if current_method is not None:
                for sig in parsed:
                    current_method.signatures.append(sig)
            elif current_enum is not None and parsed:
                # Code in an enum section — ignore (probably an example)
                pass
            elif parsed and (_is_method_section(section_h2) or "types" in section_h2):
                # No method object yet, create one from the signature name
                m_name = parsed[0].method_name or section_h3
                current_method = Method(name=m_name)
                for sig in parsed:
                    current_method.signatures.append(sig)
            elif current_typeblock is not None and parsed:
                # Code block inside an active TypeBlock (e.g. h3 "Register"
                # under h2 "Handling Events") — start a method on this TypeBlock.
                m_name = parsed[0].method_name or section_h3
                current_method = Method(name=m_name)
                for sig in parsed:
                    current_method.signatures.append(sig)
            i += 1
            continue

        if node.tag == "table":
            headers = [h.lower() for h in _table_headers(node)]
            rows = _table_rows(node)
            header_set = set(headers)

            if _is_enum_section(section_h2) and current_enum is not None:
                # Decide enum type from column headers
                is_int = (
                    "name" in header_set
                    and "value" in header_set
                    and "description" not in header_set
                )
                current_enum.is_int_enum = is_int
                _seen_enum_names = {v.name for v in current_enum.values}
                for row in rows:
                    if not row:
                        continue
                    if is_int:
                        name = row[0]
                        if name in _seen_enum_names:
                            continue
                        _seen_enum_names.add(name)
                        val = row[1] if len(row) > 1 else ""
                        current_enum.values.append(EnumValue(name=name, value=val))
                    else:
                        val_name = row[0]
                        if val_name in _seen_enum_names:
                            continue
                        _seen_enum_names.add(val_name)
                        desc = row[1] if len(row) > 1 else ""
                        current_enum.values.append(
                            EnumValue(name=val_name, description=desc)
                        )
                # An enum with values is definitely an enum; flush it now
                # so it doesn't get mistaken for a property.
                if current_enum.values:
                    flush_enum()

            elif current_method is not None:
                # Parameter or return table
                if (
                    "parameter" in header_set
                    or "param" in header_set
                    or (
                        "name" in header_set
                        and "type" in header_set
                        and "description" in header_set
                    )
                ):
                    _fill_param_descriptions(current_method.signatures, node)
                elif "returns" in header_set or "return" in header_set:
                    _fill_return_descriptions(current_method.signatures, node)
                # If the table has both Name/Type/Description it might be
                # a combined param table (common pattern)
                elif {"name", "type", "description"} <= header_set:
                    _fill_param_descriptions(current_method.signatures, node)

            elif _is_prop_section(section_h2):
                _, _, props = _target()
                for row in rows:
                    if len(row) < 2:
                        continue
                    pname = row[0]
                    ptype, pdesc = _coerce_prop_type(
                        row[1], row[2] if len(row) > 2 else ""
                    )
                    read_only = (
                        "(read-only)" in pdesc.lower() or "(read-only)" in pname.lower()
                    )
                    pdesc_clean = re.sub(
                        r"\(Read-only\)\s*", "", pdesc, flags=re.IGNORECASE
                    ).strip()
                    props.append(
                        Property(
                            name=pname,
                            type=ptype,
                            description=pdesc_clean,
                            read_only=read_only,
                        )
                    )

            elif (
                current_typeblock is not None
                and "name" in header_set
                and "type" not in header_set
                and "value" not in header_set
                and rows
                and re.match(
                    r"^[A-Z][A-Z0-9_]+( Supported by.*)?$", rows[0][0].strip() if rows[0] else ""
                )
            ):
                # "Name | Parameters | Description" table inside a TypeBlock —
                # hook / event listings (e.g. ui.Hook in component.html).
                # Treat each row's Name as a string-valued enum entry.
                if current_enum is None:
                    current_enum = Enum(name=current_typeblock.name)
                _seen = {v.name for v in current_enum.values}
                desc_col = next(
                    (i for i, h in enumerate(headers) if h in ("description", "desc")),
                    -1,
                )
                for row in rows:
                    vname = (
                        row[0].strip().split()[0]
                    )  # first word only (strip footnotes)
                    if not vname or vname in _seen:
                        continue
                    _seen.add(vname)
                    vdesc = (
                        row[desc_col].strip()
                        if desc_col >= 0 and desc_col < len(row)
                        else ""
                    )
                    current_enum.values.append(EnumValue(name=vname, description=vdesc))

            elif (
                current_typeblock is not None
                and ("name" in header_set or "property" in header_set)
                and "type" in header_set
            ):
                # Property table inside an active TypeBlock (e.g. audio.SoundPlaybackParams,
                # ui.ComponentDragConfig …) — not caught by section_h2 because the TypeBlock
                # was introduced by an h3 inside a "types" h2.
                for row in rows:
                    if len(row) < 2:
                        continue
                    pname = row[0]
                    ptype, pdesc = _coerce_prop_type(
                        row[1], row[2] if len(row) > 2 else ""
                    )
                    read_only = (
                        "(read-only)" in pdesc.lower() or "(read-only)" in pname.lower()
                    )
                    pdesc_clean = re.sub(
                        r"\(Read-only\)\s*", "", pdesc, flags=re.IGNORECASE
                    ).strip()
                    current_typeblock.properties.append(
                        Property(
                            name=pname,
                            type=ptype,
                            description=pdesc_clean,
                            read_only=read_only,
                        )
                    )

            i += 1
            continue

        i += 1

    flush_method()
    flush_enum()
    flush_typeblock()

    # Merge TypeBlocks that only organise main-class methods back into the model.
    # Some pages use h2 sections to group methods of the main class (e.g. component.html).
    bare_title = _bare_name(model.title).lower()
    real_extra: list[TypeBlock] = []
    for tb in model.extra_types:
        sig_classes: set[str] = set()
        for m in tb.methods:
            for sig in m.signatures:
                if sig.class_name:
                    sig_classes.add(
                        _bare_name(_sanitise_type_name(sig.class_name)).lower()
                    )
        if sig_classes and all(c == bare_title for c in sig_classes):
            # TypeBlock only organises the main class; absorb into model
            model.properties.extend(tb.properties)
            model.methods.extend(tb.methods)
        else:
            real_extra.append(tb)
    model.extra_types = real_extra

    return model


def _bare_name(name: str) -> str:
    """Return the last dotted segment, e.g. 'ui.Component' gives 'Component'."""
    return name.rsplit(".", 1)[-1] if name else name


# PageModel to Lua stubs

_TYPE_NORMALISE = {
    "Integer": "Int",
    "Boolean": "Bool",
    "Number": "Float",
}


def _lua_type(t: str) -> str:
    if not t:
        return "any"
    t = t.strip()

    # Docs use a bare "?" for genuinely dynamic/varies-per-instance types
    # (e.g. Enum/DBRow/DBTable generic value accessors) - not valid LuaLS syntax.
    if t == "?":
        return "any"
    if t == "?[]":
        return "any[]"

    # A trailing "?" marks a nullable/optional type; normalise the base type
    # first, then re-attach the "?" (e.g. "Boolean?" -> "Bool" -> "Bool?").
    # Skip this when a top-level "/" is present - the union-splitting branch
    # below handles trailing "?" on unions itself (emitting an explicit "nil"
    # member instead of a trailing "?").
    if t.endswith("?") and t != "?" and "/" not in t:
        return _lua_type(t[:-1]) + "?"

    # Filter clearly invalid type names (e.g. stray code-fence markers)
    if t.startswith("`"):
        return "any"

    # "function (...) -> Type" prose notation (used for callback params)
    # becomes proper LuaLS fun(...):Type syntax.
    m = re.match(r"^function\s*\((.*)\)\s*->\s*(.+)$", t, re.DOTALL)
    if m:
        params_part = m.group(1).strip()
        ret_part = _lua_type(m.group(2).strip())
        return f"fun({params_part}):{ret_part}"

    # Strip generic type parameters like <T>, <T?>, <Type> etc.
    # (LuaLS doesn't support Lua-level generics; stripping avoids undefined-type warnings.)
    if "<" in t:
        t = re.sub(r"<[^>]*>", "", t).strip()

    # Slash-separated union T1/T2/T3 becomes T1|T2|T3 (top level only)
    if "/" in t:
        depth = 0
        slash_positions: list[int] = []
        for idx, ch in enumerate(t):
            if ch in "({[<":
                depth += 1
            elif ch in ")}]>":
                depth -= 1
            elif ch == "/" and depth == 0:
                slash_positions.append(idx)
        if slash_positions:
            parts = []
            nullable = False
            prev = 0
            for pos in slash_positions:
                token = t[prev:pos].strip()
                if token.endswith("?"):
                    nullable = True
                    token = token[:-1].strip()
                parts.append(_lua_type(token))
                prev = pos + 1
            token = t[prev:].strip()
            if token.endswith("?"):
                nullable = True
                token = token[:-1].strip()
            parts.append(_lua_type(token))
            # A trailing '?' on any union member means the whole can be nil;
            # emit explicit |nil rather than attaching '?' to the last type only.
            if nullable:
                parts.append("nil")
            return "|".join(parts)

    # RS map notation { K -> V } becomes table<K, V>
    m = re.match(r"^\{\s*(.+?)\s*->\s*(.+?)\s*\}$", t, re.DOTALL)
    if m:
        k_type = _lua_type(m.group(1).strip())
        v_type = _lua_type(m.group(2).strip())
        return f"table<{k_type}, {v_type}>"

    # RS array notation [Type] becomes Type[] ([ Type, ... ] case handled upstream)
    m = re.match(r"^\[\s*(.+?)\s*\]$", t)
    if m:
        inner = m.group(1).strip()
        # strip spaces from inner type (e.g. "Combo Entry" -> "ComboEntry")
        inner = re.sub(r"\s+", "", inner)
        return f"{_lua_type(inner)}[]"

    # (T1, T2) tuple notation becomes {[1]: T1, [2]: T2} (LuaLS indexed tuple)
    m = re.match(r"^\((.+)\)$", t, re.DOTALL)
    if m:
        parts = [_lua_type(p.strip()) for p in m.group(1).split(",")]
        return "{" + ", ".join(f"[{i + 1}]: {p}" for i, p in enumerate(parts)) + "}"

    return _TYPE_NORMALISE.get(t, t)


def _coerce_prop_type(raw_type: str, raw_desc: str) -> tuple[str, str]:
    """Detect when a description was placed in the Type column and fix it.

    Some HTML pages have rows where the Type cell contains a sentence
    (e.g. "True if this sound is currently paused.").  When that happens,
    move the text to the description and infer a sensible type.
    """
    if not raw_type:
        return raw_type, raw_desc
    # Some rows have no real type at all - just a "(Read-only)"/"(Writable)"
    # marker (a data gap in the source docs). There's no type to preserve;
    # fall through to the sentence-inference logic below, which emits "any"
    # and keeps the marker text in the description (where read_only detection
    # already looks for it).
    is_bare_marker = bool(
        re.fullmatch(r"\(?\s*(read-only|writable)\s*\)?", raw_type.strip(), re.IGNORECASE)
    )
    if not is_bare_marker and " " not in raw_type:
        return raw_type, raw_desc
    # "X of Y" is always prose (e.g. "Array of Integer", "Array of [ ?, ? ]")
    # even when Y itself contains bracket/generic characters - move to
    # description and fall through to the sentence-inference logic below.
    if not is_bare_marker and not re.search(r"\bof\b", raw_type, re.IGNORECASE):
        # Legitimate multi-word type notations contain these characters
        if any(c in raw_type for c in "/{[(<->"):
            return raw_type, raw_desc
    # Type looks like a sentence – move to description
    combined = (raw_type + " " + raw_desc).strip() if raw_desc else raw_type
    low = raw_type.lower()
    if low.startswith(("true ", "false ")):
        return "boolean", combined
    return "any", combined


def _desc_lines(desc: str) -> list[str]:
    """Convert description text to ---comment lines."""
    if not desc:
        return []
    lines = []
    for line in desc.splitlines():
        line = line.strip()
        if line:
            lines.append(f"---{line}")
    return lines


def _enum_key(name: str) -> str:
    """Return the table key for an enum member, quoting Lua reserved words."""
    return f'["{name}"]' if name in LUA_KEYWORDS else name


def _render_enum(enum: Enum) -> list[str]:
    out: list[str] = []
    if enum.description:
        out.extend(_desc_lines(enum.description))
    if enum.is_int_enum:
        # Use ---@enum for integer enums — generates a proper table
        out.append(f"---@enum {enum.name}")
        out.append(f"{enum.name} = {{")
        for v in enum.values:
            val = v.value if v.value else "0"
            out.append(f"    {_enum_key(v.name)} = {val},")
        out.append("}")
    else:
        # Use ---@enum with string values so both the type annotation AND
        # table-field access (e.g. PluginPermissions.httpAccess) work.
        out.append(f"---@enum {enum.name}")
        out.append(f"{enum.name} = {{")
        for v in enum.values:
            desc = f" -- {v.description}" if v.description else ""
            out.append(f'    {_enum_key(v.name)} = "{v.name}",{desc}')
        out.append("}")
    out.append("")
    return out


def _render_overload(sig: Signature) -> str:
    parts = []
    # For method overloads (`:` separator), LuaLS requires an explicit `self`
    # parameter in the fun(...) type so argument counts are correct.
    if sig.separator == ":" and sig.class_name:
        parts.append(f"self: {_sanitise_type_name(sig.class_name)}")
    for p in sig.params:
        if p.name == "...":
            parts.append(f"...: {_lua_type(p.type)}")
        else:
            parts.append(f"{p.name}: {_lua_type(p.type)}")
    params_str = ", ".join(parts)
    ret_str = ""
    if sig.returns:
        ret_str = ": " + ", ".join(_lua_type(r.type) for r in sig.returns)
    return f"---@overload fun({params_str}){ret_str}"


def _render_method(method: Method) -> list[str]:
    if not method.signatures:
        return []

    # When a single heading covers multiple distinct functions (e.g. "Get/Post"),
    # each distinct method_name must become its own function stub, not an @overload.
    names_seen: list[str] = []
    by_name: dict[str, list[Signature]] = {}
    for sig in method.signatures:
        key = sig.method_name
        if key not in by_name:
            names_seen.append(key)
        by_name.setdefault(key, []).append(sig)

    if len(by_name) > 1:
        out: list[str] = []
        for idx, name in enumerate(names_seen):
            sub = Method(
                name=name,
                # Share description on first function only to avoid duplication
                description=method.description if idx == 0 else "",
                signatures=by_name[name],
            )
            out.extend(_render_method(sub))
        return out

    out: list[str] = []
    if method.description:
        out.extend(_desc_lines(method.description))

    primary = method.signatures[0]

    # Emit overloads for additional signatures
    for sig in method.signatures[1:]:
        out.append(_render_overload(sig))

    # Emit params and returns for the primary signature
    for p in primary.params:
        t = _lua_type(p.type)
        desc = f" {p.description}" if p.description else ""
        if p.name == "...":
            # Vararg: LuaLS expects  ---@param ... <type>  (no named identifier)
            out.append(f"---@param ... {t}{desc}")
        else:
            out.append(f"---@param {p.name} {t}{desc}")
    for r in primary.returns:
        t = _lua_type(r.type)
        desc = f" {r.description}" if r.description else ""
        out.append(f"---@return {t}{desc}")

    # Function stub — vararg params must appear as '...' in the signature
    params = ", ".join(p.name for p in primary.params)
    class_part = _sanitise_type_name(primary.class_name)
    if class_part:
        func_name = f"{class_part}{primary.separator}{primary.method_name}"
    else:
        func_name = primary.method_name
    out.append(f"function {func_name}({params}) end")
    out.append("")
    return out


def _synth_new_method(safe_class_name: str) -> Method:
    """Build a synthetic zero-arg `.new()` constructor Method for a class only
    ever seen constructed inside example code (see `example_constructors`)."""
    sig = Signature(
        raw="",
        class_name=safe_class_name,
        method_name="new",
        separator=".",
        returns=[ReturnVal(type=safe_class_name)],
    )
    return Method(name="new", signatures=[sig])


def _render_class(
    name: str,
    overview: str,
    properties: list[Property],
    methods: list[Method],
    seen_namespaces: Optional[set] = None,
    *,
    annotation_name: str = "",
    parent_class: str = "",
) -> list[str]:
    """Render a class block.

    ``annotation_name`` (optional) is used for the ``---@class`` tag and must
    be the fully-qualified type name (e.g. ``ui.ComponentCollection``).
    ``name`` is used for the Lua variable declaration and must match what the
    parsed function-signature class names look like (bare or qualified).

    When the two differ (e.g. annotation ``ui.Layer``, var ``Layer``), LuaLS
    types the bare global as the qualified class, so methods defined on the
    bare name are correctly attached to the qualified type.

    When both are the same qualified name (e.g. ``ui.Pos`` from both title and
    signatures), a bare ``---@alias Pos ui.Pos`` is also emitted so that
    annotations referencing the short form still resolve.
    """
    safe_name = _sanitise_type_name(name)
    safe_ann = _sanitise_type_name(annotation_name) if annotation_name else safe_name

    out: list[str] = []
    # Declare top-level namespace table so LuaLS doesn't flag it as undefined.
    ns_source = safe_ann if "." in safe_ann else safe_name
    parts = ns_source.split(".")
    if len(parts) > 1:
        ns = parts[0]
        if seen_namespaces is None or ns not in seen_namespaces:
            out.append(f"---@class {ns}")
            out.append(f"{ns} = {{}}")
            out.append("")
            if seen_namespaces is not None:
                seen_namespaces.add(ns)

    if overview:
        out.extend(_desc_lines(overview))
    parent_suffix = f" : {_sanitise_type_name(parent_class)}" if parent_class else ""
    out.append(f"---@class {safe_ann}{parent_suffix}")
    for prop in properties:
        t = _lua_type(prop.type)
        desc = prop.description
        if prop.read_only:
            desc = f"(Read-only) {desc}".strip()
        desc_part = f" {desc}" if desc else ""
        out.append(f"---@field {prop.name} {t}{desc_part}")
    out.append(f"{safe_name} = {{}}")
    out.append("")

    # When the variable uses the full qualified name (e.g. ui.Pos = {}) the
    # bare name (Pos) isn't declared as a global, so emit an alias so that
    # annotations using the short form still resolve.
    if safe_name == safe_ann and "." in safe_ann:
        bare = _bare_name(safe_ann)
        out.append(f"---@alias {bare} {safe_ann}")
        out.append("")

    for m in methods:
        out.extend(_render_method(m))
    return out


# core/events.html special-case
#
# The Event global is a bus of named channels (Event.ChatMessage, Event.Logic,
# ...), each carrying its own payload type and - for EntityDraw only - a
# meaningful callback return value. That shape (a generic EventSubscription<T,
# RetT> wrapper) has no analogue anywhere else in the docs, and each event's
# payload is documented with a "Payload variable / Type / Writeable /
# Description" table that no other page uses. Rather than bending the shared
# TypeBlock state machine (used by ~50 other pages) to fit this one page,
# events.html is walked and rendered by hand below.


def _split_br_cell(td: Node) -> list[str]:
    """Split a table cell into segments separated by <br> tags.

    A payload table row occasionally documents several fields at once (e.g.
    EntityDraw's npcEntity/playerEntity/objStackEntity row) or a multi-line
    union type (e.g. VarTransmit's Integer/String value columns).
    """
    segments: list[str] = []
    current: list[str] = []

    def flush():
        joined = "".join(current).strip()
        if joined:
            segments.append(joined)
        current.clear()

    for c in td.children:
        if isinstance(c, str):
            current.append(c)
        elif c.tag == "br":
            flush()
        else:
            current.append(c.text())
    flush()
    return segments or [td.text()]


def _events_writeable(td: Node) -> tuple[bool, str]:
    """Read the Events page's icon-based Writeable column.

    A check-mark icon means the field can be written to from a callback; an
    X means it can't. A couple of rows hold prose instead of an icon (e.g.
    "Using Swap()"), which is kept as a note rather than force-fit into a
    plain boolean.
    """
    svg = td.find("svg")
    if svg is not None:
        return ("lucide-check" not in svg.cls, "")
    text = td.text()
    return (True, text) if text else (True, "")


def _admonition_text(node: Node) -> str:
    """Body text of an admonition div, skipping its title paragraph."""
    parts = [p.text() for p in node.find_all("p") if "admonition-title" not in p.cls]
    return " ".join(p for p in parts if p)


def _h2_section_paragraphs(article: Node, heading_text: str) -> list[str]:
    """Top-level <p> text under the given H2 heading (until the next H2)."""
    texts: list[str] = []
    capture = False
    for n in _child_nodes(article):
        if n.tag == "h2":
            capture = n.text().replace("¶", "").strip().lower() == heading_text
            continue
        if capture and n.tag == "p":
            t = n.text()
            if t:
                texts.append(t)
    return texts


def _parse_supported_events(article: Node) -> list[dict]:
    """Parse the 'Supported events' H2 section of core/events.html.

    Returns an ordered list of {name, description, properties} dicts, one
    per H3 event (e.g. ChatMessage, EntityDraw, ...).
    """
    children = _child_nodes(article)
    start = None
    for idx, n in enumerate(children):
        if n.tag == "h2" and n.text().replace("¶", "").strip().lower() == "supported events":
            start = idx + 1
            break
    if start is None:
        return []

    events: list[dict] = []
    current: Optional[dict] = None
    for n in children[start:]:
        if n.tag == "h2":
            break
        if n.tag == "h3":
            current = {
                "name": n.text().replace("¶", "").strip(),
                "description": "",
                "properties": [],
            }
            events.append(current)
            continue
        if current is None:
            continue
        if n.tag == "p":
            text = n.text()
            if text:
                current["description"] = f"{current['description']} {text}".strip()
        elif n.tag == "div" and "admonition" in n.cls:
            text = _admonition_text(n)
            if text:
                if "warning" in n.cls:
                    text = f"Warning: {text}"
                current["description"] = f"{current['description']} {text}".strip()
        elif n.tag == "table":
            headers = [h.lower() for h in _table_headers(n)]
            if "payload variable" not in headers:
                continue
            tbody = n.find("tbody")
            if tbody is None:
                continue
            for tr in tbody.find_all("tr"):
                tds = tr.find_all("td")
                if len(tds) < 4:
                    continue
                names = _split_br_cell(tds[0])
                types = _split_br_cell(tds[1])
                read_only, note = _events_writeable(tds[2])
                desc = tds[3].text()
                if note:
                    desc = f"{desc} ({note})".strip()
                if len(names) > 1 and len(names) == len(types):
                    for nm, ty in zip(names, types):
                        current["properties"].append(
                            Property(name=nm, type=ty, description=desc, read_only=read_only)
                        )
                else:
                    current["properties"].append(
                        Property(
                            name=names[0],
                            type="/".join(types),
                            description=desc,
                            read_only=read_only,
                        )
                    )
    return events


def generate_events_lua(html: str) -> str:
    """Generate generated/core/events.lua from site/core/events.html.

    Reuses the generic ``extract_page`` pass for the page's enums (EntityType,
    ChatType, GameState) and overview text, which already parse correctly
    through the shared pipeline, then hand-renders the Event bus, the generic
    EventSubscription<T, RetT> wrapper, and each event's payload class.
    """
    model = extract_page(html, "core/events.html")
    root = parse_dom(html)
    article = _article(root)
    if article is None:
        return ""
    events = _parse_supported_events(article)

    out: list[str] = ["---@meta", ""]
    for enum in model.enums:
        out.extend(_render_enum(enum))

    payload_intro = _h2_section_paragraphs(article, "event payloads")
    out.extend(_desc_lines("\n".join(payload_intro)))
    out.append("---@class EventSubscription<T, RetT>")
    out.append("---@field Subscribe fun(name: string, callback: fun(event: T): RetT)")
    out.append("---@field Unsubscribe fun(name: string)")
    out.append("EventSubscription = {}")
    out.append("")

    seen_namespaces: set = set()
    field_lines: list[str] = []
    for ev in events:
        payload_type = "nil"
        if ev["properties"]:
            payload_type = ev["name"]
            out.extend(
                _render_class(
                    ev["name"], ev["description"], ev["properties"], [], seen_namespaces
                )
            )
        # EntityDraw is the only documented event whose callback return value
        # is meaningful (it decides whether the entity continues drawing);
        # every other event's callback return is unused.
        ret_type = "boolean" if ev["name"] == "EntityDraw" else "nil"
        first_sentence = ev["description"].split(". ")[0].strip()
        if first_sentence and not first_sentence.endswith("."):
            first_sentence += "."
        desc_part = f" {first_sentence}" if first_sentence else ""
        field_lines.append(
            f"---@field {ev['name']} EventSubscription<{payload_type}, {ret_type}>{desc_part}"
        )

    if model.overview:
        out.extend(_desc_lines(model.overview))
    out.append("---@class Event")
    out.extend(field_lines)
    out.append("Event = {}")
    out.append("")

    return "\n".join(out).rstrip() + "\n"


def generate_lua(model: PageModel) -> str:
    out: list[str] = ["---@meta", ""]

    has_content = model.enums or model.methods or model.properties or model.extra_types
    if not has_content:
        return ""

    # A page's own "Enumerations" section can name an enum the same as the
    # page's root class (e.g. questtype.html's root class QuestType also has
    # an enum literally titled "QuestType" listing quest categories). The
    # enum is a real global table plugin code executes against directly
    # (e.g. QuestType.NORMAL), so it must keep that exact name. The class
    # annotation, in contrast, only ever appears inside `---@` doc comments -
    # it's never typed as a runtime identifier itself (code uses the shorter
    # bound global, e.g. Quest) - so it's the safe one to disambiguate.
    root_name = _sanitise_type_name(model.title) if model.title else ""
    class_name_override = ""
    if root_name and any(e.name == root_name for e in model.enums):
        class_name_override = f"{root_name}Config"

    for enum in model.enums:
        out.extend(_render_enum(enum))

    # annotation_class: fully-qualified name for ---@class (from page title)
    # var_class: name in function signatures / Lua variable (dominant sig class)
    annotation_class = class_name_override or (
        _sanitise_type_name(model.title) if model.title else ""
    )
    if not re.match(r"^[A-Za-z_][A-Za-z0-9_.]*$", annotation_class):
        annotation_class = ""

    sig_counter: Counter = Counter()
    for m in model.methods:
        for sig in m.signatures:
            if sig.class_name:
                sig_counter[_sanitise_type_name(sig.class_name)] += 1
    var_class = sig_counter.most_common(1)[0][0] if sig_counter else ""

    # Prefer annotation_class when it appears in signatures to avoid spurious TypeBlocks on a tie.
    if annotation_class and sig_counter.get(annotation_class, 0) > 0:
        var_class = annotation_class

    if not var_class:
        var_class = _bare_name(annotation_class) if annotation_class else ""
    if not annotation_class:
        annotation_class = var_class

    # If title and sigs disagree only in case (e.g. "Audio" vs "audio"), keep sig casing.
    if (
        annotation_class
        and var_class
        and annotation_class.lower() == var_class.lower()
        and annotation_class != var_class
    ):
        annotation_class = var_class

    # If title is the bare name of the qualified sig class (e.g. "Interface" vs "ui.Interface"),
    # use the qualified name so ---@class and variable assignment stay in sync.
    if (
        annotation_class
        and var_class
        and "." in var_class
        and _bare_name(var_class) == annotation_class
    ):
        annotation_class = var_class

    main_class_name = var_class or annotation_class

    # Promote secondary-class methods to synthetic TypeBlocks.
    # Multi-type pages (e.g. common_types.html) have non-dominant classes in
    # model.methods with no declaration; collect them so _render_class emits ---@class.
    if main_class_name:
        primary_methods: list[Method] = []
        secondary_methods: dict[str, list[Method]] = {}
        for m in model.methods:
            cls_set: set[str] = {
                _sanitise_type_name(sig.class_name)
                for sig in m.signatures
                if sig.class_name
            }
            if len(cls_set) == 1:
                cls = next(iter(cls_set))
                if cls != main_class_name:
                    secondary_methods.setdefault(cls, []).append(m)
                    continue
            primary_methods.append(m)
        model.methods = primary_methods
        # Prepend synthetic TypeBlocks so they appear before any existing ones
        for cls, methods in reversed(list(secondary_methods.items())):
            model.extra_types.insert(0, TypeBlock(name=cls, methods=methods))
    seen_namespaces: set[str] = set()
    if main_class_name and (model.properties or model.methods):
        out.extend(
            _render_class(
                main_class_name,
                model.overview,
                model.properties,
                model.methods,
                seen_namespaces,
                annotation_name=annotation_class,
                parent_class=model.parent_class,
            )
        )
        # Prevent secondary TypeBlocks from re-declaring the main class
        # namespace (e.g. audio.SoundInstance re-declaring "audio = {}").
        seen_namespaces.add(main_class_name)
    elif model.methods:
        if model.overview:
            out.extend(_desc_lines(model.overview))
        for m in model.methods:
            out.extend(_render_method(m))

    for cls in model.bare_classes:
        safe = _sanitise_type_name(cls)
        bare = _bare_name(safe)
        out.append(f"---@class {safe}")
        out.append(f"{safe} = {{}}")
        out.append("")
        if bare != safe:
            out.append(f"---@alias {bare} {safe}")
            out.append("")
        if safe in model.example_constructors:
            out.extend(_render_method(_synth_new_method(safe)))

    for tb in model.extra_types:
        for enum in tb.enums:
            out.extend(_render_enum(enum))
        safe_tb = _sanitise_type_name(tb.name)
        has_new = any(
            sig.method_name == "new" for m in tb.methods for sig in m.signatures
        )
        if not has_new and safe_tb in model.example_constructors:
            tb.methods.append(_synth_new_method(safe_tb))
        if tb.properties or tb.methods:
            out.extend(
                _render_class(
                    tb.name, tb.description, tb.properties, tb.methods, seen_namespaces
                )
            )

    # Strip trailing blank lines and ensure single trailing newline
    text = "\n".join(out).rstrip() + "\n"
    return text


# File walking & entry-point

# Root-level files to skip (by name only when at the top of site_dir)
ROOT_SKIP_FILES = {
    "404.html",
    "index.html",
    "search.json",
    "sitemap.xml",
    "cheats.html",
    "quickstart.html",
    "coord_system.html",
}

# Narrative/guide pages to skip regardless of directory (by path relative to
# site_dir, POSIX-style). These are prose walkthroughs, not formal API
# reference pages, so the state-machine extractor has nothing real to find
# and only mistakes heading text (e.g. "Registering Shapes") for class/type
# names. The actual API they describe lives on a separate reference page
# (e.g. game/shapes.html points readers at game/list/shapelist.html).
SKIP_FILES = {
    "game/shapes.html",
}


def _detect_skipped_globals(
    html: str, known_names: set[str], full_page: bool = False
) -> list[Method]:
    """
    Detect global functions described in prose (not formal API reference markup).

    Pass 1: find <p> elements containing a bare <code>name</code> element (no
    class attribute) where the paragraph also contains the word "function".
    Pass 2: infer param types from any Lua code block (inline <code> or hoisted
    <div class="language-lua">) that calls one of the detected candidates.

    When `full_page` is True (whole-page narrative docs, e.g. an old-style
    quickstart/cheats page that is skipped from formal generation entirely),
    the whole article is scanned. Otherwise this only looks inside h2 sections
    that the formal extractor itself treats as non-API prose (SKIP_SECTIONS,
    e.g. "Dependencies"/"Notes") - narrative walkthroughs (tutorial pages) have
    real h2 sections full of example code/variable names that would otherwise
    be mistaken for engine globals.
    """
    root = parse_dom(html)
    article = _article(root)
    if article is None:
        return []

    children = _flatten_article_nodes(article)
    candidates: dict[str, dict] = {}  # name: {description, params}

    # Pass 1: prose mention detection
    section_h2 = ""
    for node in children:
        if node.tag == "h2":
            section_h2 = node.text().replace("¶", "").strip().lower()
            continue
        if node.tag != "p":
            continue
        if not full_page and not _is_skip_section(section_h2):
            continue
        p_text = node.text()
        if not p_text or "function" not in p_text:
            continue
        for code_el in node.find_children(tag="code"):
            if code_el.cls:
                continue  # skip language-tagged inline examples
            name = code_el.text().strip()
            if (
                re.match(r"^[a-z_]\w*$", name)
                and name not in known_names
                and name not in candidates
            ):
                candidates[name] = {"description": p_text, "params": []}

    if not candidates:
        return []

    # Pass 2: param inference from Lua code blocks (inline or hoisted)
    for node in children:
        lua_els: list[Node] = []
        if node.tag == "p":
            lua_els = [
                c for c in node.find_children(tag="code") if "language-lua" in c.cls
            ]
        elif node.tag == "div" and "language-lua" in node.cls:
            lua_els = [node]
        for code_el in lua_els:
            for nb_span in code_el.find_all("span", "nb"):
                fname = nb_span.text().strip()
                if fname not in candidates or candidates[fname]["params"]:
                    continue
                params = []
                for span in code_el.find_all("span"):
                    if "s2" in span.cls or "s1" in span.cls:
                        params.append(Param(name="path", type="string"))
                    elif "mi" in span.cls or "mf" in span.cls:
                        params.append(Param(name="n", type="number"))
                    elif "kc" in span.cls:
                        params.append(Param(name="value", type="boolean"))
                candidates[fname]["params"] = params[:1]

    methods = []
    for name, info in candidates.items():
        m = Method(name=name, description=info["description"])
        sig = Signature(
            raw=f"function {name}(...)", class_name="", method_name=name, separator="."
        )
        sig.params = info["params"]
        sig.returns = [ReturnVal(type="any")]
        m.signatures.append(sig)
        methods.append(m)
    return methods


def should_process(path: Path, site_dir: Path) -> bool:
    if path.suffix != ".html":
        return False
    # Only skip root-level files, not subdirectory index.html pages
    if path.parent == site_dir and path.name in ROOT_SKIP_FILES:
        return False
    if path.relative_to(site_dir).as_posix() in SKIP_FILES:
        return False
    return True


def process_site(site_dir: Path, out_dir: Path, verbose: bool = False):
    all_html_files = sorted(p for p in site_dir.rglob("*.html"))
    html_files = [p for p in all_html_files if should_process(p, site_dir)]
    generated = skipped = 0
    known_names: set[str] = set()

    for html_path in html_files:
        rel = html_path.relative_to(site_dir)
        # Sub-directory index pages get named after their parent folder
        if rel.name == "index.html" and rel.parent != Path("."):
            lua_path = out_dir / rel.parent.with_suffix(".lua")
        else:
            lua_path = out_dir / rel.with_suffix(".lua")

        html = html_path.read_text(encoding="utf-8")

        if rel == Path("core/events.html"):
            lua_code = generate_events_lua(html)
        else:
            model = extract_page(html, str(rel))
            for m in model.methods:
                known_names.add(m.name)
            lua_code = generate_lua(model)

        if not lua_code.strip() or lua_code.strip() == "---@meta":
            if verbose:
                print(f"  skip (empty): {rel}")
            skipped += 1
            continue

        lua_path.parent.mkdir(parents=True, exist_ok=True)
        lua_path.write_text(lua_code, encoding="utf-8")

        if verbose:
            print(f"  wrote: {lua_path.relative_to(out_dir.parent)}")
        generated += 1

    # Detect global functions described only in prose (e.g. "call the require
    # function...") rather than formal API reference markup, and append them
    # to core.lua. This scans every page, not just root-level narrative pages
    # (quickstart/cheats-style) - doc reshuffles can also drop this kind of
    # prose into an otherwise-formal reference page (e.g. a "Dependencies"
    # section on an API page), so relying on a fixed page list is fragile.
    core_lua = out_dir / "core.lua"
    extra_lines: list[str] = []
    for html_path in all_html_files:
        rel = html_path.relative_to(site_dir)
        html_text = html_path.read_text(encoding="utf-8")
        full_page = not should_process(html_path, site_dir)
        extra = _detect_skipped_globals(html_text, known_names, full_page=full_page)
        if not extra:
            continue
        for m in extra:
            extra_lines.append("")
            extra_lines.extend(_render_method(m))
        known_names.update(m.name for m in extra)
        if verbose:
            names = ", ".join(m.name for m in extra)
            print(f"  appended to core.lua from {rel}: {names}")

    if extra_lines and core_lua.exists():
        core_lua.write_text(
            core_lua.read_text(encoding="utf-8").rstrip()
            + "\n"
            + "\n".join(extra_lines)
            + "\n",
            encoding="utf-8",
        )

    print(f"Generated {generated} stub file(s), skipped {skipped}.")


def main():
    site_dir = Path("site")
    out_dir = Path("generated")

    if not site_dir.is_dir():
        os.makedirs(site_dir, exist_ok=True)

    if not out_dir.is_dir():
        os.makedirs(out_dir, exist_ok=True)

    print(f"Reading from: {site_dir.resolve()}")
    print(f"Writing to:   {out_dir.resolve()}")
    process_site(site_dir, out_dir, verbose=True)


if __name__ == "__main__":
    main()
