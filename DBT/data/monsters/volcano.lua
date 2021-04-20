-- Dragonball T: Monsters in the volcano on Fire Montain

new_monster_races
{
	['q'] =
	{
		defaults =
		{
			body = default_body.quadruped
			flags =
			{
				ALLOW_IN_VOLCANO=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				ANIMAL=true
				FORCE_MAXHP=true
				SMART=true 
				DROP_CORPSE=true
				REGENERATE=1000
			}
		}
		[1] =
		{
			name = "lava lizard"
			level = 46 rarity = 1
			desc = 
			{
				"A rather large, fast-moving lizard with purple skin and a long, slippery tongue.",
				"It slithers through the lava looking for its next meal. It's skin is soft, but it",
				"looks very tough all the same.",
			}
			color = color.RED
			speed = 10 life = {50,50} ac = 120
			aaf = 10 sleep = 0
			exp = 7000
			weight = 600
			blows =
			{
				{"BITE","PIERCE",{10,20}},
			}
			flags =
			{
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=100 POIS=100 }
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
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
			flags =
			{
				ALLOW_IN_VOLCANO=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				ANIMAL=true
				FORCE_MAXHP=true
				SMART=true 
				DROP_CORPSE=true
				REGENERATE=1000
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			name = "fire fox"
			level = 46 rarity = 1
			desc = {
				"A large fox, perhaps three feet in length. It is quick and agile, but doesn't look",
				"very sturdy.",
			}
			color = color.LIGHT_RED
			speed = 22 life = {25,25} ac = 150
			aaf = 10 sleep = 10
			exp = 7000
			weight = 1500
			blows =
			{
				{"BITE","PIERCE",{2,40}},
			}
			flags =
			{
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=100 POIS=100 }
				AI=ai.DBT_ZOMBIE
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
			flags =
			{
				ALLOW_IN_VOLCANO=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				ANIMAL=true
			}
		}
		[1] =
		{
			name = "glow bug"
			level = 46 rarity = 1
			desc = {
				"An annoying, buzzing, flying insect that emits a faint light. It is small and",
				"its motions are extremely erratic, making it difficult to hit.",
			}
			color = color.YELLOW
			speed = 7 life = {1,1} ac = 300
			aaf = 10 sleep = 0
			exp = 1000
			weight = 1
			blows =
			{
			}
			spells =
			{
				frequency = 8
				["Buzz"] = { level=50 chance=100 }
			}
			flags =
			{
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=100 POIS=100 }
				AI=ai.DBT_DEFAULT
				RAND_MOVEMENT=75 
				CAN_FLY=30 
				STUPID=true 
				HAS_LITE=true
			}
		}
	}
}

new_monster_races
{
	['H'] =	{
		defaults = {
			sleep  = 0

			body = default_body.dragon
			flags = {
				ALLOW_IN_VOLCANO=true
				DROP_CORPSE=true 
				AI=ai.DBT_ZOMBIE
				FORCE_MAXHP=true
				REGENERATE=1000
			}
		}
		[1] =
		{
			name = "nine headed hydra"
			desc =
			{
				"A massive two-ton beast with nine heads, with slavering jaws and sharp pointed teeth.",
				"It does not look very snuggly. In fact, it's downright scary looking, powerful, and",
				"heavily armored. Fortunately all that bulk slows it down some, but you do not relish",
				"the thought of being caught in those jaws.",
			}
			color = color.GREEN
			level = 49 rarity = 1
			life = {40,40} ac = 150
			exp   = 12000
			speed = 10 
			aaf = 10
			weight = 40000
			blows =
			{
				{"BITE","PIERCE",{1,20}},
				{"BITE","PIERCE",{1,20}},
				{"BITE","PIERCE",{1,20}},
				{"BITE","PIERCE",{1,20}},
				{"BITE","PIERCE",{1,20}},
				{"BITE","PIERCE",{1,20}},
				{"BITE","PIERCE",{1,20}},
				{"BITE","PIERCE",{1,20}},
				{"BITE","PIERCE",{1,20}},
			}
			spells =
			{
				frequency = 4
				["Breathe Fast Poison"] = { level=35 chance=100 }
			}
			flags =
			{
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=100 POIS=100 CRUSH=40 PIERCE=40 SLASH=40 }
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_TREASURE=100 }
			}
		}
	}
}

