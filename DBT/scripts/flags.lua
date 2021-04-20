-- Dragonball T: Flags

-- Weapon Flags
new_flag("BLADED")		-- Is it bladed? Can we sharpen and poison it?
new_flag("POISON_BLADE")	-- How much poison on the weapon?
new_flag("DIFFICULTY")		-- Difficulty penalty (used also by tech stuff)
new_flag("PAIRED")		-- Does it naturally pair?
new_flag("IAIDO")			-- Items with this flag consume zero time to equip/takeoff with Iaijutsu ability
new_flag("ENTANGLE")		-- Quickie check for whipchains and ropedarts
new_flag("REINFORCEABLE")	-- Armor that Joesephine can repair/reinforce
new_flag("SCISSORABLE")		-- Items that may be cut with scissors
new_flag("RIPOSTABLE")		-- Weapons that may riposte

-- Misc item flags
new_flag("USEABLE")		-- What does it activate for?
new_flag("TECH_REQUIRE")	-- How much tech skill do we need to use/equip it?
new_flag("EXPLOSIVE")		-- Things that tend to explode when unduly stressed
new_flag("BALLISTIC_PLATED")	-- It's ballistic armor. Does it have a ballistic plate installed?
new_flag("XP_MOD")		-- How much of an xp modifier does this item grant when equipped?
new_flag("BASHO_USES")		-- Number of uses remaining for the Basho fan
new_flag("SILLY_DEBUG")		-- What's the deal with steel ego?!?!?!?!
new_flag("PRICE_MOD")		-- Modify price of item
new_flag("DBT_DIGGER")		-- Tunneling doesn't need to be complicated
new_flag("WHITE_RICE")		-- For rice cookers
new_flag("BROWN_RICE")		-- For rice cookers
new_flag("VEHICLE_CHP")		-- Current vehicle hp
new_flag("VEHICLE_MHP")		-- Maximum vehicle hp
new_flag("AJISA_SEED")		-- I am an Ajisa seed
new_flag("DBT_EGO_VALUE")	-- Workaround to allows 'bad' egos to be worth less
new_flag("PORN")			-- Pornographic items

new_flag("EARTH_DRAGONBALL")	-- To differentiate
new_flag("NAMEK_DRAGONBALL")	-- To differentiate

-- Capsule Corp Item and Vehicle Flags
new_flag("CAPSULED")		-- What is its capsule state?
new_flag("CAPSULE_WEIGHT")	-- What is its pre-capsuled weight?
new_flag("INTEGRATED_CAPSULE")-- This object has an integrated capsule
new_flag("VEHICLE_SET_SPEED")	-- It's a vehicle. Does it override other speed settings? To what?
new_flag("CAPSULE_FLYER")	-- Special flight movement mode
new_flag("CAPSULE_BOAT")	-- Boats
new_flag("STORED_WATER")	-- Water stored in a capsule

new_flag("DBT_LEVEL_FEELING")	-- Level feeling function

-- School flags
new_flag("KARATE")
new_flag("KICKBOXING")
new_flag("KUNGFU")
new_flag("FENCING")
new_flag("SUMO")
new_flag("JUDO")
new_flag("BALLET")
new_flag("NINJUTSU")

new_flag("MARKSMANSHIP")

new_flag("TONY")
new_flag("TOFU")
new_flag("YMCA")
new_flag("FLIGHT_SCHOOL")

-- new_flag("TAEKWONDO")

-- Death dialogues
new_flag("DEATH_KAMI_RESCUE")
new_flag("DEATH_EMMA")

-- Enrollment flags. Used so as to not create coincidental conflicts.
-- I don't know if RACE_* numbers are made to be distinct from FLAG numbers
new_flag("ENROLL_ABBOT")
new_flag("ENROLL_ROSSHI")
new_flag("ENROLL_CRANE_HERMIT")
new_flag("ENROLL_NORTH_KAIO")
new_flag("ENROLL_KARIN")
new_flag("ENROLL_POPO")
new_flag("ENROLL_KAMI")
new_flag("ENROLL_TRUNKS")
new_flag("ENROLL_VEGITA")
new_flag("ENROLL_RADDITZ")
new_flag("ENROLL_SPLINTER")
new_flag("ENROLL_SHREDDER")
new_flag("ENROLL_YAJIROBE")
new_flag("ENROLL_URANAI_BABA")
new_flag("ENROLL_MUSASHI")
new_flag("ENROLL_BRIEFS_SOME")
new_flag("ENROLL_BRIEFS_ALL")
new_flag("ENROLL_MONK")

new_flag("SCHOOL_CLOSED")
new_flag("SCHOOL_OPEN")


