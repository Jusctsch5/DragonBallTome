-- Corrupted monks and temple people

new_monster_races
{
	['p'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags =
			{
				DROP_THEME = getter.flags { THEME_MARTIAL=100 }
				FACTION=FACTION_DUNGEON
				AI=ai.EVIL_MONK
			}
		}
		[1] =
		{
			define_as = "RACE_CORRUPT_MONK_A"
			name = "corrupt monk"
			level = 17 rarity = 1
			desc = {
				"Dressed in the bright orange robes of a Buddhist monk, it is unclear why this man",
				"has chosen the path he has. The look on his face suggests he acts with a near",
				"complete sense of passivity, yet the fists he brings to bear on you don't look",
				"passive at all.",
				}
			color = color.ORANGE
			speed = 9 life = {20,5} ac = 70
			aaf = 10 sleep = 0
			exp = 80
			weight = 1500
			blows =
			{
				{"PUNCH","CRUSH",{1,14}},
			}
			flags =
			{
				DBT_DEFLECT=10
				MALE = true
				HAS_LITE=true
				DROP_CORPSE=true
				MORTAL=true
				DROP_90=true
				ALLOW_IN_TEMPLE=true
				DBTCHAT=function()
					-- dialogue.FOOT_HELPER()
				end
			}
		}
		[2] =
		{
			define_as = "RACE_CORRUPT_MONK_B"
			name = "invader monk"
			level = 19 rarity = 1
			desc = {
				"While this is clearly not a monk of the Temple, nothing about this man's appeareance",
				"leads you to suspect that he might be a Taoist. You really have no idea where Krillan",
				"got that idea.",
				}
			color = color.LIGHT_DARK
			speed = 12 life = {25,5} ac = 80
			aaf = 10 sleep = 0
			exp = 70
			weight = 1500
			blows =
			{
				{"PUNCH","CRUSH",{3,5}},
			}
			flags =
			{
				DBT_DEFLECT=30
				MALE = true
				HAS_LITE=true
				OPEN_DOOR=true DROP_CORPSE=true
				MORTAL=true
				DROP_90=true
				ALLOW_IN_TEMPLE=true
				DBTCHAT=function()
					-- dialogue.FOOT_HELPER()
				end
			}
		}
		[3] =
		{
			define_as = "RACE_CORRUPT_MONK_C"
			name = "defiler monk"
			level = 21 rarity = 1
			desc = {
				"This man wears a perpetual sneer as well as what looks like meaty grease",
				"stains on his robes. Clearly he does not take his monkly vows very seriously",
				"if he ever took them at all.",
				}
			color = color.RED
			speed = 15 life = {30,5} ac = 90
			aaf = 10 sleep = 0
			exp = 100
			weight = 1600
			blows =
			{
				{"PUNCH","CRUSH",{3,5}},
				{"PUNCH","CRUSH",{3,5}},
			}
			flags =
			{
				DBT_DEFLECT=50
				MALE = true
				HAS_LITE=true
				OPEN_DOOR=true DROP_CORPSE=true
				MORTAL=true
				DROP_90=true
				ALLOW_IN_TEMPLE=true
				DBTCHAT=function()
					-- dialogue.FOOT_HELPER()
				end
			}
		}
		[4] =
		{
			define_as = "RACE_CORRUPT_MONK_D"
			name = "ancient priest"
			level = 23 rarity = 1
			desc = {
				"From his appearance this man could easily be a hundred years old. Maybe even two.",
				"He moves slowly compared to his younger companions, and yet there is an unmistakable",
				"grace to his movements. He looks extremely delicate, and yet...somehow quite deadly.",
				}
			color = color.CRIMSON
			speed = 7 life = {5,5} ac = 150
			aaf = 10 sleep = 0
			exp = 100
			weight = 1600
			blows =
			{
				{"TOUCH","CRUSH",{10,10}},
			}
			flags =
			{
				MALE = true
				DBT_REFLECT=70
				DBT_DEFLECT=80
				OPEN_DOOR=true DROP_CORPSE=true
				MORTAL=true
				DROP_90=true
				ALLOW_IN_TEMPLE=true
				DBTCHAT=function()
					-- dialogue.FOOT_HELPER()
				end
			}
		}
	}
}

-- Some Uniques
new_monster_races
{
	['p'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags =
			{
				UNIQUE=true
				DROP_THEME = getter.flags { THEME_MARTIAL=100 }
			}
		}
		[1] =
		{
			define_as = "RACE_ABBOT"
			name = "The Abbot"
			level = 21 rarity = 5
			desc = {
				"The Abbot is a monk of indeterminiate age, and eyes that you suspect would probably",
				"gleam with great wisdom...if only he would open his eyelids for you to see.",
				}
			color = color.VIOLET
			speed = 5 life = {45,5} ac = 0
			aaf = 10 sleep = 0
			exp = 500
			weight = 1800
			blows =
			{
				-- {"PUNCH","CRUSH",{2,10}},
			}
			spells =
			{
				-- frequency = 8
				-- ["Throw"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_DEFLECT=20
				GOOD=true
				GOTO_HEAVEN=true
				MALE = true
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				SPECIAL_GENE=true
				FACTION=FACTION_KAMI
				DROP_NUMBER=getter.random(1,2)
				OPEN_DOOR=true DROP_CORPSE=true
				MORTAL=true
				ALLOW_IN_TEMPLE=true
				DBTCHAT=function()
					dialogue.ABBOT()
				end
			}
		}
		[2] =
		{
			define_as = "RACE_MONK_RINGLEADER"
			name = "monk ringleader"
			level = 25 rarity = 999
			desc = {
				"This man is an enigma. What thought process could possibly lead someone to choose",
				"to try to take control of a Buddhist temple by force? It's sort of like people who",
				"steal Bibles. Things that really make you wonder 'why?'",
				}
			color = color.VIOLET
			speed = 5 life = {45,5} ac = 0
			aaf = 10 sleep = 0
			exp = 500
			weight = 1800
			blows =
			{
				-- {"PUNCH","CRUSH",{2,10}},
			}
			spells =
			{
				-- frequency = 8
				-- ["Throw"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.EVIL_MONK
				DBT_DEFLECT=20
				EVIL=true
				GOTO_HELL=true
				MALE = true
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				SPECIAL_GENE=true
				DROP_NUMBER=getter.random(2,2)
				OPEN_DOOR=true DROP_CORPSE=true
				MORTAL=true
				ALLOW_IN_TEMPLE=true
				DBTCHAT=function()
					message("Die, fool!")
				end
				ON_DEATH=function(name)
					dialogue.EVIL_MONK()
				end
			}
		}
	}
}
