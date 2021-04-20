new_monster_races
{
	['r'] =
	{
		defaults =
		{
			body = default_body.quadruped
			flags =
			{
				ANIMAL=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			name = "small rat"
			level = 3 rarity = 1
			desc = {
				"He would be cute if he weren't quite so dirty, smelly, and looking at",
				"you hungrily.",
			}
			color = color.UMBER
			speed = 10 life = {2,5} ac = 50
			aaf = 10 sleep = 10
			exp = 7
			weight = 600
			blows =
			{
				{"BITE","PIERCE",{1,3}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				MULTIPLY=true
				ALLOW_IN_SEWERS=true
				ALLOW_IN_URANAI=true
			}
		}
		[2] =
		{
			name = "large rat"
			level = 5 rarity = 1
			desc = "This is a rodent of unusual size. Unusual apetite as well."
			color = color.UMBER
			speed = 5 life = {5,5} ac = 50
			aaf = 10 sleep = 10
			exp = 15
			weight = 600
			blows =
			{
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				ALLOW_IN_SEWERS=true
				ALLOW_IN_URANAI=true
			}
		}
		[3] =
		{
			name = "mutant rat"
			level = 7 rarity = 2
			desc = {
				"This rodent is a bit larger than your ordinary giant rat, and its fur is",
				"colored strangely. You're not certain, but you don't think this creature",
				"is entirely natural.",
			}
			color = color.VIOLET
			speed = 5 life = {10,5} ac = 50
			aaf = 10 sleep = 10
			exp = 50
			weight = 800
			blows =
			{
				{"BITE","PIERCE",{1,12}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				ALLOW_IN_SEWERS=true
			}
		}
		[4] =
		{
			name = "badger"
			level = 1 rarity = 1
			desc = "A small furry rodent."
			color = color.UMBER
			speed = 3 life = {1,3} ac = 10
			aaf = 30 sleep = 10
			exp = 1
			weight = 60
			blows =
			{
				{"BITE","PIERCE",{1,3}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				FACTION=FACTION_ANIMAL
				ALLOW_IN_EARTH_SAFE=true
				I_AM_A_BADGER=true
			}
		}
	}
}

new_monster_races
{
	['s'] =
	{
		defaults =
		{
			body = default_body.none
			flags =
			{
				ANIMAL=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			name = "small snake"
			level = 5 rarity = 1
			desc = {
				"A small garden snake, perhaps two or three feet long. It looks harmless.",
			}
			color = color.LIGHT_GREEN
			speed = 10 life = {2,5} ac = 50
			aaf = 10 sleep = 10
			exp = 7
			weight = 20
			blows =
			{
				{"BITE","PIERCE",{1,3}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				FACTION=FACTION_ANIMAL
				ALLOW_IN_SEWERS=true
				ALLOW_IN_EARTH_EASY=true
				ALLOW_IN_URANAI=true
				DBTCHAT=function()
					monster_random_say{
					"the small snake is uninterested in you",
					"it scurries away",}
				end
			}
		}
		[2] =
		{
			name = "large snake"
			level = 7 rarity = 1
			desc = "A rather large snake, perhaps five feet long. It is not poisonous but it has a powerful bite."
			color = color.GREEN
			speed = 10 life = {10,5} ac = 50
			aaf = 10 sleep = 10
			exp = 50
			weight = 200
			blows =
			{
				{"BITE","PIERCE",{1,12}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				FACTION=FACTION_ANIMAL
				ALLOW_IN_SEWERS=true
				ALLOW_IN_URANAI=true
			}
		}
		[3] =
		{
			name = "python"
			level = 16 rarity = 1
			desc = "A long snake, with sharp teeth and dealy venom, and perhaps twelve to fifteen feet long."
			color = color.GREEN
			speed = 10 life = {15,10} ac = 50
			aaf = 10 sleep = 10
			exp = 200
			weight = 800
			blows =
			{
				{"BITE","POISON",{1,20}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_AI=ai.DBT_ZOMBIE
				ALLOW_IN_URANAI=true
			}
		}
		[4] =
		{
			name = "giant snake"
			level = 16 rarity = 1
			desc = {
					"It is difficult to judge how long this snake is, but far more impressive is its",
					"incredible bulk. Fully two feet in diameter, this snake would have little difficulty",
					"swallowing a cow.",
				}
			color = color.GREEN
			speed = 10 life = {15,10} ac = 50
			aaf = 10 sleep = 10
			exp = 200
			weight = 4000
			blows =
			{
				{"BITE","CRUSH",{20,3}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_AI=ai.DBT_ZOMBIE
				ALLOW_IN_URANAI=true
			}
		}
	}
}
new_monster_races
{
	['i'] =
	{
		defaults =
		{
			body = default_body.insect
			flags = {
				ALLOW_IN_SEWERS=true
				ANIMAL=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			name = "dragonfly"
			level = 2 rarity = 1
			desc = {
				"More annoying than dangerous, this dragonfly seems to enjoy buzzing around",
				"noisily.",
			}
			color = color.GREEN
			speed = 0 life = {1,5} ac = 50
			aaf = 10 sleep = 10
			exp = 4
			weight = 1
			blows =
			{
				{"BITE","PIERCE",{1,2}},
			}
			spells =
			{
				frequency = 4
				["Buzz"] = { level=50 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				-- ALLOW_IN_EARTH_EASY=true
				RAND_MOVEMENT=75 
				STUPID=true 
				ALLOW_IN_URANAI=true
			}
		}
		[2] =
		{
			name = "large cochroach"
			level = 5 rarity = 2
			desc = "Whoa! This thing has to be a good four inches long. Creepy!"
			color = color.UMBER
			speed = 10 life = {2,5} ac = 45
			aaf = 10 sleep = 10
			exp = 10
			weight = 5
			blows =
			{
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				ALLOW_IN_URANAI=true
			}
		}
		[3] =
		{
			name = "mutant cochroach"
			level = 7 rarity = 2
			desc = {
				"Yes...it's a cochroach. At first you thought it might be a rat, but no, it's",
				"a cochroach fully eight inches long and as big around as your forearm. It makes",
				"a curious clicking sound, and you see its antennea honing in on you. This is not",
				"good.",
			}
			color = color.VIOLET
			speed = 10 life = {6,5} ac = 50
			aaf = 10 sleep = 10
			exp = 25
			weight = 5
			blows =
			{
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
			}
		}
		[4] =
		{
			name = "spider"
			level = 7 rarity = 2
			desc = {
				"It's a small spider.",
			}
			color = color.LIGHT_DARK
			speed = 10 life = {6,5} ac = 50
			aaf = 10 sleep = 0
			exp = 25
			weight = 5
			blows =
			{
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
			}
		}
		[4] =
		{
			name = "large spider"
			level = 17 rarity = 2
			desc = {
				"This spider is fully a foot in diameter. It's heavy enough that it makes",
				"noise as it scuttles towards you.",
			}
			color = color.LIGHT_UMBER
			speed = 10 life = {6,5} ac = 50
			aaf = 10 sleep = 0
			exp = 25
			weight = 50
			blows =
			{
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				-- ALLOW_IN_EARTH_HARD=true
				ALLOW_IN_URANAI=true
			}
		}
		[5] =
		{
			name = "giant spider"
			level = 22 rarity = 2
			desc = {
				"This spider is larger than you are. Talk about creepy.",
			}
			color = color.LIGHT_RED
			speed = 20 life = {20,20} ac = 50
			aaf = 10 sleep = 0
			exp = 250
			weight = 1500
			blows =
			{
				{"BITE","PIERCE",{1,30}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				-- ALLOW_IN_EARTH_DEADLY=true
				ALLOW_IN_URANAI=true
			}
		}
		[6] =
		{
			name = "massive, bloated, grotesque spider"
			level = 32 rarity = 2
			desc = {
				"Ooohhh....it's puffy and bloated and covered with a thin layer of slime.",
				"I bet it's poisonous, too.",
			}
			color = color.RED
			speed = 20 life = {20,20} ac = 90
			aaf = 10 sleep = 0
			exp = 700
			weight = 1700
			blows =
			{
				{"BITE","POISON",{1,30}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				ALLOW_IN_URANAI=true
			}
		}
	}
}

new_monster_races
{
	['b'] =
	{
		defaults =
		{
			body = default_body.bird
			flags = {
				I_AM_A_BIRD=true
				DROP_CORPSE=true
				ANIMAL=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				CAN_FLY=3 
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			name = "bluejay"
			level = 1 rarity = 1
			desc = {
				"A little bird, flitting about, looking for worms.",
			}
			color = color.BLUE
			speed = 30 life = {1,5} ac = 60
			aaf = 10 sleep = 0
			exp = 1
			weight = 1
			blows =
			{
				{"BITE","PIERCE",{1,2}},
			}
			spells =
			{
			}
			flags =
			{
				STUPID=true 
				FACTION=FACTION_ANIMAL
				ALLOW_IN_EARTH_SAFE=true
				CAN_FLY=15
				DBTCHAT=function()
					monster_random_say{
					"the bluejay chirps happily",
					"the bluejay sings a merry tune",
					"the bluejay is busy searching for yummy worms",}
				end
			}
		}
		[2] =
		{
			name = "robin"
			level = 1 rarity = 1
			desc = {
				"A little bird, flitting about, looking for worms.",
			}
			color = color.RED
			speed = 30 life = {1,5} ac = 60
			aaf = 10 sleep = 0
			exp = 1
			weight = 1
			blows =
			{
				{"BITE","PIERCE",{1,2}},
			}
			spells =
			{
			}
			flags =
			{
				STUPID=true 
				FACTION=FACTION_ANIMAL
				ALLOW_IN_EARTH_SAFE=true
				CAN_FLY=15
				DBTCHAT=function()
					monster_random_say{
					"the robin chirps happily",
					"the robin sings a merry tune",
					"the robin is busy searching for yummy worms",}
				end
			}
		}
		[3] =
		{
			name = "eagle"
			level = 12 rarity = 2
			desc = "A large predatory bird."
			color = color.UMBER
			speed = 20 life = {10,10} ac = 30
			aaf = 30 sleep = 10
			exp = 30
			weight = 60
			blows =
			{
				{"CLAW","PIERCE",{3,3}},
				{"CLAW","PIERCE",{3,3}},
				{"BITE","SLASH",{2,6}},
			}
			flags =
			{
				CAN_FLY=15
				FACTION=FACTION_DUNGEON
				ALLOW_IN_EARTH_HARD=true
			}
		}
	}
}

new_monster_races
{
	['f'] =
	{
		defaults =
		{
			body = default_body.quadruped
			flags = {
				ANIMAL=true
				KITTY=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			name = "cat"
			level = 1 rarity = 1
			desc = {
				"A friendly housecat wandering the streets looking for an easy mark to con",
				"into scratching his head.",
			}
			color = color.UMBER
			speed = 10 life = {2,5} ac = 50
			aaf = 10 sleep = 100
			exp = 3
			weight = 1
			blows =
			{
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				ALLOW_IN_EARTH_SAFE=true
				FACTION=FACTION_ANIMAL
				DBTCHAT=function()
					monster_random_say{
					"the cat says 'Pet me!'",
					"the cat says 'Feed me!'",
					"the cat says 'Love me!'",}
				end
			}
		}
		[2] =
		{
			define_as = "RACE_MOUNTAIN_LION"
			name = "mountain lion"
			level = 17 rarity = 1
			desc = {
				"At about six feet in length, not including her tail, this feline is on the",
				"prowl for her next meal. The questions is: is that you?",
			}
			color = color.YELLOW
			speed = 10 life = {20,5} ac = 70
			aaf = 10 sleep = 100
			exp = 125
			weight = 1
			blows =
			{
				{"CLAW","SLASH",{1,6}},
				{"CLAW","SLASH",{1,6}},
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				FACTION=FACTION_DUNGEON
				ALLOW_IN_EARTH_HARD=true
				DBTCHAT=function()
					monster_random_say
					{
					"the mountain lion says 'Grrrooooowwwwwwrrrrr!!!!'",
					"the mountain lion says 'Grrrrrrrrr!!!!'",
					"the mountain lion blinks at you.",
					"the mountain lion says 'Maybe if you scratch my head I won't eat you right away.'",
					}
				end
				ON_DEATH = function(monst)
				end
			}
		}
	}
}

new_monster_races
{
	['P'] =
	{
		[1] =
		{
			define_as = "RACE_FLORINIFERA"
			name = "florinifera"
			level = 6 rarity = 1
			desc = {
				"A harmless, but technically carnivorous plant that eats mostly bugs. With bright",
				"green stalks, and vibrantly colorful flowers, it is really quite lovely.",
			}
			body = default_body.blob
			color = color.GREEN
			speed = -10 life = {1,5} ac = 20
			aaf = 10 sleep = 255
			exp = 1
			weight = 700
			blows =
			{
			}
			flags =
			{
				AI=ai.NEVER_MOVE
				NO_FEAR=true
				ALLOW_IN_SEWERS=true
				ALLOW_IN_URANAI=true
				ALLOW_IN_EARTH_EASY=true
				FORCE_MAXHP=true
				NEVER_MOVE=true
				MORTAL=true
				STUPID=true
				FACTION=FACTION_NEUTRAL
				PLANT=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
			}
		}
	}
}

