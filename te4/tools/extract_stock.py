"""Pull plain items sold by Earth stores into ToME 4 entity lists.

Reads DBT/data/items/items.lua and DBT/data/stores/stores.lua. Egos,
identification, and stat bonuses are left out. Armor class and weapon
damage dice are kept, because those already affect the current combat.
"""

import os
import re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
DBT = os.path.join(ROOT, "DBT", "data")
OUT = os.path.join(ROOT, "te4", "dbt", "data")

BIRTH_IDS = {
    "& kubotan": "KUBOTAN",
    "& set~ of streetclothes": "STREET_CLOTHES",
    "& pair~ of tennis shoes": "TENNIS_SHOES",
    "& pair~ of high heels": "HIGH_HEELS",
    "& power bar~": "POWER_BAR",
}

COLORS = {
    "WHITE": (255, 255, 255),
    "SLATE": (168, 168, 168),
    "UMBER": (140, 100, 50),
    "LIGHT_UMBER": (196, 148, 90),
    "DARK_UMBER": (90, 60, 30),
    "RED": (220, 40, 40),
    "LIGHT_RED": (255, 120, 120),
    "DARK_RED": (140, 20, 20),
    "GREEN": (40, 160, 40),
    "LIGHT_GREEN": (120, 220, 120),
    "DARK_GREEN": (20, 90, 20),
    "BLUE": (60, 80, 220),
    "LIGHT_BLUE": (120, 170, 255),
    "DARK_BLUE": (20, 30, 120),
    "YELLOW": (230, 210, 40),
    "ORANGE": (230, 140, 30),
    "PINK": (255, 150, 190),
    "VIOLET": (170, 80, 220),
    "GREY": (150, 150, 150),
    "GRAY": (150, 150, 150),
    "DARK_GREY": (80, 80, 80),
    "DARK_GRAY": (80, 80, 80),
    "LIGHT_DARK": (110, 110, 110),
    "AQUA": (40, 210, 210),
    "TEAL": (30, 150, 150),
    "BLACK": (20, 20, 20),
}


def strip_comments(text):
    text = re.sub(r"--\[\[.*?\]\]", "", text, flags=re.S)
    out = []
    for line in text.splitlines():
        cut = line
        quote = None
        i = 0
        while i < len(line) - 1:
            c = line[i]
            if quote:
                if c == "\\":
                    i += 2
                    continue
                if c == quote:
                    quote = None
            elif c in ("'", '"'):
                quote = c
            elif c == "-" and line[i + 1] == "-":
                cut = line[:i]
                break
            i += 1
        out.append(cut)
    return "\n".join(out)


def brace_block(text, open_at):
    depth = 0
    quote = None
    i = open_at
    while i < len(text):
        c = text[i]
        if quote:
            if c == "\\":
                i += 2
                continue
            if c == quote:
                quote = None
            i += 1
            continue
        if c in ("'", '"'):
            quote = c
        elif c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return text[open_at + 1:i]
        i += 1
    return ""


def quoted(text, pattern):
    m = re.search(pattern, text)
    if not m:
        return None
    return m.group(1)


def lua_quote(text):
    return '"' + text.replace("\\", "\\\\").replace('"', '\\"').replace("\n", " ") + '"'


def clean_name(raw):
    name = raw.strip()
    if name.startswith("&"):
        name = name[1:].strip()
    name = name.replace("~", "")
    return re.sub(r"\s*#\s*$", "", name).strip()


def slug(raw, used):
    if raw in BIRTH_IDS:
        ident = BIRTH_IDS[raw]
    else:
        ident = re.sub(r"[^A-Za-z0-9]+", "_", clean_name(raw)).strip("_").upper()
        if not ident or ident[0].isdigit():
            ident = "ITEM_" + ident
    base = ident
    n = 2
    while ident in used:
        ident = "%s_%d" % (base, n)
        n += 1
    used.add(ident)
    return ident


