"""Build the six dojo duel zones and the closed-school cap steps."""
import os
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DBT = ROOT / "DBT"
OUT = ROOT / "te4" / "dbt" / "data"

DOJOS = [
    ("d_kara.map", "dojo_kara", "Karate Dojo"),
    ("d_kick.map", "dojo_kick", "Kickboxing Gym"),
    ("d_kung.map", "dojo_kung", "Kung Fu School"),
    ("d_fence.map", "dojo_fence", "Fencing School"),
    ("d_sumo.map", "dojo_sumo", "Sumo Dojo"),
    ("d_judo.map", "dojo_judo", "Judo Dojo"),
]

FEATS = {
    "FEAT_FLOOR": "FLOOR",
    "FEAT_MAP_BORDER": "MAP_BORDER",
    "FEAT_PERMA_WALL": "WALL",
    "FEAT_GREEN_CARPET": "CARPET_GREEN",
    "FEAT_BLUE_CARPET": "CARPET_BLUE",
    "FEAT_DOOR": "DOOR",
    "FEAT_MIRROR": "WALL",
    "FEAT_GLASS_WALL": "WALL",
    "FEAT_LESS": "UP_DOJO",
    "FEAT_SIGNPOST": "FLOOR",
    "FEAT_SAND": "SAND",
    "FEAT_DISQUALIFIED": "SAND",
    "FEAT_FURNITURE": "FLOOR",
    "FEAT_JAPANESE_BATH": "WATER",
    "FEAT_SHOWER": "FLOOR",
    "FEAT_LADDER_RIGHT": "FLOOR",
    "FEAT_DOOR_LOCKED_HEAD+6": "WALL",
}

SKILLS = {
    "SKILL_MARTIALARTS": "martialarts",
    "SKILL_HAND": "hand",
    "SKILL_WEAPONS": "weapons",
    "SKILL_STRENGTH": "strength",
    "SKILL_DEXTERITY": "dexterity",
    "SKILL_PARRYING": "parrying",
    "SKILL_PAIRED": "paired",
    "SKILL_SPEED": "speed",
    "SKILL_CONSTITUTION": "constitution",
    "SKILL_DODGE": "dodge",
    "SKILL_STEALTH": "stealth",
    "SKILL_THROWING": "throwing",
    "SKILL_MARKSMANSHIP": "marksmanship",
    "SKILL_BLOCKING": "blocking",
}


def strip_comments(src):
    out = []
    i = 0
    n = len(src)
    while i < n:
        if src.startswith("--[[", i):
            j = src.find("]]", i + 4)
            i = n if j < 0 else j + 2
            continue
        if src.startswith("--", i):
            j = src.find("\n", i)
            i = n if j < 0 else j
            continue
        out.append(src[i])
        i += 1
    return "".join(out)


def matching_brace(text, open_at):
    depth = 0
    i = open_at
    while i < len(text):
        c = text[i]
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return len(text) - 1


def field(block, key):
    m = re.search(r"\b" + key + r"\s*=\s*\"((?:\\.|[^\"])*)\"", block)
    if m:
        return m.group(1)
    m = re.search(r"\b" + key + r"\s*=\s*'((?:\\.|[^'])*)'", block)
    if m:
        return m.group(1)
    m = re.search(r"\b" + key + r"\s*=\s*([A-Za-z0-9_+]+)", block)
    if m:
        return m.group(1)
    return None


def lua_quote(text):
    return '"' + text.replace("\\", "\\\\").replace('"', '\\"') + '"'


def parse_map(path):
    raw = path.read_text(encoding="utf-8", errors="replace")
    map_at = raw.find("map.map")
    head = strip_comments(raw[:map_at] if map_at >= 0 else raw)
    symbols = {}
    i = 0
    while True:
        j = head.find("map.symbol", i)
        if j < 0:
            break
        brace = head.find("{", j)
        end = matching_brace(head, brace)
        block = head[brace:end + 1]
        char = field(block, "symbol")
        if char and len(char) == 1:
            symbols[char] = {
                "feat": field(block, "feat") or "FEAT_FLOOR",
                "monster": field(block, "monster"),
                "on_walk": field(block, "on_walk"),
            }
        i = end + 1
    grid_src = raw[map_at:] if map_at >= 0 else raw
    rows = re.findall(r"\[\[(.*?)\]\]", grid_src)
    if not rows:
        raise SystemExit("no grid in %s" % path)
    lines = rows
    width = len(lines[0])
    if any(len(ln) != width for ln in lines):
        raise SystemExit("ragged grid in %s" % path.name)
    return symbols, lines


def slug(text):
    return re.sub(r"[^A-Za-z0-9]+", "_", text).strip("_")[:40] or "NOTE"


