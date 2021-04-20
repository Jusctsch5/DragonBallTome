-- Dragonball T: Uniques who train skills

-- Master Rosshi, the Turtle Hermit, teaches combatative and Chi arts.
-- He may be found on his island to the southwest of the World Tournament
new_monster_races
{
	['p'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags = 
			{
				DROP_THEME = getter.flags { THEME_NINJA=50 THEME_MARTIAL=50 }
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_ROSSHI"
			name = "Master Rosshi"
			desc =
			{
				"Describe this guy again.",
			}
			color = color.WHITE
			level = 40 rarity = 999
			life = {30,30} ac = 150
			exp   = 5000
			speed = 20 
			aaf = 10 sleep = 0
			weight = 1800
			spells =
			{
				frequency = 4
				["Chi Burst"] = { level=40 chance=100 }
			}
			blows =
			{
				{"CRUSH","CRUSH",{1,60}},
			}
			flags =
			{
				AI=ai.ROSSHI
				DBT_REFLECT=20
				DBT_DEFLECT=60
				NO_FEAR=true
				DROP_DRAGONBALL=100
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				RESIST=getter.resists{CONFUSION=100 FEAR=100}
				MALE=true
				FACTION=FACTION_GOOD
				GOOD=true
				GOTO_HEAVEN=true
				MORTAL=true
				DBTCHAT=function(name)
					dialogue.ROSSHI()
				end
				ON_DEATH = function(monst)
					-- Crane Hermit quest and enrollment handlers
					trainer[FLAG_ENROLL_CRANE_HERMIT] = 1
					if quest(QUEST_CHI_CRANE).status == QUEST_STATUS_TAKEN then
						change_quest_status(QUEST_CHI_CRANE, QUEST_STATUS_FINISHED)
					end
					-- Rosshi's artifacts
					if (a_info(ART_NYOIBO).cur_num < 1) then
						if (dball_data.tourny_now == 0) then
							local obj = create_artifact(ART_NYOIBO)
							drop_near(obj, -1, monst.fy, monst.fx)
						end
						local obj = create_artifact(ART_ROSSHI_SHELL)
						drop_near(obj, -1, monst.fy, monst.fx)
					end
				end
				FUSION_GAIN=function()
					player.stat_add[A_STR] = player.stat_add[A_STR] + 20
					player.stat_add[A_CON] = player.stat_add[A_CON] + 20
					player.stat_add[A_CHR] = player.stat_add[A_CHR] - 10
					dball.fusion_gain(AB_CHI_BURST)
				end
				FUSION_LOSE=function()
					dball.fusion_lose(AB_CHI_BURST)
				end
			}
		}
	}
}

-- Splinter is a kindly mutant rat ninja. He teaches the ninja arts.
-- He may be found in his home in the Sewers
new_monster_races
{
	['p'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags = 
			{
				DROP_THEME = getter.flags { THEME_NINJA=50 THEME_MARTIAL=50 }
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_SPLINTER"
			name = "Splinter"
			level = 25 rarity = 100
			desc = {
				"Describe me",
			}
			color = color.UMBER
			speed = 10 life = {10,10} ac = 50
			aaf = 10 sleep = 10
			exp = 2000
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{5,20}},
				{"HIT","CRUSH",{5,20}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=10
				DBT_DEFLECT=30
				NO_FEAR=true
				FACTION=FACTION_TURTLES
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH = function(monst)
				end
				DBTCHAT=function(name)
					dialogue.SPLINTER()
				end
			}
		}
	}
}

