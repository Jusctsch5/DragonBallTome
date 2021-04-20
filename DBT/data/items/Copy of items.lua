-- First we declare some validators as to prevent stupid mistakes when
-- defining objects
constant("item_valid", {})
------------------------------------------------------------------------

-- I don't think firearms really need this error checking.
-- That's all this is, and not all guns work the same way
--[[
function item_valid.firearm(t)
	local bowname = "Bow " .. t.name .. " "

	-- The WEAPON flag would cause the bow's damage to be displayed,
	-- but bows have a multiplier and bonuses without any damage on
	-- their own
	assert(not t.flags.WEAPON, bowname .. "doesn't need WEAPON")

	-- SHOW_MODS forces the display of "(to_h, to_d)" when the item
	-- is known, even if both are 0
	assert(t.flags.SHOW_COMBAT_MODS,
		   bowname .. "needs SHOW_COMBAT_MODS")

	--assert(not t.flags.DAM, bowname .. "doesn't need DAM type")
	--assert(t.flags.AMMO, bowname .. "needs AMMO type")
	--assert(t.flags.BASE_RANGE, bowname .. "needs BASE_RANGE")
	--assert(t.flags.MULTIPLIER, bowname .. "needs MULTIPLIER")
	--assert(t.flags.AMMO_CAPACITY, bowname .. "needs AMMO_CAPACITY")
	--assert(t.flags.AMMO_CURRENT, bowname .. "needs AMMO_CURRENT")
end
register_item_kind_validator(item_valid.firearm, {TV_GUN, TV_LAUNCHER})
]]
------------------------------------------------------------------------
function item_valid.ammo(t)
	local ammoname = "Ammo " .. t.name .. " "

	assert(t.flags.AMMO_DAMAGE, ammoname .. "needs AMMO_DAM type")
end
register_item_kind_validator(item_valid.ammo, {TV_CLIP}, TV_MISSILE)
------------------------------------------------------------------------
function item_valid.armor(t)
	local armorname = "Armor " .. t.name .. " "

	assert(t.ac, armorname .. "needs ac")
end
register_item_kind_validator(item_valid.armor,
			     {TV_BOOTS, TV_GLOVES, TV_HEADPIECE,
				     TV_SHIELD, TV_CLOAK, TV_BODY_ARMOUR})
------------------------------------------------------------------------
function item_valid.weapon(t)
	local weapname = "Weap " .. t.name .. " "

	assert(t.flags.WEAPON, weapname .. "needs WEAPON")
	assert(t.flags.DAM, weapname .. "needs DAM type")
end
register_item_kind_validator(item_valid.weapon,
			     {TV_ENTANGLEARM, TV_POLEARM, TV_SMALLARM, TV_SWORDARM})
------------------------------------------------------------------------
function item_valid.scroll(t)
	local scrollname = "Scroll " .. t.name .. " "

	assert(t.flags.ON_READ, scrollname .. "needs ON_READ")
end
register_item_kind_validator(item_valid.scroll, {TV_PARCHMENT})
------------------------------------------------------------------------
function item_valid.potion(t)
	local potionname = "Potion " .. t.name .. " "

	assert(t.flags.BREAKAGE_CHANCE, potionname .. "needs BREAKAGE_CHANCE")
	assert(t.flags.ON_QUAFF, potionname .. "needs ON_QUAFF")
end
register_item_kind_validator(item_valid.potion, TV_POTION)
------------------------------------------------------------------------
function item_valid.gold(t)
	local goldname = "Gold " .. t.name .. " "

	assert(t.flags.GOLD_VALUE, goldname .. "needs GOLD_VALUE")
end
register_item_kind_validator(item_valid.gold, TV_GOLD)
------------------------------------------------------------------------
--[[
function item_valid.food(t)
	local foodname = "Food " .. t.name .. " "

	assert(t.flags.ON_EAT, foodname .. "needs ON_EAT")
	if type(t.flags.ON_EAT) == "function" then
		assert(t.flags.FOOD_VALUE, foodname .. "needs FOOD_VALUE")
	end
end
register_item_kind_validator(item_valid.food, TV_FOOD, TV_SUSHI)
]]
------------------------------------------------------------------------
function item_valid.lite(t)
	local litename = "Lite " .. t.name .. " "

	assert(t.flags.LITE, litename .. "needs LITE")
