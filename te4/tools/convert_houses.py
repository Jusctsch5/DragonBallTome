"""Static Earth interiors: houses, caves, and the temple's two maps."""
import os
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DBT = ROOT / "DBT"
OUT = ROOT / "te4" / "dbt" / "data"

# zone, title, earth entrance, list of (map, less grid, more grid, outfile)
PLACES = [
    ("kame", "Kame House", "ENTER_DUNGEON_KAME_HOUSE", [
        ("rosshi.map", "UP_EARTH", None, "map.lua"),
    ]),
    ("crane", "Crane Hermit", "ENTER_DUNGEON_CRANE", [
        ("crane.map", "UP_EARTH", None, "map.lua"),
    ]),
    ("musashi", "Musashi's Cave", "ENTER_DUNGEON_MUSASHI", [
        ("musashi.map", "UP_EARTH", None, "map.lua"),
    ]),
    ("wolfcave", "White Wolf's Cave", "ENTER_DUNGEON_WOLFCAVE", [
        ("wolfcave.map", "UP_EARTH", None, "map.lua"),
    ]),
    ("oolong", "Castle Oolong", "ENTER_DUNGEON_OOLONG", [
        ("oolong.map", "UP_EARTH", None, "map.lua"),
    ]),
    ("pilaf", "Castle Pilaf", "ENTER_DUNGEON_PILAF", [
        ("pilaf.map", "UP_EARTH", None, "map.lua"),
    ]),
    ("briefs", "Capsule Corporation", "ENTER_DUNGEON_BRIEFS", [
        ("briefs.map", "UP_EARTH", None, "map.lua"),
    ]),
    ("frypan", "Mount Frypan", "ENTER_DUNGEON_OXKING_HOUSE", [
        ("frypan.map", "UP_EARTH", "DOWN_HOUSE", "map.lua"),
        ("oxking.map", "UP_HOUSE", None, "house.lua"),
    ]),
    ("satan", "Mr. Satan's Estate", "ENTER_DUNGEON_SATAN_ESTATE", [
        ("satan_entry.map", "UP_EARTH", "DOWN_HOUSE", "map.lua"),
        ("satan.map", "UP_HOUSE", None, "house.lua"),
    ]),
    ("temple", "Buddhist Temple", "ENTER_DUNGEON_TEMPLE", [
        ("temple.map", "UP_EARTH", "DOWN_HOUSE", "map.lua"),
        ("catacomb.map", "UP_HOUSE", None, "catacomb.lua"),
    ]),
]

FEATS = {
    "FEAT_FLOOR": "FLOOR",
    "FEAT_MAP_BORDER": "MAP_BORDER",
    "FEAT_PERMA_WALL": "WALL",
    "FEAT_KAME_WALL": "WALL",
    "FEAT_WALL": "WALL",
    "FEAT_DOOR": "DOOR",
    "FEAT_GLASS_WALL": "GLASS",
    "FEAT_WINDOW": "GLASS",
    "FEAT_GRASS": "GRASS",
    "FEAT_TREES": "TREE",
    "FEAT_DIRT": "DIRT",
    "FEAT_FURNITURE": "FURNITURE",
    "FEAT_TELEVISION": "KAME_TV",
    "FEAT_LAMP": "LAMP",
    "FEAT_RED_CARPET": "CARPET_RED",
    "FEAT_GREEN_CARPET": "CARPET_GREEN",
    "FEAT_BLUE_CARPET": "CARPET_BLUE",
    "FEAT_WALL_OF_FIRE": "FIRE",
    "FEAT_MOUNTAIN": "MOUNTAIN",
    "FEAT_SAND": "SAND",
    "FEAT_SHAL_WATER": "WATER",
    "FEAT_DEEP_WATER": "DEEP_WATER",
    "FEAT_MUD": "DIRT",
    "FEAT_SATAN_TROPHY": "TROPHY",
    "FEAT_FAKE_DOOR": "TEMPLE_LOCK",
    "FEAT_GROTTO": "DIRT",
    "FEAT_PERM_INNER": "WALL",
    "FEAT_SNOW": "SNOW",
    "FEAT_DOOR_LOCKED_HEAD+6": "WALL",
    "FEAT_SIGNPOST": "SIGNPOST",
    "FEAT_MIRROR": "WALL",
    "FEAT_LADDER_LEFT": "FLOOR",
    "FEAT_LADDER_RIGHT": "FLOOR",
    "FEAT_BUDDHA": "BUDDHA",
}

