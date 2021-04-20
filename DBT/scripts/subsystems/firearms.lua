-- -=Dragonball T Firearms combat subsystem=-
--
-- EXPERIMENTAL!!! EXPERIMENTAL!!!
--
-- ********************
-- *** EXPERIMENTAL ***
-- ********************
--
-- This eventually should be a functional subsystem that I'm
-- a good number of module makers out there are going to want
-- to use. Right now, though...it's not done. Deal with it.
-- I started firearms handling for Dragonball T before I even
-- knew what a subsystem was, so going back and retroactively
-- making everything 'friendly' is a bit of a task. Especially
-- since it was originally built as simply an add-on to the DBT
-- melee combat system.

-- Unfortunately I'm not sure how to implement a third of the
-- stuff that it does as a separate subsystem. It has tendrils
-- throughout SO MANY files that isolating them and putting them
-- all in here so people can use it might be tough. But I'm
-- going to try. Gradually. Eventually. Be patient. Also...
-- some of those tendrils are dug into places that are somewhat
-- impractical to pull out and put in here. I really don't see
-- any easy way to adapt this system just by loading it and
-- creating items. It's going to require manual tweaking of
-- existing files.

-- Semi-current list of adaptation issues:
--  * some duplicate flags with default ToME systems
--  * subsystem assumes calc.lua does a lot
--  * subsystem still refers to dbt_data
--  * Dual wield handling is all very DBT
--  * TV/SV assumptions
--  * Gun vs. Launcher behavior is all hard coded
--  * desc.lua handling
--  * Probably some other stuff

-- So, having said all that...let's begin, shall we?

-- You probably already have this loaded:
-- load_subsystem("combat")

-- These don't really do anything
-- They're just to make reading the code easier
new_flag("OUT_OF_AMMO")
new_flag("FAILED_TO_FIRE")
new_flag("SHOT_SUCCESSFUL")
new_flag("SHOT_MISSED")
new_flag("SHOT_KILLED_MONSTER")

-- Flags for firearms
new_flag("AMMO_CAPACITY")	-- Total ammo capacity of a firearm
new_flag("AMMO_CURRENT")	-- Current ammo in a firearm
new_flag("AMMO_LOADED")		-- What TYPE of round is loaded? (Takes a k_idx)
new_flag("MISSILE_WEAPON")	-- This needs to go on EVERY firearm this subsystem handles
					-- to indicate that an item in the hands in a valid shooter
					-- Necessary because not all missile weapons use ammunition

-- Flags for ammunition
-- These are entirely COSMETIC for the benefit of desc.lua
-- so firearms will display what type of ammo they have loaded
new_flag("AMMO_STANDARD")	-- Standard Round
new_flag("AMMO_AP")		-- Armor Piercing Round
new_flag("AMMO_I")		-- Incendiary Round
new_flag("AMMO_NONE")		-- No round
new_flag("AMMO_NA")		-- Firearm does not require ammunition
-- This next set is to define what the round actually does
new_flag("AMMO_DAMAGE")		-- How much and what sort of damage does it do?

-- How does this weapon/ammo reload?
new_flag("RELOAD_TYPE")
new_flag("RELOAD_FULL")		-- One clip sets ammo at full capacity
new_flag("RELOAD_ONE")		-- One clip only reloads a single bullet

-- Firearm Accessories
new_flag("SILENCED")
new_flag("SCOPABLE")

-- For monsters that can catch and eat ballistics
new_flag("DEFLECT")

-- Post V085 stuff:
new_flag("MISSILE_FIXED_DAMAGE")	-- Don't consult ammo, just do the damage specified
new_flag("AMMO_CLASS")			-- Which of four types ammo types below does this firearm use?
new_flag("ATYPE_LOOKUP_PROJ")		-- Ammo TV/SV contains (variable) info on damage type currently 'loaded'
new_flag("ATYPE_INFINITE")		-- Energy weapon with infinite firing capacity
new_flag("ATYPE_CHI")			-- Energy weapon which draws upon characters Chi
new_flag("AMMO_VOLLEY")			-- How many rounds does this weapon fire per round?
new_flag("AMMO_AOE")			-- Hmm. Duplicate of below?
new_flag("AOE_BALL")			-- Ball effect, like missiles, and shotgun scattershot
new_flag("AOE_BEAM")			-- Beam effect, not currently used, but chi weapons
new_flag("AOE_BOLT")			-- Bolt effect, like pistols and rifles
new_flag("AOE_SPRAY")			-- Spray effect, like fully automatic mode machine guns

--
new_flag("WILDLY_INACCURATE")		-- Shots may not end up exactly where intended

-- Fire a weapon
hook(hook.KEYPRESS, function (key)
	if key == strbyte('f') then firearmcombat.fire() return true end
end)

