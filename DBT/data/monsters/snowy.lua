-- Dragonball T: Snowy, chilly, cold, frozen type monsters

-- Note: Now that the Frozen Waste are gone...these monsters
-- probably aren't seein gmuch use.

new_monster_races
{
	['c'] =
	{
		defaults =
		{
			body = default_body.quadruped
			flags = {
				ANIMAL=true
				CAN_SWIM=true
				DROP_CORPSE=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
			}
		}
		[1] =
		{
			define_as = "RACE_WOLF"
			name = "wolf"
			level = 22 rarity = 1
			desc = {
				"With sharp teeth and thick fur, these wolves are fast",
				"and efficient hunters.",
			}
			color = color.BLUE
			speed = 20 life = {25,10} ac = 90
			aaf = 10 sleep = 100
			exp = 250
			weight = 1
			blows =
			{
				{"BITE","PIERCE",{3,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_AI=ai.DBT_ZOMBIE
				FACTION=FACTION_DUNGEON
				RESIST=getter.resists{FIRE=-50 COLD=80 SLASH=20}
				FRIENDS=getter.friends(30,10)
			}
		}
		[2] =
		{
			define_as = "RACE_WHITE_WOLF"
			name = "the white wolf"
			level = 30 rarity = 1
			desc = {
				"This lone predatory wolf is unique amongst its kind, and chooses to hunt",
				"alone. Whether to keep its prey to itself, or simply because it has no",
				"need of a pack is diffiult to say.",
			}
			color = color.BLUE
			speed = 20 life = {20,20} ac = 120
			aaf = 10 sleep = 0
			exp = 400
			weight = 1
			blows =
			{
				{"BITE","PIERCE",{4,10}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DBT_AI=ai.DBT_ZOMBIE
				UNIQUE=true
				FACTION=FACTION_DUNGEON
				RESIST=getter.resists{FIRE=-50 COLD=100 SLASH=20}
				FORCE_MAXHP=true
				ON_DEATH = function(monst)
					message(color.YELLOW, "The white wolf lets out a loud yelp, and collapses!")
					local obj = create_artifact(ART_WOLF_PELT)
					drop_near(obj, -1, monst.fy, monst.fx)
					if quest(QUEST_WHITE_WOLF).status == QUEST_STATUS_TAKEN then
						change_quest_status(QUEST_WHITE_WOLF, QUEST_STATUS_COMPLETED)
					end
				end
			}
		}
	}
}