new_monster_races
{
	['b'] =	{
		defaults = {
			sleep  = 0

			body = default_body.bird
			flags = {
				ALLOW_IN_VOLCANO=true
				DROP_CORPSE=true
				ANIMAL=true
				I_AM_A_BIRD=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				REGENERATE=1000
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			name = "fire bird"
			level = 46 rarity = 1
			desc = {
				"This brightly feathered red bird resembles a peacock dressed in an elegant spectrum",
				"of reds and yellows. It's tail, while beautiful, clearly slows it down tremendously,",
				"and altogether conveys a look of delicateness. However, you suspect that this foe",
				"should not be taken lightly.",
			}
			color = color.RED
			speed = 7 life = {20,20} ac = 25
			aaf = 20 sleep = 0
			exp = 5000
			weight = 1500
			blows =
			{
				{"BITE","PIERCE",{2,40}},
			}
			spells =
			{
				frequency = 3
				["Breathe Fire"] = { level=25 chance=100 }
			}
			flags =
			{
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=100 POIS=100 }
				AI=ai.DBT_DEFAULT
				CAN_FLY=30 
			}
		}
	}
}


new_monster_races
{
	['b'] =	{
		defaults = {
			sleep  = 0

			body = default_body.bird
			flags = {
				ALLOW_IN_VOLCANO=true
				DROP_CORPSE=true
				UNIQUE=true
				ANIMAL=true
				I_AM_A_BIRD=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				REGENERATE=200
				FORCE_MAXHP=true
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_HIKUI_BIRD"
			name = "Hikui Bird"
			desc =
			{
				"The elusive Hikui bird, renowed as the only bird to derive sustenance from raw flames.",
				"For all it's fame, it is far from majestic, looking rather like a plump, purple plush",
				"bird. In fact, all in all the Hikui bird is rather goofy looking. It would be difficult",
				"to take seriously if it didn't have a wingspan of about thirty feet and weight almost",
				"half a ton.",
			}
			color = color.VIOLET
			level = 46 rarity = 1
			life = {30,30} ac = 50
			exp   = 3000
			speed = 10 
			aaf = 10
			weight = 8000
			blows =
			{
				{"BITE","PIERCE",{1,60}},
			}
			spells =
			{
				frequency = 4
				["Breathe Fire"] = { level=20 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				NO_FEAR=true
				SPECIAL_GENE=true
				CAN_FLY=30 
				MALE=true
				HAS_LITE=true
				-- Hell?
				RESIST=getter.resists{ PIERCE=50 CONFUSION=100 FEAR=100 FIRE=100 POIS=100 COLD=-50 }
			}
		}
	}
}

new_monster_races
{
	['b'] =	{
		defaults = {
			sleep  = 0

			body = default_body.bird
			flags = {
				ALLOW_IN_VOLCANO=true
				DROP_CORPSE=true
				ANIMAL=true
				I_AM_A_BIRD=true
				UNIQUE=true
				SMART=true 
				FORCE_MAXHP=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				REGENERATE=5000
			}
		}
		[1] =
		{
			define_as = "RACE_PHOENIX"
			name = "The Phoenix"
			level = 50 rarity = 1
			desc = {
				"Sheathed in a crimson blaze, the Phoenix gazes at you with supernaturally intelligent",
				"eyes. Clearly it has decided that you are an unwelcome intruder.",
			}
			color = color.VIOLET
			speed = 33 life = {50,50} ac = 25
			aaf = 30 sleep = 255
			exp = 100000
			weight = 2500
			blows =
			{
				{"BITE","PIERCE",{1,100}},
			}
			spells =
			{
				frequency = 4
				["Breathe Plasma"] = { level=50 chance=100 }
				["Breathe Disintigration"] = { level=50 chance=100 }
				["Gaze Paralysis"] = { level=40 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				DBT_REFLECT=40
				CAN_FLY=30 
				FORCE_SLEEP=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=100 POIS=100 }
				BLOW_RESPONSE=getter.array{[AURA_FIRE]={1,40}}
				DROP_DRAGONBALL=100
			}
		}
	}
}
