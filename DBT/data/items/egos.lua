getter.auto_share_flags(true)
--------------------------------------------------------------------------
-- Armor egos
--------------------------------------------------------------------------
new_item_ego
{
	define_as = "DBTEGO_WEIGHTED"
	name = { "before", "weighted"}
	item_kinds =
	{
		[TV_BOOTS] = {0, 255}
		[TV_BODY_ARMOUR] = {0, 255}
		[TV_HEADPIECE] = {0, 255}
		[TV_CLOAK] = {0, 255}
		[TV_GLOVES] = {0, 255}
	}

	level = 5 allocation = 100 value_add = 100 rating = 5
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "Weights sewn into the material makes this an excellent training tool, but difficult to fight in."
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_BULK_MATERIAL, SV_STEEL)
			INGRED1_QTY=4
			INGRED2_WHAT=lookup_kind(TV_MISC, SV_CLOTH)
			INGRED2_QTY=2
			ON_MAKE =
				function(obj)
					local weightedness = rng(1, 10)
					obj.flags[FLAG_XP_MOD] = weightedness
					obj.weight = obj.weight + (weightedness * 50)
					obj.to_h = obj.to_h - weightedness
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_FURLINED"
	name = { "before", "fur lined"}
	item_kinds =
	{
		[TV_BOOTS] = {0, 255}
		[TV_BODY_ARMOUR] = {0, 255}
		-- [TV_CLOAK] = getter.ego_allow{SV_LEATHER_JACKET, SV_DUSTER, SV_TRENCHCOAT}
		-- [TV_GLOVES] = getter.ego_allow{SV_GOLFING_GLOVES, SV_SILK_GLOVES, SV_WELDING_GLOVES, SV_SKI_GLOVES}
	}

	level = 5 allocation = 100 value_add = 350 rating = 5
	flags =
	{
		[100] =
		{
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_MISC, SV_PELT)
			INGRED1_QTY=2
			ON_MAKE =
				function(obj)
					dball.thanks_nerdanel(obj, FLAG_RESIST, dam.COLD, 10)
				end
		}
	}
}

new_item_ego
{
	define_as = "DBTEGO_DESIGNER"
	name = { "before", "designer"}
	item_kinds =
	{
		[TV_BOOTS] = {0, 255}
		[TV_BODY_ARMOUR] = {0, 255}
		[TV_CLOAK] = {0, 255}
		[TV_GLOVES] = {0, 255}
	}

	level = 5 allocation = 100 value_add = 350 rating = 10
	flags =
	{
		[100] =
		{
			-- NOT techno-enhanceable?
			ON_MAKE =
				function(obj)
					dball.thanks_nerdanel(obj, FLAG_STATS, A_CHR, 2)
				end
		}
	}
}

new_item_ego
{
	define_as = "DBTEGO_STUDDED"
	name = { "before", "studded"}
	item_kinds =
	{
		[TV_BODY_ARMOUR] = {0, 255}
		[TV_CLOAK] = {0, 255}
	}

	level = 5 allocation = 100 value_add = 350 rating = 10
	flags =
	{
		[100] =
		{
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_BULK_MATERIAL, SV_STEEL)
			INGRED1_QTY=2
			INGRED2_WHAT=lookup_kind(TV_MISC, SV_CLOTH)
			INGRED2_QTY=2
			DESC_DETAIL = "Metal studs have been woven into the fabric."
			ON_MAKE =
				function(obj)
					-- flag_inc(obj.flags[FLAG_RESIST], dam.SLASH, 10)
					dball.thanks_nerdanel(obj, FLAG_RESIST, dam.SLASH, 10)
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_DARK"
	name = { "before", "dark"}
	item_kinds =
	{
		[TV_BODY_ARMOUR] = {0, 255}
		[TV_CLOAK] = {0, 255}
	}

	level = 5 allocation = 100 value_add = 350 rating = 10
	flags =
	{
		[100] =
		{
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_MISC, SV_CLOTH)
			INGRED1_QTY=2
			DESC_DETAIL = "It is made of jet black cloth."
			STEALTH=1
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_NEON"
	name = { "before", "neon"}
	item_kinds =
	{
		[TV_BODY_ARMOUR] = {0, 255}
		[TV_CLOAK] = {0, 255}
	}

	level = 1 allocation = 100 value_add = 0 rating = 1
	flags =
	{
		[100] =
		{
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_MISC, SV_CLOTH)
			INGRED1_QTY=2
			DESC_DETAIL = "It is made of very bright cloth."
			STEALTH=-1
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_CLEATED"
	name = { "before", "cleated"}
	item_kinds =
	{
		[TV_BOOTS] = getter.ego_allow{SV_TENNIS_SHOES, SV_LEATHER_THIGH_BOOTS}
	}
	level = 5 allocation = 100 value_add = 350 rating = 10
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "Cleats on the soles offer better grip."
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_BULK_MATERIAL, SV_STEEL)
			INGRED1_QTY=1
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
					-- obj.flags[FLAG_SPEEDS] = getter.speeds{WALK=rng(1,5)}
					obj.flags[FLAG_SPEED] = rng(1,5)
				end
		}
	}
}

