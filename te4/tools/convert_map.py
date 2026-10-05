"""Convert ToME 3 Earth town maps into ToME 4 static zones.

Source is DBT/data/towns/earthN.map, the map the wilderness loads for that
region. Those files match DBT/data/maps/earthN.map except Earth 5, where the
town file is the city and the maps/ file is an older bordered copy.

Quest branches and on_walk functions are not carried. The default branch of a
quest symbol is used, and a comment in the generated map lists what was left out.
"""

import os
import re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
DBT = os.path.join(ROOT, "DBT", "data")
OUT = os.path.join(ROOT, "te4", "dbt", "data")

REGIONS = {
    1: "Earth, southwest",
    2: "Earth, south",
    3: "Earth, southeast",
    4: "Earth, west",
    5: "Earth",
    6: "Earth, east",
    7: "Earth, northwest",
    8: "Earth, north",
    9: "Earth, northeast",
}

# display, color, back, blocks move, blocks sight
FEATS = {
    "FEAT_GRASS": ("grass", ".", "LIGHT_GREEN", "DARK_GREEN", False, False),
    "FEAT_DIRT": ("dirt", ".", "UMBER", "DARK_UMBER", False, False),
    "FEAT_ASPHALT": ("road", ".", "SLATE", "DARK_GREY", False, False),
    "FEAT_SIDEWALK": ("sidewalk", ".", "WHITE", "DARK_GREY", False, False),
    "FEAT_ROADSTRIPE_VERT": ("road", ".", "YELLOW", "DARK_GREY", False, False),
    "FEAT_ROADSTRIPE_HORZ": ("road", ".", "YELLOW", "DARK_GREY", False, False),
    "FEAT_SHAL_WATER": ("shallow water", "~", "LIGHT_BLUE", "BLUE", False, False),
    "FEAT_SAND": ("sand", ".", "YELLOW", "DARK_UMBER", False, False),
    "FEAT_ASH": ("ash", ".", "SLATE", "DARK_GREY", False, False),
    "FEAT_SNOW": ("snow", ".", "WHITE", "DARK_BLUE", False, False),
    "FEAT_RRA_SNOW": ("snow", ".", "WHITE", "DARK_BLUE", False, False),
    "FEAT_MUSHROOM": ("mushroom", ",", "LIGHT_RED", "DARK_GREEN", False, False),
    "FEAT_SWAMP_POOL": ("swamp", "~", "GREEN", "DARK_GREEN", False, False),
    "FEAT_FLOOR": ("floor", ".", "WHITE", "DARK_GREY", False, False),
    "FEAT_SIGNPOST": ("signpost", "!", "YELLOW", "DARK_UMBER", False, False),
    "FEAT_TONKAN": ("business directory", "!", "YELLOW", "DARK_GREY", False, False),
    "FEAT_STEAM_VENT": ("steam vent", "^", "WHITE", "DARK_GREY", False, False),
    "FEAT_TREES": ("tree", "T", "GREEN", "DARK_GREEN", True, True),
    "FEAT_RRA_TREES": ("tree", "T", "DARK_GREEN", "DARK_UMBER", True, True),
    "FEAT_DECAYING_TREES": ("dead tree", "T", "UMBER", "DARK_UMBER", True, True),
    "FEAT_MOUNTAIN": ("mountain", "^", "WHITE", "DARK_GREY", True, True),
    "FEAT_SNOWY_PEAK": ("snowy peak", "^", "WHITE", "DARK_BLUE", True, True),
    "FEAT_BUILDING": ("building", "#", "WHITE", "DARK_UMBER", True, True),
    "FEAT_DEEP_WATER": ("deep water", "~", "BLUE", "DARK_BLUE", True, False),
    "FEAT_VOLC_LAVA": ("lava", "~", "LIGHT_RED", "RED", True, False),
    "FEAT_KAME_WALL": ("wall", "#", "LIGHT_BLUE", "DARK_BLUE", True, True),
    "FEAT_GLASS_WALL": ("glass wall", "#", "LIGHT_BLUE", "DARK_GREY", True, False),
    "FEAT_WINDOW": ("window", "#", "LIGHT_BLUE", "DARK_UMBER", True, True),
    "FEAT_FENCE_VERT": ("fence", "|", "UMBER", "DARK_GREEN", True, False),
    "FEAT_FENCE_HORZ": ("fence", "-", "UMBER", "DARK_GREEN", True, False),
    "FEAT_KAME_ROOF": ("roof", "#", "LIGHT_RED", "DARK_UMBER", True, True),
    "FEAT_WRAP_BORDER": ("map edge", "*", "DARK_GREY", "BLACK", True, True),
    "FEAT_KARIN_TOWER_EXT": ("tower", "|", "WHITE", "DARK_GREY", True, True),
}

