-- The Warehouse: Monster races definitions
-- Incidentally, for anyone who doesn't get the joke...the Drainage Ditch special level
-- and related Quest lines are entirely a reference to Tchaikovsky's Nutcracker. 
-- Remember...Elizabeth is a dance instructor. :)

new_monster_races
{

	['r'] =
	{
		defaults =
		{
			body = default_body.quadruped
			flags = {
				ALLOW_IN_RABBIT_HOLE=true
				ANIMAL=true
				DROP_CORPSE=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				AI=ai.DBT_ZOMBIE
			}
		}
		[1] =
		{
			name = "cute little bunny"
			level = 1 rarity = 1
			desc = "It's a fluffy white rabbit How cute!"
			color = color.WHITE
			speed = 5 life = {1,1} ac = 20
			aaf = 10 sleep = 0
			exp = 3
			weight = 40
			blows =
			{
				{"BITE","PIERCE",{1,1}},
			}
			flags = {
				MULTIPLY=true STUPID=true
			}
		}
		[2] =
		{
			name = "large rabbit"
			level = 2 rarity = 5
			desc = {
				"This rabbit is not so cute.",
			}
			color = color.OLD_LACE
			speed = 0 life = {5,5} ac = 40
			aaf = 10 sleep = 10
			exp = 6
			weight = 100
			blows =
			{
				{"BITE","PIERCE",{1,4}},
			}
			flags =
			{
				STUPID=true
			}
		}
		[3] =
		{
			name = "giant rabbit"
			level = 4 rarity = 5
			desc = {
				"This rabbit is downright scary looking.",
			}
			color = color.LIGHT_DARK
			speed = 0 life = {5,5} ac = 50
			aaf = 10 sleep = 10
			exp = 15
			weight = 120
			blows =
			{
				{"BITE","PIERCE",{1,6}},
			}
			flags =
			{
				STUPID=true
			}
		}
		[4] =
		{
			define_as = "RACE_BOSS_RABBIT"
			name = "Boss Rabbit"
			level = 4 rarity = 5
			desc = {
				"This is the humanoid rabbit the Aru villagers seem to think is responsible for",
				"kidnapping people and transforming them into carrots.",
			}
			color = color.VIOLET
			speed = 0 life = {7,7} ac = 50
			aaf = 10 sleep = 10
			exp = 65
			weight = 600
			blows =
			{
				{"BITE","PIERCE",{1,12}},
			}
			flags =
			{
				DROP_NUMBER=getter.random(1,2) DROP_GOOD=true
				FORCE_MAXHP=true
				MALE=true
				HAS_LITE=true
				EVIL=true
				GOTO_HELL=true
				UNIQUE=true
				CAN_SPEAK=function(name)
					monster_random_say{
					name.." looks around for some carrots",
					name.." wiggles his whiskers",
					name.." shouts 'I will transform the people of Aru village into carrots!",}
				end
				ON_DEATH=function(name)
					if quest(QUEST_BOSS_RABBIT).status == QUEST_STATUS_TAKEN then
						message(color.YELLOW, "This must have been the rabbit Imelda spoke of.")
				 		change_quest_status(QUEST_BOSS_RABBIT, QUEST_STATUS_COMPLETED)
						-- Don't actually need to set this, Imelda checks the quest, but...
						dball_data.bossrabbit = 1
					else
						message(color.YELLOW, "What a curious, bloated-looking bunny that was.")
						dball_data.bossrabbit = 1
					end
				end
			}
		}
	}
}
