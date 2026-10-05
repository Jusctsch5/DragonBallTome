-- Rosshi, Crane, Musashi, and the Abbot. Caps that jump from 5 to 10 on enrollment are stored at 10,
-- because the trainer only opens after he has accepted you.
dbt_masters = true

dbt_temple_monsters = {
	{id="RACE_CORRUPT_MONK_A", level=17, rarity=1},
	{id="RACE_CORRUPT_MONK_B", level=19, rarity=1},
	{id="RACE_CORRUPT_MONK_C", level=21, rarity=1},
	{id="RACE_CORRUPT_MONK_D", level=23, rarity=1},
	{id="RACE_MONK_RINGLEADER", level=25, rarity=999},
}

if dbt_schools then
	dbt_schools.ROSSHI = {
		name = "Master Rosshi",
		cost = 0,
		classes = {
			{type="skill", skill="martialarts", gain=500, skcost=1, cap=30, key="m", reqtxt="", req={}},
			{type="skill", skill="strength", gain=500, skcost=1, cap=10, key="s", reqtxt="", req={}},
			{type="skill", skill="constitution", gain=500, skcost=1, cap=10, key="c", reqtxt="", req={}},
			{type="ability", skill="double_attack", gain=0, skcost=20, cap=0, key="d", reqtxt="Requires 40 Barehand", req={{kind="skill", skill="hand", n=40000}}},
			{type="skill", skill="chi", gain=1000, skcost=1, cap=10, key="i", reqtxt="", req={}},
			{type="skill", skill="chi_offense", gain=1000, skcost=1, cap=10, key="o", reqtxt="", req={}},
			{type="skill", skill="chi_regeneration", gain=1000, skcost=1, cap=10, key="r", reqtxt="", req={}},
			{type="skill", skill="chi_gung", gain=1000, skcost=1, cap=10, key="g", reqtxt="", req={}},
			{type="ability", skill="chi_burst", gain=0, skcost=10, cap=0, key="t", reqtxt="", req={}},
			{type="ability", skill="light", gain=0, skcost=2, cap=0, key="l", reqtxt="", req={}},
		},
	}
	dbt_schools.CRANE_HERMIT = {
		name = "Crane Hermit",
		cost = 0,
		classes = {
			{type="skill", skill="martialarts", gain=500, skcost=1, cap=30, key="m", reqtxt="", req={}},
			{type="skill", skill="dexterity", gain=400, skcost=1, cap=20, key="d", reqtxt="", req={}},
			{type="skill", skill="speed", gain=400, skcost=1, cap=5, key="s", reqtxt="", req={}},
			{type="ability", skill="blocking", gain=0, skcost=10, cap=0, key="b", reqtxt="Requires 40 Barehand", req={{kind="skill", skill="hand", n=40000}}},
			{type="skill", skill="chi", gain=1000, skcost=1, cap=10, key="i", reqtxt="", req={}},
			{type="skill", skill="chi_defense", gain=1000, skcost=1, cap=10, key="f", reqtxt="", req={}},
			{type="skill", skill="chi_regeneration", gain=1000, skcost=1, cap=10, key="r", reqtxt="", req={}},
			{type="skill", skill="chi_gung", gain=1000, skcost=1, cap=10, key="g", reqtxt="", req={}},
			{type="ability", skill="light", gain=0, skcost=2, cap=0, key="l", reqtxt="", req={}},
			{type="ability", skill="flight", gain=0, skcost=10, cap=0, key="t", reqtxt="", req={}},
		},
	}
	dbt_schools.MUSASHI = {
		name = "Musashi",
		cost = 0,
		classes = {
			{type="skill", skill="weapons", gain=700, skcost=1, cap=60, key="w", reqtxt="Requires 40 Weapons", req={{kind="skill", skill="weapons", n=40000}}},
			{type="skill", skill="parrying", gain=1000, skcost=1, cap=100, key="p", reqtxt="Requires 40 Weapons", req={{kind="skill", skill="weapons", n=40000}}},
			{type="skill", skill="dexterity", gain=300, skcost=1, cap=100, key="d", reqtxt="Requires 40 Weapons", req={{kind="skill", skill="weapons", n=40000}}},
			{type="skill", skill="speed", gain=300, skcost=1, cap=60, key="s", reqtxt="Requires 40 Weapons", req={{kind="skill", skill="weapons", n=40000}}},
			{type="ability", skill="paired_weapons", gain=0, skcost=10, cap=0, key="d2", reqtxt="Requires 40 Weapons", req={{kind="skill", skill="weapons", n=40000}}},
			{type="ability", skill="iaijutsu", gain=0, skcost=5, cap=0, key="i", reqtxt="Requires 40 Weapons", req={{kind="skill", skill="weapons", n=40000}}},
			{type="ability", skill="bleed_attack", gain=0, skcost=10, cap=0, key="b", reqtxt="Requires 40 Weapons", req={{kind="skill", skill="weapons", n=40000}}},
		},
	}
	dbt_schools.ABBOT = {
		name = "The Abbot",
		cost = 0,
		classes = {
			{type="ability", skill="meditation", gain=0, skcost=10, cap=0, key="m", reqtxt="", req={}},
			{type="skill", skill="chi", gain=1000, skcost=1, cap=10, key="i", reqtxt="", req={}},
			{type="skill", skill="chi_offense", gain=1000, skcost=1, cap=10, key="f", reqtxt="", req={}},
			{type="skill", skill="chi_defense", gain=1000, skcost=1, cap=10, key="d", reqtxt="", req={}},
			{type="skill", skill="chi_regeneration", gain=1000, skcost=1, cap=10, key="r", reqtxt="", req={}},
			{type="skill", skill="chi_gung", gain=1000, skcost=1, cap=10, key="g", reqtxt="", req={}},
		},
	}
end