BLOCK_HINTS = ("WALL", "TREE", "MOUNTAIN", "PEAK", "LAVA", "FENCE", "ROOF", "WINDOW", "BUILDING", "DEEP_WATER")


def strip_comments(text):
    out = []
    i = 0
    quote = None
    while i < len(text):
        ch = text[i]
        if quote:
            out.append(ch)
            if ch == "\\" and i + 1 < len(text):
                out.append(text[i + 1])
                i += 2
                continue
            if ch == quote:
                quote = None
            i += 1
            continue
        if ch in ("'", '"'):
            quote = ch
            out.append(ch)
            i += 1
            continue
        if text.startswith("--", i):
            while i < len(text) and text[i] != "\n":
                i += 1
            continue
        out.append(ch)
        i += 1
    return "".join(out)


def brace_end(text, open_at):
    depth = 0
    quote = None
    i = open_at
    while i < len(text):
        ch = text[i]
        if quote:
            if ch == "\\" and quote == '"':
                i += 2
                continue
            if ch == quote:
                quote = None
            i += 1
            continue
        if ch in ("'", '"'):
            quote = ch
        elif ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                return i
        i += 1
    raise ValueError("unbalanced brace at %d" % open_at)


def blocks(text, keyword):
    found = []
    start = 0
    while True:
        at = text.find(keyword, start)
        if at < 0:
            return found
        brace = text.find("{", at)
        if brace < 0:
            return found
        end = brace_end(text, brace)
        found.append(text[brace:end + 1])
        start = end + 1


def field(block, name):
    m = re.search(r"%s\s*=\s*'([^']*)'" % name, block)
    if m:
        return m.group(1)
    m = re.search(r'%s\s*=\s*"([^"]*)"' % name, block)
    if m:
        return m.group(1)
    m = re.search(r"%s\s*=\s*([A-Za-z0-9_\.]+)" % name, block)
    if m:
        return m.group(1)
    return None


def default_branch(block):
    at = block.find("default")
    if at < 0:
        return None
    brace = block.find("{", at)
    if brace < 0:
        return None
    end = brace_end(block, brace)
    return block[brace:end + 1]


def dungeon_names():
    text = open(os.path.join(DBT, "dungeon", "dungeons.lua"), encoding="utf-8", errors="replace").read()
    names = {}
    for m in re.finditer(r'define_as\s*=\s*"(DUNGEON_[A-Z0-9_]+)"', text):
        window = text[m.end():m.end() + 240]
        n = re.search(r'name\s*=\s*"([^"]+)"', window) or re.search(r"name\s*=\s*'([^']+)'", window)
        if n:
            names[m.group(1)] = n.group(1)
    return names


def feat_style(feat):
    if feat in FEATS:
        return FEATS[feat], False
    block = any(hint in feat for hint in BLOCK_HINTS)
    style = (feat.replace("FEAT_", "").lower().replace("_", " "), "?", "WHITE", "DARK_GREY", block, block)
    return style, True


def lua_quote(text):
    return '"' + text.replace("\\", "\\\\").replace('"', '\\"') + '"'