------------------------------------------------
------------------- Marksmanship ---------------
------------------------------------------------
-- For functions
constant("firearmcombat", {})

-- Ammo stores information that the subsystem needs, even
-- though the ammo itself has long since ceased to exist.
-- So we recreate it from the k_idx stores during the
-- ammo reloading process.
function firearmcombat.get_ammo(k_idx)
	if k_idx == FLAG_AMMO_NONE then
		error("Error! firearmcombat.get_ammo has received a FLAG instead of an obj!")
		return nil, false
	end
	local obj = new_object()
	object_prep(obj, k_idx)
	return (obj), true
end

function firearmcombat.fire()
	-- First let's check to see if we're NOT wielding any firearms
	-- We'll trust that calc.lua did its job correctly, throughout
	if dball_data.lhand_valid ~= 2 and dball_data.rhand_valid ~= 2 then
		message("You're not wielding any firearms")
		return
	end

	-- Firearms are prohibited in the World Tournament
	if dball_data.tourny_now == 1 then
		if dball.tourny_disqualify() then
			message("You have been disqualified for illegal use of firearms!")
			-- Implement: assign disqualify type?
			return
		end	
	end


	local ammo_check = 0
	local twin_guns = 0
	local fire_status

	-- Implement the marksmanship AB_'s!

	-- Left hand
	if dball_data.lhand_valid == 2 then
		twin_guns = 1
		fire_status = firearmcombat.helper(1)
		if fire_status == FLAG_OUT_OF_AMMO then
			ammo_check = 1
		elseif fire_status == FLAG_SHOT_KILLED_MONSTER then
			-- Don't fire with second hand
			return
		else
		end
	end
	-- Right hand
	if dball_data.rhand_valid == 2 then
		twin_guns = twin_guns + 1
		fire_status = firearmcombat.helper(2)
		if fire_status == FLAG_OUT_OF_AMMO then
			ammo_check = ammo_check + 1
		else
		end
	end

	-- As is, we universally use energy
	-- Shall we be nice and NOT use energy if
	-- no firing occurred?
	energy_use = get_player_energy(SPEED_GLOBAL)

	-- Give only a single notification, whether either or both guns is out of ammo
	if twin_guns == 2 and ammo_check == 1 then
		message("One firearm is out of ammo!")
	elseif ammo_check == 1 then
		message("Out of ammo!")
	elseif ammo_check == 2 then
		message("Firearms in both hands out of ammo!")
	end
end

function firearmcombat.helper(which)
	-- Get it
	local fire_arm = player.inventory[INVEN_WIELD][which]
	-- Check for ammo
	if fire_arm.flags[FLAG_AMMO_CURRENT] and fire_arm.flags[FLAG_AMMO_CURRENT] == 0 then
		return FLAG_OUT_OF_AMMO
	else

		-- Get a target
		local ret, dir
			ret, dir = get_aim_dir()

		if (not ret) then
			return FLAG_FAILED_TO_FIRE
		end

		-- How many rounds does this weapon fire?
		local rounds = fire_arm.flags[FLAG_AMMO_VOLLEY]
		if fire_arm.flags[FLAG_AMMO_CURRENT] < rounds then
			rounds = fire_arm.flags[FLAG_AMMO_CURRENT]
		end

		-- Fire!
		for each_bullet = 1, rounds do
			-- Maximum range by firearm type
			local tdis = fire_arm.flags[FLAG_BASE_RANGE]
			-- Start at the player
			local by = player.py
			local bx = player.px
			local y = player.py
			local x = player.px
			local ny, nx

			-- Predict the "target" location
			local dy, dx = explode_dir(dir)
			local tx = player.px + 99 * dx
			local ty = player.py + 99 * dy

			-- Adjust target for machine guns and other wildly inaccurate weapons
			if has_flag(fire_arm, FLAG_WILDLY_INACCURATE) then
				ty = ty + rng(-1, 1)
				tx = tx + rng(-1, 1)
			end

			-- Check for "target request"
			if (dir == 5) and (target_okay()) then
				tx = target_col
				ty = target_row
			end

			-- Travel until stopped
			for cur_dis = 0, tdis do
				-- Hack -- Stop at the target
				if ((y == ty) and (x == tx)) then break end

				-- Calculate the new location (see "project()")
				ny = y
				nx = x
				ny, nx = mmove2(ny, nx, by, bx, ty, tx)

				-- Stopped by walls/doors
				if (cave_floor_bold(ny, nx) == nil) then
					-- Handle missiles
					break
				end

				-- Save the new location
				x = nx
				y = ny

				local c_ptr = cave(y, x)
				local m_ptr

				-- term.xtra(TERM_XTRA_DELAY, msec)

				-- We hit something
				if c_ptr.m_idx > 0 then
					m_ptr = monster(c_ptr.m_idx)
					if attack_firearm(which, m_ptr, cur_dis) then
				
						-- Is the monster dead?
						if c_ptr.m_idx > 0 then
							return FLAG_SHOT_SUCCESSFUL
						else
							return FLAG_SHOT_KILLED_MONSTER
						end

					-- If we miss, missile may continue to another target
					end
				end
			end
		end
	end -- each_bullet

	-- Wake up monsters is the gun is not silenced
	if has_flag(fire_arm, FLAG_SILENCED) and (fire_arm.flags[FLAG_SILENCED] == 2) then
			-- Don't wake anyone up
	else
		for_each_monster(function(m_idx, monst)
			if monst.csleep > 0 and los(monst.fy, monst.fx, player.py, player.px) then
				monst.csleep = 0
				message(monster_desc(monster(m_idx), 0) .. " wakes up")
			end
		end)
	end

	return FLAG_SHOT_MISSED
