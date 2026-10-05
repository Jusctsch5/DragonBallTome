"""Build the World Tournament zone from DBT/data/maps/tournament.map."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
src = (ROOT / "DBT" / "data" / "maps" / "tournament.map").read_text(encoding="utf-8", errors="replace")
at = src.find("map.map")
rows = re.findall(r"\[\[(.*?)\]\]", src[at:])
width = len(rows[0])
if any(len(r) != width for r in rows):
    raise SystemExit("ragged tournament map")
print("size", width, len(rows))
for y, row in enumerate(rows):
    print("%2d %s" % (y, row))
print("set_player 24,3", rows[3][24] if len(rows) > 3 else "?")
print("seal 20,10", rows[10][20] if len(rows) > 10 else "?")
print("player ring 13,18", rows[18][13] if len(rows) > 18 else "?")
print("fighter 13,26", rows[26][13] if len(rows) > 26 else "?")

FEATS = {
    ".": "OUTSIDE_RING",
    "*": "MAP_BORDER",
    "X": "WALL",
    "-": "RING",
    "f": "WT_BLOCKER",
    "g": "WT_DOOR",
    "i": "RING_EDGE",
    "w": "WALL",
    "<": "UP_EARTH",
}
MONSTERS = {
    "a": "WT_TICKET",
    "b": "WT_GUARD",
    "c": "WT_AUDIENCE",
    "d": "WT_AUDIENCE",
    "e": "WT_AUDIENCE",
    "h": "WT_BACKSTAGE",
    "m": "WT_MEDIC",
}

out = ROOT / "te4" / "dbt" / "data" / "zones" / "tournament"
(out / "maps").mkdir(parents=True, exist_ok=True)
seen = []
for row in rows:
    for ch in row:
        if ch not in seen:
            seen.append(ch)
lines = ["-- World Tournament, from DBT/data/maps/tournament.map.", ""]
for ch in seen:
    feat = FEATS.get(ch, "FLOOR")
    mon = MONSTERS.get(ch)
    if mon:
        lines.append('defineTile("%s", "%s", nil, "%s")' % (ch, feat, mon))
    else:
        lines.append('defineTile("%s", "%s")' % (ch, feat))
lines += ["", "startx = 24", "starty = 3", "endx = 24", "endy = 3", "", "return [[" + "\n".join(rows) + "]]", ""]
(out / "maps" / "map.lua").write_text("\n".join(lines) + "\n", encoding="utf-8")
(out / "grids.lua").write_text('load("/data/general/grids/basic.lua")\n', encoding="utf-8")
(out / "npcs.lua").write_text('load("/data/general/npcs/tournament.lua")\n', encoding="utf-8")
(out / "zone.lua").write_text(
    """return {
	name = "World Tournament",
	level_range = {1, 1},
	max_level = 1,
	width = %d, height = %d,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = {
		map = {
			class = "engine.generator.map.Static",
			map = "!map",
		},
	},
}
""" % (width, len(rows)),
    encoding="utf-8",
)
print("wrote", out)
