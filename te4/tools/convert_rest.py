"""Remaining static maps and the generated floors between them."""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import convert_houses as H

ROOT = H.ROOT
DBT = H.DBT
OUT = H.OUT
MAPS = DBT / "data" / "maps"
TOWNS = DBT / "data" / "towns"

H.FEATS.update({
    "FEAT_SKY": "SKY",
    "FEAT_AESTHETIC_SPACE": "SPACE",
    "FEAT_DEEP_SPACE": "SPACE",
    "FEAT_NAMEK_GROUND": "NAMEK_GROUND",
    "FEAT_NAMEK_MOUNTAIN": "NAMEK_MOUNTAIN",
    "FEAT_NAMEK_WATER": "NAMEK_WATER",
    "FEAT_AJASA": "AJASA",
    "FEAT_BUILDING": "BUILDING",
    "FEAT_ASH": "ASH",
    "FEAT_DEEP_LAVA": "LAVA",
    "FEAT_SHAL_LAVA": "LAVA",
    "FEAT_LAVA_WALL": "LAVA_WALL",
    "FEAT_VOLC_LAVA": "LAVA",
    "FEAT_ROADSTRIPE_HORZ": "ROAD",
    "FEAT_ROADSTRIPE_VERT": "ROAD",
    "FEAT_ASPHALT": "ROAD",
    "FEAT_NAMEK_WELL": "NAMEK_GROUND",
    "FEAT_ICE": "SNOW",
    "FEAT_ICE_WALL": "WALL",
    "FEAT_GLACIER": "WALL",
    "FEAT_SNOWY_PEAK": "MOUNTAIN",
    "FEAT_WRAP_BORDER": "MAP_BORDER",
    "FEAT_KARIN_TOWER_EXT": "WALL",
    "FEAT_KAME_ROOF": "WALL",
    "FEAT_FENCE_VERT": "WALL",
    "FEAT_FENCE_HORZ": "WALL",
    "FEAT_WINDOW": "GLASS",
    "FEAT_DEEP_WATER": "DEEP_WATER",
    "FEAT_SHAL_WATER": "WATER",
    "FEAT_GRASS": "GRASS",
    "FEAT_TREES": "TREE",
    "FEAT_DIRT": "DIRT",
    "FEAT_SAND": "SAND",
    "FEAT_MOUNTAIN": "MOUNTAIN",
    "FEAT_SIGNPOST": "SIGNPOST",
    "FEAT_FLOOR": "FLOOR",
    "FEAT_DOOR": "DOOR",
    "FEAT_PERMA_WALL": "WALL",
    "FEAT_GROTTO": "DIRT",
    "FEAT_MUD": "DIRT",
    "FEAT_SECRET": "DOOR",
    "FEAT_DBT_SECRETDOOR": "DOOR",
    "FEAT_DOOR_LOCKED_HEAD": "WALL",
    "FEAT_IMPASSABLE_DOOR": "WALL",
    "FEAT_KARIN_TOWER": "WALL",
    "FEAT_GUARD_TOWER": "WALL",
    "FEAT_PERM_SOLID": "WALL",
    "FEAT_VOID": "SPACE",
    "FEAT_CLOUD": "CLOUD",
    "FEAT_SERPENT_CLOUD": "CLOUD",
    "FEAT_SERPENT_PATH": "ROAD",
    "FEAT_SERPENT_KAIO": "ROAD",
    "FEAT_FOOT_ELECTRONICS": "FURNITURE",
    "FEAT_CONTROL_SYSTEM": "FLOOR",
    "FEAT_LEVER": "FLOOR",
    "FEAT_HELL_SIGN": "SIGNPOST",
    "FEAT_NAMEK_GRASS": "GRASS",
    "FEAT_NAMEK_EMPTY_WELL": "NAMEK_GROUND",
    "FEAT_KAIO_CAR": "FURNITURE",
    "FEAT_DESERT": "SAND",
    "FEAT_SPACEPORT": "BUILDING",
    "FEAT_COUNTER": "FURNITURE",
    "FEAT_RUBBLE": "FLOOR",
    "FEAT_OPEN": "FLOOR",
    "FEAT_LESS": "UP",
    "FEAT_MORE": "DOWN",
})

