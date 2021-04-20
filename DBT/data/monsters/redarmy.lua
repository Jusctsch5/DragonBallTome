-- Dragonball T: The Red Ribbon Army

-- Note that RRA personell cannot open doors. This is to
-- prevent monsters on special levels from opening doors
-- and getting themselves killed before the player trips
-- the special level dialogues
-- Perhaps a better solution would be to use feature blockers?

-- Or custom ai's?

new_monster_races
{
	['p'] =	{
		defaults = {
			body = default_body.humanoid
			flags = {
				DROP_THEME = getter.flags { THEME_RRA=50 THEME_BALLISTICS=40 THEME_BATTERY=10 }
				DROP_CORPSE=true TAKE_ITEM=true
				HAS_LITE=true
				FACTION=FACTION_RRA
				FORCE_MAXHP=true
				RED_RIBBON=15
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_RRA_SNOW_PATROL"
			name = "red ribbon army patrol"
			desc =
			{
				"Dressed in a thick parka adorned with the red ribbon army logo, this poor soul spends his",
				"days wandering through the snow looking for intruders. It seems a very boring job. Fortunately,",
				"now that you're here he'll have something to do.",
			}
			level = 20 rarity = 1
			speed = 3 sleep  = 5
			exp   = 50
			color = color.RED
			life = {10,10} ac = 50
			aaf = 10
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,6}},
			}
			spells =
			{
				frequency = 6
				["Shoot"] = { level=4 chance=100 }
				["Snow Patrol"] = { level=4 chance=100 }
			}
			flags =
			{
				AI=ai.RRA_PATROL
				DBT_AI_STATE=0
				MALE=true
				DROP_90=true
			}
		}
		[2] =
		{
			name = "red ribbon army guard"
			desc =
			{
				"Guard duty may not be as exciting or as exotic as some other Red Army assignments,",
				"but it does have the advantage of being very safe. These two guards are sitting atop",
				"heavily fortified guard towers which grant them an aeriel view of the entire Red Ribbon",
				"Army encampment. From these positions they fire on any who trespass, and provide advance",
				"warning to the tower of potential intruders.",
			}
			level = 25 rarity = 999
			speed = 10 sleep  = 0
			exp   = 100
			color = color.RED
			life = {10,10} ac = 100
			aaf = 10
			weight = 1500
			blows =
			{
			}
			spells =
			{
				frequency = 1
				["Shoot"] = { level=1 chance=100 }
			}
			flags =
			{
				-- Be careful with drops for these guys...they're in the wilderness
				-- and clips aren't allowed at dungeon level zero by THEME_RRA
				AI=ai.DBT_DEFAULT
				MALE=true
				SPECIAL_GENE=true
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
				DROP_THEME = getter.flags { THEME_RRA=50 THEME_BALLISTICS=40 THEME_BATTERY=10 }
				DROP_CORPSE=true TAKE_ITEM=true
				HAS_LITE=true
				MORTAL=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				ALLOW_IN_RRA_SHQ=true
				FACTION=FACTION_RRA
				AI=ai.DBT_DEFAULT
				FORCE_MAXHP=true
				RED_RIBBON=true
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_RRA_PRIVATE"
			name = "red ribbon army private"
			desc =
			{
				"A low ranking grunt of the Red Ribbon Army. He's not very tough. At least he doesn't look it.",
				"He doesn't look very brave either, or he wouldn't have the terrified look on his face. He's not",
				"very strong, or he wouldn't have to struggle to lift that pistol he's carrying. And...he's not",
				"very bright, or he wouldn't have enlisted in the army in the first place.",
			}
			level = 20 rarity = 1
			speed = 3 sleep  = 5
			exp   = 50
			color = color.RED
			life = {10,10} ac = 50
			aaf = 10
			weight = 1500
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
				MALE=true
				DROP_90=true
				RAND_MOVEMENT=25
			}
		}
		[2] =
		{
			define_as = "RACE_RRA_SEARGENT"
			name = "red ribbon army seargent"
			desc =
			{
				"A relatively low ranking enlisted member of the Red Ribbon Army. ",
			}
			level = 22 rarity = 1
			speed = 3 sleep  = 0
			exp   = 70
			color = color.RED
			life = {11,11} ac = 60
			aaf = 10
			weight = 1600
			blows =
			{
				{"HIT","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 5
				["Shoot"] = { level=6 chance=100 }
				["Flashlight"] = { level=10 chance=100 }
			}
			flags =
			{
				MALE=true
				DROP_90=true
				RAND_MOVEMENT=25
			}
		}
		[3] =
		{
			define_as = "RACE_RRA_CORPORAL"
			name = "red ribbon army corporal"
			desc =
			{
				"A moderately ranked member of the Red Ribbon Army. You're still not impressed, but",
				"they do seem to be getting tougher.",
			}
			level = 24 rarity = 1
			speed = 5 sleep  = 0
			exp   = 100
			color = color.RED
			life = {12,12} ac = 70
			aaf = 10
			weight = 1600
			blows =
			{
				{"HIT","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 4
				["Shoot"] = { level=6 chance=100 }
				["Flashlight"] = { level=10 chance=100 }
			}
			flags =
			{
				MALE=true
				DROP_90=true
				RAND_MOVEMENT=25
			}
		}
		[4] =
		{
			define_as = "RACE_RRA_LIETENANT"
			name = "red ribbon army lietenant"
			desc =
			{
				"A non-commissioned officer of the Red Ribbon Army. You notice that not only does his shoes",
				"have laces, they are even tied. That means he's probably a little brighter than most of the",
				"lower ranked Red Ribbon soldiers. He appears to be better armed, as well.",
			}
			level = 26 rarity = 2
			speed = 7 sleep  = 0
			exp   = 300
			color = color.RED
			life = {13,13} ac = 80
			aaf = 10
			weight = 1600
			blows =
			{
				{"HIT","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 4
				["Shoot"] = { level=6 chance=100 }
				["Grenade"] = { level=10 chance=100 }
				["Flashlight"] = { level=10 chance=100 }
			}
			flags =
			{
				DROP_NUMBER=1
				MALE=true
				RAND_MOVEMENT=25
			}
		}
		[5] =
		{
			define_as = "RACE_RRA_CAPTAIN"
			name = "red ribbon army captain"
			desc =
			{
				"A moderately ranked officer of the Red Ribbon Army. An intelligent coward, he",
				"is rarely seen without a troop escort.",
			}
			level = 30 rarity = 4
			speed = 7 sleep  = 0
			exp   = 400
			color = color.RED
			life = {14,14} ac = 90
			aaf = 10
			weight = 1600
			blows =
			{
				{"HIT","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 3
				["Shoot"] = { level=10 chance=100 }
			}
			flags =
			{
				DROP_NUMBER=getter.random(1,2)
				MALE=true
				ESCORTED_BY_GROUPS=true 
			}
		}
		[6] =
		{
			define_as = "RACE_RRA_COMMANDER"
			name = "red ribbon army commander"
			desc =
			{
				"A moderately high officer of the Red Ribbon Army.",
			}
			level = 33 rarity = 5
			speed = 10 sleep  = 0
			exp   = 1000
			color = color.RED
			life = {15,15} ac = 100
			aaf = 10
			weight = 1600
			blows =
			{
				{"HIT","CRUSH",{1,8}},
			}
			spells =
			{
				frequency = 2
				["Shoot"] = { level=15 chance=100 }
			}
			flags =
			{
				DROP_NUMBER=getter.random(1,3)
				MALE=true
				ESCORTED_BY_GROUPS=true
			}
		}
		[7] =
		{
			define_as = "RACE_RRA_SNIPER"
			name = "red ribbon army sniper"
			desc =
			{
				"This special operative of the Red Ribbon Army is small, fast and an expert marksman.",
				"His only weapon is a forty pound, five foot long sniper rifle which propels uranium",
				"slugs which can penetrate even tank armor. They may not be equipped to fight at close",
				"range, but it is rare that they need to.",
			}
			level = 33 rarity = 5
			speed = 10 sleep  = 0
			exp   = 800
			color = color.LIGHT_DARK
			life = {10,10} ac = 50
			aaf = 10
			weight = 1600
			blows =
			{
			}
			spells =
			{
				frequency = 1
				["Shoot"] = { level=20 chance=100 }
			}
			flags =
			{
				DROP_NUMBER=1
				MALE=true
			}
		}
	}
}


-- ***************************************************************
-- Keeping the Uniques Separate, just because I want to. So, nyeh.
-- ***************************************************************


new_monster_races
{
	['p'] =	{
		defaults = {
			body = default_body.humanoid
			flags = {
				DROP_THEME = getter.flags { THEME_RRA=100 }
				UNIQUE=true FORCE_MAXHP=true EVIL=true
				DROP_CORPSE=true TAKE_ITEM=true
				HAS_LITE=true
				MORTAL=true
				EVIL=true
				RED_RIBBON=true
			}
		} -- defaults
		[1] =
		{
			name = "Colonel Violet"
			desc =
			{
				"A thin, but tough woman who gets her namesake from the color of her hair. Colonel Violet",
				"would stop a tank to keep it from running over a puppy dog, but wouldn't think twice",
				"before pushing an RRA soldier out of a helicopter to save weight. It's a little difficult",
				"to know exactly where her loyalties lie. Even for the RRA brass.",
			}
			level = 23 rarity = 5
			speed = 15 sleep  = 0
			exp   = 500
			color = color.VIOLET
			life = {15,15} ac = 75
			aaf = 10
			weight = 1200
			blows =
			{
				{"HIT","CRUSH",{1,10}},
			}
			spells =
			{
				frequency = 4
				["Shoot"] = { level=5 chance=100 }
				["Grenade"] = { level=5 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				FEMALE=true
				GOTO_HELL=true
				DROP_NUMBER=getter.random(1,3) DROP_GOOD=true
				ESCORTED_BY_GROUPS=true 
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_RRA_SHQ=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." shouts 'Kill the intruder!'",
					name.." screams 'Find the Dragonballs!'",
					name.." shouts 'Rule the World! Rule the World!'",
					name.." screeches 'Oh no! I broke a nail!'",}
				end
			}
		}
		[2] =
		{
			name = "Colonel Silver"
			desc =
			{
				"Describe me! All my notes say is that he uses a bazooka. Ok...bazooka it is.",
			}
			level = 23 rarity = 5
			speed = 15 sleep  = 0
			exp   = 700
			color = color.WHITE
			life = {15,15} ac = 60
			aaf = 10
			weight = 1800
			blows =
			{
				{"HIT","CRUSH",{1,20}},
			}
			spells =
			{
				frequency = 4
				["Bazooka"] = { level=5 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				MALE=true
				GOTO_HELL=true
				DROP_NUMBER=getter.random(1,3) DROP_GOOD=true
				ESCORTED_BY_GROUPS=true 
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				ALLOW_IN_RRA_SHQ=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." shouts 'Kill the intruder!'",
					name.." screams 'Find the Dragonballs!'",
					name.." reloads his bazooka.",}
				end
			}
		}
		[3] =
		{
			name = "Lietenant Green"
			desc =
			{
				"Lietenant Green is an extreme stickler for miltary rules, regulations and discipline.",
				"At least, when applied to other people. Himself, he's about 100 pounds overweight.",
				"In battle, he uses a sharp-looking whip, and his primary function in the Red Ribbon",
				"Army is to help General Blue in the Quest to locate the Dragonballs.",
			}
			level = 24 rarity = 5
			speed = 5 sleep  = 0
			exp   = 500
			color = color.GREEN
			life = {15,15} ac = 80
			aaf = 10
			weight = 3000
			blows =
			{
				{"HIT","SLASH",{1,30}},
			}
			spells =
			{
				frequency = 2
				["Shoot"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				ALLOW_IN_EVERYWHERE=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				ALLOW_IN_RRA_SHQ=true
				GOTO_HELL=true
				MALE=true
				ESCORTED_BY_GROUPS=true 
				DROP_NUMBER=getter.random(1,3) DROP_GOOD=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." rummages through his pack for some K-rations.",
					name.." cracks his whip.",
					name.." looks around to see if there are any doughnuts left.",}
				end
			}
		}
		[4] =
		{
			define_as = "RACE_RRA_WHITE"
			name = "General White"
			desc =
			{
				"White is the General officially in command of Muscle Tower, and receives his",
				"orders directly from Commander Red. He doesn't much care for personal combat,",
				"but is an excellent marksman.",
			}
			level = 28 rarity = 999
			speed = 10 sleep  = 0
			exp   = 2500
			color = color.WHITE
			life = {20,20} ac = 100
			aaf = 10
			weight = 2000
			blows =
			{
			}
			spells =
			{
				frequency = 1 -- Freq not used by White's ai
				["Shoot"] = { level=25 chance=100 }
			}
			flags =
			{
				AI=ai.WHITE
				NO_FEAR=true
				MALE=true
				GOTO_HELL=true
				DROP_NUMBER=getter.random(2,2) DROP_GOOD=true
				DROP_DRAGONBALL=100
				DROP_GOOD=true
				DROP_GREAT=true
				ALLOW_IN_MUSCLE_TOWER=true
				CAN_SPEAK=function(name)
					-- Not enabled for White's ai
				end
				ON_DEATH=function(name)
					message(color.YELLOW, "You have defeated General White!") 
				end
			}
		}
		[5] =
		{
			define_as = "RACE_RRA_BLUE"
			name = "General Blue"
			desc =
			{
				"Under direct order from Commander Red, General Blue hunts perpetually for the",
				"missing Dragonballs. Blue is a higly trained fighter, and though he is willing",
				"to put a bullet in anyone when the situation calls for it, he's much rather fight",
				"with his hands. Also, unlike most Red Ribbon Army officers, rather than needlessly",
				"sacrificing his underlings, he prefers doing his own dirty work.",
			}
			level = 36 rarity = 999
			speed = 20 sleep  = 0
			exp   = 6500
			color = color.BLUE
			life = {20,20} ac = 120
			aaf = 10
			weight = 3000
			blows =
			{
				{"PUNCH","CRUSH",{2,20}},
				{"KICK","CRUSH",{3,20}},
			}
			spells =
			{
				frequency = 8
				["Gaze Paralysis"] = { level=15 chance=100 }
			}
			flags =
			{
				AI=ai.BLUE
				NO_FEAR=true
				MALE=true
				GOTO_HELL=true
				DROP_NUMBER=getter.random(2,3)
				DROP_GOOD=true
				DROP_GREAT=true
				ALLOW_IN_BLUE_LAIR=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." reloads his pistol.",}
				end
				ON_DEATH=function(name)
					message(color.YELLOW, "You have defeated General Blue!") 
					dball_data.rra_android8 = 1 -- (Allow Android 8 dialogue)
				end
			}
		}
		[6] =
		{
			define_as = "RACE_RRA_BLACK"
			name = "Adjutant Black"
			desc =
			{
				"The direct, left-hand man of Commander Red, Adjutant Black is very serious about",
				"his business, and eagerly looks forward to the day the Red Ribbon Army locates",
				"the last of the Dragonballs so that they may finally rule the world.",
			}
			level = 40 rarity = 999
			speed = 20 sleep  = 0
			exp   = 10000
			color = color.SLATE
			life = {20,20} ac = 120
			aaf = 10
			weight = 2100
			blows =
			{
			}
			spells =
			{
				frequency = 1
				["Shoot"] = { level=15 chance=100 }
			}
			flags =
			{
				AI=ai.RANDOM_CAST
				NO_FEAR=true
				MALE=true
				GOTO_HELL=true
				DROP_NUMBER=getter.random(2,3)
				DROP_GOOD=true
				DROP_GREAT=true
				ESCORTED_BY_GROUPS=true 
				ALLOW_IN_RRA_SHQ=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." reloads his pistol.",}
				end
				ON_DEATH=function(name)
					message(color.YELLOW, "You have defeated Adjutant Black!") 
				end
			}
		}
		[7] =
		{
			define_as = "RACE_RRA_RED"
			name = "Commander Red"
			desc =
			{
				"The Supreme Commander of the Red Ribbon Army, Commander Red urges his forces",
				"relentlessly onward in their quest to find the dragonballs.",
			}
			level = 42 rarity = 999
			speed = 20 sleep  = 0
			exp   = 10000
			color = color.RED
			life = {25,25} ac = 130
			aaf = 10
			weight = 1800
			blows =
			{
			}
			spells =
			{
				frequency = 1
				["Shoot"] = { level=20 chance=100 }
			}
			flags =
			{
				AI=ai.RANDOM_CAST
				NO_FEAR=true
				MALE=true
				GOTO_HELL=true
				DROP_NUMBER=getter.random(2,3) DROP_GOOD=true
				DROP_DRAGONBALL=100
				DROP_GOOD=true
				DROP_GREAT=true
				ALLOW_IN_RRA_SHQ=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." looks at you with steely eyes. Then looks scared.",
					name.." sighs wistfully and says 'I wish I were taller.'",}
				end
				ON_DEATH=function(name)
					message(color.YELLOW, "You have defeated the Supreme Commander of the Red Ribbon Army!") 
					if quest(QUEST_PILAF_RRA).status == QUEST_STATUS_TAKEN then
						change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_COMPLETED)
					end
					change_quest_status(QUEST_GERO_MASTERMIND, QUEST_STATUS_TAKEN)
				end
			}
		}
	}
}