-- Oroku Saki is an evil Ninja Master. He teaches the art of invisibility.
-- He may be found in the Inner Sanctum of the Foot Lair
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=500
			}
		}
		[1] =
		{
			define_as = "RACE_SHREDDER"
			name = "Oroku Saki, the Shredder"
			level = 35 rarity = 100
			desc = {
				"Describe me",
			}
			color = color.RED
			speed = 20 life = {20,20} ac = 80
			aaf = 10 sleep = 10
			exp = 2000
			weight = 1500
			blows =
			{
				{"HIT","SLASH",{4,8}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=0
				DBT_DEFLECT=40
				-- DBT_AI = ai.SHREDDER
				FACTION=FACTION_FOOT
				MALE=true
				EVIL=true
				GOTO_HELL=true
				ON_DEATH = function(monst)
					local obj = create_artifact(ART_SHREDDER_CLAW)
					drop_near(obj, -1, monst.fy, monst.fx)
					if quest(QUEST_DESTROY_THE_FOOT).status == QUEST_STATUS_TAKEN then
						change_quest_status(QUEST_DESTROY_THE_FOOT, QUEST_STATUS_COMPLETED)
					end
					if quest(QUEST_KILL_SHREDDER).status == QUEST_STATUS_TAKEN then
						change_quest_status(QUEST_KILL_SHREDDER, QUEST_STATUS_COMPLETED)
					end
					if quest(QUEST_BEING_WATCHED).status == QUEST_STATUS_TAKEN then
						quest(QUEST_BEING_WATCHED).status = QUEST_STATUS_FINISHED
					end
					if quest(QUEST_KILL_SHREDDER_FOR_HATSUMI).status == QUEST_STATUS_TAKEN then
						quest(QUEST_KILL_SHREDDER_FOR_HATSUMI).status = QUEST_STATUS_FINISHED
					end
				end
				DBTCHAT=function(name)
					dialogue.SHREDDER()
				end
			}
		}
	}
}

-- Miyamoto Musashi teaches Kendo to advanced practitioners.
-- He may be found in his meditative retreat near the lion dens of earth
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_MUSASHI"
			name = "Miyamoto Musashi"
			level = 50 rarity = 999
			desc = {
				"Generally regaled as Japans greatest swordman of all time, Musashi really",
				"deserves to have a better description than this.",
			}
			color = color.RED
			speed = 40 life = {50,50} ac = 200
			aaf = 10 sleep = 0
			exp = 100000
			weight = 1400
			blows =
			{
				{"HIT","SLASH",{2,80}},
				{"HIT","SLASH",{4,30}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=10
				DBT_DEFLECT=40
				NO_FEAR=true
				FACTION=FACTION_NEUTRAL
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					dialogue.MUSASHI()				
				end
				ON_DEATH = function(monst)
					local obj = create_object(TV_SWORDARM, SV_KATANA)
					drop_near(obj, -1, monst.fy, monst.fx)
					local obj = create_object(TV_SWORDARM, SV_WAKAZASHI)
					drop_near(obj, -1, monst.fy, monst.fx)
				end
			}
		}
	}
}

-- The Crane Hermit teaches the graceful fighting arts of the Crane
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_CRANE_HERMIT"
			name = "Tsuru Sen'nin"
			desc =
			{
				"Rosshi's Rival. Describe me.",
			}
			color = color.VIOLET
			level = 40 rarity = 999
			life = {30,30} ac = 150
			exp   = 5000
			speed = 20 
			aaf = 10 sleep = 0
			weight = 1800
			blows =
			{
				{"CRUSH","CRUSH",{1,60}},
			}
			spells =
			{
				frequency = 8
				["Throw"] = { level=8 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				DBT_REFLECT=30
				DBT_DEFLECT=50
				DROP_DRAGONBALL=100
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				RESIST=getter.resists{CONFUSION=100 FEAR=100}
				MALE=true
				CAN_FLY=30 
				FACTION=FACTION_GOOD
				GOOD=true
				GOTO_HEAVEN=true
				MORTAL=true
				DBTCHAT=function(name)
					dialogue.CRANE_HERMIT()
				end
			}
		}
	}
}

