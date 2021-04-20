-- Dragonball T: Humans
new_monster_races
{
	['p'] =	{
		defaults = {
			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true TAKE_ITEM=true
				OPEN_DOOR=true HAS_LITE=true
			}
		} -- defaults
		[1] =
		{
			name = "starving college student"
			desc =
			{
				"You feel sorry for this one. His parents pay for his room, tuition and",
				"sometimes his books, but always seem to forget that food costs money too.",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 30
			exp   = 0
			color = color.LIGHT_UMBER
			life = {1,5} ac = 10
			aaf = 10
			weight = 1500
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_RUN_AWAY
				ALLOW_IN_EARTH_SAFE=true
				FACTION=FACTION_NEUTRAL
				KARMA=-1
				MALE=true
				DROP_60=true BASH_DOOR=true HAS_LITE=true
				DROP_THEME = getter.flags { THEME_JUNK=100 }
				DBTCHAT=function()
					monster_random_say{
					"the starving student begs you for money to eat with",
					"the starving student asks you if you've read any Voltaire",
					"the starving student whines about the cost of books",}
				end
			}
		}
		[2] =
		{
			name = "wannabee martial artist"
			desc =
			{
				"This poor sod would love to be studying at a studio somewhere, but for",
				"one reason or anyther either can't find a school or can't afford to",
				"pay for classes.",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 10
			exp   = 1
			color = color.WHITE
			life = {2,5} ac = 30
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,3}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				ALLOW_IN_EARTH_SAFE=true
				MALE=true
				DROP_60=true RAND_MOVEMENT=75
				DROP_THEME = getter.flags { THEME_JUNK=100 }
			}
		}
		[3] =
		{
			name = "aerobics instructor"
			desc =
			{
				"This slender and athletic gem teaches aerobics nearby. She's wearing a yellow leotard",
				"and a bright pink t-shirt that reads 'Pichi-pichi.' What could that mean?",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 10
			exp   = 1
			color = color.LIGHT_RED
			life = {2,5} ac = 30
			aaf = 10
			weight = 1500
			spells =
			{
				frequency = 4
				["Shriek"] = { level=50 chance=100 }
			}
			blows =
			{
				{"HIT","CRUSH",{1,3}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_DEFAULT
				FACTION=FACTION_NEUTRAL
				KARMA=-1
				ALLOW_IN_EARTH_SAFE=true
				FEMALE=true
				DROP_60=true RAND_MOVEMENT=75
				DROP_THEME = getter.flags { THEME_JUNK=100 }
			}
		}
	}
}