FRIENDLY = {
    "RACE_ROSSHI", "RACE_UMIGAME", "RACE_CRANE_HERMIT", "RACE_CHAOZU", "RACE_TENSHINHAN",
    "RACE_MUSASHI", "RACE_KRILLAN", "RACE_MEDITATING_MONK", "RACE_ABBOT", "RACE_OOLONG",
    "RACE_PILAF", "RACE_MAI", "RACE_SHUU", "RACE_CHICHI", "RACE_BRIEFS", "RACE_TAMA",
    "RACE_MR_SATAN", "RACE_VIDEL", "RACE_MISS_PIIZA", "RACE_FLORINIFERA", "RACE_WHINY_ARU",
}
TALK = {
    "RACE_ROSSHI": "rosshi",
    "RACE_CRANE_HERMIT": "crane",
    "RACE_MUSASHI": "musashi",
    "RACE_KRILLAN": "krillin",
    "RACE_ABBOT": "abbot",
}
QUEST = {
    "RACE_WHITE_WOLF": "white_wolf",
    "RACE_MONK_RINGLEADER": "temple",
}

SKILL_ID = {
    "SKILL_MARTIALARTS": "martialarts",
    "SKILL_HAND": "hand",
    "SKILL_WEAPONS": "weapons",
    "SKILL_STRENGTH": "strength",
    "SKILL_DEXTERITY": "dexterity",
    "SKILL_CONSTITUTION": "constitution",
    "SKILL_PARRYING": "parrying",
    "SKILL_PAIRED": "paired",
    "SKILL_SPEED": "speed",
    "SKILL_DODGE": "dodge",
    "SKILL_STEALTH": "stealth",
    "SKILL_CHI": "chi",
    "SKILL_CHI_OFFENSE": "chi_offense",
    "SKILL_CHI_DEFENSE": "chi_defense",
    "SKILL_CHI_REGENERATION": "chi_regeneration",
    "SKILL_CHI_GUNG": "chi_gung",
    "SKILL_MARKSMANSHIP": "marksmanship",
    "SKILL_THROWING": "throwing",
    "AB_DOUBLE_ATTACK": "double_attack",
    "AB_CHI_BURST": "chi_burst",
    "AB_LIGHT": "light",
    "AB_MEDITATION": "meditation",
    "AB_SNEAK": "sneak",
    "AB_PAIRED_WEAPONS": "paired_weapons",
    "AB_RIPOSTE": "riposte",
    "AB_IAIJUTSU": "iaijutsu",
    "AB_HASTE": "haste",
    "AB_AURA": "aura",
    "AB_FLIGHT": "flight",
    "AB_HEAL": "heal",
    "AB_CURE": "cure",
    "AB_BLOCKING": "blocking",
    "AB_BLEED_ATTACK": "bleed_attack",
}

SCHOOLS = [
    ("ROSSHI", "Master Rosshi"),
    ("CRANE_HERMIT", "Crane Hermit"),
    ("MUSASHI", "Musashi"),
    ("ABBOT", "The Abbot"),
]


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


def slug(text):
    return re.sub(r"[^A-Za-z0-9]+", "_", text).strip("_")[:40] or "NOTE"


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
    lines = [ln.strip("\r") for ln in rows if ln.strip("\r") != ""]
    width = max(len(ln) for ln in lines)
    if any(len(ln) != width for ln in lines):
        print("padded", path.name)
        lines = [ln.ljust(width, lines[0][:1] or "*") for ln in lines]
    return symbols, lines


def grid_for(zone, ch, spec, less, more):
    feat = spec["feat"]
    if zone == "kame" and ch in ("=", "q"):
        return "KAME_TV"
    if zone == "temple" and ch == "E":
        return "TEMPLE_LOCK"
    if feat == "FEAT_LESS":
        return less or "UP_EARTH"
    if feat == "FEAT_MORE":
        return more or "FLOOR"
    if feat not in FEATS:
        print("unknown feat", feat, "in", zone)
        return "WALL" if "WALL" in feat or "DOOR" in feat else "FLOOR"
    return FEATS[feat]