-- Krillan is a nice Buddhist, and teaches basic barehand and Chi arts
-- He may be found in Orinji Temple
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_KRILLAN"
			name = "Krillan"
			desc =
			{
				"Describe me!",
			}
			level = 20 rarity = 999
			speed = 20 sleep  = 0
			exp   = 1000
			color = color.ORANGE
			life = {20,20} ac = 100
			aaf = 10 sleep = 0
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,10}},
			}
			flags =
			{
				AI=ai.PARTY
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=20
				DBT_DEFLECT=20
				NO_FEAR=true
				HAS_LITE=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100}
				FACTION=FACTION_KAMI
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_PARTIED=false
				PARTY_ACTS=function()
					local foo = { FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_FIGHT, FLAG_PARTY_ACT_PELT, FLAG_PARTY_ACT_AVOID }
					return foo
				end
				PARTY_CONDITION=function()
					return true
				end
				CAN_SPEAK=function(name) monster_random_say{
					name.." chants softly.",
					name.." chants softly.",
					name.." chants softly.",
					name.." chants softly.",
					name.." chants softly.",
					name.." says 'This meditating stuff is hard!",
					name.." pouts 'I'd really rather have a girlfriend than be a monk.'",
				}end
				DBTCHAT=function(name)
					dialogue.KRILLAN()
				end
				FUSION_GAIN=function()
					player.stat_add[A_STR] = player.stat_add[A_STR] + 5
					player.stat_add[A_CON] = player.stat_add[A_CON] + 5
					dball.fusion_gain(AB_MEDITATION)
				end
				FUSION_LOSE=function()
					dball.fusion_lose(AB_MEDITATION)
				end
			}
		}
	}
}
-- Uranai Baba is Rosshi's sister, and will probably teach something eventually
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_URANAI_BABA"
			name = "Uranai Baba"
			desc =
			{
				"Wearing a black dress over her body as if it were a tent, and wearing a pointy",
				"hat, this aging woman looks very much like she's dressed as a Halloween witch.",
				"You get the impression that it's not a costume, though.",
			}
			color = color.LIGHT_DARK
			level = 27 rarity = 999
			life = {20,20} ac = 50
			exp   = 4000
			speed = 17
			aaf = 10 sleep = 0
			weight = 1550
			spells =
			{
				frequency = 1
				["SummonSnakes"] = { level=15 chance=100 }
			}
			blows = {}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				DROP_THEME=getter.flags{ THEME_FOOD=100 }
				-- DROP_NUMBER=getter.random(2,2)
				FEMALE=true
				HAS_LITE=true
				FACTION=FACTION_GOOD
				GOTO_HEAVEN=true
				RESIST=getter.resists{ FEAR=100 COLD=50 FIRE=50 ELEC=50 }
				DBTCHAT=function(name) 
					dialogue.URANAI_BABA()
				end
				ON_DEATH = function(monst)
					local obj = create_artifact(ART_URANAI_BALL)
					drop_near(obj, -1, monst.fy, monst.fx)
				end
				FUSION_GAIN=function()
					player.stat_add[A_STR] = player.stat_add[A_STR] - 5
					player.stat_add[A_CON] = player.stat_add[A_CON] - 5
					player.stat_add[A_CHR] = player.stat_add[A_CHR] - 10
					player.stat_add[A_INT] = player.stat_add[A_INT] + 10
					player.stat_add[A_WIL] = player.stat_add[A_WIL] + 10
					-- Implement auto id!
				end
				FUSION_LOSE=function()
				end
			}
		}
	}
}
-- Yajirobe is a kendo practitioner who likes to eat. He teaches weapons fighting arts
-- He may be found in the mountains...somewhere.
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_YAJIROBE"
			name = "Yajirobe"
			desc =
			{
				"This overweight, bearded man, is dressed in what appears to be fuedal samurai",
				"furs. He looks mostly harmless, but the fact that he is wearing his katana",
				"with the bladed curve facing upwards tells you that he is no stranger to a",
				"sword. The well rounded curve of his belly tells you that he is no stranger",
				"to a hearty meal, either.",
			}
			color = color.UMBER
			level = 27 rarity = 999
			life = {20,30} ac = 120
			exp   = 4000
			speed = 20 
			aaf = 10 sleep = 0
			weight = 1700
			blows =
			{
				{"HIT","SLASH",{1,60}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DROP_THEME=getter.flags{ THEME_FOOD=100 }
				DROP_NUMBER=getter.random(2,2)
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				FACTION=FACTION_NEUTRAL
				RESIST=getter.resists{ FEAR=100 COLD=50 }
				DBTCHAT=function(name) 
					dialogue.YAJIROBE()
				end
				ON_DEATH = function(monst)
				end
			}
		}
	}
}