new_item_ego
{
	define_as = "DBTEGO_SQUEAKY"
	name = { "before", "squeaky"}
	item_kinds =
	{
		[TV_BOOTS] = {0, 255}
		-- [TV_BOOTS] = getter.ego_allow{SV_TENNIS_SHOES, SV_STEEL_TOED_SHOES, SV_LEATHER_THIGH_BOOTS, SV_NINJA_TABI, SV_NINJA_CLIMBING_TABI, SV_CROC_BOOTS}
	}
	level = 1 allocation = 100 value_add = 0 rating = 1
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "They're kind of squeaky."
			AGGRAVATE=true
			TECHNO_ENHANCEABLE=true
			TECHNO_EGO_FREE=true
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 1
					obj.flags[FLAG_DBT_EGO_VALUE] = -5
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_REINFORCED"
	name = { "before", "reinforced"}
	item_kinds =
	{
		[TV_BRACERS] = {0, 255}
	}

	level = 5 allocation = 100 value_add = 100 rating = 5
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "Extra reinforcement provides extra protection."
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_MISC, SV_CLOTH)
			INGRED1_QTY=2
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
					obj.to_a = obj.to_a + 5
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_SPIKED"
	name = { "before", "spiked"}
	item_kinds =
	{
		[TV_BRACERS] = getter.ego_allow{SV_LIGHT_LEATHER_BRACERS, SV_HEAVY_LEATHER_BRACERS, SV_STEEL_BRACERS}
	}

	level = 5 allocation = 100 value_add = 100 rating = 5
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "Small metal spikes in these bracers allows you to damage your opponent when you block his attacks."
			BLOW_RESPONSE = getter.array{[AURA_PIERCE] = {1,6}}
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_BULK_MATERIAL, SV_STEEL)
			INGRED1_QTY=1
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_VISORED"
	name = { "before", "visored"}
	item_kinds =
	{
		[TV_HEADPIECE] = getter.ego_allow{SV_SAMURAI_HELM}
	}

	level = 5 allocation = 100 value_add = 100 rating = 5
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "This item features a transparent visor to protect your eyes."
			RES_BLIND=true
		}
	}
}

--------------------------------------------------------------------------
-- Melee Weapon egos
--------------------------------------------------------------------------
new_item_ego
{
	define_as = "DBTEGO_SERATED"
	name = { "before", "serated"}
	item_kinds =
	{
		[TV_POLEARM] = getter.ego_allow{SV_SPEAR, SV_PUDAO},
		[TV_SMALLARM] = getter.ego_allow{SV_KNIFE, SV_MINI_BUTTERFLY_KNIFE, SV_NINJA_CLAW, SV_KAMA, SV_IRON_FAN},
		[TV_SWORDARM] = getter.ego_allow{SV_BUTTERFLY_KNIFE, SV_STRAIGHTSWORD, SV_SABRE, SV_WAKAZASHI, SV_KATANA, SV_TAI_CHI_SWORD, SV_NINJA_TO, SV_HOOK_SWORD}
	}

	level = 15 allocation = 100 value_add = 2000 rating = 15
	to_h = 0 to_d = 10
	flags =
	{
		[100] =
		{
			VORPAL = true
			TECHNO_ENHANCEABLE=true
			TECHNO_EGO_FREE=true
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 7
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_CHANNELED"
	name = { "before", "channeled"}
	item_kinds =
	{
		[TV_SWORDARM] = getter.ego_allow{SV_BUTTERFLY_KNIFE, SV_STRAIGHTSWORD, SV_SABRE, SV_WAKAZASHI, SV_KATANA, SV_TAI_CHI_SWORD, SV_NINJA_TO, SV_HOOK_SWORD}
	}

	level = 10 allocation = 100 value_add = 750 rating = 10
	to_h = 0 to_d = 0
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "The blade has a blood channel in it."
			VORPAL = true
			TECHNO_ENHANCEABLE=true
			TECHNO_EGO_FREE=true
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 3
				end
		}
	}
}

