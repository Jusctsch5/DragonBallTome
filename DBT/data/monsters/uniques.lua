-- Dragonball T: Uniques that don't fit any other category

new_monster_races
{
	['p'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true TAKE_ITEM=true OPEN_DOOR=true
				UNIQUE=true FORCE_MAXHP=true
				REGENERATE=200
			}
		} -- defaults


		[1] =
		{
			define_as = "RACE_YAMCHA"
			name = "Yamcha, the desert bandit"
			desc =
			{
				"A muscular youth with long hair and a scar on his face, Yamcha guards his home in the desert",
				"with his faithful companion Puar. Together, they rob any who trespass.",
			}
			color = color.RED
			level = 25 rarity = 999
			life = {20,20} ac = 100
			exp   = 4000
			speed = 11 
			aaf = 20
			weight = 1800
			blows =
			{
				{"TOUCH","EAT_GOLD",{0,0}},
			}
			flags =
			{
				AI=ai.YAMCHA
				DBT_AI=ai.DBT_ZOMBIE
				DBT_AI_STATE = 0
				DROP_THEME = getter.flags{ THEME_GOLD=100 }
				DROP_NUMBER=getter.random(2,2)
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
					local obj = create_artifact(ART_PANZER_FAUST)
					drop_near(obj, -1, monst.fy, monst.fx)

					-- Logic here is no longer accurate 'implement'
					if quest(QUEST_BRIDGE_BANDIT).status == QUEST_STATUS_TAKEN then
						if player.get_sex() == "Female" then
							message(color.YELLOW, "Poor guy. Killed by his greatest fear.")
						else
							message(color.YELLOW, "You have slain the bridge bandit!")
						end
						quest(QUEST_BRIDGE_BANDIT).status = QUEST_STATUS_FINISHED
					else
						-- Yamcha was redeemed, but killed anyway.
					end
				end
				DBTCHAT=function(name)
					dialogue.YAMCHA()
				end
			}
		}
		[2] =
		{
			define_as = "RACE_DR_GERO"
			name = "Dr Gero"
			desc =
			{
				"Dr. Gero is the technical genuis responsible for the creation of the various",
				"robots and Androids of the Red Ribbon Army. Bent on world domination, he is evil",
				"incarnate, and possibly a little bit insane. Well...maybe a lot bit insane.",
			}
			color = color.VIOLET
			level = 100 rarity = 100
			life = {20,20} ac = 100
			exp   = 100000
			speed = 10 
			aaf = 10
			weight = 1800
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				DROP_THEME = getter.flags{ THEME_TECHNO=100 }
				MALE=true
				HAS_LITE=true
				ALLOW_IN_GERO_LAB=true
				FACTION=FACTION_GERO
				EVIL=true
				-- Dr Gero does NOT appear in Hell! Remember...he's not REALLY dead!
				MORTAL=true
				CAN_SPEAK=function(name)
						monster_random_say{
						name.." mumbles under his breath.",
						name.." curses about some 'foul contraption.'",
						name.." is examining a ridiculously complicated looking gadget.",}
				end
				DBTCHAT=function(name)
					-- check conditions
					dialogue.GERO()
				end
			}
		}
		[3] =
		{
			define_as = "RACE_GINKAKO"
			name = "Ginkako, the thug"
			desc =
			{
				"One of two thugs accosting Aru villagers and demanding money from them.",
			}
			color = color.SLATE
			level = 9 rarity = 999
			life = {10,10} ac = 75
			exp   = 100
			speed = 0 
			aaf = 10
			weight = 1800
			blows =
			{
				{"HIT","SLASH",{3,3}},
				{"TOUCH","EAT_GOLD",{0,0}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DROP_THEME = getter.flags{ THEME_TREASURE=100 }
				MALE=true
				HAS_LITE=true
				EVIL=true
				GOTO_HELL=true
				MORTAL=true
				CAN_SPEAK=function(name)
					if dball_data.kinkaku == 0 then
						monster_random_say{
						name.." demands your money.",
						name.." laughs about how evil he is.",
						name.." asks Kinkaku who he thinks they should rob next.",}
					else
						monster_random_say{
						name.." shouts 'You killed Kinkaku!",
						name.." screams 'Die!'",}
					end
				end
				ON_DEATH = function(monst)
					dball_data.ginkako = 1
				end
			}
		}
		[4] =
		{
			define_as = "RACE_KINKAKU"
			name = "Kinkaku, the thug"
			desc =
			{
				"One of two thugs accosting Aru villagers and demanding money from them.",
			}
			color = color.SLATE
			level = 9 rarity = 999
			life = {10,10} ac = 75
			exp   = 100
			speed = 0 
			aaf = 10
			weight = 1800
			blows =
			{
				{"HIT","SLASH",{3,3}},
				{"TOUCH","EAT_GOLD",{0,0}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DROP_THEME = getter.flags{ THEME_TREASURE=100 }
				MALE=true
				HAS_LITE=true
				EVIL=true
				GOTO_HELL=true
				MORTAL=true
				CAN_SPEAK=function(name)
					if dball_data.ginkako == 0 then
						monster_random_say{
						name.." demands your money.",
						name.." laughs about how evil he is.",
						name.." asks Ginkako who he thinks they should rob next.",}
					else
						monster_random_say{
						name.." shouts 'You killed Ginkako!",
						name.." screams 'Die!'",}
					end
				end
				ON_DEATH = function(monst)
					dball_data.kinkaku = 1
				end
			}
		}

		[5] =
		{
			define_as = "RACE_OOLONG"
			name = "Oolong, the terrible"
			desc =
			{
				"This must be him. The horrible monster mutant anthropomorphic pig who has been taking",
				"the village women of Aru. He's only as high as your waist, so you have a difficult time",
				"feeling very terrified of him, but he must be terrible to do such horrible things.",
			}
			color = color.LIGHT_RED
			level = 12 rarity = 100
			life = {10,10} ac = 50
			exp   = 300
			speed = 10 
			aaf = 10
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{1,4}},
				{"PUNCH","CRUSH",{1,4}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.RUN_AWAY
				DROP_THEME = getter.flags{ THEME_TREASURE=100 }
				DROP_NUMBER=4
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_NEUTRAL
				ON_DEATH = function(monst)
					dball_data.oolong = 1
					dball_data.oolong_resolution = 5
					if quest(QUEST_OOLONG).status == QUEST_STATUS_TAKEN then
						message("You have slain the creature. You feel bad.")
						change_quest_status(QUEST_OOLONG, QUEST_STATUS_COMPLETED)
						dball_data.oolong_quest_helper = 3
					end
					if quest(QUEST_OOLONG_LONELY).status == QUEST_STATUS_TAKEN then
						message("Looks like he won't be getting married any time soon.")
						change_quest_status(QUEST_OOLONG, QUEST_STATUS_FAILED)
					end
					if dball_data.married == FLAG_MARRIED_OOLONG then
						message("Oh, dear. Killed your husband. That's not so good.")
						dball.chalign(-10000)
					end
				end
				CAN_SPEAK=function(name)
					if dball_data.married == 1 then
						monster_random_say
						{
							name.." exclaims 'I am the happiest pig on the planet!",
							name.." says 'I'm really glad I got have a 'happily every after.' '",
							name.." smiles at you.",
							name.." smiles and says 'I love you dearly.'",
						}
					elseif not quest(QUEST_OOLONG).status == QUEST_STATUS_TAKEN then
						monster_random_say
						{
							name.." cries softly to himself.",
							name.." cries out 'They all just want me for my money!",
							name.." whimpers 'Won't I ever find anyone to genuinely love me?'",
							name.." moans 'An entire village...and not one of them a quiet, nice, shy, friendly girl.'",
						}
					end
				end
				DBTCHAT=function(name)
					dialogue.OOLONG()
				end
			}
		}
		[6] =
		{
			define_as = "RACE_PILAF"
			name = "Emperor Pilaf"
			desc =
			{
				"A short, squat, creature of questionable origin with bright blue skin and a poor",
				"disposition, it is not clear exactly what Emperor Pilaf is supposed to be the Emperor",
				"of. He has a castle, and he has his two servants, Mai and Shuu. But...well, that's it.",
			}
			color = color.LIGHT_BLUE
			level = 12 rarity = 100
			life = {10,10} ac = 70
			exp   = 1000
			speed = 10 
			aaf = 10
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{1,4}},
				{"PUNCH","CRUSH",{1,4}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_RUN_AWAY
				DROP_DRAGONBALL=100
				DROP_THEME = getter.flags{ THEME_TREASURE=100 }
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_PILAF
				MORTAL=true
				DBTCHAT=function(name) 
					dialogue.PILAF()
				end
			}
		}
		[7] =
		{
			define_as = "RACE_MAI"
			name = "Mai, Pilaf's Servant"
			desc =
			{
				"The loyal servant of Emperor Pilaf, Mai is certain to have a trick or two up the sleeves",
				"of her trenchcoat.",
			}
			color = color.LIGHT_RED
			level = 17 rarity = 999
			life = {20,20} ac = 80
			exp   = 500
			speed = 10 
			aaf = 10
			weight = 1800
			spells =
			{
				frequency = 1
				["Shoot"] = { level=6 chance=100 }
			}
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_BALLISTICS=40 THEME_TREASURE=30 THEME_PLAIN=30 }
				RESIST=getter.resists{CONFUSION=100}
				FEMALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_PILAF
				MORTAL=true
				DBTCHAT=function(name)
					message("Implement Mai")
				end
				ON_DEATH=function()
					dball_data.mai = 1
				end



			}
		}
		[8] =
		{
			define_as = "RACE_SHUU"
			name = "Shuu, Pilaf's Ninja"
			desc =
			{
				"A small cat-ninja. Never have you seen a ninja quite so clumsy and clueless. Of course,",
				"if a ninja is really doing his job correctly, you'll never see him at all.",
			}
			color = color.LIGHT_DARK
			level = 21 rarity = 100
			life = {20,20} ac = 100
			exp   = 400
			speed = 10 
			aaf = 10
			weight = 1800
			spells =
			{
				frequency = 4
				["Powder"] = { level=4 chance=100 }
			}
			blows =
			{
				{"CLAW","SLASH",{1,6}},
				{"CLAW","SLASH",{1,6}},
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				DBT_REFLECT=10
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_NINJA=100 }
				MALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_PILAF
				MORTAL=true
				ANIMAL=true
				DBTCHAT=function(name)
					message("Implement Shuu")
				end
				ON_DEATH=function()
					dball_data.shuu = 1
				end
			}
		}
		[9] =
		{
			define_as = "RACE_MR_SATAN"
			name = "Mr. Satan"
			desc =
			{
				"The winner of last year's World Tournament, Mr. Satan is commonly accepted as the",
				"most powerful martial artist in the world. And if there is any doubt, just ask him.",
				"He'll tell you.",
			}
			level = 25 rarity = 100
			speed = 15 sleep  = 0
			exp   = 5000
			color = color.UMBER
			life = {30,30} ac = 100
			aaf = 10
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{1,40}},
				{"KICK","CRUSH",{1,40}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				MORTAL=true
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				DROP_NUMBER=getter.random(2,2)
				FACTION=FACTION_NEUTRAL
				ALLOW_IN_SATAN_ESTATE=true
				CAN_SPEAK=function(name)
					if not quest(QUEST_SUSHI).status == QUEST_STATUS_TAKEN then
						monster_random_say
							{
							name.." cries out 'Train! Train harder!",
							name.." announces 'I am the best!'",
							name.." admires his form.",
							name.." says 'No, I'm not giving out autographs today.'",
							}
						end
					end
				DBTCHAT=function(name)
					dialogue.MR_SATAN()
				end
			}
		}
		[10] =
		{
			define_as = "RACE_AKIRA"
			name = "Akira, the sushi chef"
			desc =
			{
				"A small Japanese man, ordinarily he is quiet and unassuming...but you have insulted",
				"his sushi, and he now approaches you with death in his eyes.",
			}
			color = color.YELLOW
			level = 7 rarity = 100
			life = {6,6} ac = 20
			exp   = 100
			speed = 10 
			aaf = 10
			weight = 1400
			blows =
			{
				{"PUNCH","CRUSH",{1,8}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_SUSHI=100 }
				DROP_NUMBER=getter.random(2,2)
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				MORTAL=true
				DBTCHAT=function(name) message("KOROSU!") end
				ON_DEATH = function(monst)
					message(color.YELLOW, "Looks like his fighting wasn't much better than his sushi.")
					dball_data.akira_state = 2 -- (Closes store)
					quest(QUEST_AKIRA_INSULTED).status = QUEST_STATUS_FINISHED
				end
			}
		}
		[11] =
		{
			define_as = "RACE_BURUMA"
			name = "Buruma"
			desc =
			{
				"With a keen mind and an adventurous spirit, Buruma (Bulma/Buluma/etc) spends",
				"her days searching for the infamous dragonballs, and her nights tinkering on",
				"high-tech gadgetry with her father, Dr. Briefs. Buruma is quite spoiled and",
				"vain, but has a reputation for being totally unwilling to let anything get",
				"in the way of what she wants: not monsters, not mountains, not even pride.",
			}
			color = color.LIGHT_BLUE
			level = 12 rarity = 999
			life = {7,7} ac = 50
			exp   = 100
			speed = 10 
			aaf = 10
			weight = 1200
			spells =
			{
				frequency = 6
				["Shoot"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.BURUMA
				-- DBT_AI_STATE=ai.BURUMA
				DROP_THEME=getter.flags{ THEME_ELECTRONICS=100 }
				DROP_NUMBER=getter.random(2,2)
				FEMALE=true
				PARTY_PILOT=true
				PARTY_PARTIED=false
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_ACTS=function()
					local foo = {FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_PELT, FLAG_PARTY_ACT_AVOID}
					return foo
				end
				PARTY_CONDITION=function()
					if quest(QUEST_FIND_BURUMA).status == QUEST_STATUS_FINISHED then -- Must have completed quest
						return true
					else
						return false
					end
				end
				HAS_LITE=true
				GOTO_HEAVEN=true
				-- RAND_MOVEMENT=100
				FACTION=FACTION_GOOD
				DBTCHAT=function(name) 
					dialogue.BURUMA()
				end
				ON_DEATH = function(monst)
					local obj = create_object(TV_ELECTRONICS, SV_DRAGON_RADAR)
					drop_near(obj, -1, monst.fy, monst.fx)
					local obj = create_object(TV_VEHICLE, SV_MOTORCYCLE)
					obj.flags[FLAG_CAPSULED] = true
					drop_near(obj, -1, monst.fy, monst.fx)
					if dball_data.buruma_carrying == 1 then
						drop_near(dball_data.buruma_stored_obj, -1, monst.fy, monst.fx)
						dball_data.buruma_stored_obj = 0
						dball_data.buruma_carrying = 0
					end
					if quest(QUEST_BRIEFS_FIND_BURUMA).status == QUEST_STATUS_TAKEN then
						quest(QUEST_BRIEFS_FIND_BURUMA).status = QUEST_STATUS_FAILED
					end
				end
			}
		}

		[12] =
		{
			define_as = "RACE_RANFAN"
			name = "Ranfan"
			desc =
			{
				"A dazzlingly beautiful girl dressed in a skin tight Qipao, wielding an iron",
				"fan in each hand. She smiles pleasantly at you.",
			}
			color = color.LIGHT_RED
			level = 25 rarity = 30
			life = {20,20} ac = 80
			exp   = 2500
			speed = 10 
			aaf = 10
			weight = 1030
			blows =
			{
				{"HIT","CRUSH",{2,10}},
				{"HIT","CRUSH",{2,10}},
			}
			spells =
			{
				frequency = 8
				["Seduce"] = { level=30 chance=100 }
				["ThrowFan"] = { level=15 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				FEMALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				DROP_THEME=getter.flags{ THEME_PLAIN=100 }
			}
		}

		[13] =
		{
			define_as = "RACE_NAM"
			name = "Nam"
			desc =
			{
				"A thoroughly tanned boy of perhaps 15. He has excellent muscle tone and virtually",
				"no fat on him at all. He looks into your eyes with fierce determination.",
			}
			color = color.UMBER
			level = 25 rarity = 60
			life = {20,20} ac = 100
			exp   = 2500
			speed = 10 
			aaf = 10
			weight = 1400
			blows =
			{
				{"PUNCH","CRUSH",{1,10}},
				{"PUNCH","CRUSH",{1,10}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_REFLECT=30
				NO_FEAR=true
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				RESIST=getter.resists{FEAR=100}
				CAN_SPEAK=function(name)
					monster_random_say
						{
						name.." says 'I will win!'",
						name.." looks at you with fire in his eyes.",
						name.." lets out a fierce battle cry!",
						}
					end
			}
		}
		[14] =
		{
			define_as = "RACE_VIDEL"
			name = "Videl"
			desc =
			{
				"A friendly, charming young girl, Videl looks to be in her late teens. She",
				"looks at you pleasantly with the eyes of a girl who is down-to-earth,",
				"feminine, emotionally stable, and ready to give as much to a relationship as",
				"she expects to receive. All of this makes her a rare find, but especially",
				"surprising is that she is also the daughter of Mr. Satan, world renowed",
				"as the best tournament fighter in the world. How she has survived wealth,",
				"fame, and fortune and yet still retained her inner feminine beauty is a",
				"great mystery we can only hope more girls will unravel.",
			}
			color = color.YELLOW
			level = 1 rarity = 100
			life = {5,5} ac = 50
			exp   = 500
			speed = 0 
			aaf = 10
			weight = 1400
			blows = {}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_RUN_AWAY
				FEMALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_GOOD
				PARTY_PARTIED=false
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_ACTS=function()
					local foo = {FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_AVOID}
					return foo
				end
				PARTY_CONDITION=function()
					if quest(QUEST_FIND_BURUMA).status == QUEST_STATUS_FINISHED then -- Must have completed quest
						return true
					else
						return false
					end
				end
				DBTCHAT=function(name)
					dialogue.VIDEL()
				end
			}
		}
		[15] =
		{
			define_as = "RACE_CHICHI"
			name = "Chichi"
			desc =
			{
				"Thin and quiet, Chichi reminds you of a beautiful flower on the threshhold before",
				"spring, not quite ready to bloom. While obviously very intelligent, she's just",
				"a little too shy to say much, and prefers to watch events in the world go on",
				"around her. She has a bit of a problem with her temper, however, and the slightest",
				"annoyance can transform her from a delicate flower to raging thunderstorm.",
			}
			color = color.VIOLET
			level = 1 rarity = 35
			life = {10,20} ac = 120
			exp   = 500
			speed = 17 
			aaf = 10
			weight = 1400
			blows =
			{
				{"HIT","CRUSH",{1,6}},
			}
			spells =
			{
				frequency = 6
				["Shoot"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.CHICHI
				FEMALE=true
				HAS_LITE=true
				SPECIAL_GENE=true
				FACTION=FACTION_GOOD
				GOTO_HEAVEN=true
				PARTY_PARTIED=false
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_ACTS=function()
					local foo = {FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_AVOID}
					return foo
				end
				PARTY_CONDITION=function()
					if quest(QUEST_FIND_BURUMA).status == QUEST_STATUS_FINISHED then -- Must have completed quest
						return true
					else
						return false
					end
				end
				DBTCHAT=function(name)
					dialogue.CHICHI()
				end
				CAN_SPEAK=function()
					if dball_data.chichi_state == 2 then
						-- message("Chichi shrieks 'You pervert!'")
					end
				end
				ON_DEATH = function(monst)
					dball_data.chichi_state = 3
				end
			}
		}
		[16] =
		{
			name = "Bra"
			desc =
			{
				"Sort of a pompous, pushy girl, but who wouldn't be with double-D breasts and",
				"parents who thought it would be a good idea to name her 'Bra?' You get the impression",
				"that she developed physically at a very early age. You can only imagine what sort of",
				"childhood she led...all the jokes she must have been the butt of throughout the years.",
				"You would almost feel sorry for her if she weren't quite so obnoxious. And, on top of",
				"it all, the only source of self validation she seems to understand is from the very",
				"situations in which she is being taken advantage of. She may hate being on the receiving",
				"end of sexual comments, but at the same time she craves the attention, and obviously",
				"goes out of her way to give men the opportunity to make them so she can play the role",
				"of the helpless, submissive victim. A classic case of a girl who never learned healthy",
				"ways to relate to men, Bra is not the most psychologically stable of girls.",
			}
			color = color.LIGHT_BLUE
			level = 1 rarity = 100
			life = {5,5} ac = 25
			exp   = 500
			speed = 0 
			aaf = 10
			weight = 1400
			blows = {}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_RUN_AWAY
				FEMALE=true
				HAS_LITE=true
				SPECIAL_GENE=true
				FACTION=FACTION_GOOD
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					dialogue.BRA()
				end
				CAN_SPEAK=function(name)
					if player.get_sex() == "Female" then
						monster_random_say
							{
							name.." looks at her boobs, then at yours...and giggles under her breath.",
							name.." does her nails.",
							name.." looks around, bored.",
							}
					else
						monster_random_say
							{
							name.." looks at you coyly.",
							name.." blinks innocently.",
							name.." pushes out her chest and pretends not to notice.",
							}
					end
				end
			}
		}
		[17] =
		{
			define_as = "RACE_OXKING"
			name = "Ox King"
			desc =
			{
				"A happy, jolly, giant of a man who would be perfectly at home riding around with",
				"Valkyries, with a tankard of ale in one hand, and a teddy bear in the other.",
				"Apart from his viking helm and nordic furs he looks like he has had a smile on",
				"his face his entire life and you find him immensely likeable. Interestingly, he",
				"once was a very unpleasant person renowed for death and cruelty. Apparently he",
				"decided to be warm and fuzzy instead.",
			}
			color = color.LIGHT_RED
			level = 12 rarity = 999
			life = {35,35} ac = 70
			exp   = 500
			speed = 0 
			aaf = 10
			weight = 1400
			blows = {}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_RUN_AWAY
				MALE=true
				HAS_LITE=true
				FACTION=FACTION_GOOD
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					dialogue.OXKING()
				end
			}
		}
		[18] =
		{
			define_as = "RACE_FANLADY"
			name = "Fan Lady"
			desc =
			{
				"A charming, middle aged woman stands on the corner peddling her wares. For a mere",
				"hundred zeni she will make a most beautiful fan for you. Of course, you'll have",
				"to supply the materials as well. Most fans are made from bird feathers. Where could",
				"you find some birds for her to make a fan from?",
			}
			color = color.LIGHT_RED
			level = 1 rarity = 999
			life = {3,3} ac = 10
			exp   = 100
			speed = 0 
			aaf = 10
			weight = 1400
			blows = {}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_RUN_AWAY
				FEMALE=true
				HAS_LITE=true
				GOOD=true
				FACTION=FACTION_NEUTRAL
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					dialogue.FANLADY()
				end
			}
		}
		[19] =
		{
			define_as = "RACE_LUNCH"
			name = "Lunch"
			desc =
			{
				"At one moment, a shy, quiet, calm girl...the next a raging torrent of anger and",
				"hormones, Lunch is the most violet case of multiple personality disorder you're",
				"likely ever to encounter in a roguelike.",
			}
			color = color.LIGHT_RED
			level = 15 rarity = 999
			life = {10,10} ac = 50
			exp   = 100
			speed = 7
			aaf = 10
			weight = 1400
			blows =
			{
				{"HIT","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 4
				["Shoot"] = { level=6 chance=100 }
				["Grenade"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.LUNCH
				NO_FEAR=true
				FEMALE=true
				-- NOTE: See ai.LUNCH for Lunch's party handling
				-- Her Available AI's change when she sneezes
				PARTY_PARTIED=false
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_ACTS=function()
					local foo = {FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_AVOID}
					return foo
				end
				-- PARTY_ACTS={FLAG_PARTY_ACT_MINOR_CHAOS, FLAG_PARTY_MAJOR_CHAOS}
				PARTY_CONDITION=function()
					return true
				end
				HAS_LITE=true
				FACTION=FACTION_LUNCH
				GOTO_HEAVEN=true
				ALLOW_IN_EARTH_EASY=true
				CAN_SPEAK=function(name)
				end
				DBTCHAT=function(name)
					dialogue.LUNCH()
				end
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_CONDITION=function()
					return FLAG_PARTY_FORCE_ALLOW	
				end
			}
		}
		[20] =
		{
			define_as = "RACE_BOJACK"
			name = "Bojack"
			desc =
			{
				"My notes say 'fairly random bad guy of unknown origin,' Woohoo! Do you know",
				"what that means? That means, for me, not coming up with a description and being",
				"annoyed at accidently erasing them! And for you, it means a monster that",
				"has ALL the ALLOW_IN flags, so you can encounter him anywhere! Wow!",
			}
			color = color.LIGHT_RED
			level = 35 rarity = 1
			life = {20,20} ac = 150
			exp   = 7000
			speed = 20 
			aaf = 10
			weight = 1400
			blows =
			{
				{"PUNCH","CRUSH",{7,7}},
			}
			spells =
			{
				frequency = 10
				["Throw"] = { level=6 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_THROWER
				DBT_REFLECT=40
				MALE=true
				HAS_LITE=true
				GOTO_HELL=true
				ALLOW_IN_SEWERS=true
				ALLOW_IN_GERO_LAB=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_SATAN_ESTATE=true
				ALLOW_IN_TOURNAMENT=true
				ALLOW_IN_VOLCANO=true
				ALLOW_IN_URANAI=true
			}
		}
		[21] =
		{
			define_as = "RACE_STORE_HACK"
			name = "Man in a trenchcoat"
			desc =
			{
				"This seedy-looking man is dressed in a dark brown trenchcoat and wearing",
				"sunglasses. His eyes are constantly darting back and forth, and he looks",
				"very suspicious. Looking more closely, you notice a logo on his trenchcoat",
				"that appears to depict a cute young girl with frilly, dark hair, a divinely",
				"magnificent coat, and massive boots. She seems to be smashing some sort of",
				"large, multi-legged creature with a six foot long mallet.",
			}
			color = color.UMBER
			level = 1 rarity = 999
			life = {5,5} ac = 25
			exp   = 1
			speed = 0 
			aaf = 10
			weight = 1400
			blows = {}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				MALE=true
				HAS_LITE=true
				GOOD=true
				FACTION=FACTION_NEUTRAL
				MORTAL=true
				DBTCHAT=function(name)
					dialogue.STORE_HACK()
				end
			}
		}
		[22] =
		{
			define_as = "RACE_WIMPY_GUY"
			name = "Slim, the fighter"
			desc =
			{
				"You're not sure what to make of this one. He is dressed in a Japanese style",
				"uniform that has been heavily covered with trendy patches. He's torn the arms",
				"and legs of his uniform off at the shoulders and knees to expose his musculature.",
				"And, he is well muscled. Still, there is something about him that seems...not",
				"quite right.",
			}
			color = color.UMBER
			level = 1 rarity = 999
			life = {5,5} ac = 1
			exp   = 1
			speed = 0 
			aaf = 10
			weight = 1600
			blows = {}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=1000 -- Just for fun
				MALE=true
				HAS_LITE=true
				FACTION=FACTION_DUNGEON
				GOTO_HEAVEN=true
			}
		}
		[23] =
		{
			define_as = "RACE_CHAOZU"
			name = "Chaozu"
			desc =
			{
				"A most peculiar looking fighter with pale white skin and puffy red cheeks, and about",
				"three feet tall. He looks almost like a doll. And yet, you suspect he may be far more",
				"formidable than he appears.",
			}
			color = color.ANTIQUE_WHITE
			level = 28 rarity = 999
			life = {15,15} ac = 100
			exp   = 5000
			speed = 11 
			aaf = 10
			weight = 1400
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=10 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{1,8}},
				{"KICK","CRUSH",{1,8}},
			}
			flags =
			{
				AI=ai.CHAOZU
				DBT_REFLECT=50
				NO_FEAR=true
				RESIST=getter.resists{CONFUSION=100}
				MALE=true
				CAN_FLY=30 
				HAS_LITE=true
				GOOD=true
				GOTO_HEAVEN=true
				FACTION=FACTION_CRANE
				DBTCHAT=function(name)
					dialogue.CHAOZU()
				end
				PARTY_PARTIED=false
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_ACTS=function()
					local foo = { FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_FIGHT, FLAG_PARTY_ACT_PELT, FLAG_PARTY_ACT_AVOID }
					return foo
				end
				PARTY_CONDITION=function()
					if enrollments[FLAG_ENROLL_CRANE_HERMIT] < 1 then -- Must study crane
						return false
					else
						return true
					end
				end
			}
		}
		[24] =
		{
			define_as = "RACE_TENSHINHAN"
			name = "Tenshinhan"
			desc =
			{
				"A powerfully muscled fighter with three eyes. He moves with stunning grace and",
				"and speed, more so than you would think possible for someone of his bulk. He",
				"has clearly trained with a master.",
			}
			color = color.GREEN
			level = 33 rarity = 999
			life = {30,30} ac = 100
			exp   = 4000
			speed = 20
			aaf = 10
			weight = 1550
			spells =
			{
				frequency = 5
				["Chi Burst"] = { level=5 chance=100 }
				["Throw"] = { level=3 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{1,10}},
				{"KICK","CRUSH",{1,30}},
			}
			flags =
			{
				AI=ai.TENSHINHAN
				DBT_REFLECT=60
				NO_FEAR=true
				DROP_THEME=getter.flags{ THEME_MARTIAL=100 }
				-- DROP_NUMBER=getter.random(2,2)
				MALE=true
				CAN_FLY=30 
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_CRANE
				RESIST=getter.resists{ FEAR=100 }
				DBTCHAT=function(name) 
					dialogue.TENSHINHAN()
				end
				ON_DEATH = function(monst)
				end
				PARTY_PARTIED=false
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_ACTS=function()
					local foo = { FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_FIGHT, FLAG_PARTY_ACT_PELT, FLAG_PARTY_ACT_AVOID }
					return foo
				end
				PARTY_CONDITION=function()
					if enrollments[FLAG_ENROLL_CRANE_HERMIT] < 1 then -- Must study crane
						return false
					else
						return true
					end
				end
			}
		}
		[25] =
		{
			define_as = "RACE_BACTERIUM"
			name = "Bacterium"
			desc =
			{
				"This fighter is a practitioner of a kempo style you don't recognize. Curiously,",
				"he makes no secret of the fact that he has a 'special attack.' It seems that he",
				"has never bathed or brushed his teeth in his entire life. You can smell him",
				"from quite a ways, and the scent is nauseating.",
			}
			level = 15 rarity = 5
			speed = 15 sleep  = 0
			exp   = 500
			color = color.LIGHT_GREEN
			life = {20,10} ac = 80
			aaf = 10
			weight = 1750
			blows =
			{
				{"PUNCH","CRUSH",{1,8}},
				{"KICK","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 6
				["PoisonBreath"] = { level=5 chance=100 }
				["Throw"] = { level=2 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				MALE=true FORCE_MAXHP=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				MORTAL=true UNIQUE=true
				CAN_SPEAK=function(name)
				end
			}
		}
		[26] =
		{
			define_as = "RACE_OOPA"
			name = "Oopa"
			desc =
			{
				"A small boy, perhaps six years old, dressed in animal furs and beads. Oopa is Bosa's",
				"friendly and cheerful son.",
			}
			level = 1 rarity = 999
			speed = 0 sleep  = 0
			exp   = 500
			color = color.LIGHT_UMBER
			life = {1,3} ac = 1
			aaf = 10
			weight = 1750
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				MALE=true FORCE_MAXHP=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				SPECIAL_GENE=true
				FACTION=FACTION_KAMI
				MORTAL=true UNIQUE=true
				CAN_SPEAK=function(name)
				end
			}
		}
		[27] =
		{
			define_as = "RACE_BOSA"
			name = "Bosa, Guardian of the Land of Korin"
			desc =
			{
				"A massively built man dressed in animal skins, Bosa guards the base of Korin tower from",
				"any evil that dares approach. While clearly powreful, he is friendly and",
				"kind to those who intend no harm to this holy land.",
			}
			level = 27 rarity = 999
			speed = 15 sleep  = 0
			exp   = 1000
			color = color.UMBER
			life = {25,25} ac = 25
			aaf = 10
			weight = 2100
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_REFLECT=25
				DBT_AI=ai.DBT_DEFAULT
				MALE=true FORCE_MAXHP=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				SPECIAL_GENE=true
				FACTION=FACTION_KAMI
				MORTAL=true UNIQUE=true
				CAN_SPEAK=function(name)
				end
			}
		}
		[28] =
		{
			define_as = "RACE_ANTON"
			name = "Anton, the Great"
			desc =
			{
				"A massive wrestler, Anton 'the Great' towers over you. He doesn't appear to be",
				"the most skillful fighter in the world, but you get the impression that it might be bad if",
				"you let him grab a hold of you.",
			}
			level = 27 rarity = 999
			speed = 11 sleep  = 0
			exp   = 1700
			color = color.LIGHT_UMBER
			life = {30,30} ac = 25
			aaf = 10
			weight = 3500
			blows =
			{
			}
			spells =
			{
				frequency = 1
				["Bearhug"] = { level=7 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_THROWER
				MALE=true FORCE_MAXHP=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				SPECIAL_GENE=true
				FACTION=FACTION_NEUTRAL
				MORTAL=true UNIQUE=true
				CAN_SPEAK=function(name)
				end
			}
		}
		[29] =
		{
			define_as = "RACE_CHAPAO"
			name = "Chapao"
			desc =
			{
				"This man intends to prove himself the strongest fighter in the world. Whether he",
				"is, remains to be seen.",
			}
			level = 27 rarity = 999
			speed = 18 sleep  = 0
			exp   = 3000
			color = color.UMBER
			life = {25,25} ac = 100
			aaf = 10
			weight = 1800
			blows =
			{
			}
			spells =
			{
				frequency = 7
				["Throw"] = { level=3 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				MALE=true FORCE_MAXHP=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				SPECIAL_GENE=true
				FACTION=FACTION_NEUTRAL
				MORTAL=true UNIQUE=true
				CAN_SPEAK=function(name)
				end
			}
		}
		[30] =
		{
			define_as = "RACE_CARONI"
			name = "Caroni"
			desc =
			{
				"Dressed in white spandex, and holding several red roses, Caroni is one of is one of",
				"Mr Satan's most Senior students. While some may say that his excessive flamboyance",
				"and flashy stances tend to distract him from his fighting, it does tend to get him a",
				"lot of girls.",
			}
			level = 23 rarity = 1
			speed = 15 sleep  = 0
			exp   = 2000
			color = color.WHITE
			life = {25,25} ac = 100
			aaf = 10
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{1,20}},
				{"KICK","CRUSH",{1,20}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				MORTAL=true
				DROP_THEME = getter.flags{ THEME_PLAIN=100 }
				DROP_NUMBER=getter.random(2,2)
				FACTION=FACTION_NEUTRAL
				ALLOW_IN_SATAN_ESTATE=true
				DBTCHAT=function(name)
				end
			}
		}
		[31] =
		{
			define_as = "RACE_PIROZUKI"
			name = "Pirozuki"
			desc =
			{
				"A veritable powerhouse of fat and muscle, Pirozuki is one of Mr Satan's most Senior students.",
				"He doesn't look very fast, or very bright, for that matter...but you wouldn't want him to sit",
				"on you.",
			}
			level = 23 rarity = 1
			speed = 11 sleep  = 0
			exp   = 2000
			color = color.UMBER
			life = {25,25} ac = 120
			aaf = 10
			weight = 3200
			blows =
			{
				{"PUNCH","CRUSH",{1,20}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				MORTAL=true
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				DROP_NUMBER=getter.random(2,2)
				FACTION=FACTION_NEUTRAL
				ALLOW_IN_SATAN_ESTATE=true
				DBTCHAT=function(name)
				end
			}
		}
		[32] =
		{
			define_as = "RACE_MISS_PIIZA"
			name = "Miss Piiza"
			desc =
			{
				"Mr Satan's business manager. Dressed in a bright red ensemble that doesn't leave much to the",
				"imagination, Miss Piiza is always ready to promote Mr. Satan and his students.",
			}
			level = 7 rarity = 1
			speed = 7 sleep  = 0
			exp   = 300
			color = color.PINK
			life = {7,7} ac = 50
			aaf = 10
			weight = 1200
			blows =
			{
				{"PUNCH","CRUSH",{1,10}}, 
			}
			spells =
			{
				frequency = 4
				["Shriek"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_RUN_AWAY
				SPECIAL_GENE=true
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				MORTAL=true
				DROP_THEME = getter.flags{ THEME_PLAIN=100 }
				DROP_NUMBER=getter.random(2,2)
				FACTION=FACTION_NEUTRAL
				ALLOW_IN_SATAN_ESTATE=true
				DBTCHAT=function(name)
					dialogue.MISS_PIIZA()
				end
			}
		}
		[33] =
		{
			define_as = "RACE_PUNTER"
			name = "Punter"
			desc =
			{
				"A large, well-rounded man dressed as an arabian peasant, Punter looks to be the sort of",
				"fighter who compensates for his adequete skill with his tremendous size. Certainly he",
				"must have a great deal of muscle to carry his own weight. Besides, surely all that blubber",
				"must be worth at least a few points of armor class.",
			}
			level = 27 rarity = 999
			speed = 11 sleep  = 0
			exp   = 3000
			color = color.UMBER
			life = {25,25} ac = 120
			aaf = 10
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{1,10}}, 
			}
--			spells =
--			{
--				frequency = 7
--				["Throw"] = { level=3 chance=100 }
--			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				MALE=true FORCE_MAXHP=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				SPECIAL_GENE=true
				FACTION=FACTION_NEUTRAL
				MORTAL=true UNIQUE=true
				CAN_SPEAK=function(name)
				end
			}
		}
		[34] =
		{
			define_as = "RACE_MIA"
			name = "Mia, the party test unique"
			desc =
			{
				"Mia is a short young girl, perhaps twelve years old. She is pertually cheerful",
				"and exhuberant nearly to the point of sillyness. She is here to help you test",
				"the new party system.",
			}
			color = color.LIGHT_BLUE
			level = 1 rarity = 999
			life = {10,10} ac = 40
			exp   = 1
			speed = 0 
			aaf = 10
			weight = 900
			blows =
			{
				{"PUNCH","CRUSH",{1,10}}, 
			}
			spells =
			{
				frequency = 6
				["Shoot"] = { level=1 chance=100 }
			}
			flags =
			{
				AI=ai.PARTY
				DBT_REFLECT=1000 -- Just for fun
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_PARTIED=false
				PARTY_ACTS=function()
					local foo = { FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_FIGHT, FLAG_PARTY_ACT_PELT, FLAG_PARTY_ACT_AVOID, FLAG_PARTY_ACT_BOARD }
					return foo
				end
				PARTY_CONDITION=function()
					return true
				end
				FEMALE=true
				HAS_LITE=true
				FACTION=FACTION_PLAYER
				GOTO_HEAVEN=true
				DBTCHAT=function()
					dialogue.MIA()
				end
			}
		}
	}
}