def write_maps(zone, title, levels):
    zone_dir = OUT / "zones" / zone
    (zone_dir / "maps").mkdir(parents=True, exist_ok=True)
    extras = []
    monsters = []
    sizes = []
    for src_name, less, more, outfile in levels:
        symbols, lines = parse_map(DBT / "data" / "maps" / src_name)
        if zone == "kame" and outfile == "map.lua" and len(lines) > 8 and lines[8][3:4] == ".":
            row = list(lines[8])
            row[3] = "U"
            lines[8] = "".join(row)
            symbols["U"] = {"feat": "FEAT_FLOOR", "monster": "RACE_UMIGAME", "on_walk": None}
        tiles = []
        seen = set()
        start = (1, 1)
        found_up = False
        for y, row in enumerate(lines):
            for x, ch in enumerate(row):
                spec = symbols.get(ch)
                ident = grid_for(zone, ch, spec or {"feat": "FEAT_FLOOR"}, less, more)
                if ident in ("UP_EARTH", "UP_HOUSE") and not found_up:
                    start = (x, y)
                    found_up = True
                if ch in seen:
                    continue
                seen.add(ch)
                if not spec:
                    raise SystemExit("%s uses undefined symbol %r" % (src_name, ch))
                if spec["on_walk"] and ident not in ("KAME_TV", "TEMPLE_LOCK"):
                    ident = "SIGN_" + slug(spec["on_walk"])
                    extras.append(
                        "newEntity{\n"
                        "\tdefine_as = %s,\n"
                        "\tname = \"sign\",\n"
                        "\tdisplay = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,\n"
                        "\tnotice = true,\n"
                        "\tdoes_block_move = true,\n"
                        "\tdesc = %s,\n"
                        "\tshow_tooltip = true,\n"
                        "}\n" % (lua_quote(ident), lua_quote(spec["on_walk"]))
                    )
                if spec["monster"]:
                    monsters.append(spec["monster"])
                    tiles.append("defineTile(%s, %s, nil, %s)" % (lua_quote(ch), lua_quote(ident), lua_quote(spec["monster"])))
                else:
                    tiles.append("defineTile(%s, %s)" % (lua_quote(ch), lua_quote(ident)))
        body = "\n".join(lines)
        (zone_dir / "maps" / outfile).write_text(
            "-- %s, from DBT/data/maps/%s.\n\n%s\n\nstartx = %d\nstarty = %d\nendx = %d\nendy = %d\n\nreturn [[%s]]\n"
            % (title, src_name, "\n".join(tiles), start[0], start[1], start[0], start[1], body),
            encoding="utf-8", newline="\n",
        )
        sizes.append((len(lines[0]), len(lines), outfile))
        print(zone, outfile, len(lines[0]), "x", len(lines), "start", start)
    return extras, monsters, sizes


def write_npcs(zone, monsters):
    lines = ['load("/data/general/npcs/races.lua")\n']
    seen = set()
    for race in monsters:
        if race in seen:
            continue
        seen.add(race)
        hostile = race not in FRIENDLY
        chat = TALK.get(race)
        quest = QUEST.get(race)
        bits = [
            'base = %s' % lua_quote(race),
            'define_as = %s' % lua_quote(race),
            'faction = %s' % lua_quote("enemies" if hostile else "neutral"),
            'ai = %s' % lua_quote("simple" if hostile else "none"),
            'never_move = %s' % ("false" if hostile else "true"),
        ]
        if chat:
            bits.append("can_talk = %s" % lua_quote(chat))
        if quest:
            bits.append("dbt_quest = %s" % lua_quote(quest))
        lines.append("newEntity{ %s }\n" % ", ".join(bits))
    if zone == "kame":
        lines.append(
            'newEntity{ base = "RACE_UMIGAME", define_as = "RACE_UMIGAME", '
            'faction = "neutral", ai = "none", never_move = true }\n'
        )
    (OUT / "zones" / zone / "npcs.lua").write_text("".join(lines), encoding="utf-8", newline="\n")