-- Dr Briefs is the founder of Capsule Corporation, and teaches a variety of Technical skill
-- He may be found in his laboratory near Capsule Corp headquarters
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_BRIEFS"
			name = "Dr. Briefs"
			desc =
			{
				"The genius and founder behind Capsule Corporation, Dr. Briefs is personally",
				"responsible for inventing a significant percentage of the worlds most advanced",
				"technology. If you were to ask him, though, he'd tell you that he's just doing",
				"what he loves.",
			}
			color = color.ANTIQUE_WHITE
			level = 12 rarity = 999
			life = {7,7} ac = 50
			exp   = 1000
			speed = 10 
			aaf = 10 sleep = 0
			weight = 1550
			flags =
			{
				AI=ai.BRIEFS
				DBT_AI=ai.DBT_RUN_AWAY
				DROP_THEME=getter.flags{ THEME_TECHNO=100 }
				DROP_NUMBER=getter.random(2,2)
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				FACTION=FACTION_GOOD
				DBTCHAT=function(name) 
					dialogue.BRIEFS()
				end
				ON_DEATH = function(monst)
					if quest(QUEST_BRIEFS_FIND_BURUMA).status == QUEST_STATUS_TAKEN then
						quest(QUEST_BRIEFS_FIND_BURUMA).status = QUEST_STATUS_FAILED
					end
				end
			}
		}
	}
}

-- Karin teaches...?
-- He may be found in his tower beneath Kami's Lookout
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_KARIN"
			name = "Karin"
			desc =
			{
				"The Master of the tower, Korin takes the form of a bipedal cat about two feet tall.",
			}
			color = color.WHITE
			level = 35 rarity = 100
			life = {40,40} ac = 150
			exp   = 5000
			speed = 30 
			aaf = 10 sleep = 0
			weight = 450
			blows =
			{
				{"CLAW","SLASH",{6,6}},
				{"CLAW","SLASH",{6,6}},
				{"BITE","PIERCE",{6,6}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=80
				DBT_DEFLECT=90
				NO_FEAR=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 }
				MALE=true
				FACTION=FACTION_KAMI
				GOOD=true
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					dialogue.KARIN()
				end
				CAN_SPEAK=function(name) monster_random_say{
					name.." purrs.",
					name.." finds a speck of dust and licks his fur clean.",
					name.." blinks at you.",
					}
				end
			}
		}	}
}

-- Mr. Popo is the Djinn who tends the Gardens on the North Kaio's Planet. He teaches a few fighting skills.
-- He may be found on the North Kaio's planet.
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_MR_POPO"
			name = "Mr Popo"
			desc =
			{
				"A large djinn with black skin wearing a turbin, Mr Popo's primary task is to",
				"tend the gardens on the North Kaio's planet. He also happens to be a tremendously",
				"powerful martial artist. But, who isn't at this point in the game?",
			}
			color = color.SLATE
			level = 50 rarity = 100
			life = {50,50} ac = 200
			exp   = 15000
			speed = 20 
			aaf = 10 sleep = 0
			weight = 3200
			spells =
			{
				frequency = 4
				["Chi Burst"] = { level=40 chance=100 }
			}
			blows =
			{
				{"CRUSH","CRUSH",{10,15}},
			}
			flags =
			{
				AI=ai.POPO
				DBT_REFLECT=80
				DBT_DEFLECT=90
				NO_FEAR=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=80 COLD=80 }
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				MALE=true
				FACTION=FACTION_KAMI
				ALLOW_ON_KAIO_WORLD=true
				GOOD=true
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					dialogue.POPO()
				end
			}
		}
	}
}

-- OverGod of the Northern portion of our Galaxy, the North Kaio teaches just about everything
-- He may be found on his planet.
new_monster_races
{
	['K'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags = 
			{
				DROP_THEME = getter.flags { THEME_MARTIAL=100 }
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=1000
			}
		}
		[1] =
		{
			define_as = "RACE_NORTH_KAIO"
			name = "The North Kaio"
			desc =
			{
				"Overgod of the northern quadrant of our galaxy, the North Kaio appears as a",
				"bright blue, fat, mustacheod humanoid in sunglasses and Chinese clothing. He is",
				"friendly, cheerful...and as powerful as you would expect an Overgod to be.",
			}
			color = color.LIGHT_BLUE
			level = 70 rarity = 999
			life = {100,100} ac = 300
			exp   = 50000
			speed = 30 
			aaf = 10 sleep = 0
			weight = 4500
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=100
				DBT_DEFLECT=200
				NO_FEAR=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=80 COLD=80 }
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				MALE=true
				FACTION=FACTION_KAMI
				ALLOW_ON_KAIO_WORLD=true
				GOOD=true
				TAUNT=1
				DBTCHAT=function(name)
					dialogue.KAIO()
				end
			}
		}
	}
}