new_monster_races
{
	['q'] =	{
		defaults = {
			sleep  = 0
			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true
				FORCE_MAXHP=true
				ANIMAL=true
				UNIQUE=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				REGENERATE=200
			}
		} -- defaults

		[1] =
		{
			define_as = "RACE_BUBBLES"
			name = "Bubbles, the monkey"
			desc =
			{
				"A rather playful pet monkey belonging to the North Kaio. While Bubbles isn't a",
				"tremendously powerful martial artist, he has at least managed to adapt to the",
				"extreme gravity on the Kaio's planet, and is quite happy frolicking about.",
			}
			color = color.LIGHT_UMBER
			level = 5 rarity = 100
			life = {5,5} ac = 100
			exp   = 5000
			speed = 50 
			aaf = 10
			weight = 600
			blows =
			{
			}
			flags =
			{
				AI=ai.BUBBLES
				MALE=true
				FACTION=FACTION_KAMI
				ALLOW_ON_KAIO_WORLD=true
				GOOD=true
				TAKE_ITEM=true
				DBTCHAT=function(name)
					if quest(QUEST_KAIO_BUBBLES).status == QUEST_STATUS_TAKEN then
						message("You have caught Bubbles!")
						change_quest_status(QUEST_KAIO_BUBBLES, QUEST_STATUS_COMPLETED)
					else
						message("Oo-uh-oo-uh-oo!")
					end
				end
			}
		}
		[2] =
		{
			define_as = "RACE_UMIGAME"
			name = "Umigame, the sea turtle"
			desc =
			{
				"Master Rosshi's pet sea turtle, Umigame is as friendly as most sea turtles",
			}
			color = color.SLATE
			level = 1 rarity = 999
			life = {1,1} ac = 1
			exp   = 1
			speed = -10 
			aaf = 10
			weight = 600
			blows = {}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_RUN_AWAY
				MALE=true
				FACTION=FACTION_GOOD
				ALLOW_IN_EARTH_SAFE=true
				ALLOW_IN_EARTH_EASY=true
				GOOD=true
				-- Should Umiagme appear in Heaven?
				AQUATIC=true
				ON_DEATH = function(monst)
					message(color.YELLOW, "Umigame is dead! Master Rosshi will not be pleased.")
					change_quest_status(QUEST_LOST_TURTLE, QUEST_STATUS_FAILED)
				end
				DBTCHAT=function(name)
					if quest(QUEST_LOST_TURTLE).status == QUEST_STATUS_TAKEN then
						message("Hello! I'm lost. You look like you know where you're going, so I'll follow you!")
						for_each_monster(function(m_idx, monst)
							if monst.r_idx == RACE_UMIGAME then
								monst.flags[FLAG_RAND_MOVEMENT] = 25
								monst.faction = FACTION_PLAYER
								monst.flags[FLAG_PERMANENT] = true
							end
						end)
					else
						message("Hello!")
					end
				end
			}
		}

		[3] =
		{
			name = "Iruka, the dolphin"
			desc =
			{
				"A playful dolphin, frolicking through the water.",
			}
			color = color.LIGHT_BLUE
			level = 1 rarity = 999
			life = {5,5} ac = 20
			exp   = 50
			speed = 10 
			aaf = 10
			weight = 6000
			blows =
			{
				{"BITE","PIERCE",{1,10}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_RUN_AWAY
				ALLOW_IN_EARTH_SAFE=true
				ALLOW_IN_EARTH_EASY=true
				ALLOW_IN_EARTH_HARD=true
				AQUATIC=true
				MALE=true
				FACTION=FACTION_NEUTRAL
				GOOD=true
				DBTCHAT=function(name)
					message("Hello!")
				end
			}
		}
		[4] =
		{
			define_as = "RACE_TAMA"
			name = "Tama, the cat"
			desc =
			{
				"Cuddly and affectionate, Tama is Dr. Breifs' cat, and rarely goes without him.",
			}
			color = color.LIGHT_DARK
			level = 1 rarity = 999
			life = {5,5} ac = 50
			exp   = 50
			speed = 10 
			aaf = 10
			weight = 6000
			blows =
			{
				{"BITE","PIERCE",{1,1}},
			}
			flags =
			{
				AI=ai.TAMA
				DBT_AI=ai.DBT_ZOMBIE
				FEMALE=true
				KITTY=true
				NO_CATNIP=true
				-- Heaven?
				FACTION=FACTION_NEUTRAL
				DBTCHAT=function(name)
					dialogue.TAMA()
				end
			}
		}
		[5] =
		{
			define_as = "RACE_BEAR_THIEF"
			name = "Bear Thief"
			desc =
			{
				"A rather ordinary looking brown bear...except for the black mask and bag slung",
				"over his shoulder.",
			}
			color = color.UMBER
			level = 21 rarity = 1
			life = {20,20} ac = 90
			exp   = 1000
			speed = 13 
			aaf = 10
			weight = 6000
			blows =
			{
				{"CLAW","SLASH",{1,10}},
				{"CLAW","SLASH",{1,10}},
				{"BITE","SLASH",{1,10}},
				{"TOUCH","EAT_DRAGONBALL",{1,10}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DROP_DRAGONBALL=100
				MALE=true
				EVIL=true
				-- Hell?
				RESIST=getter.resists{SLASH=50 COLD=50 }
				ALLOW_IN_SEWERS=true
				ALLOW_IN_NINJA_SEWERS=true
				ALLOW_IN_FOOT_LAIR=true
				ALLOW_IN_GERO_LAB=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_SATAN_ESTATE=true
				ALLOW_IN_VOLCANO=true
				ALLOW_IN_URANAI=true
			}
		}
		[6] =
		{
			define_as = "RACE_CUTE_LITTLE_PUPPY"
			name = "cute ilttle puppy"
			desc =
			{
				"It's a cute little puppy.",
			}
			color = color.UMBER
			level = 1 rarity = 999
			life = {5,5} ac = 50
			exp   = 50
			speed = 10 
			aaf = 10
			weight = 6000
			blows =
			{
				{"BITE","PIERCE",{1,1}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_RUN_AWAY
				MALE=true
				ALLOW_IN_EARTH_SAFE=true
				ALLOW_IN_EARTH_EASY=true
				FACTION=FACTION_NEUTRAL
				DBTCHAT=function(name)
					monster_random_say{
						"Arf!",
						"Bark!",
					}
				end
			}
		}
	}
}

new_monster_races
{
	['M'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true 
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				UNIQUE=true FORCE_MAXHP=true
				REGENERATE=200
				SPECIAL_GENE=true
			}
		} -- defaults

		[1] =
		{
			define_as = "RACE_BABIDI"
			name = "Babidi, the Sorceror"
			desc =
			{
				"Babidi is a mutant sorceror from another planet. Perhaps four feet tall, and somewhat",
				"resembling an upright, walking fish with long, gangly arms, he doesn't look physically",
				"intimidating at all. However, any unique to show up this late in the game is obviously",
				"dangerous, right? He is dressed in penculiar, but very expensive-looking clothing, and",
				"amongst the apparantly magical paraphenelia he wears is an amulet bearing a symbol which",
				"appears to be a giant capital letter 'M' stylized from the Greek symbol for finality,",
				"Omega.",
			}
			color = color.YELLOW
			level = 60 rarity = 999
			life = {20,20} ac = 200
			exp   = 500000
			speed = 30 
			aaf = 10
			weight = 900
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				RESIST=getter.resists{CONFUSION=100 FIRE=100 POIS=100 ELEC=100 COLD=100 }
				MALE=true
				HAS_LITE=true
				EVIL=true
				GOTO_HELL=true
				DBTCHAT=function(name)
					dialogue.BABIDI()
				end
			}
		}
		[2] =
		{
			define_as = "RACE_FREEZA"
			name = "Freeza"
			desc =
			{
				"Freeza is a humanoid mutant, with purplish skin and a long tail. He is ",
				"somewhat smaller than the average human, and he is wearing what appears to be some",
				"sort of body armor made of a light white metal. Somehow, though, despire his size",
				"you get the impression that he is far sturdier than he looks, and that the metal",
				"he wears is not for protection, but rather it is the only material able to withstand",
				"the harsh conditions his body routinely endures.",
			}
			color = color.LIGHT_BLUE
			level = 60 rarity = 100
			life = {70,70} ac = 200
			exp   = 500000
			speed = 30 
			aaf = 10
			weight = 1500
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=90
				NO_FEAR=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=-50 POIS=100 ELEC=80 COLD=80 CRUSH=40 SLASH=40 PIERCE=40 }
				MALE=true
				HAS_LITE=true
				-- FACTION=FACTION_FREEZA
				EVIL=true
				GOTO_HELL=true
				DBTCHAT=function(name)
					dialogue.FREEZA()
				end
			}
		}
		[3] =
		{
			define_as = "RACE_BURTUR"
			name = "Burtur"
			desc =
			{
				"A mercenary in Freeza's 'Ginyu Force,' Burtur is a tall, blue-skinned alien.",
				"Nicknamed the 'Blue Hurricane' Burtur fancies himself the fastest being in the",
				"universe.",
			}
			color = color.LIGHT_BLUE
			level = 45 rarity = 100
			life = {40,40} ac = 150
			exp   = 500000
			speed = 50 
			aaf = 10
			weight = 1700
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				RESIST=getter.resists{CRUSH=20 SLASH=20 PIERCE=20 }
				DBT_REFLECT=60
				MALE=true
				HAS_LITE=true
				-- FACTION=FACTION_FREEZA
				EVIL=true
				GOTO_HELL=true
				--DBTCHAT=function(name)
				--	dialogue.BURTUR()
				--end
			}
		}
		[4] =
		{
			define_as = "RACE_GINYU"
			name = "Captain Ginyu"
			desc =
			{
				"The leader of the notorious 'Ginyu Force,' and certainly the most dangerous",
				"of the group. He is large and powerful looking, and curiously, appears to have",
				"a skull that exposes his brain to the open air.",
			}
			color = color.VIOLET
			level = 45 rarity = 100
			life = {40,40} ac = 150
			exp   = 100000
			speed = 20 
			aaf = 10
			weight = 1700
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				NO_FEAR=true
				RESIST=getter.resists{CRUSH=20 SLASH=20 PIERCE=20 }
				DBT_REFLECT=70
				MALE=true
				HAS_LITE=true
				-- FACTION=FACTION_FREEZA
				EVIL=true
				GOTO_HELL=true
				--DBTCHAT=function(name)
				--	dialogue.BURTUR()
				--end
			}
		}
		[5] =
		{
			define_as = "RACE_GULDO"
			name = "Guldo"
			desc =
			{
				"A mercenary in Freeza's 'Ginyu Force,' Guldo is the smallest, and least",
				"powerful of the bunch. Phsycailly, he takes the form of a short, rotund",
				"green alien with four eyes.",
			}
			color = color.GREEN
			level = 40 rarity = 100
			life = {35,35} ac = 150
			exp   = 100000
			speed = 50 
			aaf = 10
			weight = 1700
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				RESIST=getter.resists{CRUSH=20 SLASH=20 PIERCE=20 }
				DBT_REFLECT=30
				MALE=true
				HAS_LITE=true
				-- FACTION=FACTION_FREEZA
				EVIL=true
				GOTO_HELL=true
				--DBTCHAT=function(name)
				--	dialogue.BURTUR()
				--end
			}
		}
		[6] =
		{
			define_as = "RACE_GEICE"
			name = "Geice"
			desc =
			{
				"A mercenary in Freeza's 'Ginyu Force,' Geice is an extremely flamboyant",
				"alien with red skin and silky white hair that he obviously spends a great",
				"deal of time grooming.",
			}
			color = color.LIGHT_RED
			level = 45 rarity = 100
			life = {40,40} ac = 150
			exp   = 100000
			speed = 20 
			aaf = 10
			weight = 1700
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				RESIST=getter.resists{CRUSH=20 SLASH=20 PIERCE=20 }
				DBT_REFLECT=50
				MALE=true
				HAS_LITE=true
				-- FACTION=FACTION_FREEZA
				EVIL=true
				GOTO_HELL=true
				--DBTCHAT=function(name)
				--	dialogue.BURTUR()
				--end
			}
		}
		[7] =
		{
			define_as = "RACE_RECOOME"
			name = "Recoome"
			desc =
			{
				"A mercenary in the 'Ginyu Force,' Recoome is a large, tall, human-looking",
				"alien with bright red hair. Despite his strength, he has a deceptively goofy",
				"manner about him, as well as a tendancy to strike dramatic poses before and",
				"after his attacks.",
			}
			color = color.LIGHT_BLUE
			level = 45 rarity = 100
			life = {40,40} ac = 150
			exp   = 100000
			speed = 20 
			aaf = 10
			weight = 1700
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				RESIST=getter.resists{CRUSH=20 SLASH=20 PIERCE=20 }
				DBT_REFLECT=30
				MALE=true
				HAS_LITE=true
				-- FACTION=FACTION_FREEZA
				EVIL=true
				GOTO_HELL=true
				--DBTCHAT=function(name)
				--	dialogue.RECOOME()
				--end
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
				DROP_CORPSE=true 
				AI=ai.DBT_ZOMBIE
				FORCE_MAXHP=true
				UNIQUE=true
				REGENERATE=200
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_SNUGGLES"
			name = "Snuggles, the 9 headed hydra"
			desc =
			{
				"Oolong's pet hydra, Snuggles is a massive two-ton beast with nine heads, with",
				"slavering jaws, sharp pointed teeth...and a bright red bow tied on each head.",
			}
			color = color.GREEN
			level = 25 rarity = 100
			life = {20,20} ac = 70
			exp   = 3000
			speed = 10 
			aaf = 10
			weight = 40000
			blows =
			{
				{"BITE","PIERCE",{1,4}},
				{"BITE","PIERCE",{1,4}},
				{"BITE","PIERCE",{1,4}},
				{"BITE","PIERCE",{1,4}},
				{"BITE","PIERCE",{1,4}},
				{"BITE","PIERCE",{1,4}},
				{"BITE","PIERCE",{1,4}},
				{"BITE","PIERCE",{1,4}},
				{"BITE","PIERCE",{1,4}},
			}
			flags =
			{
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_TREASURE=100 }
				MALE=true
				SPECIAL_GENE=true
				CAN_SPEAK=function(name) monster_random_say{
					name.." drools causticly",
					name.." roars!",
					name.." stomps mightily",
					name.." pines for love and attention",
				}end
				DBTCHAT=function(name) message("Snuggles looks at you...sniffs you...and decides you look tasty.") end
			}
		}
		[2] =
		{
			define_as = "RACE_GIRAN"
			name = "Giran"
			desc =
			{
				"A massively built bipedal pterodactyl complete with wings. As huge as he is",
				"it is difficult for you to imagine how he could possibly fly, but he seems",
				"capable.",
			}
			color = color.GREEN
			level = 29 rarity = 60
			life = {30,30} ac = 100
			exp   = 4000
			speed = 7
			aaf = 10
			weight = 7000
			blows =
			{
				{"PUNCH","CRUSH",{1,40}},
			}
			spells =
			{
				frequency = 4
				["TailWhip"] = { level=4 chance=100 }
				["Throw"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				-- He resigned his match. Maybe we should allow fear?
				NO_FEAR=true
				CAN_FLY=3 
				MALE=true
				RESIST=getter.resists{FEAR=100}
			}
		}
	}
}