def write_zone_files(zone, title, extras, sizes):
    zone_dir = OUT / "zones" / zone
    grids = 'load("/data/general/grids/basic.lua")\nload("/data/general/grids/house.lua")\n'
    if extras:
        grids += "\n" + "\n".join(extras)
    (zone_dir / "grids.lua").write_text(grids, encoding="utf-8", newline="\n")
    (zone_dir / "objects.lua").write_text("-- No loose objects on the map.\n", encoding="utf-8", newline="\n")
    (zone_dir / "traps.lua").write_text("-- No traps.\n", encoding="utf-8", newline="\n")
    if zone == "temple":
        w1, h1, _ = sizes[0]
        w7, h7, _ = sizes[1]
        width = max(66, w1, w7)
        height = max(44, h1, h7)
        text = (
            "return {\n"
            "\tname = %s,\n"
            "\tlevel_range = {17, 23},\n"
            "\tmax_level = 7,\n"
            "\twidth = %d, height = %d,\n"
            "\tall_remembered = true,\n"
            "\tall_lited = true,\n"
            "\tpersistent = \"zone\",\n"
            "\tgenerator = {\n"
            "\t\tmap = {\n"
            "\t\t\tclass = \"mod.class.generator.map.Sewer\",\n"
            "\t\t\twall = \"WALL\", mud = \"FLOOR\", water = \"FLOOR\", swamp = \"FLOOR\",\n"
            "\t\t\tup = \"UP_HOUSE\", up_earth = \"UP_EARTH\", down = \"DOWN_HOUSE\",\n"
            "\t\t},\n"
            "\t},\n"
            "\tpost_process = function(level)\n"
            "\t\tif game and game.stockTemple then game:stockTemple(level) end\n"
            "\tend,\n"
            "\tlevels = {\n"
            "\t\t[1] = { name = \"Buddhist Temple\", width = %d, height = %d,\n"
            "\t\t\tgenerator = { map = { class = \"engine.generator.map.Static\", map = \"!map\" } } },\n"
            "\t\t[7] = { name = \"Catacombs\", width = %d, height = %d,\n"
            "\t\t\tgenerator = { map = { class = \"engine.generator.map.Static\", map = \"!catacomb\" } } },\n"
            "\t},\n"
            "}\n"
        ) % (lua_quote(title), width, height, w1, h1, w7, h7)
    elif len(sizes) == 1:
        w, h, _ = sizes[0]
        text = (
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
            "}\n"
        ) % (lua_quote(title), w, h)
    else:
        w1, h1, _ = sizes[0]
        w2, h2, _ = sizes[1]
        text = (
            "return {\n"
            "\tname = %s,\n"
            "\tlevel_range = {1, 2},\n"
            "\tmax_level = 2,\n"
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
            "\tlevels = {\n"
            "\t\t[1] = { width = %d, height = %d },\n"
            "\t\t[2] = { width = %d, height = %d,\n"
            "\t\t\tgenerator = { map = { class = \"engine.generator.map.Static\", map = \"!house\" } } },\n"
            "\t},\n"
            "}\n"
        ) % (lua_quote(title), max(w1, w2), max(h1, h2), w1, h1, w2, h2)
    (zone_dir / "zone.lua").write_text(text, encoding="utf-8", newline="\n")


def patch_earth():
    path = OUT / "general" / "grids" / "earth.lua"
    text = path.read_text(encoding="utf-8")
    text = text.replace(
        "-- Shops are closed doors. Dungeons other than Uranai Baba's house use the closed zone.",
        "-- Shops are closed doors. Open dungeons are named below; the rest stay closed.",
    )
    for zone, _title, entrance, _levels in PLACES:
        marker = 'define_as = "%s"' % entrance
        idx = text.find(marker)
        if idx < 0:
            raise SystemExit("missing entrance " + entrance)
        nxt = text.find("define_as =", idx + len(marker))
        window = text[idx:nxt if nxt > 0 else idx + 400]
        old = 'change_zone = "closed"'
        at = window.find(old)
        if at < 0:
            if 'change_zone = "%s"' % zone in window:
                continue
            raise SystemExit("no closed zone for " + entrance)
        window = window[:at] + 'change_zone = "%s"' % zone + window[at + len(old):]
        text = text[:idx] + window + text[nxt if nxt > 0 else idx + 400:]
    path.write_text(text, encoding="utf-8", newline="\n")


def school_chunk(text, name):
    marker = "FLAG_ENROLL_" + name
    best = ""
    start = 0
    while True:
        i = text.find(marker, start)
        if i < 0:
            break
        nxt = text.find("elseif which ==", i + len(marker))
        chunk = text[i:nxt if nxt > 0 else i + 12000]
        if "school_data[1]" in chunk and len(chunk) > len(best):
            best = chunk
        start = i + len(marker)
    return best


