-- Only one ego

new_monster_ego
{
	define_as = "RACE_EGO_MAJIN"
	name = "Majin" place = "before"
	level = mods.add(20) rarity = 999
	speed = mods.add(10) life = {mods.add(2),mods.add(2)} ac = mods.add(50)
	aaf = mods.add(0) sleep = mods.add(0)
	exp = mods.add(10000)
	weight = mods.add(0)
	need_flags =
	{
		CAN_MAJIN=1
	}
}