new_item_ego
{
	define_as = "DBTEGO_STEEL"
	name = { "before", "steel"}
	item_kinds =
	{
		[TV_POLEARM] = getter.ego_allow{SV_BO_STAFF, SV_THREE_SECTIONAL_STAFF},
		[TV_SMALLARM] = getter.ego_allow{SV_NUNCHAKU, SV_KUBOTAN, SV_ESCRIMA_STICK, SV_TONFA, SV_SANJOBANG},
		[TV_SWORDARM] = getter.ego_allow{SV_BOKKEN, SV_SHINAI}
	}

	level = 15 allocation = 100 value_add = 1000 rating = 15
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "Solid metal rather than wood construction makes this weapon slow and heavy, but hard-hitting."
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_BULK_MATERIAL, SV_STEEL)
			INGRED1_QTY=6
			ON_MAKE =
				function(obj)
					if has_flag(obj, FLAG_SILLY_DEBUG) then
						-- error("This is the steel ego bug! please report this item!")
					else
						obj.flags[FLAG_SILLY_DEBUG] = true
						obj.to_d = obj.to_d + (obj.weight / 2)
						obj.to_h = 0
						obj.weight = obj.weight * 10
						obj.flags[FLAG_DIFFICULTY] = (obj.flags[FLAG_DIFFICULTY] + 2) * 2
						obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
						if has_flag(obj, FLAG_RIPOSTABLE) then
							obj.flags[FLAG_RIPOSTABLE] = false
						end
					end
				end
		}
	}
}

new_item_ego
{
	define_as = "DBTEGO_POORLY_MADE"
	name = { "before", "poorly made"}
	item_kinds =
	{
		[TV_POLEARM] = {0, 255}
		[TV_ENTANGLEARM] = {0, 255}
		[TV_SMALLARM] = {0, 255}
		[TV_SWORDARM] = {0, 255}
	}

	level = 1 allocation = 100 value_add = 0 rating = 1
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "This weapon seems to be balanced strangely."
			TECHNO_ENHANCEABLE=true
			TECHNO_EGO_FREE=true
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_DIFFICULTY] = obj.flags[FLAG_DIFFICULTY] * 2
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
					obj.flags[FLAG_DBT_EGO_VALUE] = -5
					if has_flag(obj, FLAG_RIPOSTABLE) then
						obj.flags[FLAG_RIPOSTABLE] = false
					end
				end
		}
	}
}