-- Object Theme Helper Flags
new_flag("ITEM_ACCESSORY")	-- Misc low tech items like flashlights, watches and batteries that are allowed in most places
new_flag("ITEM_PLAIN")		-- Plain items
new_flag("ITEM_MARTIAL")	-- Martial Arts items
new_flag("ITEM_NINJA")		-- Ninja items
new_flag("ITEM_MILITARY")	-- Military items
new_flag("ITEM_POLICE")		-- Police items
new_flag("ITEM_NAMEK")		-- Namekian items
new_flag("ITEM_FRENCH")		-- French items
new_flag("ITEM_CHINESE")	-- Chinese items
new_flag("ITEM_JAPANESE")	-- Japanese items
new_flag("ITEM_TECHNO")		-- Tech items

-- Some new object found flags
new_flag("OBJ_FOUND_FANLADY")	-- Items given by the fan lady
new_flag("OBJ_FOUND_MARRIAGE")-- Wedding rings

-- Boolean Item flags used only by a single item because
-- It's easier to check for a flag than a TV/SV
new_flag("TRAP_DETECTOR")	-- Auto trap detection				(Used only by metal detector)
new_flag("FORTUNE")		-- Give a fortune when eaten			(Used only by fortune cookies)
new_flag("DRAGON_RADAR")	-- Issue Dragonball level-feelings		(Used only by Dragon Radar)
new_flag("TIMEPIECE")		-- Allow time checks				(Used only by watches)
new_flag("BINOCULARS")		-- Allows 'L' map viewing			(Used only by binoculars)
new_flag("GAME_BALANCE")	-- God of GB will destroy if over-used	(Used by: Ruby Slippers)
new_flag("WIDGET")		-- It's a widget!					(Used by: Widget)
new_flag("BE_BLIND")		-- Induces blindness when worn		(Used by: blindfold)
new_flag("VEHICLE_SPACESHIP")	-- It's a spaceship!				(Used by Freeza Spaceship)
new_flag("RYOGA")			-- No orientation effects			(Used by Ryoga's headband and umbrella)
new_flag("CHAINSAW")		-- Cut down trees					(Used by chainsaw)
new_flag("MAGLIGHT")		-- Allow use as a non-weapon			(Used by Maglight)
new_flag("KINTO_UN")		-- Ignore usual vehicle limitations		(Used by Kinto Un and Dark Kinto Un)

new_flag("DBT_THROWN")		-- ON_QUAFF flag function for missiles

-- Various flags for the refill/refual system
new_flag("FUEL_CAPACITY")	-- In practice: What to set FUEL to when refilling/refueling
new_flag("FUEL_REQUIRE")	-- Pointer to one of the below flags, what refills/refuels this item?
new_flag("FUEL_USE")		-- When should we deplete fuel?
new_flag("USE_ALWAYS")		-- Anytime PROCESS_WORLD happens, we use fuel (lites, for example)
new_flag("USE_IN_WATER")	-- (scuba gear...?)
new_flag("USE_IN_SPACE")	-- (eva suits...?)
new_flag("USE_NEVER")		-- Never deplete fuel based on movement (nailguns, for instance)
new_flag("BATERIE")		-- Battery
new_flag("FLAME_RETARDANT")	-- Flame retardant for fire extinguishers
new_flag("OXYGEN_TANK")		-- Oxygen for SCUBA gear, eva suits
new_flag("PROPANE")		-- Propane for Flame Thrower
new_flag("NAILS")			-- Nails for nailguns

-- If the item has to hit and dam bonuses, to what shall they be applied?
new_flag("WHEN_TO_DBCOMBAT_MOD")
new_flag("DBCOMBAT_MOD_HANDS")
new_flag("DBCOMBAT_MOD_WEAPONS")
new_flag("DBCOMBAT_MOD_MELEE")
new_flag("DBCOMBAT_MOD_GUNS")
new_flag("DBCOMBAT_MOD_ALWAYS")

-- Battle Jacket prevents ordinary melee combat modes
new_flag("TECHNO_COMBAT")

-- Marriage flags
new_flag("MARRIED_OOLONG")
new_flag("MARRIED_ROSSHI")
new_flag("MARRIED_VIDEL")
new_flag("MARRIED_CHICHI")
new_flag("MARRIED_BURUMA")

-- Monster Flags
new_flag("DBT_AI")		-- Which AI should this monster used when aggressive?
new_flag("DBT_AI_STATE")	-- Special AI handler for uniques with their own AI
new_flag("DBT_REFLECT")		-- Monster may reflect Chi bursts back on the attacker
new_flag("DBT_DEFLECT")		-- Even if reflection fails, monsters may still deflect Chi bursts away
new_flag("DROP_DRAGONBALL")	-- Base chance of dropping a drgagonball
new_flag("FORCE_NO_DBALL")	-- Don't drop a dragonball, no matter what, ever
new_flag("PLANT")			-- I am a plant!
new_flag("CAN_MAJIN")		-- This monster can pick up the Majin ego
new_flag("I_AM_A_BIRD")		-- Easier than checking body.bird
new_flag("I_AM_A_BADGER")	-- For Karin
new_flag("I_AM_A_HUMANOID")	-- Bipeds
new_flag("I_AM_A_LEVIATHAN")	-- Leviathan for Namek quest
new_flag("GRUMPY_WHEN_DEAD")	-- Use a generic non-response for this monster when dialoguing while dead
new_flag("KITTY")			-- I'm a kitty cat!!!
new_flag("NO_CATNIP")		-- I'm a kitty...but I don't do catnip.
new_flag("IMMORTAL")		-- Instead of ~MORTAL
new_flag("GREGORY")		-- Hack for Gregory quest
new_flag("KARMA")			-- For non-standard alignment handling
new_flag("GOTO_HEAVEN")		-- This monster appears in Heaven when dead
new_flag("GOTO_HELL")		-- This monster appears in Hell when dead
new_flag("REMOTE_DESTROY")	-- Affected by the Remote Stop Device
new_flag("NAMEKSEIJIN")		-- Identifies Nameks
new_flag("RED_RIBBON")		-- RRA Troops
new_flag("CORPSE_ANDROID")	-- percent chance of monster leaving a technomanceable android corpse
new_flag("DBT_FORCE_NO_CORPSE") -- For uniques who drop no corpse (battle jacket monters, for instance)

-- Fusion handling flags
new_flag("FUSION_GAIN")		-- When a monster is fused
new_flag("FUSION_LOSE")		-- When fusion ends
new_flag("FUSION_AB_KNOWN")	-- Ability is KNOWN
new_flag("FUSION_AB_UNKNOWN")	-- Ability is NOT known
new_flag("FUSION_AB_TEMP")	-- Ability it granted TEMPORARILY as a result of fusion

-- Player/Character Flags:
new_flag("PR_ALIGN")		-- Used to help display/redraw the characters alignment
new_flag("RES_BLIND")		-- For blindness resistance. Why isn't this auto created by dam_types?

-- FEAT flags
new_flag("PASS_BLOCKADE")	-- Hack: to disallow monsters to pass through terrain FEAT's

-- Dungeon Flags
new_flag("NO_TRAPS")		-- Forbid ALL generation of traps within this dungeon

-- Misc specific 'just to make it easier' flags
new_flag("AUTO_BUMP")		-- No valid WT opponent, bump to next round

-- This is to workaround the automatic transmission of
-- directional attack into chat for monsters that have
-- the chattable flag (We need to be able to both talk
-- to and attack the same monsters.)
new_flag("DBTCHAT")

-- Monster 'which planets may I spawn on?' flags
new_flag("ALLOW_IN_EARTH_SAFE")
new_flag("ALLOW_IN_EARTH_EASY")
new_flag("ALLOW_IN_EARTH_HARD")
new_flag("ALLOW_IN_EARTH_DEADLY")
new_flag("ALLOW_ON_KAIO_WORLD")
new_flag("ALLOW_ON_79")
new_flag("ALLOW_ON_PLANT")
new_flag("ALLOW_ON_NAMEK")
-- Monster 'which dungeons may I spawn in?' flags
new_flag("ALLOW_IN_SEWERS")
new_flag("ALLOW_IN_NINJA_SEWERS")
new_flag("ALLOW_IN_NINJA_WAREHOUSE")
new_flag("ALLOW_IN_FOOT_LAIR")
new_flag("ALLOW_IN_GERO_LAB")
new_flag("ALLOW_IN_DOJO")
new_flag("ALLOW_IN_MUSCLE_TOWER")
new_flag("ALLOW_IN_BLUE_LAIR")
new_flag("ALLOW_IN_RRA_SHQ")
new_flag("ALLOW_IN_RABBIT_HOLE")
new_flag("ALLOW_IN_SATAN_ESTATE")
new_flag("ALLOW_IN_TOURNAMENT")
new_flag("ALLOW_IN_VOLCANO")
new_flag("ALLOW_IN_FROZEN_WASTES")
new_flag("ALLOW_IN_URANAI")
new_flag("ALLOW_IN_TEMPLE")

-- Flags that I don't think are being used anymore
new_flag("TAUNT")
new_flag("DBTDBTWTF")
new_flag("BECOME_ZOMBIE")
new_flag("BECOME_NEVERMOVE")
new_flag("BECOME_RUNAWAY")
new_flag("ALIGN_GOOD")
new_flag("ALIGN_EVIL")

-----------------------------------------------------
-- Block copied to get tunneling to work
-----------------------------------------------------
 new_flag("DEAD_TREE_FEAT")

-- Substance flags
new_flag("SUBST_WEB")
new_flag("SUBST_ICE")
new_flag("SUBST_TREE")
new_flag("SUBST_SAND")
new_flag("SUBST_MAGMA")
new_flag("SUBST_QUARTZ")
new_flag("EASY_DIG")

memory.flag_misc_add{
	{FLAG_KILL_WALL, FLAG_DEAD_TREE_FEAT, "cut down living trees"},
	{FLAG_KILL_WALL, FLAG_SUBST_TREE, "cut down trees"},
	{FLAG_KILL_WALL, FLAG_SUBST_WEB, "cut down webs"},
	{FLAG_KILL_WALL, FLAG_SUBST_ICE, "bore through ice"},
	{FLAG_KILL_WALL, FLAG_SUBST_MAGMA, "bore through magma"},
	{FLAG_KILL_WALL, FLAG_SUBST_QUARTZ, "bore through quartz"},
	{FLAG_KILL_WALL, FLAG_SUBST_SAND, "dig through sand"},
	{FLAG_KILL_WALL, FLAG_EASY_DIG, "dig through soft material"},
}

constant("subst_desc",
{
	[FLAG_SUBST_ROCK]     = "rock",
	[FLAG_SUBST_GRANITE]  = "granite",
	[FLAG_SUBST_RUBBLE]   = "rubble",
	[FLAG_SUBST_WEB]      = "webs",
	[FLAG_SUBST_ICE]      = "ice",
	[FLAG_DEAD_TREE_FEAT] = "living trees",
	[FLAG_SUBST_TREE]     = "trees",
	[FLAG_SUBST_SAND]     = "sand",
	[FLAG_SUBST_MAGMA]    = "magma",
	[FLAG_SUBST_QUARTZ]   = "quartz",
})



-----------------------------------------------------
-- Stuff from the ToME module that I think I'm using:
-----------------------------------------------------
-- Player metabolism/hunger/food-usage
new_flag("METAB_PCT") -- Set metabolism to X% of normal
new_flag("NUTRI_MOD") -- Object supplies (or consumes) nutrition
new_flag("WALK_WATER")
new_flag("STORE")
new_flag("EVIL")
new_flag("GOOD")

------------------------------------------------------------
-- Leftover stuff from the ToME module that can probably go:
------------------------------------------------------------

new_flag("COORD")

-- CAN_PASS and PASS_WALL flags
new_flag("PASS_WEB")
new_flag("PASS_MOUNTAIN")
new_flag("PASS_ICE")
new_flag("PASS_TREES")

memory.flag_misc_add{
	{FLAG_PASS_WALL, FLAG_PASS_WEB, "pass through webs"},
	{FLAG_PASS_WALL, FLAG_PASS_MOUNTAIN, "climb over mountains"},
	{FLAG_PASS_WALL, FLAG_PASS_ICE, "pass through ice"},
	{FLAG_PASS_WALL, FLAG_PASS_TREES, "pass through trees"},
}

-- Probability travel
new_flag("PROB_TRAVEL_UPDOWN")
new_flag("PROB_TRAVEL_WALLS")
new_flag("PROB_TRAVEL_NO_UPDOWN")
new_flag("PROB_TRAVEL_NO_WALLS")
new_flag("PROB_TRAVEL_NO_END")

-- Fun things
new_flag("ABSORBED_LEVELS")


new_flag("ALLOW_IN_EVERYWHERE")
new_flag("ALLOW_IN_FOREST")
new_flag("ALLOW_IN_DESERT")
new_flag("ALLOW_IN_PLAIN")
new_flag("ALLOW_IN_CAVE")
new_flag("ALLOW_IN_SWAMP")
new_flag("ALLOW_IN_OCEAN")

new_flag("ORC")
new_flag("TROLL")
new_flag("GIANT")
new_flag("DRAGON")
new_flag("DEMON")
new_flag("UNDEAD")
new_flag("ANIMAL")
new_flag("THUNDERLORD")

-------------------------------------------------------
-- ESP flag descriptions
-------------------------------------------------------
constant("esp", {})
settag(esp, TAG_NAMESPACE) -- Tag as a namespace

esp.race_flags = {
	[FLAG_ANIMAL]          = true,
	[FLAG_DEMON]           = true,
	[FLAG_DRAGON]          = true,
	[FLAG_ELDRITCH_HORROR] = true,
	[FLAG_GIANT]           = true,
	[FLAG_NAZGUL]          = true,
	[FLAG_ORC]             = true,
	[FLAG_SPIDER]          = true,
	[FLAG_THUNDERLORD]     = true,
	[FLAG_TROLL]           = true,
}

function esp.desc_flag(flag)
	local name = get_flag_name(flag)

	if name == "ESP" then
		return "everything"
	end

	if starts_with(name, "ESP_") then
		name = strsub(name, 5, -1)
	end

	name = strlower(name)

	if esp.race_flags[flag] then
		return (name .. "s")
	end

	return (name .. " beings")
end