def parse_map(path):
    raw = open(path, encoding="utf-8", errors="replace").read()
    text = strip_comments(raw)
    symbols = {}
    notes = []
    for block in blocks(text, "map.symbol"):
        char = field(block, "symbol")
        if not char or len(char) != 1:
            notes.append("skipped symbol block without a one-character symbol")
            continue
        if "function" in block and not field(block, "on_walk"):
            notes.append("symbol %r has a script that was not carried (%s)" % (char, field(block, "feat")))
        symbols[char] = {
            "feat": field(block, "feat") or "FEAT_FLOOR",
            "dungeon": field(block, "dungeon"),
            "building": field(block, "building"),
            "on_walk": field(block, "on_walk"),
            "monster": field(block, "monster"),
            "name": field(block, "name"),
        }
        if symbols[char]["monster"]:
            notes.append("symbol %r places %s" % (char, symbols[char]["monster"]))
    for block in blocks(text, "map.quest_symbol"):
        char = field(block, "symbol")
        branch = default_branch(block)
        quest = field(block, "quest")
        if not char or not branch:
            notes.append("quest symbol %s had no default branch" % char)
            continue
        symbols[char] = {
            "feat": field(branch, "feat") or "FEAT_FLOOR",
            "dungeon": field(branch, "dungeon"),
            "building": field(branch, "building"),
            "on_walk": field(branch, "on_walk"),
            "monster": field(branch, "monster"),
            "name": field(branch, "name"),
        }
        notes.append("quest %s symbol %r uses the default branch only" % (quest, char))
    rows = re.findall(r"\[\[(.*?)\]\]", text)
    if not rows:
        raise ValueError("no grid in %s" % path)
    width = len(rows[0])
    if any(len(row) != width for row in rows):
        raise ValueError("ragged grid in %s" % path)
    return symbols, rows, notes


def entity_id(spec):
    if spec["dungeon"]:
        return "ENTER_" + spec["dungeon"]
    if spec["building"]:
        return "SHOP_" + re.sub(r"[^A-Za-z0-9]", "_", spec["building"])
    if spec["on_walk"]:
        slug = re.sub(r"[^A-Za-z0-9]+", "_", spec["on_walk"])[:40].strip("_")
        return "NOTE_" + slug
    return spec["feat"]


def walkable(spec, entities):
    ident = entity_id(spec)
    return not entities[ident]["block"]


def choose_start(rows, symbols, entities, prefer):
    height = len(rows)
    width = len(rows[0])
    if prefer:
        for y, row in enumerate(rows):
            for x, ch in enumerate(row):
                spec = symbols.get(ch)
                if spec and spec.get("dungeon") == prefer and walkable(spec, entities):
                    return x, y
    cx, cy = width // 2, height // 2
    best = None
    for y, row in enumerate(rows):
        if y == 0 or y == height - 1:
            continue
        for x, ch in enumerate(row):
            if x == 0 or x == width - 1:
                continue
            spec = symbols.get(ch)
            if not spec or not walkable(spec, entities):
                continue
            dist = abs(x - cx) + abs(y - cy)
            if best is None or dist < best[0]:
                best = (dist, x, y)
    if best:
        return best[1], best[2]
    return 1, 1


def stocked_stores():
    path = os.path.join(OUT, "stores.lua")
    names = {}
    if not os.path.exists(path):
        return names
    text = open(path, encoding="utf-8").read()
    for match in re.finditer(r"^\t([A-Z0-9_]+) = \{\n\t\tname = \"((?:\\.|[^\"])*)\"", text, re.M):
        names[match.group(1)] = match.group(2).replace('\\"', '"')
    return names


STOCKED = {}


def store_id(spec):
    return (spec.get("building") or "").split(".")[-1]