new_monster_races
{
	['p'] =	{
		defaults = {
			body = default_body.humanoid
			flags = {
				MALE=true
				DROP_CORPSE=true TAKE_ITEM=true
				OPEN_DOOR=true HAS_LITE=true
				MORTAL=true
				ALLOW_IN_SATAN_ESTATE=true
				FORCE_MAXHP=true
			}
		} -- defaults


		[1] =
		{
			define_as = "RACE_WHITE_BELT"
			name = "white belt"
			desc =
			{
				"A beginner at the local martial arts studio, his form is atrocious, he",
				"lacks speed, precision and power. Give him time though. He'll get there.",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 10
			exp   = 4
			color = color.WHITE
			life = {3,5} ac = 40
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				ALLOW_IN_EARTH_EASY=true
				RAND_MOVEMENT=60
				DROP_60=true
				DROP_THEME = getter.flags { THEME_TPEOPLE=100 }
			}
		}
		[2] =
		{
			define_as = "RACE_YELLOW_BELT"
			name = "yellow belt"
			desc =
			{
				"This martial artist has been awarded a rank for his diligent training and",
				"dedication over the past few months. While he is still unable to punch, kick,",
				"or perform any other technique with any degree of skill, he has at least managed",
				"to memorize the names for most of them.",
			}
			level = 2 rarity = 1
			speed = 0 sleep  = 10
			exp   = 8
			color = color.YELLOW
			life = {5,5} ac = 30
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,4}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				RAND_MOVEMENT=25
				ALLOW_IN_EARTH_EASY=true
				ALLOW_IN_EARTH_HARD=true
				DROP_60=true
				DROP_THEME = getter.flags { THEME_TPEOPLE=80 THEME_GOLD=20 }
			}
		}
		[3] =
		{
			define_as = "RACE_ORANGE_BELT"
			name = "orange belt"
			desc =
			{
				"After a year of practice, this martial artist has finally started to 'get it.' He",
				"still lacks power and precision, but countless repetitions have instilled a",
				"a degree of comfort and confidence to his motions.",
			}
			level = 3 rarity = 1
			speed = 0 sleep  = 5
			exp   = 10
			color = color.ORANGE
			life = {5,5} ac = 40
			aaf = 10
			weight = 1600
			blows =
			{
				{"HIT","CRUSH",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				ALLOW_IN_EARTH_EASY=true
				ALLOW_IN_EARTH_HARD=true
				RAND_MOVEMENT=25
				DROP_60=true
				DROP_THEME = getter.flags { THEME_TPEOPLE=80 THEME_GOLD=20 }
			}
		}
		[4] =
		{
			define_as = "RACE_GREEN_BELT"
			name = "green belt"
			desc =
			{
				"With a few years of training, this martial artist could possibly be described as",
				"dangerous. He can defend himself adequetly, and his strikes have power. Fortunately,",
				"years of classroom practice have also taught him a number of bad habits that make him",
				"in some ways an even less effective fighter than someone who has learned nothing at all.",
			}
			level = 7 rarity = 1
			speed = 5 sleep  = 0
			exp   = 32
			color = color.GREEN
			life = {6,5} ac = 60
			aaf = 10
			weight = 1700
			blows =
			{
				{"HIT","CRUSH",{1,8}},
				{"HIT","CRUSH",{1,8}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				ALLOW_IN_EARTH_HARD=true
				DROP_90=true
				DROP_THEME = getter.flags { THEME_MARTIAL=80 THEME_GOLD=20 }
			}
		}
		[5] =
		{
			define_as = "RACE_BROWN_BELT"
			name = "brown belt"
			desc =
			{
				"With several years of diligent training under his belt, this martial artist",
				"is both precise and powerful in his motions, as well as extremely fast to",
				"execute them. Countless sparring bouts have also taught him to know his limits,",
				"and how not to make foolish mistakes. This is a dangerous opponent.",
			}
			level = 12 rarity = 1
			speed = 10 sleep  = 0
			exp   = 50
			color = color.TAN
			life = {10,5} ac = 70
			aaf = 10
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{1,8}},
				{"KICK","CRUSH",{1,8}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				ALLOW_IN_EARTH_HARD=true
				DROP_NUMBER=1
				DROP_THEME = getter.flags { THEME_MARTIAL=80 THEME_GOLD=20 }
			}
		}
		[6] =
		{
			define_as = "RACE_BLACK_BELT"
			name = "black belt"
			desc =
			{
				"With no less than five years of constant traning, this martial artist has finally",
				"become a genuine master of the basics. He can punch. He can kick. He can move.",
				"He can defend himself. Be careful.",
			}
			level = 15 rarity = 1
			speed = 12 sleep  = 0
			exp   = 100
			color = color.LIGHT_DARK
			life = {20,5} ac = 80
			aaf = 10
			weight = 1500
			blows =
			{
				{"PUNCH","CRUSH",{1,8}},
				{"KICK","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 10
				["Throw"] = { level=2 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_THROWER
				ALLOW_IN_EARTH_DEADLY=true
				DROP_NUMBER=getter.random(1,2)
				DROP_THEME = getter.flags { THEME_MARTIAL=100 }
			}
		}
	}
}