new_monster_races
{
	['B'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true 
				AI=ai.DBT_ZOMBIE
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				UNIQUE=true FORCE_MAXHP=true
				REGENERATE=500
			}
		} -- defaults

		[1] =
		{
			-- define_as = "RACE_CELL"
			name = "Cell"
			desc =
			{
				"A massive bright green humanoid mutant with antler-like protrusions from his",
				"head and a spiked tail, Cell claims to be the most perfect being ever created.",
				"Or, at the very least, that he has the potential to be, if he can only absorb",
				"the energy and DNA of the most powerful of those around him. Unfortunately his",
				"claim might have merit to it. Also unfortuantely...he seems to think that you",
				"are worth absorbing to increase his own power.",
			}
			color = color.LIGHT_GREEN
			level = 100 rarity = 100
			life = {100,100} ac = 500
			exp   = 1000000
			speed = 40
			aaf = 10
			weight = 4000
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				DBT_REFLECT=90
				NO_FEAR=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=80 ELEC=80 COLD=80 CRUSH=40 SLASH=40 PIERCE=40 }
				MALE=true
				SPECIAL_GENE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				CAN_SPEAK=function(name)
						monster_random_say{
						name.." says 'I don't want to embarass you. Please stop fighting and let me absorb you.'",
						name.." says 'It doesn't have to be like this.'",
						name.." says 'Don't you understand? I want only to perfect myself.'",}
				end
			}
		}
	}
}