# (map or None, less, more, outfile). None is a generated floor.
ZONES = [
    ("karin", "Land of Karin", "ENTER_DUNGEON_KARIN", [
        ("k_land.map", "UP_EARTH", "DOWN_HOUSE", "map.lua"),
        ("karinno.map", "UP_HOUSE", "DOWN_HOUSE", "l2.lua"),
        ("k_roof.map", "UP_HOUSE", "DOWN_HOUSE", "l3.lua"),
        ("lookout.map", "UP_HOUSE", "DOWN_HOUSE", "l4.lua"),
        ("kamino.map", "UP_HOUSE", None, "l5.lua"),
    ], None),
    ("foot", "Foot Lair", "ENTER_DUNGEON_NINJA_WAREHOUSE", [
        ("juvinile.map", "UP_EARTH", "DOWN_HOUSE", "map.lua"),
        None, None, None, None, None,
        ("foot_lair.map", "UP_HOUSE", None, "sanctum.lua"),
    ], "foot"),
    ("muscle", "Muscle Tower", "ENTER_DUNGEON_MUSCLE_TOWER", [
        None, None, None, None, None,
        ("towerhq.map", "UP_HOUSE", None, "map.lua"),
    ], "muscle"),
    ("buyon", "Buyon's Lair", None, [
        ("buyon.map", "UP_EARTH", None, "map.lua"),
    ], None),
    ("rabbit", "Rabbit Hole", "ENTER_DUNGEON_RABBIT_HOLE", [
        None, None, None, None, None,
    ], "rabbit"),
    ("blue", "Underwater Cavern", "ENTER_DUNGEON_UNDERWATER_CAVERN", [
        None, None, None, None, None,
        ("bluelair.map", "UP_HOUSE", None, "map.lua"),
    ], "blue"),
    ("volcano", "Volcano", "ENTER_DUNGEON_VOLCANO", [
        None, None, None, None,
        ("phoenix.map", "UP_HOUSE", None, "map.lua"),
    ], "volcano"),
    ("heaven", "Heaven", None, [("heaven.map", "UP_EARTH", None, "map.lua")], None),
    ("hell", "Hell", None, [("hell.map", "UP_EARTH", None, "map.lua")], None),
    ("serpent", "The Serpent's Path", None, [("serpent.map", "UP_EARTH", None, "map.lua")], None),
    ("bear", "Bear Cave", None, [("bearcave.map", "UP_EARTH", None, "map.lua")], None),
    ("spaceport", "Spaceport", None, [("spaceport.map", "UP_EARTH", None, "map.lua")], None),
    ("gero", "Dr. Gero's Lab", None, [("gerolair.map", "UP_EARTH", None, "map.lua")], None),
    ("bird", "Bird Cave", None, [("birdcave.map", "UP_EARTH", None, "map.lua")], None),
    ("kaiohouse", "King Kai's House", None, [("kaiohouse.map", "UP_EARTH", None, "map.lua")], None),
    ("shq1", "RRA Control", None, [("control1.map", "UP_EARTH", "DOWN_HOUSE", "map.lua")], None),
    ("shq2", "RRA Control", None, [("control2.map", "UP_EARTH", None, "map.lua")], None),
    ("shq3", "RRA Control", None, [("control3.map", "UP_EARTH", None, "map.lua")], None),
    ("shq", "RRA Supreme HQ", None, [("shq.map", "UP_EARTH", None, "map.lua")], None),
    ("vault", "RRA Vault", None, [("vault.map", "UP_EARTH", None, "map.lua")], None),
    ("stage", "Stage", None, [("stage.map", "UP_EARTH", None, "map.lua")], None),
    ("dojo_taek", "Tae Kwon Do", None, [("d_taek.map", "UP_EARTH", None, "map.lua")], None),
    ("dojo_marks", "Shooting Range", None, [("d_marks.map", "UP_EARTH", None, "map.lua")], None),
    ("dojo_ninj", "Ninja Training", None, [("d_ninj.map", "UP_EARTH", None, "map.lua")], None),
    ("dojo_ballet", "Ballet School", None, [("d_ball.map", "UP_EARTH", None, "map.lua")], None),
    ("sushi_bar", "Sushi Bar", None, [("sushi.map", "UP_EARTH", None, "map.lua")], None),
]

for i in range(1, 8):
    ZONES.append((
        "namek_elder%d" % i,
        "Namekian Elder",
        None,
        [("nam_elder%d.map" % i, "UP_EARTH", None, "map.lua")],
        None,
    ))

