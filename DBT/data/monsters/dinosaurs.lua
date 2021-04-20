-- Dragonball T: Dinosaurs

new_monster_races
{
	['d'] =
	{
		[1] =
		{
			name = "velociraptor"
			level = 33 rarity = 3
			desc = {
				"A relatively small, but lightning-fast dinosaur capable of running on two legs.",
				"With two taloned hands and powerful jaws, it packs quite a punch.",
			}
			body = default_body.quadruped
			color = color.GREEN
			speed = 22 life = {20,20} ac = 60
			aaf = 10 sleep = 10
			exp = 3000
			weight = 6000
			blows =
			{
				{"CLAW","SLASH",{4,4}},
				{"CLAW","SLASH",{4,4}},
				{"BITE","PIERCE",{6,6}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				ALLOW_IN_EARTH_DEADLY=true
				DROP_CORPSE=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
			}
		}
		[2] =
		{
			name = "tyranosaur"
			level = 33 rarity = 3
			desc = {
				"A massive, thirty ton beast with a mouth large enough to swallow you whole, these",
				"creatures are not to be taken lightly. Fortunately they are neither terribly fast,",
				"not very intelligent.",
			}
			body = default_body.quadruped
			color = color.UMBER
			speed = 15 life = {40,40} ac = 60
			aaf = 10 sleep = 10
			exp = 3000
			weight = 60000
			blows =
			{
				{"BITE","PIERCE",{6,12}},
			}
			flags =
			{
				AI=ai.DBT_ZOMBIE
				ALLOW_IN_EARTH_DEADLY=true
				DROP_CORPSE=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
			}
		}
	}
}

new_monster_races
{
	['b'] =
	{
		defaults =
		{
			body = default_body.bird
			flags = {
				I_AM_A_BIRD=true
				DROP_CORPSE=true
				ANIMAL=true
				DROP_THEME = getter.flags { THEME_TREASURE=100 }
				AI=ai.DBT_ZOMBIE
				FORCE_MAXHP=true
			}
		}
		[1] =
		{
			name = "pterodon"
			level = 25 rarity = 1
			desc = {
				"A massive, flying lizard, hungrily soaring through the skies searching prey large",
				"enough to be worth eating.",
			}
			color = color.LIGHT_UMBER
			speed = 40 life = {25,25} ac = 40
			aaf = 10 sleep = 0
			exp = 1000
			weight = 1
			blows =
			{
				{"BITE","PIERCE",{1,40}},
			}
			spells =
			{
			}
			flags =
			{
				ALLOW_IN_EARTH_DEADLY=true
				CAN_FLY=15
			}
		}
	}
}