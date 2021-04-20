-- Three types of corruption in Dragonball T:
-- Those gains by dying (if you're evil, you go
-- to Hell and gain horns, if you're good you go
-- to Heaven and get a halo), the Android
-- corruptions installed by Dr. Gero, and finally,
-- by drinking radioactive waste, you will have
-- a chance over time of beocming a mutant

-- Note: All stat mods from corruptions are
-- handled in a hook in dbtstuff so as to
-- be certain to execute after skills
-- modify stats
corruption.CORTEX_BOMB = corruption.new
{
-- 0	-- 0: Dinosaur or whale
	color		= color.GREEN
	name		= "Cortext Bomb"
	get_text	= "Gained: Cortex bomb"
	lose_text	= "Lost: Cortex bomb"
	desc		=
	{
		"You have a remote control explosive device inside your brain. Dr. Gero has the trigger",
		"mechanism, which he euphemistically refers to as a 'remote stop' device.'",
	}
	hooks       =
	{
	}
}

corruption.SYNTHETIC_MUSCLE = corruption.new
{
-- 1
	color		= color.GREEN
	name		= "Synthetic Muscle"
	get_text	= "Gained: Synthetic Muscle"
	lose_text	= "Lost: Synthetic Muslce"
	desc		=
	{
		"Your muscles have been replaced with a synthetic substitute. This makes you very strong,",
		"but no amount of working out will increase your strength. But, no amount of fatigue will",
		"ever drain you, either.",
		" * Strength is fixed at 60",
		" * Immunity to weakness",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
			-- flag_add_increase(player.intrinsic_flags[FLAG_SUST_STATS], flags[FLAG_SUST_STATS])
		end
	}
}
corruption.CORTEX_PROCESSOR = corruption.new
{
-- 2
	color		= color.GREEN
	name		= "Cortex Processor"
	get_text	= "Gained: Cortex Processor"
	lose_text	= "Lost: Cortex Processor"
	desc		=
	{
		"Your brain has been interfaced with a mirocomputer in the frontal lobe. This computer supplies",
		"you with vast stores of knowledge, and aids in perfoming complex calculations. This allows you",
		"to function as if superhumanly intelligent. Further, this computer is not affected by neurotoxins",
		"that hunder the functioning of the biological portion of your brain, rendering you immune to",
		"mind affecting chemicals and traps. However, you have grown dependant upon this interface, and",
		"it is not practical for you to increase your intelligence through ordinary learning. Further,",
		"the mechanization of portions of your brain renders you extremely susceptible to suggestion.",
		" * Intelligence is fixed at 60",
		" * Immunity to stupidity",
		" * Willpower -10",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
		end
	}
}

---
--- No Willpower Enhancement!
---

corruption.BRAINSTEM_PROCESSOR = corruption.new
{
-- 3
	color		= color.GREEN
	name		= "Brainstem Processor"
	get_text	= "Gained: Brainstem Processor"
	lose_text	= "Lost: Brainstem Processor"
	desc		=
	{
		"A small processor has been integrated with your brain stem to handle basal subconscious",
		"reactions. This has the effect of allowing you to ",
		" * Dexterity is fixed at 60",
		" * Immunity to ",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
		end
	}
}
corruption.TITANIUM_LACING = corruption.new
{
-- 4
	color		= color.GREEN
	name		= "Titanium Lacing"
	get_text	= "Gained: Titanium lacing"
	lose_text	= "Lost: Titanium lacing"
	desc		=
	{
		"Your skeleton and joints have been laced with liberal amounts of titanium. This makes your",
		"your entire body incredibly sturdy, and very difficult to damage. It also renders you immune",
		" * Constitution is fixed at 60",
		" * Immunity to wasting effects",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
			-- flag_add_increase(player.intrinsic_flags[FLAG_SUST_STATS], flags[FLAG_SUST_STATS])
		end
	}
}

---
--- No Charisma Enhencements!
---

