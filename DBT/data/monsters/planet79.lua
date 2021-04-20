-- Dragonball T: Dinosaurs

new_monster_races
{
	['M'] =
	{
		[1] =
		{
			name = "Terranodon"
			level = 33 rarity = 3
			desc = {
				"A huge, prehistoric-looking beast that towers above you with slavering jaws.",
				"Its forelimbs are prehensile, but feature three foot long claws, which are dwarfed",
				"by its massively powerful hind legs, which carry it a great speed.",
			}
			body = default_body.quadruped
			color = color.UMBER
			speed = 20 life = {20,20} ac = 60
			aaf = 10 sleep = 10
			exp = 3000
			weight = 70000
			blows =
			{
				{"CLAW","SLASH",{4,4}},
				{"CLAW","SLASH",{4,4}},
				{"BITE","PIERCE",{6,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				DROP_CORPSE=true
				MORTAL=true
				CAN_FLY=30 
				ALLOW_ON_79=true
				RAND_MOVEMENT=0
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
			}
		}
	}
	['b'] =
	{
		[1] =
		{
			name = "Chrystlix"
			level = 33 rarity = 2
			desc = {
				"A largish creature that looks like a cross between a beetle and a rhinosaurus,",
				"with powerful mandibles, and a hard, chitinous shell.",
			}
			body = default_body.quadruped
			color = color.YELLOW
			speed = 10 life = {20,20} ac = 90
			aaf = 10 sleep = 0
			exp = 2400
			weight = 600
			blows =
			{
				{"BITE","CRUSH",{7,7}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				RAND_MOVEMENT=0
				DROP_CORPSE=true
				MORTAL=true
				ALLOW_ON_79=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
			}
		}
	}
	['P'] =
	{
		[1] =
		{
			name = "Rhododendron"
			level = 33 rarity = 1
			desc = {
				"A huge mass of writhing tentacles erupting from the ground, you're not certain",
				"whether this plant draws sustenance from the soil, but if so, it's clear that its",
				"tentacles are looking for alternate sources as food as well.",
			}
			body = default_body.blob
			color = color.GREEN
			speed = 0 life = {10,10} ac = 70
			aaf = 10 sleep = 0
			exp = 1000
			weight = 700
			blows =
			{
				{"HIT","SLASH",{3,4}},
				{"HIT","SLASH",{3,4}},
				{"HIT","SLASH",{3,4}},
				{"HIT","PARALYZE",{3,4}},
			}
			flags =
			{
				NO_FEAR=true
				MORTAL=true
				ALLOW_ON_79=true
				ALLOW_IN_URANAI=true
				MULTIPLY=true
				STUPID=true
				RAND_MOVEMENT=0 -- Not used, but easier on the handler
				PLANT=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
			}
		}
	}
}