TOWN_ZONES = [
    ("nameksw", "Namek, southwest", TOWNS / "nameksw.map"),
    ("namekse", "Namek, southeast", TOWNS / "namekse.map"),
    ("nameknw", "Namek, northwest", TOWNS / "nameknw.map"),
    ("namekne", "Namek, northeast", TOWNS / "namekne.map"),
    ("kaio", "North Kaio's Planet", TOWNS / "kaiow.map"),
    ("plant", "Planet Plant", TOWNS / "plant.map"),
    ("p79", "Planet 79", TOWNS / "79.map"),
    ("babidi", "Babidi's Ship", TOWNS / "babidi.map"),
]

DUNGEON_ZONE = {
    "DUNGEON_KARIN": "karin",
    "DUNGEON_NINJA_WAREHOUSE": "foot",
    "DUNGEON_MUSCLE_TOWER": "muscle",
    "DUNGEON_BUYON": "buyon",
    "DUNGEON_RABBIT_HOLE": "rabbit",
    "DUNGEON_UNDERWATER_CAVERN": "blue",
    "DUNGEON_VOLCANO": "volcano",
    "DUNGEON_HEAVEN": "heaven",
    "DUNGEON_HELL": "hell",
    "DUNGEON_SERPENT": "serpent",
    "DUNGEON_BEAR_CAVE": "bear",
    "DUNGEON_SPACEPORT": "spaceport",
    "DUNGEON_GERO_LAB": "gero",
    "DUNGEON_HIKUI_BIRD_CAVE": "bird",
    "DUNGEON_NK_HOUSE": "kaiohouse",
    "DUNGEON_RRA_SHQ1": "shq1",
    "DUNGEON_RRA_SHQ2": "shq2",
    "DUNGEON_RRA_SHQ3": "shq3",
    "DUNGEON_RRA_SHQ4": "shq",
    "DUNGEON_TEMPLE": "temple",
    "DUNGEON_KAME_HOUSE": "kame",
    "DUNGEON_CRANE": "crane",
    "DUNGEON_MUSASHI": "musashi",
    "DUNGEON_WOLFCAVE": "wolfcave",
    "DUNGEON_OOLONG": "oolong",
    "DUNGEON_PILAF": "pilaf",
    "DUNGEON_BRIEFS": "briefs",
    "DUNGEON_OXKING_HOUSE": "frypan",
    "DUNGEON_SATAN_ESTATE": "satan",
    "DUNGEON_URANAI": "uranai",
    "DUNGEON_NINJA_SEWERS": "sewers",
    "DUNGEON_TOURNAMENT": "tournament",
}
for i in range(1, 8):
    DUNGEON_ZONE["DUNGEON_NAMEK_ELDER%d" % i] = "namek_elder%d" % i
    if i == 7:
        DUNGEON_ZONE["DUNGEON_NAMEK_GREAT_ELDER"] = "namek_elder7"

DENS = {
    "foot": (2, 6, 10, "{NINJA=60, MARTIAL=20, GOLD=20}", ["ALLOW_IN_NINJA_WAREHOUSE", "ALLOW_IN_FOOT_LAIR"]),
    "muscle": (1, 5, 10, "{RRA=50, PLAIN=10, BATTERY=10, BLUEPRINTS=10, GOLD=20}", ["ALLOW_IN_MUSCLE_TOWER"]),
    "rabbit": (1, 5, 10, "{PLAIN=25, ACCESSORY=25, JUNK=25, GOLD=25}", ["ALLOW_IN_RABBIT_HOLE"]),
    "blue": (1, 5, 10, "{RRA=50, PLAIN=10, BATTERY=10, BLUEPRINTS=10, GOLD=20}", ["ALLOW_IN_BLUE_LAIR"]),
    "volcano": (1, 4, 10, "{PLAIN=40, MARTIAL=40, GOLD=20}", ["ALLOW_IN_VOLCANO"]),
}

GEN = {
    "foot": ('WALL', 'FLOOR'),
    "muscle": ('WALL', 'FLOOR'),
    "rabbit": ('TREE', 'DIRT'),
    "blue": ('WALL', 'DIRT'),
    "volcano": ('LAVA_WALL', 'ASH'),
}


def friendly_flags():
    text = (OUT / "general" / "npcs" / "races.lua").read_text(encoding="utf-8", errors="replace")
    friendly, stuck = set(), set()
    parts = text.split("newEntity{")
    for part in parts[1:]:
        ident = re.search(r'define_as = "([^"]+)"', part)
        if not ident:
            continue
        if re.search(r"faction = nil", part):
            friendly.add(ident.group(1))
        if re.search(r"never_move = true", part):
            stuck.add(ident.group(1))
    return friendly, stuck