-- Really tough to classify...so I'm assigning a new letter
-- for Piccolo/Demon King Piccolo. Of course, now that we have
-- 'Namekians' that makes Kami a bit off, since he's a Nammekian
-- also, but I figure Godhood overides species, right?
new_monster_races
{
	['N'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true 
				AI=ai.DBT_ZOMBIE
				FORCE_MAXHP=true UNIQUE=true
				SPECIAL_GENE=true
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_DEMON_KING_PICCOLO"
			name = "Demon King Piccolo"
			desc =
			{
				"A sinister looking creature with green skin and antennea, yet generally humanoid.",
				"Demon King Piccolo has been released from his captivity, and is quite pleased about it.",
			}
			color = color.GREEN
			level = 40 rarity = 100
			life = {40,40} ac = 200
			exp   = 30000
			speed = 20 
			aaf = 10
			weight = 16000
			blows =
			{
				{"PUNCH","DEMON_PICCOLO",{7,7}},
				{"PUNCH","DEMON_PICCOLO",{7,7}},
			}
			flags =
			{
				DBT_REFLECT=50
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_TREASURE=100 }
				MALE=true
				HAS_LITE=true
				MORTAL=true
				DBTCHAT=function(name)
					dialogue.DEMON_KING_PICCOLO()
				end
				ON_DEATH = function(monst)
					if dball_data.piccolo_state == 1 then
						dball_data.piccolo_state = 2
					end
					-- Killing Piccolo also kills Kami
					race_info_idx(RACE_KAMI, 0).max_num = 0
				end
			}
		}
		[2] =
		{
			define_as = "RACE_PICCOLO"
			name = "Piccolo"
			desc =
			{
				"Spawn of Piccolo the Demon King, and bearing the same name, this Piccolo is younger and stronger",
				"than the original. But what of his disposition? Is he just as evil, as well?",
			}
			color = color.LIGHT_GREEN
			level = 60 rarity = 100
			life = {50,50} ac = 200
			exp   = 60000
			speed = 20 
			aaf = 10
			weight = 18000
			blows =
			{
				{"PUNCH","CRUSH",{8,8}},
				{"PUNCH","CRUSH",{8,8}},
			}
			flags =
			{
				DBT_REFLECT=60
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_TREASURE=100 }
				MALE=true
				HAS_LITE=true
				MORTAL=true
				DBTCHAT=function(name)
					dialogue.PICCOLO()
				end
			}
		}
	}
}

