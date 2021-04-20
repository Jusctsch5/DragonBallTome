----------------------------------------------------------------------
------------------------ Gods (Kami/Kaio/Daio) -----------------------
----------------------------------------------------------------------
new_monster_races
{
	['K'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true TAKE_ITEM=true OPEN_DOOR=true
				UNIQUE=true FORCE_MAXHP=true
				IMMORTAL=true
			}
		} -- defaults

		[1] =
		{
			define_as = "RACE_KAMI"
			name = "Kami"
			desc =
			{
				"The current God of the world happens to be a Namekian so old he has forgotten",
				"his given name, and goes simply, by 'Kami.'",
			}
			color = color.GREEN
			level = 50 rarity = 100
			life = {30,30} ac = 200
			exp   = 25000
			speed = 20 
			aaf = 10
			weight = 1700
			blows =
			{
				{"CRUSH","CRUSH",{10,10}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=70
				NO_FEAR=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 }
				DROP_THEME = getter.flags{ THEME_NAMEK=100 }
				MALE=true
				FACTION=FACTION_KAMI
				GOOD=true
				KARMA=-5000
				DBTCHAT=function(name)
					dialogue.KAMI()
				end
			}
		}
		[2] =
		{
			define_as = "RACE_EAST_KAIOSHIN"
			name = "The East Kaioshin"
			desc =
			{
				"One rank above the Kaio, Kaioshin oversee countless galaxies, and it is extremely",
				"rare to see one. The East Kaioshin generally takes the form of a short, purple",
				"skinned humanoid with white hair, and dresses in heavily symbolized formal attire.",
				"He has a serious demeanor, but is friendly, and is rarely seen without his faithful",
				"friend and bodyguard, Kibito. Bodyguard? Yes, unlike most Gods in this region, the",
				"East Kaioshin has only a casual interest in the fighting arts.",
			}
			color = color.VIOLET
			level = 99 rarity = 999
			life = {20,20} ac = 100
			exp   = 50000
			speed = 20 
			aaf = 10
			weight = 1500
			blows =
			{
				{"CRUSH","CRUSH",{8,8}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_RUN_AWAY
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=80 COLD=80 }
				DROP_THEME = getter.flags{ THEME_PLAIN=100 }
				MALE=true
				FACTION=FACTION_KAMI
				ALLOW_ON_KAIO_WORLD=true
				GOOD=true
				KARMA=-10000
				DBTCHAT=function(name)
					dialogue.EAST_KAIOSHIN()
				end
			}
		}
		[3] =
		{
			define_as = "RACE_EMMA_DAIO"
			name = "Emma Daio, the red ogre"
			desc =
			{
				"A massive ogre with red skin, Emma Daio guards the gates to Heaven and Hell, and",
				"decides who, of the newly dead, will go to each.",
			}
			color = color.RED
			level = 60 rarity = 100
			life = {20,20} ac = 200
			exp   = 50000
			speed = 30 
			aaf = 10
			weight = 4000
			blows =
			{
				{"CRUSH","CRUSH",{6,6}},
			}
			flags =
			{
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				DBT_REFLECT=100
				NO_FEAR=true
				RESIST=getter.resists{CONFUSION=100 FEAR=100 FIRE=80 POIS=100 ELEC=80 COLD=80 }
				MALE=true
				FACTION=FACTION_KAMI
				GOOD=true
				KARMA=-20000
				CAN_SPEAK=function(name)
						monster_random_say{
						name.." says 'Hmm. You really shouldn't be here.'",
						name.." says 'You know, this really isn't the safest of places to be loitering about.",
						name.." says 'We don't get many tourists through here.",}
				end
				DBTCHAT=function(name)
					dialogue.EMMA()
				end
			}
		}
	}
}