-- Radditz is the weakest of the four (?) remaining Saiyan
-- He may teach mid-range fighting and Chi is the player
-- becomes prematurely stranded on Planet 79
new_monster_races
{
	['S'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				UNIQUE=true FORCE_MAXHP=true
				DROP_THEME = getter.flags { THEME_MARTIAL=100 }
				REGENERATE=500
			}
		}
		[1] =
		{
			define_as = "RACE_RADDITZ"
			name = "Radditz"
			desc =
			{
				"A tall, and powerful looking Saiyan...one of the few, scattered survivors of the",
				"destruction of the planet Plant. Radditz is in the business of exterminating the",
				"native population of entire worlds so that they may be sold at auction. To be",
				"perfectly blunt, though, he obviously isn't the brains in charge of his operation.",
				"That begs the question, of course...who is?",
			}
			color = color.YELLOW
			level = 50 rarity = 100
			life = {40,40} ac = 200
			exp   = 100000
			speed = 20
			aaf = 10 sleep = 0
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{8,8}},
				{"PUNCH","CRUSH",{8,8}},
			}
			spells =
			{
				--frequency = 4
				--["Chi Burst"] = { level=40 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=80
				DBT_DEFLECT=100
				RESIST=getter.resists{CONFUSION=100}
				MALE=true
				CAN_FLY=30 
				EVIL=true
				GOTO_HELL=true
				FACTION=FACTION_BAD
				DBTCHAT=function(name)
					-- Hack?
					if dball.am_i_on_earth() then
						dialogue.RADDITZ_EARTH()
					else
						dialogue.RADDITZ_79()
					end
				end
				ON_DEATH = function(monst)
					local obj = create_object(TV_BODY_ARMOUR, SV_POWER_ARMOR)
					drop_near(obj, -1, monst.fy, monst.fx)
				end
			}
		}
	}
}

-- Vegita...hmm. Pending.
new_monster_races
{
	['S'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				UNIQUE=true FORCE_MAXHP=true
				DROP_THEME = getter.flags { THEME_MARTIAL=100 }
				REGENERATE=1000
			}
		}
		[1] =
		{
			define_as = "RACE_VEGITA"
			name = "Vegita"
			desc =
			{
				"Though short, and wirey, Vegita is extraordinarily powerful. He also claims to be the sole",
				"surviving member of the high ruling class of the former planet Plant, the 'Prince' of the",
				"Seiyan, and therefore is destined to become the next incarnation of the Legendary Seiyan, a",
				"super-powerful being who has not appeared in 3000 years.",
			}
			color = color.LIGHT_BLUE
			level = 60 rarity = 100
			life = {50,50} ac = 250
			exp   = 100000
			speed = 20
			aaf = 10 sleep = 0
			weight = 1500
			blows =
			{
				{"PUNCH","CRUSH",{12,12}},
				{"PUNCH","CRUSH",{12,12}},
			}
			spells =
			{
				--frequency = 4
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				DBT_REFLECT=120
				DBT_DEFLECT=140
				RESIST=getter.resists{CONFUSION=100 FEAR=100}
				MALE=true
				CAN_FLY=30 
				GOTO_HEAVEN=true
				FACTION=FACTION_BAD
				DBTCHAT=function(name)
					if dball.am_i_on_earth() then
						dialogue.VEGITA_EARTH()
					else
						dialogue.VEGITA_79()
					end
				end
				ON_DEATH = function(monst)
					local obj = create_object(TV_BODY_ARMOUR, SV_POWER_ARMOR)
					drop_near(obj, -1, monst.fy, monst.fx)
				end
			}
		}
	}
}

-- Trunks may teach weapon abilities if the player prematurely trips the Android quests
-- Once available, he may be found in Dr Briefs' Lab
new_monster_races
{
	['S'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				UNIQUE=true FORCE_MAXHP=true
				DROP_THEME = getter.flags { THEME_PLAIN=100 }
				REGENERATE=1000
			}
		}
		[1] =
		{
			define_as = "RACE_TRUNKS"
			name = "Trunks"
			desc =
			{
				"A boy of about fifteen, with platinum blonde hair, and wearing a massive",
				"sword on his back.",
			}
			color = color.LIGHT_BLUE
			level = 35 rarity = 999
			life = {30,30} ac = 120
			exp   = 6500
			speed = 20 
			aaf = 10 sleep = 0
			weight = 1500
			spells =
			{
				frequency = 6
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
				{"HIT","SLASH",{20,20}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				DBT_REFLECT=100
				DBT_DEFLECT=120
				NO_FEAR=true
				CAN_FLY=30 
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				FACTION=FACTION_GOOD
				DBTCHAT=function(name)
					dialogue.TRUNKS()
				end
				ON_DEATH = function(monst)
					-- No more hunting
					dball_data.trunks_hunt = 0
				end
			}
		}
	}
}


