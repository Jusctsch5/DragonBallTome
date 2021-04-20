-- Abilities are hidden in dbtstuff.lua
-- For some reason, can't do it immediately after the definitions

-- NOTE: Costs are not used.
-- Dragonball T uses a custom enrollment system

new_ability
{
	define_as = "AB_MOTORCYCLIST"
	name = "Motorcycle Riding"
	desc =
	{
		"Ability to ride motorcycles.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_PILOT"
	name = "Pilot"
	desc =
	{
		"Ability to ride aeriel Capsule Craft.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_SKATING"
	name = "Skating"
	desc =
	{
		"Ability to use inline skates.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_SWIMMING"
	name = "Swimming"
	desc =
	{
		"Ability to swim in water too deep to wade through.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_JUMP"
	name = "Jump"
	desc =
	{
		"Well practiced dancers are able to jump quite far.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_FIRST_AID"
	name = "First Aid"
	desc =
	{
		"With knowledge of basic first aid, you'll be able to use first aid kits",
		"to patch up minor bruises and cuts.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_ACUPUNCTURE"
	name = "Acupuncture"
	desc =
	{
		"By inserting needles into strategic energy meridians in the body,",
		"an acupuncturist is able to cure secondary effects such as blindness,",
		"confusion, stat drain, etc. Be warned that this process is time",
		"consuming. Try to avoid being interupted during a session.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_MEDITATION"
	name = "Meditation"
	desc =
	{
		"Ability to swim enter into deep trance states that will double your Chi",
		"regeneration rate while resting.",
	}
	cost = 5
}

new_ability
{
	define_as = "AB_IMMOVABILITY"
	name = "Immovability"
	desc =
	{
		"Knowledge of this ability allows you to position, and leverage your body mass",
		"so as lower your center of gravity, thus rendering you virtually impossible to",
		"move, or be thrown. You can still move yourself, though at a reduced rate of speed.",
	}
	cost = 3
}
new_ability
{
	define_as = "AB_SNEAK"
	name = "Sneaking"
	desc =
	{
		"This ability allows you access to the 'sneaking' movment mode, which doubles",
		"your Stealth bonus from skill and equipment, at a slight reduction of speed.",
	}
	cost = 3
}

new_ability
{
	define_as = "AB_THROW"
	name = "Throw"
	desc =
	{
		"Knowledge of this ability allows you manipulate an opponents momentuum into",
		"any direction of your choosing, and maybe with an extra push, throw him to",
		"a nearby location of your choosing.",
		"NOT IMPLEMENTED",
	}
	cost = 3
}

new_ability
{
	define_as = "AB_ULTIMATE"
	name = "Ultimate Fighting"
	desc =
	{
		"Allows you to freely intermingle any and all attacks types: guns, weapons and barehand.",
	}
	cost = 5
}

new_ability
{
	define_as = "AB_SUSHI"
	name = "Martial Arts Sushi Eating Technique!"
	desc =
	{
		"Allows you to focus your energies into the act of eating with such power, skill and",
		"determination that you can eat without losing a round of action! Is that impressive",
		"or what!?!?!",
	}
	cost = 1
}

new_ability
{
	define_as = "AB_DOUBLE_ATTACK"
	name = "Double Attack"
	desc =
	{
		"Ability to use either or both hands for barehanded attacks and defense.",
		"Allows you to attack even when wielding a flashlight, or tool. Or, if both",
		"hands are free, gives you two barehanded attacks per round.",
	}
	cost = 5
}

new_ability
{
	define_as = "AB_BLOCKING"
	name = "Blocking"
	desc =
	{
		"This ability allows you to defend yourself equally as well as you fight.",
		"Skilled blockers will gain armor class equal to their barehanded fighting",
		"skill, for each hand engaged in barehanded combat.",
	}
	cost = 5
}

new_ability
{
	define_as = "AB_TAMESHIWARI"
	name = "Tameshiwari"
	desc =
	{
		"Generally starting with boads and bricks, practitioners skilled in the art",
		"of breaking are able to bash through doors, and will eventually learn to",
		"destroy sturdier objects, such as trees, and even solid stone. (Not Implemented)",
	}
	cost = 5
}

new_ability
{
	define_as = "AB_PAIRED_WEAPONS"
	name = "Paired Weapons"
	desc =
	{
		"Ability to use a weapon in each hand.",
	}
	cost = 7
}

new_ability
{
	define_as = "AB_RIPOSTE"
	name = "Riposte"
	desc =
	{
		"During an attack, the aggressor must briefly relinquish his defensive position.",
		"This ability allows you an opportunity to take advantage of this weakened",
		"position to possibly score an extra attack every time you parry a blow.", 
	}
	cost = 7
}

new_ability
{
	define_as = "AB_IAIJUTSU"
	name = "Iaijutsu"
	desc =
	{
		"The art of speedy and seamless sword drawing and sheating, this ability will",
		"allow you to swap weapons without consuming any energy, or time.",
	}
	cost = 1
}

new_ability
{
	define_as = "AB_BLEED_ATTACK"
	name = "Bleed Attack"
	desc =
	{
		"By targetting arteries and sensitive points in your opponents body, this ability",
		"allows you use any bladed weapon to cut foes and make them bleed.",
	}
	cost = 5
}

new_ability
{
	define_as = "AB_PAIRED_FIREARMS"
	name = "Paired Firearms"
	desc =
	{
		"Ability to fire on a single target with a gun in each hand",
		"NOT IMPLEMENTED (Wait...I think it is.)",
	}
	cost = 23
}

new_ability
{
	define_as = "AB_POINT_BLANK"
	name = "Point Blank Firing"
	desc =
	{
		"Ability to use guns at point blank range. In game terms, this allows",
		"you to use guns at melee range using the directional arrows instead of 'f.'",
	}
	cost = 7
}

new_ability
{
	define_as = "AB_MULTI_TARGET"
	name = "Multi Target Tracking"
	desc =
	{
		"Ability to track entirely different targets with a gun in each hand",
		"NOT IMPLEMENTED",
	}
	cost = 10
}

new_ability
{
	define_as = "AB_CHI_BURST"
	name = "Chi Burst"
	desc =
	{
		"A skilled practitioner of Chi-Gung is able to gather up his energies into",
		"a coherent ball, and hurl it at an opponent.",
	}
	cost = 11
}

new_ability
{
	define_as = "AB_HASTE"
	name = "Haste"
	desc =
	{
		"By compelling energies to compact into a tighter space of time, a Chi",
		"Gung practitioner is able to speed up his motions for a short time.",
	}
	cost = 6
}

new_ability
{
	define_as = "AB_BLINK"
	name = "Burst of Speed"
	desc =
	{
		"Like Haste, but with amazing amounts of energy compacted into a blink",
		"of an eye, a Chi master is able to rush a short distance at such speeds",
		"that to the naked eye they appear to be teleporting.",
	}
	cost = 9
}

new_ability
{
	define_as = "AB_AURA"
	name = "Battle Aura"
	desc =
	{
		"By directing the internal flow of energies outwards, one is able to",
		"generate a battle aura which provides both offensive and defensive",
		"qualities. The master may also gain additional benefits.",
	}
	cost = 15
}

-- Dragoball Z: Episode 257: The Battle with Yakon
new_ability
{
	define_as = "AB_LIGHT"
	name = "Aura Light"
	desc =
	{
		"While a Battle Aura generates light as a mere side effect of its",
		"radiation, it is possible to deliberately direct energy to the end,",
		"thus easily generating a tremendous brightness.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_POWER_DETECTION"
	name = "Power Detection"
	desc =
	{
		"This ability allows you to detect the presence of sources of Chi, effectively",
		"allowing you to know where potential opponents are from a distance.",
	}
	cost = 100
}

new_ability
{
	define_as = "AB_FLIGHT"
	name = "Flight"
	desc =
	{
		"With only a little practice, those able to generate a Battle Aura",
		"may learn to fly.",
	}
	cost = 5
}

new_ability
{
	define_as = "AB_CURE"
	name = "Cure Conditions"
	desc =
	{
		"By focusing the spiritual upon the physical, a skilled practitioner",
		"of Chi Regeneration may learn to instantly repair cuts wounds, draw",
		"poison from the body, as well as purge a variety of harmful effects.",
	}
	cost = 7
}

new_ability
{
	define_as = "AB_HEAL"
	name = "Healing"
	desc =
	{
		"A skilled practitioner of Chi Regeneration discovers that it is not difficult",
		"to use the spiritual energies to heal all physical defects and damage. Healing",
		"at an accelerated rate can be extremely draining, however.", 
	}
	cost = 5
}

new_ability
{
	define_as = "AB_REGENERATION"
	name = "Regeneration"
	desc =
	{
		"As it is the spirit which causes the physical form to naturally heal,",
		"by properly focusing, one may accelerate the rate at which the body",
		"heals itself", 
	}
	cost = 5
}

new_ability
{
	define_as = "AB_ABSORBTION"
	name = "Aura Absorbtion"
	desc =
	{
		"The Ascended Master may learn to completely absorb any and all physical",
		"damage with his Battle Aura, limited only by his level of Defensive skill.",
		"NOT IMPLEMENTED",
	}
	cost = 25
}

new_ability
{
	define_as = "AB_TELEPATHY"
	name = "Telepathy"
	desc =
	{
		"The Ascended Master learns that all that exists is united in spirit.",
		"Truly, we are all as one, and communication with any conscious being",
		"is merely connectign with the Self.",
	}
	cost = 3
}

new_ability
{
	define_as = "AB_TELEPORTATION"
	name = "Teleportation"
	desc =
	{
		"As all that is is united in fullness, ideas like distance and",
		"space are merely illusory concepts of the mind. A master is able to",
		"reach beyond the physical, and reinsert himself wherever he chooses.",
	}
	cost = 5
}

new_ability
{
	define_as = "AB_PLANETARY_TELEPORT"
	name = "Long Range Teleport"
	desc =
	{
		"As physical distance is merely an illusion, to one with proper understanding,",
		"it is no more difficult to teleport infinitely far than to take a single step.",
	}
	cost = 1
}

new_ability
{
	define_as = "AB_SPIRIT_BOMB"
	name = "Spirit Bomb"
	desc =
	{
		"Through proper focus, it is possible to gather energy from nearby monsters to be",
		"formed into a massive energy ball. Similar to Chi Burst, but the power of the blast",
		"is limited only by the amount of time you spend gathering energy.",
		"NOT IMPLEMENTED",
	}
	cost = 7
}

new_ability
{
	define_as = "AB_FUSION"
	name = "Fusion"
	desc =
	{
		"By performing a synergistic dance, knowledge of the art of fusion allows to martial",
		"artists to temporarily merge their bodies into a single, more powerful, form.",
		"EXPERIMENTAL",
	}
	cost = 100
}
