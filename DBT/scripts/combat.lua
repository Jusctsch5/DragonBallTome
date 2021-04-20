-- Combat system

declare_global_constants {
	"__do_aura",
	"add_aura",
	"attack_barehand",
	"attack_weapon",
	"attack_firearm",
	"dbattack_message",
}

load_subsystem("combat")

constant("COMBAT_WEAPON", add_combat_system
{
	name = "DBT Combat",
	desc = "Unified Barehand/Weapon/Firearm combat",
	skill = "SKILL_NONE",
	energy = function() return get_player_energy(SPEED_WEAPON) end,

	info = function()
		return "You shouldn't see this"
	end,

	available = function() return true end,

--[[
check_faction = function(m_idx, monst, y, x)
	local m_name = monster_desc(monst, 0)

	if (is_friend(monst) < 0) then
		-- Monster is aggressive! Fight it no matter what!
		-- If the player wants to talk, they can press 'Y'
		message("1")
		return combat.ATTACK
	elseif game_options.chat_mode == true then
		message("2")
		if has_flag(monst, FLAG_DBTCHAT) then
		message("3")
--[[
			talk_to_monster(m_idx)
			if m_ptr.flags[FLAG_DBTCHAT] then
				local func
				func = get_function_registry_from_flag(r_ptr.flags, FLAG_DBTCHAT)
				func()
			else
				message(m_name .. " doesn't have anything to say.")
			end
]]
			return combat.DONT_MOVE
		else
		message("4")
			return combat.DONT_MOVE
		end
	else
		message("5")
		-- Player is not friendly by default, query to attack
		local ret, raw_key, key
		ret, raw_key = get_com("Really attack? (y/n)")
		if not ret then
			key = "n"
		else
			key = strlower(strchar(raw_key))
		end
		if key == "y" then
		message("6")
			return combat.ATTACK
		else
		message("7")
			message("Press 'Y' to talk to someone.")
			return combat.DONT_MOVE
		end
	end
	message("Error in combat.lua: check_combat(): This line should never execute!")
end
]]
	attack = function(y, x, max)
		-- Do not fight illusory monsters
		local m_idx = cave(y,x).m_idx
		if m_idx == 0 then return end
		
		-- Get the monster, not the mob
		local monst = monster(m_idx)
		
		-- Get the damage/type
		local typ = dam.MELEE  -- Wait...is there such a thing??? Why does this work?
		local happy_damage = 0

	-- From the subsystem
	-- ******************************
	-- Disturb the monster
	monst.csleep = 0

	-- Disturb the player
	term.disturb(0, 0)

	-- HP Bar tracking
	if monst.ml then monster_race_track(monst.r_idx, monst.ego) end
	if monst.ml then health_track(m_idx) end

	-- No melee from flyers
	if dball.player_in_flight_craft() == true then
		-- if player_monster_swap(monst) then
			return combat.DO_MOVE
		-- else
		--	return combat.DONT_MOVE
		-- end
	end

	-- No melee with groundbound uniques while flying at high altitude
	if dball_data.flying_high > 0 then
		if player_monster_swap(monst) then
			return combat.DO_MOVE
		else
			return combat.DONT_MOVE
		end
	end

	-- Query to stop if friendly
	-- if is_friend(monst) >= 0 and not player.has_intrinsic(FLAG_CONFUSED) and not player.has_intrinsic(FLAG_HALLUCINATE) and monst.ml then
	if is_friend(monst) >= 0 then
		if has_flag(monst, FLAG_GREGORY) and quest(QUEST_KAIO_GREGORY).status == QUEST_STATUS_TAKEN then
			for foo = 1, 2 do
				if player.inventory[INVEN_WIELD][foo].flags[FLAG_GREGORY] then
					return combat.DONT_MOVE
				end
			end
			-- Otherwise, fall through to dialogue below

		elseif has_flag(monst, FLAG_PERMANENT) and monst.faction == FACTION_PLAYER then
			-- Is a companion
			if game_options.party_mode == true then
				if player_monster_swap(monst) then
					return combat.DO_MOVE
				else
					return combat.DONT_MOVE
				end
			end
		end
		if game_options.chat_mode == true then
			-- Never attack friendly monsters mode
			if monst.flags[FLAG_DBTCHAT] then
				local r_ptr = r_info[monst.r_idx + 1]
				local func
				func = get_function_registry_from_flag(r_ptr.flags, FLAG_DBTCHAT)
				func()
			else
				if player_monster_swap(monst) then
					return combat.DO_MOVE
				else
					local m_name = monster_desc(monst, 0)
					message(m_name .. " doesn't have anything to say.")
					return combat.DONT_MOVE
				end
			end
			return nil
		else
			-- Query
			local ret, raw_key, key
			ret, raw_key = get_com("Really attack? (y/n)")
			if not ret then
				key = "n"
			else
				key = strlower(strchar(raw_key))
			end
			if key == "y" then
				-- Check faction stuff and 'special events'
				dball.faction_handler(monst.flags[FLAG_FACTION])
	
			else
				message("Press 'Y' to talk to someone.")
				return nil
			end
		end
	end

	-- Handle player fear
	if player.has_intrinsic(FLAG_FEAR) then
		-- Message
		if monst.ml then
			message("You are too afraid!")
		else
			if player.get_sex() == "Female" then
				message("Eeek! There's somthing slimy and awful and gross! Eeek!")
			else
				message("There is something scary in your way!")
			end
		end
		return nil
	end

	-- Shouldn't we be good and include these?
	--if hook.process(hook.INIT_COMBAT_PRE, monst, m_name) then
	--	return false
	--end
	--hook.process(hook.INIT_COMBAT_POST, monst, m_name)
	--return true

	-- ******************************


	-- Ok, last step. Getting combat to use everything we've set up so far.
	-- Please, no nasty comments on how I've done this. It works.

	local w1 = dball_data.lhand_valid
	local w2 = dball_data.rhand_valid

	-- What has it got in it's handses?
	-- Junk and Junk (Well, shields...flashlights, etc. Can't fight with them.)
	if (w1 == -1 and w2 == -1) then
		if player.inventory[INVEN_VEHICLE][1] then
			message("It's not practical to fight from a vehicle.")
		else
			message("You can't fight with that.")
		end

	-- Barehand and Junk or Junk and Barehand (Calc checks to make sure this is ok)
	elseif (w1 == 0 and w2 == -1) or (w1 == -1 and w2 == 0) then
		attack_barehand(1, monst)

	-- Barehand and Barehand (calc sets a -1 if this is not allowed, so we're good)
	elseif (w1 == 0 and w2 == 0) then
		attack_barehand(1, monst)
		if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
		attack_barehand(2, monst)

	-- Barehanded and Weapon (calc also checks this one)
	elseif (w1 == 0 and w2 == 1) then
		attack_barehand(1, monst)
		if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
		attack_weapon(2, monst)

	-- Weapon and Barehanded (calc checks)
	elseif (w1 == 1 and w2 == 0) then
		attack_weapon(1, monst)
		if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
		attack_barehand(2, monst)

	-- Weapon and Junk
	elseif (w1 == 1 and w2 == -1) then
		attack_weapon(1, monst)

	-- Junk and Weapon
	elseif (w1 == -1 and w2 == 1) then
		attack_weapon(2, monst)

	-- Junk and Gun (Calc doesn't (can't) check for ab_point_blank, so we have to
	elseif (w1 == -1 and w2 == 2) then
		if has_ability(AB_POINT_BLANK) then
			attack_firearm(2, monst, 0)
		else
			message("You haven't the skill to fire in such close proximity.")
		end

	-- Gun and Junk
	elseif (w1 == 2 and w2 == -1) then
		if has_ability(AB_POINT_BLANK) then
			attack_firearm(1, monst, 0)
		else
			message("You haven't the skill to fire in such close proximity.")
		end

	-- Gun and Barehand (Complicated...have to handle here)
	elseif (w1 == 2 and w2 == 0) then
		-- First, are we allowed to fire point blank?
		if has_ability(AB_POINT_BLANK) then
			-- Yes. Ok, try to fire the gun.
			if attack_firearm(1, monst, 0) then
				-- We fired. Can we ALSO attack barehand?
				if has_ability(AB_ULTIMATE) then
					if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
					attack_barehand(2, monst)
				end
			else
				-- We're out of bullets, so go ahead and attack barehand
				attack_barehand(2, monst)
			end
		else
			-- Can't fire point blank. Calc confirms melee is ok, so barehand
			attack_barehand(2, monst)
		end

	-- Barehand and Gun (Calc confirms the barehand, but not the gun)
	elseif (w1 == 0 and w2 == 2) then
		-- First, are we allowed to fire point blank?
		if has_ability(AB_POINT_BLANK) then
			-- Yes. Ok, try to fire the gun.
			if attack_firearm(2, monst, 0) then
				-- We fired. Can we ALSO attack barehand?
				if has_ability(AB_ULTIMATE) then
					if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
					attack_barehand(1, monst)
				end
			else
				-- We're out of bullets, so go ahead and attack barehand
				attack_barehand(1, monst)
			end
		else
			-- Can't fire point blank. Calc confirms melee is ok, so barehand
			attack_barehand(1, monst)
		end

	-- Gun and Weapon (Again, we have to handle here)
	elseif (w1 == 2 and w2 == 1) then
		-- First, are we allowed to fire point blank?
		if has_ability(AB_POINT_BLANK) then
			-- Yes. Ok, try to fire the gun.
			if attack_firearm(1, monst, 0) then
				-- We fired. Can we ALSO attack with the weapon?
				if has_ability(AB_ULTIMATE) then
					if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
					attack_weapon(2, monst)
				end
			else
				-- We're out of bullets, so go ahead and attack weapon
				attack_weapon(2, monst)
			end
		else
			-- Can't fire point blank. Calc confirms melee is ok, so weapon
			attack_weapon(2, monst)
		end

	-- Weapon and Gun (Another complicated one)
	elseif (w1 == 1 and w2 == 2) then
		-- First, are we allowed to fire point blank?
		if has_ability(AB_POINT_BLANK) then
			-- Yes. Ok, try to fire the gun.
			if attack_firearm(2, monst, 0) then
				-- We fired. Can we ALSO attack with the weapon?
				if has_ability(AB_ULTIMATE) then
					if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
					attack_weapon(1, monst)
				end
			else
				-- We're out of bullets, so go ahead and attack weapon
				attack_weapon(1, monst)
			end
		else
			-- Can't fire point blank. Calc confirms melee is ok, so weapon
			attack_weapon(1, monst)
		end


	-- Gun and Gun (wield_pre only allows if ok, but we still need to check for point_blank
	elseif (w1 == 2 and w2 == 2) then
		if has_ability(AB_POINT_BLANK) then
			attack_firearm(1, monst, 0)
			if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
			attack_firearm(2, monst, 0)
		else
			message("You not skilled enough to maneuver a shot like this!")
		end

	-- Weapon and Weapon (wield_pre only allows if ok, so this one is simple)
	elseif (w1 == 1 and w2 == 1) then
		attack_weapon(1, monst)
		if cave(y,x).m_idx == 0 then return end -- Monster already dead, don't do second attack
		attack_weapon(2, monst)

	else
		message("Error in combat.lua: Attempting to attack with an invalid combination of armaments!")
	end

	end,

	hooks 	=
	{
	},
})

-- Combat helper functions

function attack_barehand(which, monst)	
	local to_hit, to_dam			
	if which == 1 then
		to_hit = dball_data.lhand_th
		to_dam = dball_data.lhand_td
	elseif which == 2 then
		to_hit = dball_data.rhand_th
		to_dam = dball_data.rhand_td
	else
		message("l/r hand non-array sillyness causing trouble in combat.lua")
	end	
	if to_hit + rng(1,100) > monst.ac then	
		-- We hit!
		local bh_damage = to_dam

		-- Add from skill
		if get_skill(SKILL_HAND) >= 1 then
			local bhandskill = get_skill(SKILL_HAND)
			bh_damage = bh_damage + rng(1, bhandskill)
		end

		if bh_damage < 0 then bh_damage = 0 end

		-- Generate the 'You thwack it' message
		dbattack_message(dam.CRUSH, bh_damage, monst)
		-- Apply damage
		project(WHO_PLAYER, 0, monst.fy, monst.fx, bh_damage, dam.CRUSH, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
	else
		message("You miss.")
	end
	return true
end

function attack_weapon(which, monst, riposte)
	local to_hit, to_dam
	if which == 1 then
		to_hit = dball_data.lhand_th
		to_dam = dball_data.lhand_td
	elseif which == 2 then
		to_hit = dball_data.rhand_th
		to_dam = dball_data.rhand_td
	else
		message("l/r hand non-array sillyness causing trouble in combat.lua")
	end	
	if to_hit + rng(1,100) > monst.ac then	
		-- We hit!

		-- Big-time Hack: Gregory quest
		if has_flag(monst, FLAG_GREGORY) and quest(QUEST_KAIO_GREGORY).status == QUEST_STATUS_TAKEN then
			message("You have hit Gregory!")
			change_quest_status(QUEST_KAIO_GREGORY, QUEST_STATUS_COMPLETED)
			-- Allow continue to actually deliver the damage?
		end

		local dams = player.inventory[INVEN_WIELD][which].flags[FLAG_DAM]
		local typ = flag_max_key(dams)

		-- Poison!
		local poisoned = 0
		-- Should we give this flag as false to all weapons?
		if player.inventory[INVEN_WIELD][which].flags[FLAG_POISON_BLADE] then
			poisoned = player.inventory[INVEN_WIELD][which].flags[FLAG_POISON_BLADE]
		end

		-- Hack: No poison in WT fights unless the fight is to the death!
		if dball_data.tourny_now == 1 and poisoned > 0 then
			if dball.tourny_disqualify() then
				message("You have been disqualified for illegal use of a poisoned weapon!")
				return
			end	
		end

		-- Entangling weapons!
		local entangle = 0

		if player.inventory[INVEN_WIELD][which].flags[FLAG_ENTANGLE] then
			-- Need a skill of 10 to have any chance to entangle
			if (skill(SKILL_WEAPONS).value / 1000) >= 10 then
				if rng(1, 200) <= (skill(SKILL_WEAPONS).value / 1000) then
					entangle = rng(0, (skill(SKILL_WEAPONS).value / 1000))
				end
			end
		end

		-- Vorpal/Bleed
		local v_chance, vorpal = 0, 0
		if player.inventory[INVEN_WIELD][which].flags[FLAG_VORPAL] then
			v_chance = v_chance + (skill(SKILL_WEAPONS).value / 1000)
		end
		if player.inventory[INVEN_WIELD][which].flags[FLAG_BLADED] and has_ability(AB_BLEED_ATTACK) then
			v_chance = v_chance + (skill(SKILL_WEAPONS).value / 1000)
		end
		if rng(1, 200) <= v_chance then
			vorpal = rng(flag_get(dams, typ), flag_get2(dams, typ))
		end

		-- Randomize the damage
		local wp_dam = to_dam + rng(flag_get(dams, typ), flag_get2(dams, typ))
		if wp_dam < 0 then wp_dam = 0 end

		if riposte then
			message("You riposte!")
		else
			dbattack_message(typ, wp_dam, monst)
		end

		 -- Monster already dead, don't deliver any additional damage types
		if cave(monst.fy, monst.fx).m_idx == 0 then
			return true
		end

		-- Apply damage
		project(WHO_PLAYER, 0, monst.fy, monst.fx, wp_dam, typ, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)


		if poisoned > 0 then
			project(WHO_PLAYER, 0, monst.fy, monst.fx, wp_dam, dam.POIS, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
			-- Project handles damage reduction for resistance, but we need to modify wp_dam ourselves
			-- for our own damage message
			if monst.flags[FLAG_RESIST] and monst.flags[FLAG_RESIST][dam.POIS] then
				wp_dam = wp_dam * monst.flags[FLAG_RESIST][dam.POIS] / 100
			end
			dbattack_message(dam.POISON, wp_dam, monst)

			-- Less poison on the blade
			poisoned = poisoned - 1
			player.inventory[INVEN_WIELD][which].flags[FLAG_POISON_BLADE] = poisoned
			if poisoned < 1 then
				message("Your weapon is no longer poisoned.")
			else
				message("Your weapon is less poisoned.")
			end
		end

		 -- Monster already dead, don't deliver any additional damage types
		if cave(monst.fy, monst.fx).m_idx == 0 then
			return true
		end

		-- message("Vorpal: " .. vorpal)

		if vorpal > 0 then
			project(WHO_PLAYER, 0, monst.fy, monst.fx, vorpal, dam.CUT, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
		end

		 -- Monster already dead, don't deliver any additional damage types
		if cave(monst.fy, monst.fx).m_idx == 0 then
			return true
		end

		if entangle > 0 then
			-- Dazed message generated without our help
			project(WHO_PLAYER, 0, monst.fy, monst.fx, entangle, dam.STUN, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
		end
	else
		if riposte then
		else
			message("You miss.")
		end
	end
	return true
end

function attack_firearm(which, monst, range_to_target)
	local to_hit, d_final, d_effect, typ
	local armor_pierce = false
	local volley_hack = false

	if not range_to_target then
		local range_to_target = 0
	end

	-- If we're firing at point blank range, then
	-- we need to manually handle vollies here
	if range_to_target == 0 then
		volley_hack = true
	end


	if which == 1 then
		to_hit = dball_data.lhand_th
	elseif which == 2 then
		to_hit = dball_data.rhand_th
	else
		message("l/r hand non-array sillyness causing trouble in combat.lua")
	end	

	local fire_arm = player.inventory[INVEN_WIELD][which]

	-- Scopes
	if fire_arm.flags[FLAG_SCOPABLE] and fire_arm.flags[FLAG_SCOPABLE] == 2 then
		range_to_target = range_to_target - 5
		if range_to_target < 0 then
			range_to_target = 0
		end
	end

	-- Subtract range penalties (range^2)
	if range_to_target then
		to_hit = to_hit - (range_to_target * range_to_target)
	end

	-- Get ammo information
	if fire_arm.flags[FLAG_AMMO_CLASS] then
		if fire_arm.flags[FLAG_AMMO_CLASS] == FLAG_ATYPE_LOOKUP_PROJ then
			-- Whoops! This is a flag, not a kidx or an obj!
			local c_kidx = fire_arm.flags[FLAG_AMMO_LOADED]
			local is_ok = true
			local clip = new_object()
			clip, is_ok  = firearmcombat.get_ammo(c_kidx)
			if is_ok == false then
				error("Error: no ammo is loaded. You should not have made it here.")
				return
			end
			local dams = clip.flags[FLAG_AMMO_DAMAGE]
			local typ = flag_max_key(dams)
			d_effect = clip.flags[FLAG_AMMO_AOE]
			if clip.flags[FLAG_AMMO] == FLAG_AMMO_AP then
				armor_pierce = true
			end
		elseif fire_arm.flags[FLAG_AMMO_CLASS] == FLAG_ATYPE_INFINITE then
			message("Implement infinite ammo weapons!")
			return
		elseif fire_arm.flags[FLAG_AMMO_CLASS] == FLAG_ATYPE_CHI then
			message("Implement Chi-drain weapons!")
			return
		end
	else
		message("Weird error: Unknown ammo type, but already passed check!?!?")
		return
	end


	-- If we're firing at point blank range
	-- we need to handle vollies here
	-- Otherwise, assume only one bullet
	-- is fired
	local rounds = 1
	if volley_hack == true then
		-- How many rounds does this weapon fire?
		local rounds = firearm.flags[AMMO_VOLLEY]
		if fire_arm.flags[FLAG_AMMO_CURRENT] < rounds then
			rounds = fire_arm.flags[FLAG_AMMO_CURRENT]
		end
	end

	for each_bullet = 1, rounds do
		-- Separate damage for each bullet
		d_final = rng(flag_get(dams, typ), flag_get2(dams, typ)) * fire_arm.flags[FLAG_MULTIPLIER]

-- Differentiate text for multi round vollies
--[[
		-- Buu (Should we allow him to deflect energy beams as well?)
		if monst.flags[FLAG_DEFLECT] then
			--local m_name = monster_desc(m_ptr, 0)
			if d_effect == "bullet" then
				monster_random_say
					{
					"Buu opens up a hold in his chest and lets the bullet pass through it!",
					"Buu inhales the bullet and says 'Squee!'",
					"Buu opens a dimensional portal and the bullet falls into it!",
					}
				return true -- As in, don't continue with missile
	
			elseif d_effect == "missile" then
				monster_random_say
					{
					"Buu catches the missile in mid-flight, and eats it!",
					"Buu glares at the missile...and it withers away into dust!",
					"Buu points at the missle and makes it vanish!",
					}
				return true -- As in, don't continue with missile
			end
		end
]]


		-- Handle to hit, and armor piercing ammo
		local to_hit_needed = monst.ac
		if armor_pierce == true then
			to_hit_needed = to_hit_needed / 2
		end

		if to_hit + rng(1,100) > to_hit_needed then	
			-- we hit
			if d_effect == FLAG_MISSILE_BOLT then
				project(WHO_PLAYER, 0, monst.fy, monst.fx, d_final, typ, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
			elseif d_effect == FLAG_MISSILE_BEAM then
				-- Implement beam weapons
				-- They shouldn't need to be here at all, really
				-- fire_beam(type, dir, rng.roll(3, get_skill(SKILL_WATER)))
				project(WHO_PLAYER, 0, monst.fy, monst.fx, d_final, typ, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
			elseif d_effect == FLAG_MISSILE_BALL then
				project(WHO_PLAYER, 5, monst.fy, monst.fx, d_final, typ, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
			else
				message("Error: unknown effect type in Marksmanship!")
			end
			return true
		else
			-- We miss! But, missile can continue on past target
			return false
		end

	end
end

function dbattack_message(damage_type_with_a_unique_name, damage_also_with_a_unique_name, monst)
	local he_she = "it"
	local him_her = "it"
	local monster_name = monster_desc(monst, 0)
	if monst.flags[FLAG_MALE] then
		he_she = "he"
		him_her = "him"
	elseif monst.flags[FLAG_FEMALE] then
		he_she = "she"
		him_her = "her"
	end

	-- Add monster name?
	if damage_type_with_a_unique_name == dam.BHAND then
		if damage_also_with_a_unique_name > 100 then
			message("You pound on " .. him_her)
		elseif damage_also_with_a_unique_name > 50 then
			message("You pummel " .. him_her)
		elseif damage_also_with_a_unique_name > 20 then
			message("You strike " .. him_her)
		elseif damage_also_with_a_unique_name > 8 then
			message("You hit " .. him_her)
		elseif damage_also_with_a_unique_name > 2 then
			message("You tap " .. him_her)
		elseif damage_also_with_a_unique_name > 0 then
			message("You barely tap " .. him_her)
		else
			message("You land a pathetic attack that does no damage")
		end
	elseif damage_type_with_a_unique_name == dam.PIERCE then
		if damage_also_with_a_unique_name > 100 then
			message("You visciously impale " .. monster_name)
		elseif damage_also_with_a_unique_name > 50 then
			message("You impale " .. monster_name)
		elseif damage_also_with_a_unique_name > 20 then
			message("You heavily pierce " .. monster_name)
		elseif damage_also_with_a_unique_name > 8 then
			message("You lightly pierce " .. monster_name)
		elseif damage_also_with_a_unique_name > 2 then
			message("You poke " .. monster_name)
		elseif damage_also_with_a_unique_name > 0 then
			message("You barely poke your opponent")
		else
			message("You connect, but too weakly to penetrate skin")
		end
	elseif damage_type_with_a_unique_name == dam.CRUSH then
		if damage_also_with_a_unique_name > 100 then
			message("The force of your blow does great damage")
		elseif damage_also_with_a_unique_name > 50 then
			message("You crush " .. monster_name)
		elseif damage_also_with_a_unique_name > 20 then
			message("You smash " .. monster_name)
		elseif damage_also_with_a_unique_name > 8 then
			message("You hit " .. monster_name)
		elseif damage_also_with_a_unique_name > 2 then
			message("You tap " .. monster_name)
		elseif damage_also_with_a_unique_name > 0 then
			message("You barely tap " .. him_her)
		else
			message("You gingerly touch your opponent for no damage")
		end
	elseif damage_type_with_a_unique_name == dam.SLASH then
		if damage_also_with_a_unique_name > 100 then
			message("You visciously cleave through " .. monster_name)
		elseif damage_also_with_a_unique_name > 50 then
			message("You tear into " .. monster_name)
		elseif damage_also_with_a_unique_name > 20 then
			message("You slash " .. monster_name)
		elseif damage_also_with_a_unique_name > 8 then
			message("You cut " .. monster_name)
		elseif damage_also_with_a_unique_name > 2 then
			message("You nick " .. him_her)
		elseif damage_also_with_a_unique_name > 0 then
			message("You barely nick " .. him_her)
		else
			message("You connect, but fail to break skin")
		end
	elseif damage_type_with_a_unique_name == dam.BALLISTIC then
		if damage_also_with_a_unique_name > 100 then
			message("You blow a large hole in " .. monster_name)
		elseif damage_also_with_a_unique_name > 50 then
			message("You blow a good sized hole in " .. monster_name)
		elseif damage_also_with_a_unique_name > 20 then
			message("You blow a small hole in " .. him_her)
		elseif damage_also_with_a_unique_name > 8 then
			message("You shoot " .. monster_name)
		elseif damage_also_with_a_unique_name > 2 then
			message("You shoot " .. monster_name)
		elseif damage_also_with_a_unique_name > 0 then
			message("You barely nick" .. him_her)
		else
			message("Somehow you seem not to have done any damage.")
		end
	elseif damage_type_with_a_unique_name == dam.POISON then
		if damage_also_with_a_unique_name > 100 then
			message(monster_name .. " lets out a blood curdling cry of pain from the terrible poison!")
		elseif damage_also_with_a_unique_name > 50 then
			message(monster_name .. " Your opponenet is wracked with pain!")
		elseif damage_also_with_a_unique_name > 20 then
			message(monster_name .. " Your foe twitches violently in response to the poison.")
		elseif damage_also_with_a_unique_name > 8 then
			message("The poison seems to be effective.")
		elseif damage_also_with_a_unique_name > 2 then
			message("The poison has little effect.")
		elseif damage_also_with_a_unique_name > 0 then
			message("The poison has almost no effect.")
		else
			message("The poison seems to have no effect.")
		end
	elseif damage_type_with_a_unique_name == dam.STUN or damage_type_with_a_unique_name == dam.ELEC then
		if damage_also_with_a_unique_name > 100 then
			message(monster_name .. " cries out and you smell burnt flesh!")
		elseif damage_also_with_a_unique_name > 50 then
			message(monster_name .. " cries out in pain!")
		elseif damage_also_with_a_unique_name > 20 then
			message(monster_name .. " spasms uncontrollably")
		elseif damage_also_with_a_unique_name > 8 then
			message("You thoroughly zap " .. him_her)
		elseif damage_also_with_a_unique_name > 2 then
			message("You zap " .. him_her)
		elseif damage_also_with_a_unique_name > 0 then
			message(monster_name .. " twitches slightly")
		else
			message(he_she .. " ignores the effect")
		end
	else
		message("You thwack it with an as-of-yet un-thwackably messaged type of damage! Wow!")
	end
	return true
end

------------------------------------------------
-- Monster combat
tome_dofile("monster.lua")

------------------------------------------------------------
-- Slays
------------------------------------------------------------
combat.new_slay("DRAGON", "is especially deadly against dragons",
				"dragons",
function(mon)
	return mon.flags[FLAG_DRAGON]
end)

combat.new_slay("ORC", "is especially deadly against orcs",
				"orcs",
function(mon)
	return mon.flags[FLAG_ORC]
end)

combat.new_slay("TROLL", "is especially deadly against trolls",
				"trolls",
function(mon)
	return mon.flags[FLAG_TROLL]
end)

combat.new_slay("GIANT", "is espcially deadly against giants",
				"giants",
function(mon)
	return mon.flags[FLAG_GIANT]
end)

combat.new_slay("DEMON", "strikes at demons with holy wrath",
				"demons",
function(mon)
	return mon.flags[FLAG_DEMON]
end)

combat.new_slay("UNDEAD", "strikes at the undead with holy wrath",
				"the undead",
function(mon)
	return mon.flags[FLAG_UNDEAD]
end)

combat.new_slay("EVIL", "fights against evil with holy fury",
				"evil creatures",
function(mon)
	return mon.flags[FLAG_EVIL]
end)

combat.new_slay("ANIMAL", "is especally dead against natural creatures",
				"animals",
function(mon)
	return mon.flags[FLAG_ANIMAL]
end)


------------------------------------------------------------
-- Vampirism
------------------------------------------------------------
hook(hook.WEAP_DAM_DEALT,
function(obj, launcher, mon, r_idx, re_idx, dam_dealt)
	if dam_dealt == 0 then
		return
	end

	if mon.r_idx == 0 then
		-- Monster is dead, so the mon structure has been wiped; get
		-- info directly from race info and race ego info.
		if r_info[r_idx + 1].flags[FLAG_UNDEAD] or
			r_info[r_idx + 1].flags[FLAG_NONLIVING] then
			return
		end
		if re_info[re_idx + 1].flags[FLAG_UNDEAD] or
			re_info[re_idx + 1].flags[FLAG_NONLIVING] then
			return
		end
	elseif mon.flags[FLAG_UNDEAD] or mon.flags[FLAG_NONLIVING] then
		return
	end

	if obj.flags[FLAG_VAMPIRIC] then
		if mon.r_idx == 0 then
			message("Your weapon suck the last of the life out of " ..
					"your fallen foe!")
		else
			message("Your weapon drains life from " ..
					monster_desc(mon, 0) .. "!")
		end
		
		if dam_dealt <= obj.flags[FLAG_VAMPIRIC] then
			hp_player(dam_dealt)
		else
			hp_player(obj.flags[FLAG_VAMPIRIC])
		end
	end
end
)

-----------------------------------------------------------
-- Auras
-----------------------------------------------------------
memory.flag_aura = {}
memory.flag_aura.surround = {}
memory.flag_aura.cover    = {}
memory.flag_aura.radiate  = {}
memory.flag_aura.shroud   = {}
memory.flag_aura.shield   = {}

function __do_aura(aura, attacker, target, mindam, maxdam)
	local a_ptr, t_ptr
	local a_name, t_name, a_possesive, t_possesive, isare, sss
	local y, x
	local msg

	if attacker == WHO_PLAYER then
		a_ptr       = player
		a_name      = "you"
		a_possesive = "your"
		isare       = "are"
		sss         = ""

		msg = aura.player_msg or aura.msg

		y = player.py
		x = player.px
	else
		a_ptr        = monster(attacker)
		a_name       = monster_desc(a_ptr, 4)
		a_possesive  = monster_desc(a_ptr, 6)
		isare        = "is"
		sss          = "s"

		msg = aura.monster_msg or aura.msg

		y = a_ptr.fy
		x = a_ptr.fx
	end

	if target == WHO_PLAYER then
		t_ptr       = player
		t_name      = "you"
		t_possesive = "your"
	else
		t_ptr        = monster(target)
		t_name       = monster_desc(t_ptr, 4)
		t_possesive  = monster_desc(t_ptr, 6)
	end

	-- Player learns about non-visible auras when s/he attacks a monster
	if attacker == WHO_PLAYER and aura.not_visible and t_ptr.ml then
		local r_ptr = race_info_idx(t_ptr.r_idx, t_ptr.ego)
		local entry = memory.get_entry(r_ptr, t_ptr.ego)

		memory.check(entry, {{FLAG_BLOW_RESPONSE, aura.index}}, RT_MISC,
					 memory.make_flag_checker(r_ptr))
	end

	if msg and (attacker == WHO_PLAYER or
				(a_ptr.ml and player_has_los_bold(y, x) and
				 not player.has_intrinsic(FLAG_BLIND) and
					 not aura.not_visible)) then
		msg = gsub(msg, "(@Attacker@)", strcap(a_name))
		msg = gsub(msg, "(@attacker@)", a_name)
		msg = gsub(msg, "(@Target@)", strcap(t_name))
		msg = gsub(msg, "(@target@)", t_name)
		msg = gsub(msg, "(@attacker_possesive@)", a_possesive)
		msg = gsub(msg, "(@target_possesive@)", t_possesive)
		msg = gsub(msg, "(@isare@)", isare)
		msg = gsub(msg, "(@s@)", sss)

		message(msg)
		if game_options.disturb_other or attacker == WHO_PLAYER then
			term.disturb(1, 0)
		end
	end

	local proj_flags = (PROJECT_JUMP | PROJECT_HIDE | PROJECT_STOP |
						PROJECT_KILL | PROJECT_NO_REFLECT | PROJECT_SILENT)

	proj_flags = proj_flags | aura.proj_flags

	project(target, aura.rad, y, x, rng.range(mindam, maxdam),
 			aura.dam_type, proj_flags)
end

function add_aura(t)
	assert(t.name, "Aura has no name")
	assert(t.dam_type,  t.name .. " has no damage type")
	assert(t.msg or (t.player_msg and t.monster_msg),
		   t.name .. " has no message")
	assert(not t.color or color[t.color],
		   "Unknown color '" .. t.color .. "'")


	t.is_aura = true

	t.proj_flags = t.proj_flags or 0
	t.rad        = t.rad        or 0

	t.monster_blow = function(attacker, target, effect, method, params,
							  special, mindam, maxdam)
						 if special.touched then
							 __do_aura(%t, attacker, target,
									   mindam, maxdam)
						 end
					 end

	t.weapon_blow = function(attacker, target, weapon, launcher,
							 damns, computed_dams, crit_mult, crit_div,
							 max_weap_dam, mindam, maxdam)
						if not launcher then
							__do_aura(%t, attacker, target,
									  mindam, maxdam)
						end
					end

	add_blow_response(t)

	if not t.color_desc and t.desc then
		if t.color then
			t.color_desc = "#" .. strchar(conv_color[color[t.color] + 1]) ..
				t.desc .. "#w"
		else
			t.color_desc = t.desc
		end
	end

	if not t.self_know and t.desc and t.type then
		if t.type == "radiate" then
			t.self_know = "You radiate " .. t.desc .. "."
		elseif t.type == "shield" then
			t.self_know = "You are envolvoped in a mystic shield which " ..
				t.desc .. " your foes."
		elseif t.type == "surround" then
			t.self_know = "You are surrounded by " .. t.desc .. "."
		elseif t.type == "cover" then
			t.self_know = "You are covered with " .. t.desc .. "."
		elseif t.type == "shroud" then
			t.self_know = "You are shrouded in " .. t.desc .. "."
		else
			print("Unknown type '" .. t.type .. "'")
		end
	end

	if not t.memory and t.desc and t.type then
		if t.color then
			t.memory = {t.type, "<" .. t.color .. " " .. t.desc .. ">"}
		else
			t.memory = {t.type, t.desc}
		end
	end

	if t.memory then
		local flags = memory.flagdesc_add{
			{FLAG_BLOW_RESPONSE, t.index, t.memory[2]}
		}

		tinsert(memory.flag_aura[t.memory[1]], flags[1])

		if not t.not_visible then
			memory.obviousflag_add({FLAG_BLOW_RESPONSE, t.index})
		end
	end

	return t.index
end

-----------------------

add_aura{
	name     = "AURA_FIRE",
	dam_type = dam.FIRE,
	msg      = "@Attacker@ @isare@ suddenly very hot!",
	type     = "surround",
	desc     = "flames",
	color    = "ORANGE",
}

add_aura{
	name     = "AURA_PLASMA",
	dam_type = dam.PLASMA,
	msg      = "@Attacker@ @isare@ suddenly *VERY* hot!",
	type     = "surround"
	desc     = "plasma",
	color    = "LIGHT_RED",
}

add_aura{
	name     = "AURA_ELEC",
	dam_type = dam.ELEC,
	msg      = "@Attacker@ get@s@ zapped!"
	type     = "surround"
	desc     = "electricity",
	color    = "LIGHT_BLUE",
}

add_aura{
	name     = "AURA_POIS",
	dam_type = dam.POIS,
	msg      = "@Attacker@ @isare@ smothered in noxious fumes!",
	type     = "surround"
	desc     = "noxious fumes",
	color    = "GREEN",
}

add_aura{
	name     = "AURA_COLD",
	dam_type = dam.COLD,
	msg      = "@Attacker@ @isare@ suddenly very cold!",
	type     = "cover"
	desc     = "frost",
	color    = "BLUE",
}

add_aura{
	name     = "AURA_SHARDS",
	dam_type = dam.SHARDS,
	msg      = "@Attacker@ @isare@ slashed by shards!",
	type     = "cover"
	desc     = "shards",
	color    = "UMBER",
}

---

add_aura{
	name     = "AURA_SLASH",
	dam_type = dam.SLASH,
	msg      = "@Attacker@ @isare@ slashed by @target_possesive@ " ..
		"mystic shield!",
	type     = "shield"
	desc     = "slashes",
	color    = "YELLOW",

	not_visible = true
}

add_aura{
	name     = "AURA_CRUSH",
	dam_type = dam.CRUSH,
	msg      = "@Attacker@ @isare@ crushed by @target_possesive@ " ..
		"mystic shield!",
	type     = "shield"
	desc     = "crushes",
	color    = "YELLOW",

	not_visible = true
}

add_aura{
	name     = "AURA_PIERCE",
	dam_type = dam.PIERCE,
	msg      = "@Attacker@ @isare@ pierced by @target_possesive@ " ..
		"mystic shield!",
	type     = "shield"
	desc     = "pierces",
	color    = "YELLOW",

	not_visible = true
}

add_aura{
	name     = "AURA_CUT",
	dam_type = dam.CUT,
	msg      = "@Attacker@ @isare@ cut by @target_possesive@ " ..
		"mystic shield!",
	type     = "shield"
	desc     = "cuts",
	color    = "YELLOW",

	not_visible = true
}

add_aura{
	name     = "AURA_STUN",
	dam_type = dam.STUN,
	msg      = "@Attacker@ @isare@ stunned by @target_possesive@ " ..
		"mystic shield!",
	type     = "shield"
	desc     = "stuns",
	color    = "YELLOW",

	not_visible = true
}

-----------------------------

function memory.aura(r_ptr,entry)
	local str = memory.flags2str(r_ptr, entry, memory.flag_aura.surround,
								 RT_MISC, memory.prop2)
	if str ~= "" then str = " @It@ is surrounded by"..str.."." end

	local str2 = memory.flags2str(r_ptr, entry, memory.flag_aura.cover,
								  RT_MISC, memory.prop2)
	if str2 ~= "" then str2 = " @It@ is covered with"..str2.."." end

	local str3 = memory.flags2str(r_ptr, entry, memory.flag_aura.radiate,
								  RT_MISC, memory.prop2)
	if str3 ~= "" then str3 = " @It@ radiates"..str3.."." end

	local str4 = memory.flags2str(r_ptr, entry, memory.flag_aura.shroud,
								  RT_MISC, memory.prop2)
	if str4 ~= "" then str4 = " @It@ is shrouded in"..str4.."." end

	local str5 = memory.flags2str(r_ptr, entry, memory.flag_aura.shield,
								  RT_MISC, memory.prop2)
	if str5 ~= "" then
		str5 = " @It@ is enveloped in a mystic shield which"..str5..
			" @its@ foes."
	end

	return str .. str2 .. str3 .. str4 .. str5
end

-- In monster memory, display aura info after exp info
memory.entrydesc_add_after("aura", memory.aura, "exp")

---------------------------

-- Describe objects which grant auras
function desc_obj.desc_aruas(obj, to_file, trim_down)
	if not known_flag(obj, FLAG_BLOW_RESPONSE) then
		return
	end

	local responses = obj.flags[FLAG_BLOW_RESPONSE]

	local aura_list = {}

	for i = 1, flag_max_key(responses) do
		if responses[i] then
			local aura = get_blow_response(i)
			if flag_is_known(responses, i) and (aura.is_aura and aura.type and
												aura.color_desc) then
				aura_list[aura.type] = aura_list[aura.type] or {}
				tinsert(aura_list[aura.type], aura.color_desc)
			end
		end
	end

	if aura_list.surround then
		desc_obj.text_out("It surrounds you with " ..
					  strjoin(aura_list.surround, ", ", " and ") .. ". ")
	end

	if aura_list.cover then
		desc_obj.text_out("It covers you in " ..
					  strjoin(aura_list.cover, ", ", " and ") .. ". ")
	end

	if aura_list.shroud then
		desc_obj.text_out("It shrouds you in " ..
					  strjoin(aura_list.shroud, ", ", " and ") .. ". ")
	end

	if aura_list.radiate then
		desc_obj.text_out("It makes your radiate " ..
					  strjoin(aura_list.radiate, ", ", " and ") .. ". ")
	end

	if aura_list.shield then
		desc_obj.text_out("It envelops you in a mystic shield which " ..
					  strjoin(aura_list.shield, ", ", " and ") ..
						  " your foes. ")
	end
end -- desc_obj.desc_aruas