--------------------------------------------------------------------------
-- Gun egos
--------------------------------------------------------------------------
new_item_ego
{
	define_as = "DBTEGO_HIGH_VELOCITY"
	name = { "before", "high velocity"}
	item_kinds =
	{
		[TV_GUN] = {0, 255}
		[TV_SHOTGUN] = {0, 255}
	}

	level = 20 allocation = 100 value_add = 2000 rating = 15
	to_h = 0 to_d = 10
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "Increased muzzle velocity for greater damage and range."
			TECHNO_ENHANCEABLE=true
			TECHNO_EGO_FREE=true
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_BASE_RANGE] = obj.flags[FLAG_BASE_RANGE] + 5
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_GUN_HIGH_CAPACITY"
	name = { "before", "high capacity"}
	item_kinds =
	{
		[TV_GUN] = {0, 255}
		[TV_SHOTGUN] = {0, 255}
	}

	level = 20 allocation = 100 value_add = 2000 rating = 15
	to_h = 0 to_d = 10
	flags =
	{
		[100] =
		{
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_BULK_MATERIAL, SV_STEEL)
			INGRED1_QTY=2
			ON_MAKE =
				function(obj)
					if has_flag(obj, FLAG_AMMO_CAPACITY) then
						local c_range = rng(1, (obj.flags[FLAG_AMMO_CAPACITY] * 2))
						obj.flags[FLAG_AMMO_CAPACITY] = obj.flags[FLAG_AMMO_CAPACITY] + c_range
					end
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_GUN_WILDLY_INACCURATE"
	name = { "before", "wildly inaccurate"}
	item_kinds =
	{
		[TV_GUN] = {0, 255}
		[TV_SHOTGUN] = {0, 255}
	}

	level = 20 allocation = 100 value_add = 0 rating = 1
	to_h = 0 to_d = 10
	flags =
	{
		[100] =
		{
			TECHNO_ENHANCEABLE=true
			TECHNO_EGO_FREE=true
			DESC_DETAIL = "This weapon gives too much kick to target accurately."
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_WILDLY_INACCURATE] = true
				end
		}
	}
}
--------------------------------------------------------------------------
-- Junk egos
--------------------------------------------------------------------------
new_item_ego
{
	define_as = "DBTEGO_MINT"
	name = { "after", "in mint condition"}
	item_kinds =
	{
		[TV_JUNK] = getter.ego_allow{SV_COMIC_BOOK, SV_MANGA}
	}

	level = 1 allocation = 100 value_add = 200 rating = 1
	to_h = 0 to_d = 0
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "It is in flawless condition, as if freshly minted."
			ON_MAKE =
				function(obj)
-- Conflict with easy know...
--					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_RARE"
	name = { "before", "rare"}
	item_kinds =
	{
		[TV_JUNK] = getter.ego_allow{SV_COMIC_BOOK, SV_MANGA}
	}

	level = 1 allocation = 100 value_add = 200 rating = 1
	to_h = 0 to_d = 0
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "A hard to find issue."
			ON_MAKE =
				function(obj)
-- Conflict with easy know...
--					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 1
				end
		}
	}
}
--------------------------------------------------------------------------
-- Food egos
--------------------------------------------------------------------------
new_item_ego
{
	define_as = "DBTEGO_MOLDY"
	name = { "before", "moldy"}
	item_kinds =
	{
		[TV_FOOD] = {0, 255}
	}

	level = 1 allocation = 100 value_add = 0 rating = 1
	to_h = 0 to_d = 0
	flags =
	{
		[100] =
		{
			DESC_DETAIL = "It is covered with mold."
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_DBT_EGO_VALUE] = -10
				end
		}
	}
}
--------------------------------------------------------------------------
-- Light egos
--------------------------------------------------------------------------
new_item_ego
{
	define_as = "DBTEGO_BRIGHT"
	name = { "before", "bright"}
	item_kinds =
	{
		[TV_LITE] = {0, 255}
	}

	level = 5 allocation = 100 value_add = 200 rating = 5
	to_h = 0 to_d = 0
	flags =
	{
		[100] =
		{
			TECHNO_ENHANCEABLE=true
			INGRED1_WHAT=lookup_kind(TV_MISC, SV_CLOTH)
			INGRED1_QTY=2
			DESC_DETAIL = "This flashlight seems brighter than most."
			ON_MAKE =
				function(obj)
					obj.flags[FLAG_LITE] = obj.flags[FLAG_LITE] + 1
					-- ID conflicts with EASY_KNOW
					-- obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_LITE_HIGH_CAPACITY"
	name = { "before", "high capacity"}
	item_kinds =
	{
		[TV_LITE] = getter.ego_allow{SV_FLASHLIGHT, SV_MAGLIGHT}
	}

	level = 5 allocation = 100 value_add = 100 rating = 5
	to_h = 0 to_d = 0
	flags =
	{
		[100] =
		{
			ON_MAKE =
				function(obj)
					local e_fuel = obj.flags[FLAG_FUEL_CAPACITY] * 3
					obj.flags[FLAG_FUEL_CAPACITY] = e_fuel
					obj.flags[FLAG_FUEL] = e_fuel
					-- ID conflicts with EASY_KNOW
					-- obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
				end
		}
	}
}
--------------------------------------------------------------------------
-- Tool/Electronics egos
--------------------------------------------------------------------------
new_item_ego
{
	define_as = "DBTEGO_TOOL_HIGH_CAPACITY"
	name = { "before", "high capacity"}
	item_kinds =
	{
		[TV_ELECTRONICS] = getter.ego_allow{SV_LASER_POINTER, SV_MEGAPHONE, SV_FIRE_EXTINGUISHER, SV_FLAME_THROWER, SV_BLOWTORCH, SV_JETPACK}
	}

	level = 27 allocation = 100 value_add = 800 rating = 5
	to_h = 0 to_d = 0
	flags =
	{
		[100] =
		{
			ON_MAKE =
				function(obj)
					local e_fuel = obj.flags[FLAG_FUEL_CAPACITY] * 3
					obj.flags[FLAG_FUEL_CAPACITY] = e_fuel
					obj.flags[FLAG_FUEL] = e_fuel
					obj.flags[FLAG_ID_VALUE] = obj.flags[FLAG_ID_VALUE] + 5
				end
		}
	}
}
new_item_ego
{
	define_as = "DBTEGO_TOOL_HIGH_CAPACITY"
	name = { "before", "high voltage"}
	item_kinds =
	{
		[TV_SMALLARM] = getter.ego_allow{SV_TASER, SV_STUN_BATON, SV_CATTLE_PROD}
	}

	level = 32 allocation = 100 value_add = 2000 rating = 15
	to_h = 0 to_d = 0
	flags =
	{
		[100] =
		{
			ON_MAKE =
				function(obj)
					if obj.sv == SV_TASER then
						obj.flags[FLAG_DAM] = getter.damages{STUN = {2,20}}
					elseif obj.sv == SV_STUN_BATON then
						obj.flags[FLAG_DAM] = getter.damages{STUN = {4,40}}
					elseif obj.sv == SV_CATTLE_PROD then
						obj.flags[FLAG_DAM] = getter.damages{STUN = {6,60}}
					end
				end
		}
	}
}

--------------------------------------------------------------------------
--------------------------------------------------------------------------
getter.auto_share_flags(false)