-- The head instructors of the primary schools:
-- Karate		Nakamura
-- Kickboxing	Bob
-- Kungfu		Fong-Sai Yuk
-- Fencing		Jacque
-- Sumo		Honda
-- Yawara		Judo
-- Ballet		???Add Elizabeth???
-- Marksmanship	Charleton
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
				UNIQUE=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true
				REGENERATE=200
			}
		}
		[1] =
		{
			define_as = "RACE_NAKAMURA"
			name = "Nakamura Sensei"
			desc =
			{
				"Instructor Nakamura owns and runs the local Karate Dojo. He is a quiet man, dressed",
				"in a plain white gi with a heavily frayed black belt. He looks at you calmly as he",
				"approaches.",
			}
			color = color.VIOLET
			level = 20 rarity = 999
			life = {20,20} ac = 80
			exp   = 3000
			speed = 13 
			aaf = 10 sleep = 0
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{3,8}},
			}
			spells =
			{
				frequency = 12
				["Throw"] = { level=3 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_THROWER
				DBT_REFLECT=50
				DBT_DEFLECT=50
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_JAPANESE=100 }
				DROP_NUMBER=getter.random(1,2) DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				MALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				MORTAL=true
				SPECIAL_GENE=true
				ON_DEATH = function(monst)
				end
			}
		}
		[2] =
		{
			define_as = "RACE_FONG_SAI_YUK"
			name = "Fong Sai Yuk"
			desc =
			{
				"Fong-Sai Yuk is the head instructor at the local Kung-fu school. He is dressed in",
				"casual Chinese clothing, and has a peaceful look on his face.",
			}
			color = color.VIOLET
			level = 20 rarity = 999
			life = {20,20} ac = 80
			exp   = 3000
			speed = 13 
			aaf = 10 sleep = 0
			weight = 1800
			blows =
			{
				{"HIT","SLASH",{3,8}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_REFLECT=50
				DBT_DEFLECT=50
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_CHINESE=100 }
				DROP_NUMBER=getter.random(1,2) DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				MALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
				end
			}
		}
		[3] =
		{
			define_as = "RACE_JACQUE"
			name = "Jacque"
			desc =
			{
				"Jacque is the local fencing instructor. He is small, but looks fast.",
			}
			color = color.VIOLET
			level = 20 rarity = 999
			life = {20,20} ac = 100
			exp   = 3000
			speed = 20 
			aaf = 10 sleep = 0
			weight = 1800
			blows =
			{
				{"HIT","CUT",{3,4}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_FRENCH=100 }
				DROP_NUMBER=getter.random(1,2) DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				MALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
				end
			}
		}
		[4] =
		{
			define_as = "RACE_BOB"
			name = "Bob"
			desc =
			{
				"Fast and tough, Bob is always ready for a fight. Fortunately for you he's",
				"wearing a set of very thick gloves. You're still not thrilled about him",
				"hitting you, but at least the blows will be heavily cushioned.",
			}
			color = color.VIOLET
			level = 20 rarity = 999
			life = {20,20} ac = 70
			exp   = 3000
			speed = 23 
			aaf = 10 sleep = 0
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{1,8}},
				{"PUNCH","CRUSH",{1,8}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_PLAIN=100 }
				DROP_NUMBER=1 DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				MALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
				end
			}
		}
		-- TKD is closed, but Master lee may stil appear in the Tournament
		[5] =
		{
			define_as = "RACE_MASTER_LEE"
			name = "Master Lee"
			desc =
			{
				"Head instructor at the Tae Kwon Do school.",
			}
			color = color.VIOLET
			level = 20 rarity = 999
			life = {20,20} ac = 80
			exp   = 3000
			speed = 10 
			aaf = 10 sleep = 0
			weight = 1800
			blows =
			{
				{"KICK","CRUSH",{5,5}},
				{"KICK","CRUSH",{5,5}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				DROP_NUMBER=getter.random(1,2) DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				MALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
				end
			}
		}
		[6] =
		{
			define_as = "RACE_HONDA"
			name = "Honda"
			desc =
			{
				"This huge bememoth of a man is possibly the largest sumo wrestler you've ever",
				"seen. You dread the thought of him grabbing or hitting you. Or even worse, sitting",
				"on you. Fortunately all that weight slows him down a little.",
			}
			color = color.BLUE
			level = 20 rarity = 999
			life = {20,30} ac = 50
			exp   = 3000
			speed = 7
			aaf = 10 sleep = 0
			weight = 4500
			blows =
			{
				-- With freq:1 Melee should never be selected by this ai, right?
				{"CRUSH","CRUSH",{4,8}},
			}
			spells =
			{
				frequency = 1
				["Bearhug"] = { level=7 chance=100 }
				["Throw"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_THROWER
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				DROP_NUMBER=1 DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				MALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
				end
			}
		}
		[7] =
		{
			define_as = "RACE_YAWARA"
			name = "Yawara"
			desc =
			{
				"Small, but fast and determined, Yawara teaches Judo at a local school.",
			}
			color = color.WHITE
			level = 20 rarity = 999
			life = {15,15} ac = 70
			exp   = 3000
			speed = 20 
			aaf = 10 sleep = 0
			weight = 1400
			spells =
			{
				frequency = 3
				["Throw"] = { level=4 chance=100 }
			}
			blows =
			{
				{"CRUSH","CRUSH",{1,8}},
			}
			flags =
			{
				AI=ai.DBT_THROWER
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_MARTIAL=100 }
				DROP_NUMBER=1 DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				FEMALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
				end
			}
		}
		[8] =
		{
			define_as = "RACE_HATSUMI"
			name = "Grandmaster Hatsumi"
			desc =
			{
				"Inheritor of nine Ninjutsu traditions from the late O'Sensei Toshitsugu Takamatsu",
				"in the early 1970's just before Soke Takamatsu's passing in 1972. It is said that",
				"Dr. Hatsumi was the only one receiving indepth training with the great Takamatsu",
				"during the last 15 years of his life.",
			}
			color = color.LIGHT_DARK
			level = 27 rarity = 999
			life = {20,20} ac = 110
			exp   = 7000
			speed = 15 
			aaf = 10 sleep = 0
			weight = 1800
			blows =
			{
				{"CRUSH","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 4
				["Powder"] = { level=4 chance=100 }
				["Shuriken"] = { level=4 chance=100 }
				["Dart"] = { level=4 chance=100 }
				["Throw"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				DBT_REFLECT=120
				DBT_DEFLECT=0
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_NINJA=100 }
				DROP_NUMBER=getter.random(1,2) DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				MALE=true
				INVISIBLE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				MORTAL=true
				ON_DEATH = function(monst)
					-- No WT right?
					c_schools[FLAG_NINJUTSU] = FLAG_SCHOOL_CLOSED
				end
			}
		}
		[9] =
		{
			define_as = "RACE_CHARLETON"
			name = "Charleton"
			desc =
			{
				"Old and grizzled, chuck looks like he means business.",
			}
			color = color.UMBER
			level = 20 rarity = 999
			life = {15,15} ac = 50
			exp   = 3000
			speed = 13 
			aaf = 10 sleep = 0
			weight = 1650
			spells =
			{
				frequency = 1
				["Shoot"] = { level=5 chance=100 }
			}
			blows =
			{
			}
			flags =
			{
				AI=ai.RANDOM_CAST
				NO_FEAR=true
				DROP_THEME = getter.flags{ THEME_RRA=100 }
				DROP_NUMBER=getter.random(1,2) DROP_GREAT=true
				RESIST=getter.resists{FEAR=100}
				FEMALE=true
				GOTO_HEAVEN=true
				FACTION=FACTION_DUNGEON
				ON_DEATH = function(monst)
					c_schools[FLAG_MARKSMANSHIP] = FLAG_SCHOOL_CLOSED
					message(color.YELLOW, "So much for Smith and Wesson.")
				end
			}
		}
	}
}
