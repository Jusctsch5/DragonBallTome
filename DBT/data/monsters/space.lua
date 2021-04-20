-- Space Stuff

new_monster_races
{
	['*'] =
	{
		defaults =
		{
			body = default_body.blob
			flags = 
			{
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				DROP_DRAGONBALL=0
			}
		}
		[1] =
		{
			define_as = "RACE_DEBRIS"
			name = "debris"
			level = 1 rarity = 999
			desc =
			{
				"A piece of debris from a destroyed planet.",
			}
			color = color.UMBER
			speed = 20 life = {100,100} ac = 1
			aaf = 10 sleep = 10
			exp = 0
			weight = 5000
			blows =
			{
				{"HIT","CRUSH",{10,10}},
			}
			flags =
			{
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=100 COLD=100 SLASH=100 PIERCE=80 LITE=100 }
				RAND_MOVEMENT=100
				CAN_FLY=30 
				NO_FEAR=true
			}
		}
	}
}