def monsters_for(flags):
    import extract_monsters as EM
    want = set(flags)
    found = {}
    for path in sorted((DBT / "data" / "monsters").glob("*.lua")):
        if path.name.startswith("Copy"):
            continue
        text = EM.strip_comments(path.read_text(encoding="utf-8", errors="replace"))
        for race in EM.parse_file(path, text):
            if want.intersection(race.get("flags") or ()):
                found[race["id"]] = (race["level"], race["rarity"], race["unique"])
    return found


def emit_map(zone, title, src, less, more, outfile, friendly):
    symbols, lines = H.parse_map(src)
    zone_dir = OUT / "zones" / zone
    (zone_dir / "maps").mkdir(parents=True, exist_ok=True)
    tiles, extras, monsters = [], [], []
    seen = set()
    start = (1, 1)
    found = False
    floor_at = None
    warned = set()
    floors = {"FLOOR", "NAMEK_GROUND", "GRASS", "DIRT", "ROAD", "ASH", "SNOW", "SAND"}
    for y, row in enumerate(lines):
        for x, ch in enumerate(row):
            spec = symbols.get(ch) or {"feat": "FEAT_FLOOR", "monster": None, "on_walk": None}
            dungeon = None
            ident = H.grid_for(zone, ch, spec, less, more)
            if floor_at is None and ident in floors and not spec.get("monster"):
                floor_at = (x, y)
            # grid_for does not see dungeon=. Recover it from the symbol block via a side channel:
            if ch not in seen:
                pass
            if ident in ("UP_EARTH", "UP_HOUSE") and not found:
                start = (x, y)
                found = True
            if ch in seen:
                continue
            seen.add(ch)
            if spec.get("feat") == "FEAT_SERPENT_KAIO":
                spec["dungeon"] = "KAIO_PLANET"
            link = spec.get("dungeon")
            if link == "KAIO_PLANET":
                ident = "TO_kaio"
                extras.append(
                    "newEntity{\n"
                    "\tdefine_as = \"TO_kaio\",\n"
                    "\tname = \"North Kaio\",\n"
                    "\tdisplay = '>', color=colors.YELLOW, back_color=colors.DARK_BLUE,\n"
                    "\tnotice = true, always_remember = true,\n"
                    "\tchange_level = 1, change_zone = \"kaio\",\n"
                    "\tdesc = \"Press > to enter.\",\n"
                    "}\n"
                )
            elif link:
                dest = DUNGEON_ZONE.get(link)
                if dest:
                    ident = "TO_" + dest
                    extras.append(
                        "newEntity{\n"
                        "\tdefine_as = %s,\n"
                        "\tname = %s,\n"
                        "\tdisplay = '>', color=colors.YELLOW, back_color=colors.DARK_UMBER,\n"
                        "\tnotice = true, always_remember = true,\n"
                        "\tchange_level = 1, change_zone = %s,\n"
                        "\tdesc = \"Press > to enter.\",\n"
                        "}\n" % (H.lua_quote(ident), H.lua_quote(dest), H.lua_quote(dest))
                    )
                else:
                    print("no zone for", link, "in", src.name)
            elif spec["feat"] not in H.FEATS and spec["feat"] not in ("FEAT_LESS", "FEAT_MORE"):
                if spec["feat"] not in warned:
                    warned.add(spec["feat"])
                    print("unknown", spec["feat"], src.name)
            if spec["on_walk"] and not link and ident not in ("KAME_TV", "TEMPLE_LOCK"):
                ident = "SIGN_" + H.slug(spec["on_walk"])
                extras.append(
                    "newEntity{\n"
                    "\tdefine_as = %s,\n"
                    "\tname = \"sign\",\n"
                    "\tdisplay = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,\n"
                    "\tnotice = true, does_block_move = true,\n"
                    "\tdesc = %s,\n"
                    "\tshow_tooltip = true,\n"
                    "}\n" % (H.lua_quote(ident), H.lua_quote(spec["on_walk"]))
                )
            if spec["monster"]:
                monsters.append(spec["monster"])
                tiles.append("defineTile(%s, %s, nil, %s)" % (H.lua_quote(ch), H.lua_quote(ident), H.lua_quote(spec["monster"])))
            else:
                tiles.append("defineTile(%s, %s)" % (H.lua_quote(ch), H.lua_quote(ident)))
    if not found and floor_at:
        start = floor_at
    body = "\n".join(lines)
    (zone_dir / "maps" / outfile).write_text(
        "-- %s, from %s.\n\n%s\n\nstartx = %d\nstarty = %d\nendx = %d\nendy = %d\n\nreturn [[%s]]\n"
        % (title, src.name, "\n".join(tiles), start[0], start[1], start[0], start[1], body),
        encoding="utf-8", newline="\n",
    )
    print(zone, outfile, len(lines[0]), "x", len(lines))
    return extras, monsters, len(lines[0]), len(lines)