def emit_entity(ident, spec, names):
    if spec["dungeon"]:
        name = spec["name"] or names.get(spec["dungeon"], spec["dungeon"])
        zone = "uranai" if spec["dungeon"] == "DUNGEON_URANAI" else "closed"
        return (
            "newEntity{\n"
            "\tdefine_as = %s,\n"
            "\tname = %s,\n"
            "\tdisplay = '>', color=colors.YELLOW, back_color=colors.DARK_GREEN,\n"
            "\tnotice = true,\n"
            "\talways_remember = true,\n"
            "\tchange_level = 1,\n"
            "\tchange_zone = %s,\n"
            "\tdesc = \"Press > to enter.\",\n"
            "\tshow_tooltip = true,\n"
            "}\n" % (lua_quote(ident), lua_quote(name), lua_quote(zone))
        )
    if spec["building"]:
        sid = store_id(spec)
        label = STOCKED.get(sid) or sid.replace("_", " ")
        if sid in STOCKED:
            return (
                "newEntity{\n"
                "\tdefine_as = %s,\n"
                "\tname = %s,\n"
                "\tdisplay = '+', color=colors.WHITE, back_color=colors.DARK_UMBER,\n"
                "\talways_remember = true,\n"
                "\tnotice = true,\n"
                "\tstore_id = %s,\n"
                "\ton_move = function(self, x, y, who)\n"
                "\t\tif who and who.player and game.enterStore then\n"
                "\t\t\tif who.runStop then who:runStop() end\n"
                "\t\t\tif who.restStop then who:restStop() end\n"
                "\t\t\tgame:enterStore(self.store_id)\n"
                "\t\tend\n"
                "\tend,\n"
                "\tdesc = \"Walk in to shop.\",\n"
                "\tshow_tooltip = true,\n"
                "}\n" % (lua_quote(ident), lua_quote(label), lua_quote(sid))
            )
        return (
            "newEntity{\n"
            "\tdefine_as = %s,\n"
            "\tname = %s,\n"
            "\tdisplay = '+', color=colors.WHITE, back_color=colors.DARK_UMBER,\n"
            "\talways_remember = true,\n"
            "\tdoes_block_move = true,\n"
            "\tblock_sight = true,\n"
            "\tdesc = \"This shop is not open yet.\",\n"
            "\tshow_tooltip = true,\n"
            "}\n" % (lua_quote(ident), lua_quote(label))
        )
    feat = spec["feat"]
    style, unknown = feat_style(feat)
    title, display, color, back, block, sight = style
    if spec["on_walk"]:
        title = "sign"
        display = "!"
        desc = spec["on_walk"]
    else:
        desc = None
    lines = [
        "newEntity{",
        "\tdefine_as = %s," % lua_quote(ident),
        "\tname = %s," % lua_quote(title),
        "\tdisplay = %s, color=colors.%s, back_color=colors.%s," % (lua_quote(display), color, back),
    ]
    if block:
        lines.append("\tdoes_block_move = true,")
    if sight:
        lines.append("\tblock_sight = true,")
    if desc:
        lines.append("\tdesc = %s," % lua_quote(desc))
        lines.append("\tshow_tooltip = true,")
        lines.append("\tnotice = true,")
    lines.append("}")
    return "\n".join(lines) + "\n", unknown


def collect(symbols, entities, unknowns):
    for spec in symbols.values():
        ident = entity_id(spec)
        if ident in entities:
            continue
        if spec["dungeon"] or spec["building"]:
            closed = spec["building"] and store_id(spec) not in STOCKED
            entities[ident] = {"spec": spec, "block": closed and True or False, "unknown": False}
            continue
        style, unknown = feat_style(spec["feat"])
        entities[ident] = {"spec": spec, "block": style[4], "unknown": unknown}
        if unknown:
            unknowns.add(spec["feat"])


def write(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="\n") as handle:
        handle.write(text)


