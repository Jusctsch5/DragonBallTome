-- In Dragonball T, the player chooses gender only.
-- Everything else develops in-game

new_player_descriptor
{
	type = "base"
	name = "Base Descriptor"
	body = { INVEN=23 WIELD=2 BODY=1 OUTER=1 HANDS=1 ARMS=1 TOOL=1 RING=2 HEAD=1 WRIST=1 FEET=1 VEHICLE=1 BACKPACK=1 }
	skills = {
		["Strength"] = { mods.add(0000), mods.add(100) }
		["Intelligence"] = { mods.add(0000), mods.add(100) }
		["Willpower"] = { mods.add(0000), mods.add(100) }
		["Dexterity"] = { mods.add(0000), mods.add(100) }
		["Constitution"] = { mods.add(0000), mods.add(100) }
		["Charisma"] = { mods.add(0000), mods.add(100) }
		["Speed"] = { mods.add(0000), mods.add(100) }
	}
	flags = {
		OPEN_DOOR=true
	}
	starting_objects = {
 		{ obj = lookup_kind(TV_PARCHMENT, SV_GUIDE) },
 		{ obj = lookup_kind(TV_PARCHMENT, SV_RELEASE_NOTES_091) },
 		{ obj = lookup_kind(TV_SMALLARM, SV_KUBOTAN) },
 		{ obj = lookup_kind(TV_BODY_ARMOUR, SV_STREETCLOTHES) },
 		{ obj = lookup_kind(TV_FOOD, SV_POWER_BAR) },
	}
	life_rating = 10
	experience = 100
	age = { 14, 6 }
	weight =
	{
		male = { 180, 30 }
		female = { 130, 20 }
	}
	height =
	{
		male = { 70, 6 }
		female = { 64, 4 }
	}
}

new_player_descriptor
{
	type = "sex"
	name = "Male"
	desc = "Gender does not effect stats in DBT, but it may have thematic consequences."
 	starting_objects =
 	{
 		{ obj = lookup_kind(TV_BOOTS, SV_TENNIS_SHOES) },
	}
	flags =
	{
		MALE=1
		OPEN_DOOR=true
	}
}
new_player_descriptor
{
	type = "sex"
	name = "Female"
	desc = "Gender does not effect stats in DBT, but it may have thematic consequences."
 	starting_objects =
 	{
 		{ obj = lookup_kind(TV_BOOTS, SV_HIGH_HEELS) },
	}
	flags =
	{
		FEMALE=1
		OPEN_DOOR=true
	}
}
new_player_descriptor
{
	type = "mode"
	name = "Normal"
	desc = "Play Dragonball T in normal mode"
 	starting_objects =
 	{
	}
	flags =
	{
	}
}
new_player_descriptor
{
	type = "mode"
	name = "PlayTest"
	desc = "Play Dragonball T in 'Playtest' mode"
 	starting_objects =
 	{
 		{ obj = lookup_kind(TV_MISC, SV_PLAYTEST) },
	}
	flags =
	{
	}
}