end
register_item_kind_validator(item_valid.lite, TV_LITE)
-----------------------------------------------------------------------------
new_item_kinds
{
	[TV_CAPSULE] =
	{
		color = color.LIGHT_BLUE
		name = "capsule"
		desc = { "A standard capsule", }
		symbol = '='
		defaults = {
			display = '&'
			color = color.RED
			flags = {}
		}
		[SV_CAPSULE_CAPSULE] = {
			name = "& capsule~"
			display = '=' color = color.RED
			desc =
			{
				"Capsule Corporation has become the world's leading producer of both civilian and military",
				"transportation through the invention of a miraculous device known as the 'capsule.' A capsule",
				"is a small electronic device which maintains a hyperdimensional space 'within' it.",
				"this allows object of great mass and size to be shruken down, and carried in one's pocket in a",
				"state of stasis. And, since the object itself exists in the extradimensional space, for all",
				"practical purposes it is weightless while contained in the capsule.",
			}
			flags = 
			{
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				USEABLE=1
				DISCIPLINE = 2
				INGRED1_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED2_QTY = 1
			}
			level = 50 weight = 1 cost = 10000
			allocation = { {50,3} }
		}
		[SV_CAPSULE_HOUSE] = {
			name = "& capsule house~"
			display = '=' color = color.YELLOW
			desc =
			{
				"A specially designed house with integrated capsule",
			}
			flags = 
			{
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				USEABLE=1
				DISCIPLINE = 2
				INTEGRATED_CAPSULE=true
				INGRED1_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED2_QTY = 1
			}
			level = 50 weight = 1 cost = 10000
			allocation = { {50,3} }
		}
	}
}
new_item_kinds
{
	[TV_POWER_ARMOR] =
	{
		color = color.LIGHT_BLUE
		name = "power armor"
		desc = { "A full bodied, powered suit of armor", }
		symbol = '['
		defaults = {
			display = '&'
			color = color.RED
			flags = {}
		}
		[SV_BATTLE_JACKET] = {
			name = "& battle jacket~"
			desc =
			{
				"A fourteen foot tall ridable mech. Unlike most powered armors, the battle jacket",
				"is piloted rather than worn. The pilot sits in a central cockpit and controls",
				"the motions of the suit via a complicated computer interface. This design offers",
				"many benefits, with the downside that it is not possible to use personal forms of",
				"melee combat.",
			}
			level = 60 weight = 40000 cost = 25000
			allocation = { {60, 1} }
			ac = 200
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=35
				DISCIPLINE=4
				TECHNO_COMBAT=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 99
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 99
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 20
				INGRED4_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED4_QTY = 20
				TECHNO_GAIN_AC = true
			    	RESIST = getter.array{
					[dam.FIRE] = 20
					[dam.COLD] = 20
					[dam.SLASH] = 20
					[dam.PIERCE] = 20
					[dam.SHARDS] = 50
					}
					IGNORE = getter.resists{
						COLD = true
						FIRE = true
						ELEC = true
					}
			}
		}
		[SV_HARDSUIT] = {
			name = "& hardsuit~"
			desc =
			{
				"Describe me",
			}
			level = 85 weight = 600 cost = 50000
			allocation = { {85,100} }
			ac = 200
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=45
				DISCIPLINE=4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 4
				INGRED2_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED2_QTY = 4
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 4
				TECHNO_GAIN_AC = true
			    	RESIST = getter.array{
					[dam.FIRE] = 33
					[dam.COLD] = 33
					[dam.SLASH] = 33
					[dam.PIERCE] = 33
					[dam.SHARDS] = 66
					}
					IGNORE = getter.resists{
						COLD = true
						FIRE = true
						ELEC = true
					}
			}
		}
	}
}
new_item_kinds
{
	[TV_VEHICLE] =
	{
		color = color.LIGHT_BLUE
		name = "vehicle"
		desc =
		{
			"Planes, trains, spaceships, bikes! Mechanical transport so you needn't hike!",
		}
		symbol = '&'
		defaults = {
			display = '&'
			color = color.WHITE
			flags = {
				WIELD_SLOT = INVEN_VEHICLE
				PARTY_OWNER = 0	-- Defaults to player
			}
		}
		[SV_MOTORCYCLE] = {
			name = "& motorcycle~"
			display = '&' color = color.RED
			desc =
			{
				"A lightning fast sport bike.",
			}
			flags = 
			{
				VEHICLE_SET_SPEED = 50
				LITE  = obvious(5)
				AGGRAVATE=true
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=0
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 8
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 8
				INGRED3_WHAT = TV_BULK_MATERIAL
				INGRED3_QTY = 8
				INGRED4_WHAT = TV_BULK_MATERIAL
				INGRED4_QTY = 8
				WIELD_PRE=function(obj)
					if not has_ability(AB_MOTORCYCLIST) and get_skill(SKILL_TECHNOLOGY) < 30 then
						message("You don't know how to ride.")
						return true, false
					elseif player.inventory[INVEN_WIELD][2] then
						message("Your right hand must be free to control the throttle and brake.")
						return true, false
					end
				end
				CAPSULED=true
				CAPSULE_WEIGHT=6500
				INTEGRATED_CAPSULE=true
			}
			level = 50 weight = 1 cost = 25000
			allocation = { {50,1} }
		}
--[[
		[SV_CAPSULE_HOVERBIKE] = {
			name = "& capsule hoverbike~"
			display = '&' color = color.LIGHT_BLUE
			desc =
			{
				"A magnetic levitation powered version of the standard capsule bike, this vehicle",
				"if fully capable of low-altitude flight.",
			}
			flags = 
			{
				VEHICLE_SET_SPEED = 50
				LITE  = obvious(5)
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=0
				DISCIPLINE = 4
				FLY = obvious(15)
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 8
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 8
				INGRED3_WHAT = TV_BULK_MATERIAL
				INGRED3_QTY = 8
				INGRED4_WHAT = TV_BULK_MATERIAL
				INGRED4_QTY = 8
				WIELD_PRE=function(obj)
					if not has_ability(AB_MOTORCYLCLIST) and get_skill(SKILL_TECHNOLOGY) < 30 then
						message("You don't know how to ride.")
						return true, false
					elseif player.inventory[INVEN_WIELD][2] then
						message("Your right hand must be free to control the throttle and brake.")
						return true, false
					end
				end
			}
			level = 50 weight = 6500 cost = 50000
			allocation = { {50,1} }
		}
]]
		[SV_CAPSULE_FLYER] = {
			name = "& capsule flyer~"
			display = '&' color = color.LIGHT_UMBER
			desc =
			{
				"A small, personal jet, manufactured and distributed by capsule corporation.",
				"This craft is able to transport several people, but requires piloting skill",
				"to fly.",
			}
			flags = 
			{
				VEHICLE_SET_SPEED = 30
				VEHICLE_CHP = 1000
				VEHICLE_MHP = 1000
				LITE  = obvious(5)
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=0
				DISCIPLINE = 4
				FLY = obvious(30)
				CAPSULE_FLYER=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 50
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 50
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 10
				INGRED4_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED4_QTY = 10
				WIELD_PRE=function(obj)
					if party.partied_with_flag(FLAG_PARTY_PILOT) > 0 then
						-- allow
					elseif has_ability(AB_PILOT) then
						-- allow
					elseif get_skill(SKILL_TECHNOLOGY) < 30 then
						message("You have no idea how to pilot this craft.")
						return true, false
					elseif player.inventory[INVEN_WIELD][1] or player.inventory[INVEN_WIELD][2] then
						message("Both hands must be free to pilot this craft")
						return true, false
					end
				end
				WIELD_POST = function(obj)
				end
				TAKEOFF_PRE = function(obj)
				end
				DROP_PRE = function(obj, item)
				end
				CAPSULED=true
				CAPSULE_WEIGHT=50000
				INTEGRATED_CAPSULE=true
			}
			level = 50 weight = 1 cost = 100000
			allocation = { {50,1} }
		}
		[SV_CAPSULE_SPACESHIP] = {
			name = "& capsule spaceship~"
			display = '&' color = color.BLUE
			desc =
			{
				"A capsule corp design spaceship, this craft is spherical, with four retractable",
				"landing pods.",
			}
			flags = 
			{
				VEHICLE_SET_SPEED = 0
				VEHICLE_SPACESHIP = true
				-- NEVER_MOVE=true
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=0
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 99
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 99
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 20
				INGRED4_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED4_QTY = 20
				WIELD_PRE=function(obj)
					if get_skill(SKILL_TECHNOLOGY) < 30 then
						message("You have absolutely no clue how to pilot this craft.")
						return true, false
					end
				end
				GET_PRE=function(obj)
					if not dball.capsuled(obj) then
						message("What...you're just going to put it in your pocket?")
						return true, false
					end
				end
			}
			level = 100 weight = 50000 cost = 1000000
			allocation = { {100,999} }
		}
--[[
		[SV_FREEZA_SPACESHIP] = {
			name = "& spaceship~"
			display = '&' color = color.BLUE
			desc =
			{
				"A massive spaceship, perhaps two hundred feet long.",
			}
			flags = 
			{
				VEHICLE_SET_SPEED = 0
				VEHICLE_SPACESHIP = true
				-- NEVER_MOVE=true
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=0
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 99
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 99
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 20
				INGRED4_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED4_QTY = 20
				WIELD_PRE=function(obj)
					if get_skill(SKILL_TECHNOLOGY) < 30 then
						message("You have absolutely no clue how to pilot this craft.")
						return true, false
					end
				end
				GET_PRE=function(obj)
					local capsule_state = obj.flags[FLAG_CAPSULED]
					if capsule_state[1] == false then
						message("What...you're just going to put it in your pocket?")
						return true, false
					end
				end
			}
			level = 100 weight = 50000 cost = 1000000
			allocation = { {100,999} }
		}
]]
	}

	[TV_BOOTS] =
	{
		color = color.WHITE
		name = "boots"
		desc =
		{
			"Protection for the feet",
		}
		symbol = '/'
		defaults = {
			display = '['
			color = color.SLATE
			flags = {
				WIELD_SLOT = INVEN_FEET
				CAPSULED=false
				CAPSULE_WEIGHT=0
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				SHOW_AC_MODS=true

				-- Ego hack
			    	-- RESIST = getter.array{[dam.COLD] = 0 [dam.SLASH] = 0 }
				-- STATS = getter.stats{[A_CHR] = 0}			
			}
		}
		[SV_TENNIS_SHOES] = {
			name = "& pair~ of tennis shoes"
			display = '[' color = color.SLATE
			desc =
			{
				"An ordinary pair of tennis shoes.",
			}
			level = 1 weight = 30 cost = 40
			allocation = { {0,1}, {3,1}, {5,1}, {7,1}, {9,1}, {11,1} }
			ac = 1
			flags = {
				RESIST = obvious(getter.resists{COLD=5})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=1
				ITEM_PLAIN=true
			}
		}
		[SV_LEATHER_BOOTS] = {
			name = "& pair~ of leather boots"
			display = '[' color = color.SLATE
			desc =
			{
				"A pair of leather boots. They provide good foot protection.",
				"protection",
			}
			level = 5 weight = 50 cost = 250
			allocation = { {5,1}, {7,1}, {9,1}, {11,1} }
			ac = 5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
				RESIST = getter.resists{COLD=10}
				REINFORCEABLE=true
				ITEM_PLAIN=true
			}
		}
		[SV_FIGHTING_BOOTS] = {
			name = "& pair~ of fighting boots"
			display = '[' color = color.SLATE
			desc =
			{
				"An extremely lightweight pair of boots, made of thick and tightly woven cloth.",
				"These boots provide approximately the same protection as leather, but are much",
				"lighter.",
			}
			level = 8 weight = 15 cost = 450
			allocation = { {14,3}, {16,2}, {18,1} }
			ac = 10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
				RESIST = getter.resists{COLD=5}
				REINFORCEABLE=true
				ITEM_MARTIAL=true
				SCISSORABLE=true
			}
		}
		[SV_STEEL_TOED_SHOES] = {
			name = "& pair~ of steel toed shoes"
			display = '[' color = color.SLATE
			desc =
			{
				"A heavy pair of workers shoes with steel inserts over the toes for extra",
				"protection. The extra weight does slow down movement, slightly.",
			}
			level = 8 weight = 70 cost = 450
			allocation = { {21,1}, {23,1}, {25,1}, {31,1}, {33,1}, {35,1}, {41,1}, {43,1}, {45,1}, {46,3}, {49,3} }
			ac = 10
			to_h = -3
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
			    	RESIST = getter.array{
					[dam.CRUSH] = 10
					[dam.COLD] = 10
					}
				REINFORCEABLE=true
				ITEM_PLAIN=true
				ITEM_MILITARY=true
			}
		}
		[SV_LEATHER_THIGH_BOOTS] = {
			name = "& pair~ leather thigh boots"
			display = '[' color = color.SLATE
			desc =
			{
				"A pair of black leather boots for women which extend halfway up the",
				"thighs. Though one might question the fashion sense of the designer, it",
				"happens that they do offer a good deal of protection to the legs.",
				"That protection comes at a cost, however, as these boots are both",
				"bulky and heavy.",
			}
			level = 12 weight = 70 cost = 750
			allocation = { {35,3}, {43,2}, {49,1} }
			ac = 15
			to_h = -3
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=7
			    	RESIST = getter.array{
					[dam.SHARDS] = 10
					[dam.SLASH] = 10
					[dam.COLD] = 15
					}
				REINFORCEABLE=true
				ITEM_PLAIN=true
			}
		}
		[SV_HIGH_HEELS] = {
			name = "& pair~ of high heels"
			display = '[' color = color.SLATE
			desc =
			{
				"A pair of women's shoes with a three inch heel. They're cold, uncomfortable,",
				"and difficult to walk in. But they look nice.",
			}
			level = 3 weight = 15 cost = 60
			allocation = { {3,2}, {5,1} }
			ac = 0
			to_h = -5
			flags = {
				ID_SKILL=SKILL_CHARISMA
				ID_VALUE=1
				STATS = getter.stats{[A_CHR] = 2}			
				ITEM_PLAIN=true
				WIELD_PRE=function(obj)
						if player.get_sex() ~= "Female" then
						message("You would look silly wearing women's shoes.")
						return true, false
					end
				end
			}		
		}
		[SV_NINJA_TABI] = {
			name = "& pair~ of ninja tabi"
			display = '[' color = color.SLATE
			desc =
			{
				"Made of black cloth, these flat-soled and split-toed boots are silent to",
				"walk in and provide excellent grip to the ground.",
			}
			level = 5 weight = 30 cost = 450
			allocation = { {16,1}, {18,1}, {20,1} }
			ac = 2
			flags = {
				ID_SKILL=SKILL_STEALTH
				ID_VALUE=5
				STEALTH=1
				RESIST = getter.resists{COLD=5}
				ITEM_NINJA=true
				REINFORCEABLE=true
				SCISSORABLE=true
			}
		}
		[SV_NINJA_CLIMBING_TABI] = {
			name = "& pair~ of ninja climbing tabi"
			display = '/' color = color.SLATE
			desc =
			{
				"Made of black cloth, these flat-soled and split-toed boots are silent to",
				"walk in and provide excellent grip to the ground. This pair also features",
				"a set of steel cleats on the soles to facilitate climbing.",
			}
			level = 15 weight = 70 cost = 900
			allocation = { {16,3}, {18,2}, {20,1} }
			ac = 2
			flags = {
				ID_SKILL=SKILL_STEALTH
				ID_VALUE=7
				STEALTH=1
				RESIST = getter.resists{COLD=5}
				ITEM_NINJA=true
				PASS_TREES=1
				PASS_CLIMB=1
				REINFORCEABLE=true
			}
		}
		[SV_BALLET_SLIPPERS] = {
			name = "& pair~ of ballet slippers"
			display = '[' color = color.SLATE
			desc =
			{
				"Tiny cloth shoes with straps rather than laces to keep them on. They don't",
				"offer anything in the way of protection, but they are rather quiet to walk in.",
			}
			level = 1 weight = 0 cost = 50
			allocation = { {5,3}, {7,2} }
			ac = 0
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=1
				STEALTH=1
				ITEM_FRENCH=true
			}
		}
		[SV_TOE_SHOES] = {
			name = "& pair~ of toe shoes"
			display = '[' color = color.SLATE
			desc =
			{
				"Only the French would have been capable of thinking up these masochistic",
				"medievil torture device in the form of a pair of hard plastic shoes with",
				"flat soles, intentionally designed to be just a little too small, and to",
				"crush your toes into a straight line.",
			}
			level = 3 weight = 3 cost = 125
			allocation = { {5,3}, {7,2} }
			ac = 1
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
				ITEM_FRENCH=true
			}
		}
		[SV_CROC_BOOTS] = {
			name = "& pair~ crocodile skin boots"
			display = '[' color = color.UMBER
			desc =
			{
				"As it is illegal to kill crocodiles in most places, these boots are very",
				"expensive. They are mostly a fashion accessory for the wealthy, but crocodile skin",
				"happens to be sturdy stuff, making these boots offer adequete protection.",
			}
			level = 17 weight = 40 cost = 1250
			allocation = { {9,3}, {12,2}, {22,2} }
			ac = 7
			flags = {
				RESIST = getter.resists{COLD=10}
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=7
				STATS = getter.stats{[A_CHR] = 2}			
				ITEM_PLAIN=true
			}
		}
		[SV_INLINE_SKATES] = {
			name = "& pair~ of inline skates"
			display = '[' color = color.LIGHT_RED
			desc =
			{
				"A pair of hard plastic boots with a set of four wheels, all in a line, mounted",
				"on the bottom. While they do take some skill to use effectively, they do allow",
				"you to move much more quickly. Unfortunately the hard plastic form of the boot",
				"does restrict the flexibility of your motions somewhat.",
			}
			level = 17 weight = 40 cost = 3000
			allocation = { {5,5}, {8,4}, {17,3} }
			ac = 3
			to_h = -10
			flags = {
				RESIST = getter.resists{COLD=10}
				SPEED = 7
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=11
				ITEM_PLAIN=true
				WIELD_PRE=function(obj)
					if not has_ability(AB_SKATING) and get_skill(SKILL_TECHNOLOGY) < 30 then
						message("You don't know how to use these.")
						return true, false
					end
				end
			}
		}
	}

	[TV_POLEARM] =
	{
		color = color.WHITE
		name = "polearms"
		desc =
		{
			"Polearms are long, heavy weapons designed for use in a formation.",
		}
		symbol = '/'
		defaults = {
			display = '/'
			color = color.SLATE
			flags = {
				WIELD_SLOT = INVEN_WIELD
				WEAPON = obvious(true)
				CAPSULED=false
				CAPSULE_WEIGHT=0
				IAIDO=true
				--WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_WEAPONS
			}
		}

		[SV_SPEAR] = {
			name = "& spear~"
			display = '/' color = color.SLATE
			desc =
			{
				"Long favored by the Chinese military as a cheap weapon, easily supplied",
				"to large numbers of infantry, as well as effective in field warfare, the",
				"spear is basically a long stick with a pointy piece of metal on one end.",
				"This particular spear is six feet long and features a decorative red",
				"tassle.",
			}
			level = 5 weight = 20 cost = 350
			allocation = { {15,3}, {17,2}, {19,1} }
			flags = {
				WEAPON  = true
				MUST2H  = obvious(true)
				DAM = getter.damages{PIERCE = {8,30}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=7
				BLADED=true
				POISON_BLADE=0
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_BO_STAFF] = {
			name = "& bo staff~"
			display = '/' color = color.YELLOW
			desc =
			{
				"This Japanese style staff is approximately six feet in length and",
				"constructed of solid mahoghany. It is heavy and inflexible.",
			}
			level = 5 weight = 70 cost = 300
			ac = 20
			allocation = { {14,2}, {16,1}, {18,1} }
			flags = {
				WEAPON  = true
				MUST2H  = obvious(true)
				DAM = getter.damages{CRUSH = {8,24}}
				DIFFICULTY = 3
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=5
				SHOW_AC_MODS=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_WAXWOOD_STAFF] = {
			name = "& waxwood staff~"
			display = '/' color = color.SLATE
			desc =
			{
				"This Chinese style staff is fast, lightweight and extremely flexible.",
				"Waxwood staves are made by carefully grooming and shaving an individual",
				"shoot of bamboo over many years to be straight and smooth.",
			}
			level = 18 weight = 12 cost = 250
			ac = 20
			allocation = { {14,2}, {16,1}, {18,1} }
			flags = {
				WEAPON  = true
				MUST2H  = obvious(true)
				DAM = getter.damages{ CRUSH = {8,24} }
				DIFFICULTY = 6
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=11
				SHOW_AC_MODS=true
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_THREE_SECTIONAL_STAFF] = {
			name = "& three sectional staff~"
			display = '/' color = color.SLATE
			desc =
			{
				"A most complicated weapon, the three sectional staff in comprised of",
				"three solid sections of solid wood connected by two sets of chains. They",
				"require two hands to weild, as well as uncommon skill to keep from whapping",
				"yourself in the head with them.",
			}
			level = 15 weight = 40 cost = 500
			ac = 20
			allocation = { {15,3}, {17,2}, {19,1} }
			flags = {
				WEAPON  = true
				MUST2H  = obvious(true)
				DAM = getter.damages{ CRUSH = {16,30} }
				DIFFICULTY = 12
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=15
				SHOW_AC_MODS=true
				RIPOSTABLE=true
				ITEM_CHINESE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_PUDAO] = {
			name = "& pudao"
			display = '/' color = color.SLATE
			desc =
			{
				"A short staff with a wide, flared and heavily curved blade on the end fully a",
				"foot and a half long. The pudao is a heavy weapon, designed to cleave through",
				"armor and ribcages, but the length of the pole makes it clear that it is intended",
				"for close quarters combat rather than field formations.",
			}
			level = 18 weight = 70 cost = 4000
			allocation = { {17,3}, {19,2} }
			flags = {
				WEAPON  = true
				MUST2H  = obvious(true)
				DAM = getter.damages{ SLASH = {40,60} }
				DIFFICULTY = 16
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=25
				BLADED=true
				POISON_BLADE=0
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}
	}

	[TV_ENTANGLEARM] =
	{
		color = color.WHITE
		name = "entangling weapons"
		desc =
		{
			"Any of various weapons intended to trip, entangle, or otherwise disable an opponent.",
		}
		symbol = '\\'
		defaults = {
			display = '\\'
			color = color.WHITE
			flags = {
				WIELD_SLOT = INVEN_WIELD
				WEAPON = obvious(true)
				CAPSULED=false
				CAPSULE_WEIGHT=0
				IAIDO=true
				ENTANGLE=true
				--WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_WEAPONS
			}
		}

		[SV_WHIPCHAIN] = {
			name = "& whipchain~"
			desc =
			{
				"Nine sections of thin steel tube connected in series by a a small set of chain",
				"with a handle on one end, and a sharp spike on the other. Whipchains are additionally",
				"adorned with a colorful set of silks on the pointed end. This serves a triplicate",
				"purpose: to make the path of the chain more visible to its wielder. To slow down",
				"its rate of spin to keep it easier to control. And, to allow the artist to fight",
				"not only with fierceness, but with beauty as well.", 
			}
			level = 20 weight = 50 cost = 1500
			allocation = { {17,3}, {19,2} }
			flags = {
				COULD2H = obvious(true)
				DAM = getter.damages{SLASH = {1,30}}
				DAM_COMPUTE = combat.COMPUTE_ROLL
				DIFFICULTY = 10
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=30
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_ROPE_DART] = {
			name = "& rope dart~"
			desc =
			{
				"Well renowned as the most difficult of all martial arts weapons to use effectively,",
				"the rope dart is, very simply, a heavy metal spike at the end of a length of rope.",
				"Typically, about ten to fifteen feet of rope. It can be used in any of several ways.",
				"The novice may use the rope dart very much like a whipchain: by swinging it. The initiate",
				"however, will learn to then interupt the motion of its swing to convert the spiral",
				"motion into a direct path, thus causing the spike to be fired as if from a gun. Finally",
				"the master will learn to deliberately entangle his body with the rope in such a way as",
				"to allow the dart to be 'fired' without needing to swing it at all. Watch Shanghai Noon",
				"for a good example of the use of a rope dart. Jackie Chan's horseshoe is essentially an",
				"improvised rope dart.",
			}
			color = color.LIGHT_DARK
			level = 30 weight = 70 cost = 4000
			allocation = { {17,5}, {19,3} }
			flags = {
				MUST2H = obvious(true)
				DAM = getter.damages{PIERCE = {20,80}}
				DAM_COMPUTE = combat.COMPUTE_ROLL
				DIFFICULTY = 30
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=50
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}

	}

	[TV_SMALLARM] =
	{
		color = color.WHITE
		name = "smallarm"
		desc =
		{
			"Any of a number of small martial arts weapons.",
		}
		defaults = {
				flags = 
					{
					WIELD_SLOT=INVEN_WIELD
					CAPSULED=false
					CAPSULE_WEIGHT=0
					IAIDO=true
					--WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_WEAPONS
					}
				}

		[SV_KUBOTAN] = {
			name = "& kubotan"
			display = '/' color = color.SLATE
			desc =
			{
				"This small four inch stick attaches easily to any keychain and is heavily",
				"promoted as an ideal women's self defense weapon. Their actual usefulnes is",
				"questionable.",
			}
			level = 5 weight = 5 cost = 100
			allocation = { {0,1}, {3,1}, {5,1}, {5,1}, {9,1}, {13,1}, {15,1}, {20,1}, {30,1} }
			flags = {
				WEAPON  = true
				DAM = getter.damages{PIERCE = {1,4}}
				DIFFICULTY = 1
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=1
				ITEM_MARTIAL=true
				ITEM_PLAIN=true
			}
		}

		[SV_KNIFE] = {
			name = "& knife~"
			display = '/' color = color.SLATE
			desc =
			{
				"A simple knife. This particular one is well built, with the blade extending",
				"through the entire length of the handle."
			}
			level = 5 weight = 20 cost = 160
			allocation = { {0,2}, {3,2}, {5,1}, {7,1}, {9,1}, {13,1}, {15,1}, {20,1}, {30,1} }
			flags = {
				WEAPON  = true
				DAM = getter.damages{PIERCE = {1,6}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=5
				BLADED=true
				POISON_BLADE=0
				ITEM_MARTIAL=true
				ITEM_PLAIN=true
			}
		}
		[SV_ESCRIMA_STICK] = {
			name = "& escrima stick~"
			display = '/' color = color.SLATE
			desc =
			{
				"A small, thin stick about two feet in length. Not used like clubs, but",
				"rather, held towards the middle of their length, and traditionally used",
				"in pairs."
			}
			level = 10 weight = 20 cost = 200
			allocation = { {5,1}, {7,1}, {9,1}, {11,1} }
			flags = {
				WEAPON  = true
				PAIRED = obvious(true)
				DAM = getter.damages{CRUSH = {1,10}}
				DIFFICULTY = 5
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=15
				ITEM_MARTIAL=true
			}
		}
		[SV_NUNCHAKU] = {
			name = "& nunchaku"
			display = '/' color = color.SLATE
			desc =
			{
				"Who hasn't heard of nunchaku? (Or, 'nunchucks' to the American audience.)",
				"These weapons consist of a pair of just-over-a-foot long sticks connected",
				"at the ends by about four inches of chain, or rope. They may be used, simply,"
				"as clubs, or, by making use of the flexible chain, one may whip them around",
				"in a variety of manners. Some useful, others just pretty.",
			}
			level = 10 weight = 30 cost = 500
			allocation = { {11,1}, {13,1}, {15,1}, {17,1}, {19,1}, {21,1} }
			flags = {
				WEAPON  = true
				COULD2H = obvious(true)
				DAM = getter.damages{CRUSH = {1,16}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=7
				ITEM_CHINESE=true  -- Japanese name, but the chinese use these things too
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_MINI_BUTTERFLY_KNIFE] = {
			name = "& mini butterfly knife~"
			display = '/' color = color.SLATE
			desc =
			{
				"More for show than actual fighting, the 'mini' butterfly knife features a",
				"tiny blade housed between two rotating pieces of metal connected to the base",
				"of the blade. In one position, the blade is completely housed between the two",
				"pieces. In the other position, the blade is exposed and the two pieces serve",
				"together as a handle. Altogether a silly, flimsy weapon, but nonetheless",
				"extremely effective for impressing the clueless.",
			}
			level = 5 weight = 8 cost = 100
			allocation = { {0,2}, {3,1}, {5,1}, {5,1}, {9,1} }
			flags = {
				WEAPON  = true
				DAM = getter.damages{SLASH = {1,4}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=3
				BLADED=true
				POISON_BLADE=0
				ITEM_MARTIAL=true
				ITEM_PLAIN=true
			}
		}
		[SV_SAI] = {
			name = "& sai"
			display = '/' color = color.SLATE
			desc =
			{
				"Originally a farming implement used by Okinawaan peasents, sai are Essentially a",
				"small, handheld pitchforks with elongated middle spikes. They may be used to toss",
				"hay, break up ground, poke holes to plant seeds, and a variety of other tasks. They",
				"are not bladed, and their points are generally blunt. In battle, they are generally",
				"used as extensions of ones hands, or as clubs, or as protective shields for the",
				"forearms. Traditionally, masters of the sai were renownwed for the ability to catch",
				"the sword of a samurai between the points, and then leverage a pair of sai together",
				"to snap the blade in two. This requires tremendous wrist strength.",
			}
			level = 12 weight = 60 cost = 350
			allocation = { {9,5}, {11,3}, {14,2}, {16,1}, {18,1}, {20,1} }
			flags = {
				WEAPON  = true
				PAIRED = obvious(true)
				DAM = getter.damages{CRUSH = {2,10}}
				DIFFICULTY = 4
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=12
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_TONFA] = {
			name = "& tonfa"
			display = '/' color = color.SLATE
			desc =
			{
				"About a foot and a half long squarish stick, about two inches thick, with a handle",
				"separating about a fifth of the stick from the rest of its length. Traditionally",
				"used in pairs, tonfa act as hand extensions and forearms shields. They are extremely",
				"simple to use, and given a pair, the average open-handed karate practitioner will quickly",
				"discover that he can still perform 90% of the material that is familiar with while holding",
				"a pair of tonfa."
			}
			level = 10 weight = 20 cost = 350
			allocation = { {9,5}, {11,3}, {14,2}, {16,1}, {18,1}, {20,1} }
			flags = {
				WEAPON  = true
				PAIRED = obvious(true)
				DAM = getter.damages{CRUSH = {1,10}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=5
				RIPOSTABLE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_NINJA_CLAW] = {
			name = "& ninja claw~"
			display = '/' color = color.SLATE
			desc =
			{
				"A pair of deadly sharp claws fitted to the back of a forearm glove.",
			}
			level = 15 weight = 40 cost = 1000
			allocation = { {17,3}, {19,2}, {21,1} }
			flags = {
				WEAPON  = true
				PAIRED = obvious(true)
				DAM = getter.damages{SLASH = {1,20}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=25
				BLADED=true
				POISON_BLADE=0
				ITEM_NINJA=true
			}
		}
		[SV_SANJOBANG] = {
			name = "& sanjobang"
			display = '/' color = color.SLATE
			desc =
			{
				"The Korean version of, and essentially identical to the Japanese nuchaku,",
				"these weapons consist of a pair of just-over-a-foot long sticks connected",
				"at the ends by about four inches of chain, or rope. They may be used, simply,"
				"as clubs, or, by making use of the flexible chain, one may whip them around",
				"in a variety of manners. Some useful, others just pretty.",
			}
			level = 12 weight = 30 cost = 500
			allocation = { {11,1}, {13,1}, {15,1}, {17,1}, {19,1}, {21,1} }
			flags = {
				WEAPON  = true
				COULD2H = obvious(true)
				DAM = getter.damages{CRUSH = {1,16}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=5
				ITEM_MARTIAL=true
			}
		}
		[SV_KAMA] = {
			name = "& kama"
			display = '/' color = color.TAN
			desc =
			{
				"One of many weapons used by Okinaawan peasants against the samurai, kama are",
				"essentially foot long sticks with curved blades roughly eight inches long on the",
				"end. They are difficult to use well, but lend themselves well to paired combat.", 
			}
			level = 12 weight = 14 cost = 700
			allocation = { {11,3}, {14,2}, {16,1}, {18,1}, {20,1} }
			flags = {
				WEAPON  = true
				PAIRED = obvious(true)
				DAM = getter.damages{PIERCE = {4,16}}
				DIFFICULTY = 12
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=12
				BLADED=true
				POISON_BLADE=0
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_IRON_FAN] = {
			name = "& iron fan~"
			display = '/' color = color.TAN
			desc =
			{
				"A heavy, metal fan constructed of perhaps a dozen thin sheets of metal layered",
				"tightly on top of one another with a thin, but sturdy cloth connecting them. When",
				"collapsed the fan appears as a more or less solid piece of metal about 1 inch thick,",
				"two inches wide, and just under a foot long. The fan extends out to a full half-circle,",
				"revealing a beautiful design across its nearly two feet diamater. Iron fans are",
				"extremely complicated to use, and require tremendous wrist strength, but are surprisingly",
				"versitile weapons, which may strike block, parry, and may even be thrown.",
			}
			level = 30 weight = 40 cost = 1200
			allocation = { {17,3}, {19,2}, {21,2} }
			ac = 10
			flags = {
				WEAPON  = true
				SHOW_AC_MODS=obvious(true)
				PAIRED = obvious(true)
				DAM = getter.damages{ CRUSH = {10,30}}
				DIFFICULTY = 16
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=12
				BLADED=true
				POISON_BLADE=0
				RIPOSTABLE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_HAMMER] = {
			name = "& rounded hammer~"
			display = '/' color = color.ANTIQUE_WHITE
			desc =
			{
				"A simple, two foot long pole with a wide metal sphere on the end, chinese",
				"rounded hammers could possibly be mistaken for a unusually large European",
				"style maces, with fully six to eight inch diameter balls. Not merely different",
				"in size, these hammers are usually wielded in pairs, and a skilled user will",
				"generally use them to thrust and parry at least as much as bash.",
			}
			level = 30 weight = 60 cost = 12000
			allocation = { {15,5}, {17,3}, {19,2}, {21,2} }
			ac = 10
			flags = {
				WEAPON  = true
				PAIRED = obvious(true)
				DAM = getter.damages{ CRUSH = {10,40}}
				DIFFICULTY = 8
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=12
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_TASER] = {
			name = "& taser gun~"
			display = '/' color = color.SLATE
			desc =
			{
				"A small handheld taser, highly promoted for women's defense. ",
				"button and touch your opponent with it.",
			}
			level = 4 weight = 10 cost = 400
			allocation = { {4,2}, {7,2}, {11,2}, {21,1}, {25,1}, {33,1}, {45,1} }
			flags = {
				WEAPON  = true
				DAM = getter.damages{STUN = {1,10}}
				DIFFICULTY = 1
				TECH_REQUIRE = 5
				FUEL  = obvious(10)
				FUEL_CAPACITY = 10
				FUEL_REQUIRE = FLAG_BATERIE
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 1
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=5
				ITEM_PLAIN=true
			}
		}
		[SV_STUN_BATON] = {
			name = "& stun baton~"
			display = '/' color = color.SLATE
			desc =
			{
				"An electrified stick, about a foot and a half long. Intended for crowd control.",
			}
			level = 7 weight = 20 cost = 1200
			allocation = { {21,2}, {25,2}, {33,2}, {45,2} }
			flags = {
				WEAPON  = true
				DAM = getter.damages{STUN = {2,20}}
				DIFFICULTY = 3
				TECH_REQUIRE = 12
				FUEL  = obvious(10)
				FUEL_CAPACITY = 10
				FUEL_REQUIRE = FLAG_BATERIE
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 1
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=7
				ITEM_PLAIN=true
				ITEM_MILITARY=true
			}
		}
		[SV_CATTLE_PROD] = {
			name = "& cattle prod~"
			display = '/' color = color.SLATE
			desc =
			{
				"An electrified stick, about a foot and a half long. Similar to a stun baton,",
				"but this one is powerful enough to herd cattle.",
			}
			level = 12 weight = 20 cost = 4000
			allocation = { {25,3}, {33,2}, {45,1} }
			flags = {
				WEAPON  = true
				DAM = getter.damages{STUN = {3,30}}
				DIFFICULTY = 3
				TECH_REQUIRE = 30
				FUEL  = obvious(10)
				FUEL_CAPACITY = 10
				FUEL_REQUIRE = FLAG_BATERIE
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 1
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=10
				ITEM_PLAIN=true
				ITEM_MILITARY=true
			}
		}
	}

	[TV_SWORDARM] =
	{
		color = color.WHITE
		name = "swords"
		desc =
		{
			"Sharp, long, and deadly.",
		}
		symbol = '|'
		defaults = {
			display = '|' color = color.SLATE
			flags = {
				WIELD_SLOT = INVEN_WIELD
				WEAPON = true
				CAPSULED=false
				CAPSULE_WEIGHT=0
				IAIDO=true
				-- WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_WEAPONS
			}
		}

		[SV_BUTTERFLY_KNIFE] = {
			name = "& butterfly knife~"
			display = '|' color = color.LIGHT_DARK
			desc =
			{
				"True Chinese butterfly knives, these paired blades are over a foot long,",
				"and twice as thick as a butcher knife. The handles of the blades are",
				"flattened on one side so that the two knives may easily be held together",
				"in one hand, as well as being used as paired weapons."
			}
			level = 10 weight = 14 cost = 450
			allocation = { {13,2}, {15,1}, {17,1}, {19,1}, {21,1} }
			flags = {
				WEAPON = true
				PAIRED = obvious(true)
				DAM = getter.damages{SLASH = {1,10}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=11
				BLADED=true
				POISON_BLADE=0
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_STRAIGHTSWORD] = {
			name = "& straightsword~"
			display = '|' color = color.LIGHT_DARK
			desc =
			{
				"These lightweight Chinese swords require tremendous skill and grace to",
				"be used effectively. In battle they can be beautiful as well as deadly.",
				"The tassles and balls extended nearly a foot from its handle serve not",
				"only to lend beauty, but also to provide balance to the weight of the",
				"sword itself as it glides through the air."
			}
			level = 18 weight = 22 cost = 2000
			allocation = { {15,4}, {17,3}, {19,2}, {21,1} }
			flags = {
				WEAPON = true
				DAM = getter.damages{SLASH = {10,16}}
				DIFFICULTY = 6
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=22
				BLADED=true
				POISON_BLADE=0
				RIPOSTABLE=true
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_SABRE] = {
			name = "& sabre~"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A brutal rather than elegant weapon, the Chinese sabre is an excellent",
				"choice for quickly shredding a dozen opponents into ribbons. The blade is",
				"lightly curved, and the handle features a pair of brightly colored tassles",
				"so that its weilder may retain an air of flair while he mauls his foes."			}
			level = 18 weight = 24 cost = 2000
			allocation = { {15,4}, {17,3}, {19,2}, {21,1} }
			flags = {
				WEAPON = true
				DAM = getter.damages{SLASH = {4,30}}
				DIFFICULTY = 5
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=25
				BLADED=true
				POISON_BLADE=0
				RIPOSTABLE=true
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_WAKAZASHI] = {
			name = "& wakazashi"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A small curved blade, approximately two feet in length, these weapons were",
				"traditionally used as a secondary deflecting blade in conjunction with the",
				"katana by Samurai before the practice was outlawed when Tokyo became the",
				"capitol of Japan."
			}
			level = 13 weight = 24 cost = 750
			allocation = { {13,3}, {15,2}, {17,1}, {19,1}, {21,1} }
			flags = {
				WEAPON = true
				DAM = getter.damages{SLASH = {4,16}}
				DIFFICULTY = 3
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=17
				BLADED=true
				POISON_BLADE=0
				RIPOSTABLE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_SHINAI] = {
			name = "& shinai"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A sword, loosely speaking, crafted of several strips of bamboo",
				"bound together and padded at the end, generally used by kendo",
				"initiates before they are trusted with the more dangerous bokken.",
				"Heavy and awkward, the shinai may hurt a lot to be whacked with",
				"but it is difficult to genuinely damage anyone.",
			}
			level = 2 weight = 40 cost = 250
			allocation = { {11,1}, {13,1}, {15,1}, {17,1}, {19,1}, {21,1} }
			flags = {
				MUST2H  = obvious(true)
				WEAPON = true
				DAM = getter.damages{CRUSH = {1,10}}
				DIFFICULTY = 4
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=4
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_BOKKEN] = {
			name = "& bokken"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A wooden sword crafted of solid mahogany, the bokken as the",
				"standard practice sword of a kendo practitioner. While not",
				"very effective against armour, it is still hefty enough to",
				"crack a skull.",
			}
			level = 10 weight = 30 cost = 700
			allocation = { {11,2}, {13,2}, {15,1}, {17,1}, {19,1}, {21,1} }
			flags = {
				COULD2H  = obvious(true)
				WEAPON = true
				DAM = getter.damages{CRUSH = {1,16}}
				DIFFICULTY = 2
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=7
				RIPOSTABLE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_KATANA] = {
			name = "& katana"
			display = '|' color = color.WHITE
			desc =
			{
				"A sword of medium length, with a one-sided, smoothly curved blade.",
				"The katana is notoriously sharp, and ancient artisans are reported",
				"to have tested a new blade by dropping a piece of silk over it, to",
				"see not only if it was cut in two...but also whether it cut cleanly, or",
				"with frayed edges. The katana is intended to be used with both hands,",
				"but those with especially strong wrists may be able to weild it in one.",
				"Historically, the katana was made especially famous by the swordsman",
				"Miyamoto Musashi, who developed the art of using the it paired",
				"with the wakazashi."
				
			}
			level = 35 weight = 22 cost = 15000
			allocation = { {21,3}, {24,2}, {33,1}, {43,1} }
			flags = {
				COULD2H  = obvious(true)
				VORPAL = true
				WEAPON = true
				DAM = getter.damages{SLASH = {20,60}}
				DIFFICULTY = 8
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=45
				BLADED=true
				POISON_BLADE=0
				RIPOSTABLE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
				ITEM_MILITARY=true
			}
		}

		[SV_TAI_CHI_SWORD] = {
			name = "& tai chi sword~"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A long, double bladed and symmetrical sword."
			}
			ac = 20
			level = 15 weight = 40 cost = 8000
			allocation = { {17,2}, {20,2} }
			flags = {
				WEAPON = true
				SHOW_AC_MODS = true
				DAM = getter.damages{SLASH = {10,50}}
				DIFFICULTY = 5
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=30
				BLADED=true
				POISON_BLADE=0
				RIPOSTABLE=true
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}

		[SV_NINJA_TO] = {
			name = "& ninja-to"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A medium length single-bladed straight sword. It is a favorite weapon of",
				"ninja everywhere. It is called a 'to' blade because of the shape of the",
				"tip: a straight 45 degree angle rather than a smoothed curve.",
			}
			level = 15 weight = 18 cost = 3000
			allocation = { {17,2}, {20,2} }
			flags = {
				WEAPON = true
				DAM = getter.damages{SLASH = {10,25}}
				DIFFICULTY = 3
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=30
				BLADED=true
				POISON_BLADE=0
				ITEM_NINJA=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
				RIPOSTABLE=true
			}
		}
		[SV_HOOK_SWORD] = {
			name = "& hook sword~"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"The hooksword features an encased handguard with pointy spikes, and",
				"a curved, bladed 'hook' instead of a point at the end, sized just large",
				"enough to grab onto an opponents sword and disarm him.",
			}
			ac = 20
			level = 22 weight = 40 cost = 12000
			allocation = { {17,3}, {20,2} }
			flags = {
				WEAPON = true
				PAIRED = obvious(true)
				SHOW_AC_MODS = true
				DAM = getter.damages{SLASH = {10,35}}
				DIFFICULTY = 8
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=50
				BLADED=true
				POISON_BLADE=0
				RIPOSTABLE=true
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_EPEE] = {
			name = "& epee~"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A slender, flexible sword with a point, but lacking a blade. Fighting with",
				"an epee is all about speed and reflexes, featuring primarily fast wrist and",
				"body motions, with damage done exclusively by the tip of the blade, never its",
				"length.",
			}
			level = 7 weight = 18 cost = 500
			allocation = { {20,1} }
			flags = {
				WEAPON = true
				DAM = getter.damages{PIERCE = {1,16}}
				DIFFICULTY = 7
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=17
				RIPOSTABLE=true
				ITEM_FRENCH=true
			}
		}
		[SV_RAPIER] = {
			name = "& rapier~"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A French fencing weapon, a rapier is fairly flexible, and features a symmetrical",
				"blade roughly a inch across. While heavier, and not as fast or graceful as epee,",
				"a apier is able to perform both slashing and piercing attacks.",
			}
			level = 12 weight = 24 cost = 750
			allocation = { {20,1} }
			flags = {
				WEAPON = true
				DAM = getter.damages{SLASH = {5,20}}
				DIFFICULTY = 5
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=12
				BLADED=true
				POISON_BLADE=0
				RIPOSTABLE=true
				ITEM_FRENCH=true
			}
		}
		-- Base Item Type for the Jagged-Edged Sword of King Mouse
		[SV_JAGGED_SWORD] = {
			name = "& jagged-edged sword~"
			display = '|' color = color.LIGHT_WHITE
			desc =
			{
				"A massive sword with a heavily notched blade.",
			}
			level = 4 weight = 200 cost = 20000
			allocation = { {100,999} }
			flags = {
				WEAPON = true
				INSTA_ART = true
				SPECIAL_GENE = true
				MUST2H = obvious(true)
				DAM = getter.damages{SLASH = {10,60}}
				DIFFICULTY = 20
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=30
				BLADED=true
				POISON_BLADE=0
			}
		}
		-- Base Item Type for the Artifact Umbrellas
		[SV_FIGHTING_UMBRELLA] = {
			name = "& umbrella~"
			display = '~' color = color.LIGHT_UMBER
			desc =
			{
				"An umbrella.",
			}
			level = 1 weight = 40 cost = 4000
			allocation = { {100, 999} }
			flags = {
				WEAPON = true
				INSTA_ART = true
				SPECIAL_GENE = true
				DAM = getter.damages{CRUSH = {1,20}}
				DIFFICULTY = 1
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=30
				RIPOSTABLE=true
			}
		}
		-- Base Item Type for Trunks' sword
		[SV_TWO_HANDED] = {
			name = "& two handed sword~"
			display = '|' color = color.LIGHT_BLUE
			desc =
			{
				"A two handed sword.",
			}
			level = 100 weight = 1000 cost = 20000
			allocation = { {100, 999} }
			flags = {
				WEAPON = true
				MUST2H = obvious(true)
				INSTA_ART = true
				SPECIAL_GENE = true
				DAM = getter.damages{SLASH = {20,200}}
				DIFFICULTY = 1
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=50
				BLADED=true
				POISON_BLADE=0
			}
		}
		-- Base Item Type for the Z Sword
		[SV_Z_SWORD] = {
			name = "& massive sword~"
			display = '|' color = color.LIGHT_BLUE
			desc =
			{
				"A massive sword.",
			}
			level = 100 weight = 10000 cost = 100000
			allocation = { {100, 999} }
			flags = {
				WEAPON = true
				MUST2H = obvious(true)
				INSTA_ART = true
				SPECIAL_GENE = true
				DAM = getter.damages{SLASH = {1,1000}}
				DIFFICULTY = 100
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=60
				BLADED=true
				POISON_BLADE=0
			}
		}
	}

	[TV_GUN] =
	{
		color = color.UMBER
		name = "guns"
		desc = "Used for firing bullets."
		symbol = '}'
		defaults = {
			flags = {
				WIELD_SLOT = INVEN_WIELD
				AMMO = TV_CLIP
				AMMO_LOADED = FLAG_AMMO_NONE
				AMMO_CLASS = FLAG_ATYPE_LOOKUP_PROJ
				SHOW_COMBAT_MODS = true
				MISSILE_WEAPON = true
				IAIDO=true
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_GUNS
				TECHNO_GAIN_TH = true
				CAPSULED=false
				CAPSULE_WEIGHT=0
				SILENCED=1
				ITEM_MILITARY=true
			}
			display = '}'
			color = color.UMBER
		}

		[SV_PISTOL] = {
			name = "& pistol~"
			desc = {
				"A small hand gun."
			}
			level = 21 weight = 80 cost = 700
			allocation = { {21,1}, {23,1}, {26,1}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				MULTIPLIER = 2
				BASE_RANGE = 5
				AMMO_CAPACITY = obvious(12)
				AMMO_CURRENT = obvious(0)
				AMMO_AOE=FLAG_AOE_BOLT
				AMMO_VOLLEY=1
				DIFFICULTY = 2
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=5
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
			}
		}

		[SV_RIFLE] = {
			name = "& rifle~"
			desc = {
				"A hunting rifle."
			}
			level = 24 weight = 100 cost = 1400
			allocation = { {23,1}, {26,1}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				MULTIPLIER = 3
				BASE_RANGE = 10
				MUST2H = obvious(true)
				AMMO_CAPACITY = 6
				AMMO_CURRENT = 0
				AMMO_AOE=FLAG_AOE_BOLT
				AMMO_VOLLEY=1
				SCOPABLE=1
				DIFFICULTY = 2
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=10
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
			}
		}

		[SV_MACHINE_GUN] = {
			name = "& machine gun~"
			desc = {
				"This rifle may be fired in either single round, or fully autmatic modes. To",
				"alternate modes ues the 'u'se item command. When in single round",
			}
			level = 26 weight = 120 cost = 7000
			allocation = { {26,1}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				MULTIPLIER = 3
				BASE_RANGE = 8
				MUST2H = obvious(true)
				AMMO_CAPACITY = 50
				AMMO_CURRENT = 0
				AMMO_AOE=FLAG_AOE_SPRAY
				WILDLY_INACCURATE=true
				AMMO_VOLLEY=5
				USEABLE = 5
				DIFFICULTY = 4
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=22
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 3
			}
		}
	}
	[TV_SHOTGUN] =
	{
		color = color.UMBER
		name = "shotguns"
		desc = "A short range, high damage weapon"
		symbol = '}'
		defaults = {
			flags = {
				WIELD_SLOT = INVEN_WIELD
				AMMO = TV_SHOTGUN_ROUND
				AMMO_LOADED = FLAG_AMMO_NONE
				AMMO_CLASS = FLAG_ATYPE_LOOKUP_PROJ
				AMMO_AOE=FLAG_AOE_BOLT
				AMMO_VOLLEY=999
				SHOW_COMBAT_MODS = true
				MISSILE_WEAPON = true
				IAIDO=true
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_GUNS
				TECHNO_GAIN_TH = true
				CAPSULED=false
				CAPSULE_WEIGHT=0
				SILENCED=1
				ITEM_MILITARY=true
			}
			display = '}'
			color = color.UMBER
		}

		[SV_SINGLE_SHOTGUN] = {
			name = "& shotgun~"
			desc = {
				"An ordinary shotgun"
			}
			level = 21 weight = 80 cost = 700
			allocation = { {21,1}, {23,1}, {26,1}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				MULTIPLIER = 3
				BASE_RANGE = 5
				AMMO_CAPACITY = obvious(1)
				AMMO_CURRENT = obvious(0)
				DIFFICULTY = 1
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=5
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
			}
		}

		[SV_DOUBLE_SHOTGUN] = {
			name = "& double barreled shotgun~"
			desc = {
				"A shotguns with two barrels, each of which may be loaded with rounds."
			}
			level = 24 weight = 120 cost = 1400
			allocation = { {26,1}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				MULTIPLIER = 3
				BASE_RANGE = 5
				MUST2H = obvious(true)
				AMMO_CAPACITY = 2
				AMMO_CURRENT = 0
				DIFFICULTY = 1
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=10
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
			}
		}
	}
	[TV_LAUNCHER] =
	{
		color = color.UMBER
		name = "rocket launchers"
		desc = "Used for firing rockets"
		symbol = '}'
		defaults = {
			flags = {
				WIELD_SLOT = INVEN_WIELD
				AMMO = TV_MISSILE
				AMMO_LOADED = FLAG_AMMO_NONE
				AMMO_CLASS = FLAG_ATYPE_LOOKUP_PROJ
				AMMO_AOE=FLAG_AOE_BALL
				AMMO_VOLLEY=1
				SHOW_COMBAT_MODS = true
				MISSILE_WEAPON = true
				CAPSULED=false
				CAPSULE_WEIGHT=0
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_GUNS
				TECHNO_GAIN_TH = true
				ITEM_MILITARY=true
			}
			display = '}'
			color = color.UMBER
		}
		[SV_BAZOOKA] = {
			name = "& bazooka~"
			desc = {
				"A shoulder mounted rocket launcher."
			}
			color = color.LIGHT_UMBER
			level = 31 weight = 120 cost = 30000
			allocation = { {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				MULTIPLIER = 5
				BASE_RANGE = 12
				MUST2H = obvious(true)
				AMMO_CAPACITY = 1
				AMMO_CURRENT = 0
				SCOPABLE=1
				DIFFICULTY = 6
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=27
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 3
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 3
			}
		}
	}
	[TV_CLIP] =
	{
		color = color.UMBER
		name = "clips"
		desc =
		{
			"Ammunition for guns",
		}
		symbol = '{'
		defaults = {
			flags = {
				-- Not used anymore, right?
				BREAKAGE_CHANCE = 100
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_MILITARY=true
				RELOAD_TYPE=FLAG_RELOAD_FULL
			}
			display = '{'
			color = color.UMBER
		}

		[SV_STANDARD_ROUNDS] = {
			name = "& clip~"
			desc = {
				"A clip of standard ammunition"
			}
			level = 20 weight = 30 cost = 250
			allocation = { {21,1}, {23,1}, {26,1}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				AMMO=FLAG_AMMO_STANDARD
				AMMO_DAMAGE=getter.damages{BALLISTIC = {1,10}}
				AMMO_AOE=FLAG_AOE_BOLT
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=1
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {10,30}}
			}
		}
		[SV_AP_ROUNDS] = {
			name = "& AP clip~"
			desc = {
				"A clip of armor piercing ammunition, these rounds are designed more",
				"solidly than standard ammunition. Consequently they tend not to fragment",
				"when striking a target, thus providing more penetrating power, but",
				"tending to 'poke' rather than 'blow' holes, thus delivering less damage.",
			}
			level = 20 weight = 30 cost = 350
			allocation = { {21,3}, {23,2}, {26,2}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				AMMO=FLAG_AMMO_AP
				AMMO_DAMAGE=getter.damages{BALLISTIC = {1,8}}
				AMMO_AOE=FLAG_AOE_BOLT
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=8
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {10,30}}
			}
		}
	}
	[TV_SHOTGUN_ROUND] =
	{
		color = color.UMBER
		name = "shotgun rounds"
		desc =
		{
			"Ammunition for guns",
		}
		symbol = '{'
		defaults = {
			flags = {
				-- Not used anymore, right?
				BREAKAGE_CHANCE = 100
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_MILITARY=true
				RELOAD_TYPE=FLAG_RELOAD_ONE
			}
			display = '{'
			color = color.UMBER
		}

		[SV_SCATTERSHOT] = {
			name = "& scattershot~"
			desc = {
				"A shotgun round containing small shards of metal which spray for a shredding effect."
			}
			level = 20 weight = 30 cost = 150
			allocation = { {21,1}, {23,1}, {26,1}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				AMMO=FLAG_AMMO_STANDARD
				AMMO_DAMAGE=getter.damages{SHARDS = {1,10}}
				AMMO_AOE=FLAG_AOE_BALL
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=1
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
			}
		}
		[SV_LEAD_SLUG] = {
			name = "& lead slug~"
			desc = {
				"A clip of armor piercing ammunition, these rounds are designed more",
				"solidly than standard ammunition. Consequently they tend not to fragment",
				"when striking a target, thus providing more penetrating power, but",
				"tending to 'poke' rather than 'blow' holes, thus delivering less damage.",
			}
			level = 20 weight = 30 cost = 150
			allocation = { {21,3}, {23,2}, {26,2}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				AMMO=FLAG_AMMO_AP
				AMMO_DAMAGE=getter.damages{BALLISTIC = {1,20}}
				AMMO_AOE=FLAG_AOE_BOLT
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=8
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
			}
		}
	}

	[TV_MISSILE] =
	{
		color = color.UMBER
		name = "missiles"
		desc =
		{
			"Ammunition for missile launchers",
		}
		symbol = '{'
		defaults = {
			flags = {
				-- Not using BC, yes?
				BREAKAGE_CHANCE = 100
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_MILITARY=true
				RELOAD_TYPE=FLAG_RELOAD_ONE
			}
			display = '{'
			color = color.UMBER
		}

		[SV_STS_MISSILE] = {
			name = "& sts missile~"
			desc = {
				"A standard surface to surface missile, intended to be fired from any",
				"shoulder mounted rocket launcher.",
			}
			level = 31 weight = 80 cost = 5000
			allocation = { {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				AMMO=FLAG_AMMO_STANDARD
				AMMO_DAMAGE=getter.damages{BALLISTIC = {1,100}}
				AMMO_AOE=FLAG_AOE_BALL
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=27
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 3
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 3
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 3
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {50,100}}
			}
		}
		[SV_INCENDIARY_MISSILE] = {
			name = "& incendiary missile~"
			desc = {
				"These missiles contain an incendiary, rather than an explosive charge.",
				"Consequently, while their initial onslaught does far less damage, the",
				"napalm-like substance they spew will continue to deliver damage for",
				"quite some time.",
			}
			level = 31 weight = 80 cost = 5000
			allocation = { {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			flags = {
				AMMO=FLAG_AMMO_I
				AMMO_DAMAGE=getter.damages{FIRE = {1,50}}
				AMMO_AOE=FLAG_AOE_BALL
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=31
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 3
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 3
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 3
				TECHNO_EXPLODE = getter.damages{FIRE = {30,80}}
			}
		}
	}


	[TV_BODY_ARMOUR] =
	{
		color = color.SLATE
		name = "clothing"
		desc =
		{
			"Clothing worn on the body. It may provide protection.",
		}
		symbol = '('
		defaults =
		{
			display = '('
			color = color.SLATE
			flags =
			{
				WIELD_SLOT = INVEN_BODY
				CAPSULED=false
				CAPSULE_WEIGHT=0
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				-- Ego hack
			    	-- RESIST = getter.array{[dam.COLD] = 0 [dam.SLASH] = 0 }
				-- STATS = getter.stats{[A_CHR] = 0}			
			}
		}

		[SV_BATHROBE] = {
			name = "& bathrobe~"
			desc =
			{
				"For those going for the Arthur Dent look."
			}
			level = 1 weight = 30 cost = 35
			allocation = { {0,1}, {1,1}, {3,1}, {5,1} }
			ac = 2
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=1
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_PLAIN=true
			    	RESIST = getter.array{
						[dam.COLD] = 5
					}
			}
		}
		[SV_STREETCLOTHES] = {
			name = "& set~ of streetclothes"
			desc =
			{
				"Jeans and a t-shirt. Maybe not the best protection, and unfortunately the",
				"jeans make it a little hard to kick to the head, but at least you won't",
				"stand out in the crowd like that guy over there wearing the power armor, right?"
			}
			level = 1 weight = 50 cost = 60
			allocation = { {0,1}, {1,2}, {3,1}, {5,1}, {7,1}, {9,1} }
			ac = 5
			to_h = -1
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=2
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_PLAIN=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
					}
			}
		}
		[SV_LIGHTWEIGHT_GI] = {
			name = "& lightweight gi"
			desc =
			{
				"A traditional Japanese martial arts uniform made of ordinary white cloth."
			}
			level = 5 weight = 30 cost = 150
			allocation = { {10,1}, {13,1}, {15,1} }
			ac = 5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
			}
		}
		[SV_MEDIUMWEIGHT_GI] = {
			name = "& mediumweight gi"
			desc =
			{
				"A traditional Japanese martial arts uniform made of heavy cloth."
			}
			level = 10 weight = 50 cost = 400
			allocation = { {10,2}, {13,1}, {15,1} }
			ac = 10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=10
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
			}
		}
		[SV_HEAVYWEIGHT_GI] = {
			name = "& heavyweight gi"
			desc =
			{
				"A traditional Japanese martial arts uniform. This one is made of a thick,",
				"heavy canvas.",
			}
			level = 12 weight = 70 cost = 700
			allocation = { {10,3}, {13,2}, {15,1} }
			ac = 15
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=15
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
			}
		}
		[SV_BOXING_SHORTS] = {
			name = "& pair~ of boxing shorts"
			desc =
			{
				"A brightly colored set of boxing shorts. The neon orange makes it easier for",
				"you to go unseen. Really, it does. No...really! Ok, maybe not.",
			}
			level = 1 weight = 3 cost = 50
			allocation = { {0,1}, {1,1} }
			ac = 0
			flags = {
				STEALTH=-2
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=2
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_PLAIN=true
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
			}
		}
		[SV_TUTU] = {
			name = "& tutu~"
			desc =
			{
				"A tight, off-white Ballet outfit with a dress that flares out in parallel",
				"to the floor."
			}
			level = 1 weight = 30 cost = 150
			allocation = { {20,1} }
			ac = 2
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=3
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_FRENCH=true
				STATS = getter.stats{[A_CHR] = 2}			
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
				WIELD_PRE=function(obj)
						if player.get_sex() ~= "Female" then
						message("You would look silly wearing a woman's dress.")
						return true, false
					end
				end
			}		
		}
		[SV_QIPAO] = {
			name = "& qipao"
			desc =
			{
				"A beatiful Chinese ladies dress with Mandarin collar and frogs.",
			}
			level = 15 weight = 10 cost = 350
			allocation = { {15,3}, {17,3}, {19,2}, {21,2} }
			ac = 1
			flags = {
				ID_SKILL=SKILL_CHARISMA
				ID_VALUE=3
				ITEM_CHINESE=true
				REINFORCEABLE=true
				SCISSORABLE=true
				STATS = getter.stats{[A_CHR] = 2}			
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
				WIELD_PRE=function(obj)
						if player.get_sex() ~= "Female" then
						message("You would look silly wearing a woman's dress.")
						return true, false
					end
				end
			}		
		}
		[SV_TAI_CHI_UNIFORM] = {
			name = "& tai chi uniform~"
			desc =
			{
				"Comfortable leggings with a pleasant, formal jacket with a Mandarin",
				"collar. These uniforms are simple, yet retain an air of elegance.",
			}
			level = 5 weight = 10 cost = 250
			allocation = { {10,2}, {13,1}, {15,1} }
			ac = 7
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=6
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
					}
			}
		}
		[SV_TUXEDO] = {
			name = "& tuxedo"
			desc =
			{
				"Describe Me!",
			}
			level = 33 weight = 60 cost = 1250
			allocation = { {33,3}, {43,2} }
			ac = 8
			flags = {
				STATS = getter.stats{[A_CHR] = 3}
				ID_SKILL=SKILL_CHARISMA
				ID_VALUE=4
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_PLAIN=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
					}
			}
		}
		[SV_CAMOFLAGUE] = {
			name = "& camoflague outfit~"
			desc =
			{
				"A standard military camoflague uniform for front-line foot soldiers. It",
				"is made of heavy, protective cloth, with a design colored to allow you to",
				"blend in with your surroundings."
			}
			level = 21 weight = 80 cost = 550
			allocation = { {23,1}, {26,1}, {31,1}, {33,1}, {36,1}, {41,1}, {43,1}, {46,1} }
			ac = 10
			flags = {
				STEALTH=2
				ID_SKILL=SKILL_STEALTH
				ID_VALUE=12
				ITEM_MILITARY=true
				REINFORCEABLE=true
				SCISSORABLE=true
			    	RESIST = getter.array{
						[dam.COLD] = 5
					}
			}
		}
		[SV_NINJA_UNIFORM] = {
			name = "& ninja uniform~"
			desc =
			{
				"A full-bodied black ninja uniform. ",
			}
			level = 8 weight = 60 cost = 400
			allocation = { {16,1}, {18,1}, {20,1} }
			ac = 7
			flags = {
				STEALTH=2
				ID_SKILL=SKILL_STEALTH
				ID_VALUE=15
				ITEM_NINJA=true
				REINFORCEABLE=true
				SCISSORABLE=true
			    	RESIST = getter.array{
						[dam.COLD] = 5
					}
			}
		}
		[SV_DOBAK] = {
			name = "& dobak"
			desc =
			{
				"A traditional Korean martial arts uniform made of ordinary white cloth.",
				"Unlike the Japanese uniform, the Dobak slides over your head, and does not",
				"require a belt to keep it closed.",
			}
			level = 5 weight = 50 cost = 50
			allocation = { {5,3}, {10,3}, {15,3} }
			ac = 10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=7
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.COLD] = 5
					}
			}
		}
		[SV_SAMURAI_DO] = {
			name = "& samurai do"
			desc =
			{
				"A suit of rigid leather samurai armor, covering the torso, shoulders, and top of",
				"the thighs. It is heavy and limits movement somewhat, but provides excellent protection.",
			}
			level = 15 weight = 200 cost = 3000
			allocation = { {15,5}, {17,3}, {20,2} }
			ac = 35
			to_h = -10
			flags = {
			    	RESIST = getter.array{
						[dam.PIERCE] = 20
						[dam.SLASH] = 20
						[dam.SHARDS] = 20
					}
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=17
				ITEM_JAPANESE=true
				ITEM_MARTIAL=true
			}
		}
		[SV_FENCING_ARMOR] = {
			name = "& fencing armor~"
			desc =
			{
				"Made of thick, heavily padded cloth, and covering the arms and torso, this",
				"suit of armor is intended to protect the body during fencing matches and",
				"practice. While it does an excellent job of protecting from cuts, it does",
				"very little to eliminate the bruises resulting from the sheer force of",
				"a blow",
			}
			level = 12 weight = 70 cost = 1500
			allocation = { {20,1} }
			ac = 25
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=7
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_FRENCH=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
						[dam.PIERCE] = 20
					}
			}
		}
		[SV_FLAK_VEST] = {
			name = "& flak vest~"
			desc =
			{
				"A lightweight version of basic infantry armor, this vest protects the critical portions",
				"of the torso from low penetration ballistics, grenade fragmentation and incendiaries.",
				"Like most anti-ballistic armor, it is made of a high-tech cloth which is woven from",
				"extremely thin and durable plastic threading, and layered dozens of times to about a",
				"quarter inch thick",
			}
			level = 30 weight = 150 cost = 2000
			allocation = { {23,3}, {26,2}, {32,2}, {34,1}, {42,1}, {44,1} }
			ac = 20
			to_h = -5
			flags = {
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=20
				BALLISTIC_PLATED=1
				ITEM_MILITARY=true
				REINFORCEABLE=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
						[dam.FIRE] = 10
						[dam.BALLISTIC] = 30
						[dam.SHARDS] = 20
					}
			}
		}
		[SV_FLAK_JACKET] = {
			name = "& flak jacket~"
			desc =
			{
				"A mid range version of military infantry armor, this vest protects the torso, shoulders",
				"and upper arms from all manner of ballistics, incendiaries and grenade fragmentation.",
				"It is designed for firearms combat, however, not melee.",
				"Like most anti-ballistic armor, it is made of a high-tech cloth which is woven from",
				"extremely thin and durable plastic threading, and layered dozens of times to about a",
				"quarter inch thick.",
			}
			level = 34 weight = 200 cost = 3500
			allocation = { {32,2}, {34,1}, {42,1}, {44,1} }
			ac = 25
			to_h = -10
			flags = {
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=30
				BALLISTIC_PLATED=1
				ITEM_MILITARY=true
				REINFORCEABLE=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
						[dam.FIRE] = 20
						[dam.BALLISTIC] = 50
						[dam.SHARDS] = 30
					}
			}
		}
		[SV_MAWASHI] = {
			name = "& mawashi"
			desc =
			{
				"Traditional sumo grab, mawashi consist of approximately thirty feet of silk",
				"which is layered and worn around the pelvis.",
			}
			level = 10 weight = 90 cost = 100
			allocation = { {10,1}, {13,1}, {15,1} }
			ac = 2
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=1
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_JAPANESE=true
				-- ITEM_MARTIAL=true -- This is more traditional wear than martial arts wear
			}
		}
		[SV_SPARRING_GEAR] = {
			name = "& set~ of sparring gear~"
			desc =
			{
				"A full body suit of bright red foam padding. Suits of this sort tend to make",
				"for messay 'slap-fights' and only a very few schools actually use them.",
			}
			level = 13 weight = 30 cost = 300
			allocation = { {10,3}, {13,2}, {15,1}  }
			ac = 10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=12
				REINFORCEABLE=true
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.SLASH] = 10
						[dam.CRUSH] = 10
						[dam.COLD] = 10
						[dam.SHARDS] = 10
					}
			}
		}
		[SV_RADIATION_SUIT] = {
			name = "radiation suit"
			desc =
			{
				"A bright yellow, full body suit, gloves and filtration mask designed to protect",
				"you from the harmful effects of radioactive and poisonous gases.",
			}
			display = ')'
			color = color.YELLOW
			level = 65 weight = 50 cost = 2000
			allocation = { {43,5}, {80,2}, {90,1}, {100,1} }
			ac = 10
			to_h = -20
			to_d = -20
			flags = {
				TECH_REQUIRE = 30
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=16
				DISCIPLINE = 2
				ITEM_TECHNO=true
				ITEM_MILITARY=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
			    	RESIST = getter.array{
					[dam.COLD] = 50
					[dam.RADIATION] = 100
					[dam.POIS] = 100
					}
					IGNORE = getter.resists{
						COLD = true
						ELEC = true
					}
			}		
		}
		[SV_EVA_SUIT] = {
			name = "eva suit"
			desc =
			{
				"An EVA, or 'Extra-Vehicular-Activity' suit is a classic full bodied spacesuit",
				"worn by astronauts to protect them from the harsh conditions of space.",
				"Additionally, the suit can accomodate an oxygen tank to allow one to breath even",
				"in absolute vacuum.",
				"Wearing it renders one effectively immune to heat, cold, radiation and electrical",
				"effects, as well as provides a completely isolated atmosphere, thus protecting the",
				"wearer from all caustic and poisonous airbourne effects. The visor is designed to",
				"shield against even direct sunlight, unfiltered even by an atmosphere, and the",
				"material of the suit itself is designed to offer protection from micro-meteors",
				"travelling at high speed. In essence, it is the ultimate in protective armors.",
				"Unfortunately, however, it is extremely heavy, bulky, greatly limits one range",
				"of motion, and is far from ideal for wearing in normal gravity."
			}
			display = ')'
			color = color.WHITE
			level = 75 weight = 800 cost = 8000
			allocation = { {80,2}, {90,1}, {100,1} }
			ac = 100
			to_h = -100
			to_d = -100
			flags = {
				TECH_REQUIRE = 30
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=22
				MAGIC_BREATH = true
				ITEM_TECHNO=true
				RES_BLIND=obvious(true)
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_ALWAYS
				FUEL  = obvious(12000)
				FUEL_CAPACITY = 12000
				FUEL_REQUIRE = FLAG_OXYGEN_TANK
				SPEED = 12
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {100,1000}}
			    	RESIST = getter.array{
					[dam.FIRE] = 100
					[dam.COLD] = 100
					[dam.ELEC] = 100
					[dam.RADIATION] = 100
					[dam.POIS] = 100
					[dam.LITE] = 100
					[dam.SHARDS] = 33
					[dam.PIERCE] = 33
					[dam.SLASH] = 33
					[dam.CRUSH] = 33
					}
					IGNORE = getter.resists{
						COLD = true
						FIRE = true
						ELEC = true
					}
			}		
		}
		[SV_SAIYAJIN_ARMOR] = {
			name = "& saiyajin armor~"
			desc =
			{
				"A suit of extremely lightweight and durable metal, and are often worn by",
				"the fighting Saiyajin. This particular piece of armor covers the upper torso",
				"in its entirety, as well as the arms to the elbows, and the tops of the",
				"thighs. It offers unparalleled protection.",
			}
			level = 85 weight = 600 cost = 50000
			allocation = { {100,999} }
			ac = 100
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=45
				DISCIPLINE=4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 4
				INGRED2_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED2_QTY = 4
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 4
				TECHNO_GAIN_AC = true
			    	RESIST = getter.array{
					[dam.FIRE] = 33
					[dam.COLD] = 33
					[dam.SLASH] = 33
					[dam.PIERCE] = 33
					[dam.SHARDS] = 66
					}
					IGNORE = getter.resists{
						COLD = true
						FIRE = true
						ELEC = true
					}
			}
		}
	}

	[TV_HEADPIECE] =
	{
		color = color.SLATE
		name = "head gear"
		desc =
		{
			"Some headgear offers protection. Some headgear just helps you look groovy."
		}
		symbol = ')'
		defaults =
		{
			display = ')'
			color = color.SLATE
			flags =
			{
				WIELD_SLOT = INVEN_HEAD
				CAPSULED=false
				CAPSULE_WEIGHT=0
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_ALWAYS
				-- Ego hack
			    	-- RESIST = getter.array{[dam.COLD] = 0 [dam.SLASH] = 0 }
				-- STATS = getter.stats{[A_CHR] = 0}			
			}
		}

		[SV_SUNGLASSES] = {
			name = "& pair of sunglasses"
			desc =
			{
				"A pair of ordinary sunglasses, these will keep the sun from hurting your",
				"eyes too much."
			}
			level = 1 weight = 1 cost = 50
			allocation = { {0,1}, {1,1}, {3,1}, {5,1}, {21,1}, {26,1}, {31,1}, {36,1}, {41,1}, {46,1} }
			ac = 0
			flags = {
				ID_SKILL=SKILL_CHARISMA
				ID_VALUE=2
				RES_BLIND=true
				RESIST = getter.resists{LITE=50}
				ITEM_PLAIN=true
				ITEM_MILITARY=true
			}
		}
		[SV_MIRRORED_SHADES] = {
			name = "& pair of mirrored shades"
			desc =
			{
				"A trendy set of sunglasses, these will not only keep you seeing light, "
				"they'll also make sure others see you in the light as well.",
			}
			level = 5 weight = 1 cost = 150
			allocation = { {1,2}, {3,1}, {5,1}, {21,1}, {26,1}, {31,1}, {36,1}, {41,1}, {46,1} }
			ac = 0
			flags = {
				ID_SKILL=SKILL_CHARISMA
				ID_VALUE=4
				RES_BLIND=true
				RESIST = getter.resists{LITE=66}
				STATS = getter.stats{[A_CHR] = 1}
				ITEM_PLAIN=true
				ITEM_MILITARY=true
			}
		}
		[SV_HEADBAND] = {
			name = "& headband~"
			desc =
			{
				"This will keep blood and sweat from getting into your eyes.",
			}
			level = 1 weight = 1 cost = 10
			allocation = { {0,1}, {3,1}, {5,1}, {5,1}, {9,1}, {13,1}, {15,1}, {20,1} }
			ac = 0
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				REINFORCEABLE=true
				SCISSORABLE=true
				ID_VALUE=1
				ITEM_PLAIN=true
				ITEM_MARTIAL=true
			}
		}
		[SV_BLINDFOLD] = {
			name = "& blindfold~"
			desc =
			{
				"A thick cloth which may be tied around the head, covering the eyes.",
			}
			level = 1 weight = 1 cost = 50
			allocation = { {0,1}, {3,1}, {5,1}, {5,1}, {9,1}, {13,1}, {15,1}, {20,1} }
			ac = 0
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
				ITEM_PLAIN=true
				ITEM_MARTIAL=true
				REINFORCEABLE=true
				SCISSORABLE=true
				BE_BLIND=obvious(true)
				RES_BLIND=obvious(true)
				XP_MOD=10
				TAKEOFF_POST=function()
					player.update = player.update | PU_MONSTERS
					player.redraw[FLAG_PR_BLIND] = true
				end
			}
		}
		[SV_NINJA_HOOD] = {
			name = "& ninja hood~"
			desc =
			{
				"A black cloth mask with a single narrow slit for your eyes. They don't offer",
				"much in the way of protection, but they do make it easier to blend into shadows.",
				"They also tendto muffle the sound of your breathing, making your more silent.",
			}
			level = 8 weight = 1 cost = 60
			allocation = { {16,1}, {18,1}, {20,1} }
			ac = 0
			flags = {
				ID_SKILL=SKILL_STEALTH
				ID_VALUE=7
				REINFORCEABLE=true
				SCISSORABLE=true
				STEALTH=1
				ITEM_NINJA=true
			}
		}
		[SV_SAMURAI_HELM] = {
			name = "& samurai helm~"
			desc =
			{
				"A massive open-face steel headpiece with antler-like protrusions from the forehead.",
				"It's extremely heavy, and doesn't look entirely practical unless you're planning",
				"on fighting mounted, but all the same, three eights of an inch of steel amounts",
				"to some excellent protection.",
			}
			level = 12 weight = 200 cost = 1500
			allocation = { {15,5}, {17,3}, {20,2} }
			ac = 25
			to_h=-10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=22
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
					[dam.CRUSH] = 10
					[dam.SLASH] = 10
					[dam.SOUND] = 10
					[dam.SHARDS] = 10
					}
			}
		}
		[SV_MOTORCYCLE_HELMET] = {
			name = "& motorcycle helmet~"
			desc =
			{
				"An extremely lightweight helmet made of high-tech materials designed to keep",
				"your brains from spilling out. It provides excellent protection to the head",
				"but is a bit bulky.",
			}
			level = 12 weight = 40 cost = 2500
			allocation = { {21,1}, {26,1}, {31,1}, {36,1}, {41,1}, {46,1} }
			ac = 20
			to_h=-10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=12
				ITEM_PLAIN=true
			    	RESIST = getter.array{
					[dam.CRUSH] = 30
					[dam.SOUND] = 60
					[dam.SHARDS] = 10
					}
			}		
		}
		[SV_EARMUFFS] = {
			name = "& set~ of earmuffs"
			desc =
			{
				"A heavy-duty set of earmuffs maade from dense foam with rubber insulation to give",
				"it a tight fit. It will be very difficult to hear anything wearing these.",
			}
			level = 5 weight = 20 cost = 70
			allocation = { {0,1}, {1,1}, {3,1}, {5,1} }
			ac = 1
			flags = {
				RESIST = getter.resists{SOUND=66}
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=2
				ITEM_PLAIN=true
			}		
		}
		[SV_HOCKEY_MASK] = {
			name = "& hockey mask~"
			desc =
			{
				"A thin plastic face mask.",
			}
			level = 5 weight = 50 cost = 150
			allocation = { {6,1}, {8,1} }
			ac = 5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=4
				ITEM_PLAIN=true
				RES_BLIND=true
			    	RESIST = getter.array{
					[dam.SLASH] = 5
					[dam.PIERCE] = 5
					[dam.SHARDS] = 10
					}
			}		
		}
		[SV_INFANTRY_HELMET] = {
			name = "& infantry helmet~"
			desc =
			{
				"A thick steel helmet that covers only the top of the head, and straps on",
				"under ths chin. While intended solely to protect shrapnel and bullets from",
				"piercing your skull, all in all it offers decent protection, and doesn't",
				"interfere with movement at all.",
			}
			level = 16 weight = 40 cost = 350
			allocation = { {21,1}, {26,1}, {31,1}, {36,1}, {41,1}, {46,1} }
			ac = 10
			flags = {
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=5
				ITEM_MILITARY=true
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
			    	RESIST = getter.array{
					[dam.BALLISTIC] = 10
					[dam.SHARDS] = 10
					}
			}
		}
		[SV_GAS_MASK] = {
			name = "& gas mask~"
			desc =
			{
				"A thick rubber headpiece with airtight coverings for the face and eyes, as well",
				"as an air filtration system.",
			}
			level = 25 weight = 40 cost = 550
			allocation = { {21,3}, {26,2}, {31,1}, {36,1}, {41,1}, {46,1} }
			ac = 5
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=5
				ITEM_MILITARY=true
				RES_BLIND=true
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
			    	RESIST = getter.array{
					[dam.POIS] = 100
					}
			}
		}
		[SV_FENCING_MASK] = {
			name = "& fencing mask~"
			desc =
			{
				"A headpiece with a wire mesh covering the face, generally used by fencers",
				"to minimize risk of injury to the face and eyes while sparring.",
			}
			level = 20 weight = 40 cost = 1100
			allocation = { {20,1} }
			ac = 10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=15
				ITEM_FRENCH=true
			    	RESIST = getter.array{
					[dam.PIERCE] = 20
					}
			}
		}
	}

	[TV_CLOAK] =
	{
		color = color.LIGHT_BLUE
		name = 'jacket'
		desc = {
			"Jackets are worn over the top of regular clothing.",
		}
		symbol = '('
		defaults =
		{
			display = '('
			color = color.BLUE
			flags =
			{
				WIELD_SLOT = INVEN_OUTER
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=1
				CAPSULED=false
				CAPSULE_WEIGHT=0
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				-- Ego hack
			    	-- RESIST = getter.array{[dam.COLD] = 0 [dam.SLASH] = 0 }
				-- STATS = getter.stats{[A_CHR] = 0}			
			}
		}

		[SV_COTTON_CLOAK] = {
			name = "& cotton cloak~"
			desc =
			{
				"A relatively light cloak woven from cotton.",
			}
			level = 8 weight = 30 cost = 50
			allocation = { {6,1}, {8,1} }
			ac = 2
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=3
				ITEM_PLAIN=true
				REINFORCEABLE=true
				SCISSORABLE=true
			    	RESIST = getter.array{
					[dam.COLD] = 5
					}
			}
		}

		[SV_CAPE] = {
			name = "& cape~"
			desc =
			{
				"A decorative cape which attaches at the shoulders and hangs straight down.",
				"It's impressive looking, but doesn't offer much in the way of protection.",
			}
			level = 8 weight = 20 cost = 150
			allocation = { {4,1}, {6,1}, {8,1} }
			ac = 1
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				REINFORCEABLE=true
				SCISSORABLE=true
				ID_VALUE=3
				ITEM_PLAIN=true
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
			}
		}

		[SV_LEATHER_JACKET] = {
			name = "& leather jacket~"
			desc =
			{
				"A thick, black leather jacket, as commonly worn by motorcyclists. Not only",
				"will it protect you from damage, it will keep you warm too.",
			}
			level = 21 weight = 120 cost = 700
			allocation = { {14,3}, {21,1}, {23,1}, {31,1}, {33,1}, {41,1}, {43,1} }
			ac = 10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				REINFORCEABLE=true
				ID_VALUE=5
				ITEM_PLAIN=true
				ITEM_MILITARY=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
					}
			}		
		}
		[SV_FLIGHT_JACKET] = {
			name = "& flight jacket~"
			desc =
			{
				"A flight jacket, commonly worn by both amatuer and professional pilots.",
				"Designed to keep you warm at high altitude, and expensive and classy as well.",
			}
			level = 33 weight = 40 cost = 2300
			allocation = { {21,5}, {23,3}, {31,1}, {33,1}, {41,1}, {43,1} }
			ac = 10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				REINFORCEABLE=true
				ID_VALUE=5
				ITEM_PLAIN=true
				ITEM_MILITARY=true
				STATS = getter.stats{[A_CHR] = 1}
			    	RESIST = getter.array{
						[dam.COLD] = 33
					}
			}		
		}
		[SV_DUSTER] = {
			name = "& Australian duster~"
			desc =
			{
				"A lightweight trenchcoat made of sturdy material. It is warm, and offers excellent",
				"protection, but the bottoms do tend to get in the way of complicated motions.",
			}
			level = 15 weight = 50 cost = 2500
			allocation = { {21,5}, {23,3}, {31,1}, {33,1}, {41,1}, {43,1} }
			ac = 20
			to_h = -5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				REINFORCEABLE=true
				SCISSORABLE=true
				ID_VALUE=12
				ITEM_PLAIN=true
			    	RESIST = getter.array{
						[dam.COLD] = 33
						[dam.SHARDS] = 10
					}
			}
		}
		[SV_TRENCHCOAT] = {
			name = "& leather trenchcoat~"
			desc =
			{
				"An extremely heavy leather trenchcoat extending completely to the wrists and ankles.",
				"This offers excellent protection, but is rather expensive as they pretty much have to",
				"kill an entire cow to get enough leather to make one. Not that anyone is in the business",
				"of killing partial cows, but you get my meaning.",
			}
			level = 18 weight = 120 cost = 3500
			allocation = { {31,2}, {33,2}, {41,1}, {43,1} }
			ac = 25
			to_h = -5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=15
				REINFORCEABLE=true
				ITEM_PLAIN=true
			    	RESIST = getter.array{
						[dam.COLD] = 40
						[dam.SHARDS] = 15
					}
			}
		}
		[SV_TURTLE_SHELL] = {
			name = "& turtle shell~"
			desc =
			{
				"Given to you by Master Rosshi, this heavy Turtle Shell may be worn on your back.",
				"Specifically intended to slow you down and hinder your motions, it is nevertheless",
				"an excellent training tool", 
			}
			level = 25 weight = 500 cost = 200
			allocation = { {100,999} }
			ac = 25
			to_h = -10
			display = '('
			color = color.VIOLET
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=15
				SPECIAL_GENE=true
				XP_MOD=10
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
			}
		}
		[SV_HEAVY_TURTLE_SHELL] = {
			name = "& heavy turtle shell~"
			desc =
			{
				"Given to you by Master Rosshi, this extremely heavy Turtle Shell may be worn on your back.",
				"Specifically intended to slow you down and hinder your motions, it is nevertheless",
				"an excellent training tool", 
			}
			level = 25 weight = 1000 cost = 350
			allocation = { {999,1} }
			ac = 25
			to_h = -20
			display = '('
			color = color.VIOLET
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=23
				SPECIAL_GENE=true
				XP_MOD=20
			    	RESIST = getter.array{
						[dam.COLD] = 0
					}
			}
		}
	}

	[TV_GLOVES] =
	{
		color = color.UMBER
		name = 'gloves'
		desc = {
			"Hand coverings",
		}
		symbol = ']'
		defaults =
		{
			display = ']'
			color = color.UMBER
			flags =
			{
				WIELD_SLOT = INVEN_HANDS
				CAPSULED=false
				CAPSULE_WEIGHT=0
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_ALWAYS
				-- Ego hack
			    	-- RESIST = getter.array{[dam.COLD] = 0 [dam.SLASH] = 0 }
				-- STATS = getter.stats{[A_CHR] = 0}			
			}
		}

		[SV_LIGHT_BOXING_GLOVES] = {
			name = "& pair~ of light boxing gloves"
			desc =
			{
				"Intended to prevent scrapes and cuts on the knuckles when you make",
				"contact with someone else's head, these gloves offer a small amount",
				"of protection. Of course, they also soften your blows, and reduce",
				"the available range of motion to your fingers, making both finger strikes",
				"and wielding weapons a bit more difficult."
			}
			level = 1 weight = 10 cost = 60
			allocation = { {10,1}, {13,1}, {15,1} }
			ac = 5
			to_h = -2
			to_d = -2
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.COLD] = 5
					}
			}
		}

		[SV_HEAVY_BOXING_GLOVES] = {
			name = "& pair~ of heavy boxing gloves"
			desc =
			{
				"Thick, heavy red boxing gloves as used by professional boxers. These",
				"gloves are quite large, and simply by holding them in front of you give",
				"a moderately effective barrier from attacks. Of course, they also reduce",
				"the force of your punches considerably, and the single, mitten-like pouch",
				"which your fingers are grouped into makes it nearly impossible to wield",
				"a weapon."
				
			}
			level = 12 weight = 40 cost = 300
			allocation = { {13,1}, {15,1} }
			ac = 10
			to_h = -5
			to_d = -5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=7
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
					}
			}
		}

		[SV_GOLFING_GLOVES] = {
			name = "& pair~ of golfing gloves"
			desc =
			{
				"A simple pair of thin leather gloves which extend only to the wrist and",
				"cut off halfway down the length of the fingers. They offer only a minimum",
				"of protection, but also don't interfere with your motion.",

			}
			level = 1 weight = 2 cost = 60
			allocation = { {2,2}, {5,1}, {6,1}, {8,1} }
			ac = 1
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=1
				REINFORCEABLE=true
				SCISSORABLE=true
				ITEM_PLAIN=true
			}
		}
		[SV_SILK_GLOVES] = {
			name = "& pair~ of silk gloves"
			desc =
			{
				"An expensive pair of silk gloves.",

			}
			level = 5 weight = 2 cost = 400
			allocation = { {5,3}, {6,2}, {8,1} }
			ac = 1
			to_h = -1
			flags = {
				ID_SKILL=SKILL_CHARISMA
				REINFORCEABLE=true
				SCISSORABLE=true
				ID_VALUE=1
				ITEM_PLAIN=true
				ITEM_FRENCH=true
				STATS = getter.stats{[A_CHR] = 1}
			}
		}
		[SV_WELDING_GLOVES] = {
			name = "& pair~ of leather welding gloves"
			desc =
			{
				"A heavy pair of thick leather gloves, intended to provide protection",
				"to the hands while welding."
			}
			level = 5 weight = 15 cost = 200
			allocation = { {5,3}, {6,2}, {8,1} }
			ac = 5
			to_h = -2
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				REINFORCEABLE=true
				ID_VALUE=3
				ITEM_PLAIN=true
			    	RESIST = getter.array{
						[dam.FIRE] = 5
						[dam.COLD] = 5
					}
			}
		}
		[SV_SKI_GLOVES] = {
			name = "& pair~ of ski gloves"
			desc =
			{
				"A heavy pair of thick mitten-like gloves. They provide excellent",
				"protection from the cold, but they do tend to retrict motion in the hands."
			}
			level = 3 weight = 15 cost = 100
			allocation = { {2,1}, {4,1} }
			ac = 5
			to_h = -5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=4
				ITEM_PLAIN=true
			    	RESIST = getter.array{
						[dam.COLD] = 10
					}
			}
		}
		[SV_NINJA_CLIMBING_CLAWS] = {
			name = "& pair~ of ninja climbing claws"
			display = '/' color = color.SLATE
			desc =
			{
				"A half-glove with metal spikes in the palms. Useful for climbing, but interferes",
				"with your grip control, and it is impossible to completely close your fist while",
				"wearing them",
			}
			level = 17 weight = 40 cost = 700
			allocation = { {17,3}, {20,2} }
			ac = 1
			to_h = -10
			flags = {
				ID_SKILL=SKILL_STEALTH
				ID_VALUE=3
				ITEM_NINJA=true
				PASS_TREES=1
				PASS_CLIMB=1
			}
		}
	}

	[TV_BRACERS] =
	{
		color = color.UMBER
		name = 'bracers'
		desc = {
			"Coverings for the forearms.",
		}
		symbol = ']'
		defaults =
		{
			display = ']'
			color = color.UMBER
			flags =
			{
				WIELD_SLOT = INVEN_ARMS
				CAPSULED=false
				CAPSULE_WEIGHT=0
				-- Note: Might be nice to have the to hit penalties always apply
				-- But we don't want the damage bonuses from battle bracers applying
				-- to guns
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				-- Ego hack
			    	-- RESIST = getter.array{[dam.COLD] = 0 [dam.SLASH] = 0 }
				-- STATS = getter.stats{[A_CHR] = 0}			
			}
		}
		[SV_WRIST_BRACE] = {
			name = "& pair~ of wrist braces"
			desc =
			{
				"A tight, heavy elastic set of wrist braces that cover only the first few inches",
				"of your forearms starting from the wrists. They offer only minimal protection",
				"as armor, but the support they give to your wrists will go a long way to prevent",
				"strains, sprains and breaks.",
			}
			level = 10 weight = 2 cost = 200
			allocation = { {6,1}, {8,1}, {10,1}, {13,1}, {15,1}, {17,1}, {20,1} }
			ac = 2
			flags = {
				REINFORCEABLE=true
				ITEM_PLAIN=true
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
			}
		}
		[SV_CLOTH_BRACERS] = {
			name = "& pair~ of cloth bracers"
			desc =
			{
				"Simple, starched cloth coverings for the forearms, these bracers are primarily",
				"cosmetic but do offer slight protection to the arms.",
			}
			level = 10 weight = 6 cost = 100
			allocation = { {6,2}, {8,1}, {10,1}, {13,1}, {15,1}, {17,1}, {20,1} }
			ac = 4
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=4
				ITEM_PLAIN=true
				ITEM_MARTIAL=true
				REINFORCEABLE=true
				SCISSORABLE=true
			}
		}
		[SV_LIGHT_LEATHER_BRACERS] = {
			name = "& pair~ of light leather bracers"
			desc =
			{
				"The leather these bracers are made of is light and soft, but tightly pulls",
				"across the lower half of your forearms to offer both protection from cuts",
				"and scrapes, as well as prevent you from damaging yourself through overexertion.",
				"They offer the best protection possible for the forearms without hindering",
				"your motion.",
			}
			level = 10 weight = 6 cost = 400
			allocation = { {8,3}, {10,1}, {13,1}, {15,1}, {17,1}, {20,1} }
			ac = 8
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=7
				ITEM_PLAIN=true
				ITEM_MARTIAL=true
				REINFORCEABLE=true
			}
		}
		[SV_HEAVY_LEATHER_BRACERS] = {
			name = "& pair~ of heavy leather bracers"
			desc =
			{
				"Often worn by weightlifters, the leather of these bracers is fully an eighth",
				"an an inch thick, and partially rigid. Worn tightly on the forearms, they are",
				"intended to keep your bones from snapping durign excessive exertion, but the",
				"leather is thick enough that it would take substantial sawing to cut through.",
				"The overall effect is remarkably protective, but the rigidity does slightly",
				"impede ones range of motion when it comes time to rotate the wrist.",
			}
			level = 10 weight = 6 cost = 800
			allocation = { {10,2}, {13,1}, {15,1}, {17,1}, {20,1} }
			ac = 12
			to_h = -5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=7
				ITEM_PLAIN=true
				ITEM_MARTIAL=true
				REINFORCEABLE=true
			}
		}
		[SV_STEEL_BRACERS] = {
			name = "& pair~ of steel bracers"
			desc =
			{
				"Sold steel forearm guards that wrap completely around the lower portion of the",
				"forearm, and extend on the back of the arm all the way to the elbow. They offer",
				"tremendous protection, but the inflexibility of the steel does hinder the fliudity",
				"of your motions considerably.",
			}
			level = 18 weight = 6 cost = 1500
			allocation = { {15,5}, {17,3}, {20,1} }
			ac = 20
			to_h = -10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=15
				ITEM_MARTIAL=true
				ITEM_NINJA=true
			}
		}
		[SV_BATTLE_BRACERS] = {
			name = "& pair~ of steel battle bracers"
			desc =
			{
				"Similar to the ordinary steel bracer, these guards feature a set of directed",
				"blades along the back of the arm, as well as a viscious pointed spike extending",
				"past the elbow. They give just as much as regular steel bracers in terms of",
				"protection and motion restriction, but give additional tearing surfaces allow",
				"you extra opportunities to damage an oponent.",
			}
			level = 30 weight = 30 cost = 2500
			allocation = { {17,3}, {20,1} }
			ac = 20
			to_h = -10
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=23
				ITEM_MARTIAL=true
				ITEM_NINJA=true
				BLOW_RESPONSE = getter.array{[AURA_PIERCE] = {1,12}}
			}
		}
		[SV_NINJA_BRACERS] = {
			name = "& pair~ of ninja bracers"
			desc =
			{
				"A cloth bracer nearly a foot long into which",
				"one slides their arm up to the elbow and secures by looping a finger through",
				"a small ring. Thus, the flesh of the fingers and palm remain available, while",
				"at the same time maximizing coverage, and incidentally covering and holding",
				"in place any otherwise loose, or baggy shirtsleeves.",

			}
			level = 14 weight = 6 cost = 400
			allocation = { {16,1}, {18,1}, {20,1} }
			ac = 4
			flags = {
				STEALTH=1
				ID_SKILL=SKILL_STEALTH
				ID_VALUE=7
				ITEM_NINJA=true
				REINFORCEABLE=true
				SCISSORABLE=true
 			}
		}
	}

	[TV_SHIELD] =
	{
		color = color.UMBER
		name = 'shields'
		desc = {
			"Handheld deflection devices",
		}
		symbol = ')'
		defaults =
		{
			display = ')'
			color = color.UMBER
			flags =
			{
				WIELD_SLOT = INVEN_WIELD
				CAPSULED=false
				CAPSULE_WEIGHT=0
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_ALWAYS
			}
		}

		[SV_LEATHER_SHIELD] = {
			name = "& leather shield~"
			desc =
			{
				"Describe me!",
			}
			level = 10 weight = 40 cost = 450
			allocation = { {15,5}, {17,3}, {20,1} }
			ac = 8
			flags = {
				ID_SKILL=SKILL_PARRYING
				ID_VALUE=5
				ITEM_MARTIAL=true
			    	RESIST = getter.array{
						[dam.SHARDS] = 10
					}
			}
		}
		[SV_RIOT_SHIELD] = {
			name = "& riot shield~"
			desc =
			{
				"A heavy, transparant plexiglass shield extending from head to knees. It is lightweight",
				"and offers excellent protection. It is a bit awkward, though."
			}
			level = 35 weight = 30 cost = 2000
			allocation = { {33,5}, {35,3}, {41,1}, {43,1} }
			ac = 30
			to_h = -5
			flags = {
				ID_SKILL=SKILL_PARRYING
				ID_VALUE=10
				ITEM_POLICE=true
				ITEM_MILITARY=true
			    	RESIST = getter.array{
						[dam.BALLISTIC] = 10
						[dam.SHARDS] = 20
					}
			}
		}
	}

	[TV_DRINK] =
	{
		color = color.LIGHT_BLUE
		name = "drink"
		desc =
		{
			"Everyone gets thirsty, even you. Well, maybe especially you.",
		}
		defaults =
		{
			flags =
			{
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}
		symbol = '!'
		[SV_BOTTLED_WATER] = {
			name = "& bottle~ of water"
			display = '!' color = color.LIGHT_BLUE
			desc =
			{
				"A small plastic bottle filled with water."
			}
			level = 1 weight = 1 cost = 10
			allocation = { {1,1}, {5,1}, {10,1} }
			dice = {1, 1}
			flags = {
				EASY_KNOW=true
				BREAKAGE_CHANCE = 5
				FOOD_VALUE = 200
				ON_QUAFF=function()
					message("You feel less thirsty.");
					return true
				end
			}
		}
		[SV_PERRIER] = {
			name = "& bottle~ of perrier"
			display = '!' color = color.GREEN
			desc =
			{
				"A small glass bottle filled with carbonated water imported from France."
			}
			level = 3 weight = 1 cost = 60
			allocation = { {3,3} }
			dice = {1, 1}
			flags = {
				EASY_KNOW=true
				BREAKAGE_CHANCE = 100
				FOOD_VALUE = 200
				ON_QUAFF=function()
					message("You feel classy.")
					return true
				end
			}
		}
		[SV_DR_PEPPER] = {
			name = "& can~ of Dr. Pepper"
			display = '!' color = color.TAN
			desc =
			{
				"Caffeine is good."
			}
			level = 4 weight = 1 cost = 10
			allocation = { {4,5}, {10,2} }
			dice = {1, 1}
			flags = {
				EASY_KNOW=true
				BREAKAGE_CHANCE = 5
				FOOD_VALUE = 200
				ON_QUAFF=function()
					message("You feel less thirsty.");
					return true
				end
			}
		}
		[SV_MOUNTAIN_DEW] = {
			name = "& can~ of Mountain Dew"
			display = '!' color = color.LIGHT_GREEN
			desc =
			{
				"Caffeine is good!"
			}
			level = 4 weight = 1 cost = 50
			allocation = { {4,5}, {10,2} }
			dice = {1, 1}
			flags = {
				EASY_KNOW=true
				BREAKAGE_CHANCE = 5
				FOOD_VALUE = 200
				ON_QUAFF=function()
					if dball_data.caffiene > 2 then
						message("Your body is used to the caffiene.")
					elseif dball_data.caffiene == 0 then
						message("Wow! You feel a caffeine rush!")
						return timed_effect.set(timed_effect.FAST, rng(25) + 15, 7)
					else
						message("You feel a bit of a caffeine rush!")
						return timed_effect.set(timed_effect.FAST, rng(25) + 15, 3)
					end
					dball_data.caffiene = dball_data.caffiene + 1
					return nil
				end
			}
		}
		[SV_JOLT] = {
			name = "& can~ of Jolt"
			display = '!' color = color.RED
			desc =
			{
				"All the sugar and twice the caffeine."
			}
			level = 10 weight = 1 cost = 75
			allocation = { {4,2}, {10,2} }
			dice = {1, 1}
			flags = {
				EASY_KNOW=true
				BREAKAGE_CHANCE = 5
				FOOD_VALUE = 200
				ON_QUAFF=function()
					if dball_data.caffiene > 2 then
						message("Your body is used to the caffiene.")
					elseif dball_data.caffiene == 0 then
						message("Wow! You feel a caffeine rush!")
						return timed_effect.set(timed_effect.FAST, rng(25) + 15, 10)
					else
						message("You feel a bit of a caffeine rush!")
						return timed_effect.set(timed_effect.FAST, rng(25) + 15, 7)
					end
					dball_data.caffiene = dball_data.caffiene + 2
					return nil
				end
			}
		}
		[SV_WINE] = {
			name = "& bottle~ of wine"
			display = '!' color = color.GREEN
			desc =
			{
				"A bottle of expensive wine."
			}
			level = 7 weight = 1 cost = 100
			allocation = { {1,2}, {3,2}, {10,2} }
			dice = {1, 1}
			flags = {
				EASY_KNOW=true
				BREAKAGE_CHANCE = 5
				FOOD_VALUE = 200
				ITEM_FRENCH=true
				ON_QUAFF=function()
					message("Hmm. Good year.");
					return true
				end
			}
		}
	}

	[TV_POTION] =
	{
		color = color.LIGHT_BLUE
		name = "Strange Liquids"
		desc =
		{
			"A small container of liquid",
		}
		defaults =
		{
			flags =
			{
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_TECHNO=true
			}
		}
		symbol = '!'
		[SV_POISON] = {
			name = "vial of poison"
			display = '!' color = color.GREEN
			desc =
			{
				"This bottle is filled with a mild but still dangerous liquid poison. Drinking it would be highly",
				"unwise."
			}
			level = 10 weight = 4 cost = 0
			allocation = { {10,3} }
			dice = {1, 1}
			flags = {
				FLAVOUR = "vial of green liquid"
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=3
				USEABLE = 31
				ON_QUAFF=function()
					--if not player.has_intrinsic(FLAG_RES_POIS) then
						if timed_effect(timed_effect.POISON, rng(15) + 10, 1) then
							return true
						end
					--end
					return nil
				end
				BREAKAGE_CHANCE = 100
				FOOD_VALUE = 0
				DISCIPLINE = 3
				INGRED1_WHAT = TV_CHEMISTRY
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {40,100}}
			}
		}
		[SV_ANTIDOTE] = {
			name = "vial of antidote"
			display = '!' color = color.GREEN
			desc =
			{
				"This liquid will completely negate the effect of poisons currently affecting you."
			}
			level = 20 weight = 4 cost = 75
			allocation = { {20,3} }
			dice = {1, 1}
			flags = {
				FLAVOUR = "vial of green liquid"
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=5
				ON_QUAFF=function()
					return set_poisoned(0)
				end
				BREAKAGE_CHANCE = 100
				FOOD_VALUE = 0
				DISCIPLINE = 3
				INGRED1_WHAT = TV_CHEMISTRY
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
			}
		}
		[SV_NUCLEAR_WASTE] = {
			name = "small nuclear waste canister"
			display = '!' color = color.VIOLET
			desc =
			{
				"This canister contains a viscous radioactive gel.",
			}
			level = 10 weight = 120 cost = 0
			allocation = { {4,3} }
			dice = {20, 20}
			flags = {
				FLAVOUR = "small cylinder"
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=10
				ON_QUAFF=function()
					message("Your nerves and muscles feel weak and lifeless!")
					take_hit(rng.roll(10, 10), "drinking nuclear waste")
					dec_stat(A_DEX, 25, true)
					dec_stat(A_WIL, 25, true)
					dec_stat(A_CON, 25, true)
					dec_stat(A_STR, 25, true)
					dec_stat(A_CHR, 25, true)
					dec_stat(A_INT, 25, true)
					dec_stat(A_SPD, 25, true)
					dball_data.mutant = dball_data.mutant + 1
					return true
				end
				BREAKAGE_CHANCE = 1
				FOOD_VALUE = 0
			}
		}
	}

	[TV_SALVE] =
	{
		color = color.WHITE
		name = "salve"
		desc = {"A paste or liquid intended for external application"}
		symbol = '!'
		defaults =
		{
			flags =
			{
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}
		-- NOTE: Use requirements handled in tools.lua
		-- Either first Aid or Tech >= 5 will allow use of coagulant
		[SV_COAGULANT] = {
			name = "blood coagulant"
			display = '!' color = color.GREEN
			desc =
			{
				"A chemical paste that induces blood coagulation. Or, to put it another way: it's",
				"goo that contains a lot of oxygen. When you smear it onto cuts it causes your blood",
				"to scab over very quickly so you stop bleeding.",
			}
			level = 10 weight = 2 cost = 50
			allocation = { {13,3}, {15,2}, {20,1}, {23,1}, {33,1}, {35,1}, {41,1}, {43,1} }
			dice = {1, 1}
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=5
				ITEM_PLAIN=true
				ITEM_MARTIAL=true
				ITEM_MILITARY=true
				USEABLE = 12
				BREAKAGE_CHANCE = 100
				FOOD_VALUE = 0
				DISCIPLINE = 3
				INGRED1_WHAT = TV_CHEMISTRY
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
			}
		}
		[SV_ZHENG_GU_SHUI] = {
			name = "zheng gu shui"
			display = '!' color = color.RED
			desc =
			{
				"Liquid extract of the root from a chinese zheng gu shui plant, this salve",
				"enhances and accelerates your body's natural healing propensities. It smells",
				"fairly bad, but is exclusively beneficial, and using it in massive quantities",
				"produces no harmful side effects. It is not magic, however, and the effect",
				"will be gradual over time rather than instantaneous.",
			}
			level = 13 weight = 2 cost = 100
			allocation = { {11,5}, {13,3}, {15,2} }
			dice = {1, 1}
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
				USEABLE = 13
				BREAKAGE_CHANCE = 100
				FOOD_VALUE = 0
				ITEM_CHINESE=true
				ITEM_MARTIAL=true
				-- This is ground plant root. Should it be Technomancable?
				-- DISCIPLINE = 3
				-- INGRED1_WHAT = TV_CHEMISTRY
				-- INGRED1_QTY = 1
				-- INGRED2_WHAT = TV_CHEMISTRY
				-- INGRED2_QTY = 1
			}
		}
		[SV_BODY_OIL] = {
			name = "body oil"
			display = '!' color = color.LIGHT_DARK
			desc =
			{
				"A small container of olive oil, commonly used by wrestlers. By rubbing it on one's body, one is",
				"able to become very slippery, and thus more difficult to grab. To be effective you'll need to",
				"remove clothing from your torso. That would be the 'on body' and 'about body' equipment slots.",
			}
			level = 10 weight = 1 cost = 150
			allocation = { {11,2}, {13,1}, {15,1} }
			dice = {1, 1}
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
				USEABLE = 14
				ITEM_MARTIAL=true
				BREAKAGE_CHANCE = 100
				FOOD_VALUE = 0
				-- DISCIPLINE = 3
				-- INGRED1_WHAT = TV_CHEMISTRY
				-- INGRED1_QTY = 1
				-- INGRED2_WHAT = TV_CHEMISTRY
				-- INGRED2_QTY = 1
			}
		}
	}

	[TV_BLUEPRINTS] =
	{
		color = color.VIOLET
		name = "blueprints"
		desc =
		{
			"A guide for how to build something",
		}
		symbol = '?'
		defaults = {
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_TECHNO=true
			}
		}
		[1] = {
			define_sval_as = "SV_ANDROID17"
			name = "& set~ of blueprints"
			display = '?' color = color.VIOLET
			desc =
			{
				"Blueprints",
			}
			level = 100 weight = 1 cost = 500
			allocation = { {0,1} }
			flags = {
				ID_VALUE=25
				INSTA_ART = true
				SPECIAL_GENE = true
				ON_READ=function()
					if get_skill(SKILL_TECHNOLOGY) < 3 then
						message("Looks like gobbledygook to you.")
					elseif get_skill(SKILL_TECHNOLOGY) < 10 then
						message("It is too complicated for you to make much sense of.")
					else
						message("You barely grasp the basics, but it's way over your head. Maybe Dr. Briefs could help?")
					end
					return false, true
				end
			}
		}
		[2] = {
			define_sval_as = "SV_EASY_BLUEPRINTS"
			name = "& set~ of basic blueprints"
			display = '?' color = color.VIOLET
			desc =
			{
				"Blueprints",
			}
			level = 10 weight = 1 cost = 300
			allocation = { {10,1} }
			flags = {
				ID_VALUE=10
				ON_READ=function(obj)
					if obj.flags[FLAG_TECHNO_PLANS] == FLAG_TECHNO_AVAILABLE then
						message("Error in blueprints: ON_MAKE never assigned a blueprint pointer!")
					else
						local k_ptr = obj.flags[FLAG_TECHNO_PLANS]
						local item = k_info[k_ptr]
						if item.name and item.flags[FLAG_DISCIPLINE] then
							-- local desc = object_desc(obj, false, 0)
							if tech_known[k_ptr - 1] == false then
								if get_skill(SKILL_TECHNOLOGY) + get_skill(SKILL_CONSTRUCTION) + get_skill(SKILL_DISASSEMBLY) < obj.flags[FLAG_ID_VALUE] then
									message("You pore over the blueprints, but can't figure out what they're for.")
								else
									tech_known[k_ptr - 1] = true
									message("You learn how to build a " .. item.name .. " with a " .. technomancy.discipline_name(item.flags[FLAG_DISCIPLINE]))
								end
							else
								message("You already know how to build a " .. item.name)
							end
						else
							message("Error: pointer does not point to a valid item!")
						end
					end
					return true, true
				end
				TECHNO_PLANS=FLAG_TECHNO_AVAILABLE
				ON_MAKE =
					function(obj)
						obj.flags[FLAG_TECHNO_PLANS] = technomancy.make_bp(-1)
						local k_ptr = obj.flags[FLAG_TECHNO_PLANS]
						local item = k_info[k_ptr]
						obj.flags[FLAG_ID_VALUE] = item.level
					end
			}
		}
		[3] = {
			define_sval_as = "SV_MEDIUM_BLUEPRINTS"
			name = "& set~ of medium blueprints"
			display = '?' color = color.VIOLET
			desc =
			{
				"Blueprints",
			}
			level = 30 weight = 1 cost = 700
			allocation = { {30,1} }
			flags = {
				ID_VALUE=20
				ON_READ=function(obj)
					if obj.flags[FLAG_TECHNO_PLANS] == FLAG_TECHNO_AVAILABLE then
						message("Error in blueprints: ON_MAKE never assigned a blueprint pointer!")
					else
						local k_ptr = obj.flags[FLAG_TECHNO_PLANS]
						local item = k_info[k_ptr]
						if item.name and item.flags[FLAG_DISCIPLINE] then
							-- local desc = object_desc(obj, false, 0)
							if tech_known[k_ptr - 1] == false then
								if get_skill(SKILL_TECHNOLOGY) + get_skill(SKILL_CONSTRUCTION) + get_skill(SKILL_DISASSEMBLY) < obj.flags[FLAG_ID_VALUE] then
									message("You pore over the blueprints, but can't figure out what they're for.")
								else
									tech_known[k_ptr - 1] = true
									message("You learn how to build a " .. item.name .. " with a " .. technomancy.discipline_name(item.flags[FLAG_DISCIPLINE]))
								end
							else
								message("You already know how to build a " .. item.name)
							end
						else
							message("Error: pointer does not point to a valid item!")
						end
					end
					return true, true
				end
				TECHNO_PLANS=FLAG_TECHNO_AVAILABLE
				ON_MAKE =
					function(obj)
						obj.flags[FLAG_TECHNO_PLANS] = technomancy.make_bp(-2)
						local k_ptr = obj.flags[FLAG_TECHNO_PLANS]
						local item = k_info[k_ptr]
						obj.flags[FLAG_ID_VALUE] = item.level
					end
			}
		}
		[4] = {
			define_sval_as = "SV_HARD_BLUEPRINTS"
			name = "& set~ of complicated blueprints"
			display = '?' color = color.VIOLET
			desc =
			{
				"Blueprints",
			}
			level = 60 weight = 1 cost = 1400
			allocation = { {60,1} }
			flags = {
				ID_VALUE=30
				ON_READ=function(obj)
					if obj.flags[FLAG_TECHNO_PLANS] == FLAG_TECHNO_AVAILABLE then
						message("Error in blueprints: ON_MAKE never assigned a blueprint pointer!")
					else
						local k_ptr = obj.flags[FLAG_TECHNO_PLANS]
						local item = k_info[k_ptr]
						if item.name and item.flags[FLAG_DISCIPLINE] then
							-- local desc = object_desc(obj, false, 0)
							if tech_known[k_ptr - 1] == false then
								if get_skill(SKILL_TECHNOLOGY) + get_skill(SKILL_CONSTRUCTION) + get_skill(SKILL_DISASSEMBLY) < obj.flags[FLAG_ID_VALUE] then
									message("You pore over the blueprints, but can't figure out what they're for.")
								else
									tech_known[k_ptr - 1] = true
									message("You learn how to build a " .. item.name .. " with a " .. technomancy.discipline_name(item.flags[FLAG_DISCIPLINE]))
								end
							else
								message("You already know how to build a " .. item.name)
							end
						else
							message("Error: pointer does not point to a valid item!")
						end
					end
					return true, true
				end
				TECHNO_PLANS=FLAG_TECHNO_AVAILABLE
				ON_MAKE =
					function(obj)
						obj.flags[FLAG_TECHNO_PLANS] = technomancy.make_bp(-3)
						local k_ptr = obj.flags[FLAG_TECHNO_PLANS]
						local item = k_info[k_ptr]
						obj.flags[FLAG_ID_VALUE] = item.level
					end
			}
		}
	}

	[TV_PARCHMENT] =
	{
		color = color.ORANGE
		name = "parchments"
		desc =
		{
			"Helpful reminders from the module maintainer.",
		}
		symbol = '?'
		defaults = {
			flags = {
				EASY_KNOW=true
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}
		[1] = {
			define_sval_as = "SV_GUIDE"
			name = "Guide to Dragonball T"
			display = '?' color = color.ORANGE
			desc =
			{
				"Read it !"
			}
			level = 0 weight = 1 cost = 1
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[2] = {
			define_sval_as = "SV_PILOTS_CLUB"
			name = "Pilot's Club Membership"
			display = '?' color = color.ORANGE
			desc =
			{
				"This pamphlet contains useful information for pilot's club members."
			}
			level = 0 weight = 1 cost = 0
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[3] = {
			define_sval_as = "SV_ESSAY_BARE_WEAP"
			name = "Barehanded or Weapons?"
			display = '?' color = color.ORANGE
			desc =
			{
				"This is an essay discussing the relative benfits of fighting",
				"barehanded vs. fighting with weapons.",

			}
			level = 0 weight = 1 cost = 100
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[4] = {
			define_sval_as = "SV_ESSAY_COMBAT_MATH"
			name = "Combat Math"
			display = '?' color = color.ORANGE
			desc =
			{
				"This is an essay discussing describing how Dragonball T",
				"computes various useful numbers.",

			}
			level = 0 weight = 1 cost = 100
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[5] = {
			define_sval_as = "SV_ESSAY_ACUPUNCTURE"
			name = "All About Acupuncture"
			display = '?' color = color.ORANGE
			desc =
			{
				"This essay contains useful information about acupuncture.",

			}
			level = 0 weight = 1 cost = 100
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[6] = {
			define_sval_as = "SV_WT_GUIDE"
			name = "The World Tournament"
			display = '?' color = color.ORANGE
			desc =
			{
				"This pamphlet contains useful information for prospective",
				"participants in the World Tournament.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[7] = {
			define_sval_as = "SV_WEAPONS_GUIDE"
			name = "Weapons Guide"
			display = '?' color = color.ORANGE
			desc =
			{
				"This pamphlet deescribes the general categories of",
				"weapons that exist in the world of Dragonball T.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[8] = {
			define_sval_as = "SV_RELEASE_NOTES_024"
			name = "Dragonball T V024 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[9] = {
			define_sval_as = "SV_FIREARMS_GUIDE"
			name = "Firearms Guide"
			display = '?' color = color.ORANGE
			desc =
			{
				"This pamphlet describes how firearms work in Dragonball T.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[10] = {
			define_sval_as = "SV_RELEASE_NOTES_029"
			name = "Dragonball T V029 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[11] = {
			define_sval_as = "SV_TRANSLATION_COMMENTARY"
			name = "Dragonball T Translation Commentary"
			display = '?' color = color.ORANGE
			desc =
			{
				"Some comments from the Module Maintainer about naming conventions.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[12] = {
			define_sval_as = "SV_RECENTLY_DECEASED"
			name = "Manual for the Recently Deceased"
			display = '?' color = color.ORANGE
			desc =
			{
				"...oh dear. This can't be good.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[13] = {
			define_sval_as = "SV_RELEASE_NOTES_041"
			name = "Dragonball T V041 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[14] = {
			define_sval_as = "SV_RELEASE_NOTES_050"
			name = "Dragonball T V050 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[15] = {
			define_sval_as = "SV_RELEASE_NOTES_057"
			name = "Dragonball T V057 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[16] = {
			define_sval_as = "SV_RELEASE_NOTES_066"
			name = "Dragonball T V066 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[17] = {
			define_sval_as = "SV_RELEASE_NOTES_071"
			name = "Dragonball T V071 (087) Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[18] = {
			define_sval_as = "SV_RELEASE_NOTES_075"
			name = "Dragonball T V075 (094) Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[19] = {
			define_sval_as = "SV_RELEASE_NOTES_076"
			name = "Dragonball T V076 (095) Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[20] = {
			define_sval_as = "SV_RELEASE_NOTES_077"
			name = "Dragonball T V077 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Release Notes!",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[21] = {
			define_sval_as = "SV_RELEASE_NOTES_078"
			name = "Dragonball T V078 Release Notes (V077 Bugfixes)"
			display = '?' color = color.ORANGE
			desc =
			{
				"Next-day bugfix for V077.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[22] = {
			define_sval_as = "SV_SKILL_EXPERIMENT"
			name = "About the experimental skill system"
			display = '?' color = color.ORANGE
			desc =
			{
				"I think it's a failed experiement, and not going to stay. :/",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[23] = {
			define_sval_as = "SV_RELEASE_NOTES_079"
			name = "Dragonball T V079 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Weapons, motorcycles, experimental skill system, and fixes for the Briefs and Dragonball bugs.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[24] = {
			define_sval_as = "SV_RELEASE_NOTES_080"
			name = "Dragonball T V080 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"New Story-Mode skill system, several bugfixes, monsters are tougher.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[25] = {
			define_sval_as = "SV_RELEASE_NOTES_081"
			name = "Dragonball T V081 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Big release.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[26] = {
			define_sval_as = "SV_RELEASE_NOTES_082"
			name = "Dragonball T V082 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"A bunch of new ego types, introduction of blueprints, and some rule changes.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[27] = {
			define_sval_as = "SV_RELEASE_NOTES_083"
			name = "Dragonball T V083 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Bugfixes, Hell has been partially implemented, some rule changes, a new",
				"fencing school, and a general reworking of the Challenge Quests",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[28] = {
			define_sval_as = "SV_RELEASE_NOTES_085"
			name = "Dragonball T V084 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Partial alpha14 migration, new material, significant changes to Technomancy",
				"and Chi.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[29] = {
			define_sval_as = "SV_README"
			name = "READ ME!!! BUG WORKAROUND!"
			display = '?' color = color.ORANGE
			desc =
			{
				"win.cfg may cause your saves to crash. Delete this file if you have any trouble.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[30] = {
			define_sval_as = "SV_RELEASE_NOTES_086"
			name = "Dragonball T V086 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Large content release. Lots of changes. Complete redesign of the planet earth.",
				"Many things are still in progress. Probably some bugs, but more stable than V085.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[31] = {
			define_sval_as = "SV_RELEASE_NOTES_087"
			name = "Dragonball T V087 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Tunneling, WT loss by ringout improvements, and replacement of things missed",
				"in V086's transition to a 3x3 earth map. Plus a whole bunch of bugfixes.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[32] = {
			define_sval_as = "SV_RELEASE_NOTES_088"
			name = "Dragonball T V088 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Bugfixes, rulechanges, basic introduction of throwing and the North Kaio.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[33] = {
			define_sval_as = "SV_RELEASE_NOTES_089"
			name = "Dragonball T V089 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"LOTS of bugfixes, SHQ Mega-Dungeon, some development of Namek",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
		[34] = {
			define_sval_as = "SV_RELEASE_NOTES_090"
			name = "Dragonball T V090 Release Notes"
			display = '?' color = color.ORANGE
			desc =
			{
				"Party system, new quests and content, major item drop revision, 70K new dialogue.",

			}
			level = 0 weight = 1 cost = 10
			allocation = { {0,1} }
			flags = { ON_READ=display_parchement }
		}
	}

	[TV_CORPSE] =
	{
		color = color.LIGHT_UMBER
		name = "corpses"
		symbol = '~'
		desc =
		{
			"Something has died, leaving this empty husk behind,",
			"and going on to someplace better than this foul world.",
		}
		defaults = {
			flags = {
				EASY_KNOW=true
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}
		[SV_CORPSE_CORPSE] = {
			name = "corpse"
			display = '~' color = color.LIGHT_UMBER
			desc =
			{
				"Whatever happened with this one, it wasn't pretty."
			}
			level = 20 weight = 80 cost = 0
			allocation = { {30,1} }
			flags = {
				ON_EAT     = food.eat_corpse
				FOOD_VALUE = 2500
				DECAY      = true
			}
		}
		[SV_CORPSE_SKELETON] = {
			name = "skeleton"
			display = '~' color = color.WHITE
			desc =
			{
				"Whatever happened to this one, it didn't leave much behind.",
			}
			level = 20 weight = 80 cost = 0
			allocation = { {30,1} }
			flags = {
			}
		}
	}
	[TV_DBT_BONES] =
	{
		color = color.WHITE
		name = "bones"
		symbol = '~'
		desc =
		{
			"Something has died, leaving this empty husk behind,",
			"and going on to someplace better than this foul world.",
		}
		defaults = {
			flags = {
				EASY_KNOW=true
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}
		[SV_FEMUR] = {
			name = "femur"
			display = '~' color = color.LIGHT_UMBER
			desc =
			{
				"The large bone of a human upper thigh. Finding it does beg the question: what happened to",
				"the rest of the skeleton?",
			}
			level = 20 weight = 20 cost = 0
			allocation = { {30,1} }
			flags = {
			}
		}
		[SV_RIBCAGE] = {
			name = "ribcage"
			display = '~' color = color.LIGHT_UMBER
			desc =
			{
				"The shattered remenants of a human ribcage. Few of the bones are still intact. It looks",
				"like whomever it was met with a very messy end.",
			}
			level = 20 weight = 80 cost = 0
			allocation = { {30,1} }
			flags = {
			}
		}
		[SV_SKULL] = {
			name = "skull"
			display = '~' color = color.LIGHT_UMBER
			desc =
			{
				"A human skull. Creepy.",
			}
			level = 20 weight = 40 cost = 0
			allocation = { {30,1} }
			flags = {
			}
		}
	}


	[TV_FOOD] =
	{
		color = color.LIGHT_UMBER
		name = "food"
		desc =
		{
			"Food is a good thing. Unless you're the food.",
		}
		symbol = ','
		defaults = {
			display = ','
			flags = {
				EASY_KNOW  = true
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}
		[SV_POWER_BAR] = {
			name = "& power bar~"
			display = ',' color = color.RED
			desc =
			{
				"A gooey plastic wrapped nutritional bar gaurunteed by the manufacturer",
				"to envigorate you with all sorts of important vitamins and nutrients.",
				"Curiously the ingredients list hidden underneath the fold seems mostly",
				"to list various names chemical names for sugar and a numbered artificial",
				"dye.",
			}
			level = 1 weight = 10 cost = 3
			allocation = { {0,1}, {5,1}, {10,1} }
			flags = {
				ON_EAT     = food.eat_good
				FOOD_VALUE = 2000
			}
		}
		[SV_BEEF_JERKY] = {
			name = "& strip~ of beef jerky"
			display = ',' color = color.LIGHT_UMBER
			desc =
			{
				"Yummy protein! Not very filling, though.",
			}
			level = 1 weight = 10 cost = 3
			allocation = { {0,1}, {5,1}, {10,1} }
			flags = {
				ON_EAT     = food.eat_good
				FOOD_VALUE = 1000
			}
		}
		[SV_SQUID_JERKY] = {
			name = "& strip~ of squid jerky"
			display = ',' color = color.LIGHT_UMBER
			desc =
			{
				"Perhaps an acquired taste, squid jerky is just like beef jerky...",
				"except it's made from squid.",
			}
			level = 1 weight = 10 cost = 3
			allocation = { {0,1}, {5,1}, {10,1} }
			flags = {
				ON_EAT     = food.eat_good
				FOOD_VALUE = 1000
			}
		}
		[SV_PIZZA] = {
			name = "& slice~ of pizza"
			display = ',' color = color.LIGHT_RED
			desc =
			{
				"The true food of martial artists everywhere!",
			}
			level = 1 weight = 10 cost = 3
			allocation = { {1,1}, {5,1}, {10,1} }
			flags = {
				ON_EAT     = food.eat_good
				FOOD_VALUE = 5000
			}
		}
		[SV_FORTUNE_COOKIE] = {
			name = "& fortune cookie~"
			display = ',' color = color.LIGHT_UMBER
			desc =
			{
				"A small, sweet, crunchy piece of bread wrapped around a message on a piece of paper.",
			}
			level = 0 weight = 10 cost = 3
			allocation = { {0,1}, {5,1}, {10,1} }
			flags = {
				ON_EAT     = food.eat_good
				FORTUNE=true
				FOOD_VALUE = 200
			}
		}
		[SV_PIECE_OF_SUSHI] = {
			name = "& piece~ of sushi"
			display = ',' color = color.LIGHT_RED
			desc =
			{
				"Sushi is raw fish wrapped with rice. Don't get me wrong...sushi is good.",
				"You like sushi. You may even *like* suchi. But you're not entirely sure",
				"where this particular piece came from. Do you really want to eat it?",
			}
			level = 1 weight = 1 cost = 1
			allocation = { {0,1}, {5,1}, {10,1} }
			flags = {
				ON_EAT     = food.eat_not_so_good
				FOOD_VALUE = 500
			}
		}
		[SV_SENZU_BEAN] = {
			name = "& senzu bean~"
			display = ',' color = color.RED
			desc =
			{
				"Grown by Korin in his tower, these magic beans will instantly restore you",
				"to perfect health, curing all damage, removing all negative effects, even",
				"regenerating lost limbs. Karin gives them away freely to those who have",
				"earned his respect, but they take a great deal of time to harvest, and are",
				"rarely available in any significant quantity.",
			}
			level = 100 weight = 1 cost = 1000
			allocation = { {100,999} }
			flags = {
				ON_EAT     = function()
					message("You feel all better!")
					dball.cure_cond()
					restore_level()
					-- Not using .mod_hp, but can't eat when dead, so ok.
					hp_player(10000)
					return true
				end
				FOOD_VALUE = 500
			}
		}
		[SV_CATNIP] = {
			name = "& piece~ of catnip"
			display = ',' color = color.LIGHT_GREEN
			desc =
			{
				"Drugs for cats. Curiously, very few people seem to realize this, and generally",
				"panic when you tell them that catnip is basically marijuana that only affects",
				"cats. Try it sometime. It can be entertaining.",
			}
			level = 1 weight = 1 cost = 3
			allocation = { {1,1}, {5,1}, {10,1} }
			flags = {
				ON_EAT =	function()
							message("It doesn't look very tasty.")
						end
				FOOD_VALUE = 10
			}
		}
		[SV_CHOCOLATE] = {
			name = "& piece~ of chocolate"
			display = ',' color = color.TAN
			desc =
			{
				"A yummy-looking piece of chocolate.",
			}
			level = 1 weight = 1 cost = 10
			allocation = { {1,1} }
			flags = {
				ON_EAT     = food.eat_good
				FOOD_VALUE = 2000
			}
		}
		[SV_LICORICE] = {
			name = "& piece~ of licorice"
			display = ',' color = color.LIGHT_DARK
			desc =
			{
				"A stick of dark licorice.",
			}
			level = 1 weight = 1 cost = 1
			allocation = { {1,1} }
			flags = {
				ON_EAT     = food.eat_good
				FOOD_VALUE = 2000
			}
		}
		[SV_GUMMY_BEAR] = {
			name = "& gummy bear~"
			display = ',' color = color.LIGHT_BLUE
			desc =
			{
				"A small gummy bear. It is soft and warm.",
			}
			level = 1 weight = 1 cost = 1
			allocation = { {1,1} }
			flags = {
				ON_EAT     = food.eat_good
				FOOD_VALUE = 2000
			}
		}
		[SV_SOUR_FISH] = {
			name = "& sour fish~"
			display = ',' color = color.PINK
			desc =
			{
				"A small sugared sour fish.",
			}
			level = 1 weight = 1 cost = 1
			allocation = { {1,1} }
			flags = {
				ON_EAT     = food.eat_good
				FOOD_VALUE = 2000
			}
		}
		[SV_MRE] = {
			name = "& mre~"
			display = ',' color = color.LIGHT_WHITE
			desc =
			{
				"The MRE, or 'Meal Ready to Eat' is a pre-packaged combat field ration scientifcally",
				"designed to supply the body with everything it needs to survive, and to taste bad.",
			}
			level = 20 weight = 10 cost = 30
			allocation = { {20,1}, {25,1}, {30,1}, {35,1} }
			flags = {
				ON_EAT     = food.eat_mre
				FOOD_VALUE = 5000
				ITEM_MILITARY=true
			}
		}
		[SV_COOKED_WHITE_RICE] = {
			name = "& bag~ of cooked white rice"
			display = ',' color = color.ANTIQUE_WHITE
			desc =
			{
				"A small bag of white rice, cooked in a rice cooker. Ordinarily grains of rice are",
				"coated with thin brown husks, but many people prefer the flavor and texture of",
				"de-husked rice.",
			}
			level = 999 weight = 1 cost = 3
			allocation = { {999,1} }
			flags = {
				SPECIAL_GENE = true
				ON_EAT     = food.eat_good
				FOOD_VALUE = 2000
			}
		}
		[SV_COOKED_BROWN_RICE] = {
			name = "& bag~ of cooked brown rice"
			display = ',' color = color.UMBER
			desc =
			{
				"A small bag of brown rice, cooked in a rice cooker. With the husks still on the grains,",
				"brown rice contains more nutrients than white rice.",
			}
			level = 999 weight = 1 cost = 3
			allocation = { {999,1} }
			flags = {
				SPECIAL_GENE = true
				ON_EAT     = food.eat_good
				FOOD_VALUE = 2500
			}
		}
		[SV_BAG_OF_WHITE_RICE] = {
			name = "& bag~ of white rice"
			display = ',' color = color.ANTIQUE_WHITE
			desc =
			{
				"A large bag of uncooked white rice. You'll need a rice cooker to prepare this.",
			}
			level = 12 weight = 100 cost = 3
			allocation = { {12,1} }
			flags = {
				WHITE_RICE=true
				EAT_PRE = function()
					message("You must cook it first.")
					return true
				end
				ON_EAT     = function()
					message("You should never see this.")
				end
			}
		}
		[SV_BAG_OF_BROWN_RICE] = {
			name = "& bag~ of brown rice"
			display = ',' color = color.UMBER
			desc =
			{
				"A large bag of uncooked brown rice. You'll need a rice cooker to prepare this.",
			}
			level = 12 weight = 100 cost = 3
			allocation = { {12,1} }
			flags = {
				BROWN_RICE=true
				EAT_PRE = function()
					message("You must cook it first.")
					return true
				end
				ON_EAT     = function()
					message("You should never see this.")
				end
			}
		}
	}

	[TV_SUSHI] =
	{
		color = color.LIGHT_BLUE
		name = "sushi"
		desc =
		{
			"Sushi is raw fish wrapped up with rice.",
		}
		symbol = ','
		defaults = {
			display = ','
			flags = {
				EASY_KNOW  = true
				FOOD_VALUE = 500
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}
		[SV_SUSHI_UNAGI] = {
			name = "& piece~ of unagi"
			display = ',' color = color.LIGHT_BLUE
			desc =
			{
				"This particular piece is made with freshwater eel.",
			}
			level = 100 weight = 1 cost = 500
			allocation = { {100,99} }
			flags = {
				ON_EAT= food.eat_sushi
			}
		}
		[SV_SUSHI_ANAGO] = {
			name = "& piece~ of anago"
			display = ',' color = color.LIGHT_BLUE
			desc =
			{
				"This particular piece is made with saltwater eel.",
			}
			level = 100 weight = 1 cost = 500
			allocation = { {100,99} }
			flags = {
				ON_EAT= food.eat_sushi
			}
		}	
		[SV_SUSHI_SABA] = {
			name = "& piece~ of saba"
			display = ',' color = color.LIGHT_BLUE
			desc =
			{
				"This particular piece is made",
				"with mackeral. It's a very strongly flavored fish, and while very tasty",
				"it tends to be a bit too strong for the casual sushi eater.",
			}
			level = 100 weight = 1 cost = 500
			allocation = { {100,99} }
			flags = {
				ON_EAT= food.eat_sushi
			}
		}	
		[SV_SUSHI_TAKKO] = {
			name = "& piece~ of takko"
			display = ',' color = color.LIGHT_BLUE
			desc =
			{
				"This particular piece is made with octopus. (Wait...octopus or squid?)",
			}
			level = 100 weight = 1 cost = 500
			allocation = { {100,99} }
			flags = {
				ON_EAT= food.eat_sushi
			}
		}	
		[SV_SUSHI_FUGU] = {
			name = "& piece~ of fugu"
			display = ',' color = color.LIGHT_BLUE
			desc =
			{
				"Fugu, or blowfish, is a rare delicacy, prepared by carefully cutting the blowfish",
				"into very thin slices. Carefully because blowfish contains one of the deadlier",
				"of poisons, and serving only the portions of the fish that do not contain venom",
				"is something of an art.",
			}
			level = 100 weight = 1 cost = 500
			allocation = { {100,99} }
			flags = {
				ON_EAT=function(obj)
					local old_num = obj.number
					obj.number = 1
					timed_effect.inc(timed_effect.FOOD, 500)
					obj.number = old_num
					if rng(3) == 1 then
						message("Mmmm! Yummy...but...why can't you feel your tongue?")
						dball_data.fugu = true
					else
						message("Mmmm! Yummy dead fish!")
					end
					return true
				end
			}
		}	
	}


	-- NOTE: TV_BATTERY is used for any and all items intended to be used to re fill/fuel/charge
	-- something else (except bullets and missile, we're grandfather clausing those)

	[TV_BATTERY] =
	{
		color = color.YELLOW
		name = "Battery"
		desc = {
			"Any item used to charge, refill, or refuel."
		}
		symbol = '!'

		[SV_BATTERY_BATTERY] = {
			name = "& battery~"
			desc = {"This is a battery.",
			}
			display = '!' color = color.YELLOW
			level = 0 weight = 1 cost = 10
			allocation = { {0,1}, {5,1} }
			flags = {
				EASY_KNOW = true
				BATERIE = true
				DISCIPLINE = 1
				ITEM_TECHNO=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
				TECHNO_EXPLODE = getter.damages{FIRE = {1,10}}
				ITEM_ACCESSORY=true

			}
		}
		[SV_BATTERY_FLAME_RETARDANT] = {
			name = "& canister~ of flame retardant"
			desc = {"Frothy chemical goo good for putting out fires. Is primarily used to refill",
				"fire extingishers.",
			}
			display = '!' color = color.YELLOW
			level = 8 weight = 1 cost = 200
			allocation = { {5,1}, {10,1} }
			flags = {
				FLAME_RETARDANT=true
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=3
				DISCIPLINE = 3
				ITEM_TECHNO=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 2
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 2
				TECHNO_EXPLODE = getter.damages{FIRE = {10,100}}
			}
		}
		[SV_BATTERY_OXYGEN_TANK] = {
			name = "& oxygen tank~"
			desc = {"A heavy steel oxygen tank with a valve intended to be used with SCUBA gear.",
			}
			display = '!' color = color.YELLOW
			level = 14 weight = 300 cost = 200
			allocation = { {14,3} }
			flags = {
				OXYGEN_TANK=true
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=3
				ITEM_TECHNO=true
				DISCIPLINE = 3
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 2
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 2
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {20,200}}
			}
		}
		[SV_BATTERY_PROPANE] = {
			name = "& propane tank~"
			desc = {
				"A metal tank of highly flammable, pressurized gas.",
			}
			display = '!' color = color.RED
			level = 8 weight = 1 cost = 250
			allocation = { {5,1}, {10,1} }
			flags = {
				PROPANE=true
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=3
				DISCIPLINE = 3
				ITEM_TECHNO=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 2
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 2
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {10,1000}}
			}
		}
		[SV_BATTERY_NAILS] = {
			name = "& box~ of nails"
			desc = {"A box of nails.",
			}
			display = '!' color = color.LIGHT_DARK
			level = 0 weight = 1 cost = 50
			allocation = { {0,1}, {5,1} }
			flags = {
				AMMO=FLAG_AMMO_STANDARD
				AMMO_DAMAGE=getter.damages{PIERCE = {1,10}}
				AMMO_AOE=FLAG_AOE_BEAM
				EASY_KNOW = true
				BATERIE = true
				ITEM_TECHNO=true
				NAILS = true
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
			}
		}
	}

	[TV_LITE] =
	{
		color = color.YELLOW
		name = "lites"
		desc =
		{
			"These may enable you to see in the depths of the dungeon.",
		}
		symbol = '~'
		defaults =
			{
			flags =
				{
					WIELD_SLOT = INVEN_WIELD
					CAPSULED=false
					CAPSULE_WEIGHT=0
					ITEM_TECHNO=true
				}
			}

		[SV_FLASHLIGHT] = {
			name = "& flashlight~ #"
			display = '~' color = color.BLUE
			desc =
			{
				"A small flashlite that will help you see in the dark. Takes batteries.",
			}
			level = 1 weight = 30 cost = 10
			allocation = { {1,2}, {4,1}, {6,1}, {8,1} }
			flags = {
				LITE  = obvious(2)
				EASY_KNOW = true
				BREAKAGE_CHANCE = 50
				FUEL  = obvious(4000)
				FUEL_CAPACITY = 4000
				FUEL_LITE  = obvious(true)
				FUEL_REQUIRE = FLAG_BATERIE
				FUEL_USE = FLAG_USE_ALWAYS
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				ITEM_ACCESSORY=true
			}
		}
		[SV_SAFETY_FLASHLIGHT] = {
			name = "& safety flashlight~"
			display = '~' color = color.LIGHT_BLUE
			desc =
			{
				"A small flashlight with a built-in magnetic coil recharger. Simply by shaking",
				"the flashlight back and forth a few times, this flashlight may be recharged.",
				"Infinite use comes at a cost, however: the light emmitted by this flashlite",
				"is not very bright.",
			}
			level = 5 weight = 50 cost = 35
			allocation = { {6,1}, {8,1} }
			flags = {
				LITE  = obvious(1)
				EASY_KNOW = true
				BREAKAGE_CHANCE = 50
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
			}
		}
		[SV_MAGLIGHT] = {
			name = "& maglight~ #"
			display = '~' color = color.LIGHT_BLUE
			desc =
			{
				"A heavy duty flashlite heavy enough to be used as a club, if need be. Takes",
				"batteries.",
			}
			level = 7 weight = 50 cost = 250
			allocation = { {8,3}, {21,1}, {23,1}, {31,1}, {33,1}, {41,1}, {43,1} }
			flags = {
				WEAPON  = true
				EASY_KNOW = true
				BREAKAGE_CHANCE = 20
				LITE  = obvious(3)
 				FUEL  = obvious(8000)
				FUEL_CAPACITY = 8000
				FUEL_LITE  = obvious(true)
				FUEL_REQUIRE = FLAG_BATERIE
				FUEL_USE = FLAG_USE_ALWAYS
				DAM = getter.damages{CRUSH = {1,6}}
				MAGLIGHT=true
				DIFFICULTY = 3
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=1
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
			}
		}
	}

	[TV_GOLD] =
	{
		color = color.YELLOW
		name = "money"
		desc =
		{
			"It's the *love* of money that's the root of all evil",
			"So if you don't love it, it's safe to collect as",
			"much as you can, right?",
		}
		defaults = { flags = { CAPSULED=getter.array{0, 0}} }
		symbol = '$'
		[1] = {
			name = "a few zeni"
			display = '$' color = color.UMBER
			level = 1 weight = 0 cost = 3
			flags = {
				GOLD_VALUE = 5
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. amount .. " zeni")
					return amount
				end
			}
		}
		[2] = {
			name = "a few zeni"
			display = '$' color = color.UMBER
			level = 5 weight = 0 cost = 4
			flags = {
				GOLD_VALUE = 10
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. amount .. " zeni")
					return amount
				end
			}
		}
		[3] = {
			name = "a few zeni"
			display = '$' color = color.UMBER
			level = 10 weight = 0 cost = 5
			flags = {
				GOLD_VALUE = 15
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. amount .. " zeni")
					return amount
				end
			}
		}
		[4] = {
			name = "a small billfold"
			display = '$' color = color.SLATE
			level = 15 weight = 0 cost = 6
			flags = {
				GOLD_VALUE = 20
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[5] = {
			name = "a small billfold"
			display = '$' color = color.SLATE
			level = 20 weight = 0 cost = 7
			flags = {
				GOLD_VALUE = 25
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[6] = {
			name = "a billfold"
			display = '$' color = color.SLATE
			level = 25 weight = 0 cost = 8
			flags = {
				GOLD_VALUE = 30
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[7] = {
			name = "a billfold"
			display = '$' color = color.RED
			level = 30 weight = 0 cost = 9
			flags = {
				GOLD_VALUE = 35
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[8] = {
			name = "a thick billfold"
			display = '$' color = color.RED
			level = 35 weight = 0 cost = 10
			flags = {
				GOLD_VALUE = 40
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[9] = {
			name = "a thick billfold"
			display = '$' color = color.YELLOW
			level = 40 weight = 0 cost = 12
			flags = {
				GOLD_VALUE = 45
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[10] = {
			name = "a thick billfold"
			display = '$' color = color.YELLOW
			level = 45 weight = 0 cost = 14
			flags = {
				GOLD_VALUE = 50
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[11] = {
			name = "a very thick billfold"
			display = '$' color = color.YELLOW
			level = 50 weight = 0 cost = 16
			flags = {
				GOLD_VALUE = 55
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[12] = {
			name = "a very thick billfold"
			display = '$' color = color.LIGHT_WHITE
			level = 55 weight = 0 cost = 18
			flags = {
				GOLD_VALUE = 60
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[13] = {
			name = "a very thick billfold"
			display = '$' color = color.BLUE
			level = 60 weight = 0 cost = 20
			flags = {
				GOLD_VALUE = 65
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni")
					return amount
				end
			}
		}
		[14] = {
			name = "a credit card"
			display = '$' color = color.RED
			level = 65 weight = 0 cost = 24
			flags = {
				GOLD_VALUE = 70
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni on it")
					return amount
				end
			}
		}
		[15] = {
			name = "a credit card"
			display = '$' color = color.WHITE
			level = 70 weight = 0 cost = 28
			flags = {
				GOLD_VALUE = 75
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni on it")
					return amount
				end
			}
		}
		[16] = {
			name = "a credit card"
			display = '$' color = color.GREEN
			level = 75 weight = 0 cost = 32
			flags = {
				GOLD_VALUE = 80
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni on it")
					return amount
				end
			}
		}
		[17] = {
			name = "a credit card"
			display = '$' color = color.LIGHT_BLUE
			level = 80 weight = 0 cost = 40
			flags = {
				GOLD_VALUE = 85
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni on it")
					return amount
				end
			}
		}
		[18] = {
			name = "a platinum card"
			display = '$' color = color.LIGHT_GREEN
			level = 85 weight = 0 cost = 80
			flags = {
				GOLD_VALUE = 90
				MONEY_PICKUP = function(amount, name)
					message("You have found " .. name .. " with " .. amount .. " zeni on it")
					return amount
				end
			}
		}
	}

	[TV_BRACELET] =
	{
		color = color.RED
		name = "bracelets"
		desc = {
			"Decorative jewelry worn on the wrist.",
			}
		symbol = '"'
		defaults = {
			display = '"'
			flags = {
				WIELD_SLOT = obvious(INVEN_WRIST)
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}

		[SV_WATCH] = {
			name = "& watch~"
			desc = {
				"This convenient little device will let you keep track of the time.",
				}
			color = color.YELLOW
			level = 10 weight = 2 cost = 500
			allocation = { {5, 5}, {15, 3}, {21, 1}, {25, 1}, {33, 1} }
			flags = {
				TIMEPIECE=true
				DISCIPLINE = 2
				ITEM_MILITARY=true
				ITEM_ACCESSORY=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 1
			}
		}
-- What should this do?
--[[
		[SV_PULSE_MONITOR] = {
			name = "& pulse monitor~"
			desc = {
				"This device straps onto your wrist and monitors your blood pressure and heart rate,",
				"thus allowing you to more accurately pace yourself, and prevent over exertion.",
				}
			color = color.RED
			level = 10 weight = 2 cost = 250
			allocation = { {10, 1} }
			flags = {
			}
		}
]]
	}


	[TV_JEWELRY] =
	{
		color = color.YELLOW
		name = "jewelry"
		desc = {
			"Oooh! Pretty!",
		}
		symbol = '='
		defaults = {
			flags = {
				ID_SKILL=SKILL_INTELLIGENCE
				ID_VALUE=0
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}

		[SV_RING] = {
			name = "& plain gold ring~"
			desc = {
				"A plain gold ring",
			}

			display = '=' color = color.YELLOW
			level = 10 weight = 2 cost = 750
			allocation = { {10, 1} }
			flags = {
				WIELD_SLOT=obvious(INVEN_RING)
			}
		}
		[SV_EARING] = {
			name = "& earing~"
			desc = {
				"A sparkly earing",
			}

			display = '"' color = color.YELLOW
			level = 10 weight = 1 cost = 750
			allocation = { {10, 1} }
			flags = {
				WIELD_SLOT = INVEN_HEAD
			}
		}
	}

	[TV_JUNK] =
	{
		color = color.WHITE
		name = "junk"
		desc = {
			"Junk is usually worthless, though beauty is often",
			"in the eye of the beholder."
		}
		symbol = '~'
		defaults = {
			flags = {
				EASY_KNOW=true
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}

		[SV_COMIC_BOOK] = {
			name = "& comic book~"
			desc = {"A fairly obscure work from an author you've never heard of."}

			display = '~' color = color.LIGHT_DARK
			level = 0 weight = 1 cost = 10
			allocation = { {0, 1} }
			flags = {
			}
		}

		[SV_MANGA] = {
			name = "& manga book~"
			desc = {"A fairly obscure work from an author you've never heard of."}

			display = '~' color = color.LIGHT_DARK
			level = 0 weight = 1 cost = 12
			allocation = { {0, 1} }

			flags = {
			}
		}

		[SV_KUNG_FU_VIDEO] = {
			name = "& kung fu video~"
			desc = {
				"An extremely badly dubbed martial arts flick. The acting is worse than",
				"your typical junior high school production, the fight scene choreography",
				"is even worse, and clearly actors were hired to do the film rather than",
				"martial artists. You know all this because you've seen this particular",
				"film about a dozen times.",
			}
			display = '~' color = color.LIGHT_UMBER
			level = 0 weight = 1 cost = 20
			allocation = { {0, 1} }

			flags = {
			}
		}
		[SV_BASEBALL] = {
			name = "& baseball~"
			desc = {"It's a baseball."}
			display = 'o' color = color.WHITE
			level = 0 weight = 1 cost = 12
			allocation = { {1, 1} }

			flags = {
			}
		}
		[SV_SOCCER_BALL] = {
			name = "& soccer ball~"
			desc = {"It's a soccer ball. Or, a 'futbol' for those outside the US."}
			display = 'o' color = color.WHITE
			level = 0 weight = 1 cost = 12
			allocation = { {1, 1} }

			flags = {
			}
		}
		[SV_UMBRELLA] = {
			name = "& umbrella~"
			desc = {"It's an umbrella."}
			display = '~' color = color.LIGHT_UMBER
			level = 0 weight = 1 cost = 12
			allocation = { {1, 1} }
			flags = {
			}
		}
		[SV_DOJO_SIGN] = {
			name = "& dojo sign~"
			desc = {
				"It says 'Leaping Aardvark Kung-fu.' No, wait...maybe it's 'Lecherous Squirrel-Do.",
				"Hmm. Could be 'Platypus Crossing.' You're really not sure. It probably doesn't matter",
				"though, since whatever style it was didn't produce martial artists talented enough even",
				"to keep this sign from being stolen off the front of their studio."
			}
			display = '~' color = color.LIGHT_UMBER
			level = 2 weight = 1 cost = 12
			allocation = { {2, 1} }

			flags = {
				ITEM_JAPANESE=true
			}
		}
	}

	[TV_TOOL] = {
		color = color.SLATE
		name = "tools",
		desc = {
			"Describe me!",
		}

		defaults = {
			flags = {
				EASY_KNOW  = true
				WIELD_SLOT = obvious(INVEN_TOOL)
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}

		[SV_SHOVEL] = {
			name = "& shovel~"
			desc = {"A simple digging tool for shovelling away rubble and",
				"maybe even soft rock."}
			display = '\\' color = color.SLATE
			level = 5 weight = 60 cost = 20
			allocation = { {5, 2} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				-- TUNNEL = obvious(1)
				-- DIGGER = obvious(true)
				DBT_DIGGER=10
				DISCIPLINE=4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
			}
		}

		[SV_PICK] = {
			name = "& pick~"
			desc = {"A heavy digging tool, primarily for earthworking,",
				"but also good for tunnelling through stone, if one is",
				"willing to perform the time-consuming labour."}

			display = '\\' color = color.SLATE
			level = 8 weight = 150 cost = 50
			allocation = { {8, 3} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=3
				DISCIPLINE=4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				DBT_DIGGER=20
			}
		}
	}

	[TV_ELECTRONICS] = {
		color = color.LIGHT_BLUE
		name = "Electronics",
		desc = {
			"A device, tool, or piece of electronics.",
		}

		defaults = {
			flags = {
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_TECHNO=true
			}
		}

		[SV_COMPASS] = {
			name = "compass"
			desc = {"A small device that helps you keep your bearings.",
			}
			display = '\\' color = color.SLATE
			level = 8 weight = 1 cost = 10
			allocation = { {6, 3}, {8, 2}, {21, 1}, {23, 1}, {31, 1}, {33, 1}, {41, 1}, {43, 1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				USEABLE = 20
				TECH_REQUIRE = 1
				ITEM_MILITARY=true
				ITEM_ACCESSORY=true
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_GPS] = {
			name = "global positioning system"
			desc = {"This device remotely communicates with satellites to keep you informed",
				"of exactly where you are at all times.",
			}
			display = '\\' color = color.SLATE
			level = 15 weight = 20 cost = 300
			allocation = { {15, 5} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=5
				USEABLE = 21
				TECH_REQUIRE = 3
				ITEM_MILITARY=true
				ITEM_ACCESSORY=true
				DISCIPLINE = 2
				INGRED1_WHAT = TV_CIRCUITRY
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_CELL_PHONE] = {
			name = "cell phone"
			desc = {"Cell phones allow you to contact anyone who has given you their phone number.",
				"You wlil, of course, need to make regular payments to keep your service running.",
			}
			display = '\\' color = color.SLATE
			level = 25 weight = 3 cost = 200
			allocation = { {25, 5} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				USEABLE = 22
				TECH_REQUIRE = 1
				ITEM_ACCESSORY=true
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 1
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_METAL_DETECTOR] = {
			name = "metal detector"
			desc = {
				"A largish electronic device that detects the presence of metals. When equipped",
				"it will inform you of the presence of hidden metal objects such as traps in",
				"your immediate vicinity, but at a slight cost in speed.",
			}
			display = '\\' color = color.SLATE
			level = 4 weight = 40 cost = 250
			allocation = { {4, 1}, {10, 1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=7
				TECH_REQUIRE = 12
				ITEM_MILITARY=true
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 5
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 5
				WIELD_SLOT = obvious(INVEN_TOOL)
				SPEED = -5
				TRAP_DETECTOR=true
			}
		}
		[SV_LASER_POINTER] = {
			name = "laser pointer"
			desc = {"It looks like a pen, but when you press this little button it emits",
				"a tiny red beam of laser light. Don't point it in your eyes, it might make",
				"you blind. Takes batteries.",
			}
			display = '\\' color = color.SLATE
			level = 5 weight = 1 cost = 50
			allocation = { {5, 3} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				FUEL  = obvious(5)
				FUEL_CAPACITY = 5
				FUEL_REQUIRE = FLAG_BATERIE
				USEABLE = 24
				ITEM_PLAIN=true
				ITEM_ACCESSORY=true
				TECH_REQUIRE = 3
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_BINOCULARS] = {
			name = "binoculars"
			desc = {"A handheld set of telescopic lenses placed over the eyes to allow you to see",
				"at a great distance. To use, equip them and use the 'L'ook command.",
			}
			display = '\\' color = color.SLATE
			level = 3 weight = 30 cost = 60
			allocation = { {3, 3}, {21, 1} }

			flags = {
				BINOCULARS=true
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				TECH_REQUIRE = 1
				ITEM_PLAIN=true
				ITEM_MILITARY=true
				ITEM_ACCESSORY=true
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 1
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_SCUBA_GEAR] = {
			name = "SCUBA gear"
			desc = {"Self Contained Underwater Breathing Apparatus. Or, if this case: a full body",
				"wet-suit to keep you warm, fins to allow you to move, a mask to help you to see,",
				"and an oxygen tank to allow you to breath. It is very bulky, and the oxygen in",
				"the tank will periodically need to be recharged.", 
			}
			display = '\\' color = color.SLATE
			level = 18 weight = 600 cost = 1500
			allocation = { {21, 3}, {25, 2}, {31, 1}, {35, 1} }
			ac = 5
			to_h = -20

			flags = {
				-- Handled by FEAT_DEEP_WATER
				--MAGIC_BREATH = true
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_ALWAYS
				FUEL  = obvious(12000)
				FUEL_CAPACITY = 12000
				FUEL_REQUIRE = FLAG_OXYGEN_TANK
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=7
				ITEM_MILITARY=true
				TECH_REQUIRE = 12
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 4
				SHOW_MODS=true
				WIELD_SLOT = obvious(INVEN_TOOL)
			    	RESIST = getter.array{
						[dam.SLASH] = 10
						[dam.COLD] = 50
						[dam.FIRE] = -20
						[dam.SHARDS] = 10
					}
			}
		}
		[SV_LAPTOP] = {
			name = "laptop"
			desc = {
				"A small, portable computer with Internet access via satellite. You can look",
				"up anything online.",
			}
			display = '\\' color = color.BLUE
			level = 18 weight = 1 cost = 2500
			allocation = { {21, 3}, {25, 1}, {31, 1}, {33, 1}, {41, 1}, {43, 1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=7
				USEABLE = 25
				TECH_REQUIRE = 30
				ITEM_MILITARY=true
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 4
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 4
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 4
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_RICE_COOKER] = {
			name = "rice cooker"
			desc = {
				"A small, portable rice cooker with the manufacturer and model name inscribed on",
				"the side: Denshi Jar. ",
			}
			display = '~' color = color.BLUE
			level = 1 weight = 2 cost = 100
			allocation = { {1, 1}, {4, 1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				USEABLE = 26
				TECH_REQUIRE = 1
				ITEM_ACCESSORY=true
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_MEGAPHONE] = {
			name = "megaphone"
			desc = {
				"A handheld device about a foot long that amplifies ones ones voice many times",
				"over. I bet if you screamed into this you could really get somebody's attention.",
				"Takes batteries.",
			}
			display = '~' color = color.LIGHT_RED
			level = 7 weight = 20 cost = 350
			allocation = { {7, 3} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				FUEL  = obvious(4)
				FUEL_CAPACITY = 4
				FUEL_REQUIRE = FLAG_BATERIE
				USEABLE = 27
				ITEM_MILITARY=true
				ITEM_ACCESSORY=true
				TECH_REQUIRE = 3
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 2
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_ROAD_FLARE] = {
			name = "road flare"
			desc = {

				"This mighty ring was given to Flare by Celegorm when...oh, wait. Wrong game. *ahem*",
				"A small, self-contained stick of chemicals that, when a small piece of thread is",
				"pulled, initiates a reaction that causes a slow, light-emmiting burn which lasts",
				"for several hours. Kind of like a scroll of light, only not.",
			}
			display = '~' color = color.LIGHT_RED
			level = 5 weight = 20 cost = 20
			allocation = { {2, 3}, {5, 1}, {6, 1}, {8, 1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				USEABLE = 28
				TECH_REQUIRE = 2
				ITEM_ACCESSORY=true
				DISCIPLINE = 3
				INGRED1_WHAT = TV_CHEMISTRY
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				TECHNO_EXPLODE = getter.damages{FIRE = {10,100}}
			}
		}
		[SV_FIRE_EXTINGUISHER] = {
			name = "fire extinguisher"
			desc = {
				"A pressurized tank of fire-extinguishing chemicals with a spray nozzle. The tank",
				"will periodically need to be refilled with flame retardant.",
			}
			display = '~' color = color.RED
			level = 7 weight = 100 cost = 350
			allocation = { {7, 3} }

			flags = {
				FUEL  = obvious(3)
				FUEL_CAPACITY = 3
				FUEL_REQUIRE = FLAG_FLAME_RETARDANT
				EXPLOSIVE=true
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {10,100}}
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=3
				USEABLE = 29
				TECH_REQUIRE = 3
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 3
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_FLAME_THROWER] = {
			name = "flame thrower"
			desc = {
				"A tank of highly flammable gas attached to a valve and directional muzzle with",
				"a torch on it. Allows one to throw flames at a distance. The propane fuel tank",
				"will periodically need to be refilled.",
			}
			display = '~' color = color.RED
			level = 7 weight = 100 cost = 1250
			allocation = { {7, 3} }

			flags = {
				FUEL  = obvious(6)
				FUEL_CAPACITY = 6
				FUEL_REQUIRE = FLAG_PROPANE
				EXPLOSIVE=true
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=7
				USEABLE = 23
				TECH_REQUIRE = 12
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 3
				WIELD_SLOT = obvious(INVEN_TOOL)
				ITEM_MILITARY=true
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {10,100}}
			}
		}
		[SV_DRAGON_RADAR] = {
			name = "dragon radar"
			desc = {
				"This device picks up the unusual wavelengths given off by the Dragonballs. When equipped,",
				"the dragon radar will inform its user upon entering areas that contain a dragonball.",
			}
			display = '~' color = color.RED
			level = 100 weight = 50 cost = 4000
			allocation = { {100, 999} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=15
				DRAGON_RADAR = true
				SPECIAL_GENE=true
				-- USEABLE = 29 -- Is the dragon radar activatable?
				TECH_REQUIRE = 30
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 2
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_NIGHTVISION_GOGGLES] = {
			name = "nightvision goggles"
			desc =
			{
				"A high-tech headpiece that amplifies the available light, thus effectively",
				"allowing you to see in the dark."
			}
			display = ')'
			color = color.SLATE
			level = 32 weight = 40 cost = 2000
			allocation = { {31,2}, {33,1}, {41,1}, {43,1} }
			ac = 0
			flags = {
				LITE  = 3
				TECH_REQUIRE = 7
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=15
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 2
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 2
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 2
				WIELD_SLOT = INVEN_HEAD
				ITEM_MILITARY=true
			}		
		}
		[SV_INFRARED_GOGGLES] = {
			name = "infrared goggles"
			desc =
			{
				"A high-tech headpiece that makes use of and amplifies whatever light is available",
				"to see, even if that light is not ordinarily within the human visible spectrum."
			}
			display = ')'
			color = color.SLATE
			level = 32 weight = 40 cost = 2000
			allocation = { {31,2}, {33,1}, {41,1}, {43,1} }
			ac = 0
			flags = {
				-- Does this work?
				INFRA = 5
				-- SEE_INVIS=obvious(true)
				TECH_REQUIRE = 7
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=15
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 2
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 2
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 2
				WIELD_SLOT = INVEN_HEAD
				ITEM_MILITARY=true
			}		
		}
		[SV_BALLISTIC_PLATE] = {
			name = "ballistic plate"
			desc =
			{
				"A heavy metal plate which may be optionally inserted into normal ballistic",
				"armor to cover and protect the heart, sternum, and some of the chest. About",
				"three eighths of an inch of solid steel, it will stop most bullets even",
				"at point-blank range, but the weight and inflexible bulk will seriously",
				"hinder the complicated motions of melee combat. 'U'se ballistic plates",
				"to insert them into armor.",
			}
			display = ')'
			color = color.SLATE
			level = 32 weight = 200 cost = 2000
			allocation = { {31,2}, {33,1}, {41,1}, {43,1} }
			ac = 10
			to_h = -10
			flags = {
				-- This should never be wieldable but...
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				SHOW_COMBAT_MODS=true
				USEABLE=2
				TECH_REQUIRE = 4
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=10
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				ITEM_MILITARY=true
			    	RESIST = getter.array{
						[dam.BALLISTIC] = 10
						[dam.SHARDS] = 10
					}
			}		
		}
		[SV_SILENCER] = {
			name = "silencer"
			desc =
			{
				"A silencer and flash suppressor which may be mounted to the barrel of otherwise",
				"noisy firearms. May only be applied to handguns, not missile launchers.",
			}
			display = ')'
			color = color.SLATE
			level = 32 weight = 20 cost = 1400
			allocation = { {31,2}, {33,1}, {41,1}, {43,1} }
			flags = {
				USEABLE=3
				TECH_REQUIRE = 4
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=10
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				ITEM_MILITARY=true
			}		
		}
		[SV_SCOPE] = {
			name = "scope"
			desc =
			{
				"A rifle scope. This may be fitted to any rifle or bazooka via the 'u'se command.",
				"When firing with a scoped rifle, all targets are treated as if they are 5 squares",
				"closer.",
			}
			display = ')'
			color = color.SLATE
			level = 32 weight = 5 cost = 1400
			allocation = { {31,1}, {33,1}, {41,1}, {43,1} }
			flags = {
				USEABLE=4
				TECH_REQUIRE = 3
				ID_SKILL=SKILL_MARKSMANSHIP
				ID_VALUE=10
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				ITEM_MILITARY=true
			}		
		}
		[SV_MUSCLE_STIMULATOR] = {
			name = "muscle stimulator"
			desc = {
				"This fascinating little device generates electrical pulses at levels",
				"that your body responds to. Simply put, you attach electrodes to both ",
				"ends of the muscle you'd like to work, turn the device on, and relax.",
				"Pulses are delivered directly to your muscles that cause them to",
				"alternately tense, then relax...over and over. This allows you to 'work'",
				"a single muscle without actually having to do any work yourself. You simply",
				"turn it on and relax, watch tv, sleep, anything you'd like. It's a great",
				"concept, but it does have a few limitations: first, while muscles respond",
				"very well to it, other supportive tissues like tendons and ligaments tend",
				"not to, so it is possible to build the strength of your muscles beyond the",
				"capacity of your body to acccomodate. Second: the effect is extremely isolated,",
				"and anyone who has lifted weights knows that, for example, when you do curls",
				"you're getting just as much a workout in your hands and forearms as your biceps.",
				"The stimulator works ONLY one muscle. Third: It's generally not a good idea",
				"to apply electrical pulses near the chest, as you don't want to induce cardiac",
				"arrest. So, while you'd be fine using the stimulator on your calves, you probably",
				"wouldn't want to apply it on your pectorals.",
			}
			display = '~' color = color.LIGHT_RED
			level = 100 weight = 20 cost = 2000
			allocation = { {100, 999} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				USEABLE = 30
				TECH_REQUIRE = 2
				DISCIPLINE = 2
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 1
			}
		}
		[SV_MECHANICAL_TOOLKIT] = {
			name = "mechanical toolkit"
			desc = {"A small metal box containing a broad assortment of mechanical",
				"tools: wrenches, hammers, screwdrivers, etc.",
			}
			display = '\\' color = color.SLATE
			level = 60 weight = 150 cost = 500
			allocation = { {31,2}, {33,1}, {41,1}, {43,1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=5
				USEABLE=200
				TECH_REQUIRE = 30
				ITEM_MILITARY=true
				DISCIPLINE=4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
			}
		}
		[SV_ELECTRICAL_TOOLKIT] = {
			name = "electrical toolkit"
			desc = {"A small kit containing a broad assortment of tools for building",
				"and repairing electronic devices: multi-meter, soldering iron, etc.",
			}
			display = '\\' color = color.SLATE
			level = 60 weight = 50 cost = 500
			allocation = { {60, 2} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=7
				USEABLE=201
				TECH_REQUIRE = 30
			}
		}
		[SV_CHEMISTRY_KIT] = {
			name = "chemistry kit"
			desc = {"A small kit containing everything neccesary for with chemicals: ",
				"vials, beakers, gloves, a burner, etc.",
			}
			display = '\\' color = color.SLATE
			level = 6 weight = 50 cost = 2000
			allocation = { {60, 3} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=10
				USEABLE=202
				TECH_REQUIRE = 30
			}
		}
		[SV_LATHE] = {
			name = "lathe"
			desc = {"A rotating engine built into a bench along with the necessary cutting",
				"shapes and tools to shape metal into any desired shape.",
			}
			display = '\\' color = color.SLATE
			level = 65 weight = 3000 cost = 7500
			allocation = { {31,2}, {33,1}, {41,1}, {43,1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=9
				USEABLE=203
				ITEM_MILITARY=true
				DISCIPLINE=4
				TECH_REQUIRE = 30
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 3
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 3
			}
		}
		[SV_SEWING_KIT] = {
			name = "sewing kit"
			display = '/' color = color.LIGHT_BLUE
			desc =
			{
				"A small sewing kit for mending torn garments.",
			}
			level = 12 weight = 10 cost = 35
			allocation = { {4,1}, {12,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=10
				TECH_REQUIRE = 30
				ITEM_PLAIN=true
				ITEM_ACCESSORY=true
				DISCIPLINE=1
				USEABLE = 204
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 1
			}
		}
		[SV_ACUPUNCTURE_NEEDLES] = {
			name = "acupuncture kit"
			desc = {"A small kit containing a dozen flexible needles of various sized. A skilled",
				"acupuncturist would be able to use them to restore himself, or others, to good",
				"health. Note, however, that while acupuncture is excellent for curing secondary",
				"conditions such as poison, confusion, blindness and stat drain, it isn't very",
				"good for repairing major physical damage, or mental fatigue. It is also quite",
				"time consuming. A typical session lasts about an hour, and you would be well",
				"advised to make sure you are not interupted during that time.",
			}
			display = '~' color = color.BLUE
			level = 12 weight = 2 cost = 500
			allocation = { {12, 3} }

			flags = {
				USEABLE = 10
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=5
			}
		}
		[SV_FIRST_AID_KIT] = {
			name = "first aid kit"
			desc = {
				"A small kit containing basic first aid supplies: gauze, band-aids, disinfectants,",
				"a needle and thread, tweezers, etc.",
			}
			display = '~' color = color.BLUE
			level = 20 weight = 5 cost = 500
			allocation = { {21,1}, {23,1}, {31,1}, {33,1}, {41,1}, {43,1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				USEABLE = 11
				ITEM_MILITARY=true
				ITEM_ACCESSORY=true
			}
		}
		[SV_EARPLUGS] = {
			name = "pair of earplugs"
			desc = {
				"A small set of earplugs. You can put them in your ears to muffle your hearing, but",
				"they're small, low-quality, and not likely to offer much protection.",
			}
			display = '\\' color = color.YELLOW
			level = 1 weight = 1 cost = 15
			allocation = { {1, 1}, {5,1} }

			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				WIELD_SLOT = obvious(INVEN_TOOL)
				RESIST = getter.resists{SOUND=10}
			}
		}
		[SV_MOUTHGUARD] = {
			name = "mouthguard"
			desc = {
				"A small rubber insert for your mouth that protects your teeth and jaw from",
				"blows.",
			}
			display = '[' color = color.YELLOW
			level = 1 weight = 1 cost = 15
			allocation = { {1, 1}, {5,1}, {10,1}, {13,1} }

			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=1
				ITEM_MARTIAL=true
				WIELD_SLOT = obvious(INVEN_TOOL)
				RESIST = getter.resists{CRUSH=5}
			}
		}
		[SV_CHAINSAW] = {
			name = "chainsaw"
			display = '/' color = color.LIGHT_DARK
			desc =
			{
				"A large, gasoline powered saw generally used for cutting trees. They do",
				"tend to be noisy, however.",
			}
			level = 8 weight = 100 cost = 200
			allocation = { {8,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=1
				TECH_REQUIRE = 5
				DISCIPLINE=4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
				WIELD_SLOT = obvious(INVEN_TOOL)
				CHAINSAW=true
				AGGRAVATE=true
			}
		}
		[SV_BLOWTORCH] = {
			name = "blowtorch"
			display = '/' color = color.LIGHT_RED
			desc =
			{
				"A small, propane torch",
			}
			level = 8 weight = 80 cost = 400
			allocation = { {8,1}, {22,1}, {32,1} }
			flags = {
				FUEL  = obvious(10)
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=4
				TECH_REQUIRE = 4
				DISCIPLINE=1
				FUEL_CAPACITY = 10
				FUEL_REQUIRE = FLAG_PROPANE
				EXPLOSIVE=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 1
				WIELD_SLOT = obvious(INVEN_TOOL)
				USEABLE = 33
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {10,100}}
			}
		}
		[SV_JETPACK] = {
			name = "jetpack"
			display = '/' color = color.LIGHT_RED
			desc =
			{
				"A large, chemically powered jetpack. Fueled by propane, by wearing this on",
				"your back you'll be able to fly, for a short while.",
			}
			level = 32 weight = 600 cost = 4000
			allocation = { {32,1} }
			flags = {
				FUEL  = obvious(10)
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=20
				TECH_REQUIRE = 30
				DISCIPLINE=4
				FUEL_CAPACITY = 10
				FUEL_REQUIRE = FLAG_PROPANE
				EXPLOSIVE=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 4
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 2
				INGRED4_WHAT = TV_CHEMISTRY
				INGRED4_QTY = 2
				WIELD_SLOT = obvious(INVEN_TOOL)
				TECHNO_EXPLODE = getter.damages{BALLISTIC = {10,100}}
			}
		}
		[SV_SCOUTER] = {
			name = "scouter"
			display = '/' color = color.VIOLET
			desc =
			{
				"A highly technical device worn over a single eye which allows the wearer to",
				"detect and analyze energy signature. Using a scouter will allow you to determine",
				"the relative power levels of your adversaries.",
			}
			level = 80 weight = 10 cost = 5000
			allocation = { {999,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=20
				SPECIAL_GENE=true
				TECH_REQUIRE = 20
				DISCIPLINE=2
				USEABLE = 34
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 1
				WIELD_SLOT = INVEN_HEAD
			}
		}
		[SV_NAILGUN] = {
			name = "nailgun"
			display = '/' color = color.TAN
			desc = {
				"Intended for explosively firing nails at extremely short range into wood during",
				"construction. Of course, flesh is much softer than wood.",
			}
			level = 21 weight = 50 cost = 1000
			allocation = { {21,1} }
			flags = {
				WIELD_SLOT = INVEN_WIELD
				SHOW_COMBAT_MODS = true
				MISSILE_WEAPON = true
				MISSILE_FIXED_DAMAGE = getter.damages{PIERCE = {1,10}}
				AMMO_CLASS = FLAG_ATYPE_LOOKUP_PROJ
				IAIDO=true
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_GUNS
				TECHNO_GAIN_TH = true
				MULTIPLIER = 1
				BASE_RANGE = 2
				FUEL  = 99
				FUEL_CAPACITY = 99
				FUEL_REQUIRE = FLAG_NAILS
				DIFFICULTY = 2
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=6
				TECH_REQUIRE = 6
				TECHNOMANCE=true	-- dbtstuff.lua: ignore marksmanship requirement to equip
				DISCIPLINE = 4
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
			}
		}
		[SV_JACKHAMMER] = {
			name = "jackhammer"
			display = '/' color = color.LIGHT_UMBER
			desc =
			{
				"A highly technical device worn over a single eye which allows the wearer to",
			}
			level = 80 weight = 1000 cost = 10000
			allocation = { {999,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=20
				TECH_REQUIRE = 30
				DISCIPLINE=4
				USEABLE = 35
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 4
				INGRED2_WHAT = TV_BULK_MATERIAL
				INGRED2_QTY = 2
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 2
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 2
				WIELD_SLOT = INVEN_TOOL
			}
		}
		[SV_REMOTE_STOP_DEVICE] = {
			name = "remote stop device"
			display = '/' color = color.RED
			desc =
			{
				"This simple transmitter sends an encoded self-destruct message to any of Dr.",
				"Gero's Androids. A simple, yet effective means of control, but it must be",
				"activated at extremely close range.",
			}
			level = 80 weight = 10 cost = 5000
			allocation = { {999,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=30
				TECH_REQUIRE = 1
				DISCIPLINE=2
				SPECIAL_GENE=true
				USEABLE = 36
				SPECIAL_GENE=true
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_HIGH_TECH_COMPONENTS
				INGRED3_QTY = 1
				WIELD_SLOT = INVEN_TOOL
			}
		}
		[SV_TELEVISION_REMOTE] = {
			name = "television remote"
			display = '/' color = color.LIGHT_DARK
			desc =
			{
				"A remote control for a television. A small red button near the top reads 'power.'",
			}
			level = 1 weight = 2 cost = 50
			allocation = { {999,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=0
				TECH_REQUIRE = 0
				DISCIPLINE=2
				SPECIAL_GENE=true
				USEABLE = 38
				INGRED1_WHAT = TV_CIRCUITRY
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 1
				WIELD_SLOT = INVEN_TOOL
			}
		}
		[SV_SCISSORS] = {
			name = "scissors"
			display = '/' color = color.LIGHT_DARK
			desc =
			{
				"A metal pair of scissors. Useful for cutting things.",
			}
			level = 1 weight = 1 cost = 10
			allocation = { {1,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=0
				TECH_REQUIRE = 0
				DISCIPLINE=4
				USEABLE = 205
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				WIELD_SLOT = INVEN_TOOL
			}
		}
	}

	[TV_GRENADE] = {
		color = color.GREEN
		name = "Thrown items",
		desc = {
			"Devices for throwing",
		}
		symbol = '~'
		defaults = {
			flags = {
				CAPSULED=false
				CAPSULE_WEIGHT=0
			}
		}
		[SV_FRAG_GRENADE] = {
			name = "& fragmentation grenade~"
			display = '*' color = color.GREEN
			desc =
			{
				"A small grenade designed to throw heavy metal shrapnel into nearby targets.",
			}
			level = 22 weight = 20 cost = 1000
			allocation = { {22,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=20
				TECH_REQUIRE = 3
				DISCIPLINE=3
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
				ITEM_MILITARY=true
				DBT_THROW_EFFECT=function(y, x)
					project(WHO_FLOOR, 1, y, x, rng(10,100), dam.BALLISTIC, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
				end
			}
		}
		[SV_INCENDIARY_GRENADE] = {
			name = "& incendiary grenade~"
			display = '*' color = color.LIGHT_RED
			desc =
			{
				"A small grenade designed to throw a sticy naplam-like substance onto nearby targets.",
			}
			level = 22 weight = 20 cost = 1000
			allocation = { {22,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=20
				TECH_REQUIRE = 3
				DISCIPLINE=3
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
				ITEM_MILITARY=true
				DBT_THROW_EFFECT=function(y, x)
					project(WHO_FLOOR, 1, y, x, rng(10,100), dam.FIRE, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
				end
			}
		}
		[SV_SMOKE_GRENADE] = {
			name = "& smoke grenade~"
			display = '*' color = color.UMBER
			desc =
			{
				"A small grenade designed to throw a massive cloud of smoke, hindering visibility",
				"for all.",
			}
			level = 22 weight = 10 cost = 1000
			allocation = { {22,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=20
				TECH_REQUIRE = 3
				DISCIPLINE=3
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 1
				INGRED2_WHAT = TV_CHEMISTRY
				INGRED2_QTY = 1
				INGRED3_WHAT = TV_CHEMISTRY
				INGRED3_QTY = 1
				ITEM_MILITARY=true
				DBT_THROW_EFFECT=function(y, x)
					fire_cloud(dam.PLITE, y, x, 5, 3, player.speed())
				end
			}
		}
		[SV_SHURIKEN] = {
			name = "& shuriken"
			display = '*' color = color.LIGHT_DARK
			desc =
			{
				"A metal pinwheel, intended for throwing. About four inches across, and nearly a centimeter",
				"thick, it is a real shuriken. Not one of those cheap imitations you find in Mexico.",
			}
			level = 15 weight = 5 cost = 350
			allocation = { {15,1}, {17,1}, {20,1} }
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=20
				-- If these can be lathed, what about regular metal melee weapons?
				-- DISCIPLINE=4
				-- INGRED1_WHAT = TV_BULK_MATERIAL
				-- INGRED1_QTY = 1
				ITEM_NINJA=true
				DBT_THROW_EFFECT=function(y, x)
					project(WHO_PLAYER, 0, y, x, rng(1,30), dam.PIERCE, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
				end
			}
		}
	}
	[TV_CIRCUITRY] = {
		color = color.SLATE
		name = "circuitry",
		desc = {
			"Various components used to build electronic circuits and devices.",
		}
		symbol = '~'
		defaults = {
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=5
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_TECHNO=true
			}
		}

		[SV_RESISTER] = {
			name = "& resistor~"
			desc = {"A small component used to inhibit the flow of electricity through",
				"a circuit.",
			}
			display = '~' color = color.SLATE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 1} }

			flags = {
			}
		}
		[SV_CAPACITOR] = {
			name = "& capacitor~"
			desc = {"A small component used to regulate the flow of electricity through",
				"a circuit.",
			}
			display = '~' color = color.SLATE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 1} }

			flags = {}
		}
		[SV_CIRCUIT_BOARD] = {
			name = "& circuit board~"
			desc = {"A fiberglass form upon which electrical circuits may be",
				"designed.",
			}
			display = '~' color = color.SLATE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 1} }

			flags = {}
		}
		[SV_SPOOL_OF_WIRE] = {
			name = "& spool~ of wire"
			desc = {
				"A roll of electricly conductive material commonly used in circuit design.",
			}
			display = '~' color = color.SLATE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 1} }

			flags = {}
		}
		[SV_SPOOL_OF_SOLDER] = {
			name = "& spool~ of solder"
			desc = {"Solder is a conductive metal composite with an extremely low melting point.",
				"It is commonly used as 'glue' to connect circuitry components.",
			}
			display = '~' color = color.SLATE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 1} }

			flags = {}
		}
		[SV_EPROM] = {
			name = "& eprom~"
			desc = {
				"Something of an oxymoron, an eprom or, 'electronically programmable read-only-memory'",
				"is a chip that can be programmed to perform a task.",
				
			}
			display = '~' color = color.SLATE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 1} }

			flags = {}
		}
	}
	[TV_CHEMISTRY] = {
		color = color.WHITE
		name = "chemistry",
		desc = {
			"Chemicals",
		}
		symbol = '~'
		defaults = {
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=15
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_TECHNO=true
			}
		}

		[SV_IRON] = {
			name = "powdered iron"
			desc = {"Iron."}
			display = '~' color = color.WHITE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 2} }

			flags = {
			}
		}
		[SV_SULPHUR] = {
			name = "sulphur"
			desc = {"Sulphur."}
			display = '~' color = color.WHITE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 2} }

			flags = {
			}
		}
		[SV_SODIUM_PERMANGANATE] = {
			name = "sodium permanganate"
			desc = {"Sodium permanganate."}
			display = '~' color = color.WHITE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 2} }

			flags = {
			}
		}
		[SV_HYDROGEN_TETRACHLORIDE] = {
			name = "hydrogen tetrachloride"
			desc = {"Hydrogen tetrachloride."}
			display = '~' color = color.WHITE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 2} }

			flags = {
			}
		}
		[SV_ALUMINUM_DIOXIDE] = {
			name = "aluminum dioxide"
			desc = {"Aluminum dioxide"}
			display = '~' color = color.WHITE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 2} }

			flags = {
			}
		}
		[SV_ASSORTED_HYDROCARBONS] = {
			name = "assorted hydrocarbons"
			desc = {"Assorted hydrocarbons"}
			display = '~' color = color.WHITE
			level = 60 weight = 1 cost = 20
			allocation = { {60, 2} }

			flags = {
			}
		}
	}

	[TV_BULK_MATERIAL] = {
		color = color.WHITE
		name = "bulk materials",
		desc = {
			"Bulk materials used for large construction.",
		}
		symbol = '~'
		defaults = {
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=7
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_TECHNO=true
			}
		}

		[SV_STEEL] = {
			name = "& sheet~ of steel"
			desc = {"Steel. A nice, strong, sturdy material."}
			display = '~' color = color.WHITE
			level = 60 weight = 100 cost = 500
			allocation = { {60, 3} }

			flags = {
			}
		}
		[SV_ALUMINUM] = {
			name = "& sheet~ of aluminum"
			desc = {"Aluminum is often chosen for its light weight."}
			display = '~' color = color.WHITE
			level = 60 weight = 50 cost = 200
			allocation = { {60, 3} }

			flags = {
			}
		}
		[SV_TITANIUM] = {
			name = "& sheet~ of titanium"
			desc = {"Titanium is a plentiful material, and even stronger than steel."}
			display = '~' color = color.WHITE
			level = 60 weight = 100 cost = 700
			allocation = { {60, 3} }

			flags = {
			}
		}
		[SV_PLASTIFORM] = {
			name = "& sheet~ of plastiform"
			desc = {"Plastics are often used in construction."}
			display = '~' color = color.WHITE
			level = 1 weight = 50 cost = 200
			allocation = { {10, 2} }

			flags = {
			}
		}
		[SV_FIBERGLASS] = {
			name = "& sheet~ of fiberglass"
			desc = {"Fiberglass is strong, sturdy, but extremely heavy"}
			display = '~' color = color.WHITE
			level = 60 weight = 200 cost = 500
			allocation = { {60, 3} }

			flags = {
			}
		}
		[SV_TUBING] = {
			name = "& bag~ of tubing"
			desc = {"Tubes are such a wonderful invention! They are used to direct the flow of",
				"liquids or gases from one place to another! Yay for tubes! Woo! Woo!",
			}
			display = '~' color = color.WHITE
			level = 60 weight = 50 cost = 200
			allocation = { {60, 3} }

			flags = {
			}
		}
	}

	[TV_HIGH_TECH_COMPONENTS] = {
		color = color.WHITE
		name = "high-tech components",
		desc = {
			"Extremely complicated, high tech gizmos.",
		}
		symbol = '~'
		defaults = {
			flags = {
				ID_SKILL=SKILL_TECHNOLOGY
				ID_VALUE=33
				CAPSULED=false
				CAPSULE_WEIGHT=0
				ITEM_TECHNO=true
			}
		}

		[SV_PARTICLE_ACCELERATOR] = {
			name = "& particle accelerator~"
			desc = {"This fabulously complicated device chooses to observe 'things' as",
				"particles so that they may then be accelerated. Usually for the purpose",
				"of smashing them into other 'things' for the purpose of creating yet",
				"more 'things,' and thinking of them all as particles also. Of course, it is",
				"called a particle accelerator, after all.",
			}
			display = '~' color = color.WHITE
			level = 70 weight = 200 cost = 3000
			allocation = { {70, 6} }

			flags = {
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 5
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 5
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 5
				TECHNO_EXPLODE = getter.damages{PURE = {100,1000}}
			}
		}
		[SV_PLASMA_DIODE] = {
			name = "& plasma diode~"
			desc = {"These diodes are designed to work with superheated gases."}
			display = '~' color = color.WHITE
			level = 70 weight = 10 cost = 700
			allocation = { {70, 5} }

			flags = {
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 5
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 5
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 5
				TECHNO_EXPLODE = getter.damages{PURE = {100,300}}
			}
		}
		[SV_MAGLEV_TUBE] = {
			name = "& maglev tube~"
			desc = {"Magentic levitation tubes employ very powerful magnets to suspend",
				"objects in the air.",
			}
			display = '~' color = color.WHITE
			level = 70 weight = 100 cost = 1200
			allocation = { {70, 5} }

			flags = {
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 5
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 5
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 5
			}
		}
		[SV_CONTAINER_OF_NANITES] = {
			name = "& container~ of nanites"
			desc = {"Nanites are microscopic robots which may be programmed to carry",
				"out complicated tasks that are impractical for us macroscopic types.",
			}
			display = '~' color = color.WHITE
			level = 70 weight = 1 cost = 1200
			allocation = { {70, 5} }

			flags = {
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 5
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 5
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 5
			}
		}
		[SV_TACHYON_STREAMER] = {
			name = "& tachyon streamer~"
			desc = {"This tube supplies a steady flow of tachyons to any desired source."}
			display = '~' color = color.WHITE
			level = 70 weight = 100 cost = 1700
			allocation = { {70, 5} }

			flags = {
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 5
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 5
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 5
				TECHNO_EXPLODE = getter.damages{PURE = {100,500}}
			}
		}
		[SV_POSITRONIC_RELAY] = {
			name = "& positronic relay~"
			desc = {"It's not like you can just nicely ask positrons to go where you want them",
				"to and expect it to happen. Similarly to how wires are used to conduct electrons",
				"from one point to another, the positronic relay directs positrons to a desired",
				"point, while simultaneously minimizing their chance of decay.",
			}
			display = '~' color = color.WHITE
			level = 70 weight = 50 cost = 600
			allocation = { {70, 5} }

			flags = {
				DISCIPLINE = 1
				INGRED1_WHAT = TV_BULK_MATERIAL
				INGRED1_QTY = 2
				INGRED2_WHAT = TV_CIRCUITRY
				INGRED2_QTY = 5
				INGRED3_WHAT = TV_CIRCUITRY
				INGRED3_QTY = 5
				INGRED4_WHAT = TV_CIRCUITRY
				INGRED4_QTY = 5
				TECHNO_EXPLODE = getter.damages{PURE = {100,500}}
			}
		}
	}

	[TV_DBALL] = {
		color = color.ORANGE
		name = "dragonball",
		desc = {"",}
		defaults = { flags = {CAPSULED=getter.array{0, 0} } }
		symbol = 'o'
		[SV_DRAGONBALL] = {
			name = "& massive sphere~"
			desc = {"This massive sphere is one of the seven dragonballs. When all seven",
				"are gathered together, they may be used to summon Shenron, the Eternal Dragon.",
				"He will grant his summoner a single, powerful wish, and then scatter the dragonballs",
				"across the earth to be found once again.",
			}
			display = 'o' color = color.ORANGE
			level = 50 weight = 1000 cost = 10000
			allocation = { {50, 50} }
			flags = {
				INSTA_ART = true
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=25
			}
		}
	}
	[TV_NAMEK_WEAPON] = {
		color = color.WHITE
		name = "Namek Weapon",
		desc = {"This item is from the planet Namek.",}
		defaults = { flags = {CAPSULED=getter.array{0, 0} } }
		symbol = '|'

		[SV_NAM_KNIFE] = {
			name = "& Namekkian knife~"
			desc =
			{
				"Made of an alien metal, this knife is extremely strong and durable.",
			}
			display = '|' color = color.SLATE
			level = 50 weight = 100 cost = 3000
			allocation = { {35, 1} }
			flags =
			{
				WIELD_SLOT = INVEN_WIELD
				WEAPON  = true
				DAM = getter.damages{PIERCE = {1,16}}
				DIFFICULTY = 3
				ID_SKILL=SKILL_WEAPONS
				ID_VALUE=35
				PAIRED = true
				BLADED=true
				VORPAL=true
				POISON_BLADE=0
				ITEM_NAMEK=true
			}
		}
	}

	[TV_NAMEK_ARMOR] = {
		color = color.WHITE
		name = "Namek Armor",
		desc = {"This item is from the planet Namek.",}
		defaults = { flags = {CAPSULED=getter.array{0, 0} } }
		symbol = '['

		[SV_NAM_ROBES] = {
			name = "& Namekkian robe~"
			desc =
			{
				"Woven of alien cloth, the fabric of this robe is light weight, and extremely durable.",
			}
			display = '[' color = color.SLATE
			level = 30 weight = 150 cost = 1200
			allocation = { {30,1}, {35,1} }
			ac = 25
			flags =
			{
				WIELD_SLOT = INVEN_BODY
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				RESIST = obvious(getter.resists{COLD=10 SLASH=10 FIRE=10 SHARDS=5})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=32
				ITEM_NAMEK=true
			}
		}
		[SV_NAM_ELDER_ROBES] = {
			name = "& Namekkian elder's robe~"
			desc =
			{
				"This robe was not woven at all, but rather conjured by an elder of Namek.",
			}
			display = '[' color = color.LIGHT_BLUE
			level = 35 weight = 180 cost = 2400
			allocation = { {35,1}, {40,1} }
			ac = 35
			flags =
			{
				WIELD_SLOT = INVEN_BODY
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				RESIST = obvious(getter.resists{COLD=10 SLASH=10 FIRE=10 SHARDS=5})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=32
				ITEM_NAMEK=true
				IGNORE = getter.resists{
					COLD = true
					FIRE = true
					ELEC = true
				}
			}
		}
		[SV_NAM_BRACERS] = {
			name = "& Namekkian bracer~"
			desc = {
				"These bracers are commonly worn on Namek. They are not specifically designed to",
				"be protective, but the material is sturdier than the equivalent cloth from earth.",
			}
			display = '[' color = color.SLATE
			level = 30 weight = 80 cost = 800
			allocation = { {30,1}, {35,1} }
			ac = 10
			flags = {
				WIELD_SLOT = INVEN_ARMS
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				RESIST = obvious(getter.resists{COLD=5})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=30
				ITEM_NAMEK=true
			}
		}
		[SV_NAM_FIGHTING_BRACERS] = {
			name = "& Namekkian fighting bracer~"
			desc = {
				"Worn as forearm support and armor by the fighting Namek's, these bracers are",
				"extremely sturdy and will help to deflect the force of incoming blows.",
			}
			display = '[' color = color.LIGHT_UMBER
			level = 40 weight = 120 cost = 1200
			allocation = { {38,1}, {44,1} }
			ac = 20
			flags = {
				WIELD_SLOT = INVEN_ARMS
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				RESIST = obvious(getter.resists{COLD=5 SLASH=5})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=40
				ITEM_NAMEK=true
			}
		}
		[SV_NAM_BOOTS] = {
			name = "& pairs~ of Namekkian boots"
			desc = {
				"Simple boots, but like everything on Namek, made of sturdier, heavier material.",
			}
			display = '[' color = color.SLATE
			level = 30 weight = 160 cost = 1600
			allocation = { {30,1}, {35,1} }
			ac = 12
			flags = {
				RESIST = obvious(getter.resists{COLD=10})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=30
				WIELD_SLOT = INVEN_FEET
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				ITEM_NAMEK=true
			}
		}
		[SV_NAM_FIGHTING_BOOTS] = {
			name = "& pairs~ of Namekkian fighting boots"
			desc = {
				"Intended to be extremely lightweight so as to not slow down ones kicks, these",
				"shoes are ideal to fight in.",
			}
			display = '[' color = color.SLATE
			level = 40 weight = 12 cost = 3200
			allocation = { {40,1}, {45,1} }
			ac = 16
			flags = {
				RESIST = obvious(getter.resists{COLD=10})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=40
				WIELD_SLOT = INVEN_FEET
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
				ITEM_NAMEK=true
			}
		}
		[SV_NAM_TURBIN] = {
			name = "& Namekkian turbin~"
			desc = {
				"With three suns on the planet Namek, local custom is to wear protective turbins.",
				"Made of six or seven feet of wrapped cloth, these turbins provide good protective",
				"benefits.",
			}
			display = '[' color = color.WHITE
			level = 30 weight = 80 cost = 2000
			allocation = { {30, 1} }
			ac = 16
			flags = {
				RESIST = obvious(getter.resists{COLD=15 SLASH=5})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=40
				WIELD_SLOT = INVEN_HEAD
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_ALWAYS
				ITEM_NAMEK=true
			}
		}
		[SV_NAM_ELDER_TURBIN] = {
			name = "& Namekkian elder's turbin~"
			desc = {
				"Similar to the common turbin, but made of material conjured by a Namekkian elder.",
			}
			display = '[' color = color.WHITE
			level = 40 weight = 120 cost = 3400
			allocation = { {30, 1} }
			ac = 32
			flags = {
				RESIST = obvious(getter.resists{COLD=15 SLASH=5})
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=40
				WIELD_SLOT = INVEN_HEAD
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_ALWAYS
				ITEM_NAMEK=true
			}
		}
		[SV_NAM_CAPE] = {
			name = "& Namekkian cape~"
			desc =
			{
				"A decorative cape which attaches at the shoulders and hangs straight down.",
				"It's impressive looking, but doesn't offer much in the way of protection.",
			}
			display = '[' color = color.WHITE
			level = 30 weight = 50 cost = 750
			allocation = { {30,1} }
			ac = 5
			flags = {
				ID_SKILL=SKILL_MARTIALARTS
				ID_VALUE=30
				WIELD_SLOT = INVEN_OUTER
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_MELEE
			}
		}
	}
	[TV_MISC] = {
		color = color.WHITE
		name = "misc stuff",
		-- Don't want to give too much away, do we?
		-- desc = {"Things in general. Quest items. Joke items. General misc. 'other stuff.'",}
		desc = {"",}
		defaults =
			{
				flags =
				{
					EASY_KNOW=true
					SPECIAL_GENE=true
					CAPSULED=false
					CAPSULE_WEIGHT=0
				}
			}
		symbol = '~'
		[SV_AUTOGRAPH] = {
			name = "& autograph~"
			desc = {
				"This piece of paper has been autographed by the famous tournament fighter,",
				"Mr. Satan! Surely it's worth something...right? To somebody?",
			}
			display = '?' color = color.WHITE
			level = 1 weight = 1 cost = 50000
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_FAN] = {
			name = "& fan~"
			desc = {
				"This small fan is made of feathers, and may be used to help keep cool.",
			}
			display = '~' color = color.RED
			level = 1 weight = 1 cost = 100
			allocation = { {100, 999} }
			flags = {
				RESIST = getter.resists{FIRE=5}
				WIELD_SLOT = obvious(INVEN_TOOL)
			}
		}
		[SV_CROCK_OF_GOLD] = {
			name = "& crock~ of gold"
			desc = {
				"A large Irish cooking-crock filled with large gold coins. It looks very",
				"heavy.",
			}
			display = 'o' color = color.YELLOW
			level = 1 weight = 50000 cost = 1000000
			allocation = { {100, 999} }
			flags = {
				GET_PRE=function(obj)
					if not obj.flags[FLAG_CAPSULED] and player.stat(A_STR) < 25 then
						message("It's too heavy for you to lift! Gold is heavy stuff, you know.")
						return true, false
					end
				end
			}
		}
		[SV_PAIR_OF_PANTIES] = {
			name = "& pair~ of panties"
			desc = {
				"A lovely pair of panties. Ahh...their scent is still fresh!",
			}
			display = ',' color = color.LIGHT_BLUE
			level = 1 weight = 1 cost = 10
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_RUBY_SLIPPERS] = {
			name = "& pair~ of ruby slippers"
			desc = {
				"A delightful pair of sparkly red slippers. They look comfy.",
			}
			display = ',' color = color.RED
			level = 1 weight = 1 cost = 100
			allocation = { {100, 999} }
			flags = {
				WIELD_SLOT = INVEN_FEET
			}
		}
		[SV_WIDGET] = {
			name = "& widget~"
			desc = {
				"A small device of some sort. It is brightly colored, and looks very user",
				"friendly. You're not certain what it does.",
			}
			display = '~' color = color.RED
			level = 1 weight = 1 cost = 100
			allocation = { {100, 999} }
			flags = {
				USEABLE = 32
			}
		}
		[SV_TROPHY] = {
			name = "& trophy~"
			desc = {
				"A trophy.",
			}
			display = '~' color = color.YELLOW
			level = 1 weight = 100 cost = 1000
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_OFUDA] = {
			name = "& ofuda"
			desc = {
				"A small, rectangular piece of paper with highly stylized kanji written on",
				"it, intended to ward off evil spirits and demons.",
			}
			display = '?' color = color.WHITE
			level = 1 weight = 1 cost = 100
			allocation = { {100, 999} }
			flags = {
				WIELD_SLOT = INVEN_TOOL
				WIELD_POST=function(obj)
						message("'Aku-Ryo-Tai-San!'")
				end
			}
		}
		[SV_STATUE] = {
			name = "& statue~"
			desc = {
				"A small statue",
			}
			display = 'o' color = color.VIOLET
			level = 1 weight = 1 cost = 100
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_NIMBUS] = {
			name = "& little fluffy cloud~"
			desc = {
				"It seems to be a little fluffy cloud.",
			}
			display = '*' color = color.WHITE
			level = 1 weight = 1 cost = 10000
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_CRYSTAL_BALL] = {
			name = "& crystal ball~"
			desc = {
				"A solid sphere of glass, or crystal.",
			}
			display = 'o' color = color.WHITE
			level = 1 weight = 300 cost = 2000
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_PELT] = {
			name = "& pelt~"
			desc = {
				"A strip of fur from an animal.",
			}
			display = ']' color = color.WHITE
			level = 1 weight = 30 cost = 350
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_CLOTH] = {
			name = "& strips~ of cloth"
			desc = {
				"A strip of cloth.",
			}
			display = ']' color = color.WHITE
			level = 1 weight = 1 cost = 1
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_PAPER_CUP] = {
			name = "& small paper cup~"
			desc = {
				"A small paper cup.",
			}
			display = ',' color = color.WHITE
			level = 1 weight = 1 cost = 1
			allocation = { {100, 999} }
			flags = {
			}
		}
		[SV_NAM_AJASA_SEED] = {
			name = "& ajasa seed~"
			desc = {
				"A small seed from the ajasa plant, native to Namek.",
			}
			display = ',' color = color.PURPLE
			level = 40 weight = 10 cost = 3400
			allocation = { {30, 1} }
			flags = {
				ITEM_NAMEK=true
				USEABLE=37
				AJISA_SEED=true
			}
		}
		[SV_NAM_AJASA_PLANT] = {
			name = "& ajasa plant~"
			desc = {
				"A small, but fully grown ajasa plant. It is deep purple, and really quite lovely.",
			}
			display = ',' color = color.PURPLE
			level = 40 weight = 120 cost = 1000
			allocation = { {40, 1} }
			flags = {
				ITEM_NAMEK=true
			}
		}
		[SV_EARTH_WATER] = {
			name = "& water~"
			desc = {
				"A large quantity of water, stored in a capsule.",
			}
			display = '~' color = color.LIGHT_BLUE
			level = 999 weight = 10000 cost = 1
			allocation = { {999, 999} }
			flags = {
				STORED_WATER=true
			}
		}
		[SV_NAMEK_WATER] = {
			name = "& namekkian water~"
			desc = {
				"A large quantity of water, stored in a capsule. You should never see this.",
			}
			display = '~' color = color.LIGHT_GREEN
			level = 999 weight = 10000 cost = 1
			allocation = { {999, 999} }
			flags = {
				STORED_WATER=true
				ITEM_NAMEK=true
			}
		}
		-- Charred for Hell, unlike the other skeleton type(s)
		[SV_SKELETON] = {
			name = "& skeleton~"
			desc = {
				"A set of charred, humanoid bones.",
			}
			display = ',' color = color.WHITE
			level = 40 weight = 80 cost = 1
			allocation = { {40, 1} }
			flags = {
			}
		}
		[SV_VIKING_HELMET] = {
			name = "& viking helmet~"
			desc = {
				"A heavy, viking helmet with a large pair of horns.",
			}
			display = ')' color = color.UMBER
			level = 99 weight = 100 cost = 750
			allocation = { {100, 999} }
			ac = 10
			flags = {
				WIELD_SLOT = INVEN_HEAD
				WHEN_TO_DBCOMBAT_MOD = FLAG_DBCOMBAT_MOD_ALWAYS
				BLOW_RESPONSE = getter.array{[AURA_PIERCE] = {1,12}}
			}
		}
	}
}