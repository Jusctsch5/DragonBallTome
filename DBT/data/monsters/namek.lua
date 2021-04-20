-- Dragonball T: Creatures of Namek

new_monster_races
{
	['N'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags = {
				ALLOW_ON_NAMEK=true
				DROP_CORPSE=true
				DROP_THEME = getter.flags { THEME_NAMEK=100 }
				NAMEKSEIJIN=true
				FACTION=FACTION_NAMEK
				DBTCHAT=function(name)
					dialogue.NAMEK_GENERIC()
				end
			}
		}
		[1] =
		{
			define_as = "RACE_NAMEK_FARMER"
			name = "farmer"
			level = 24 rarity = 1
			desc = "A farmer, sowing the fields with the ajasa plant."
			color = color.LIGHT_GREEN
			speed = 18 life = {20,20} ac = 100
			aaf = 10 sleep = 0
			exp = 1000
			weight = 1800
			blows =
			{
				{"PUNCH","CRUSH",{8,8}},
			}
			flags = {
				REGENERATE=200
				AI=ai.NAMEK
			}
		}
		[2] =
		{
			define_as = "RACE_NAMEK_WARRIOR"
			name = "warrior"
			level = 33 rarity = 1
			desc =
				{
					"As dueling is a favorite hobby on Namek, and the ability to manipulate chi",
					"common, the basic warriors of Namek should not be taken lightly.",
				}
			color = color.DARK_GREEN
			speed = 25 life = {30,30} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1900
			spells =
			{
				frequency = 7
				["Chi Burst"] = { level=20 chance=80 }
				["Throw"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{10,10}},
			}
			flags = {
				REGENERATE=300
				DBT_REFLECT=40
				AI=ai.NAMEK
				CAN_FLY=3 
			}
		}
	}
}

new_monster_races
{
	['N'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags = {
				ALLOW_ON_NAMEK=true
				UNIQUE=true
				SPECIAL_GENE=true
				FORCE_MAXHP=true
				REGENERATE=200
				DROP_CORPSE=true
				DROP_THEME = getter.flags { THEME_NAMEK=100 }
				DROP_GOOD=true
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_DEFAULT
				NAMEKSEIJIN=true
				FACTION=FACTION_NAMEK
			}
		}
		[1] =
		{
			define_as = "RACE_NAMEK_ELDER1"
			name = "first elder"
			level = 37 rarity = 1
			desc =
				{
					"While physically slower and weaker than the warriors, the elders of Namek",
					"have all spent countless years refining their ability to direct the forces",
					"of life.",
				}
			color = color.GREEN
			speed = 22 life = {20,20} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1600
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{6,6}},
			}
			flags = {
				REGENERATE=500
				DBTCHAT=function(name)
					dialogue.NAMEK_ELDER(1)
				end
			}
		}
		[2] =
		{
			define_as = "RACE_NAMEK_ELDER2"
			name = "second elder"
			level = 37 rarity = 1
			desc =
				{
					"While physically slower and weaker than the warriors, the elders of Namek",
					"have all spent countless years refining their ability to direct the forces",
					"of life.",
				}
			color = color.GREEN
			speed = 22 life = {20,20} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1600
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{6,6}},
			}
			flags = {
				REGENERATE=500
				DBTCHAT=function(name)
					dialogue.NAMEK_ELDER(2)
				end
			}
		}
		[3] =
		{
			define_as = "RACE_NAMEK_ELDER3"
			name = "third elder"
			level = 37 rarity = 1
			desc =
				{
					"While physically slower and weaker than the warriors, the elders of Namek",
					"have all spent countless years refining their ability to direct the forces",
					"of life.",
				}
			color = color.GREEN
			speed = 22 life = {20,20} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1600
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{6,6}},
			}
			flags = {
				REGENERATE=500
				DBTCHAT=function(name)
					dialogue.NAMEK_ELDER(3)
				end
			}
		}
		[4] =
		{
			define_as = "RACE_NAMEK_ELDER4"
			name = "fourth elder"
			level = 37 rarity = 1
			desc =
				{
					"While physically slower and weaker than the warriors, the elders of Namek",
					"have all spent countless years refining their ability to direct the forces",
					"of life.",
				}
			color = color.GREEN
			speed = 22 life = {20,20} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1600
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{6,6}},
			}
			flags = {
				REGENERATE=500
				DBTCHAT=function(name)
					dialogue.NAMEK_ELDER(4)
				end
			}
		}
		[5] =
		{
			define_as = "RACE_NAMEK_ELDER5"
			name = "fifth elder"
			level = 37 rarity = 1
			desc =
				{
					"While physically slower and weaker than the warriors, the elders of Namek",
					"have all spent countless years refining their ability to direct the forces",
					"of life.",
				}
			color = color.GREEN
			speed = 22 life = {20,20} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1600
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{6,6}},
			}
			flags = {
				REGENERATE=500
				DBTCHAT=function(name)
					dialogue.NAMEK_ELDER(5)
				end
			}
		}
		[6] =
		{
			define_as = "RACE_NAMEK_ELDER6"
			name = "sixth elder"
			level = 37 rarity = 1
			desc =
				{
					"While physically slower and weaker than the warriors, the elders of Namek",
					"have all spent countless years refining their ability to direct the forces",
					"of life.",
				}
			color = color.GREEN
			speed = 22 life = {20,20} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1600
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
				{"PUNCH","CRUSH",{6,6}},
			}
			flags = {
				REGENERATE=500
				DBTCHAT=function(name)
					dialogue.NAMEK_ELDER(6)
				end
			}
		}
		[7] =
		{
			define_as = "RACE_NAMEK_GREAT_ELDER"
			name = "the great elder"
			level = 50 rarity = 1
			desc =
				{
					"The Great Elder is the only living Namekian on the planet to have survived",
					"the holocaust that nearly destroyed their race. Sadly, his heart is failing, and",
					"he is very near the end of his natural life.",
				}
			color = color.DARK_SEA_GREEN
			speed = 22 life = {20,20} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1600
			blows =
			{
			}
			flags = {
				REGENERATE=500
				DBTCHAT=function(name)
					dialogue.NAMEK_ELDER(7)
				end
			}
		}
		[8] =
		{
			define_as = "RACE_NAMEK_DENDE"
			name = "Dende"
			level = 30 rarity = 1
			desc =
				{
					"A young Namek, perhaps the size of a 12 year old, Dende is a gifted healer.",
				}
			color = color.GREEN
			speed = 22 life = {20,20} ac = 110
			aaf = 10 sleep = 0
			exp = 3000
			weight = 1600
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
			}
			flags = {
				REGENERATE=500
				DBT_REFLECT=20
				DBTCHAT=function(name)
					dialogue.NAMEK_DENDE()
				end
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_CONDITION=function()
					if dball_data.namek_general_state == 0 then -- No contact
						return false
					elseif dball_data.namek_general_state == 999 then -- Nameks aggressive
						return false
					elseif dball_data.alignment < 100 then -- Require niceness
						return false
					elseif dball_data.namek_who_promoted == RACE_NAMEK_DENDE then -- Won't abandon post
						return false
					else
						return true
					end
				end
			}
		}
		[9] =
		{
			define_as = "RACE_NAMEK_NAIL"
			name = "Nail"
			level = 50 rarity = 1
			desc =
				{
					"The greatest of the warrior Nameks, Nail attends to the Great Elder.",
				}
			color = color.GREEN
			speed = 22 life = {50,50} ac = 160
			aaf = 10 sleep = 0
			exp = 15000
			weight = 2300
			spells =
			{
				frequency = 3
				["Chi Burst"] = { level=20 chance=100 }
			}
			blows =
			{
			}
			flags = {
				REGENERATE=1000
				DBT_REFLECT=50
				DBTCHAT=function(name)
					dialogue.NAMEK_NAIL()
				end
				PARTY_STATE=FLAG_PARTY_ACT_FOLLOW
				PARTY_CONDITION=function()
					if dball_data.namek_general_state == 0 then -- No contact
						return false
					elseif dball_data.namek_general_state == 999 then -- Nameks aggressive
						return false
					elseif dball_data.alignment < 100 then -- Require niceness
						return false
					elseif dball_data.namek_who_promoted == RACE_NAMEK_NAIL then -- Won't abandon post
						return false
					else
						return true
					end
				end
			}
		}
	}
}