new_monster_races
{
	['p'] =	{
		defaults = {
			body = default_body.quadruped
			flags = {
				DROP_THEME = getter.flags { THEME_NINJA=100 }
				DROP_CORPSE=true
				MORTAL=true
				ALLOW_IN_MUSCLE_TOWER=true
				RED_RIBBON=true
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_RRA_MURASAKI"
			name = "Seargent Murasaki"
			desc =
			{
				"Master Seargeant Murasaki, the deadly ninja of 1000 techniques. Murasaki",
				"works directly under General White in Muscle Tower. In truth though, he is only moderately",
				"deadly as ninja go. He may know 1000 techniques, but only a couple of them made",
				"it through the module conversion process. Besides, what kind of a ninja wears bright",
				"purple clothes?",
			}
			level = 30 rarity = 1
			speed = 17 sleep  = 0
			exp   = 1750
			color = color.VIOLET
			life = {15,15} ac = 70
			aaf = 10
			weight = 3000
			blows =
			{
				{"HIT","SLASH",{1,8}},
			}
			spells =
			{
				frequency = 10
				["Shuriken"] = { level=6 chance=100 }
				["Powder"] = { level=6 chance=100 }
				["Dart"] = { level=6 chance=100 }
			}
			flags =
			{
				AI=ai.MURASAKI
				MALE=true
				GOTO_HELL=true
				ESCORTED_BY_GROUPS=true 
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				ALLOW_IN_RRA_SHQ=true
				DROP_NUMBER=getter.random(1,3) DROP_GOOD=true
				DROP_GOOD=true
			}
		}
		[2] =
		{
			define_as = "RACE_HASUKI"
			name = "Hasuki, the thief"
			desc =
			{
				"A buxom blonde in a purple jumpsuit, Hasuki is renowed as the most competant thief",
				"in the world. What could she be here to steal, I wonder?",
			}
			level = 24 rarity = 1
			speed = 10 sleep  = 0
			exp   = 700
			color = color.YELLOW
			life = {10,10} ac = 70
			aaf = 10
			weight = 3000
			blows =
			{
				{"HIT","EAT_ITEM",{1,4}},
				{"HIT","EAT_DRAGONBALL",{1,4}},
			}
			spells =
			{
				frequency = 10
				["Powder"] = { level=6 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				ALLOW_IN_EVERYWHERE=true
				ALLOW_IN_URANAI=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				ALLOW_IN_RRA_SHQ=true
				ALLOW_IN_EARTH_DEADLY=true
				ALLOW_IN_SATAN_ESTATE=true
				DROP_DRAGONBALL=50
				FEMALE=true
				GOTO_HELL=true
				DROP_NUMBER=getter.random(2,2) DROP_GOOD=true
				CAN_SPEAK=function(name)
					monster_random_say
					{
						name.." whispers to herself",
						name.." eyes your back with interest.",
					}
				end
			}
		}
		[3] =
		{
			define_as = "RACE_TAO_PAI_PAI"
			name = "Tao Pai Pai"
			desc =
			{
				"A member of the Crane school, Tao Pai Pai is regarded by many as the world's most",
				"skillfull assassin. He is quiet, vain, and extremely powerful.",
			}
			level = 33 rarity = 1
			speed = 17 sleep  = 0
			exp   = 4000
			color = color.PINK
			life = {25,25} ac = 70
			aaf = 10
			weight = 1650
			blows =
			{
				{"HIT","SLASH",{6,3}},
				{"HIT","SLASH",{6,3}},
			}
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
				["Throw"] = { level=8 chance=100 }
				["Dart"] = { level=12 chance=100 }
				["Powder"] = { level=10 chance=100 }
				["Grenade"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.TAOPAIPAI
				MALE=true
				GOTO_HELL=true
				-- DROP_NUMBER=getter.random(2,2)
				DROP_GOOD=true
				ALLOW_IN_TOURNAMENT=true
				ALLOW_IN_EVERYWHERE=true
				ALLOW_IN_URANAI=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				ALLOW_IN_RRA_SHQ=true
				ALLOW_IN_EARTH_DEADLY=true
				ALLOW_IN_SATAN_ESTATE=true
				ON_DEATH = function(monst)
					if dball.current_location() ~= "World Tournament" then
						local obj = create_object(TV_SWORDARM, SV_STRAIGHTSWORD)
						drop_near(obj, -1, monst.fy, monst.fx)
						local obj = create_object(TV_SWORDARM, SV_STRAIGHTSWORD)
						drop_near(obj, -1, monst.fy, monst.fx)
					end
				end
			}
		}
	}
}

new_monster_races
{
	['f'] =	{
		defaults = {
			body = default_body.quadruped
			flags = {
				DROP_THEME = getter.flags { THEME_BALLISTICS=100 }

				DROP_CORPSE=true
				MORTAL=true
				ALLOW_IN_MUSCLE_TOWER=true
				RED_RIBBON=true
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_RRA_YELLOW"
			name = "Captain Yellow"
			desc =
			{
				"This moderately high ranking officer happens to be a tiger. A hungry one, at that. He moves",
				"with grace and speed, and his claws and teeth are sharp and ready to strike. A tiger, you ask?",
				"Well, the Red Ribbon Army may be an evil, cruel organization bent on World Domination...but no",
				"one ever accused the Red Ribbon Army of being specicists.",
			}
			level = 28 rarity = 5
			speed = 15 sleep  = 0
			exp   = 1000
			color = color.YELLOW
			life = {10,10} ac = 50
			aaf = 10
			weight = 3500
			blows =
			{
				{"CLAW","SLASH",{1,6}},
				{"CLAW","SLASH",{1,6}},
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				MALE=true
				GOTO_HELL=true
				HAS_LITE=true
				FORCE_MAXHP=true
				UNIQUE=true
				EVIL=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				ALLOW_IN_RRA_SHQ=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." licks his teeth.",
					name.." gets ready to pounce.",}
				end
			}
		}
	}
}

new_monster_races
{
	['a'] =	{
		defaults = {
			body = default_body.blob
			flags = {
				DROP_THEME = getter.flags { THEME_BALLISTICS=100 }
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=-100 }
				FORCE_MAXHP=true
				EMPTY_MIND=true
				COLD_BLOOD=true
				STUPID=true 
				FORCE_NO_DBALL=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				RED_RIBBON=true
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_RRA_TURRET"
			name = "Auto Cannon"
			desc =
			{
				"This defensive mechanical contraption is comprised of a large, automatic gun mounted",
				"on a rotating turret. Whether it is controlled by an AI, or remotely via a human operator",
				"is not clear, however, it seems only rarely to target Red Ribbon Army personell.",
			}
			level = 26 rarity = 30
			speed = 10 sleep  = 0
			exp   = 450
			color = color.SLATE
			life = {10,10} ac = 50
			aaf = 10
			weight = 3500
			blows = {}
			spells =
			{
				frequency = 1
				["Shoot"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.RANDOM_CAST
			}
		}
		[2] =
		{
			define_as = "RACE_RRA_CAMERA"
			name = "Security Camera"
			desc =
			{
				"A small video camera mounted on the wall. It's not clear whether someone is actively",
				"monitoring this camera, but it is very obviously tracking your movement.",
			}
			level = 21 rarity = 40
			speed = 0 sleep  = 0
			exp   = 1
			color = color.SLATE
			life = {1,1} ac = 50
			aaf = 10
			weight = 200
			blows = {}
			spells =
			{
				frequency = 6
				["Alarm"] = { level=1 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
			}
		}
	}
}


-- Supreme HQ Variants
new_monster_races
{
	['a'] =	{
		defaults = {
			body = default_body.blob
			flags = {
				DROP_THEME = getter.flags { THEME_BALLISTICS=100 }
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=-100 }
				FORCE_MAXHP=true
				EMPTY_MIND=true
				COLD_BLOOD=true
				STUPID=true 
				FORCE_NO_DBALL=true
				ALLOW_IN_RRA_SHQ=true
				RED_RIBBON=true
			}
		} -- defaults

		[1] =
		{
			define_as = "RACE_RRA_SHQ_INT"
			name = "Auto Cannon"
			desc =
			{
				"This defensive mechanical contraption is comprised of a large, automatic gun mounted",
				"on a rotating turret. Whether it is controlled by an AI, or remotely via a human operator",
				"is not clear, however, it seems only rarely to target Red Ribbon Army personell.",
			}
			level = 40 rarity = 30
			speed = 10 sleep  = 0
			exp   = 700
			color = color.SLATE
			life = {20,20} ac = 50
			aaf = 10
			weight = 3500
			blows = {}
			spells =
			{
				frequency = 1
				["Shoot"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.RRA_SHQ_INT
			}
		}
		[2] =
		{
			define_as = "RACE_RRA_SHQ_CAM"
			name = "Security Camera"
			desc =
			{
				"A small video camera mounted on the wall. It's not clear whether someone is actively",
				"monitoring this camera, but it is very obviously tracking your movement.",
			}
			level = 21 rarity = 40
			speed = 0 sleep  = 0
			exp   = 1
			color = color.SLATE
			life = {10,10} ac = 50
			aaf = 10
			weight = 200
			blows = {}
			spells =
			{
				frequency = 6
				["Alarm"] = { level=1 chance=100 }
			}
			flags =
			{
				AI=ai.RRA_SHQ_CAM
			}
		}
		[3] =
		{
			define_as = "RACE_RRA_SHQ_EXT"
			name = "Missile Turret"
			desc =
			{
				"A set of missiles rack-mounted on a swiveling turret with fully 360x180 degrees of",
				"rotation. Built of solid steel, it is extremely sturdy. It does have one weakness,",
				"however: limited ammunition.",
			}
			level = 40 rarity = 30
			speed = 10 sleep  = 0
			exp   = 500
			color = color.RED
			life = {30,30} ac = 100
			aaf = 10
			weight = 3500
			blows = {}
--			spells =
--			{
--				frequency = 1
--				["Missile Turret"] = { level=10 chance=100 }
--			}
			flags =
			{
				AI=ai.RRA_SHQ_EXT
				AMMO=8
				ALLOW_IN_RRA_SHQ=true
			}
		}
	}
}

new_monster_races
{
	['R'] =	{
		defaults = {
			body = default_body.humanoid
			flags = {
				DROP_THEME = getter.flags { THEME_BALLISTICS=100 }

				DROP_CORPSE=true
				BASH_DOOR=true
				ALLOW_IN_MUSCLE_TOWER=true
				ALLOW_IN_BLUE_LAIR=true
				ALLOW_IN_RRA_SHQ=true
				RED_RIBBON=true
			}
		} -- defaults
		[1] =
		{
			name = "Seargent Metallic"
			desc =
			{
				"An early model pregenitor to the Androids. With squared jaws and huge muscles, Seargent",
				"Metallic follows you with silent determination. He never sleeps. He never eats. He'll never",
				"give up. He'll find you.",
			}
			level = 25 rarity = 5
			speed = 10 sleep  = 0
			exp   = 1200
			color = color.ANTIQUE_WHITE
			life = {15,15} ac = 70
			aaf = 10
			weight = 3500
			blows =
			{
				{"HIT","CRUSH",{5,4}},
			}
			spells =
			{
				frequency = 3
				["Shoot"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=-100 CRUSH=50 SLASH=50 PIERCE=50 }
				ALLOW_IN_EVERYWHERE=true
				DROP_NUMBER=getter.random(1,3) DROP_GOOD=true
				MALE=true
				HAS_LITE=true
				FORCE_MAXHP=true
				UNIQUE=true
				EVIL=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." looks at you passively.",
					name.." emotionlessly reloads his guns.",}
				end
			}
		}
	}
}

new_monster_races
{
	['M'] =	{
		defaults = {
			body = default_body.humanoid
			flags = {
				DROP_THEME = getter.flags { THEME_BALLISTICS=100 }

				DROP_CORPSE=true
				BASH_DOOR=true
				ALLOW_IN_MUSCLE_TOWER=true
				RED_RIBBON=true
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_BUYON"
			name = "Buyon"
			desc =
			{
				"A massive purple monster with slimy green tongue and evil-looking antenna. It is so massively",
				"covered in a layer of thick blubber that you seriously doubt any sort of blunt attack is going",
				"to hurt it. It approaches hungrily, crunching bones beneath it's feet.",
			}
			level = 25 rarity = 999
			speed = 12 sleep  = 0
			exp   = 2000
			color = color.VIOLET
			life = {15,15} ac = 150
			aaf = 10
			weight = 3500
			blows =
			{
				{"BITE","CRUSH",{5,5}},
			}
			spells =
			{
				frequency = 5
				["Lightning Antenna"] = { level=10 chance=100 }
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				SPECIAL_GENE=true
				FORCE_NO_DBALL=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 COLD=-100 ELEC=100 CRUSH=100 BHAND=100 }
				MALE=true
				FORCE_MAXHP=true
				UNIQUE=true
				EVIL=true
				ON_DEATH=function(name)
					cave_set_feat(2, 15, FEAT_LESS)
				end
			}
		}
	}
}