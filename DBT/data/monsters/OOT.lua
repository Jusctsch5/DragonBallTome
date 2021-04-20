-- Dragonball T: Out of Theme monsters
-- Note that several OOT monsters are trainers, and thus found in trainers.lua

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
				NO_FEAR=true
			}
		}
		[1] =
		{
			define_as = "RACE_LEONARDO"
			name = "Leonardo"
			level = 25 rarity = 100
			desc = {
				"Describe me",
			}
			color = color.GREEN
			speed = 10 life = {10,10} ac = 50
			aaf = 10 sleep = 10
			exp = 2000
			weight = 1500
			blows =
			{
				{"HIT","SLASH",{4,20}},
				{"HIT","SLASH",{4,20}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				FACTION=FACTION_TURTLES
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH = function(monst)
					if dball.current_location() ~= "World Tournament" then
						local obj = create_object(TV_SWORDARM, SV_KATANA)
						drop_near(obj, -1, monst.fy, monst.fx)
						local obj = create_object(TV_SWORDARM, SV_KATANA)
						drop_near(obj, -1, monst.fy, monst.fx)
					end
				end
			}
		}
		[2] =
		{
			define_as = "RACE_DONATELLO"
			name = "Donatello"
			level = 25 rarity = 100
			desc = {
				"Describe me",
			}
			color = color.GREEN
			speed = 10 life = {10,10} ac = 50
			aaf = 10 sleep = 10
			exp = 2000
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{4,20}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				FACTION=FACTION_TURTLES
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH = function(monst)
					if dball.current_location() ~= "World Tournament" then
						local obj = create_object(TV_POLEARM, SV_BO_STAFF)
						drop_near(obj, -1, monst.fy, monst.fx)
					end
				end
			}
		}
		[3] =
		{
			define_as = "RACE_MICHAELANGELO"
			name = "Michaelangelo"
			level = 25 rarity = 100
			desc = {
				"Describe me",
			}
			color = color.GREEN
			speed = 10 life = {10,10} ac = 50
			aaf = 10 sleep = 10
			exp = 2000
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{1,16}},
				{"HIT","CRUSH",{1,16}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				FACTION=FACTION_TURTLES
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH = function(monst)
					if dball.current_location() ~= "World Tournament" then
						local obj = create_object(TV_SMALLARM, SV_NUNCHAKU)
						drop_near(obj, -1, monst.fy, monst.fx)
						local obj = create_object(TV_SMALLARM, SV_NUNCHAKU)
						drop_near(obj, -1, monst.fy, monst.fx)
					end
				end
			}
		}
		[4] =
		{
			define_as = "RACE_RAPHAEL"
			name = "Raphael"
			level = 25 rarity = 100
			desc = {
				"Describe me",
			}
			color = color.GREEN
			speed = 10 life = {10,10} ac = 50
			aaf = 10 sleep = 10
			exp = 2000
			weight = 1500
			blows =
			{
				{"HIT","CRUSH",{4,20}},
				{"HIT","PIERCE",{4,20}},
			}
			flags =
			{
				AI=ai.DBT_RANDOM
				DBT_AI=ai.DBT_ZOMBIE
				FACTION=FACTION_TURTLES
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH = function(monst)
					if dball.current_location() ~= "World Tournament" then
						local obj = create_object(TV_SMALLARM, SV_SAI)
						drop_near(obj, -1, monst.fy, monst.fx)
						local obj = create_object(TV_SMALLARM, SV_SAI)
						drop_near(obj, -1, monst.fy, monst.fx)
					end
				end
			}
		}
		[5] =
		{
			define_as = "RACE_IRON_MONKEY"
			name = "The Iron Monkey"
			level = 32 rarity = 30
			desc = {
				"'Under the shadow of night, in the silence before dawn, he fights to give hope",
				"to the poor and the oppressed. Although no one knows his name or where he comes",
				"from, his heroism makes him a living legend to the people...and a wanted man to",
				"the powes that be.'",
			}
			color = color.LIGHT_DARK
			speed = 20 life = {30,30} ac = 120
			aaf = 10 sleep = 10
			exp = 2000
			weight = 1500
			spells =
			{
				frequency = 4
				["Powder"] = { level=8 chance=100 }
				["Shuriken"] = { level=8 chance=100 }
				["Dart"] = { level=8 chance=100 }
			}
			blows =
			{
				{"HIT","SLASH",{4,8}},
				{"TOUCH","EAT_GOLD",{0,0}},
			}
			flags =
			{
				AI=ai.DBT_DEFAULT
				DBT_AI=ai.DBT_DEFAULT
				DBT_REFLECT=40
				FACTION=FACTION_GOOD
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				-- DBTCHAT=function(name)
				--end
			}
		}
	}
}

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
				DROP_CORPSE=true MORTAL=true
				OPEN_DOOR=true BASH_DOOR=true
			}
		}
		[1] =
		{
			define_as = "RACE_WONG_FEI_HONG"
			name = "Wong Fei Hong"
			level = 37 rarity = 20
			desc = {
				"Warrior, healer, and hero of China, Wong-Fei Hong fights with an umbrella,",
				"and like many uniques deserves to have a better description than he has.",
			}
			color = color.LIGHT_BLUE
			speed = 40 life = {40,40} ac = 150
			aaf = 10 sleep = 0
			exp = 20000
			weight = 1400
			blows =
			{
				{"HIT","CRUSH",{1,50}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_REFLECT=50
				NO_FEAR=true
				DBT_AI=ai.DBT_ZOMBIE
				FACTION=FACTION_GOOD
				MALE=true
				GOOD=true
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					message("Wong-Fei Hong says 'Hello.'")
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
		defaults =
		{
			body = default_body.humanoid
			flags = 
			{
				DROP_THEME = getter.flags { THEME_MARTIAL=100 }
				FORCE_MAXHP=true SMART=true 
				DROP_CORPSE=true MORTAL=true
				OPEN_DOOR=true BASH_DOOR=true
				UNIQUE=true 
				SPECIAL_GENE=true
			}
		}
		[1] =
		{
			define_as = "RACE_SAKURA_SENSHI"
			name = "Battle Jacket, Sakura"
			level = 29 rarity = 20
			desc = {
				"The lovely Sakura has donned a steam powered battle jacket and is intent on killing",
				"you! What an unexpected turn of events!",
			}
			color = color.LIGHT_RED
			speed = 23 life = {20,40} ac = 150
			aaf = 10 sleep = 0
			exp = 20000
			weight = 40000
			blows =
			{
				{"HIT","CRUSH",{1,50}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DBT_AI=ai.DBT_ZOMBIE
				FEMALE=true
				DBT_FORCE_NO_CORPSE=true
				GOOD=true
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					-- message("I shall slay you!")
				end
				ON_DEATH = function(monst)
					local obj = create_object(TV_POWER_ARMOR, SV_BATTLE_JACKET)
					drop_near(obj, -1, monst.fy, monst.fx)
				end
			}
		}
		[2] =
		{
			define_as = "RACE_SUMIRE_SENSHI"
			name = "Battle Jacket, Sumire"
			level = 29 rarity = 20
			desc = {
				"This suit is piloted by Sumire Kanzaki. The massive naginata in her suits' hands more than",
				"makes up for the lack of other forms of mounted weaponry.",
			}
			color = color.VIOLET
			speed = 23 life = {20,40} ac = 150
			aaf = 10 sleep = 0
			exp = 20000
			weight = 40000
			blows =
			{
				{"HIT","CRUSH",{1,50}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DBT_AI=ai.DBT_ZOMBIE
				FEMALE=true
				DBT_FORCE_NO_CORPSE=true
				GOOD=true
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					-- message("I shall slay you!")
				end
				ON_DEATH = function(monst)
					local obj = create_object(TV_POWER_ARMOR, SV_BATTLE_JACKET)
					drop_near(obj, -1, monst.fy, monst.fx)
				end
			}
		}
		[3] =
		{
			define_as = "RACE_MARIA_SENSHI"
			name = "Battle Jacket, Maria"
			level = 29 rarity = 20
			desc = {
				"This suit is piloted by Maria Tachibana, a veteran with extensive military experience.",
				"Her Koubu carries a large and mean-looking mini gun directly mounted on one arm.",
			}
			color = color.DARK
			speed = 23 life = {20,40} ac = 150
			aaf = 10 sleep = 0
			exp = 20000
			weight = 40000
			blows =
			{
				{"HIT","CRUSH",{1,50}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DBT_AI=ai.DBT_ZOMBIE
				FEMALE=true
				DBT_FORCE_NO_CORPSE=true
				GOOD=true
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					-- message("I shall slay you!")
				end
				ON_DEATH = function(monst)
					local obj = create_object(TV_POWER_ARMOR, SV_BATTLE_JACKET)
					drop_near(obj, -1, monst.fy, monst.fx)
				end
			}
		}
		[4] =
		{
			define_as = "RACE_IRIS_SENSHI"
			name = "Battle Jacket, Iris"
			level = 29 rarity = 20
			desc = {
				"This bright yellow Koubu is piloted by Iris Chateaubriand of France. Curiously,",
				"her suit does not appear to be configured with any weapons. So that means she's",
				"not dangerous, right...?",
			}
			color = color.YELLOW
			speed = 23 life = {20,40} ac = 150
			aaf = 10 sleep = 0
			exp = 20000
			weight = 40000
			blows =
			{
				{"HIT","CRUSH",{1,50}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DBT_AI=ai.DBT_ZOMBIE
				FEMALE=true
				DBT_FORCE_NO_CORPSE=true
				GOOD=true
				GOTO_HEAVEN=true
				DBTCHAT=function(name)
					-- message("I shall slay you!")
				end
				ON_DEATH = function(monst)
					local obj = create_object(TV_POWER_ARMOR, SV_BATTLE_JACKET)
					drop_near(obj, -1, monst.fy, monst.fx)
				end
			}
		}
	}
}