"""Pull monster races out of the ToME 3 sources into a T-Engine 4 npc list."""
import os
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DBT = ROOT / "DBT" / "data" / "monsters"
OUT = ROOT / "te4" / "dbt" / "data" / "general" / "npcs" / "races.lua"

FRIENDLY = {"NEUTRAL", "GOOD", "PLAYER", "KAMI", "TOWN", "LUNCH"}
BAND_FLAGS = {
    "ALLOW_IN_EARTH_SAFE": "SAFE",
    "ALLOW_IN_EARTH_EASY": "EASY",
    "ALLOW_IN_EARTH_HARD": "HARD",
    "ALLOW_IN_EARTH_DEADLY": "DEADLY",
    "AQUATIC": "AQUATIC",
}
SPAWN_OUT = ROOT / "te4" / "dbt" / "data" / "earth_spawns.lua"

COLORS = {
    "WHITE", "SLATE", "ORANGE", "RED", "GREEN", "BLUE", "UMBER", "YELLOW",
    "VIOLET", "AQUA", "PINK", "TEAL", "DARK_GREY", "DARK_RED", "DARK_GREEN",
    "DARK_BLUE", "DARK_UMBER", "LIGHT_RED", "LIGHT_GREEN", "LIGHT_BLUE",
    "LIGHT_UMBER", "LIGHT_SLATE", "LIGHT_DARK", "ANTIQUE_WHITE", "GREY",
    "DARK_KHAKI", "KHAKI", "STEEL_BLUE", "LIGHT_STEEL_BLUE", "GOLD",
    "ORANGE_RED", "SALMON", "LIGHT_SALMON", "DARK_ORANGE", "CRIMSON",
    "FIREBRICK", "DARK_MAGENTA", "MAGENTA", "PURPLE", "INDIGO", "CADET_BLUE",
    "DARK_SEA_GREEN", "SEA_GREEN", "OLIVE", "OLIVE_DRAB", "YELLOW_GREEN",
    "LIME", "LIME_GREEN", "SPRING_GREEN", "AQUAMARINE", "CYAN", "SKY_BLUE",
    "ROYAL_BLUE", "NAVY", "BLACK", "BROWN", "TAN", "WHEAT", "BEIGE",
    "LIGHT_GREY", "SILVER", "DARK_SLATE", "LIGHT_DARK_BLUE",
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
        if src[i] in "\"'":
            q = src[i]
            out.append(q)
            i += 1
            while i < n:
                if src[i] == "\\" and i + 1 < n:
                    out.append(src[i:i + 2])
                    i += 2
                    continue
                out.append(src[i])
                if src[i] == q:
                    i += 1
                    break
                i += 1
            continue
        out.append(src[i])
        i += 1
    return "".join(out)


def matching_brace(text, open_at):
    depth = 0
    i = open_at
    n = len(text)
    while i < n:
        c = text[i]
        if c in "\"'":
            q = c
            i += 1
            while i < n:
                if text[i] == "\\" and i + 1 < n:
                    i += 2
                    continue
                if text[i] == q:
                    i += 1
                    break
                i += 1
            continue
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return n - 1


def lua_quote(text):
    return '"' + text.replace("\\", "\\\\").replace('"', '\\"').replace("\n", " ") + '"'


def field_string(block, key):
    m = re.search(r"\b" + key + r"\s*=\s*\"((?:\\.|[^\"])*)\"", block)
    if m:
        return m.group(1).replace('\\"', '"')
    m = re.search(r"\b" + key + r"\s*=\s*'((?:\\.|[^'])*)'", block)
    if m:
        return m.group(1)
    m = re.search(r"\b" + key + r"\s*=\s*\{", block)
    if not m:
        return None
    end = matching_brace(block, m.end() - 1)
    body = block[m.end():end]
    parts = re.findall(r"\"((?:\\.|[^\"])*)\"", body)
    if not parts:
        parts = re.findall(r"'((?:\\.|[^'])*)'", body)
    text = " ".join(p.replace('\\"', '"') for p in parts)
    return text.strip() or None


def field_number(block, key):
    m = re.search(r"\b" + key + r"\s*=\s*(-?\d+)", block)
    if m:
        return int(m.group(1))
    return None


def flag_names(block):
    m = re.search(r"\bflags\s*=\s*\{", block)
    if not m:
        return set()
    end = matching_brace(block, m.end() - 1)
    body = block[m.end():end]
    # Drop nested tables so a function or resist table cannot look like a flag.
    flat = []
    depth = 0
    i = 0
    while i < len(body):
        c = body[i]
        if c == "{":
            depth += 1
        elif c == "}":
            depth = max(0, depth - 1)
        elif depth == 0:
            flat.append(c)
        i += 1
    text = "".join(flat)
    names = set(re.findall(r"\b([A-Z][A-Z0-9_]*)\s*=", text))
    return names


def faction_of(block):
    m = re.search(r"FACTION\s*=\s*FACTION_([A-Z0-9_]+)", block)
    if m:
        return m.group(1)
    return None


def blows_of(block):
    m = re.search(r"\bblows\s*=\s*\{", block)
    if not m:
        return []
    end = matching_brace(block, m.end() - 1)
    body = block[m.end():end]
    found = []
    for method, effect, dice, sides in re.findall(
        r"\{\s*\"([A-Z0-9_]+)\"\s*,\s*\"([A-Z0-9_]+)\"\s*,\s*\{\s*(\d+)\s*,\s*(\d+)\s*\}",
        body,
    ):
        found.append((method, effect, int(dice), int(sides)))
    return found


def spells_of(block):
    m = re.search(r"\bspells\s*=\s*\{", block)
    if not m:
        return 0, []
    end = matching_brace(block, m.end() - 1)
    body = block[m.end():end]
    freq = 0
    fm = re.search(r"frequency\s*=\s*(\d+)", body)
    if fm:
        freq = int(fm.group(1))
    spells = []
    for name, level in re.findall(r"\[\"([A-Za-z0-9_ ]+)\"\]\s*=\s*\{\s*level\s*=\s*(\d+)", body):
        spells.append((name, int(level)))
    return freq, spells


def never_move(flags, block):
    if "NEVER_MOVE" in flags:
        return True
    return "DBT_NEVER_MOVE" in block or "ai.DBT_NEVER_MOVE" in block


def drop_spec(block):
    """DROP_THEME weights and DROP_NUMBER dice from one monster block."""
    themes = {}
    match = re.search(r"DROP_THEME\s*=\s*getter\.flags\s*\{", block)
    if match:
        end = matching_brace(block, match.end() - 1)
        inner = block[match.end():end]
        for name, val in re.findall(r"THEME_([A-Z0-9_]+)\s*=\s*(\d+)", inner):
            themes[name] = int(val)
    lo = hi = None
    rand = re.search(r"DROP_NUMBER\s*=\s*getter\.random\(\s*(\d+)\s*,\s*(\d+)\s*\)", block)
    if rand:
        lo, hi = int(rand.group(1)), int(rand.group(2))
    else:
        plain = re.search(r"DROP_NUMBER\s*=\s*(\d+)", block)
        if plain:
            lo = hi = int(plain.group(1))
    ball = None
    ball_m = re.search(r"DROP_DRAGONBALL\s*=\s*(\d+)", block)
    if ball_m:
        ball = int(ball_m.group(1))
    return {"themes": themes, "lo": lo, "hi": hi, "ball": ball}


def parse_file(path, text):
    races = []
    letter = "p"
    defaults_flags = set()
    defaults_faction = None
    defaults_drop = {"themes": {}, "lo": None, "hi": None, "ball": None}
    i = 0
    while i < len(text):
        letter_m = re.match(r"\['(.)'\]\s*=", text[i:])
        if letter_m and (i == 0 or text[i - 1] in "\n\t "):
            letter = letter_m.group(1)
            i += letter_m.end()
            continue
        def_m = re.match(r"defaults\s*=\s*\{", text[i:])
        if def_m and (i == 0 or text[i - 1] in "\n\t "):
            open_at = i + def_m.end() - 1
            end = matching_brace(text, open_at)
            body = text[open_at:end + 1]
            defaults_flags = flag_names(body)
            defaults_faction = faction_of(body)
            defaults_drop = drop_spec(body)
            i = end + 1
            continue
        ent_m = re.match(r"\[\d+\]\s*=\s*\{", text[i:])
        if ent_m and (i == 0 or text[i - 1] in "\n\t "):
            open_at = i + ent_m.end() - 1
            end = matching_brace(text, open_at)
            body = text[open_at:end + 1]
            name = field_string(body, "name")
            if name:
                ident_m = re.search(r'define_as\s*=\s*"([A-Z0-9_]+)"', body)
                if ident_m:
                    ident = ident_m.group(1)
                else:
                    slug = re.sub(r"[^A-Za-z0-9]+", "_", name).strip("_").upper()
                    ident = "RACE_%s_%s" % (letter.upper(), slug[:40])
                flags = defaults_flags | flag_names(body)
                faction = faction_of(body) or defaults_faction
                own_drop = drop_spec(body)
                themes = own_drop["themes"] or defaults_drop["themes"]
                drop_lo = own_drop["lo"] if own_drop["lo"] is not None else defaults_drop["lo"]
                drop_hi = own_drop["hi"] if own_drop["hi"] is not None else defaults_drop["hi"]
                ball = own_drop["ball"] if own_drop["ball"] is not None else defaults_drop["ball"]
                life_m = re.search(r"\blife\s*=\s*\{\s*(\d+)\s*,\s*(\d+)\s*\}", body)
                dice, sides = (1, 1)
                if life_m:
                    dice, sides = int(life_m.group(1)), int(life_m.group(2))
                freq, spells = spells_of(body)
                color = "WHITE"
                cm = re.search(r"\bcolor\s*=\s*color\.([A-Z0-9_]+)", body)
                if cm and cm.group(1) in COLORS:
                    color = cm.group(1)
                elif cm:
                    color = "WHITE"
                races.append({
                    "id": ident,
                    "name": name,
                    "desc": field_string(body, "desc") or name,
                    "char": letter,
                    "color": color,
                    "level": field_number(body, "level") or 1,
                    "speed": field_number(body, "speed") or 0,
                    "ac": field_number(body, "ac") or 0,
                    "exp": field_number(body, "exp") or 0,
                    "dice": dice,
                    "sides": sides,
                    "force_hp": "FORCE_MAXHP" in flags,
                    "blows": blows_of(body),
                    "freq": freq,
                    "spells": spells,
                    "faction": faction,
                    "friendly": faction in FRIENDLY if faction else False,
                    "never_move": never_move(flags, body),
                    "unique": "UNIQUE" in flags,
                    "source": path.name,
                    "drop_themes": themes,
                    "drop60": "DROP_60" in flags,
                    "drop90": "DROP_90" in flags,
                    "drop_lo": drop_lo,
                    "drop_hi": drop_hi,
                    "only_gold": "ONLY_GOLD" in flags,
                    "only_item": "ONLY_ITEM" in flags,
                    "animal": "ANIMAL" in flags,
                    "plant": "PLANT" in flags,
                    "immortal": "IMMORTAL" in flags,
                    "no_ball": "FORCE_NO_DBALL" in flags,
                    "ball": ball,
                    "no_corpse": "DBT_FORCE_NO_CORPSE" in flags,
                    "force_corpse": "DROP_CORPSE_FORCE" in flags,
                    "rarity": field_number(body, "rarity") or 1,
                    "flags": flags,
                    "bands": [BAND_FLAGS[flag] for flag in sorted(BAND_FLAGS) if flag in flags],
                })
            i = end + 1
            continue
        i += 1
    return races


def emit(race):
    life = race["dice"] * race["sides"]
    lines = ["newEntity{"]
    lines.append("\tdefine_as = %s," % lua_quote(race["id"]))
    lines.append("\tname = %s," % lua_quote(race["name"]))
    lines.append("\ttype = \"monster\", subtype = %s," % lua_quote(race["source"].replace(".lua", "")))
    lines.append("\tdisplay = %s, color=colors.%s," % (lua_quote(race["char"]), race["color"]))
    lines.append("\tdesc = %s," % lua_quote(race["desc"]))
    lines.append("\tlevel = %d," % race["level"])
    lines.append("\tlevel_range = {%d, %d}," % (race["level"], race["level"]))
    lines.append("\tdbt_speed = %d," % race["speed"])
    lines.append("\tcombat_armor = %d," % race["ac"])
    lines.append("\tmax_life = %d, life = %d," % (life, life))
    lines.append("\tdb_hd = {%d, %d}," % (race["dice"], race["sides"]))
    lines.append("\tdb_force_hp = %s," % ("true" if race["force_hp"] else "false"))
    lines.append("\texp_worth = %d," % max(1, race["level"]))
    lines.append("\tdb_char = %s," % lua_quote(race["char"]))
    if race["unique"]:
        lines.append("\tunique = true,")
    if race["blows"]:
        bits = []
        for method, effect, dice, sides in race["blows"]:
            bits.append("{method=%s, effect=%s, dice=%d, sides=%d}" % (
                lua_quote(method), lua_quote(effect), dice, sides))
        lines.append("\tblows = { %s }," % ", ".join(bits))
    if race["spells"]:
        bits = []
        for name, level in race["spells"]:
            bits.append("{name=%s, level=%d}" % (lua_quote(name), level))
        lines.append("\tdbt_spells = { %s }," % ", ".join(bits))
        lines.append("\tdbt_spell_freq = %d," % race["freq"])
    if race["friendly"]:
        lines.append("\tfaction = nil,")
        lines.append("\tai = \"none\",")
        lines.append("\tnever_move = true,")
    else:
        lines.append("\tfaction = \"enemies\",")
        if race["never_move"]:
            lines.append("\tai = \"none\",")
            lines.append("\tnever_move = true,")
        else:
            lines.append("\tai = \"simple\", ai_state = { talent_in=3 },")
    lines.append("}")
    return "\n".join(lines)


def write_spawns(order):
    """Wilderness terrain rules for the nine Earth screens. Town maps themselves place nobody."""
    zones = [
        ("earth1", 15, ["HARD"]),
        ("earth2", 15, ["HARD"]),
        ("earth3", 27, ["HARD"]),
        ("earth4", 5, ["EASY"]),
        ("earth5", 1, ["SAFE"]),
        ("earth6", 33, ["DEADLY"]),
        ("earth7", 1, ["AQUATIC"]),
        ("earth8", 5, ["EASY"]),
        ("earth9", 17, ["HARD", "DEADLY"]),
    ]
    lines = [
        "-- Earth overworld spawns. Generated by te4/tools/extract_monsters.py.",
        "-- Bands and levels come from DBT/data/wild/terrain.lua. The town maps do not place these.",
        "dbt_earth_zones = {",
    ]
    for name, level, bands in zones:
        band_lua = ", ".join('"%s"' % b for b in bands)
        lines.append('\t%s = {level = %d, bands = {%s}},' % (name, level, band_lua))
    lines.append("}")
    lines.append("dbt_earth_monsters = {")
    kept = 0
    for race in order:
        if not race["bands"] or race["unique"] or race["friendly"] or race["never_move"]:
            continue
        kept += 1
        band_lua = ", ".join('"%s"' % b for b in race["bands"])
        lines.append('\t{id=%s, level=%d, rarity=%d, bands={%s}},' % (
            lua_quote(race["id"]), race["level"], race["rarity"], band_lua))
    lines.append("}")
    lines.append("")
    SPAWN_OUT.write_text("\n".join(lines), encoding="utf-8")
    print("wrote", SPAWN_OUT, "monsters", kept)


def main():
    seen = {}
    order = []
    for path in sorted(DBT.glob("*.lua")):
        if path.name.startswith("Copy"):
            continue
        raw = path.read_text(encoding="utf-8", errors="replace")
        text = strip_comments(raw)
        for race in parse_file(path, text):
            if race["id"] in seen:
                continue
            seen[race["id"]] = race
            order.append(race)
    chunks = [
        "-- Monster races from DBT/data/monsters. Generated by te4/tools/extract_monsters.py.\n",
        "-- Life is hit dice times sides. Speed is the ToME bonus on top of 110.\n",
        "-- A friendly faction stands still. Anything else closes and strikes.\n\n",
        "newEntity{\n",
        "\tdefine_as = \"BASE_NPC_RACE\",\n",
        "\ttype = \"monster\", subtype = \"race\",\n",
        "\tdisplay = \"p\", color=colors.WHITE,\n",
        "\tstats = { str=10, dex=10, con=10 },\n",
        "\tcombat_armor = 0,\n",
        "\tbody = { INVEN = 1 },\n",
        "\tlife_rating = 8,\n",
        "\trank = 2,\n",
        "\tai = \"simple\", ai_state = { talent_in=3 },\n",
        "}\n\n",
    ]
    for race in order:
        chunks.append(emit(race))
        chunks.append("\n\n")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("".join(chunks), encoding="utf-8", newline="\n")
    print("races", len(order), "->", OUT)
    write_spawns(order)


if __name__ == "__main__":
    main()