def emit_schools():
    raw = strip_comments((DBT / "scripts" / "enroll.lua").read_text(encoding="utf-8", errors="replace"))
    out = [
        "-- Rosshi, Crane, Musashi, and the Abbot. Caps that jump from 5 to 10 on enrollment are stored at 10,\n",
        "-- because the trainer only opens after he has accepted you.\n",
        "dbt_masters = true\n\n",
        "dbt_temple_monsters = {\n",
        '\t{id="RACE_CORRUPT_MONK_A", level=17, rarity=1},\n',
        '\t{id="RACE_CORRUPT_MONK_B", level=19, rarity=1},\n',
        '\t{id="RACE_CORRUPT_MONK_C", level=21, rarity=1},\n',
        '\t{id="RACE_CORRUPT_MONK_D", level=23, rarity=1},\n',
        '\t{id="RACE_MONK_RINGLEADER", level=25, rarity=999},\n',
        "}\n\n",
        "if dbt_schools then\n",
    ]
    for sid, title in SCHOOLS:
        chunk = school_chunk(raw, sid)
        if not chunk:
            raise SystemExit("no school " + sid)
        parts = re.split(r"school_data\[\d+\]\s*=", chunk)[1:]
        classes = []
        used = set()
        for part in parts:
            skill_m = re.search(r'\["skill"\]\s*=\s*([A-Z0-9_]+)', part)
            if not skill_m:
                continue
            token = skill_m.group(1)
            skill = SKILL_ID.get(token)
            if not skill:
                print("skip skill", token, sid)
                continue
            kind = "ability" if token.startswith("AB_") or "FLAG_SS_ABILITY" in part[:200] else "skill"
            if "FLAG_SS_ABILITY" in part[:250]:
                kind = "ability"
            gain = int(re.search(r'\["gain"\]\s*=\s*(\d+)', part).group(1))
            cost = int(re.search(r'\["skcost"\]\s*=\s*(\d+)', part).group(1))
            key = re.search(r'\["key"\]\s*=\s*"([^"]+)"', part).group(1)
            while key in used:
                key = key + "2"
            used.add(key)
            reqtxt_m = re.search(r'\["reqtxt"\]\s*=\s*"([^"]*)"', part)
            reqtxt = reqtxt_m.group(1).strip() if reqtxt_m else ""
            reqs = []
            for req in re.finditer(r"skill\((SKILL_[A-Z0-9_]+)\)\.value\s*>=\s*(\d+)", part):
                req_skill = SKILL_ID.get(req.group(1))
                if req_skill:
                    reqs.append('{kind="skill", skill=%s, n=%s}' % (lua_quote(req_skill), req.group(2)))
            # Enrollment flips 5 to 10. The dialog is closed until that happens, so the open cap is 10.
            cap_m = re.search(r"return\s+(\d+)\s+else\s+return\s+(\d+)", part)
            if cap_m:
                cap = int(cap_m.group(2))
            else:
                caps = [int(n) for n in re.findall(r"return\s+(\d+)", part)]
                cap = caps[0] if caps else 0
            req = "{" + ", ".join(reqs) + "}"
            classes.append(
                '{type=%s, skill=%s, gain=%d, skcost=%d, cap=%d, key=%s, reqtxt=%s, req=%s}'
                % (lua_quote(kind), lua_quote(skill), gain, cost, cap, lua_quote(key), lua_quote(reqtxt), req)
            )
        body = ",\n\t\t\t".join(classes)
        out.append(
            "\tdbt_schools.%s = {\n\t\tname = %s,\n\t\tcost = 0,\n\t\tclasses = {\n\t\t\t%s,\n\t\t},\n\t}\n"
            % (sid, lua_quote(title), body)
        )
        print(sid, len(classes), "classes")
    out.append("end\n")
    (OUT / "masters.lua").write_text("".join(out), encoding="utf-8", newline="\n")


def main():
    for zone, title, _entrance, levels in PLACES:
        extras, monsters, sizes = write_maps(zone, title, levels)
        write_npcs(zone, monsters)
        write_zone_files(zone, title, extras, sizes)
    patch_earth()
    emit_schools()


if __name__ == "__main__":
    main()
