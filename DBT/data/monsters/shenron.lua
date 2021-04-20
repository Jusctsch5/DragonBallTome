-- Shenron, the Eternal Dragon
-- I just thought he deserved his own file

new_monster_races
{

	['D'] =
	{
		defaults =
		{
			body = default_body.dragon
			flags = {}
		}
		[1] =
		{
			define_as = "RACE_SHENRON"
			name = "Shenron, the Eternal Dragon"
			level = 100 rarity = 999
			desc =
			{
				"Behold, Shenron, the Eternal Dragon of the planet Earth. Shenron is an enormous, serpentine",
				"green dragon, perhaps two or three hundred feet long with a head large enough to swallow a",
				"bus. Summoned by the Dragonballs, he is here to grant you a wish.",
			}
			color = color.GREEN
			speed = 100 life = {100,100} ac = 500
			aaf = 10 sleep = 10
			exp = 1000000
			weight = 750000
			blows =
			{
				{"BITE","PIERCE",{100,100}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_REFLECT=100
				DBT_AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 COLD=80 POIS=80 ELEC=80 CRUSH=80 }
				MALE = true
				CAN_FLY=30 
				HAS_LITE=true
				SMART=true
				FACTION=FACTION_DRAGON
				BASH_DOOR=true DROP_CORPSE=true
				UNIQUE=true
				-- SPECIAL_GENE=true
				-- POWERFUL=true
				-- KILL_WALL=true
				-- MOVE_BODY=true
				ON_DEATH = function(monst)
					-- dball.destroy_earth()
				end
				DBTCHAT = function()
					dialogue.SHENRON()
				end
			}
		}
	}
}