new_monster_races
{
	['g'] =
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
			name = "small frog"
			level = 5 rarity = 1
			desc = {
				"At least, it sort of looks like a frog. A frog with a pair of antenna and glowing red eyes.",
				"It seems to be some sort of small amphibian, at least. In a way it almost looks cuddly,",
				"but this is a strange world. Are Namekkian frogs dangerous?",
			}
			color = color.LIGHT_GREEN
			speed = 7 life = {2,5} ac = 50
			aaf = 10 sleep = 10
			exp = 1
			weight = 20
			blows =
			{
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				FACTION=FACTION_ANIMAL
				ALLOW_ON_NAMEK=true
				DBTCHAT=function()
					monster_random_say{
					"Kiro!",
					"Kiro, kiro!",
					"it nudges your foot with its nose",
					"it blinks at you",
					"it wiggles its antenna at you",
					"it looks at you with curiosity",}
				end
			}
		}
	}
}

new_monster_races
{
	['M'] =
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
			name = "leviathan"
			level = 42 rarity = 1
			desc = {
				"This monstrous sea creature somewhat resembles earth whales, except that it looks",
				"far meaner. Bearing a single large horn on its head, and a sharp row of teeth, clearly",
				"the leviathan does not survive merely by eating plankton.",
			}
			color = color.LIGHT_GREEN
			speed = 40 life = {50,50} ac = 150
			aaf = 10 sleep = 10
			exp = 5000
			weight = 200000
			blows =
			{
			}
			flags =
			{
				AI=ai.LEVIATHAN
				DBT_AI=ai.RUN_AWAY
				FACTION=FACTION_DUNGEON
				ALLOW_ON_NAMEK=true
				I_AM_A_LEVIATHAN=true
				DROP_CORPSE_FORCE=true
				CAN_SWIM=true
				AQUATIC=true
				INVISIBLE=true
				DBTCHAT=function()
				end
				ON_DEATH = function(monst)
					-- No tricking the Elder...but we might trick the player! :)
					if dball_data.namek_lev_check == 1 then
						dball_data.namek_lev_check = 2
					end
					if quest(QUEST_NAMEK_LEVIATHAN).status == QUEST_STATUS_TAKEN then
						message(color.YELLOW, "You have defeated a Leviathan! Now...how to return the corpse?")
						quest(QUEST_NAMEK_LEVIATHAN).status = QUEST_STATUS_COMPLETED
					end
				end
			}
		}
	}
}
