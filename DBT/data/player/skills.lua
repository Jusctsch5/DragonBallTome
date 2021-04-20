-- Need a dummy skill
new_skill{ name = "" desc = "" __index__ = 0 }

-- Skill definitions
new_skill
{
	define_as = "SKILL_STRENGTH"
	name = "Strength"
	desc =
	{
		"Your physical strength.",
	}
}
new_skill
{
	define_as = "SKILL_INTELLIGENCE"
	name = "Intelligence"
	desc =
	{
		"Your intellect.",
	}
}
new_skill
{
	define_as = "SKILL_WILLPOWER"
	name = "Willpower"
	desc =
	{
		"Your ability to focus, and strength of will.",
	}
}
new_skill
{
	define_as = "SKILL_DEXTERITY"
	name = "Dexterity"
	desc =
	{
		"Your manual dexterity, agility, and general degree of coordination.",
	}
}
new_skill
{
	define_as = "SKILL_CONSTITUTION"
	name = "Constitution"
	desc =
	{
		"Your physical sturdiness and durability.",
	}
}
new_skill
{
	define_as = "SKILL_CHARISMA"
	name = "Charisma"
	desc =
	{
		"Your good looks and charm.",
	}
}
new_skill
{
	define_as = "SKILL_SPEED"
	name = "Speed"
	desc = 
	{
		"Your speed and grace of motion."
	}
}

new_skill
{
	define_as = "SKILL_MARTIALARTS"
	name = "Martial-Arts"
	desc =
	{
		"General martial arts ability and knowledge.",
	}
}

new_skill
{
	define_as = "SKILL_HAND"
	name = "Barehand"
	desc = "Ability to fight barehanded"
}

new_skill
{
	define_as = "SKILL_DODGE"
	name = "Dodging"
	desc = "Ability to dodge blows and bolts"
}

new_skill
{
	define_as = "SKILL_STEALTH"
	name = "Stealth"
	desc = "Ability to move unnoticed, silently"
}

new_skill
{
	define_as = "SKILL_WEAPONS"
	name = "Weapons"
	desc = "General ability to use melee weapons"
}

new_skill
{
	define_as = "SKILL_PARRYING"
	name = "Parrying"
	desc = "Ability to deflect incoming blows with your weapons"
}

new_skill
{
	define_as = "SKILL_PAIRED"
	name = "Paired"
	desc = "Ability to wield two melee weapons simultaneously"
}

new_skill
{
	define_as = "SKILL_MARKSMANSHIP"
	name = "Marksmanship"
	desc = "General ability to use firarms"
}
new_skill
{
	define_as = "SKILL_THROWING"
	name = "Throwing"
	desc = "Your skill at throwing things where you want them to go."
}

new_skill
{
	define_as = "SKILL_CHI"
	name = "Chi"
	desc = "Your ability to directly apply your spiritual energies"
}

new_skill
{
	define_as = "SKILL_CHI_OFFENSE"
	name = "Chi-Offense"
	desc = "Your ability to apply your energies offensively"
}

new_skill
{
	define_as = "SKILL_CHI_DEFENSE"
	name = "Chi-Defense"
	desc = {
		"Your ability to apply your enrgies defensively, and to",
		"redirect harmful energies away from you.",
	}
}

new_skill
{
	define_as = "SKILL_CHI_REGENERATION"
	name = "Chi-Regeneration"
	desc = "Your ability restore your energies"
}

new_skill
{
	define_as = "SKILL_CHI_GUNG"
	name = "Chi-Gung"
	desc = {
		"Your ability to understand and apply the more advanced energy",
		"concepts.",
	}
}

new_skill
{
	define_as = "SKILL_TECHNOLOGY"
	name = "Technology"
	desc = "General ability to understand and use high-tech items"
}

new_skill
{
	define_as = "SKILL_CONSTRUCTION"
	name = "Construction"
	desc = "Ability to build technological devices"
}

new_skill
{
	define_as = "SKILL_DISASSEMBLY"
	name = "Disassembly"
	desc = {
		"Ability to dismantle high-tech devices in order to scavange them",
		"for parts and learn how to build them. (Includes traps.)",
	}
}
new_skill
{
	define_as = "SKILL_PILOTING"
	name = "Piloting"
	desc = {
		"Piloting ability, for mech suits.",
	}
}

-- Skill tree
set_skill_tree
{
	["Strength"] = {}
	["Intelligence"] = {}
	["Willpower"] = {}
	["Dexterity"] = {}
	["Constitution"] = {}
	["Charisma"] = {}
	["Speed"] = {}
	["Martial-Arts"] =
	{
		["Barehand"] = {}
		["Dodging"] = {}
		["Stealth"] = {}
		["Weapons"] = {
			["Parrying"] = {}
			["Paired"] = {}
		}
	}
	["Marksmanship"] = {}
	["Throwing"] = {}
	["Chi"] = {
		["Chi-Offense"] = {}
		["Chi-Defense"] = {}
		["Chi-Regeneration"] = {}
		["Chi-Gung"] = {}
	}
	["Technology"] = {
		["Construction"] = {}
		["Disassembly"] = {}
		["Piloting"] = {}
	}
}
