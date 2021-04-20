-- The Foot Ninja Clan and related monsters

new_monster_races
{
	['n'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags =
			{
				DROP_THEME = getter.flags { THEME_NINJA=100 }
				FACTION=FACTION_FOOT
				AI=ai.FOOT_NINJA
			}
		}
		[1] =
		{
			define_as = "RACE_FOOT_BASIC"
			name = "foot ninja"
			level = 15 rarity = 1
			desc = {
				"Dressed in ninja garb and wearing the red dragon doji of the Foot Clan, this",
				"looks to be a relatively new member of the clan. He has passed the basic tests",
				"of skill and loyalty, but he's obviously still lacking in experience.",
				}
			color = color.LIGHT_DARK
			speed = 5 life = {20,5} ac = 60
			aaf = 10 sleep = 0
			exp = 50
			weight = 1400
			blows =
			{
				{"PUNCH","CRUSH",{1,10}},
			}
			flags =
			{
				MALE = true
				OPEN_DOOR=false DROP_CORPSE=true
				MORTAL=true
				DROP_90=true
				ALLOW_IN_FOOT_LAIR=true
				DBTCHAT=function()
					dialogue.FOOT_HELPER()
				end
			}
		}
		[2] =
		{
			define_as = "RACE_FOOT_MIDDLE"
			name = "foot ninja"
			level = 17 rarity = 1
			desc = {
				"Dressed in ninja garb and wearing the red dragon doji of the Foot Clan, this",
				"looks to be a moderately experienced member of the clan. He moves with a modicum",
				"of speed and grace, and generally looks to be more powerful than the newer",
				"clan members.",
				}
			color = color.LIGHT_DARK
			speed = 8 life = {25,5} ac = 70
			aaf = 10 sleep = 0
			exp = 70
			weight = 1500
			blows =
			{
				{"PUNCH","CRUSH",{3,4}},
			}
			flags =
			{
				MALE = true
				OPEN_DOOR=false DROP_CORPSE=true
				MORTAL=true
				DROP_90=true
				ALLOW_IN_FOOT_LAIR=true
				DBTCHAT=function()
					dialogue.FOOT_HELPER()
				end
			}
		}
		[3] =
		{
			define_as = "RACE_FOOT_HIGH"
			name = "foot ninja"
			level = 19 rarity = 1
			desc = {
				"Dressed in ninja garb and wearing the red dragon doji of the Foot Clan, this",
				"looks to be a fairly experienced member of the Clan. His belt is frayed and",
				"he moves with the casual nonchalance of someone who is very confidant of",
				"his abilities.",
				}
			color = color.LIGHT_DARK
			speed = 12 life = {30,5} ac = 80
			aaf = 10 sleep = 0
			exp = 100
			weight = 1600
			blows =
			{
				{"PUNCH","CRUSH",{3,4}},
				{"PUNCH","CRUSH",{3,4}},
			}
			flags =
			{
				MALE = true
				OPEN_DOOR=false DROP_CORPSE=true
				MORTAL=true
				DROP_NUMBER=1
				ALLOW_IN_FOOT_LAIR=true
				DBTCHAT=function()
					dialogue.FOOT_HELPER()
				end
			}
		}
	}
}

-- Some Uniques
new_monster_races
{
	['n'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags =
			{
				UNIQUE=true
				DROP_THEME = getter.flags { THEME_NINJA=100 }
				FACTION=FACTION_FOOT
			}
		}
		[1] =
		{
			define_as = "RACE_TATSU"
			name = "Tatsu"
			level = 21 rarity = 5
			desc = {
				"A large, bald headed Japanese man dressed in extremely formal garb.",
				"He has a no-nonsense attitude about him, and curiously, seems to communicate",
				"primarily with grunts. He doesn't seem very fast, but looks powerful.",
				}
			color = color.RED
			speed = 5 life = {45,5} ac = 80
			aaf = 10 sleep = 0
			exp = 500
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{2,10}},
			}
			spells =
			{
				frequency = 8
				["Throw"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.TATSU
				DBT_REFLECT=20
				DROP_NUMBER=getter.random(1,3)
				EVIL=true
				GOTO_HELL=true
				MALE = true
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=false DROP_CORPSE=true
				MORTAL=true
				ALLOW_IN_FOOT_LAIR=true
				DBTCHAT=function()
					message("Tatsu grunts at you.")
				end
			}
		}
	}
}