def main():
    global STOCKED
    STOCKED = stocked_stores()
    names = dungeon_names()
    entities = {}
    unknowns = set()
    parsed = {}
    for num in range(1, 10):
        path = os.path.join(DBT, "towns", "earth%d.map" % num)
        symbols, rows, notes = parse_map(path)
        parsed[num] = (symbols, rows, notes)
        collect(symbols, entities, unknowns)

    chunks = [
        "-- Outdoor Earth terrain and entrances. Generated by te4/tools/convert_map.py.\n",
        "-- Shops are closed doors. Dungeons other than Uranai Baba's house use the closed zone.\n\n",
    ]
    for ident in sorted(entities):
        spec = entities[ident]["spec"]
        emitted = emit_entity(ident, spec, names)
        if isinstance(emitted, tuple):
            text, _unknown = emitted
        else:
            text = emitted
        chunks.append(text)
        chunks.append("\n")
    write(os.path.join(OUT, "general", "grids", "earth.lua"), "".join(chunks))

    for num, (symbols, rows, notes) in parsed.items():
        prefer = "DUNGEON_URANAI" if num == 1 else None
        sx, sy = choose_start(rows, symbols, entities, prefer)
        used = []
        seen = set()
        for row in rows:
            for ch in row:
                if ch in seen:
                    continue
                seen.add(ch)
                spec = symbols.get(ch)
                if not spec:
                    raise SystemExit("earth%d uses undefined symbol %r" % (num, ch))
                used.append((ch, entity_id(spec)))
        header = [
            "-- Earth %d, converted from DBT/data/towns/earth%d.map." % (num, num),
            "-- Quest scripts and on_walk functions are not carried.",
        ]
        for note in notes:
            header.append("-- " + note)
        tiles = []
        for ch, ident in used:
            mon = symbols[ch].get("monster")
            if mon:
                tiles.append("defineTile(%s, %s, nil, %s)" % (lua_quote(ch), lua_quote(ident), lua_quote(mon)))
            else:
                tiles.append("defineTile(%s, %s)" % (lua_quote(ch), lua_quote(ident)))
        body = "\n".join(rows)
        if "]]" in body:
            raise SystemExit("earth%d grid contains ]]" % num)
        map_lua = "\n".join(header) + "\n\n" + "\n".join(tiles) + "\n\n"
        map_lua += "startx = %d\nstarty = %d\nendx = %d\nendy = %d\n\n" % (sx, sy, sx, sy)
        map_lua += "return [[\n" + body + "]]\n"
        zone = (
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
            "}\n" % (lua_quote(REGIONS[num]), len(rows[0]), len(rows))
        )
        zone_dir = os.path.join(OUT, "zones", "earth%d" % num)
        write(os.path.join(zone_dir, "zone.lua"), zone)
        write(os.path.join(zone_dir, "grids.lua"),
              'load("/data/general/grids/basic.lua")\nload("/data/general/grids/earth.lua")\n')
        write(os.path.join(zone_dir, "npcs.lua"), 'load("/data/general/npcs/earth.lua")\n')
        write(os.path.join(zone_dir, "objects.lua"), "-- Objects carried at birth are loaded separately.\n")
        write(os.path.join(zone_dir, "traps.lua"), "-- No traps on the Earth overworld.\n")
        write(os.path.join(zone_dir, "maps", "map.lua"), map_lua)
        print("earth%d %dx%d start %d,%d notes %d" % (num, len(rows[0]), len(rows), sx, sy, len(notes)))

    def edge_list(num, axis):
        symbols, rows, _notes = parsed[num]
        height = len(rows)
        width = len(rows[0])

        def blocked(x, y):
            return entities[entity_id(symbols[rows[y][x]])]["block"]

        vals = []
        if axis == "n":
            for x in range(width):
                found = 0
                for y in range(1, min(21, height - 1)):
                    if not blocked(x, y):
                        found = y
                        break
                vals.append(found)
        elif axis == "s":
            for x in range(width):
                found = 0
                for dist in range(1, 21):
                    y = height - 1 - dist
                    if y <= 0:
                        break
                    if not blocked(x, y):
                        found = y
                        break
                vals.append(found)
        elif axis == "w":
            for y in range(height):
                found = 0
                for x in range(1, min(21, width - 1)):
                    if not blocked(x, y):
                        found = x
                        break
                vals.append(found)
        else:
            for y in range(height):
                found = 0
                for dist in range(1, 21):
                    x = width - 1 - dist
                    if x <= 0:
                        break
                    if not blocked(x, y):
                        found = x
                        break
                vals.append(found)
        return "{" + ",".join(str(v) for v in vals) + "}"

    edge_lines = ["-- Arrival coordinates for crossings between Earth regions. 0 means blocked.\n", "earth_edges = {\n"]
    for num in range(1, 10):
        edge_lines.append("\tearth%d = {\n" % num)
        for axis in ("n", "s", "w", "e"):
            edge_lines.append("\t\t%s = %s,\n" % (axis, edge_list(num, axis)))
        edge_lines.append("\t},\n")
    edge_lines.append("}\n")
    write(os.path.join(OUT, "earth_edges.lua"), "".join(edge_lines))

    if unknowns:
        print("UNKNOWN FEATS")
        for feat in sorted(unknowns):
            print(" ", feat)
    else:
        print("no unknown feats")


if __name__ == "__main__":
    main()