def parse_items(text):
    items = {}
    for match in re.finditer(r"\[TV_[A-Z0-9_]+\]\s*=\s*\{", text):
        block = brace_block(text, match.end() - 1)
        head = block.split("[SV_", 1)[0]
        kind = quoted(head, r'name\s*=\s*"([^"]*)"') or quoted(head, r"name\s*=\s*'([^']*)'") or "item"
        defaults = ""
        dmatch = re.search(r"defaults\s*=\s*\{", head)
        if dmatch:
            defaults = brace_block(head, head.find("{", dmatch.start()))
        slot_m = re.search(r"WIELD_SLOT\s*=\s*INVEN_([A-Z0-9_]+)", defaults)
        default_slot = slot_m.group(1) if slot_m else None
        default_disp = quoted(defaults, r"display\s*=\s*'([^']*)'") or quoted(defaults, r'display\s*=\s*"([^"]*)"') or quoted(head, r"symbol\s*=\s*'([^']*)'") or "?"
        default_color_m = re.search(r"\bcolor\s*=\s*color\.([A-Z0-9_]+)", defaults) or re.search(r"\bcolor\s*=\s*color\.([A-Z0-9_]+)", head)
        default_color = default_color_m.group(1) if default_color_m else "WHITE"
        for sm in re.finditer(r"\[(?:SV_[A-Z0-9_]+|\d+)\]\s*=\s*\{", block):
            body = brace_block(block, sm.end() - 1)
            raw = quoted(body, r'name\s*=\s*"([^"]*)"') or quoted(body, r"name\s*=\s*'([^']*)'")
            if not raw:
                continue
            slot_m = re.search(r"WIELD_SLOT\s*=\s*INVEN_([A-Z0-9_]+)", body)
            slot = slot_m.group(1) if slot_m else default_slot
            if slot == "INVEN":
                slot = None
            cost_m = re.search(r"\bcost\s*=\s*(\d+)", body)
            weight_m = re.search(r"\bweight\s*=\s*(\d+)", body)
            ac_m = re.search(r"\bac\s*=\s*(\d+)", body)
            disp = quoted(body, r"display\s*=\s*'([^']*)'") or quoted(body, r'display\s*=\s*"([^"]*)"') or default_disp
            if len(disp) != 1:
                disp = "?"
            color_m = re.search(r"\bcolor\s*=\s*color\.([A-Z0-9_]+)", body)
            desc_m = re.search(r"desc\s*=\s*\{(.*?)\}", body, re.S)
            desc = ""
            if desc_m:
                desc = " ".join(re.findall(r'"([^"]*)"', desc_m.group(1)))
            def best_dice(marker):
                at = re.search(marker, body)
                if not at:
                    return None
                chunk = brace_block(body, body.find("{", at.start()))
                pairs = [(int(a), int(b)) for a, b in re.findall(r"\{(\d+)\s*,\s*(\d+)", chunk)]
                if not pairs:
                    return None
                lo, hi = max(pairs, key=lambda pair: (pair[0] + pair[1]) // 2)
                avg = max(1, (lo + hi) // 2)
                return lo, hi, avg

            blow_m = re.search(r"DAM\s*=\s*getter\.damages\s*\{\s*([A-Z_]+)", body)
            dice = best_dice(r"DAM\s*=\s*getter\.damages\s*\{")
            ammo = best_dice(r"AMMO_DAMAGE\s*=\s*getter\.damages\s*\{")
            diff_m = re.search(r"DIFFICULTY\s*=\s*(\d+)", body)
            mult_m = re.search(r"MULTIPLIER\s*=\s*(\d+)", body)
            cap_m = re.search(r"AMMO_CAPACITY\s*=\s*(?:obvious\()?(\d+)", body)
            firearm = "MISSILE_WEAPON" in body or "MISSILE_WEAPON" in defaults
            dam = dice[2] if dice else None
            food = "ON_EAT" in body or "FOOD_VALUE" in body
            readable = "ON_READ" in body
            food_m = re.search(r"FOOD_VALUE\s*=\s*(\d+)", body)
            heal = None
            if food:
                value = int(food_m.group(1)) if food_m else 500
                heal = max(4, value // 200)
            items[raw] = {
                "raw": raw,
                "name": clean_name(raw),
                "kind": kind,
                "slot": slot,
                "cost": int(cost_m.group(1)) if cost_m else 0,
                "weight": int(weight_m.group(1)) if weight_m else 1,
                "ac": int(ac_m.group(1)) if ac_m else 0,
                "display": disp,
                "color": color_m.group(1) if color_m else default_color,
                "desc": desc or clean_name(raw),
                "dam": dam,
                "dice": (dice[0], dice[1]) if dice else None,
                "blow": blow_m.group(1).lower() if blow_m else None,
                "difficulty": int(diff_m.group(1)) if diff_m else 0,
                "firearm": firearm and not ammo,
                "multiplier": int(mult_m.group(1)) if mult_m else 1,
                "capacity": int(cap_m.group(1)) if cap_m else 0,
                "ammo": (ammo[0], ammo[1]) if ammo else None,
                "rounds": 12 if ammo and "clip" in clean_name(raw) else 1,
                "pierce": "FLAG_AMMO_AP" in body,
                "heal": heal,
                "read": readable,
                "female_only": 'get_sex() ~= "Female"' in body,
            }
    return items


def parse_stores(text):
    stores = []
    for match in re.finditer(r"define_as\s*=\s*\"store\.([A-Z0-9_]+)\"", text):
        # Walk back to the new_store brace and take that block.
        start = text.rfind("new_store", 0, match.start())
        if start < 0:
            continue
        open_at = text.find("{", start)
        block = brace_block(text, open_at)
        name = quoted(block, r'name\s*=\s*"([^"]*)"') or match.group(1)
        kinds = []
        seen = set()
        for item in re.findall(r'item\s*=\s*"([^"]*)"', block):
            base = item.split("#", 1)[0].strip()
            if base and base not in seen:
                seen.add(base)
                kinds.append(base)
        stores.append({"id": match.group(1), "name": name, "items": kinds})
    return stores


def emit_object(ident, item):
    r, g, b = COLORS.get(item["color"], (255, 255, 255))
    lines = [
        "newEntity{",
        "\tdefine_as = %s," % lua_quote(ident),
        "\tname = %s," % lua_quote(item["name"]),
        "\ttype = %s, subtype = %s," % (lua_quote(item["kind"]), lua_quote(item["kind"])),
        "\tdisplay = %s, color_r=%d, color_g=%d, color_b=%d," % (lua_quote(item["display"]), r, g, b),
        "\tencumber = %d," % max(0, item["weight"]),
        "\tcost = %d," % item["cost"],
    ]
    if item["slot"]:
        lines.append("\tslot = %s," % lua_quote(item["slot"]))
    if item["female_only"]:
        lines.append("\tfemale_only = true,")
    if item["dice"] and not item["firearm"]:
        lo, hi = item["dice"]
        lines.append("\tcombat = { dam = %d, dice = {%d, %d} }," % (item["dam"], lo, hi))
        lines.append('\tdbt_kind = "weapon",')
        if item["blow"] in ("pierce", "slash", "crush"):
            lines.append("\tdbt_blow = %s," % lua_quote(item["blow"]))
    elif item["firearm"]:
        lines.append('\tdbt_kind = "firearm",')
    if item["difficulty"]:
        lines.append("\tdifficulty = %d," % item["difficulty"])
    if item["firearm"]:
        lines.append("\tmultiplier = %d," % item["multiplier"])
        if item["capacity"]:
            lines.append("\tcapacity = %d," % item["capacity"])
    if item["ammo"]:
        lo, hi = item["ammo"]
        lines.append("\tdbt_ammo = {%d, %d}," % (lo, hi))
        lines.append("\tdbt_rounds = %d," % item["rounds"])
        if item["pierce"]:
            lines.append("\tdbt_pierce = true,")
    if item["ac"]:
        lines.append("\twielder = { combat_armor = %d }," % item["ac"])
    if item["heal"]:
        lines.append("\tdbt_use = \"eat\",")
        lines.append("\theal = %d," % item["heal"])
    elif item["read"]:
        lines.append("\tdbt_use = \"read\",")
    lines.append("\tdesc = %s," % lua_quote(item["desc"]))
    lines.append("}")
    return "\n".join(lines)


def main():
    parsed = parse_items(strip_comments(open(os.path.join(DBT, "items", "items.lua"), encoding="utf-8", errors="replace").read()))
    items = {}
    for raw, item in parsed.items():
        items[raw] = item
        items.setdefault(raw.split("#", 1)[0].strip(), item)
    stores = parse_stores(strip_comments(open(os.path.join(DBT, "stores", "stores.lua"), encoding="utf-8", errors="replace").read()))
    used = set()
    by_raw = {}
    missing = []
    wanted = set()
    for store in stores:
        for raw in store["items"]:
            wanted.add(raw)
    # Birth kit must exist even if some shop forgot it.
    for raw in BIRTH_IDS:
        wanted.add(raw)
    ordered = []
    for raw in sorted(wanted):
        item = items.get(raw)
        if not item:
            missing.append(raw)
            continue
        ident = slug(raw, used)
        item["id"] = ident
        by_raw[raw] = ident
        ordered.append(item)

    obj_path = os.path.join(OUT, "general", "objects", "stock.lua")
    parts = [
        "-- Generated by te4/tools/extract_stock.py. Plain shop items, no egos.",
        "-- Armor and weapon damage are the base item. Stat bonuses wait for the stat pass.",
        "",
    ]
    parts.extend(emit_object(item["id"], item) + "\n" for item in ordered)
    open(obj_path, "w", encoding="utf-8", newline="\n").write("\n".join(parts))

    store_lines = [
        "-- Generated by te4/tools/extract_stock.py.",
        "dbt_stores = {",
    ]
    stocked = []
    for store in stores:
        ids = [by_raw[raw] for raw in store["items"] if raw in by_raw]
        if not ids:
            continue
        stocked.append(store["id"])
        store_lines.append("\t%s = {" % store["id"])
        store_lines.append("\t\tname = %s," % lua_quote(store["name"]))
        store_lines.append("\t\titems = {%s}," % ", ".join(lua_quote(i) for i in ids))
        store_lines.append("\t},")
    store_lines.append("}")
    store_lines.append("")
    open(os.path.join(OUT, "stores.lua"), "w", encoding="utf-8", newline="\n").write("\n".join(store_lines))

    print("items defined", len(items))
    print("shop objects", len(ordered))
    print("stores with stock", len(stocked))
    print("missing", len(missing))
    for raw in missing:
        print("  MISSING", raw)


if __name__ == "__main__":
    main()
