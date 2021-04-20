-- The Androids

-- (Androids are tough)

new_monster_races
{
	['A'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags =
			{
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=-100 CRUSH=50 PIERCE=50 SLASH=50 }
				DROP_THEME = getter.flags { THEME_PLAIN=100 }
				UNIQUE=true FORCE_MAXHP=true
				SMART=true
			}
		}
		[1] =
		{
			define_as = "RACE_ANDROID8"
			name = "Android 8"
			level = 17 rarity = 999
			desc = {
				"Designed to be a lethal killing machine, Android 8 has fallen somewhat",
				"short of his creators ambitions: he is a complete and total pacifist who believes",
				"that fighting and killing are very wrong.",
			}
			color = color.RED
			speed = 0 life = {40,40} ac = 50
			aaf = 10 sleep = 0
			exp = 2000
			weight = 1700
			blows = {}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				NO_FEAR=true
				FORCE_NO_DBALL=true
				ALLOW_IN_MUSCLE_TOWER=true
				FACTION=FACTION_NEUTRAL
				MALE=true
				GOOD=true
				REMOTE_DESTROY=true
				DROP_CORPSE=true
				CAN_SPEAK=function(name) monster_random_say{
					name.." pleads 'stop fighting!'",
				}end
				DBTCHAT=function()
					dialogue.ANDROID8()
				end
			}
		}
		[2] =
		{
			define_as = "RACE_ANDROID16"
			name = "Android 16"
			level = 87 rarity = 999
			desc = {
				"Another of Dr. Gero's great technical successes turned philosophilcal failure,",
				"Android 16 is perhaps the most powerful of all of the Androids ever built. Like number 8,",
				"however, he belives murder and conquest to be wrong. Unlike 8, however, he has on rare",
				"occassion expressed a willingness to fight to overcome evil when he believes the cause to",
				"be just and good."
			}
			color = color.UMBER
			speed = 50 life = {100,100} ac = 400
			aaf = 10 sleep = 0
			exp = 500000
			weight = 3700
			blows =
			{
				{"PUNCH","CRUSH",{10,10}},
				{"PUNCH","CRUSH",{10,10}},
				{"KICK","CRUSH",{10,10}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				NO_FEAR=true
				ALLOW_IN_MUSCLE_TOWER=true
				FACTION=FACTION_GOOD
				CAN_FLY=30 
				MALE=true
				REMOTE_DESTROY=true
				OPEN_DOOR=true BASH_DOOR=true GOOD=true
				DROP_CORPSE=true
				CAN_SPEAK=function(name) monster_random_say{
					name.." watches quietly.",
				}end
			}
		}
		[3] =
		{
			define_as = "RACE_ANDROID17"
			name = "Android 17"
			level = 60 rarity = 100
			desc = {
				"One of Dr. Gero's later models, Android 17 was built not only from a human base, but",
				"is female, as well. A near duplicate of her male counterpart, number 18, 17 is fast, powerful,",
				"and absolutely loathes humans. Curiously, she believes very strongly in the integrity of",
				"her word, and will go to extreme measures to carry out anything she says she will do, be it",
				"to spare a life...or to take one.",
			}
			color = color.YELLOW
			speed = 50 life = {50,50} ac = 400
			aaf = 10 sleep = 0
			exp = 300000
			weight = 1400
			spells =
			{
				frequency = 3
				-- Hack!: This triggers the inception dialogue!
				["FingerPointer"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{10,10}},
				{"PUNCH","CRUSH",{10,10}},
				{"KICK","CRUSH",{10,10}},
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				DBT_REFLECT=90
				NO_FEAR=true
				FACTION=FACTION_DUNGEON
				FEMALE=true
				REMOTE_DESTROY=true
				OPEN_DOOR=true BASH_DOOR=true EVIL=true
				DROP_CORPSE=true
			}
		}
		[4] =
		{
			define_as = "RACE_ANDROID18"
			name = "Android 18"
			level = 60 rarity = 100
			desc = {
				"One of Dr. Gero's later models, Android 18 was built from a human base like his female",
				"counterpart, number 17. Like 17, Android 18 is fast, powerful, and absolutely loathes humans.",
				"Unlike 17, he is completely indifferent to words, and on those rare occassions he bothers",
				"using them, he cares little for their veracity, preferring instead to simply live a life",
				"of fun and frolic, killing humans and destroying cities.",
			}
			color = color.LIGHT_DARK
			speed = 50 life = {50,50} ac = 400
			aaf = 10 sleep = 0
			exp = 300000
			weight = 1400
			spells =
			{
				frequency = 3
				-- Hack!: This triggers the inception dialogue!
				["FingerPointer"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{10,10}},
				{"PUNCH","CRUSH",{10,10}},
				{"KICK","CRUSH",{10,10}},
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				DBT_REFLECT=90
				CAN_FLY=30 
				NO_FEAR=true
				FACTION=FACTION_DUNGEON
				REMOTE_DESTROY=true
				OPEN_DOOR=true BASH_DOOR=true EVIL=true
				DROP_CORPSE=true
			}
		}
		[5] =
		{
			define_as = "RACE_ANDROID19"
			name = "Android 19"
			level = 55 rarity = 999
			desc = {
				"After so many of his attempts to build the 'Ultimate' fighting machine resulted in",
				"powerful creations who either refused to fight, or turned against him, Dr. Gero",
				"has finally fallen back on the tried and true method: mindless automatons. Neither",
				"thinking, nor feeling, Android 19 was built entirely from mechanical parts. With no",
				"heart and no soul, it does nothing but obey...and the order is to kill.",
			}
			color = color.LIGHT_DARK
			speed = 20 life = {50,50} ac = 300
			aaf = 10 sleep = 0
			exp = 300000
			weight = 1400
			blows =
			{
				{"PUNCH","CRUSH",{10,10}},
				{"PUNCH","CRUSH",{10,10}},
				{"KICK","CRUSH",{10,10}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_REFLECT=90
				CAN_FLY=30 
				NO_FEAR=true
				FACTION=FACTION_GERO
				STUPID=true 
				REMOTE_DESTROY=true
				OPEN_DOOR=true BASH_DOOR=true EVIL=true
				DROP_CORPSE=true
			}
		}
		[6] =
		{
			define_as = "RACE_ANDROID20"
			name = "Android 20"
			level = 60 rarity = 999
			desc = {
				"You're not sure how...but its face is familiar. Yes, it's Dr. Gero. It seems he",
				"survived and was able to transform his dying body into an android as he has done",
				"with so many others. Mastermind behind the Red Ribbon Army...genius responsible",
				"for the creation of the Androids...evil megalomaniac bent on ruling the world...",
				"Dr gero is alive and well, and back from the dead.\n\nThis can't be good.\n\n",
			}
			color = color.VIOLET
			speed = 30 life = {50,50} ac = 400
			aaf = 10 sleep = 0
			exp = 300000
			weight = 1700
			blows =
			{
				{"PUNCH","CRUSH",{10,10}},
				{"PUNCH","CRUSH",{10,10}},
			}
			flags =
			{
				FACTION=FACTION_GERO
				DBT_REFLECT=90
				MALE=true
				CAN_FLY=30 
				OPEN_DOOR=true BASH_DOOR=true EVIL=true
				FORCE_NO_DBALL=true
				DROP_CORPSE=true
				CAN_SPEAK=function(name) monster_random_say{
					name.." shrieks 'I will have veangeance!'",
				}end
				ON_DEATH = function(monst)
					message(color.YELLOW, "With his dying breath, Dr. Gero gasps 'You think this is it? You are WRONG!")
				end
			}
		}
	}
}

