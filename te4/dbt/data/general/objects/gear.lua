-- The birth note. Clothes, the kubotan, shoes, and the power bar come from stock.lua.

newEntity{
	define_as = "SLICE_NOTE",
	name = "note",
	type = "scroll", subtype = "paper",
	display = "?", color=colors.LIGHT_BLUE,
	encumber = 0,
	cost = 0,
	desc = "This is the ToME 4 port of Dragonball T. Life is Constitution times your level. Armor makes attacks miss. Press a, then a direction, to attack. Press c, then a direction, to talk. Shift-c opens your stats. k skills, j quests, m chi, i pack, g pickup, Shift-d drop, w wear, t take off, u use, f fire a gun. Walk onto a shop door to buy. In a school, press e to train. Press c there to challenge the instructor.",
}

newEntity{
	define_as = "NYOIBO",
	name = "Nyoi-bo",
	type = "staff", subtype = "polearm",
	display = "\\", color=colors.LIGHT_RED,
	encumber = 30,
	cost = 10000,
	dbt_use = "nyoibo",
	desc = "This magic staff can be made to extend to any length beyond its base six feet by speaking a command word. Press u to use it.",
}