def write_zone(src_name, zone, title):
    symbols, lines = parse_map(DBT / "data" / "maps" / src_name)
    extras = []
    tiles = []
    used = []
    seen = set()
    start = (1, 1)
    for y, row in enumerate(lines):
        for x, ch in enumerate(row):
            if ch == "<":
                start = (x, y)
            if ch in seen:
                continue
            seen.add(ch)
            spec = symbols.get(ch)
            if not spec:
                raise SystemExit("%s uses undefined symbol %r" % (src_name, ch))
            feat = FEATS.get(spec["feat"], "FLOOR")
            if spec["feat"] not in FEATS:
                print("unknown feat", spec["feat"], "in", src_name)
            ident = feat
            if spec["on_walk"]:
                ident = "SIGN_" + slug(spec["on_walk"])
                extras.append(
                    "newEntity{\n"
                    "\tdefine_as = %s,\n"
                    "\tname = \"sign\",\n"
                    "\tdisplay = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,\n"
                    "\tnotice = true,\n"
                    "\tdesc = %s,\n"
                    "\tshow_tooltip = true,\n"
                    "}\n" % (lua_quote(ident), lua_quote(spec["on_walk"]))
                )
            if spec["monster"]:
                tiles.append("defineTile(%s, %s, nil, %s)" % (lua_quote(ch), lua_quote(ident), lua_quote(spec["monster"])))
            else:
                tiles.append("defineTile(%s, %s)" % (lua_quote(ch), lua_quote(ident)))
    zone_dir = OUT / "zones" / zone
    (zone_dir / "maps").mkdir(parents=True, exist_ok=True)
    grids = 'load("/data/general/grids/basic.lua")\n'
    if extras:
        grids += "\n" + "\n".join(extras)
    (zone_dir / "grids.lua").write_text(grids, encoding="utf-8", newline="\n")
    (zone_dir / "npcs.lua").write_text('load("/data/general/npcs/earth.lua")\n', encoding="utf-8", newline="\n")
    (zone_dir / "objects.lua").write_text("-- The dojo floor has no loose objects.\n", encoding="utf-8", newline="\n")
    (zone_dir / "traps.lua").write_text("-- No traps.\n", encoding="utf-8", newline="\n")
    (zone_dir / "zone.lua").write_text(
        "return {\n"
        "\tname = %s,\n"
        "\tlevel_range = {1, 1},\n"
        "\tmax_level = 1,\n"
        "\twidth = %d, height = %d,\n"
        "\tall_remembered = true,\n"
        "\tall_lited = true,\n"
        "\tpersistent = \"zone\",\n"
        "\tgenerator = {\n"
        "\t\tmap = {\n"
        "\t\t\tclass = \"engine.generator.map.Static\",\n"
        "\t\t\tmap = \"!map\",\n"
        "\t\t},\n"
        "\t},\n"
        "}\n" % (lua_quote(title), len(lines[0]), len(lines)),
        encoding="utf-8", newline="\n",
    )
    body = "\n".join(lines)
    (zone_dir / "maps" / "map.lua").write_text(
        "-- %s, from DBT/data/maps/%s.\n\n%s\n\nstartx = %d\nstarty = %d\nendx = %d\nendy = %d\n\nreturn [[%s]]\n"
        % (title, src_name, "\n".join(tiles), start[0], start[1], start[0], start[1], body),
        encoding="utf-8", newline="\n",
    )
    print(zone, len(lines[0]), "x", len(lines), "start", start)


def cap_steps():
    text = strip_comments((DBT / "scripts" / "enroll.lua").read_text(encoding="utf-8", errors="replace"))
    parts = re.split(r"elseif which == FLAG_|if which == FLAG_", text)
    steps = {}
    for part in parts[1:]:
        school = re.match(r"([A-Z0-9_]+)", part)
        if not school:
            continue
        school = school.group(1)
        if school.startswith("ENROLL_"):
            continue
        found = {}
        for skill_m in re.finditer(r'\["skill"\]\s*=\s*(SKILL_[A-Z0-9_]+)', part):
            skill = SKILLS.get(skill_m.group(1))
            if not skill:
                continue
            window = part[skill_m.end():skill_m.end() + 700]
            cap = re.search(
                r'return\s+(\d+)\s+else\s+return\s+\d+\s*\+\s*\((\d+)\s*\*',
                window,
            )
            if cap:
                found[skill] = int(cap.group(2))
        if found:
            steps[school] = found
    lines = ["-- Cap added per closed school once that school's master has raised the trainer flag.\n", "dbt_cap_step = {\n"]
    for school in sorted(steps):
        bits = ", ".join("%s=%d" % (skill, steps[school][skill]) for skill in sorted(steps[school]))
        lines.append("\t%s = { %s },\n" % (school, bits))
    lines.append("}\n")
    path = OUT / "dojo_caps.lua"
    path.write_text("".join(lines), encoding="utf-8", newline="\n")
    print("caps", path)


def main():
    for src, zone, title in DOJOS:
        write_zone(src, zone, title)
    cap_steps()


if __name__ == "__main__":
    main()