new_monster_races
{
	['m'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true TAKE_ITEM=true OPEN_DOOR=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				UNIQUE=true FORCE_MAXHP=true
				REGENERATE=200
			}
		} -- defaults


		[1] =
		{
			define_as = "RACE_PUAR"
			name = "Puar"
			desc =
			{
				"An adorable little cat-like creature, Puar is Yamcha's ever loyal friend and companion.",
			}
			color = color.LIGHT_BLUE
			level = 7 rarity = 999
			life = {10,10} ac = 100
			exp   = 400
			speed = 11 
			aaf = 20
			weight = 1800
			blows =
			{
				{"TOUCH","EAT_ITEM",{0,0}},
			}
			flags =
			{
				AI=ai.PUAR
				DBT_AI_STATE = 0	-- Does Puar use this?
				DROP_THEME = getter.flags{ THEME_GOLD=100 }
				MALE=true
				HAS_LITE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
				end
				DBTCHAT=function(name)
					-- dialogue.PUAR()
				end
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
			sleep  = 0
			body = default_body.insect
			flags = {
				ANIMAL=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			define_as = "RACE_GREGORY"
			name = "Gregory"
			desc =
			{
				"A small green insect of some sort, Gregory is a friend of the North Kaio.",
			}
			color = color.GREEN
			level = 35 rarity = 100
			life = {10,50} ac = 200
			exp   = 5000
			speed = 50 
			aaf = 10
			weight = 600
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_RUN_AWAY
				MALE=true
				FACTION=FACTION_KAMI
				ALLOW_ON_KAIO_WORLD=true
				GOOD=true
				GREGORY=true
				DBTCHAT=function(name)
					dialogue.GREGORY()
				end
			}
		}
	}
}