def parse_with_dungeon(path):
    symbols, lines = H.parse_map(path)
    raw = path.read_text(encoding="utf-8", errors="replace")
    map_at = raw.find("map.map")
    head = H.strip_comments(raw[:map_at] if map_at >= 0 else raw)
    i = 0
    while True:
        j = head.find("map.symbol", i)
        if j < 0:
            break
        brace = head.find("{", j)
        end = H.matching_brace(head, brace)
        block = head[brace:end + 1]
        char = H.field(block, "symbol")
        if char and len(char) == 1 and char in symbols:
            dungeon = H.field(block, "dungeon")
            if dungeon:
                symbols[char]["dungeon"] = dungeon
        i = end + 1
    return symbols, lines


def emit_map_file(zone, title, src, less, more, outfile):
    # Re-parse so dungeon= is attached, then run the same placement as emit_map.
    symbols, lines = parse_with_dungeon(src)
    # Stash by temporarily replacing parse_map
    real = H.parse_map
    H.parse_map = lambda _p: (symbols, lines)
    try:
        return emit_map(zone, title, src, less, more, outfile, None)
    finally:
        H.parse_map = real


def write_npcs(zone, monsters, friendly, stuck):
    lines = ['load("/data/general/npcs/races.lua")\n']
    seen = set()
    for race in monsters:
        if race in seen:
            continue
        seen.add(race)
        peace = race in friendly
        hold = peace or race in stuck
        bits = [
            "base = %s" % H.lua_quote(race),
            "define_as = %s" % H.lua_quote(race),
            "faction = %s" % H.lua_quote("neutral" if peace else "enemies"),
            "ai = %s" % H.lua_quote("none" if peace else "simple"),
            "never_move = %s" % ("true" if hold else "false"),
        ]
        lines.append("newEntity{ %s }\n" % ", ".join(bits))
    (OUT / "zones" / zone / "npcs.lua").write_text("".join(lines) if len(lines) > 1 else lines[0], encoding="utf-8", newline="\n")


def write_zone(zone, title, levels, den, extras, sizes):
    zone_dir = OUT / "zones" / zone
    grids = 'load("/data/general/grids/basic.lua")\nload("/data/general/grids/house.lua")\n'
    if extras:
        grids += "\n" + "\n".join(extras)
    (zone_dir / "grids.lua").write_text(grids, encoding="utf-8", newline="\n")
    (zone_dir / "objects.lua").write_text("-- No loose objects on the map.\n", encoding="utf-8", newline="\n")
    (zone_dir / "traps.lua").write_text("-- No traps.\n", encoding="utf-8", newline="\n")
    max_level = len(levels)
    static = {i: sizes[i] for i in sizes}
    width = 66
    height = 44
    for w, h, _ in static.values():
        width = max(width, w)
        height = max(height, h)
    any_gen = any(lv is None for lv in levels)
    if not any_gen:
        width = max(s[0] for s in static.values())
        height = max(s[1] for s in static.values())
        first = static[1]
        text = (
            "return {\n\tname = %s,\n\tlevel_range = {1, %d},\n\tmax_level = %d,\n"
            "\twidth = %d, height = %d,\n\tall_remembered = true,\n\tall_lited = true,\n"
            "\tpersistent = \"zone\",\n\tgenerator = { map = { class = \"engine.generator.map.Static\", map = \"!%s\" } },\n"
        ) % (H.lua_quote(title), max_level, max_level, width, height, Path(first[2]).stem)
        if max_level > 1:
            text += "\tlevels = {\n"
            for i in range(1, max_level + 1):
                w, h, outfile = static[i]
                stem = Path(outfile).stem
                if i == 1:
                    text += "\t\t[1] = { width = %d, height = %d },\n" % (w, h)
                else:
                    text += (
                        "\t\t[%d] = { width = %d, height = %d, generator = { map = { class = \"engine.generator.map.Static\", map = \"!%s\" } } },\n"
                        % (i, w, h, stem)
                    )
            text += "\t},\n"
        text += "}\n"
    else:
        wall, mud = GEN.get(zone, ("WALL", "FLOOR"))
        text = (
            "return {\n\tname = %s,\n\tlevel_range = {1, %d},\n\tmax_level = %d,\n"
            "\twidth = %d, height = %d,\n\tall_remembered = true,\n\tall_lited = true,\n"
            "\tpersistent = \"zone\",\n"
            "\tgenerator = { map = {\n"
            "\t\tclass = \"mod.class.generator.map.Sewer\",\n"
            "\t\twall = %s, mud = %s, water = %s, swamp = %s,\n"
            "\t\tup = \"UP_HOUSE\", up_earth = \"UP_EARTH\", down = \"DOWN_HOUSE\",\n"
            "\t} },\n"
        ) % (H.lua_quote(title), max_level, max_level, width, height, H.lua_quote(wall), H.lua_quote(mud), H.lua_quote(mud), H.lua_quote(mud))
        if den:
            text += "\tpost_process = function(level)\n\t\tif game and game.stockDen then game:stockDen(level) end\n\tend,\n"
        if static:
            text += "\tlevels = {\n"
            for i, (w, h, outfile) in static.items():
                stem = Path(outfile).stem
                text += (
                    "\t\t[%d] = { width = %d, height = %d, generator = { map = { class = \"engine.generator.map.Static\", map = \"!%s\" } } },\n"
                    % (i, w, h, stem)
                )
            text += "\t},\n"
        text += "}\n"
    (zone_dir / "zone.lua").write_text(text, encoding="utf-8", newline="\n")