corruption.ADRENAL_GLANDS = corruption.new
{
-- 5
	color		= color.GREEN
	name		= "Adrenal Glands"
	get_text	= "Gained: Adrenal Glands"
	lose_text	= "Lost: Adrenal Glands"
	desc		=
	{
		"Your adrenaline glands have been replaced with a synthetic substitute. This makes you very fast",
		"and makes you immune to lethargy. But, no amount of training will allow you to further increase",
		"your speed, and you are similarly immune to speed enhancements as drains.",
		" * Speed is fixed at 60",
		" * Immunity to haste and slow effects",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
		end
	}
}
corruption.CYBERNETIC_EYES = corruption.new
{
-- 6
	color		= color.GREEN
	name		= "Cybernetic eyes"
	get_text	= "Gained: Cybernetic eyes"
	lose_text	= "Lost: Cybernetic eyes"
	desc		=
	{
		"Your eyes have been replaced with cybernetic implants. This gives you extreme visual acuity, allows",
		"you to see in the dark, and renders you immune to blinding effects. You are also more easily able to",
		"see things that might otherwise have gone unnoticed.",
		" * Immunity to blindness",
		" * Nightvision (not implemented)",
		" * Perfect searching",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
			player.set_intrinsic(FLAG_RES_BLIND, true)
			player.set_intrinsic(FLAG_SEARCH_POWER, 100)
			player.set_intrinsic(FLAG_SEARCH_FREQ, 100)
			-- player.set_intrinsic(FLAG_SEE_INVIS, true) -- Ninja? Leviathan?
		end
	}
}
corruption.DERMAL_ARMOR = corruption.new
{
-- 7
	color		= color.GREEN
	name		= "Dermal Armor"
	get_text	= "Gained: Dermal Armor"
	lose_text	= "Lost: Dermal Armor"
	desc		=
	{
		"Your skin has been replaced with a flexible, synthetic metal exoskeleton which provides tremendous",
		"protection to your more delicate insides. But, being so obviously inhuman tends to make others",
		"distrustful and uncomfortable around you.",
		" * +50 Armor Class",
		" * -10 Charisma",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
			player.ac = player.ac + 50
		end
	}
}
corruption.MOTION_TRACKER = corruption.new
{
-- 8
	color		= color.GREEN
	name		= "Holographic Processor"
	get_text	= "Gained: Holographic processor"
	lose_text	= "Lost: Holographic processor"
	desc		=
	{
		"A holographic processor has been added to your cerebral cortext. This processor allows near",
		"perfect calculation of trajectories, giving you excellent aim.",
		" * Marksmanship skill 100",
		" * Throwing skill 100",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
			skill(SKILL_MARKSMANSHIP).value = 10000
			skill(SKILL_THROWING).value = 10000
		end
	}
}
corruption.MAGNETIC_PROPULSION = corruption.new
{
-- 9
	color		= color.GREEN
	name		= "Magnetic Propulsion"
	get_text	= "Gained: Magnetic propulsion"
	lose_text	= "Lost: Magnetic propulsion"
	desc		=
	{
		"A magnetic propulsion system has been installed along your vertebrae. This allows you to fly at will.",
		" * Allows flight",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
			player.set_intrinsic(FLAG_FLY, 30)
		end
	}
}
corruption.SATELLITE_INTERFACE = corruption.new
{
-- 10
	color		= color.GREEN
	name		= "Satellite Interface"
	get_text	= "Gained: Satellite interface"
	lose_text	= "Lost: Satellite interface"
	desc		=
	{
		"A telemetry system has been installed to allow constant communication with earthbound GPS and",
		"tracking satellites.",
		" * ",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
		end
	}
}
corruption.ABSORBTION_NODES = corruption.new
{
-- 11
	color		= color.GREEN
	name		= "Absorbtion Nodes"
	get_text	= "Gained: Absorbtion Nodes"
	lose_text	= "Lost: Absorbtion Nodes"
	desc		=
	{
		"Energy absorbtion nodes have been installed in the palms of your hands. These nodes",
		"allow you to collect energy for your own use.",
		" * 100 Strength absorbtion of incoming Chi Bursts",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
		end
	}
}
corruption.SOLAR_COLLECTOR = corruption.new
{
-- 12
	color		= color.GREEN
	name		= "Solar Collector"
	get_text	= "Gained: Solar Collector"
	lose_text	= "Lost: Solar Collector"
	desc		=
	{
		"Solar collection cells have been installed in your skin, allowing you to quickly",
		"replenish your energy so long as you are exposed to strong light.",
		" * Increased hp regeneration while in sunlight",
		" * Increased chi regeneration while in sunlight",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
		end
	}
}
corruption.BLOOD_FILTRATION = corruption.new
{
-- 13
	color		= color.GREEN
	name		= "Blood Filtration"
	get_text	= "Gained: Blood Filtration"
	lose_text	= "Lost: Blood Filtration"
	desc		=
	{
		"An internal blood filter has been installed in your body. This allows you to",
		"quickly clean your system of pollutants.",
		" * Immunity to poison",
	}
	hooks       =
	{
		[hook.CALC_BONUS] = function(key)
		end
	}
}

--Halo

-- Android:
-- * Motion Sensors
-- * Forearm Plasma Beam
-- * Beam Saber

-- Mutant:
