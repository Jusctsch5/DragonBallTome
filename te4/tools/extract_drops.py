"""Build the monster drop tables from the ToME 3 sources.

Every item a theme can select is listed. Shop items stay in stock.lua.
Everything else is written to world.lua. Egos are the dball.egoify set.
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import extract_monsters as monsters
import extract_stock as stock

ROOT = Path(__file__).resolve().parents[2]
ITEMS = ROOT / "DBT" / "data" / "items" / "items.lua"
ARTIFACTS = ROOT / "DBT" / "data" / "items" / "artifacts.lua"
MONSTERS = ROOT / "DBT" / "data" / "monsters"
STOCK = ROOT / "te4" / "dbt" / "data" / "general" / "objects" / "stock.lua"
WORLD = ROOT / "te4" / "dbt" / "data" / "general" / "objects" / "world.lua"
OUT = ROOT / "te4" / "dbt" / "data" / "drops.lua"

# Theme name -> how get_themed_obj resolves it. "gold" is a zeni pile.
THEMES = {
    "TREASURE": [("gold", None)],
    "GOLD": [("gold", None)],
    "TPEOPLE": [("tval", "JUNK"), ("tval", "FOOD"), ("tval", "BATTERY"), ("gold", None)],
    "BALLISTICS": [("tval", "CLIP"), ("tval", "GUN")],
    "BRIEFS": [("tval", "HIGH_TECH_COMPONENTS"), ("tval", "BLUEPRINTS")],
    "ELECTRONICS": [("tval", "ELECTRONICS")],
    "BATTERY": [("tval", "BATTERY")],
    "JUNK": [("tval", "JUNK")],
    "FOOD": [("tval", "FOOD")],
    "BONES": [("tval", "DBT_BONES")],
    "BLUEPRINTS": [("tval", "BLUEPRINTS")],
    "ACCESSORY": [("tag", "ACCESSORY")],
    "PLAIN": [("tag", "PLAIN")],
    "MARTIAL": [("tag", "MARTIAL")],
    "CHINESE": [("tag", "CHINESE")],
    "JAPANESE": [("tag", "JAPANESE")],
    "NINJA": [("tag", "NINJA")],
    "RRA": [("tag", "MILITARY")],
    "FRENCH": [("tag", "FRENCH")],
    "POLICE": [("tag", "POLICE")],
    "NAMEK": [("tag", "NAMEK")],
    "TECHNO": [("tag", "TECHNO")],
}


def lua_quote(text):
    return monsters.lua_quote(text)


def stock_names():
    text = STOCK.read_text(encoding="utf-8")
    found = {}
    for ident, name in re.findall(r'define_as = "([^"]+)",\s*\n\tname = "([^"]+)"', text):
        found[name] = ident
    return found


def parse_items(text, names):
    items = []
    for match in re.finditer(r"\[TV_([A-Z0-9_]+)\]\s*=\s*\{", text):
        tval = match.group(1)
        if tval in ("GOLD", "CORPSE", "DBALL"):
            continue
        block = stock.brace_block(text, match.end() - 1)
        for sm in re.finditer(r"\[(SV_[A-Z0-9_]+|\d+)\]\s*=\s*\{", block):
            body = stock.brace_block(block, sm.end() - 1)
            raw = stock.quoted(body, r'name\s*=\s*"([^"]*)"') or stock.quoted(body, r"name\s*=\s*'([^']*)'")
            if not raw:
                continue
            token = sm.group(1)
            sval = token[3:] if token.startswith("SV_") else ""
            level_m = re.search(r"\blevel\s*=\s*(\d+)", body)
            level = int(level_m.group(1)) if level_m else 0
            tags = sorted(set(re.findall(r"\bITEM_([A-Z0-9_]+)\s*=", body)))
            fuel_m = re.search(r"FUEL_CAPACITY\s*=\s*(?:obvious\()?(\d+)", body)
            lite_m = re.search(r"(?<![A-Z_])LITE\s*=\s*(?:obvious\()?(\d+)", body)
            range_m = re.search(r"BASE_RANGE\s*=\s*(\d+)", body)
            items.append({
                "raw": raw,
                "id": names.get(stock.clean_name(raw)),
                "level": level,
                "tval": tval,
                "sval": sval,
                "tags": tags,
                "name": stock.clean_name(raw),
                "fuel": int(fuel_m.group(1)) if fuel_m else 0,
                "lite": int(lite_m.group(1)) if lite_m else 0,
                "range": int(range_m.group(1)) if range_m else 0,
            })
    # One row per object. Shop ids collapse to the first. Unstocked items stay distinct.
    seen = set()
    unique = []
    for item in items:
        key = item["id"] or ("raw:" + item["raw"])
        if key in seen:
            continue
        seen.add(key)
        unique.append(item)
    return unique


def parse_gold(text):
    match = re.search(r"\[TV_GOLD\]\s*=\s*\{", text)
    if not match:
        return []
    block = stock.brace_block(text, match.end() - 1)
    piles = []
    for sm in re.finditer(r"\[\d+\]\s*=\s*\{", block):
        body = stock.brace_block(block, sm.end() - 1)
        name = stock.quoted(body, r'name\s*=\s*"([^"]*)"')
        level_m = re.search(r"\blevel\s*=\s*(\d+)", body)
        value_m = re.search(r"GOLD_VALUE\s*=\s*(\d+)", body)
        if not name or not value_m:
            continue
        piles.append({
            "name": stock.clean_name(name),
            "level": int(level_m.group(1)) if level_m else 0,
            "value": int(value_m.group(1)),
            "named": ".. name" in body or " .. name" in body,
        })
    return piles


def parse_balls(text):
    balls = []
    for n in range(1, 8):
        match = re.search(r'define_as\s*=\s*"ART_DRAGONBALL%d"' % n, text)
        if not match:
            continue
        start = text.rfind("new_artifact", 0, match.start())
        open_at = text.find("{", start)
        block = stock.brace_block(text, open_at)
        name = stock.quoted(block, r'name\s*=\s*"([^"]*)"') or ("Dragonball %d" % n)
        desc_m = re.search(r"desc\s*=\s*\{(.*?)\}", block, re.S)
        desc = ""
        if desc_m:
            desc = " ".join(re.findall(r'"([^"]*)"', desc_m.group(1)))
        balls.append({"star": n, "name": stock.clean_name(name), "desc": desc})
    return balls


def parse_races():
    races = []
    seen = set()
    for path in sorted(MONSTERS.glob("*.lua")):
        if path.name.startswith("Copy"):
            continue
        text = monsters.strip_comments(path.read_text(encoding="utf-8", errors="replace"))
        for race in monsters.parse_file(path, text):
            if race["id"] in seen:
                continue
            seen.add(race["id"])
            races.append(race)
    return races


# Live path is dball.egoify: one ego, allocation weight, level <= object level.
# The duplicate define_as on the taser ego is kept as its own id so both effects exist.
EGOS = [
    {"id": "DBTEGO_WEIGHTED", "place": "before", "affix": "weighted", "level": 5, "value_add": 100,
     "tvals": ["BOOTS", "BODY_ARMOUR", "HEADPIECE", "CLOAK", "GLOVES"], "effect": "weighted",
     "desc": "Weights sewn into the material makes this an excellent training tool, but difficult to fight in."},
    {"id": "DBTEGO_FURLINED", "place": "before", "affix": "fur lined", "level": 5, "value_add": 350,
     "tvals": ["BOOTS", "BODY_ARMOUR"], "effect": "resist", "resist": "cold", "n": 10,
     "desc": "The lining shrugs off the cold."},
    {"id": "DBTEGO_DESIGNER", "place": "before", "affix": "designer", "level": 5, "value_add": 350,
     "tvals": ["BOOTS", "BODY_ARMOUR", "CLOAK", "GLOVES"], "effect": "stat", "stat": "chr", "n": 2,
     "desc": "It is cut to flatter."},
    {"id": "DBTEGO_STUDDED", "place": "before", "affix": "studded", "level": 5, "value_add": 350,
     "tvals": ["BODY_ARMOUR", "CLOAK"], "effect": "resist", "resist": "slash", "n": 10,
     "desc": "Metal studs have been woven into the fabric."},
    {"id": "DBTEGO_DARK", "place": "before", "affix": "dark", "level": 5, "value_add": 350,
     "tvals": ["BODY_ARMOUR", "CLOAK"], "effect": "stealth", "n": 1,
     "desc": "It is made of jet black cloth."},
    {"id": "DBTEGO_NEON", "place": "before", "affix": "neon", "level": 1, "value_add": 0,
     "tvals": ["BODY_ARMOUR", "CLOAK"], "effect": "stealth", "n": -1,
     "desc": "It is made of very bright cloth."},
    {"id": "DBTEGO_CLEATED", "place": "before", "affix": "cleated", "level": 5, "value_add": 350,
     "tvals": ["BOOTS"], "svals": {"BOOTS": ["TENNIS_SHOES", "LEATHER_THIGH_BOOTS"]}, "effect": "speed",
     "desc": "Cleats on the soles offer better grip."},
    {"id": "DBTEGO_SQUEAKY", "place": "before", "affix": "squeaky", "level": 1, "value_add": 0,
     "tvals": ["BOOTS"], "effect": "squeaky", "n": -5,
     "desc": "They're kind of squeaky."},
    {"id": "DBTEGO_REINFORCED", "place": "before", "affix": "reinforced", "level": 5, "value_add": 100,
     "tvals": ["BRACERS"], "effect": "to_a", "n": 5,
     "desc": "Extra reinforcement provides extra protection."},
    {"id": "DBTEGO_SPIKED", "place": "before", "affix": "spiked", "level": 5, "value_add": 100,
     "tvals": ["BRACERS"], "svals": {"BRACERS": ["LIGHT_LEATHER_BRACERS", "HEAVY_LEATHER_BRACERS", "STEEL_BRACERS"]},
     "effect": "spike", "desc": "Small metal spikes in these bracers allows you to damage your opponent when you block his attacks."},
    {"id": "DBTEGO_VISORED", "place": "before", "affix": "visored", "level": 5, "value_add": 100,
     "tvals": ["HEADPIECE"], "svals": {"HEADPIECE": ["SAMURAI_HELM"]}, "effect": "res_blind",
     "desc": "This item features a transparent visor to protect your eyes."},
    {"id": "DBTEGO_SERATED", "place": "before", "affix": "serated", "level": 15, "value_add": 2000, "to_d": 10,
     "tvals": ["POLEARM", "SMALLARM", "SWORDARM"],
     "svals": {"POLEARM": ["SPEAR", "PUDAO"], "SMALLARM": ["KNIFE", "MINI_BUTTERFLY_KNIFE", "NINJA_CLAW", "KAMA", "IRON_FAN"],
               "SWORDARM": ["BUTTERFLY_KNIFE", "STRAIGHTSWORD", "SABRE", "WAKAZASHI", "KATANA", "TAI_CHI_SWORD", "NINJA_TO", "HOOK_SWORD"]},
     "effect": "vorpal", "desc": "The edge is cut into a saw."},
    {"id": "DBTEGO_CHANNELED", "place": "before", "affix": "channeled", "level": 10, "value_add": 750,
     "tvals": ["SWORDARM"],
     "svals": {"SWORDARM": ["BUTTERFLY_KNIFE", "STRAIGHTSWORD", "SABRE", "WAKAZASHI", "KATANA", "TAI_CHI_SWORD", "NINJA_TO", "HOOK_SWORD"]},
     "effect": "vorpal", "desc": "The blade has a blood channel in it."},
    {"id": "DBTEGO_STEEL", "place": "before", "affix": "steel", "level": 15, "value_add": 1000,
     "tvals": ["POLEARM", "SMALLARM", "SWORDARM"],
     "svals": {"POLEARM": ["BO_STAFF", "THREE_SECTIONAL_STAFF"], "SMALLARM": ["NUNCHAKU", "KUBOTAN", "ESCRIMA_STICK", "TONFA", "SANJOBANG"],
               "SWORDARM": ["BOKKEN", "SHINAI"]},
     "effect": "steel", "desc": "Solid metal rather than wood construction makes this weapon slow and heavy, but hard-hitting."},
    {"id": "DBTEGO_POORLY_MADE", "place": "before", "affix": "poorly made", "level": 1, "value_add": 0,
     "tvals": ["POLEARM", "ENTANGLEARM", "SMALLARM", "SWORDARM"], "effect": "poor", "n": -5,
     "desc": "This weapon seems to be balanced strangely."},
    {"id": "DBTEGO_HIGH_VELOCITY", "place": "before", "affix": "high velocity", "level": 20, "value_add": 2000, "to_d": 10,
     "tvals": ["GUN", "SHOTGUN"], "effect": "range", "n": 5,
     "desc": "Increased muzzle velocity for greater damage and range."},
    {"id": "DBTEGO_GUN_HIGH_CAPACITY", "place": "before", "affix": "high capacity", "level": 20, "value_add": 2000, "to_d": 10,
     "tvals": ["GUN", "SHOTGUN"], "effect": "capacity"},
    {"id": "DBTEGO_GUN_WILDLY_INACCURATE", "place": "before", "affix": "wildly inaccurate", "level": 20, "value_add": 0, "to_d": 10,
     "tvals": ["GUN", "SHOTGUN"], "effect": "inaccurate",
     "desc": "This weapon gives too much kick to target accurately."},
    {"id": "DBTEGO_MINT", "place": "after", "affix": "in mint condition", "level": 1, "value_add": 200,
     "tvals": ["JUNK"], "svals": {"JUNK": ["COMIC_BOOK", "MANGA"]},
     "desc": "It is in flawless condition, as if freshly minted."},
    {"id": "DBTEGO_RARE", "place": "before", "affix": "rare", "level": 1, "value_add": 200,
     "tvals": ["JUNK"], "svals": {"JUNK": ["COMIC_BOOK", "MANGA"]},
     "desc": "A hard to find issue."},
    {"id": "DBTEGO_MOLDY", "place": "before", "affix": "moldy", "level": 1, "value_add": 0,
     "tvals": ["FOOD"], "effect": "price", "n": -10,
     "desc": "It is covered with mold."},
    {"id": "DBTEGO_BRIGHT", "place": "before", "affix": "bright", "level": 5, "value_add": 200,
     "tvals": ["LITE"], "effect": "lite",
     "desc": "This flashlight seems brighter than most."},
    {"id": "DBTEGO_LITE_HIGH_CAPACITY", "place": "before", "affix": "high capacity", "level": 5, "value_add": 100,
     "tvals": ["LITE"], "svals": {"LITE": ["FLASHLIGHT", "MAGLIGHT"]}, "effect": "fuel"},
    {"id": "DBTEGO_TOOL_HIGH_CAPACITY", "place": "before", "affix": "high capacity", "level": 27, "value_add": 800,
     "tvals": ["ELECTRONICS"],
     "svals": {"ELECTRONICS": ["LASER_POINTER", "MEGAPHONE", "FIRE_EXTINGUISHER", "FLAME_THROWER", "BLOWTORCH", "JETPACK"]},
     "effect": "fuel"},
    {"id": "DBTEGO_HIGH_VOLTAGE", "place": "before", "affix": "high voltage", "level": 32, "value_add": 2000,
     "tvals": ["SMALLARM"], "svals": {"SMALLARM": ["TASER", "STUN_BATON", "CATTLE_PROD"]}, "effect": "stun"},
]


def lua_choices(choices):
    parts = []
    for kind, ident in choices:
        if ident is None:
            parts.append('{kind="gold"}')
        else:
            parts.append('{kind=%s, id=%s}' % (lua_quote(kind), lua_quote(ident)))
    return ", ".join(parts)


def lua_ego(ego):
    tvals = ", ".join("%s=true" % name for name in ego["tvals"])
    svals = "nil"
    if ego.get("svals"):
        groups = []
        for tval, names in ego["svals"].items():
            groups.append("%s={%s}" % (tval, ", ".join(lua_quote(name) for name in names)))
        svals = "{%s}" % ", ".join(groups)
    fields = [
        "id=%s" % lua_quote(ego["id"]),
        "place=%s" % lua_quote(ego["place"]),
        "affix=%s" % lua_quote(ego["affix"]),
        "level=%d" % ego["level"],
        "alloc=100",
        "value_add=%d" % ego.get("value_add", 0),
        "to_h=%d" % ego.get("to_h", 0),
        "to_d=%d" % ego.get("to_d", 0),
        "tvals={%s}" % tvals,
        "svals=%s" % svals,
        "effect=%s" % lua_quote(ego.get("effect") or ""),
        "desc=%s" % lua_quote(ego.get("desc") or ""),
    ]
    if ego.get("resist"):
        fields.append("resist=%s" % lua_quote(ego["resist"]))
    if ego.get("stat"):
        fields.append("stat=%s" % lua_quote(ego["stat"]))
    if "n" in ego:
        fields.append("n=%d" % ego["n"])
    return "\t{%s}," % ", ".join(fields)


def main():
    raw_items = stock.strip_comments(ITEMS.read_text(encoding="utf-8", errors="replace"))
    names = stock_names()
    items = parse_items(raw_items, names)
    bodies = {}
    for raw, body in stock.parse_items(raw_items).items():
        if raw == body["raw"] and body["kind"] not in ("money", "corpses"):
            bodies.setdefault(body["name"], body)
    used = set(names.values())
    world = []
    for item in items:
        if item["id"]:
            continue
        body = bodies.get(item["name"])
        if not body:
            continue
        ident = stock.slug(item["raw"], used)
        item["id"] = ident
        world.append((ident, body))
    gold = parse_gold(raw_items)
    balls = parse_balls(stock.strip_comments(ARTIFACTS.read_text(encoding="utf-8", errors="replace")))
    races = parse_races()

    by_name = {}
    for item in items:
        if item["id"] and item["name"] not in by_name:
            by_name[item["name"]] = item["id"]
    sushi = []
    for label in ("piece of unagi", "piece of anago", "piece of saba", "piece of takko", "piece of fugu"):
        ident = by_name.get(label)
        if ident:
            sushi.append(ident)
    waste = by_name.get("small nuclear waste canister")

    world_lines = [
        "-- Generated by te4/tools/extract_drops.py. Items that are not shop stock.",
        "",
    ]
    world_lines.extend(stock.emit_object(ident, body) + "\n" for ident, body in world)
    WORLD.write_text("\n".join(world_lines), encoding="utf-8", newline="\n")

    lines = [
        "-- Monster drops. Generated by te4/tools/extract_drops.py.",
        "-- Themes are default_monster_drop. Egos are dball.egoify.",
        "dbt_drop_themes = {",
    ]
    for name in sorted(THEMES):
        lines.append("\t%s = {%s}," % (name, lua_choices(THEMES[name])))
    if sushi:
        lines.append("\tSUSHI = {%s}," % ", ".join('{kind="id", id=%s}' % lua_quote(i) for i in sushi))
    if waste:
        lines.append('\tTOXIC = {{kind="id", id=%s}},' % lua_quote(waste))
    lines.append("}")
    lines.append("dbt_drop_items = {")
    listed = 0
    for item in items:
        if not item["id"]:
            continue
        listed += 1
        tag_lua = ", ".join("%s=true" % tag for tag in item["tags"])
        lines.append("\t{id=%s, level=%d, tval=%s, sval=%s, fuel=%d, lite=%d, range=%d, tags={%s}}," % (
            lua_quote(item["id"]), item["level"], lua_quote(item["tval"]), lua_quote(item["sval"]),
            item["fuel"], item["lite"], item["range"], tag_lua))
    lines.append("}")
    lines.append("dbt_drop_by_id = {}")
    lines.append("for _, item in ipairs(dbt_drop_items) do dbt_drop_by_id[item.id] = item end")
    lines.append("dbt_egos = {")
    for ego in EGOS:
        lines.append(lua_ego(ego))
    lines.append("}")
    lines.append("dbt_gold = {")
    for pile in gold:
        lines.append("\t{name=%s, level=%d, value=%d, named=%s}," % (
            lua_quote(pile["name"]), pile["level"], pile["value"], "true" if pile["named"] else "false"))
    lines.append("}")
    lines.append("dbt_dragonballs = {")
    for ball in balls:
        lines.append("\t{star=%d, name=%s, desc=%s}," % (ball["star"], lua_quote(ball["name"]), lua_quote(ball["desc"])))
    lines.append("}")
    lines.append("dbt_drop_races = {")
    dropping = 0
    for race in races:
        themes = race["drop_themes"]
        if not themes and not race["drop60"] and not race["drop90"] and race["drop_lo"] is None and not race["unique"]:
            if not race["animal"] and not race["force_corpse"]:
                continue
        dropping += 1
        theme_lua = ", ".join("%s=%d" % (name, themes[name]) for name in sorted(themes))
        lo = "nil" if race["drop_lo"] is None else str(race["drop_lo"])
        hi = "nil" if race["drop_hi"] is None else str(race["drop_hi"])
        ball = "nil" if race["ball"] is None else str(race["ball"])
        def flag(key):
            return "true" if race[key] else "false"
        lines.append(
            "\t[%s] = {themes={%s}, drop60=%s, drop90=%s, lo=%s, hi=%s, only_gold=%s, only_item=%s, animal=%s, plant=%s, immortal=%s, no_ball=%s, ball=%s, unique=%s, no_corpse=%s, force_corpse=%s},"
            % (
                lua_quote(race["id"]), theme_lua,
                flag("drop60"), flag("drop90"), lo, hi,
                flag("only_gold"), flag("only_item"),
                flag("animal"), flag("plant"), flag("immortal"), flag("no_ball"), ball,
                flag("unique"), flag("no_corpse"), flag("force_corpse"),
            )
        )
    lines.append("}")
    lines.append("")
    OUT.write_text("\n".join(lines), encoding="utf-8", newline="\n")
    print("items", listed, "world", len(world), "gold", len(gold), "balls", len(balls), "egos", len(EGOS), "races", dropping)


if __name__ == "__main__":
    main()