def patch_earth(entrances):
    path = OUT / "general" / "grids" / "earth.lua"
    text = path.read_text(encoding="utf-8")
    for entrance, zone in entrances:
        if not entrance:
            continue
        marker = 'define_as = "%s"' % entrance
        idx = text.find(marker)
        if idx < 0:
            print("missing entrance", entrance)
            continue
        nxt = text.find("define_as =", idx + len(marker))
        window = text[idx:nxt if nxt > 0 else idx + 500]
        old = 'change_zone = "closed"'
        at = window.find(old)
        if at < 0:
            continue
        window = window[:at] + 'change_zone = "%s"' % zone + window[at + len(old):]
        text = text[:idx] + window + text[nxt if nxt > 0 else idx + 500:]
    path.write_text(text, encoding="utf-8", newline="\n")


def emit_dens():
    lines = ["-- Generated floors for the dungeons that are not a single map.\n", "dbt_dens = {\n"]
    for zone, (lo, hi, count, themes, flags) in DENS.items():
        mons = monsters_for(flags)
        body = ",\n\t\t".join(
            '{id=%s, level=%d, rarity=%d%s}' % (H.lua_quote(ident), level, rarity, ", unique=true" if unique else "")
            for ident, (level, rarity, unique) in sorted(mons.items())
        )
        lines.append("\t%s = { from_level=%d, to_level=%d, count=%d, themes=%s, monsters={\n\t\t%s,\n\t} },\n" % (zone, lo, hi, count, themes, body))
        print("den", zone, len(mons))
    lines.append("}\n")
    (OUT / "dens.lua").write_text("".join(lines), encoding="utf-8", newline="\n")


def main():
    friendly, stuck = friendly_flags()
    entrances = []
    for zone, title, entrance, levels, den in ZONES:
        extras, monsters, sizes = [], [], {}
        for i, lv in enumerate(levels, 1):
            if lv is None:
                continue
            src_name, less, more, outfile = lv
            src = MAPS / src_name
            ex, mons, w, h = emit_map_file(zone, title, src, less, more, outfile)
            extras.extend(ex)
            monsters.extend(mons)
            sizes[i] = (w, h, outfile)
        if not sizes and all(lv is None for lv in levels):
            (OUT / "zones" / zone / "maps").mkdir(parents=True, exist_ok=True)
        write_npcs(zone, monsters, friendly, stuck)
        write_zone(zone, title, levels, den, extras, sizes)
        if entrance:
            entrances.append((entrance, zone))
    for zone, title, src in TOWN_ZONES:
        ex, mons, w, h = emit_map_file(zone, title, src, "UP_EARTH", None, "map.lua")
        write_npcs(zone, mons, friendly, stuck)
        write_zone(zone, title, [(src.name, "UP_EARTH", None, "map.lua")], None, ex, {1: (w, h, "map.lua")})
    patch_earth(entrances)
    emit_dens()


if __name__ == "__main__":
    main()
