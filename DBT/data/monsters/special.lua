new_monster_races
{
	['p'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags = 
			{
			}
		}
		[1] =
		{
			define_as = "RACE_GIRL_CHILD"
			name = "darling little girl"
			level = 1 rarity = 999
			desc = "Oh! They're so adorable!"
			color = color.LIGHT_RED
			speed = 0 life = {2,5} ac = 5
			aaf = 10 sleep = 10
			exp = 3
			weight = 600
			blows =
			{
				{"BITE","PIERCE",{1,2}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				FEMALE = true
				FACTION=FACTION_PLAYER
				KARMA=-100
				DROP_DRAGONBALL=0
				OPEN_DOOR=false DROP_CORPSE=true
				MORTAL=true
				ON_DEATH = function(monst)
					message("Hmm. Killed your little girl. That's not so good.")
					dball.chalign(-10000)
				end
			}
		}
		[2] =
		{
			define_as = "RACE_BOY_CHILD"
			name = "darling little boy"
			level = 1 rarity = 999
			desc = "Oh! They're so adorable!"
			color = color.LIGHT_BLUE
			speed = 0 life = {2,5} ac = 5
			aaf = 10 sleep = 10
			exp = 3
			weight = 600
			blows =
			{
				{"BITE","PIERCE",{1,2}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				MALE = true
				FACTION=FACTION_PLAYER
				KARMA=-100
				DROP_DRAGONBALL=0
				OPEN_DOOR=false DROP_CORPSE=true
				MORTAL=true
				ON_DEATH = function(monst)
					message("Hmm. Killed your little boy. That's not so good.")
					dball.chalign(-10000)
				end
			}
		}
		[3] =
		{
			define_as = "RACE_POLICE"
			name = "police officer"
			desc =
			{
				"Describe me!",
			}
			level = 1 rarity = 1
			speed = 10 sleep  = 0
			exp   = 100
			color = color.LIGHT_BLUE
			life = {5,5} ac = 50
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,20}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DROP_60=true MALE=true
				KARMA=-50
				SPECIAL_GENE=true
				CAN_SPEAK=function(name) monster_random_say{
					name.." fire a few shots in your direction and then shouts 'Stop or I'll shoot!'",
					name.." twirls his nightstick.",
				}end
				DROP_THEME = getter.flags { THEME_POLICE=100 }
			}
		}
		[4] =
		{
			define_as = "RACE_BUDDHIST_MONK"
			name = "Buddhist monk"
			desc =
			{
				"Describe me!",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 0
			exp   = 10
			color = color.ORANGE
			life = {5,5} ac = 50
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,6}},
				{"HIT","CRUSH",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=50
				NO_FEAR=true
				FACTION=FACTION_KAMI
				SPECIAL_GENE=true
				ALIGN_GOOD=true MALE=true
				KARMA=-100
				CAN_SPEAK=function(name) monster_random_say{
					name.." chants softly.",
					name.." chants softly.",
					name.." chants softly.",
					name.." chants softly.",
					name.." chants softly.",
					name.." chants softly.",
					name.." chants softly.",
					name.." comments 'Good thing nobody knows about the terrible secret our Temple harbors.'",
				}end
				DBTCHAT=function(name)
					message("The monk is silent.")
					-- dialogue.MONK()
				end
				DROP_THEME = getter.flags { THEME_PLAIN=50 THEME_MARTIAL=50 }
			}
		}
		[5] =
		{
			define_as = "RACE_MEDITATING_MONK"
			name = "Buddhist monk"
			desc =
			{
				"This monk appeara to be deep in meditation.",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 0
			exp   = 10
			color = color.ORANGE
			life = {5,5} ac = 50
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,6}},
				{"HIT","CRUSH",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=50
				NO_FEAR=true
				FACTION=FACTION_KAMI
				KARMA=-100
				SPECIAL_GENE=true
				ALIGN_GOOD=true MALE=true
				CAN_SPEAK=function(name) monster_random_say{
					name.." chants softly.",
				}end
				DBTCHAT=function(name) message("The monk says 'Go away! I'm meditating!'") end
				DROP_THEME = getter.flags { THEME_PLAIN=50 THEME_MARTIAL=50 }
			}
		}
		[6] =
		{
			define_as = "RACE_ARU_VILLAGER"
			name = "Aru villager"
			desc =
			{
				"Describe me!",
			}
			level = 1 rarity = 100
			speed = 0 sleep  = 0
			exp   = 1
			color = color.LIGHT_BLUE
			life = {1,6} ac = 1
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,2}},
			}
			flags =
			{
				AI=ai.RANDOM_MOVE
				DBT_AI=ai.RUN_AWAY
				FACTION=FACTION_NEUTRAL
				SPECIAL_GENE=true
				ALIGN_GOOD=true
				CAN_SPEAK=function(name) monster_random_say{
					name.." says 'Aru Villagers should say stuff.'",
				}end
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
			}
		}
		[7] =
		{
			define_as = "RACE_WHINY_ARU"
			name = "Aru villagess"
			desc =
			{
				"Dressed in the finest silks, and with a neck cluttered in jewelry, this",
				"villagess doesn't seem terribly concerned about her 'captivity.'",
			}
			level = 1 rarity = 100
			speed = 0 sleep  = 0
			exp   = 0
			color = color.LIGHT_BLUE
			life = {1,1} ac = 1
			aaf = 10
			weight = 1500
			blows =
			{
			}
			flags =
			{
				AI=ai.RANDOM_MOVE
				DBT_AI=ai.RUN_AWAY
				FACTION=FACTION_NEUTRAL
				KARMA=-10
				FEMALE=true
				DROP_THEME = getter.flags { THEME_PLAIN=100 }
				SPECIAL_GENE=true
				RAND_MOVEMENT=100
				ALIGN_GOOD=true
				DBTCHAT=function()
					dialogue.WHINY_ARU()
				end
				ON_DEATH=function(monst)
					message("test")
				end
				CAN_SPEAK=function(name)
					if quest(QUEST_OOLONG).status == QUEST_STATUS_COMPLETED then
					monster_random_say{
						name.." whines 'You idiot! Now we'll have to go back to Aru!'",
						name.." whines 'Oh no...now that Marcos guy is going to be hitting on us again.'",
					}
					else
						monster_random_say{
							name.." says 'Mmm...I think I'll pass on the cavier tonight.'",
							name.." whines 'How come she got the bigger room?'",
							name.." says 'Ahh...I'll never tire of Don Perignon!'",
							name.." says 'Hmm...I think I need some new diamond earrings.'",
							name.." shrieks 'What!?!? This is only 24 caret gold? How cheap!'",
						}
					end
				end
			}
		}
		[8] =
		{
			define_as = "RACE_JUVINILE_RED"
			name = "juvinile delinquent"
			desc =
			{
				"With torn jeans, cigarette in hand and skateboard under foot, this boy",
				"is trying very hard to be bad...without REALLY being bad.",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 0
			exp   = 1
			color = color.LIGHT_RED
			life = {3,3} ac = 10
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				FACTION=FACTION_NEUTRAL
				SPECIAL_GENE=true
				MALE=true
				KARMA=-10
				DBTCHAT=function()
					dialogue.JUVINILE()
				end
				DROP_THEME = getter.flags { THEME_JUNK=100 }
			}
		}
		[9] =
		{
			define_as = "RACE_JUVINILE_GREEN"
			name = "juvinile delinquent"
			desc =
			{
				"With torn jeans, cigarette in hand and skateboard under foot, this boy",
				"is trying very hard to be bad...without REALLY being bad.",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 0
			exp   = 1
			color = color.GREEN
			life = {3,3} ac = 10
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				FACTION=FACTION_NEUTRAL
				SPECIAL_GENE=true
				MALE=true
				KARMA=-10
				DBTCHAT=function()
					dialogue.JUVINILE()
				end
				DROP_THEME = getter.flags { THEME_JUNK=100 }
			}
		}
		[10] =
		{
			define_as = "RACE_JUVINILE_YELLOW"
			name = "juvinile delinquent"
			desc =
			{
				"With torn jeans, cigarette in hand and skateboard under foot, this boy",
				"is trying very hard to be bad...without REALLY being bad.",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 0
			exp   = 1
			color = color.YELLOW
			life = {3,3} ac = 10
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				FACTION=FACTION_NEUTRAL
				SPECIAL_GENE=true
				MALE=true
				KARMA=-10
				DBTCHAT=function()
					dialogue.JUVINILE()
				end
				DROP_THEME = getter.flags { THEME_JUNK=100 }
			}
		}
		[11] =
		{
			define_as = "RACE_DELIVERY_BOY"
			name = "delivery boy"
			desc =
			{
				"This appears to be Akira's former delivery boy. He's trying very hard to fit",
				"in with his friends, and you feel a little sorry for him.",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 0
			exp   = 1
			color = color.VIOLET
			life = {3,3} ac = 10
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				UNIQUE=true
				FACTION=FACTION_NEUTRAL
				SPECIAL_GENE=true
				MALE=true
				KARMA=-10
				DBTCHAT=function()
					dialogue.DELIVERY_BOY()
				end
				DROP_THEME = getter.flags { THEME_JUNK=100 }
			}
		}
		[12] =
		{
			define_as = "RACE_JOESEPHINE"
			name = "Joesephine"
			desc =
			{
				"Describe me",
			}
			level = 1 rarity = 1
			speed = 0 sleep  = 0
			exp   = 1
			color = color.LIGHT_RED
			life = {3,3} ac = 10
			aaf = 10
			weight = 1250
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				UNIQUE=true
				FACTION=FACTION_NEUTRAL
				SPECIAL_GENE=true
				FEMALE=true
				KARMA=-10
				DBTCHAT=function()
				end
				DROP_THEME = getter.flags { THEME_JUNK=100 }
			}
		}
	}
}