new_monster_races
{
	['R'] =	{
		defaults = {
			sleep  = 0

			body = default_body.blob
			flags = {
				-- DROP_THEME = getter.flags { THEME_ALLOC_HANDLER=100 }
				NO_FEAR=true
				REMOTE_DESTROY=true
				FORCE_NO_DBALL=true
				CORPSE_ANDROID=true
			}
		} -- defaults


		[1] =
		{
			define_as = "RACE_WHIRLIGIG"
			name = "Whirligig"
			desc =
			{
				"This sphere of ever-rotating blades hovers a few feet above the ground. It waits",
				"silently and patiently for the order to attack.",
			}
			color = color.RED
			level = 80 rarity = 5
			life = {40,40} ac = 100
			exp   = 20000
			speed = 40 
			aaf = 10
			weight = 600
			blows =
			{
				{"HIT","SLASH",{8,8}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				CAN_FLY=2 
				FORCE_MAXHP=true
				ALLOW_IN_GERO_LAB=true
				FACTION=FACTION_GERO
				BASH_DOOR=true 
			}
		}
		[2] =
		{
			define_as = "RACE_DEATH_ORB"
			name = "Death Orb"
			desc =
			{
				"This floating black sphere is roughly six inches in diameter and houses six",
				"plasma beam generators. It floats silently and is very difficult to see.",
			}
			color = color.LIGHT_DARK
			level = 80 rarity = 5
			life = {30,30} ac = 200
			exp   = 20000
			speed = 25 
			aaf = 10
			weight = 80
			blows =
			{
			}
			spells =
			{
				frequency = 3
				["PlasmaBeam"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.SPELL_AND_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				FORCE_MAXHP=true
				CAN_FLY=2 
				ALLOW_IN_GERO_LAB=true
				FACTION=FACTION_GERO
			}
		}
		[3] =
		{
			define_as = "RACE_EXTERMINATOR"
			name = "Exterminator"
			desc =
			{
				"A massively built, silvery-black humanoid robot about seven feet in height.",
				"Constructed of solid metal, and looking immensely powerful, you don't think",
				"you want it touching you. Fortunately it doesn't exclusively punch. It also",
				"has a plasma beam generator in its chest. That's a good thing, right?",
			}
			color = color.ANTIQUE_WHITE
			level = 80 rarity = 5
			life = {50,50} ac = 100
			exp   = 40000
			speed = 20 
			aaf = 10
			weight = 20000
			blows =
			{
				{"HIT","CRUSH",{10,10}},
			}
			spells =
			{
				frequency = 7
				["PlasmaBeam"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_AI=ai.DBT_ZOMBIE
				FORCE_MAXHP=true
				ALLOW_IN_GERO_LAB=true
				FACTION=FACTION_GERO
				BASH_DOOR=true 
			}
		}
	}
}
