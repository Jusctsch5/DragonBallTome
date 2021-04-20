-- Dragonball T: Monsters relating to the Ballet mouse hunt

new_monster_races
{

	['r'] =
	{
		defaults =
		{
			body = default_body.humanoid
			flags = 
			{
				DROP_THEME = getter.flags { THEME_PLAIN=100 }
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			define_as = "RACE_CUTE_LITTLE_GIRLMOUSE"
			name = "cute little girl mouse"
			level = 1 rarity = 1
			desc = "Oh! It's an aspiring young ballerina in a cute little mouse costume! How precious!"
			color = color.LIGHT_RED
			speed = 0 life = {1,10} ac = 50
			aaf = 10 sleep = 0
			exp = 1
			weight = 600
			blows =
			{
			}
			flags =
			{
				AI=ai.MOUSE
				FEMALE = true
				OPEN_DOOR=false DROP_CORPSE=true
				SPECIAL_GENE=true
				ALLOW_IN_SEWERS=true
				PERMANENT=false
				FACTION=FACTION_MOUSE
			}
		}

		-- Someone on the forums objected that all of the mice were girls, so...
		[2] =
		{
			define_as = "RACE_CUTE_LITTLE_BOYMOUSE"
			name = "cute little boy mouse"
			level = 1 rarity = 1
			desc = "Oh! It's a little boy in a cute little mouse costume! How precious!"
			color = color.LIGHT_BLUE
			speed = 0 life = {1,10} ac = 50
			aaf = 10 sleep = 0
			exp = 1
			weight = 600
			blows =
			{
			}
			flags =
			{
				AI=ai.MOUSE
				MALE = true
				OPEN_DOOR=false DROP_CORPSE=true
				SPECIAL_GENE=true
				ALLOW_IN_SEWERS=true
				PERMANENT=false
				FACTION=FACTION_MOUSE
			}
		}
		[3] =
		{
			define_as = "RACE_KING_MOUSE"
			name = "King Mouse"
			level = 11 rarity = 999
			desc = {
				"A large and well dressed bipedal rat wielding a large and extremely jagged edged sword.",
				"Oh. Wait...no, it's a middle aged man wearing a costume. Never mind. Except the part about",
				"the sword. That looks real enough.",
			}
			color = color.VIOLET
			speed = 15 life = {15,15} ac = 80
			aaf = 10 sleep = 255
			exp = 1200
			weight = 1500
			blows =
			{
				{"HIT","SLASH",{2,10}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				UNIQUE=true MALE=true
				FACTION=FACTION_DUNGEON
				FORCE_SLEEP=true FORCE_MAXHP=true SMART=true 
				OPEN_DOOR=true BASH_DOOR=true EVIL=true
				GOTO_HELL=true
				DROP_CORPSE=true
				ON_DEATH = function(monst)
					local obj = create_artifact(ART_MOUSE_SWORD)
					drop_near(obj, -1, monst.fy, monst.fx)
					message(color.YELLOW, "The children are now all following you!")
					for_each_monster(function(m_idx, monst)
						if (monst.r_idx == RACE_CUTE_LITTLE_GIRLMOUSE) or (monst.r_idx == RACE_CUTE_LITTLE_BOYMOUSE) then
							monst.flags[FLAG_PERMANENT] = true
							monst.faction = FACTION_PLAYER
						end
					end)
				end
			}
		}
	}
}
