-- City sewers. Monsters with ALLOW_IN_SEWERS, except SPECIAL_GENE mice.
-- Splinter's classes are his enrollment block. Chi stays at 5 until he has taught you once.

dbt_sewer_monsters = {
	{id="RACE_I_DRAGONFLY", level=2, rarity=1},
	{id="RACE_R_SMALL_RAT", level=3, rarity=1},
	{id="RACE_R_LARGE_RAT", level=5, rarity=1},
	{id="RACE_I_LARGE_COCHROACH", level=5, rarity=2},
	{id="RACE_S_SMALL_SNAKE", level=5, rarity=1},
	{id="RACE_FLORINIFERA", level=6, rarity=1},
	{id="RACE_R_MUTANT_RAT", level=7, rarity=2},
	{id="RACE_S_LARGE_SNAKE", level=7, rarity=1},
	{id="RACE_I_MUTANT_COCHROACH", level=7, rarity=2},
	{id="RACE_I_SPIDER", level=7, rarity=2},
	{id="RACE_I_LARGE_SPIDER", level=17, rarity=2},
	{id="RACE_BEAR_THIEF", level=21, rarity=1, unique=true},
	{id="RACE_I_GIANT_SPIDER", level=22, rarity=2},
	{id="RACE_I_MASSIVE_BLOATED_GROTESQUE_SPIDER", level=32, rarity=2},
	{id="RACE_BOJACK", level=35, rarity=1, unique=true},
}

if dbt_schools then
	dbt_schools.SPLINTER = {
		name = "Splinter",
		cost = 0,
		classes = {
			{type="skill", skill="stealth", gain=1000, skcost=1, cap=100, key="t", reqtxt="", req={}},
			{type="ability", skill="sneak", gain=0, skcost=10, cap=0, key="n", reqtxt="", req={}},
			{type="ability", skill="paired_weapons", gain=0, skcost=20, cap=0, key="p", reqtxt="Requires 40 Weapons", req={{kind="skill", skill="weapons", n=40000}}},
			{type="skill", skill="chi", gain=1000, skcost=1, cap=5, key="c", reqtxt="", req={}},
			{type="skill", skill="chi_gung", gain=1000, skcost=1, cap=5, key="g", reqtxt="", req={}},
		},
	}
end
dbt_cap_step = dbt_cap_step or {}
dbt_cap_step.SPLINTER = {chi = 5, chi_gung = 5}
