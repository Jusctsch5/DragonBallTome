-- Dragonball T: Demons

new_monster_races
{
	['U'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags = {
				FACTION=FACTION_DEMON
				FORCE_MAXHP=true
				DROP_THEME = getter.flags { THEME_PLAIN=100 }
				RESIST=getter.resists{CONFUSION=50 ELEC=100 FEAR=100 FIRE=100 POIS=90}
				ONLY_ITEM=true
				SMART=true OPEN_DOOR=true BASH_DOOR=true MOVE_BODY=true REGENERATE=true
				NO_SLEEP=true EVIL=true
				HAS_LITE=true
				UNIQUE=true
				IMMORTAL=true
			}
		}
		[1] =
		{
			define_as = "RACE_DABURA"
			name = "Dabura"
			level = 50 rarity = 90
			desc = 
			{
				"A major demon, Dabura is fond of sport fishing and likes to take afternoon naps.",
			}
			color = color.VIOLET
			speed = 20 life = {70,70} ac = 200
			aaf = 10 sleep = 0
			exp = 100000
			weight = 3600
			blows =
			{
				{"HIT","PIERCE",{10,10}},
			}
			flags = {
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=90
				FACTION=FACTION_DEMON
				CAN_FLY=30 
				MALE=true
				UNIQUE=true
				DBTCHAT=function()
					dialogue.DABURA()
				end
			}
		}
		[2] =
		{
			define_as = "RACE_HILDEGARN"
			name = "Hildegarn"
			level = 70 rarity = 90
			desc = 
			{
				"Hildegarn is the King of the Underworld. He's also an excellent chess",
				"player, and his favorite color is blue.",
			}
			color = color.VIOLET
			speed = 20 life = {100,100} ac = 250
			aaf = 10 sleep = 0
			exp = 200000
			weight = 4000
			blows =
			{
				{"HIT","PIERCE",{15,15}},
			}
			flags = {
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=90
				FACTION=FACTION_DEMON
				MALE=true
				CAN_FLY=30 
				UNIQUE=true
				DBTCHAT=function()
					dialogue.HILDEGARN()
				end
			}
		}
		[3] =
		{
			define_as = "RACE_GOZ"
			name = "Goz"
			level = 40 rarity = 999
			desc = 
			{
				"Goz is one of the greeter demons. He is here to help newcomers adjust to",
				"their new existence in Hell.",
			}
			color = color.VIOLET
			speed = 20 life = {30,30} ac = 200
			aaf = 10 sleep = 0
			exp = 100000
			weight = 4000
			blows =
			{
				{"HIT","PIERCE",{15,15}},
			}
			flags = {
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=30
				FACTION=FACTION_DEMON
				MALE=true
				UNIQUE=true
				DBTCHAT=function()
					dialogue.GOZ_MEZ("Goz")
				end
			}
		}
		[4] =
		{
			define_as = "RACE_MEZ"
			name = "Mez"
			level = 40 rarity = 999
			desc = 
			{
				"Mez is one of the greeter demons. He is here to help newcomers adjust to",
				"their new existence in Hell.",
			}
			color = color.VIOLET
			speed = 20 life = {30,30} ac = 200
			aaf = 10 sleep = 0
			exp = 100000
			weight = 4000
			blows =
			{
				{"HIT","PIERCE",{15,15}},
			}
			flags = {
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=30
				FACTION=FACTION_DEMON
				MALE=true
				UNIQUE=true
				DBTCHAT=function()
					dialogue.GOZ_MEZ("Mez")
				end
			}
		}
		[5] =
		{
			define_as = "RACE_PRINCESS_SNAKE"
			name = "Princess Snake, the temptress"
			desc =
			{
				"This demoness takes the form of an enormous humanoid snake, and guards the Serpent's",
				"Path. She is a powerful sorceress, and not to be trifled with.",
			}
			color = color.LIGHT_GREEN
			level = 60 rarity = 100
			life = {20,20} ac = 200
			exp   = 50000
			speed = 30 
			aaf = 10 sleep = 0
			weight = 600
			spells =
			{
				frequency = 5
				["SummonSnakes"] = { level=30 chance=100 }
			}
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				DBT_REFLECT=30
				FACTION=FACTION_DEMON
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=100 POIS=100 ELEC=80 }
				FEMALE=true
				FACTION=FACTION_DEMON
				EVIL=true
				DBTCHAT=function(name)
						dialogue.JAJOUSHIN()
				end
				CAN_SPEAK=function(name)
						monster_random_say{
						name.." hisses 'Come to me...'",
						name.." hisses 'Looksss like sssupper!",
						name.." says 'You look very tasssty...err, I mean tired. Come ressst in my home.'",}
				end
			}
		}
		[6] =
		{
			define_as = "RACE_TENTACLE_DEMON"
			name = "writhing mass of tentacles"
			desc =
			{
				"A writhing mass of cthuloid tentacles, this foul creature reeks of unspeakable",
				"horrors. You don't want to speculate as to the sources of the slime that drips",
				"from it",
			}
			color = color.LIGHT_GREEN
			level = 30 rarity = 999
			life = {30,30} ac = 120
			exp   = 10000
			speed = 30 
			aaf = 10 sleep = 0
			weight = 4000
			spells =
			{
				frequency = 5
				["PoisonBreath"] = { level=10 chance=100 }
				["SummonSnakes"] = { level=20 chance=100 }
			}
			blows =
			{
				{"CRUSH","CRUSH",{7,7}},
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				DBT_AI=ai.DBT_DEFAULT
				DBT_REFLECT=50
				FACTION=FACTION_DUNGEON
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=100 POIS=100 ELEC=80 }
				FACTION=FACTION_DEMON
				ALLOW_IN_URANAI=true
				EVIL=true
				ON_DEATH = function(monst)
					if enrollments[FLAG_ENROLL_ROSSHI] > 0 then
						local obj = create_artifact(ART_NYOIBO)
						make_item_fully_identified(obj)
						drop_near(obj, -1, monst.fy, monst.fx)
					else
					end
				end
			}
		}
	}
}
new_monster_races
{
	['U'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true 
				DROP_THEME = getter.flags { THEME_PLAIN=100 }
				UNIQUE=true
				IMMORTAL=true
				FORCE_MAXHP=true
				DBT_REFLECT=true
			}
		} -- defaults

		[1] =
		{
			define_as = "RACE_BUU"
			name = "Buu"
			desc =
			{
				"An obese, bright pink demon with a cheery smile and a squeeky voice. Buu looks",
				"and acts perpetually playful and happy. Do not be deceived by his outward",
				"behavior, however, this is the demon responsible for the destruction of a third",
				"of the populated world in our galaxy. Do not take him lightly.",
			}
			color = color.LIGHT_RED
			level = 100 rarity = 999
			life = {100,100} ac = 500
			exp   = 1000000
			speed = 0
			aaf = 50
			weight = 26000
			blows =
			{
				{"PUNCH","CRUSH",{100,100}},
			}
			spells =
			{
				--frequency = 15
				--["InstaKill"] = { level=100 chance=100 }
				--["Teleport To"] = { level=100 chance=100 }
				--["Hold"] = { level=100 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				--AI=ai.DBT_DEFAULT
				DBT_REFLECT=95
				CAN_FLY=30 
				DEFLECT=true
				RESIST=getter.resists{
							CONFUSION=100 FEAR=100 FIRE=100 COLD=100 POIS=100 ELEC=100
							BALLISTIC=80 SLASH=50 PIERCE=50 CRUSH=50
							}
				FACTION=FACTION_DEMON
				CAN_SPEAK=function(name)
						monster_random_say{
						name.." says 'Squee...?'",
						name.." shouts 'SQUEE!!!' excitedly.",
						name.." says 'Squee.' ",
						name.." conjures a piece of chocolate, then eats it. ",
						name.." conjures a comic book, flips through the pages, then eats it. ",
						}
				end
			}
		}
		[2] =
		{
			define_as = "RACE_EVIL_BUU"
			name = "Evil Buu"
			desc =
			{
				"After the incident with the puppy, the demon Buu has split into two distinct",
				"personalities. Physically small and fast, and with all the power and invincibility",
				"of the original, fully integrated Buu, but none of the cuddly cuteness, Evil Buu is",
				"likely to be an end-game unique of fairly ridiculous proportion. Galadriel did warn",
				"you...umm, I mean the Kaioshin did warn you to retire while you had the chance.",
			}
			color = color.LIGHT_RED
			level = 100 rarity = 999
			life = {100,100} ac = 500
			exp   = 1000000
			speed = 50
			aaf = 50
			weight = 1200
			blows =
			{
				{"PUNCH","CRUSH",{100,100}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_REFLECT=90
				CAN_FLY=30 
				RESIST=getter.resists{
							CONFUSION=100 FEAR=100 FIRE=100 COLD=100 POIS=100 ELEC=100
							BALLISTIC=80 SLASH=50 PIERCE=50 CRUSH=50
							}
				FACTION=FACTION_DEMON
				EVIL=true
				CAN_SPEAK=function(name)
						monster_random_say{
						name.." scowls at you.",
						}
				end
			}
		}
		[3] =
		{
			define_as = "RACE_GOOD_BUU"
			name = "Good Buu"
			desc =
			{
				"After the incident with the puppy, the demon Buu has split into two distinct",
				"personalities. This 'Good' Buu physically resembles the original, fully integrated",
				"Buu, but is much less animated, and seems to carry an aura of sadness, no doubt",
				"from the knowledge and memories of the overwhelmingly vast devastation,",
				"death, and destruction his former self was responsible for.",
			}
			color = color.LIGHT_RED
			level = 100 rarity = 999
			life = {100,100} ac = 500
			exp   = 1000000
			speed = 0
			aaf = 50
			weight = 26000
			blows = {}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_REFLECT=90
				CAN_FLY=30 
				DEFLECT=true
				RESIST=getter.resists{
							CONFUSION=100 FEAR=100 FIRE=100 COLD=100 POIS=100 ELEC=100
							BALLISTIC=80 SLASH=50 PIERCE=50 CRUSH=50
							}
				FACTION=FACTION_DEMON
				GOOD=true
				CAN_SPEAK=function(name)
						monster_random_say{
						name.." looks on passively.",
						name.." smiles...then looks a little sad.",
						}
				end
			}
		}
	}
}