end

--[[
-------------------------------------------------------------------------
------------- Item Validation ------------------
-- This is totally UNNECCESARY. These functions are
-- just to assist module makers by generating nasty
-- error messages if their item definitions are
-- incorect.
-- For these functions to work, they must be declared
-- AFTER the "constant("item_valid", {})" line in
-- items.lua. If you care, copy and paste them into that
-- file.
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

	assert(not t.flags.DAM, bowname .. "doesn't need DAM type")
	assert(t.flags.AMMO, bowname .. "needs AMMO type")
	assert(t.flags.BASE_RANGE, bowname .. "needs BASE_RANGE")
	assert(t.flags.MULTIPLIER, bowname .. "needs MULTIPLIER")
	assert(t.flags.AMMO_CAPACITY, bowname .. "needs AMMO_CAPACITY")
	assert(t.flags.AMMO_CURRENT, bowname .. "needs AMMO_CURRENT")
end
register_item_kind_validator(item_valid.firearm, {TV_GUN, TV_LAUNCHER})

function item_valid.ammo(t)
	local ammoname = "Ammo " .. t.name .. " "

	assert(t.flags.AMMO_DAMAGE, ammoname .. "needs AMMO_DAM type")
end
register_item_kind_validator(item_valid.ammo, {TV_CLIP}, TV_MISSILE)
----------------- End Item Validation Functions -------------------------
]]

-------------------------------------------------------------------------
-------------------------- Ammo reloading -------------------------------
-------------------------------------------------------------------------
hook(hook.KEYPRESS, function (key)
	if key == strbyte('a') then

	local ret, item = get_item("Ammo for which firearm?",
							   "You must wield a firearm to reload it.",
							   USE_EQUIP,
							   function(o)
								   return has_flag(o, FLAG_AMMO)
							   end)
	if not ret or not item then return true end

--	Maybe as an option?
--	if firearm.flags[FLAG_AMMO_CAPACITY] == firearm.flags[FLAG_AMMO_CURRENT] then
--		message("That is already fully loaded.")
--		return true end
--	end

	local firearm = get_object(item)
	local reload_with = firearm.flags[FLAG_AMMO]
	local a_name = "foo"
	if reload_with == TV_CLIP then
		a_name = "clip"
	elseif reload_with == TV_SHOTGUN_ROUND then
		a_name = "round"
	elseif reload_with == TV_MISSILE then
		a_name = "missile"
	else
		a_name = "unknown clip type!"
	end

	local ret, item = get_item("Reload with which " .. a_name .. "?",
								"You have no suitable " .. a_name .. ".",
						   		USE_INVEN | USE_FLOOR,
								function(obj) return obj.tval == %reload_with end)
	if not ret or not item then return true end


	local clip = get_object(item)

	-- Shotgun rounds only reload one
	-- Otherwise, restore ammo to full
	if clip.flags[FLAG_RELOAD_TYPE] == FLAG_RELOAD_FULL then
		firearm.flags[FLAG_AMMO_CURRENT] = firearm.flags[FLAG_AMMO_CAPACITY]
	else
		firearm.flags[FLAG_AMMO_CURRENT] = firearm.flags[FLAG_AMMO_CURRENT] + 1
		if firearm.flags[FLAG_AMMO_CURRENT] > firearm.flags[FLAG_AMMO_CAPACITY] then
			firearm.flags[FLAG_AMMO_CURRENT] = firearm.flags[FLAG_AMMO_CAPACITY]
		end
	end

	firearm.flags[FLAG_AMMO_LOADED] = lookup_kind(clip.tval, clip.sval)

	-- Remove the clip
	item_increase(item, -1)
	item_describe(item)
	item_optimize(item)
	-- Use energy
	energy_use = get_player_energy(SPEED_GLOBAL)

	return true

	end
end)
