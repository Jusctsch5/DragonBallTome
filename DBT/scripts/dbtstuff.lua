-- First some general settings:
wild_see_through = false
game_options.items_capitalize = game_options.CAPITALIZE_ALL
object_desc_configuration.details_require_id = false
object_desc_configuration.details_require_id_message = false

-- From here:
-- The first half of this file contains the dball() functions
-- The second half contains hook s

-- dball. is for functions

constant("dball", {})

-- How many days has it been since the game started?
function dball.dayofyear()
	return time(time.DAY, time.display_turn(turn))
end

--[[
function dball.ddd()
	player.wilderness_y = 7
	player.wilderness_x = 7
	player.leaving = true
	player.py = 5
	player.px = 5
	player.redraw[FLAG_PR_MAP] = true
end
]]

--[[
function dball.dowehave(tval, sval)
	dball_data.monster_counter = 0
	local obj
	for i = 1, player.inventory_limits(INVEN_INVEN) do
		if player.inventory[INVEN_INVEN][i] then
			obj = player.inventory[INVEN_INVEN][i]
			if obj and obj.tval == tval and obj.sval == sval then
				return true
			end
		end
	end
	return false
end
]]

function dball.qty_carried(tval, sval)
	local obj
	local item_count = 0
	for i = 1, player.inventory_limits(INVEN_INVEN) do
		if player.inventory[INVEN_INVEN][i] then
			obj = player.inventory[INVEN_INVEN][i]
			if obj and obj.tval == tval then
				if obj.sval == sval then
					item_count = item_count + obj.number
				end
			end
		end
	end
	return item_count
end

-- Remove the FEAT's from a dungeon that we don't want
function dball.purge_feats(replace_with)
	for i = 1, cur_wid - 2 do
		for j = 1, cur_hgt - 2 do
			if cave(j, i).feat == FEAT_SECRET
			 or cave(j, i).feat == FEAT_DOOR
			  or cave(j, i).feat == FEAT_BROKEN
			   or cave(j, i).feat == FEAT_RUBBLE
			    or cave(j, i).feat == FEAT_DOOR_LOCKED_HEAD
			     or cave(j, i).feat == FEAT_DOOR_LOCKED_TAIL
			      or cave(j, i).feat == FEAT_DOOR_JAMMED_HEAD
			       or cave(j, i).feat == FEAT_DOOR_JAMMED_TAIL then
				cave(j, i).feat = replace_with
			end
		end
	end
end

-- Are we a technomancer?
function dball.is_technomancer()
	if quest(QUEST_BRIEFS_UPGRADE).status == QUEST_STATUS_FINISHED then
		return true
	else
		return false
	end
end

-- Generally handle alignment changes
function dball.chalign(how_much)
	dball_data.alignment = dball_data.alignment + how_much
	if how_much < 0 then
		dball_data.ever_been_evil = 1
	end
	player.redraw[FLAG_PR_ALIGN] = true
end

-- Compliments of Nerdanel Vampire
-- http://wiki.t-o-m-e.net/Module_Developers_Discussion/Of_rngs_and_getters
function dball.thanks_nerdanel(obj, group, item, addition)
        if type(obj.flags[group]) == type(nil) then
                obj.flags[group] = getter.array{[item] = 0}
        end
        if obj.flags[group][item] == nil then
                obj.flags[group][item] = addition
        else
                obj.flags[group][item] = max(addition, obj.flags[group][item])
        end
end


-- Retreive the idx of an ego type by name
function dball.find_ego_idx(ego_str)
	for i = 2, max_e_idx do
		local ego = e_info[i]
		if ego.name == ego_str then
			return i - 1
		end
	end
	return nil
end

-- Standard monster-grapples-player? check
function dball.grapple(m_lev, allow_immov)
	-- If Immovability mode renders the player immune
	if allow_immov == true then
		if player.movement_mode == 4 then
			return false
		end
	end
	
	local chance = player.stat(A_DEX) + get_skill(SKILL_DODGE)
	local dur = timed_effect.get(timed_effect.BODY_OIL)
	if dur and dur > 0 then
		if player.inventory[INVEN_BODY][1] then
		else
			chance = chance + 25
		end
		if player.inventory[INVEN_OUTER][1] then
		else
			chance = chance + 25
		end
	end

	if rng(1, 100) + (m_lev * 3) <= chance then
		return false
	else
		return true
	end
end

function dball.persuade(need)
	if player.stat(A_CHR) >= need then
		return true
	else
		return false
	end
end

-- For throws, and the like that require the character to
-- pass through all available points
function dball.teleport_player(dy, dx)
	local tdis = distance(player.py, player.px, dy, dx)
	local by = player.py
	local bx = player.px
	local y = player.py
	local x = player.px
	local ny, nx

	for cur_dis = 0, tdis do
		-- Place the player if we make it to the destination
		if ((y == dy) and (x == dx)) then
			teleport_player_to(dy, dx)
			return
		end

		-- Calculate the new location (see "project()")
		ny = y
		nx = x
		ny, nx = mmove2(ny, nx, by, bx, dy, dx)

		-- Have we smashed into a wall or door?
		if (cave_floor_bold(ny, nx) == nil) then
			monster_random_say
			{
				"Ouch!",
				"You smash headfirst into a wall!",
				"You smack into a wall!",
			}
			teleport_player_to(y, x) -- Note this is still 'previous' location
			take_hit(rng(1, 50), "smashing into a wall")
			return
		end

		-- Have we smashed into a monster?
		local c_ptr = cave(ny, nx)
		local m_ptr
		if c_ptr.m_idx > 0 then
			local monst = monster(c_ptr.m_idx)
			local m_name = monster_desc(monst, 0)
			monster_random_say
			{
				"You smash into " ..m_name,
				"You collide with " .. m_name,
			}
			-- Collission hurts monster too
			local collission_dam = rng(1, 30)
			project(WHO_PLAYER, 0, ny, nx, collission_dam, dam.CRUSH, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
			teleport_player_to(y, x) -- Note this is still 'previous' location
			take_hit(collission_dam, "smashing into" .. m_name)
			-- Use energy if collide
			energy_use = get_player_energy(SPEED_CAST)
			return
		end
		-- Save the new location
		x = nx
		y = ny
	end
end

-- Is this used?
function dball.egoify(obj, ego_chance)
	if rng(1,100) < ego_chance then
		local group = "default"
		local ego = rand_obj.get_single_ego(object_level, obj.k_idx, nil, group)
		if ego then
			obj.ego_id[1] = ego
		end
	end
end

-- Random object generation helper functions
function dball.accessory_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_ACCESSORY] then
		return true
	end
	return false
end
function dball.plain_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_PLAIN] then
		return true
	end
	return false
end
function dball.french_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_FRENCH] then
		return true
	end
	return false
end
function dball.ma_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_MARTIAL] then
		return true
	end
	return false
end
function dball.chinese_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_CHINESE] then
		return true
	end
	return false
end
function dball.japanese_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_JAPANESE] then
		return true
	end
	return false
end
function dball.ninja_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_NINJA] then
		return true
	end
	return false
end
function dball.police_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_POLICE] then
		return true
	end
	return false
end
function dball.rra_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_MILITARY] then
		return true
	end
	return false
end
function dball.namek_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_NAMEK] then
		return true
	end
	return false
end
function dball.techno_item_tester(k_idx)
	local item = k_info[k_idx + 1]
	if item.flags[FLAG_ITEM_TECHNO] then
		return true
	end
	return false
end
-- End random item helper functions

-- Am I identified?
function dball.idd(obj)
	-- Implement me
end
function dball.id_if(obj)
	if has_flag(obj, FLAG_ID_SKILL) and has_flag(obj, FLAG_ID_VALUE) then
		if get_skill(obj.flags[FLAG_ID_SKILL]) + player.stat(A_INT) - 10 >= obj.flags[FLAG_ID_VALUE] then
			make_item_fully_identified(obj)
		end
		if dball_data.wish_autoid == 1 then
			make_item_fully_identified(obj)
		end
		if (obj.ident & IDENT_STOREB ~= 0) then
			make_item_fully_identified(obj)
		end
	end
end
-- Am I in a capsule?
function dball.capsuled(obj)
	if obj.flags[FLAG_CAPSULED] == true then
		return true
	end
	return false
end
-- How many capsules does the player have?
function dball.player_has_capsules()
	-- Implement me!
	return 0
end

-- This is such an obnoxious case of the stupidest little thing that should
-- be so absolutely triviallly easy to do! But here's it been over a YEAR
-- that I've been working on this thing and I still can't figure out how
-- to do this!!!! I just want to check if the player has an item with
-- a flag in his inventory. WHY IS THIS SO DIFFICULT?!?!?!?
function dball.player_has_item_with_flag(which_flag)
	local qty_found = 0
	for i = 1, player.inventory_limits(INVEN_INVEN) do
		if player.inventory[INVEN_INVEN][i] then
			local obj = player.inventory[INVEN_INVEN][i]
			if obj and has_flag(obj, which_flag) then
				qty_found = qty_found + obj.number
			end
		end
	end
	return qty_found
end

-- Remove all capsules
function dball.remove_all_capsules()
	-- Implement me!
--[[
	local items = {}

	-- Get list of objects...
	for_inventory(player, INVEN_INVEN, INVEN_TOTAL,
		function(obj, i, j, item)
			if has_flag(obj, FLAG_INTEGRATED_CAPSULE) or  then
				tinsert(%items, item)
			end
		end)

	-- and drop them (in reverse order, so we don't
	-- shift the item array and change the item indexes)
	for i = getn(items), 1, -1 do
		inven_drop(items[i], 100, player.py, player.px, false)
	end
]]
end

--[[
-- Am I in a capsule?
function dball.capsuled(obj)
	--if not has_flag(obj, FLAG_CAPSULED) then
	--	message("No CAPSULED flag!")
	--	return false
	--end
	-- local capsule_state = obj.flags[FLAG_CAPSULED]
	if flag_get(obj.flags, FLAG_CAPSULED) == 1 then
--		message("Is encapsulated")
		return true
	end
--		message("is good")
	return false
end
]]

-- What shall us Technomancers make for Dr Briefs?
function dball.get_technomancer_quest(q_no)
	local techno_pool = {}

	techno_pool[1] = lookup_kind(TV_ELECTRONICS, SV_COMPASS)
	techno_pool[2] = lookup_kind(TV_ELECTRONICS, SV_BLOWTORCH)
	techno_pool[3] = lookup_kind(TV_BATTERY, SV_BATTERY_BATTERY)

	local array_pos = 3

	if q_no > 1 then
		techno_pool[array_pos + 1] = lookup_kind(TV_ELECTRONICS, SV_GPS)
		techno_pool[array_pos + 2] = lookup_kind(TV_ELECTRONICS, SV_LASER_POINTER)
		array_pos = array_pos + 2
	end
	if q_no > 2 then
		techno_pool[array_pos + 1] = lookup_kind(TV_ELECTRONICS, SV_METAL_DETECTOR)
		techno_pool[array_pos + 2] = lookup_kind(TV_ELECTRONICS, SV_CHAINSAW)
		techno_pool[array_pos + 3] = lookup_kind(TV_DRINK, SV_ANTIDOTE)
		array_pos = array_pos + 3
	end
	if q_no > 3 then
		techno_pool[array_pos] = lookup_kind(TV_ELECTRONICS, SV_LAPTOP)
		array_pos = array_pos + 1
	end
	if q_no > 4 then
		techno_pool[array_pos] = lookup_kind(TV_ELECTRONICS, SV_NIGHTVISION_GOGGLES)
		techno_pool[array_pos] = lookup_kind(TV_ELECTRONICS, SV_INFRARED_GOGGLES)
		techno_pool[array_pos] = lookup_kind(TV_ELECTRONICS, SV_FLAME_THROWER)
		array_pos = array_pos + 3
	end
	if q_no > 6 then
		techno_pool[array_pos] = lookup_kind(TV_ELECTRONICS, SV_MUSCLE_STIMULATOR)
		techno_pool[array_pos] = lookup_kind(TV_ELECTRONICS, SV_JETPACK)
		array_pos = array_pos + 2
	end
	if q_no > 7 then
		techno_pool[array_pos] = lookup_kind(TV_BODY_ARMOUR, SV_EVA_SUIT)
		techno_pool[array_pos] = lookup_kind(TV_BODY_ARMOUR, SV_RADIATION_SUIT)
		array_pos = array_pos + 2
	end
	if q_no > 8 then
		techno_pool[array_pos + 1] = lookup_kind(TV_CAPSULE, SV_CAPSULE_CAPSULE)
		techno_pool[array_pos + 1] = lookup_kind(TV_VEHICLE, SV_MOTORCYCLE)
		array_pos = array_pos + 1
	end
	if q_no > 9 then
		techno_pool[array_pos + 1] = lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_PARTICLE_ACCELERATOR)
		techno_pool[array_pos + 2] = lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_PLASMA_DIODE)
		techno_pool[array_pos + 3] = lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_MAGLEV_TUBE)
		techno_pool[array_pos + 4] = lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_CONTAINER_OF_NANITES)
		techno_pool[array_pos + 5] = lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_TACHYON_STREAMER)
		techno_pool[array_pos + 6] = lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_POSITRONIC_RELAY)
		array_pos = array_pos + 6
	end

	if q_no == 11 then
		-- Only force if we don't know the recipe yet
		return lookup_kind(TV_VEHICLE, SV_CAPSULE_SPACESHIP)
	else
		return techno_pool[rng(1, array_pos)]
	end
end

-- REALLY place a monster, instead of just thinking about it
function dball.place_monster(y, x, monster)
	if type(monster) == "string" then
		m_allow_special[test_monster_name(monster) + 1] = true
	else
		m_allow_special[monster + 1] = true
	end

	local m_idx = place_named_monster(y, x, monster, 0)

	if type(monster) == "string" then
		m_allow_special[test_monster_name(monster) + 1] = false
	else
		m_allow_special[monster + 1] = false
	end

	return m_idx
end
function dball.place_monster_near(y, x, monster)
	if type(monster) == "string" then
		m_allow_special[test_monster_name(monster) + 1] = true
	else
		m_allow_special[monster + 1] = true
	end

	local m_idx = place_named_monster_near(y, x, monster, 0)

	if type(monster) == "string" then
		m_allow_special[test_monster_name(monster) + 1] = false
	else
		m_allow_special[monster + 1] = false
	end

	return m_idx
end

-- Helper function to remove monsters peacefully
-- ???Not working???
function dball.delete_monster(m_name)
	for_each_monster(function(m_idx, monst)
		--if monster_desc(monster(m_idx), 0) == %m_name then
		if monst.r_idx == %m_name then
			delete_monster_idx(m_idx)
		end
	end)
end

-- Return true if ability was learned
-- Returns false if it wasn't (for instance, it was already known)
function dball.learn(abil)
	if ability(abil).acquired == true then
		return false
	else
		ability(abil).hidden = false
		ability(abil).acquired = true
	end
	return true
end

-- Returns a string displaying real skill value
function dball.sk(which)
	return dball.sknum_to_str(skill(which).value)
end
function dball.sknum_to_str(any_num)
	any_num = any_num / 100
	local left_of_dec = any_num / 10
	local right_of_dec = any_num - (left_of_dec * 10)

	local happy_str = tostring(left_of_dec) .. "." .. tostring(right_of_dec)
	if left_of_dec < 10 then
		happy_str = "  " .. happy_str
	elseif left_of_dec < 100 then
		happy_str = " " .. happy_str
	end

	return happy_str
end

function dball.player_flying()
	if dball_data.chi_flight_setting == 1 then
		return true
	elseif player.has_intrinsic(FLAG_FLY) then
		return true
	else
		return false
	end
end
function dball.player_in_flight_craft()
	if player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_CAPSULE_FLYER] == true then
		return true
	else
		return false
	end
end



-- Messaging is handled by calling function
function dball.tourny_disqualify()
	if dball_data.tourny_now ~= 0 and dball_data.tourny_type_of_fight ~= 0 then
		-- Fight is to the death, so anything goes!
		-- Should this only be a check for the Androids?
		return false
	elseif dball.player_flying() == true then
		message ("You are airbourne outside the ring!")
		return false
	else
		dball_data.tourny_now = 0

		dball.delete_tourny_monsters()
		quest(QUEST_TOURNAMENT).status = QUEST_STATUS_FAILED
		cave_set_feat(20, 10, FEAT_FLOOR)
		change_quest_status(QUEST_TOURNAMENT, QUEST_STATUS_FAILED)
		if quest(QUEST_VIDEL_LONELY).status == QUEST_STATUS_TAKEN then
			change_quest_status(QUEST_VIDEL_LONELY, QUEST_STATUS_FAILED)
		end
		return true
	end
end

function dball.wtm_check(m_race)
	-- Note: default zero and default one different for each array
	if race_info_idx(m_race, 0).max_num == 0 then
		return false
	elseif tourny_uniques[m_race] then
		-- If they've been entered, they've already fought, so no-go.
		return false
	end
	return true
end

-- Pick our next opponent for the World Tournament
function dball.get_tourny_fighter_number()

	local t_select = {}
	local t_count = 1

	if dball_data.tourny_round == 0 then
		return RACE_WHITE_BELT
	elseif dball_data.tourny_round == 1 then
		return RACE_YELLOW_BELT
	elseif dball_data.tourny_round == 2 then
		return RACE_ORANGE_BELT
	elseif dball_data.tourny_round == 3 then
		return RACE_GREEN_BELT
	elseif dball_data.tourny_round == 4 then
		return RACE_BROWN_BELT
	elseif dball_data.tourny_round == 5 then
		return RACE_BLACK_BELT
	end

	if dball_data.tourny_round < 9 then				-- 6,7,8
		if dball.wtm_check(RACE_BACTERIUM) then t_select[t_count] = RACE_BACTERIUM t_count = t_count + 1 end
		if dball.wtm_check(RACE_SHUU) then t_select[t_count] = RACE_SHUU t_count = t_count + 1 end
		if dball_data.yawara_wt < 1 then
			if dball.wtm_check(RACE_YAWARA) then t_select[t_count] = RACE_YAWARA t_count = t_count + 1 end
		end
		if dball.wtm_check(RACE_TATSU) then t_select[t_count] = RACE_TATSU t_count = t_count + 1 end
		if dball.wtm_check(RACE_RRA_YELLOW) then t_select[t_count] = RACE_RRA_YELLOW t_count = t_count + 1 end
	end

	if dball_data.tourny_round < 13 and t_count == 1 then	-- 9,10,11,12
		-- Yawara only if not challenge quest removed...
		if dball.wtm_check(RACE_BOB) then t_select[t_count] = RACE_BOB t_count = t_count + 1 end
		if dball.wtm_check(RACE_HONDA) then t_select[t_count] = RACE_HONDA t_count = t_count + 1 end
		if dball.wtm_check(RACE_MASTER_LEE) then t_select[t_count] = RACE_MASTER_LEE t_count = t_count + 1 end
		if dball.wtm_check(RACE_JACQUE) then t_select[t_count] = RACE_JACQUE t_count = t_count + 1 end
		if dball.wtm_check(RACE_LEONARDO) then t_select[t_count] = RACE_LEONARDO t_count = t_count + 1 end
		if dball.wtm_check(RACE_DONATELLO) then t_select[t_count] = RACE_DONATELLO t_count = t_count + 1 end
		if dball.wtm_check(RACE_MICHAELANGELO) then t_select[t_count] = RACE_MICHAELANGELO t_count = t_count + 1 end
		if dball.wtm_check(RACE_RAPHAEL) then t_select[t_count] = RACE_RAPHAEL t_count = t_count + 1 end
		if dball.wtm_check(RACE_RRA_MURASAKI) then t_select[t_count] = RACE_RRA_MURASAKI t_count = t_count + 1 end
		if dball.wtm_check(RACE_CHAPAO) then t_select[t_count] = RACE_CHAPAO t_count = t_count + 1 end
		if dball.wtm_check(RACE_ANTON) then t_select[t_count] = RACE_ANTON t_count = t_count + 1 end
		if dball.wtm_check(RACE_PUNTER) then t_select[t_count] = RACE_PUNTER t_count = t_count + 1 end
	end

	if dball_data.tourny_round < 16 and t_count == 1 then	-- 13,14,15
		if dball.wtm_check(RACE_NAKAMURA) then t_select[t_count] = RACE_NAKAMURA t_count = t_count + 1 end
		if dball.wtm_check(RACE_FONG_SAI_YUK) then t_select[t_count] = RACE_FONG_SAI_YUK t_count = t_count + 1 end
		if dball.wtm_check(RACE_NAM) then t_select[t_count] = RACE_NAM t_count = t_count + 1 end
		if dball.wtm_check(RACE_RANFAN) then t_select[t_count] = RACE_RANFAN t_count = t_count + 1 end
		if dball.wtm_check(RACE_TAO_PAI_PAI) then t_select[t_count] = RACE_TAO_PAI_PAI t_count = t_count + 1 end
		if dball.wtm_check(RACE_GIRAN) then t_select[t_count] = RACE_GIRAN t_count = t_count + 1 end
	end

	if dball_data.tourny_round < 18 and t_count == 1 then	-- 16,17
		if dball_data.piccolo_state == 1 then
			-- Mr Satan may only appear at these levels if Piccolo has been released!
			if dball.wtm_check(RACE_MR_SATAN) then t_select[t_count] = RACE_MR_SATAN t_count = t_count + 1 end
		end
		if dball.wtm_check(RACE_KRILLAN) then t_select[t_count] = RACE_KRILLAN t_count = t_count + 1 end
		if dball.wtm_check(RACE_BOJACK) then t_select[t_count] = RACE_BOJACK t_count = t_count + 1 end
		if dball.wtm_check(RACE_WONG_FEI_HONG) then t_select[t_count] = RACE_WONG_FEI_HONG t_count = t_count + 1 end
		if dball.wtm_check(RACE_IRON_MONKEY) then t_select[t_count] = RACE_IRON_MONKEY t_count = t_count + 1 end
		--if dball.wtm_check(RACE_CHAOZU) then t_select[t_count] = RACE_CHAOZU t_count = t_count + 1 end
		if dball.wtm_check(RACE_TENSHINHAN) then t_select[t_count] = RACE_TENSHINHAN t_count = t_count + 1 end
	end

	-- Special Case: If the Android Quest has been tripped
	-- Androids 16 and 17 can appear at any level of the Tournament after six
	-- ...but should be preferenced out (if not already allocated) by dragonball wishes to win the TW
	if quest(QUEST_ANDROIDS).status == QUEST_STATUS_TAKEN and dball_data.win_world_tournament == 0 then
		if dball.wtm_check(RACE_ANDROID16) then t_select[t_count] = RACE_ANDROID16 t_count = t_count + 1 end
		if dball.wtm_check(RACE_ANDROID17) then t_select[t_count] = RACE_ANDROID17 t_count = t_count + 1 end
	end

	-- Special Case: If we've spoken with Radditz
	-- Any minion involved with the Freeza tree can participate in the Tournament
	if dball_data.have_we_met_radditz ~= 0 and dball_data.win_world_tournament == 0 then
		if dball.wtm_check(RACE_RADDITZ) then t_select[t_count] = RACE_RADDITZ t_count = t_count + 1 end
		if dball.wtm_check(RACE_VEGITA) then t_select[t_count] = RACE_VEGITA t_count = t_count + 1 end
		if dball.wtm_check(RACE_GINYU) then t_select[t_count] = RACE_GINYU t_count = t_count + 1 end
	end

	-- The minor minions aren't preferenced out by wishes to win the Tournament
	if dball_data.have_we_met_radditz ~= 0 then
		if dball.wtm_check(RACE_BURTUR) then t_select[t_count] = RACE_BURTUR t_count = t_count + 1 end
		if dball.wtm_check(RACE_GULDO) then t_select[t_count] = RACE_GULDO t_count = t_count + 1 end
		if dball.wtm_check(RACE_GEICE) then t_select[t_count] = RACE_GEICE t_count = t_count + 1 end
		if dball.wtm_check(RACE_RECOOME) then t_select[t_count] = RACE_RECOOME t_count = t_count + 1 end
	end

	-- Final round handling is special
	if dball_data.tourny_round == 18 then
		if dball_data.satan_flaked == 0 and dball.wtm_check(RACE_MR_SATAN) then
			-- By default, final round is against Mr. Satan. Assuming he hasn't already flaked or been killed
			tourny_uniques[RACE_MR_SATAN] = 1
			return RACE_MR_SATAN
		else
			-- In which case it's 50/50 Rosshi or Piccolo
			if dball.wtm_check(RACE_ROSSHI, 0).max_num ~= 0 then
				if rng(1,2) == 1 then
					tourny_uniques[RACE_ROSSHI] = 1
					return RACE_ROSSHI
				else
					if dball_data.win_world_tournament == 0 then
						return RACE_DEMON_KING_PICCOLO
					else
						return RACE_WIMPY_GUY
					end
				end
			else
				-- Unless he's been evilly, nastily killed by a wicked player...in which case...
				-- He fights Picollo no matter what (Except DB WT wishes can overide)
				-- Note: NEVER mark Piccolo in the 	tourny_uniques[] array!
				if dball_data.win_world_tournament == 0 then
					return RACE_DEMON_KING_PICCOLO
				else
					return RACE_WIMPY_GUY
				end
			end
		end
	end

	-- Ok...if we made it here, just pick a random opponent from the array, if possible.
	-- If not, deal with it.

	t_count = t_count - 1

	if t_count < 1 then
		-- No valid fighters, auto bump
		return FLAG_AUTO_BUMP
	end

	-- Pick a fighter, mark that they've been selected, and return them
	local pick_a_fighter = rng(1, t_count)
	tourny_uniques[t_select[pick_a_fighter]] = 1
	return t_select[pick_a_fighter]
end

function dball.get_tourny_fighter()
	local intro = "victory"
	local m_name = "you should not see this"
	local r_flag = -1

	if dball_data.tourny_round > 18 then
		return intro, m_name, r_flag
	end

	-- If not zero, then the mext opponent has already been assigned
	if dball_data.tourny_current_opponent == 0 or dball_data.tourny_current_opponent == FLAG_AUTO_BUMP then
		dball_data.tourny_current_opponent = dball.get_tourny_fighter_number()
	end

	-- Check to see if the selected fighter has been killed since chosen
	if race_info_idx(dball_data.tourny_current_opponent, 0).max_num < 1 then
		dball_data.tourny_current_opponent = FLAG_AUTO_BUMP
	end

	if dball_data.tourny_current_opponent == FLAG_AUTO_BUMP then	-- Auto Bump to next round
		intro = "autobump"
		m_name = "you should not see this"
		return intro, m_name, r_flag
	end

	-- Now get the actual data
	-- Number values from here on are NOT indications of power...just
	-- arbitrary assignments, to be added to as convenient
	if dball_data.tourny_current_opponent == RACE_WHITE_BELT then
		intro = "Welcome to the World Tournament. Before I can add you into the official lineup you'll have to participate in a preliminary qualifying round. No worries, it's just a formality. Just get in there and show us that you won't trip over your own feet."
		m_name = "white belt"
		r_flag = RACE_WHITE_BELT
	elseif dball_data.tourny_current_opponent == RACE_YELLOW_BELT then
		intro = "Congratulations! You're in the tournament. Your first match is against a measly yellow belt."
		m_name = "yellow belt"
		r_flag = RACE_YELLOW_BELT
	elseif dball_data.tourny_current_opponent == RACE_ORANGE_BELT then
		intro = "Your last match was pretty easy, and this one will be too. Just an orange belt."
		m_name = "orange belt"
		r_flag = RACE_ORANGE_BELT
	elseif dball_data.tourny_current_opponent == RACE_GREEN_BELT then
		intro = "All right, just a few more rounds of nameless nobodys. Next one is a green belt."
		m_name = "green belt"
		r_flag = RACE_GREEN_BELT
	elseif dball_data.tourny_current_opponent == RACE_BROWN_BELT then
		intro = "Next up is some brown belt from a studio I've never heard of."
		m_name = "brown belt"
		r_flag = RACE_BROWN_BELT
	elseif dball_data.tourny_current_opponent == RACE_BLACK_BELT then
		intro = "All right, last round of easy fights. Beat this black belt and you start for real!"
		m_name = "black belt"
		r_flag = RACE_BLACK_BELT

	-- Specials

	elseif dball_data.tourny_current_opponent == RACE_ANDROID16 then
		dball_data.tourny_type_of_fight = 1 -- Fight is to the death
		if dball_data.android_quest_status == 2 then
			intro = "...oh no...it can't be! They're HERE! They're actually here, competing in the Tournament! I...don't have to tell you...this fight is going to be the death. You'd better give it everything you've got. And I don't think the referees are going to quite as particular about how this match is fought, either."
			m_name = "Android 16"
			r_flag = RACE_ANDROID16
		else
			dball_data.android_quest_status = 1
			intro = "Next up...this one's kind of strange. Nobody's ever heard of this girl. She was a last minutes registrant, and we mostly figured she'd be gone by the second round of eliminations, but she's been absolutely wiping up the mats with everyone she's fought. She registered with the name '16' and nobody knows what her real name is. I'd be careful with this one."
			m_name = "Android 16"
			r_flag = RACE_ANDROID16
		end
	elseif dball_data.tourny_current_opponent == RACE_ANDROID17 then
		dball_data.tourny_type_of_fight = 1 -- Fight is to the death, and NO BACKING OUT!
		if dball_data.android_quest_status == 2 then
			intro = "...oh no...it can't be! They're HERE! They're actually here, competing in the Tournament! I...don't have to tell you...this fight is going to be the death. You'd better give it everything you've got. And I don't think the referees are going to quite as particular about how this match is fought, either."
			m_name = "Android 17"
			r_flag = RACE_ANDROID17
		else
			dball_data.android_quest_status = 1
			intro = "Next up...this one's kind of strange. Nobody's ever heard of this guy. He was a last minutes registrant, and we mostly figured he'd be gone by the second round of eliminations, but he's been absolutely wiping up the mats with everyone he's fought. He registered with the name '17' and nobody knows what his real name is. I'd be careful against this guy."
			m_name = "Android 17"
			r_flag = RACE_ANDROID17
		end

	elseif dball_data.tourny_current_opponent == RACE_RADDITZ then
		intro = "This guy doesn't look too tough. He sure is determined though. He was asking about you earlier, by the way."
		m_name = "Radditz"
		r_flag = RACE_RADDITZ
	elseif dball_data.tourny_current_opponent == RACE_VEGITA then
		intro = "This guy doesn't look too tough. He sure is determined though. He was asking about you earlier, by the way."
		m_name = "Vegita"
		r_flag = RACE_VEGITA
	elseif dball_data.tourny_current_opponent == RACE_BURTUR then
		intro = "Hmm. What a creepy looking alien. Personally since this is supposed to be the 'Worlds' strongest fighter tournament, I wouldn't allow any aliens. But...I'm not going to be the one to tell him no. How about you go beat him and save us the trouble?"
		m_name = "Burtur"
		r_flag = RACE_BURTUR
	elseif dball_data.tourny_current_opponent == RACE_GINYU then
		intro = "Hmm. What a creepy looking alien. Personally since this is supposed to be the 'Worlds' strongest fighter tournament, I wouldn't allow any aliens. But...I'm not going to be the one to tell him no. How about you go beat him and save us the trouble?"
		m_name = "Captain Ginyu"
		r_flag = RACE_GINYU
	elseif dball_data.tourny_current_opponent == RACE_GULDO then
		intro = "Hmm. What a creepy looking alien. Personally since this is supposed to be the 'Worlds' strongest fighter tournament, I wouldn't allow any aliens. But...I'm not going to be the one to tell him no. How about you go beat him and save us the trouble?"
		m_name = "Guldo"
		r_flag = RACE_GULDO
	elseif dball_data.tourny_current_opponent == RACE_GEICE then
		intro = "Hmm. What a creepy looking alien. Personally since this is supposed to be the 'Worlds' strongest fighter tournament, I wouldn't allow any aliens. But...I'm not going to be the one to tell him no. How about you go beat him and save us the trouble?"
		m_name = "Geice"
		r_flag = RACE_GEICE
	elseif dball_data.tourny_current_opponent == RACE_RECOOME then
		intro = "Hmm. What a creepy looking alien. Personally since this is supposed to be the 'Worlds' strongest fighter tournament, I wouldn't allow any aliens. But...I'm not going to be the one to tell him no. How about you go beat him and save us the trouble?"
		m_name = "Recoome"
		r_flag = RACE_RECOOME

	-- round 6,7,8

	elseif dball_data.tourny_current_opponent == RACE_BACTERIUM then
		intro = "Let's see...your next opponent will be Bacterium. I haven't seen him fight, but I have a penciled in comment from one of the other organizers that the guy has really bad breath. I'd keep my distance if I were you."
		m_name = "Bacterium"
		r_flag = RACE_BACTERIUM
	elseif dball_data.tourny_current_opponent == RACE_SHUU then
		intro = "Your next match is with a cat-ninja named Shuu. According to my notes he says he's participating for the glory of somebody named Pilaf. Never heard of him. Anyway..."
		m_name = "Shuu, Pilaf's Ninja"
		r_flag = RACE_SHUU
	elseif dball_data.tourny_current_opponent == RACE_YAWARA then
		intro = "Looks like you're next fight is with a local Judo instructor by the name of Yawara. She's small, but fast. Probably more dangerous than she looks."
		m_name = "Yawara"
		r_flag = RACE_YAWARA
	elseif dball_data.tourny_current_opponent == RACE_TATSU then
		intro = "Next up is a practitioner of Ninjutsu. His name is Tatsu. Looks like a fairly typical big, dumb, slow, strong fighter."
		m_name = "Tatsu"
		r_flag = RACE_TATSU
	elseif dball_data.tourny_current_opponent == RACE_RRA_YELLOW then
		intro = "Next up is...oh. That's strange. Last year the Tournament required participants to be generally humanoid. Looks like they've loosened up. Your next match is with a Red Ribbon Army officer named Yellow. Apparantly he's a tiger. Literally."
		m_name = "Captain Yellow"
		r_flag = RACE_RRA_YELLOW

	-- rounds 9,10,11,12

	elseif dball_data.tourny_current_opponent == RACE_BOB then
		intro = "Next up is a local instructor. He teaches at a Kickboxing school near here."
		m_name = "Bob"
		r_flag = RACE_BOB
	elseif dball_data.tourny_current_opponent == RACE_HONDA then
		intro = "Next up is a local instructor. He teaches at a Sumo school near here. He looks like a slow mover, but powerful."
		m_name = "Honda"
		r_flag = RACE_HONDA
	elseif dball_data.tourny_current_opponent == RACE_MASTER_LEE then
		intro = "Next up is a former instrcutor. He used to teach Tae Kwon Do, but closed his school right around the time that Sakura opened her Ballet studio. I haven't seen him fight, but I hear he's a fast kicker."
		m_name = "Master Lee"
		r_flag = RACE_MASTER_LEE
	elseif dball_data.tourny_current_opponent == RACE_LEONARDO then
		intro = "Next up: a green ninja swordfighter. He's been pretty courteous about the weapons...generally striking with the flat of the blade, but I'd be real careful all the same. One mistake and you could end up losing an arm with those things."
		m_name = "Leonardo"
		r_flag = RACE_LEONARDO
	elseif dball_data.tourny_current_opponent == RACE_DONATELLO then
		intro = "Next up: a green ninja with a staff. He's super fast, and has been doing quite well. I'd be careful."
		m_name = "Donatello"
		r_flag = RACE_DONATELLO
	elseif dball_data.tourny_current_opponent == RACE_MICHAELANGELO then
		intro = "Your next opponent is a green ninja...surfer, it seems. Well, that's an odd combination. Uses a fairly unorthadox set of paired nunchaku. I'm not sure what to make of this guy. He's done extremely well, but he doesn't seem to be fighting to win. He spends most of his time in the ring making jokes. Still, he's obviously skilled, so you should probably take him seriously."
		m_name = "Michaelangelo"
		r_flag = RACE_MICHAELANGELO
	elseif dball_data.tourny_current_opponent == RACE_RAPHAEL then
		intro = "Green ninja with an atttude. He weilds a pair of sai, and he's pretty good with them."
		m_name = "Raphael"
		r_flag = RACE_RAPHAEL
	elseif dball_data.tourny_current_opponent == RACE_RRA_MURASAKI then
		intro = "Looks like your next matcn is against a Red Ribbon Army officer. Hmm. At least I think he's an officer. Full name is: Seargent Major Ninja Purple Murasaki. Of course, that's a bit redundant. 'Murasaki' means purple."
		m_name = "Seargent Murasaki"
		r_flag = RACE_RRA_MURASAKI
	elseif dball_data.tourny_current_opponent == RACE_CHAPAO then
		intro = "Your next match will be with Chapao. He competes a lot and is very well known in Tourny circles. He routinely finishes in second or third, so I'd be careful against him if I were you. He may not be the strongest fighter, but he's very experienced."
		m_name = "Chapao"
		r_flag = RACE_CHAPAO
	elseif dball_data.tourny_current_opponent == RACE_ANTON then
		intro = "Next match is againat a greco-american wrestler. You have to be careful about these guys. They don't do much sparring, but they tend to do an incredible amount of strength training, and if they can grab a hold of you, it's over."
		m_name = "Anton, the Great"
		r_flag = RACE_ANTON
	elseif dball_data.tourny_current_opponent == RACE_PUNTER then
		intro = "Next up: Punter. I've seen a few of his matches. He's not the most tremendous fighter, but he has a lot of mass to throw around, and takes hits very well."
		m_name = "Punter"
		r_flag = RACE_PUNTER

	-- rounds 13,14,15

	elseif dball_data.tourny_current_opponent == RACE_NAKAMURA then
		intro = "Next up is a local instructor. He teaches at a Karate school near here."
		m_name = "Nakamura Sensei"
		r_flag = RACE_NAKAMURA
	elseif dball_data.tourny_current_opponent == RACE_FONG_SAI_YUK then
		intro = "Next up is a local instructor. He teaches at a Kung fu school near here."
		m_name = "Fong Sai Yuk"
		r_flag = RACE_FONG_SAI_YUK
	elseif dball_data.tourny_current_opponent == RACE_JACQUE then
		intro = "Next up is a local fencing instructor by the name of Jacque."
		m_name = "Jacque"
		r_flag = RACE_JACQUE
	elseif dball_data.tourny_current_opponent == RACE_NAM then
		intro = "Your next opponent is a boy from the nearby village. Nam is his name. He's a local favorite, so the audience will be against you on this one."
		m_name = "Nam"
		r_flag = RACE_NAM
	elseif dball_data.tourny_current_opponent == RACE_RANFAN then
		intro = "Your next opponent is...Ranfan? Wow...I thought she retired from fighting after her modeling career took off."
		m_name = "Ranfan"
		r_flag = RACE_RANFAN
	elseif dball_data.tourny_current_opponent == RACE_TAO_PAI_PAI then
		intro = "Next up is Tao Pai Pai. Looks like he's one of the Tournament's relatively rare participants who fight with weapons. Paired Chinese straightswords in this case. I'd be careful of this guy. It's rare for us to get more than one or two fatalities, but most of them are from weapons fighters."
		m_name = "Tao Pai Pai"
		r_flag = RACE_TAO_PAI_PAI
	elseif dball_data.tourny_current_opponent == RACE_GIRAN then
		intro = "Wow...it's a massive lizard...thing. He has wings, so I guess he's a pterodactyl, but I don't see how he could possibly fly, he's so big. Try not to get squashed by this guy."
		m_name = "Giran"
		r_flag = RACE_GIRAN

	-- rounds 16,17


	elseif dball_data.tourny_current_opponent == RACE_KRILLAN then
		intro = "Your next opponent is a monk from the Orinji Buddhist Temple out in the mountains. I've never seen this guy fight, but Orinji is well known for producing competant fighters."
		m_name = "Krillan"
		r_flag = RACE_KRILLAN
	elseif dball_data.tourny_current_opponent == RACE_CHAOZU then
		intro = "Ok...this is just weird. Your next opponent is a midget. No, seriously! He's pale and white...he looks like a doll, but he's been doing amazingly well. His name is Chaozu, and apparantly he's a student of the Crane Hermit out in the Frozen Wastes."
		m_name = "Chaozu"
		r_flag = RACE_CHAOZU
	elseif dball_data.tourny_current_opponent == RACE_TENSHINHAN then
		intro = "This next fighter has been doing very well. It seems he has a third eye fully manifest in his forehead. I bet he has incredible depth perception."
		m_name = "Tenshinhan"
		r_flag = RACE_TENSHINHAN
	elseif dball_data.tourny_current_opponent == RACE_BOJACK then
		intro = "I don't recognize your next opponent, and there's no bio listed for him. Sorry I can't help you much here. His name is Bojack."
		m_name = "Bojack"
		r_flag = RACE_BOJACK
	elseif dball_data.tourny_current_opponent == RACE_IRON_MONKEY then
		intro = "This next fighter seems to be a ninja of some kind, but his fighting style is distinctly Chinese. Tough to get a good read on him, but I'd be careful if I were you. Hes won half of his fights without taking a single punch."
		m_name = "The Iron Monkey"
		r_flag = RACE_IRON_MONKEY
	elseif dball_data.tourny_current_opponent == RACE_WONG_FEI_HONG then
		intro = "Next up is Wong-Fei Hong! Wow!"
		m_name = "Wong Fei Hong"
		r_flag = RACE_WONG_FEI_HONG
	elseif dball_data.tourny_current_opponent == RACE_MUSASHI then
		intro = "Next up is a Japanese guy who...well, he says he's a paired sword fighter, but he's not been using swords. Actually, he's been fighting with a rather awkward looking old club, and he's wearing what passes for pajamas in Japan. He says he didn't figure the World Tournament fighters would be good enough to bother getting dressed for this morning. I'd take this guy very seriously if I were you."
		m_name = "Miyamoto Musashi"
		r_flag = RACE_MUSASHI

	-- Possible crossover rounds 16-18

	elseif dball_data.tourny_current_opponent == RACE_MR_SATAN then
		-- Allow him to flake
		if dball_data.tourny_round == 18 then
			intro = "Alright then, this is it: The final round. Should be a good one too, you've been great, but now you're going to go up against Mr. Satan. He's won this tournament the past three years running, so you're going to have to give it everything you've got!"
			m_name = "Mr. Satan"
			r_flag = RACE_MR_SATAN
		else
			intro = "bump"
			m_name = "Mr. Satan"
			r_flag = RACE_MR_SATAN
		end

	-- Final Round 18 Only

	elseif dball_data.tourny_current_opponent == RACE_ROSSHI then
		intro = "This is it! The last round! Looks like it's going to be a tough one, too. You're up against Master Rosshi, the Turtle Hermit. He's sort of a local legend, but I didn't know he participated in Tournamnets like this. Well, this is it!"
		m_name = "Master Rosshi"
		r_flag = RACE_ROSSHI

	elseif dball_data.tourny_current_opponent == RACE_DEMON_KING_PICCOLO then
		intro = "Wow! It's amazing that we're already at the end of the Tournament! I'm sorry to say, though, that there's been a last minute substitution for the final round. It's very rare to see it happen, but there's an obscure loophole that allows registrants to designate substitutes in certain rare cases. Anyway, it seems your final opponent designated a substitute and then disappeared, so you're going to have to fihgt this otehr guy...even though he hasn't fought in a single round yet. I'm sorry, it's an unsual case but it's completely legitimmite. Mostly it just means the last round will be a big disappointment for everyone because this guy is probably a nobody. His name is Piccolo. Try not to hurt him too bad."
		m_name = "Demon King Piccolo"
		r_flag = RACE_DEMON_KING_PICCOLO
	else
		intro = "Error in World Tournament: Unable to allocate a monster. Defaulting to a generic black belt."
		m_name = "black belt"
		r_flag = RACE_BLACK_BELT
	end

	return intro, m_name, r_flag
end

-- Delete World Tournament monsters -- Do we care enough to delete by flag instead?
function dball.delete_tourny_monsters()
	for_each_monster(function(m_idx, monst)
		if monst.r_idx ~= RACE_WT_TICKET_GIRL and monst.r_idx ~= RACE_WT_MEDIC and monst.r_idx ~= RACE_WT_GUARD and monst.r_idx ~= RACE_WT_AUDIENCE_BLUE and monst.r_idx ~= RACE_WT_AUDIENCE_GREEN and monst.r_idx ~= RACE_WT_AUDIENCE_YELLOW and monst.r_idx ~= RACE_WT_BACKSTAGE_GUY then
			delete_monster_idx(m_idx)
		end
	end)
end
-- returns the number of a given monster type on the current level
-- NOTE: If called from a monster death hook, that monster will NOT
-- be counted dead until the hook is completed
function dball.how_many_exist(race_name)
	dball_data.monster_counter = 0
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == %race_name then
			dball_data.monster_counter = dball_data.monster_counter + 1
		end
	end)
	return dball_data.monster_counter
end

-- Grr-ness
function dball.fighting_ai(monst)
	if has_flag(monst, FLAG_DBT_AI) then
		monst.ai = monst.flags[FLAG_DBT_AI]
	end
end

-- What to do if the player attacks a friendly monster
-- ?????
-- Why does FACTION KAMI work, but the others don't?
function dball.faction_handler(which)

	--*************************************************
	--******************* FIX ME! *********************
	--*************************************************
	-- Hack! Temp! Implement me! Etc!
		for_each_monster(function(m_idx, monst)
			if monst.flags[FLAG_FACTION] == %which then
				if monst.flags[FLAG_DBT_AI] then
					monst.ai = monst.flags[FLAG_DBT_AI]
				end
			end
		end)
	--*************************************************
	--*************************************************
	--*************************************************
	-- Handle faction standing and 'other stuff'
	if which == FACTION_KAMI then
		-- Isn't there a cleaner way to do this?
		factions.set_friendliness(FACTION_PLAYER, FACTION_KAMI, factions.get_friendliness(FACTION_PLAYER, FACTION_KAMI) -10)
		factions.set_friendliness(FACTION_KAMI, FACTION_PLAYER, factions.get_friendliness(FACTION_KAMI, FACTION_PLAYER) -10)
		-- If in the Temple, call to arms
		if dball.current_location() == "Buddhist Temple" then
			message(color.YELLOW, "You hear the temple gong sound.")
		end
		for_each_monster(function(m_idx, monst)
			if monst.flags[FLAG_FACTION] == FACTION_KAMI then
				if monst.flags[FLAG_DBT_AI] then
					monst.ai = monst.flags[FLAG_DBT_AI]
				end
			end
		end)
	elseif which == FACTION_NEUTRAL then
		dball.neutral_annoy()
	elseif which == FACTION_PILAF then
		for_each_monster(function(m_idx, monst)
			if monst.flags[FLAG_FACTION] == FACTION_PILAF then
				if monst.flags[FLAG_DBT_AI] then
					monst.ai = monst.flags[FLAG_DBT_AI]
				end
			end
		end)
	elseif which == FACTION_FOOT then
		-- Special case...standard handling...careful changing this
		-- See The Foot Lair, level 18
		dball.faction_annoy(FACTION_FOOT)
	elseif which == FACTION_DRAGON then
		factions.set_friendliness(FACTION_PLAYER, FACTION_DRAGON, -10)
		factions.set_friendliness(FACTION_DRAGON, FACTION_PLAYER, -10)
	elseif which == FACTION_GERO then
		drgero.annoy()
	elseif which == FACTION_GOOD then
		factions.set_friendliness(FACTION_PLAYER, FACTION_GOOD, -10)
		factions.set_friendliness(FACTION_GOOD, FACTION_PLAYER, -10)
	elseif which == FACTION_BAD then
		factions.set_friendliness(FACTION_PLAYER, FACTION_BAD, -10)
		factions.set_friendliness(FACTION_BAD, FACTION_PLAYER, -10)
	end
end

function dball.annoy_map()
	for_each_monster(function(m_idx, monst)
		if monst.faction ~= FACTION_PLAYER then
			monst.faction = FACTION_DUNGEON
			if monst.flags[FLAG_DBT_AI] then
				monst.ai = monst.flags[FLAG_DBT_AI]
			end
		end
	end)
end
function dball.annoy_monster(which)
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == %which then
			monst.faction = FACTION_DUNGEON
			if monst.flags[FLAG_DBT_AI] then
				monst.ai = monst.flags[FLAG_DBT_AI]
			end
		end
	end)
end

-- Generic function to cause the neutral faction to (temporarily)
-- be aggressive (lasts until level change)
function dball.neutral_annoy()
	factions.set_friendliness(FACTION_PLAYER, FACTION_NEUTRAL, -100)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_PLAYER, -100)
	for_each_monster(function(m_idx, monst)
		if monst.faction == FACTION_NEUTRAL then
			-- message("Hello?")
			if monst.flags[FLAG_DBT_AI] then
				monst.ai = monst.flags[FLAG_DBT_AI]
				message("1 ")
			end
		end
	end)
end

-- Same as above...but takes a faction
-- Grandfather clausing the previous function, for now
function dball.faction_annoy(which)
	factions.set_friendliness(FACTION_PLAYER, which, -100)
	factions.set_friendliness(which, FACTION_PLAYER, -100)
	for_each_monster(function(m_idx, monst)
		if monst.faction == %which then
			if monst.flags[FLAG_DBT_AI] then
				monst.ai = monst.flags[FLAG_DBT_AI]
			end
		end
	end)
end

function dball.faction_unannoy(which)
	factions.set_friendliness(FACTION_PLAYER, which, 1)
	factions.set_friendliness(which, FACTION_PLAYER, 1)
	for_each_monster(function(m_idx, monst)
		if monst.faction == %which then
			-- Dangerous...but if data is correct, should be safe:
			if monst.flags[FLAG_DBT_AI] then
				monst.ai = monst.flags[FLAG_AI]
			end
		end
	end)
end

function dball.helpscreen()
	term.save()
	term.blank_print("", 0, 0)
	term.text_out(color.YELLOW, "Command Reference\n")
	term.text_out(color.LIGHT_BLUE, "Movement             Important                 Visuals / Screens     \n")
	term.text_out(" Arrow keys to move   ctrl-x : Save and exit    C - Character sheet  \n")
	term.text_out(" < - Go up            ctrl-q : View quest log   M - Overhead map     \n")
	term.text_out(" > - Go down          ? for help                G - Skill screen     \n")
	term.text_out(" Shift+dir to run                               N - Abilities screen \n")
	term.text_out("                                                = - Options          \n")
	term.text_out(color.LIGHT_BLUE, "Item Handling               Other               ~ - Extra information\n")
	term.text_out(" i - Inventory               l - Look                                \n")
	term.text_out(" e - Equipment               ? - Help                                \n")
	term.text_out(" g - Get                     o - Open a door                         \n")
	term.text_out(" d - Drop                    c - Close a door                        \n")
	term.text_out(" w - Wear/Wield              s - Search                              \n")
	term.text_out(" t - Take off                S - Change movement mode                \n")
	term.text_out(" r - Read                    n - Repeat last command                 \n")
	term.text_out(" u - Use item                Q - Quit (abandon character)            \n")
	term.text_out(" k - Destroy                 U - Use ability                         \n")
	term.text_out(" f - Fire a gun              m - Manipulate constant effects         \n")
	term.text_out(" a - Reload ammo             D - Disarm a trap                       \n")
	term.text_out(" E - Eat                     Y - Talk to someone                     \n")
	term.text_out(" q - Quaff (drink)           y - Give an item to someone             \n")
	term.text_out(" F - Refill/refuel           R - Rest for a while                    \n")
	term.text_out(" I - Inspect an item         T - Tunnel (not implemented)            \n")
	dialogue.conclude()
	term.load()
end

function dball.clue(pre_fix)
	if not pre_fix then
		pre_fix = ""
	end
	monster_random_say
	{
		-- Humor
		pre_fix .. "'The women of Aru have a saying: Hare today, gone tomorrow.'",
		pre_fix .. "'No-bo is better than Nyoi-bo!'",
		pre_fix .. "'How would you feel if you were named after a cabbage?'",
		pre_fix .. "'Two barehand, or two weapon? That is the question.'",
		pre_fix .. "'Your ad here!'",
		pre_fix .. "'This fortune has not been implemented, yet.'",
		pre_fix .. "'May I recommend you study the Leaping Leopard style?'",
		pre_fix .. "'Your lotto numbers for today are: " .. rng(1, 99) .. " " .. rng(1, 99) .. " " .. rng(1, 99) .. " " .. "'",
		pre_fix .. "'What? Were you expecting a clue, or something?'",
		pre_fix .. "'He who turns and runs away lives to run another day.'", -- Quote from the Wizardry manual
		-- Misleading
		pre_fix .. "'There's no such thing as a Bio-Android!'",
		-- Martial/Asian/Thematic/Etc Expressions/Quotes
		pre_fix .. "'Never chase a dragon.'",
		pre_fix .. "'A good general discusses logistics. A Great general discusses the flow of energy.'", -- Art of War
		pre_fix .. "'It is the empty space within a pot that makes it useful.'", -- Tao Te Ching
		pre_fix .. "'Ten pounds of flax!'", -- Zen Buddhist expression
		-- Useful Tips and Clues
		pre_fix .. "'Technomancers don't need to learn first aid, swimming, or flight.'"
		pre_fix .. "'You don't HAVE to learn to swim.'",
		pre_fix .. "'The prize for winning the World Tournament is 100,000 zeni!'",
		pre_fix .. "'There is a way to destroy the Dragonballs forever. Don't find it.'",
		pre_fix .. "'Pay close attention to the Fan Lady's phrasing.'",
		pre_fix .. "'Have you found all eight schools?'",
		pre_fix .. "'Don't fall behind on your payments!'",
		pre_fix .. "'Wishes cannot impinge upon the free will of conscious beings.'",
		pre_fix .. "'There are at least four ways to get into Mr. Satan's estate.'",
		pre_fix .. "'Fugu contains one of the deadliest neuro-toxins known to man, or fish.'",
		pre_fix .. "'Wishes must begin with 'I wish''",
		pre_fix .. "'Don't annoy Shenron.'",
		pre_fix .. "'Flame throwers are nasty!'",
	}
end

-- Used to round of number to the nearest ten, hundred, etc.
function dball.round_off(min, max, mult)
	local warm_and_cuddly_number = rng(min, max)
	warm_and_cuddly_number = warm_and_cuddly_number / mult
	warm_and_cuddly_number = warm_and_cuddly_number * mult
	return warm_and_cuddly_number	
end

-- Convert a stored number to a string displaying the converted decimal
function dball.show_me_a_dec(the_number, divisor)
	local left_of_dec = the_number / divisor
	local right_of_dec = the_number - (left_of_dec * divisor)

	local num_str = tostring(left_of_dec)
	if right_of_dec ~= 0 then
		if right_of_dec < 0 then
			right_of_dec = right_of_dec * -1
		end
		num_str = num_str .. "." .. tostring(right_of_dec)
	end
	return num_str
end

--[[
-- Nyoibo now using los(). Is this used anymore?
-- Is there a clear path between two points?
-- Used by Nyoibo, Judo Throw, Burst of Speed, etc.
-- This doesn't work. Fix it please.
function dball.are_there_walls(x1, y1, x2, y2)
	local start_x, start_y = x1, y1
	local is_blocker = false
	local ny, nx
	while not nil do
		if ((y1 == y2) and (x1 == x2)) then
			break
		end

		-- Calculate the new location (see "project()")
		ny = y1
		nx = x1
		ny, nx = mmove2(ny, nx, start_y, start_x, y2, x2)

		-- Stopped by walls/doors
		if (cave_floor_bold(ny, nx) == nil) then
			is_blocker = true
			break
		end

		-- Save the new location
		x1 = nx
		y1 = ny
	end

	--return is_blocker
	return true
end
]]

-- Custom fire_bolt
function dball.chi_burst(dam_typ, caster, orig_y, orig_x, dest_y, dest_x, dir, dam_qty, rad)
	if caster == 0 then
		-- player
		local tdis = 20	-- arbitrary max range
		local by = player.py
		local bx = player.px
		local y = player.py
		local x = player.px
		local ny, nx

		-- Predict the "target" location
		local dy, dx = explode_dir(dir)
		local tx = player.px + 99 * dx
		local ty = player.py + 99 * dy

		-- Check for "target request"
		if (dir == 5) and (target_okay()) then
			tx = target_col
			ty = target_row
		else
			ty, tx = dest_y, dest_x
		end

		-- Travel until stopped
		for cur_dis = 0, tdis do
			-- Hack: Explode at target
			if ((y == ty) and (x == tx)) then
				project(caster, rad, y, x, dam_qty, dam_typ, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
				break
			end

			-- Calculate the new location (see "project()")
			ny = y
			nx = x
			ny, nx = mmove2(ny, nx, by, bx, ty, tx)

			-- Explode on walls and doors
			if (cave_floor_bold(ny, nx) == nil) then
				project(caster, rad, ny, nx, dam_qty, dam_typ, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
				break
			end

			-- Save the new location
			x = nx
			y = ny

			local c_ptr = cave(y, x)
			local m_ptr

			-- We hit someone
			if c_ptr.m_idx > 0 then
				local monst = monster(c_ptr.m_idx)
				local m_name = monster_desc(monst, 0)
				-- Does the monster reflect the blast back to the player?
				if has_flag(monst, FLAG_DBT_REFLECT) then
					local reflect_chance = monst.flags[FLAG_DBT_REFLECT]
					-- Adjust for powerful blasts
					reflect_chance = reflect_chance - (dam_qty / 10)
					if rng(1, 100) <= reflect_chance then
						local foo = {" reflects your blast back to you!", " catches it and throws it back at you!"}
						message(m_name .. foo[rng(1,2)])
						-- Double-reflection not allowed, but player
						-- may attempt to deflect it
						local p_deflect = get_skill(SKILL_CHI_DEFENSE) - (dam_qty / 10)
						if rng(1, 100) <= p_deflect then
							local foo = {"But you manage to deflect it!", "But you slap it aside.", "You catch it in your hands and absorb the blast."}
							message(foo[rng(1,3)])
						else
							-- Player take full effect of his own Chi Burst!
							project(c_ptr.m_idx, rad, player.py, player.px, dam_qty, dam_typ, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
						end
						return -- break?
					end
				end
				-- Does the monster deflect the blast?
				if has_flag(monst, FLAG_DBT_DEFLECT) then
					local deflect_chance = monst.flags[FLAG_DBT_DEFLECT]
					-- Adjust for powerful blasts
					deflect_chance = deflect_chance - (dam_qty / 10)
					if rng(1, 100) <= deflect_chance then
						local foo = {" deflects your blast", " slaps your blast away", " deflects your blast harmlessly away", " catches your blast and shrugs it off"}
						message(m_name .. foo[rng(1,4)])
						return -- break?
					end
				end
				project(caster, rad, ny, nx, dam_qty, dam_typ, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
			end
		end
	else
		-- not player, but could still be a companion
	end
end

function dball.player_adjacent_to_water()
	for yy = -1, 1 do
		for xx = -1, 1 do
			local cf = cave(player.py + yy, player.px + xx).feat
			if cf.flags[FLAG_WATER] then
				return true
			end
		end
	end
	return false
end

-- Replacement for increase_mana()
function dball.mod_chi(qty)
	dball_data.cur_chi_pool = dball_data.cur_chi_pool + qty
	if dball_data.cur_chi_pool > dball_data.max_chi_pool then
		dball_data.cur_chi_pool = dball_data.max_chi_pool
	end
	player.redraw[FLAG_PR_MANA] = true
end
-- To modify current hp
function dball.mod_hp(qty, only_if_live)
	if dball_data.alive == 0 then
		dball_data.cur_chi_pool = dball_data.cur_chi_pool + qty
		if dball_data.cur_chi_pool > dball_data.max_chi_pool then
			dball_data.cur_chi_pool = dball_data.max_chi_pool
		end
		player.redraw[FLAG_PR_MANA] = true
	else
		if not only_if_live then
			hp_player(qty)
		else
			return false
		end
	end
	return true
end

-- Called by process World
function dball.chi_regen()

	local mana_amt = 0
	local old_chi = dball_data.cur_chi_pool

	-- ALLOW over max!
	-- Fix later if over			  -- Note the - We're subtracting a negative drain
	dball_data.cur_chi_pool = dball_data.cur_chi_pool - dball.chi_get_drain(AB_MEDITATION)

	-- Flight
	if dball_data.chi_flight_setting == 1 then
		mana_amt = dball.chi_get_drain(AB_FLIGHT)
		if dball_data.cur_chi_pool - mana_amt < 1 then
			dball_data.chi_flight_setting = 0
			message(color.YELLOW, "You fall from the air!")
		else
			dball.mod_chi(-mana_amt)
		end
	end

	-- Battle Aura
	if dball_data.chi_aura_setting == 1 then
		mana_amt = dball.chi_get_drain(AB_AURA)
		if dball_data.cur_chi_pool - mana_amt < 1 then
			dball_data.chi_aura_setting = 0
			message(color.YELLOW, "Your aura crumbles!")
		else
			dball.mod_chi(-mana_amt)
		end
	end

	-- Haste
	if dball_data.chi_haste_setting > 0 then
		mana_amt = dball.chi_get_drain(AB_HASTE)
		if dball_data.cur_chi_pool - mana_amt < 0 then
			dball_data.chi_haste_setting = 0
			message(color.YELLOW, "You slow down!")
		else
			dball.mod_chi(-mana_amt)
		end
	end

	-- Regeneration
	if dball_data.chi_regeneration_setting > 0 then
	mana_amt = dball.chi_get_drain(AB_REGENERATION)
		if dball_data.cur_chi_pool - mana_amt < 0 then
			dball_data.chi_regeneration_setting = 0
			message(color.YELLOW, "You stop regenerating!")
		else
			dball.mod_chi(-mana_amt)
		end
	end

	-- Absorbtion
	if dball_data.chi_absorbtion_setting > 0 then
		mana_amt = dball.chi_get_drain(AB_ABSORBTION)
		if dball_data.cur_chi_pool - mana_amt < 0 then
			dball_data.chi_absorbtion_setting = 0
			message(color.YELLOW, "Your aura weakens!")
		else
			dball.mod_chi(-mana_amt)
		end
	end

	-- Aura Light (Lowest priority, first one to turn off)
	if dball_data.chi_light_setting > 0 then
		mana_amt = dball.chi_get_drain(AB_LIGHT)
		if dball_data.cur_chi_pool - mana_amt < 1 then
			dball_data.chi_light_setting = 0
			message(color.YELLOW, "Your light dims!")
		else
			dball.mod_chi(-mana_amt)
		end
	end

	-- Here the 'later' where we 'fix it'
	-- Temporarily allowing the chi pool to go above max
	-- allows regeneration to occur properly when we are near that max
	-- This incidentally was the only reason we had to stop using
	-- the mana counter.
	if dball_data.cur_chi_pool > dball_data.max_chi_pool then
		dball_data.cur_chi_pool = dball_data.max_chi_pool
	end

	if old_chi ~= dball_data.cur_chi_pool then
		player.redraw[FLAG_PR_MANA] = true
	end

	-- General Blue's Lair Submerge
	if dball_data.rra_blue_submerge == 1 and dball.current_location() == "Underwater Cavern" then
		-- Rate of submersion increases as player tries to escape
		local how_bad = 10 * (37 - dun_level) 
		for i = 1, how_bad do
			local y = rng(1, cur_hgt - 2)
			local x = rng(1, cur_wid - 2)
			if cave(y, x).feat == FEAT_FLOOR or cave(y, x).feat == FEAT_DIRT or cave(y, x).feat == FEAT_MORE then
				cave_set_feat(y, x, FEAT_DROWNING_WATER)
			end
		end
		-- And while we're here
		if cave(player.py, player.px).feat == FEAT_DROWNING_WATER and dball.player_needs_air() == true then
			message("You are drowning!")
			take_hit(rng(5,10), "drowning")
		end
	end

	if cave(player.py, player.px).feat == FEAT_DEEP_SPACE
	   or cave(player.py, player.px).feat == FEAT_AESTHETIC_SPACE
	      and dball.player_needs_air() == true then

		message("You are suffocating!")
		take_hit(rng(1,100), "suffocation in space")
	end

	-- General Deep Water drowner
	if cave(player.py, player.px).feat == FEAT_DEEP_WATER and dball.player_needs_air == true then
		if dball_data.chi_flight_setting == 0 then
			take_hit(rng(1,3), "drowning")
		end
	end

end

-- Can't use an intrinsic for SCUBA gear, since it is dependant on fuel
-- NOTE: This allows EVA suits to grant 'water' breathing
function dball.player_needs_air()
	if dball_data.alive ~= 0 then
		return false
	elseif player.inventory[INVEN_TOOL][1] then
		-- This is sketchy. Works for SCUBA gear and spacesuits, but...
		if player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_VEHICLE_SPACESHIP] then
			return false
		elseif player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL_REQUIRE] and player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL_REQUIRE] == FLAG_OXYGEN_TANK then
			if player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL] > 0 then
				player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL] = player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL] - 1
				return false
			end
		end
	end

	return true
end

-- Inventory stacking helper
function dball.inven_stack()
	for inven_idx = INVEN_INVEN, INVEN_TOTAL - 1 do
		local inven = player.inventory[inven_idx]
		local max = flag_max_key(inven)
		for item_idx = max, 1, -1 do
			local item = compute_slot(inven_idx, item_idx)
			item_optimize(item)
		end
	end



--	for j = INVEN_INVEN, INVEN_TOTAL - 1 do
--		for i = flag_max_key(player.inventory[j]), 1, -1 do
--			item_optimize(compute_slot(j, i))
--		end
--	end
--	for_inventory(player, INVEN_INVEN, INVEN_TOTAL,
--		function(obj, i, j, item)
--	for i = 1, player.inventory_limits(INVEN_INVEN) do
--		item_optimize(i)
--	end
--		end)
end

-- Shall we warn the player that the whole planet is about to be destroyed if he's not careful?
function dball.forewarning()
	if dball_data.has_visited_briefs == 0 and dball_data.ttq_forewarning == 0 then
		local br_wire = 0
		local br_solder = 0
		for i = 1, player.inventory_limits(INVEN_INVEN) do
			if player.inventory[INVEN_INVEN][i] then
				if player.inventory[INVEN_INVEN][i].k_idx == lookup_kind(TV_CIRCUITRY, SV_SPOOL_OF_WIRE) then
					br_wire = player.inventory[INVEN_INVEN][i].number
				end
				if player.inventory[INVEN_INVEN][i].k_idx == lookup_kind(TV_CIRCUITRY, SV_SPOOL_OF_SOLDER) then
					br_solder = player.inventory[INVEN_INVEN][i].number
				end
			end
		end

		if br_wire == 1 and br_solder == 1 then
			-- Oh, uh...
			dball_data.ttq_forewarning = 1
			return true
		end
	end

	-- No, the player is safe...for now.
	return false
end

-- Return a random element of a list
function dball.pick_one(list)
	return list[rng(getn(list))]
end

-- Check to see if the player is on earth
function dball.am_i_on_earth()

	if player.wilderness_y == 6 or player.wilderness_y == 7 or player.wilderness_y == 8 and
		player.wilderness_x == 4 or player.wilderness_x == 5 or player.wilderness_x == 6 then

		if d_info[current_dungeon_idx + 1].name and d_info[current_dungeon_idx + 1].name == "Hell" then
			return false
		elseif d_info[current_dungeon_idx + 1].name and d_info[current_dungeon_idx + 1].name == "The Serpent's Path" then
			return false
		--elseif d_info[current_dungeon_idx + 1].name and d_info[current_dungeon_idx + 1].name == "Heaven" then
		--	return false
		-- East Kaioshin's world...
		end
	else
		return false
	end
	return true
end
-- Check to sse if the player is on Namek
function dball.am_i_on_namek()
	if (player.wilderness_y == 13 and player.wilderness_x == 14) or
	 (player.wilderness_y == 13 and player.wilderness_x == 15) or
	  (player.wilderness_y == 14 and player.wilderness_x == 14) or
	   (player.wilderness_y == 14 and player.wilderness_x == 15) then
		return true
	else
		return false
	end
end

-- Dungeon Teleport Helper Function
-- NOTE: This is only intended to transport the character to
-- the 'teleport dungeons' and relies on special handling
-- elsewhere to return the character to the correct position
-- on exit.
function dball.dungeon_teleport(which)
	local dun_names = {}
	local dun_idxs  = {}
	local error_check = 1
	for i = 1, __d_num do
		if d_info[i].name and d_info[i].name ~= "" then
			tinsert(dun_names, d_info[i].name)
			dun_idxs[d_info[i].name] = i - 1
		end
	end
	if getn(dun_names) == 0 then
		message("WARNING: No dungeons to teleport to!!")
		return
	end

	for i = 1, __d_num do
		if d_info[i].name and d_info[i].name == which then
			local dun_idx = dun_idxs[dun_names[i]]
			dun_level = d_info[dun_idx + 1].mindepth

			-- I don't think I'm using any of these
			player.inside_arena = 0
			leaving_quest       = player.inside_quest
			player.inside_quest = 0
			player.leaving      = true

			current_dungeon_idx = dun_idx
			error_check = 0
		end
	end
	if error_check == 1 then
		message("Error: attempting to teleport to an unrecognized dungeon")
	end
end -- dungeon teleport helper function

-- How do we pull this from town_info?
function dball.planetary_teleport_helper(which)
	local y, x, yy, xx
	if which == "Earth" then
		y, x, yy, xx = 7, 5, 34, 111
	elseif which == "Kaio" then
		y, x, yy, xx = 2, 24, 34, 111
	elseif which == "Kaio via Serpent" then
		y, x, yy, xx = 2, 24, 33, 116
	elseif which == "Earth via Serpent" then
		y, x, yy, xx = 6, 5, 24, 133
	elseif which == "Namek" then
		y, x, yy, xx = 13, 14, 34, 111
	elseif which == "Plant" then
		y, x, yy, xx = 9, 26, 34, 111
	elseif which == "79" then
		y, x, yy, xx = 16, 44, 35, 111
	else
		message("Unrecognized location in dball.planetary_teleport_helper()!")
		return false
	end

	-- No redundancy checking?
	if dball.current_location() == which then
		message("Already there!")
		return true
	else
		dun_level = 0
		player.wilderness_y = y
		player.wilderness_x = x
		player.py = yy
		player.px = xx
		player.leaving = true
	end
	return true
end

-- Challenge Quest Helper Function
-- Just performs some preliminary checks to see if
-- an instructor will consider a challenge
function dball.challenge_is_ok()
	if quest(QUEST_TOURNAMENT).status == QUEST_STATUS_FINISHED then
		message("Fight YOU?!!? No way! Honestly, I'm flattered, but you're way out of my league!")
		return false
	elseif player.lev < 10 then
		message("You wish to duel? Hmm. I'm sorry, but I really don't think you're ready.")
		return false
	else
		-- Shall we also check to ses if the player has WT fought this particular instructor?
		-- So as to taunt him, and so forth? Probably not here though, hmm
		return true
	end
end

-- Cure secondary conditions: used by acupuncture, senzu, ab_cure and death
function dball.cure_cond()
	restore_level()
	timed_effect(timed_effect.HALLUCINATE, 0)
	timed_effect(timed_effect.SLOW, 0)
	timed_effect(timed_effect.BLIND, 0)
	timed_effect(timed_effect.CONFUSED, 0)
	timed_effect(timed_effect.AFRAID, 0)
	timed_effect(timed_effect.PARALYZED, 0)
	timed_effect(timed_effect.CUT, 0)
	timed_effect(timed_effect.POISON, 0)
	timed_effect(timed_effect.STUN, 0)
	do_res_stat(A_STR, true)
	do_res_stat(A_CON, true)
	do_res_stat(A_DEX, true)
	do_res_stat(A_WIL, true)
	do_res_stat(A_INT, true)
	do_res_stat(A_CHR, true)
	do_res_stat(A_SPD, true)
end

function dball.reward(obj)
	-- obj = create_artifact(obj)

	local destroy = true
	for i = 1, player.inventory_limits(INVEN_INVEN) - 1 do
		if not player.inventory[INVEN_INVEN][i] or player.inventory[INVEN_INVEN][i].k_idx == 0 then destroy = false break end
	end
	if destroy then
		drop_near(obj, -1, player.py, player.px)
	else
		inven_carry(obj, false)
	end

end

function dball.drop_everything()
		-- Drop everything in inventory
		player.au = 0
		-- for i = player.inventory_limits(INVEN_INVEN), 1, -1 do
		--	if player.inventory[INVEN_INVEN][i] then
		--		inven_drop(i, 100, player.py, player.px, false)
		--	end
		-- end

	-- Copied from ToME: Theives Quest
	-- Not sure why it's done this way, but it does what I want
	-- better than the above
	local items = {}

	-- Get list of objects...
	for_inventory(player, INVEN_INVEN, INVEN_TOTAL,
		function(obj, i, j, item)
			if not is_artifact(obj) then
				tinsert(%items, item)
			end
		end)

	-- and drop them (in reverse order, so we don't
	-- shift the item array and change the item indexes)
	for i = getn(items), 1, -1 do
		inven_drop(items[i], 100, player.py, player.px, false)
	end
end

function dball.player_has_kidx(which)
	local obj
	for i = 1, player.inventory_limits(INVEN_INVEN) do
		if player.inventory[INVEN_INVEN][i] then
			obj = player.inventory[INVEN_INVEN][i]
			if obj and obj.k_idx == which then
				return true
			end
		end
	end
	return false
end

-- Dialogue helper, returns the number of dragonballs
-- that remain to be found
function dball.dragonballs_left(which)
	local dragonball_count = 0
	if which == FLAG_NAMEK_DRAGONBALL then
		for i = 1, 7 do
			if namek_dragonballs[i] == 0 then
				dragonball_count = dragonball_count + 1
			end
		end
	else
		for i = 1, 7 do
			if earth_dragonballs[i] == 0 then
				dragonball_count = dragonball_count + 1
			end
		end
	end
	return dragonball_count
end

-- Returns the number of dragonballs
-- currently in inventory
function dball.dragonballs_carried(which)
	local obj
	local dragonball_count = 0

--	if not which then
--		local which = FLAG_EARTH_DRAGONBALL
--	end
	for i = 1, player.inventory_limits(INVEN_INVEN) do
		if player.inventory[INVEN_INVEN][i] then
			obj = player.inventory[INVEN_INVEN][i]
			if obj and obj.tval == TV_DBALL then
				-- Default to Earth if not specified
				-- Does this work? Or logic in LUA is different than I'm accustomed to
				if has_flag(obj, (which or FLAG_EARTH_DRAGONBALL)) then
					dragonball_count = dragonball_count + 1
				end
			end
		end
	end
	return dragonball_count
end

function dball.allocate_dragonballs()
	local locations =
		{
			RACE_RRA_RED,
			RACE_ROSSHI,
			RACE_OOLONG,
			RACE_RRA_WHITE,
			RACE_RRA_BLUE,
			RACE_PILAF,
			RACE_BEAR_THIEF,
			RACE_HASUKI,
			RACE_BURUMA,
		}


end

function dball.remove_items_with_flag(which_flag, qty)
	-- Ehh. It's 2:00am
	if not qty then
		qty = 999999
	end
	local qty_removed = 0
	for i = 1, player.inventory_limits(INVEN_INVEN) do
		if qty_removed < qty then
			if player.inventory[INVEN_INVEN][i] then
				obj = player.inventory[INVEN_INVEN][i]
				if obj and has_flag(obj, which_flag) then
					if obj.number + qty_removed >= qty then
						qty_removed = qty
						item_increase(i, (-1 * (qty - qty_removed)))
						item_optimize(i)
					else
						qty_removed = qty_removed + obj.number
						item_increase(i, -99)
						item_optimize(i)
					end
				end
			end
		end
	end
	return qty_removed
end

-- Removes all dragonballs from inventory,
-- and returns the number so removed
-- Grr! Not working! Think order needs to be reversed! Implement me!
function dball.dragonballs_deliver(which)
	if not which then
		local which = FLAG_EARTH_DRAGONBALL
	end
	local obj
	local dragonball_count = 0
	-- Does the player have a Dragonball?
	for i = 1, player.inventory_limits(INVEN_INVEN) do
		if player.inventory[INVEN_INVEN][i] then
			obj = player.inventory[INVEN_INVEN][i]
			if obj and obj.tval == TV_DBALL then
				if has_flag(obj, which) then
					item_increase(i, -99)	-- Grr...
					item_optimize(i)
					dragonball_count = dragonball_count + 1
				end
			end
		end
	end
	return dragonball_count
end

--[[
-- Returns the number of dragonballs
-- in all stores, everywhere (including homes)
funtion dball.dragonballs_in_store()
	local dragonball_count = 0
	-- for i = 1, getn(st_info) do
		-- I really don't know how to access these arrays	
		-- All the functions in engine.lua assume that store_info
		-- is being passed to them.
	-- end
	return dragonball_count
end
]]

-- Bugtest-only function: Drop a Dragonball
function dball.dball(which)
	if not which then
		local which = FLAG_EARTH_DRAGONBALL
	end
	local obj = dball.request_dragonball(which)
	if obj then
		drop_near(obj, -1, player.py, player.px)
	else
		message("No more dragonballs available!")
	end
end

function dball.request_dragonball(which)
	local db_list = {}
	local w_bounds = 0
	local dbdbdb = {}
	local a_ptr

	if not which then
		local which = FLAG_EARTH_DRAGONBALL
	end

	if which == FLAG_NAMEK_DRAGONBALL then
		a_ptr = namek_dragonballs
		dbdbdb[1] = ART_NAMEK_DRAGONBALL1
		dbdbdb[2] = ART_NAMEK_DRAGONBALL2
		dbdbdb[3] = ART_NAMEK_DRAGONBALL3
		dbdbdb[4] = ART_NAMEK_DRAGONBALL4
		dbdbdb[5] = ART_NAMEK_DRAGONBALL5
		dbdbdb[6] = ART_NAMEK_DRAGONBALL6
		dbdbdb[7] = ART_NAMEK_DRAGONBALL7
	else
		a_ptr = earth_dragonballs
		dbdbdb[1] = ART_DRAGONBALL1
		dbdbdb[2] = ART_DRAGONBALL2
		dbdbdb[3] = ART_DRAGONBALL3
		dbdbdb[4] = ART_DRAGONBALL4
		dbdbdb[5] = ART_DRAGONBALL5
		dbdbdb[6] = ART_DRAGONBALL6
		dbdbdb[7] = ART_DRAGONBALL7
	end

	for i = 1, 7 do
		if a_ptr[i] == 0 then
			w_bounds = w_bounds + 1
			db_list[w_bounds] = dbdbdb[i]
		end
	end

	-- None available
	if w_bounds == 0 then
		if wizard then
			message("Wizard: attempted to create a dragonball, but none are available!")
		end
		return
	end

	local pick_db = rng.roll(1, w_bounds)
	local obj

	obj = create_artifact(dbdbdb[db_list[pick_db]])
	return obj
end

function dball.place_wishhouse(where)
	if where == "Earth" then
			cave_set_feat(26, 79, FEAT_PERMA_WALL)
			cave_set_feat(26, 80, FEAT_PERMA_WALL)
			cave_set_feat(26, 81, FEAT_PERMA_WALL)
			cave_set_feat(27, 79, FEAT_PERMA_WALL)
			cave_set_feat(27, 80, FEAT_PERMA_WALL)
			cave_set_feat(27, 81, FEAT_PERMA_WALL)
			cave_set_feat(28, 79, FEAT_PERMA_WALL)
			cave_set_feat(28, 81, FEAT_PERMA_WALL)
			cave_set_feat(29, 80, FEAT_ASPHALT)
			cave_set_feat(30, 80, FEAT_ASPHALT)
			local c_ptr = cave(28, 80)
			flag_empty(cave(28, 80).flags)
			cave_set_feat(28, 80, FEAT_SHOP)
			cave(28, 80).flags[FLAG_CONTAINS_BUILDING] = store.STORE_WISHHOME_EARTH
			cave(28, 80).flags[FLAG_STORE_OWNER] = store.OWNER_PLAYER
			--  REMEMBER=true NOTICE=true 
			cave(28, 80).inventory[INVEN_LIMIT_KEY] = 0
	elseif where == "Namek" then
		message("Wishhouse on Namek has not been implemented!")
	end
end

-- Returns a suitable open spot of terrain
function dball.find_open_space(y, x, radius)
	local i, yp, xp
	local found = false

	yp = nil
	xp = nil

	for i = 0, radius do
		-- local dist = (i / 15) + 1

		yp, xp = scatter(y, x, i, 0)

		if yp and xp and cave_empty_bold(yp, xp) then
			found = true
			break
		end
	end

	if not found then
		return -1
	else
		return yp, xp
	end
end

-- Seiyan names are wordplays on vegetables (Vegita, Radditz, Brolli, etc.)
function dball.generate_seiyan_name()
	return rng(1,9)
end

-- Seiyan names are wordplays on vegetables (Vegita, Radditz, Brolli, etc.)
function dball.get_seiyan_name()

	local which = dball_data.seiyan_name
	if player.get_sex() == "Male" then
		which = which + 9
	end

	if which == 1 then
		return "Letucia"		-- Lettuce
	elseif which == 2 then
		return "Karatina"		-- Carrot
	elseif which == 3 then
		return "Zuchinia"		-- Zuchini
	elseif which == 4 then
		return "Potara"		-- Potato
	elseif which == 5 then
		return "Tomatia"		-- Tomato
	elseif which == 6 then
		return "Caulifina"	-- Cauliflower
	elseif which == 7 then
		return "Cabasha"		-- Cabbage
	elseif which == 8 then
		return "Brusella"		-- Brussel Sprouts
	elseif which == 9 then
		return "Oninia"		-- Onion
	elseif which == 10 then
		return "Garlo"		-- Garlic
	elseif which == 11 then
		return "Cuke"		-- Cucumber
	elseif which == 12 then
		return "Potas"		-- Potato
	elseif which == 13 then
		return "Cabash"		-- Cabbage
	elseif which == 14 then
		return "Tomats"		-- Tomato
	elseif which == 15 then
		return "Onin"		-- Onion
	elseif which == 16 then
		return "Lutts"		-- Lettuce
	elseif which == 17 then
		return "Caulifor"		-- Cauliflower
	elseif which == 18 then
		return "Zukin"		-- Zuchini
	else
		return "(Seiyan Name Error)"
	end
end

-- Intended to be used to destroy permanant structures
-- in towns. Something that may happen from time to time. :)
function dball.devastate(y, x, dest_radius)
	--fire_ball(dam.DISINTIGRATION, 0, 1, dest_radius)
	local c_ptr = cave(y, x)
	local f_ptr = f_info[c_ptr.feat + 1]
	local y_mod, x_mod, what_to_make = 0, 0, 0
	local y_dis, x_dis = 0, 0
	local circ_dist = 0

	for i = -dest_radius, dest_radius do
		for j = -dest_radius, dest_radius do
			
			y_mod = y + i -- - dest_radius
			x_mod = x + j -- - dest_radius
			circ_dist = (abs(i) * 2) + abs(j)
			c_ptr = cave(y, x)
			f_ptr = f_info[c_ptr.feat + 1]

			what_to_make = rng(1,100)

			if circ_dist <= dest_radius then	-- This makes our circle
				-- What about trees?
				if f_ptr.flags[FLAG_WALL] then
					if what_to_make < 25 then	
						cave_set_feat(y_mod, x_mod, FEAT_ASH)
					elseif what_to_make < 50 then	
						cave_set_feat(y_mod, x_mod, FEAT_FLOOR)
					elseif what_to_make < 75 then	
						cave_set_feat(y_mod, x_mod, FEAT_RUBBLE)
					else
						cave_set_feat(y_mod, x_mod, FEAT_SOFT_WALL)
					end
				else
					if what_to_make < 20 then	
						cave_set_feat(y_mod, x_mod, FEAT_ASH)
					elseif what_to_make < 40 then	
						cave_set_feat(y_mod, x_mod, FEAT_RUBBLE)
					else
						cave_set_feat(y_mod, x_mod, FEAT_FLOOR)
					end
				end
			end
		end
	end
end

-- Workaround for the default RNG
-- There are places where I NEED this,
-- placements that are random per character,
-- and the startup music
-- MODULE MAKER CAUTION: This function cannot
-- generate a random number larger than 60,
-- and the larger the number being generated
-- the easier it will be to trick the function.
-- A clever player will be able to manipulate
-- the results of this function. Beware.
function dball.true_rand(most)
	local foo = date()
	-- foo = strsub(foo, strlen(foo - 1), strlen(foo))
	foo = strsub(foo, 16, 17)
	foo = tonumber(foo)
	if (not foo) then
		-- Just in case a different OS returns the
		-- seconds in a different position and we get
		-- something like ":0" which tonumber() turns
		-- into a null. If this line executes our RNG
		-- will be deterministic, but at least we
		-- we won't crash or generate LUA errors.
		foo = 1
	end

	foo = foo * (most -1)
	foo = foo / 60
	foo = foo + 1
--[[
	local sillyness = 0
	for i = 0, foo do
		if sillyness < most then
			sillyness = sillyness + 1
		else
			sillyness = 1
		end
	end
]]

	return foo
end

function dball.current_location()
	-- Is the 'does it exist' check really necessary here?
	if d_info[current_dungeon_idx + 1].name and d_info[current_dungeon_idx + 1].name ~= "Wilderness" then
		return d_info[current_dungeon_idx + 1].name
	else
		-- It's so much easier to do this...but really, we should figure out
		-- how to make a multi-dimensional array in LUA and automate this
		-- Or, for that matter, just pull the data from town_info
		if player.wilderness_y == 8 and player.wilderness_x == 4 then
			return "Earth 1"
		elseif player.wilderness_y == 8 and player.wilderness_x == 5 then
			return "Earth 2"
		elseif player.wilderness_y == 8 and player.wilderness_x == 6 then
			return "Earth 3"
		elseif player.wilderness_y == 7 and player.wilderness_x == 4 then
			return "Earth 4"
		elseif player.wilderness_y == 7 and player.wilderness_x == 5 then
			return "Earth 5"
		elseif player.wilderness_y == 7 and player.wilderness_x == 6 then
			return "Earth 6"
		elseif player.wilderness_y == 6 and player.wilderness_x == 4 then
			return "Earth 7"
		elseif player.wilderness_y == 6 and player.wilderness_x == 5 then
			return "Earth 8"
		elseif player.wilderness_y == 6 and player.wilderness_x == 6 then
			return "Earth 9"

		elseif player.wilderness_y == 2 and player.wilderness_x == 16 then
			return "Kaio"
		elseif player.wilderness_y == 16 and player.wilderness_x == 44 then
			return "Planet 79"
		elseif player.wilderness_y == 13 and player.wilderness_x == 14 then
			return "Namek NW"
		elseif player.wilderness_y == 14 and player.wilderness_x == 14 then
			return "Namek SW"
		elseif player.wilderness_y == 13 and player.wilderness_x == 15 then
			return "Namek NE"
		elseif player.wilderness_y == 14 and player.wilderness_x == 15 then
			return "Namek SW"
		elseif player.wilderness_y == 9 and player.wilderness_x == 26 then
			return "Plant"
		elseif player.wilderness_y == 5 and player.wilderness_x == 6 then
			return "Babidi"
		else
			return "Space"
		end
	end
end

-- Map Edge Handler
function dball.planet_edge(y, x)
	if dun_level == 0 and not player.wild_mode and dball.am_i_on_earth() then

		local mapchange = 0
		local ppy, ppx = player.wilderness_y, player.wilderness_x

		if player.py == 1 then
			ppy = ppy - 1
			player.py = cur_hgt - 2
			mapchange = 1
		elseif player.py == cur_hgt - 1 then
			ppy = ppy + 1
			player.py = 1
			mapchange = 1
		end
		if player.px == 1 then
			ppx = ppx - 1
			player.px = cur_wid - 2
			mapchange = 1
		elseif player.px == cur_wid - 1 then
			ppx = ppx + 1
			player.px = 1
			mapchange = 1
		end

		if mapchange == 1 then
			if ppy < 6 then
				ppy = 8
			elseif ppy > 8 then
				ppy = 6
			end
			if ppx < 4 then
				ppx = 6
				elseif ppx > 6 then
				ppx = 4
			end
			player.wilderness_y = ppy
			player.wilderness_x = ppx
			-- player.regen_town()
			player.leaving = true
			return true, true
		end

	elseif dun_level == 0 and not player.wild_mode and dball.am_i_on_namek() then

		local mapchange = 0
		local ppy, ppx = player.wilderness_y, player.wilderness_x

		if y == 0 then
			ppy = ppy - 1
			player.py = cur_hgt - 2
			mapchange = 1
		elseif y == cur_hgt - 1 then
			ppy = ppy + 1
			player.py = 1
			mapchange = 1
		end
		if x == 0 then
			ppx = ppx - 1
			player.px = cur_wid - 2
			mapchange = 1
		elseif x == cur_wid - 1 then
			ppx = ppx + 1
			player.px = 1
			mapchange = 1
		end

		if mapchange == 1 then
			if ppy < 13 then
				ppy = 14
			elseif ppy > 14 then
				ppy = 13
			end
			if ppx < 14 then
				ppx = 15
			elseif ppx > 15 then
				ppx = 14
			end
			player.wilderness_y = ppy
			player.wilderness_x = ppx
			player.regen_town()
			return true, false
		end
	end
end

-- Haha!!!
function dball.identify(obj)
	make_item_fully_identified(obj)
	player.notice = player.notice | PN_COMBINE | PN_REORDER
end

-- How many dragonballs were generated on this level?
function dball.dragon_radar()
	return dball_data.dragon_radar
end


-- Generic for the Dojo Destroyer quest
function dball.cqcq_check()
	if quest(QUEST_DOJO_DESTROYER).status == QUEST_STATUS_UNTAKEN then
		change_quest_status(QUEST_DOJO_DESTROYER, QUEST_STATUS_TAKEN)
	else
		-- Close the quest once the build is finalized
		-- (Player is either a student of, or has closed, all eight schools)
		local foo = 0
		if (enrollments[FLAG_KARATE] > 0) or (c_schools[FLAG_KARATE] == FLAG_SCHOOL_CLOSED) then foo = foo + 1 end
		if (enrollments[FLAG_KICKBOXING] > 0) or (c_schools[FLAG_KICKBOXING] == FLAG_SCHOOL_CLOSED) then foo = foo + 1 end
		if (enrollments[FLAG_KUNGFU] > 0) or (c_schools[FLAG_KUNGFU] == FLAG_SCHOOL_CLOSED) then foo = foo + 1 end
		if (enrollments[FLAG_FENCING] > 0) or (c_schools[FLAG_FENCING] == FLAG_SCHOOL_CLOSED) then foo = foo + 1 end
		if (enrollments[FLAG_SUMO] > 0) or (c_schools[FLAG_SUMO] == FLAG_SCHOOL_CLOSED) then foo = foo + 1 end
		if (enrollments[FLAG_JUDO] > 0) or (c_schools[FLAG_JUDO] == FLAG_SCHOOL_CLOSED) then foo = foo + 1 end
		if (enrollments[FLAG_BALLET] > 0) or (c_schools[FLAG_BALLET] == FLAG_SCHOOL_CLOSED) then foo = foo + 1 end
		if (enrollments[FLAG_NINJUTSU] > 0) or (c_schools[FLAG_NINJUTSU] == FLAG_SCHOOL_CLOSED) then foo = foo + 1 end
		if foo > 7 then
			dialogue.BUILD_FINALIZED()
		end
	end
end

function dball.joke_text(which)
	local first, second
	if which == 0 then
		first = "Why is getting a new business up and running not always a good thing?"
		second = "Because it might get running so fast that you can't catch it."
	elseif which == 1 then
		first = "Why should you never bet on games of rock-paper-scissors?"
		second = "Because, no matter how much you rock at the game, you may have to pay-per scissor."
	elseif which == 2 then
		first = "Why did the punk rocker cross the road?"
		second = "Because it was stapled to a chicken."
	elseif which == 3 then
		first = "implement"
		second = "implement"
	elseif which == 4 then
		first = "implement"
		second = "implement"
	else
		first = "Unknown joke"
		second = "Unknown answer"
	end
	return first, second
end

-- The North Kaio's hammer is always 100 pounds heavier than
-- the players weight allowance
function dball.kaio_hammer_weight()
	return 1000 + (player.stat(A_STR) * 100)
end

-- Set initial faction relations
function dball.init_factions()
	factions.set_friendliness(FACTION_ANIMAL, FACTION_GERO, -10)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_TURTLES, 100)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_DRAGON, 100)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_KAMI, 100)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_NAMEK, 10)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_ANIMAL, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_GERO, FACTION_ANIMAL, -75)
	factions.set_friendliness(FACTION_GERO, FACTION_PLAYER, 1)
	factions.set_friendliness(FACTION_GERO, FACTION_DEMON, 25)
	factions.set_friendliness(FACTION_GERO, FACTION_FOOT, 25)
	factions.set_friendliness(FACTION_GERO, FACTION_TURTLES, -25)
	factions.set_friendliness(FACTION_GERO, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_NAMEK, 100)
	factions.set_friendliness(FACTION_GERO, FACTION_GOOD, -100)
	factions.set_friendliness(FACTION_GERO, FACTION_BAD, 25)
	factions.set_friendliness(FACTION_GERO, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_RRA, 100)
	factions.set_friendliness(FACTION_GERO, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_GERO, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_PLAYER, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_FOOT, -10)
	factions.set_friendliness(FACTION_PLAYER, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_RRA, -10)
	factions.set_friendliness(FACTION_PLAYER, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_DUEL, -100)
	factions.set_friendliness(FACTION_PLAYER, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_HEAVEN, 100)
	factions.set_friendliness(FACTION_PLAYER, FACTION_HELL, 100)
	factions.set_friendliness(FACTION_PLAYER, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_DEMON, FACTION_ANIMAL, 10)
	factions.set_friendliness(FACTION_DEMON, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_DRAGON, 100)
	factions.set_friendliness(FACTION_DEMON, FACTION_KAMI, 100)
	factions.set_friendliness(FACTION_DEMON, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_DEMON, FACTION_HEAVEN, 100)
	factions.set_friendliness(FACTION_DEMON, FACTION_HELL, 100)
	factions.set_friendliness(FACTION_DEMON, FACTION_MOUSE, 100)
	factions.set_friendliness(FACTION_DEMON, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_FOOT, FACTION_ANIMAL, 10)
	factions.set_friendliness(FACTION_FOOT, FACTION_GERO, 25)
	factions.set_friendliness(FACTION_FOOT, FACTION_PLAYER, -100)
	factions.set_friendliness(FACTION_FOOT, FACTION_DEMON, 25)
	factions.set_friendliness(FACTION_FOOT, FACTION_TURTLES, -100)
	factions.set_friendliness(FACTION_FOOT, FACTION_DRAGON, 10)
	factions.set_friendliness(FACTION_FOOT, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_FOOT, FACTION_NAMEK, -10)
	factions.set_friendliness(FACTION_FOOT, FACTION_GOOD, -100)
	factions.set_friendliness(FACTION_FOOT, FACTION_BAD, 25)
	factions.set_friendliness(FACTION_FOOT, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_FOOT, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_FOOT, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_FOOT, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_FOOT, FACTION_CRANE, -10)
	factions.set_friendliness(FACTION_FOOT, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_FOOT, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_FOOT, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_FOOT, FACTION_LUNCH, -1)

	factions.set_friendliness(FACTION_TURTLES, FACTION_ANIMAL, 100)
	factions.set_friendliness(FACTION_TURTLES, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_FOOT, -100)
	factions.set_friendliness(FACTION_TURTLES, FACTION_DEMON, -10)
	factions.set_friendliness(FACTION_TURTLES, FACTION_DRAGON, 100)
	factions.set_friendliness(FACTION_TURTLES, FACTION_KAMI, 100)
	factions.set_friendliness(FACTION_TURTLES, FACTION_NAMEK, 100)
	factions.set_friendliness(FACTION_TURTLES, FACTION_GOOD, 100)
	factions.set_friendliness(FACTION_TURTLES, FACTION_BAD, -25)
	factions.set_friendliness(FACTION_TURTLES, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_RRA, -10)
	factions.set_friendliness(FACTION_TURTLES, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_TURTLES, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_DRAGON, FACTION_ANIMAL, 100)
	factions.set_friendliness(FACTION_DRAGON, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_KAMI, 100)
	factions.set_friendliness(FACTION_DRAGON, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_HEAVEN, 100)
	factions.set_friendliness(FACTION_DRAGON, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_DRAGON, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_KAMI, FACTION_ANIMAL, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_GERO, -1)
	factions.set_friendliness(FACTION_KAMI, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_KAMI, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_KAMI, FACTION_TURTLES, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_DEMON, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_DRAGON, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_NAMEK, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_GOOD, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_KAMI, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_KAMI, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_KAMI, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_KAMI, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_KAMI, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_KAMI, FACTION_HEAVEN, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_HELL, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_MOUSE, 100)
	factions.set_friendliness(FACTION_KAMI, FACTION_LUNCH, 100)

	factions.set_friendliness(FACTION_GOOD, FACTION_ANIMAL, 100)
	factions.set_friendliness(FACTION_GOOD, FACTION_GERO, -100)
	factions.set_friendliness(FACTION_GOOD, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_GOOD, FACTION_FOOT, -10)
	factions.set_friendliness(FACTION_GOOD, FACTION_TURTLES, 100)
	factions.set_friendliness(FACTION_GOOD, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_GOOD, FACTION_DRAGON, 100)
	factions.set_friendliness(FACTION_GOOD, FACTION_KAMI, 100)
	factions.set_friendliness(FACTION_GOOD, FACTION_NAMEK, 100)
	factions.set_friendliness(FACTION_GOOD, FACTION_BAD, -50)
	factions.set_friendliness(FACTION_GOOD, FACTION_PILAF, -10)
	factions.set_friendliness(FACTION_GOOD, FACTION_RRA, -10)
	factions.set_friendliness(FACTION_GOOD, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_GOOD, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_GOOD, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_GOOD, FACTION_HEAVEN, 100)
	factions.set_friendliness(FACTION_GOOD, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_GOOD, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_GOOD, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_BAD, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_BAD, FACTION_GERO, 100)
	factions.set_friendliness(FACTION_BAD, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_BAD, FACTION_FOOT, 10)
	factions.set_friendliness(FACTION_BAD, FACTION_TURTLES, -25)
	factions.set_friendliness(FACTION_BAD, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_BAD, FACTION_DRAGON, 10)
	factions.set_friendliness(FACTION_BAD, FACTION_KAMI, -10)
	factions.set_friendliness(FACTION_BAD, FACTION_NAMEK, -10)
	factions.set_friendliness(FACTION_BAD, FACTION_GOOD, -100)
	factions.set_friendliness(FACTION_BAD, FACTION_PILAF, 10)
	factions.set_friendliness(FACTION_BAD, FACTION_RRA, 10)
	factions.set_friendliness(FACTION_BAD, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_BAD, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_BAD, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_BAD, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_BAD, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_BAD, FACTION_MOUSE, -10)
	factions.set_friendliness(FACTION_BAD, FACTION_LUNCH, -10)

	factions.set_friendliness(FACTION_PILAF, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_GERO, -100)
	factions.set_friendliness(FACTION_PILAF, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_FOOT, 10)
	factions.set_friendliness(FACTION_PILAF, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_DRAGON, 10)
	factions.set_friendliness(FACTION_PILAF, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_GOOD, -100)
	factions.set_friendliness(FACTION_PILAF, FACTION_BAD, 10)
	factions.set_friendliness(FACTION_PILAF, FACTION_RRA, -100)
	factions.set_friendliness(FACTION_PILAF, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_RRA, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_RRA, FACTION_GERO, 100)
	factions.set_friendliness(FACTION_RRA, FACTION_PLAYER, -10)
	factions.set_friendliness(FACTION_RRA, FACTION_FOOT, 10)
	factions.set_friendliness(FACTION_RRA, FACTION_TURTLES, -25)
	factions.set_friendliness(FACTION_RRA, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_RRA, FACTION_DRAGON, 10)
	factions.set_friendliness(FACTION_RRA, FACTION_KAMI, -10)
	factions.set_friendliness(FACTION_RRA, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_RRA, FACTION_GOOD, -100)
	factions.set_friendliness(FACTION_RRA, FACTION_BAD, 10)
	factions.set_friendliness(FACTION_RRA, FACTION_PILAF, -100)
	factions.set_friendliness(FACTION_RRA, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_RRA, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_RRA, FACTION_CRANE, -10)
	factions.set_friendliness(FACTION_RRA, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_RRA, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_RRA, FACTION_MOUSE, -10)
	factions.set_friendliness(FACTION_RRA, FACTION_LUNCH, -10)

	factions.set_friendliness(FACTION_NEUTRAL, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_DUEL, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_PLAYER, -100)
	factions.set_friendliness(FACTION_DUEL, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_DUEL, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_CRANE, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_RRA, -10)
	factions.set_friendliness(FACTION_CRANE, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_CRANE, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_HEAVEN, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_RRA, -10)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_MOUSE, 10)
	factions.set_friendliness(FACTION_HEAVEN, FACTION_LUNCH, 10)

	factions.set_friendliness(FACTION_HELL, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_RRA, -10)
	factions.set_friendliness(FACTION_HELL, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_MOUSE, 0)
	factions.set_friendliness(FACTION_HELL, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_NAMEK, FACTION_ANIMAL, 50)
	factions.set_friendliness(FACTION_NAMEK, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_DRAGON, 100)
	factions.set_friendliness(FACTION_NAMEK, FACTION_KAMI, 100)
	factions.set_friendliness(FACTION_NAMEK, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_GOOD, 10)
	factions.set_friendliness(FACTION_NAMEK, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_NEUTRAL, 50)
	factions.set_friendliness(FACTION_NAMEK, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_NAMEK, FACTION_MOUSE, 10)
	factions.set_friendliness(FACTION_NAMEK, FACTION_LUNCH, 10)

	factions.set_friendliness(FACTION_MOUSE, FACTION_ANIMAL, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_GERO, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_FOOT, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_TURTLES, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_KAMI, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_GOOD, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_PILAF, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_RRA, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_NEUTRAL, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_DUEL, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_CRANE, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_HEAVEN, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_NAMEK, 0)
	factions.set_friendliness(FACTION_MOUSE, FACTION_LUNCH, 0)

	factions.set_friendliness(FACTION_LUNCH, FACTION_ANIMAL, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_GERO, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_LUNCH, FACTION_FOOT, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_TURTLES, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_DEMON, 0)
	factions.set_friendliness(FACTION_LUNCH, FACTION_DRAGON, 0)
	factions.set_friendliness(FACTION_LUNCH, FACTION_KAMI, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_HELL, 0)
	factions.set_friendliness(FACTION_LUNCH, FACTION_GOOD, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_BAD, 0)
	factions.set_friendliness(FACTION_LUNCH, FACTION_PILAF, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_RRA, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_NEUTRAL, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_DUEL, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_CRANE, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_HEAVEN, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_NAMEK, -1)
	factions.set_friendliness(FACTION_LUNCH, FACTION_MOUSE, -1)
end

function dball.data_clearing()
	-- Initialize factions
	dball.init_factions()

	-- Option settings
	game_options.chat_mode = true
	game_options.party_mode = true
	game_options.tameshiwari_mode = true
	game_options.inhibit_reload = false

	-- Clear out data specific to Dr Briefs
	drbriefs.clear_data()

	-- And Dr Gero -- Some old stuff in here, huh?
	drgero.quest_no = 0
	drgero.annoyed = 0
	drgero.capture = 0

	-- Post V090 for Dr Gero
	dball_data.gero_state = 0
	dball_data.gero_quests = 0
	dball_data.gero_current_quest = 0
	

	-- Time warning tracker: Only indicate once per day
	dball.time_warning = 0	-- See hook MOVE_POST_DEST

	-- Playtest Settings
	dball_data.playtest_build = 0
	dball_data.playtest_level = 0

	dball_data.winner_state = 0
	-- 1 = won by marriage
	-- 2 = won by exterminating all life on earth and retiring from the planetary auction proceeds
	-- 3 = won by defeating Freeza
	-- 4 = won by defeating Cell
	-- 5 = *WON* by Defeating Buu

	-- Only here temporarily! Implement Reincarnation!
	------------------------------
	------------------------------
	reincarnation.emma_counter = 0	-- Emma notices if you reincarnate
	reincarnation.emma_component = 0	-- Character has ever died via 'component consciousness'
	reincarnation.emma_freebie_ress = 0	-- Character has claimed the freebie ressurection from knowing Karin
							-- (No fooling Emma with re-used savefiles. He DID say 'once' you know.
							-- 0=never 1=usedonce 2=player TRIED to do it again (shame on player!)
	reincarnation.hell_dcd = 0		-- Tracker for the Goz/Mez Demon Comic Dialogue
	reincarnation.trunks_early = 0	-- Has the early android quest been tripped?
	------------------------------
	------------------------------

	-- Kaio joke tracking -- 0=unknown  1=pending 2=told
	jokes[0] = 0		-- Business running
	jokes[1] = 0		-- rocker pay-per scissors
	jokes[2] = 0
	jokes[3] = 0
	jokes[4] = 0
	dball_data.joke_total = 2 -- plus zero
	dball_data.joke_answer = rng(0, dball_data.joke_total)

	-- Wait...I thought LUA can't save strings. Does this work?
	dball_data.p_sex = "Male"
	dball_data.p_race = "Human"
	dball_data.p_class = "Wannabe"

	dball_data.total_classes = 0

	-- Enrollment: Schools
	enrollments[FLAG_KARATE] = 0
	enrollments[FLAG_KICKBOXING] = 0
	enrollments[FLAG_KUNGFU] = 0
	enrollments[FLAG_FENCING] = 0
	enrollments[FLAG_SUMO] = 0
	enrollments[FLAG_JUDO] = 0
	enrollments[FLAG_BALLET] = 0
	enrollments[FLAG_NINJUTSU] = 0

	enrollments[FLAG_MARKSMANSHIP] = 0

	-- Enrollment: Masters
	enrollments[FLAG_ENROLL_ABBOT] = 0
	enrollments[FLAG_ENROLL_ROSSHI] = 0
	enrollments[FLAG_ENROLL_CRANE_HERMIT] = 0
	enrollments[FLAG_ENROLL_NORTH_KAIO] = 0
	enrollments[FLAG_ENROLL_KARIN] = 0
	enrollments[FLAG_ENROLL_POPO] = 0
	enrollments[FLAG_ENROLL_KAMI] = 0
	enrollments[FLAG_ENROLL_VEGITA] = 0
	enrollments[FLAG_ENROLL_RADDITZ] = 0
	enrollments[FLAG_ENROLL_SPLINTER] = 0
	enrollments[FLAG_ENROLL_SHREDDER] = 0
	enrollments[FLAG_ENROLL_TRUNKS] = 0
	enrollments[FLAG_ENROLL_YAJIROBE] = 0
	enrollments[FLAG_ENROLL_URANAI_BABA] = 0
	enrollments[FLAG_ENROLL_MUSASHI] = 0
	enrollments[FLAG_ENROLL_BRIEFS_SOME] = 0
	enrollments[FLAG_ENROLL_BRIEFS_ALL] = 0

	-- Training level tracking
	-- This is used by the enrollment script to
	-- determine whether a school is eligible for
	-- the closed school skill-cap bonus
	trainer[FLAG_KARATE] = 0
	trainer[FLAG_KICKBOXING] = 0
	trainer[FLAG_KUNGFU] = 0
	trainer[FLAG_FENCING] = 0
	trainer[FLAG_SUMO] = 0
	trainer[FLAG_JUDO] = 0
	trainer[FLAG_BALLET] = 0
	trainer[FLAG_NINJUTSU] = 0

	trainer[FLAG_MARKSMANSHIP] = 0

	trainer[FLAG_ENROLL_ROSSHI] = 0
	trainer[FLAG_ENROLL_ABBOT] = 0
	trainer[FLAG_ENROLL_ROSSHI] = 0
	trainer[FLAG_ENROLL_CRANE_HERMIT] = 0
	trainer[FLAG_ENROLL_NORTH_KAIO] = 0
	trainer[FLAG_ENROLL_KARIN] = 0
	trainer[FLAG_ENROLL_POPO] = 0
	trainer[FLAG_ENROLL_KAMI] = 0
	trainer[FLAG_ENROLL_VEGITA] = 0
	trainer[FLAG_ENROLL_RADDITZ] = 0
	trainer[FLAG_ENROLL_SPLINTER] = 0
	trainer[FLAG_ENROLL_SHREDDER] = 0
	trainer[FLAG_ENROLL_TRUNKS] = 0
	trainer[FLAG_ENROLL_YAJIROBE] = 0
	trainer[FLAG_ENROLL_URANAI_BABA] = 0
	trainer[FLAG_ENROLL_MUSASHI] = 0
	trainer[FLAG_ENROLL_BRIEFS_SOME] = 0
	trainer[FLAG_ENROLL_BRIEFS_ALL] = 0

	-- Which schools have been closed?
	c_schools[FLAG_KARATE] = FLAG_SCHOOL_OPEN
	c_schools[FLAG_KICKBOXING] = FLAG_SCHOOL_OPEN
	c_schools[FLAG_KUNGFU] = FLAG_SCHOOL_OPEN
	c_schools[FLAG_FENCING] = FLAG_SCHOOL_OPEN
	c_schools[FLAG_SUMO] = FLAG_SCHOOL_OPEN
	c_schools[FLAG_JUDO] = FLAG_SCHOOL_OPEN
	c_schools[FLAG_BALLET] = FLAG_SCHOOL_OPEN
	c_schools[FLAG_NINJUTSU] = FLAG_SCHOOL_OPEN

	c_schools[FLAG_MARKSMANSHIP] = FLAG_SCHOOL_OPEN

	-- Note to the audience: These are not fixed caps,
	-- These values are added to whatever the standard
	-- school-based cap is at present
	skillcaps[SKILL_STRENGTH] = 0
	skillcaps[SKILL_INTELLIGENCE] = 0
	skillcaps[SKILL_WILLPOWER] = 0
	skillcaps[SKILL_DEXTERITY] = 0
	skillcaps[SKILL_CONSTITUTION] = 0
	skillcaps[SKILL_CHARISMA] = 0
	skillcaps[SKILL_SPEED] = 0
	skillcaps[SKILL_MARTIALARTS] = 0
	skillcaps[SKILL_HAND] = 0
	skillcaps[SKILL_DODGE] = 0
	skillcaps[SKILL_THROWING] = 0
	skillcaps[SKILL_STEALTH] = 0
	skillcaps[SKILL_WEAPONS] = 0
	skillcaps[SKILL_PARRYING] = 0
	skillcaps[SKILL_PAIRED] = 0
	skillcaps[SKILL_MARKSMANSHIP] = 0
	skillcaps[SKILL_CHI] = 0
	skillcaps[SKILL_CHI_OFFENSE] = 0
	skillcaps[SKILL_CHI_DEFENSE] = 0
	skillcaps[SKILL_CHI_REGENERATION] = 0
	skillcaps[SKILL_CHI_GUNG] = 0
	skillcaps[SKILL_TECHNOLOGY] = 0
	skillcaps[SKILL_CONSTRUCTION] = 0
	skillcaps[SKILL_DISASSEMBLY] = 0
	skillcaps[SKILL_PILOTING] = 0

	-- Skill gains from Chi Masters are cumulative,
	-- so we need to track each skill separately
	-- for each master
	chi_masters[FLAG_ENROLL_ROSSHI] = 
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_ABBOT] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_KARIN] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_SPLINTER] = 
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_SHREDDER] = 
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_CRANE_HERMIT] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_NORTH_KAIO] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_POPO] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_KAMI] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_TRUNKS] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_VEGITA] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}
	chi_masters[FLAG_ENROLL_RADDITZ] =
		{
			[SKILL_CHI] = 0,
			[SKILL_CHI_OFFENSE] = 0,
			[SKILL_CHI_DEFENSE] = 0
			[SKILL_CHI_REGENERATION] = 0
			[SKILL_CHI_GUNG] = 0
		}

	-- NOTE!!!
	-- reincarnation[] does NOT get cleared!
	-- NOTE!!!

	dball_data.learned_acupuncture = 0
	dball_data.defeated_karate = 0
	dball_data.defeated_kickboxing = 0
	dball_data.defeated_kungfu = 0
	dball_data.defeated_fencing = 0
	dball_data.defeated_sumo = 0
	dball_data.defeated_judo = 0
	dball_data.defeated_ballet = 0
	dball_data.defeated_ninjutsu = 0
	-- dball_data.defeated_taekwondo = 0

	-- Did we flee from a challenge quest?
	-- Most instructors won't take you as students if
	-- you've fought them and run. Also used to customize
	-- insults for the World Tournament
	dball_data.fled_karate = 0
	dball_data.fled_kickboxing = 0
	dball_data.fled_kungfu = 0
	dball_data.fled_fencing = 0
	dball_data.fled_sumo = 0		-- 1=exited via teleport 2=left the ring
	dball_data.fled_judo = 0
	dball_data.fled_ninjutsu = 0
	dball_data.fled_ballet = 0
	dball_data.fled_marksmanship = 0
	-- dball_data.fled_taekwondo = 0

	-- Hack
	dball_data.ever_challenged_judo = 0
	dball_data.ever_challenged_sumo = 0

	-- Have we showered before bathing?
	dball_data.showered = 0

	-- To put an end to this problem once and for all:
	dball_data.serpent_teleport = 0	-- 1=Emma 2=Kaio 3=Earth 0=ignore

	-- Members Only quests
	dball_data.member_gym = 0
	dball_data.workout = 0
	dball_data.member_library = 0
	dball_data.study = 0
	dball_data.hanger_start_date = 0
	dball_data.hanger_rental = 0

	-- Used to computate current real stat
	-- Values here are the *original* values
	-- to which all subsequent gains and bonuses
	-- are added. I'm sure the engine does this
	-- for me, but it seemed a lot easier to just
	-- do it myself than dig through the engine
	-- scripts and figure out what to call
	-- and how to use it.
	-- NOTE: I don't think this is used anymore
	dball_data.strength = 0
	dball_data.intelligence = 0
	dball_data.willpower = 0
	dball_data.dexterity = 0
	dball_data.constitution = 0
	dball_data.charisma = 0
	dball_data.speed = 0

	-- The collective stat mods from death, android enhancements, etc.
	dball_data.mod_strength = 0
	dball_data.mod_intelligence = 0
	dball_data.mod_willpower = 0
	dball_data.mod_dexterity = 0
	dball_data.mod_constitution = 0
	dball_data.mod_charisma = 0
	dball_data.mod_speed = 0

	-- Misc World Tournament data
	dball_data.tourny_current_opponent = 0		-- Who is our next opponent? (0=not allocated)
	dball_data.tourny_type_of_fight = 0			-- 0=standard 1=to the DEATH
	dball_data.tourny_registered = 0			-- 0 = no, 1 = yes, 2 = LOST by defeat, 3 = LOST by exiting ring 4 = Disqualified equip use 5=won
	dball_data.tourny_round = 0
	dball_data.tourny_now = 0				-- Are we in a tourny round NOW?
	dball_data.tourny_flier = 0				-- Opponent can fly message

	-- What's your Seiyan name?
	dball_data.seiyan_name = 0

	-- Misc dialogue states for the Namekian Elders
	dball_data.namek_elder1 = 0
	dball_data.namek_elder2 = 0
	dball_data.namek_elder3 = 0
	dball_data.namek_elder4 = 0
	dball_data.namek_elder5 = 0
	dball_data.namek_elder6 = 0
	dball_data.namek_elder7 = 0
	dball_data.namek_know_db = 0		-- Does the player know about the Dragonballs on Namek?
	dball_data.namek_know_aj = 0		-- Does the player know about the Ajisa plant?
	dball_data.namek_know_gr = 0		-- Does the player know about the Great Elder?
	dball_data.namek_know_fr = 0		-- Does the player know about Freeza on Namek?
	dball_data.namek_know_bio = 0		-- Does the player know about Namekian reproductive biology?
	dball_data.namek_guru_powers = 0	-- Has Guru brought out the players 'latent powers?'
	dball_data.namek_general_state = 0	-- For random Nameks: See dialogue
	dball_data.namek_total_killed = 0	-- Only 100 Nameks left alive.
	dball_data.namek_ajasa_state = -1	-- General state tracker
	dball_data.namek_ajasa_total = 0	-- Total number of seeds succesfully grown
	dball_data.namek_ajasa_y = -1		-- y coord of planting location (Implement Namek as a SAVE_LEVEL)
	dball_data.namek_ajasa_x = -1		-- x coord of planting location
	dball_data.namek_ajasa_deliver = 0	-- Number of plants delivered for second quest
	dball_data.namek_seeds_deliver = 0	-- Number of seeds delivered for third quest
	dball_data.namek_lev_check = 0	-- 0=start 1=questissued 2=killed 3=complete Haha! Poor player!
	dball_data.namek_gravity_q = 0	-- 0=start 1=available 2=asked
	dball_data.namek_who_promoted = 0	-- RACE_ of which Namek was promoted to Village Elder
	

	-- Namek quests: which villages have been checked/visited/retreived/etc.
	namek_pollinate[1] = 0
	namek_pollinate[2] = 0
	namek_pollinate[3] = 0
	namek_pollinate[4] = 0
	namek_pollinate[5] = 0
	namek_pollinate[6] = 0
	namek_pollinate[7] = 0
	namek_seeds[1] = 0
	namek_seeds[2] = 0
	namek_seeds[3] = 0
	namek_seeds[4] = 0
	namek_seeds[5] = 0
	namek_seeds[6] = 0
	namek_seeds[7] = 0


	-- Has the player recovered Dorothy's Slippers?
	dball_data.ruby_slippers = 0

	-- Poor way to do it, but it works:
	dball_data.p_xpmod = 0

	-- Easy dragonball tracking
	-- set in default monster drop, cleared in dbtstuff level feelings
	dball_data.dragon_radar = 0

	-- Using a global for the monster counter function
	-- It's easier. Deal with it.
	dball_data.monster_counter = 0

	-- Migrate data for Dr Briefs to dball_data?
	dball_data.briefs_state = 0	-- 0=no contact 1=contact, quest handler 2=angry 3=politedone
						-- 4=enrollmentscript 5=retreivequestrunning
	dball_data.briefs_assemble_quest_counter = 0	-- How many retreive quests have we performed?

	-- What is Piccolo's state?
	dball_data.piccolo_state = 0	-- 0=none 1=DKP released 
						-- (...DKP --> Piccolo, Piccolo Dead, Kami dead, Both dead, etc...)
	dball_data.piccolo_hurt_player = 0	-- Was the player fighting Piccolo when he died?

	-- Kami and Mr Popo states?
	dball_data.kami_state = 0
	dball_data.kami_rescued_player = 0	-- Has Kami rescued the player from Piccolo?
	dball_data.popo_state = 0
	dball_data.popo_fight_now = 0		-- Dialogue helper for 'live' fight
	dball_data.popo_injured = 0		-- Mr. Popo ignores duelers until he's been injured

	-- North Kaio state?
	dball_data.kaio_state = 0

	------------------------
	-- Time Travel Quests --
	------------------------
	dball_data.ttq_tripped = 0		-- What tripped the Android timer?
							-- 0=not tripped, 1=normalprogression 2=EvildialogueBriefs 3=foreknowledgeofquest
	dball_data.ttq_day_tripped = 0	-- dball.dayofyear() day that the countdown was tripped

	dball_data.ttq_forewarning = 0	-- FEAT dialogue, Briefs Lab, only show once
	dball_data.ttq_trigger = 0		-- FEAT dialogue, Briefs Lab, only show once

	-- Quest tracking for the Android Quest
	dball_data.android_quest_status = 0		-- 0=none 1=They Can Appear 2=They've been seen

	dball_data.trunks_hunt = 0			-- Is Trunks hunting the player?

	-----------------------
	-----------------------
	-----------------------

	-- Babidi's Spacecraft Quest status
	dball_data.spacecraft_quest_status = 0	-- See quest description

	-- Dr Gero level feeling, only once
	dball_data.gero_entrance = 0

	-- For World Tournament oponent selection
	dball_data.have_we_met_radditz = 0

	-- Muscle Stimulator
	dball_data.muscle_stimulator = 0

	-- How many times have we consumed radioactive waste?
	dball_data.mutant = 0

	-- Pulling ALL to hit and damage from player. and doing it myself
	dball_data.lhand_th = 0
	dball_data.lhand_td = 0
	dball_data.lhand_dis_th = 0
	dball_data.lhand_dis_td = 0
	dball_data.lhand_valid = 0
	dball_data.rhand_th = 0
	dball_data.rhand_td = 0
	dball_data.rhand_dis_th = 0
	dball_data.rhand_dis_td = 0
	dball_data.rhand_valid = 0

	-- This is for the Criminal Quest
	dball_data.police_killed = 0

	-- Number of dragonballs stolen by the Bear Thief
	-- You don't get them back, but it does change the quest display
	dball_data.bear_thief_dbs = 0
	-- Number of dragonballs stolen by the Hasuki, the thief
	-- You don't get them back, but it does change the quest display
	dball_data.hasuki_dbs = 0

	-- Total number of times Shenron has been summoned
	dball_data.summoned_shenron = 0

	-- This is to check our multi-target firing MODE
	-- (Because it's kind of annoying, and we wouldn't
	-- want it to check when we're not using it.
	dball_data.multi_target_mode = 0 -- off

	-- The Good/Evil counter. Not using a *counter* 
	-- because I don't see any reason to
	dball_data.alignment = 0 -- Neutral
	dball_data.ever_been_evil = 0	-- Has the player EVER done anything evil?

	-- And, what is the characters death state?
	-- 0 = alive
	-- 1 = dead, undetermined
	-- 2 = purgatory
	-- 3 = demon
	-- 4 = angel		-- These don't seem to match reality...
	dball_data.alive = 0

	-- Do we need a death dialogue?
	dball_data.death_dialogue = 0 -- (Takes flags)

	-- How many total times have we died?
	dball_data.times_died = 0

	-- How much of a caffiene resistance has the player built up?
	dball_data.caffiene = 0

	-- Special wish conditions
	dball_data.immune_to_chocolate = 0		-- Polymorph immunity
	dball_data.immortality = 0			-- Immortality
	dball_data.win_world_tournament = 0		-- Win the World Tournament
	dball_data.wishhouse_earth = 0
	dball_data.wishhouse_namek = 0
	dball_data.wish_autoid = 0
	

	-- Death states certain quest uniques
	-- Gradually being phased out in favor of max_num checking
	-- Though in some cases 'has ever been killed' needs to be
	-- distinguished from 'is currently dead'
	dball_data.ginkako = 0
	dball_data.kinkaku = 0
	dball_data.bossrabbit = 0
	dball_data.oolong = 0
	dball_data.mai = 0
	dball_data.shuu = 0

	-- Random locations
	dball_data.random_mouse = 0		-- Location of King Mouse -- Not used
	dball_data.mouse_onlyonce = 0		-- Do/have we placed mice?

	-- Did we go up or down stairs in the last level change?
	dball_data.level_tracker = -1 -- -1 = down 1 = up

	-- Hack: To manually place the character after existing a store-teleport-dungeon
	dball_data.teleport_dungeon = 0

	-- Which planets have we visited (Thus accessible via planetary teleport)
	-- (Earth always an option)
	dball_data.planet_kaio = 0
	dball_data.planet_plant = 0
	dball_data.planet_79 = 0
	dball_data.planet_namek = 0
	dball_data.planet_babidi = 0

	-- Dialogue States
	-- ********************************************
	-- ********************************************
	-- Total number of times a player has succesfully used the (Persuade) option
	-- Just a cute little tracker for the file dumps
	dball_data.persuades = 0

	-- Krillan and Orinji Temple
	dball_data.krillan_state = 0
	dball_data.krillan_ever_partied = 0
	dball_data.abbot_state = 0
	dball_data.monk_two_state = 0
	dball_data.ofuda = 0
	dball_data.temple_key = 0
	dball_data.temple_alarm = 0
	dball_data.only_once_porno = 0

	-- Yamcha
	dball_data.yamcha_state = 0	-- See ai.YAMCHA for details
	dball_data.yamcha_robbed = 0
	dball_data.yamcha_girl_counter = 0 -- How many times has the player chased down Yamcha?

	-- Splinter/Turtles/Shredder and related dialogues
	dball_data.splinter_state = 0		-- 0 = nocontact 1=contact 2=allowtraining 999=aggressive(sort of)
	dball_data.splinter_story = 0		-- 0 or 1: has splinter given his tale?
	dball_data.foot_clan_rapport = 0	-- No formal contact 1= Greeter intro 2=Shredderspoke 3=aggressive 4=formaltruce
	dball_data.foot_watched_helper = 0	-- Quest desc
	dball_data.ninja_quest_tracker = 0
	dball_data.shredder_state = 0		
	dball_data.ballet_vent_state = 0	-- Steam vent dialogue tracker

	-- Musashi
	dball_data.musashi_state = 0

	-- Buruma
	dball_data.buruma_state = 0
	dball_data.buruma_ever_carried = 0	-- Has Buruma been asked to carry anything yet?
	dball_data.seduce_buruma = 0	-- It takes Buruma time to warm up to people
			-- What makes Buruma like you?
			--  +1 Knowing about tachyons during her early dialogue
			--  +1 Having ever completed the LITTER_BOX quest
			--  +1 Tama's litter box being clean RIGHT NOW (whenever that may be)
			--  +4 Giving her a dragonball
			--  +1 Being her fathers assistant
			--  +1 Being on friendly terms with her father
			-- What makes Buruma dislike you?
			--  -1 Every time you tell her she's rude
			--  -1 Every time you summon her via her cellphone

	-- How clean is Tama's litterbox?
	dball_data.tama_litterbox = 4

	-- Lunch
	dball_data.lunch_state = 0	-- 999 = married
	dball_data.lunch_sneeze = 0	-- 0=nice 1=nasty
	dball_data.lunch_faction = 0	-- Holds faction setting for swp in case player decides to attack

	-- Mr. Satan
	dball_data.satan_state = 0		-- 0=nocontact 1=politedone 2=aggressive 3=Pending WT Challeneg for Videl
	dball_data.satan_comic_state = 0	-- 0=none 1=comicpunch 2=realABlearned 3=steelgirder 4=rarereward
	dball_data.leaving_satan_estate = 0 -- 0=default 1=HACK: We're going south, so always allow exit from Satan estate
	dball_data.satan_flaked = 0		-- 0=default 1=Mr. Satan flaked on the World Tournament
	dball_data.satan_defeated = 0		-- 0=default 1=Mr Satan was DEFEATED by the lpayer in the World Tournament
	dball_data.satan_trophies = 0		-- 0-1-2 place trophies on levels

	-- Miss Piiza
	dball_data.piiza_state = 0
	dball_data.sushi_quest_awkward = 0	-- Tried to deliver sushi, but didn't have it

	-- Videl
	dball_data.videl_state = 0		-- 0=nocontact 1=friendly 2=unfriendly
	dball_data.videl_never_marry = 0	-- If the player chooses a dialogue path forbiding marriage to Videl

	-- Yawara
	dball_data.yawara_wt = 0 		-- 0=default 1=Yawara may NOT participate in the Tournament

	-- OxKing
	dball_data.oxking_drawbridge = 0	-- 0=nevertouched 1=lowered 2=has been lowered, but is currently raised

	-- Chichi
	dball_data.chichi_state = 0		-- 0=nocontact 1=pervert 2=angry 3=dead

	-- Toxic Widget Manufacturing Plant
	dball_data.toxic_state = 0
	dball_data.toxic_quest_desc = 0	-- Which description to show

	-- Data relevant to the stolen goods quest: George/Lazarus/Akira/Ninja/etc
	-- Each of these keep track of which clues we've assembled: 0=no 1=yes 2=reported to George
	-- The quest reward increases the higher your point total in each of these four
	dball_data.goods_lazarus = 0
	dball_data.goods_akira = 0
	dball_data.goods_warehouse = 0
	dball_data.goods_splinter = 0
	--
	dball_data.goods_total_reward = 0 -- Keeps track of the part 2 reward value
	dball_data.goods_store_closed = 0 -- Did you turn down part 2, thus closing the store?
	--
	dball_data.has_visited_warehouse = 0	-- To keep from duplicating the fixed goods
	dball_data.has_visited_briefs = 0 		-- Same

	-- Hell stuff
	dball_data.demon_comic_dialogue = 0
	dball_data.gozmez_done_dcd = 0
	dball_data.steps_in_hell = 0
	dball_data.hell_has_visited = 0			-- No duplicated skeletons, and DCD only once
	dball_data.hell_escalator_state = 0			-- Is the escalator operational

	-- Ninja Quests
	dball_data.foot_assassin = 0			-- Has an assassin ever appeared? (For quest text)
	dball_data.has_visited_sanctum = 0		-- To keep from duplicating the supply cache

	-- Some misc variables to keep track of the Pilaf dialogue state
	dball_data.pilaf_dungeon = 0
	dball_data.pilaf_interupted = 0
	dball_data.pilaf_polite_done = 0
	dball_data.pilaf_dungeon_for_ms = 0
	dball_data.pilaf_execute = 0
	dball_data.pilaf_dragonballs = 0		-- Number of dragonballs KNOWN to be in Pilaf's possession

	-- State of Akira, the Sushi Chef
	dball_data.akira_state = 0 -- 0=default/questhandler 1=polite_done 2=annoyed 3=storeclosed

	-- Oolong
	dball_data.oolong_sad_done = 0 -- 0=default 1=sad 2=annoyed 3=hostile
	dball_data.oolong_akira = 0		-- none 1=referred 2=spoken with akira
	dball_data.oolong_resolution = 0
	-- 0=none 1=peaceful, oolong evil 2=notyet, women golddiggers 3=oolong married NPC 4=oolong married player 5=oolongdead
	dball_data.oolong_quest_helper = 0 --grandfather clause for quest_desc: see the quest definition
	dball_data.oolong_married = 0
	dball_data.oolong_lunch_only_once = 0	-- Lunch is such a nice girl, isn't she?

	-- Marriage
	-- To whom is the character married, if anyone?
	dball_data.married = 0
	-- Using flags to identify

	-- Rosshi
	dball_data.rosshi_state = 0		-- State. See dialogue.ROSSHI()
	dball_data.rosshi_seduction = 0	-- Tracker for the marriage option
	dball_data.rosshi_girl = 0		-- Who was retrieved for Rosshi? Takes RACE_
	dball_data.rosshi_turtle_shells = 0 -- Number of Turtle Shells Rosshi has given the player (Generally: 0 to 2)

	-- Used by both of these two:
	dball_data.rosshi_uranai_apology = 0
	-- Used by both of these two:

	-- Uranai Baba
	dball_data.uranai_state = 0

	-- Tsuru Seni'nin
	dball_data.crane_state = 0		-- General state tracker
	dball_data.wolf_escort = 0		-- Has the White Wolf's escort appeared?

	-- General Blue's Underwater Lair 
	dball_data.rra_hq_state = 0		-- 0=not tripped 1=tripped
	dball_data.rra_pacifist = 0		-- 0=not tripped 1=tripped
	dball_data.rra_android8 = 0		-- 0=not tripped 1=bluedead 2=dialoguetripped
	dball_data.rra_blue_submerge = 0	-- 0=No 1=Yes
	dball_data.rra_blue	= 0		-- General Blue state tracker
	dball_data.rra_blue_bd	= 0		-- Is General Blue's Blast Door in place 0=no 1=yes (also used for dungeon dead check)
	dball_data.rra_blue_sec = 0		-- General Blue's Security system

	-- Is this used?
	dball_data.rra_mta = 0		-- Have Muscle Tower Automatons been disabled?

	-- rra cameras: don't want the alarm message to constantly go off
	dball_data.rra_alarm_msg = 0

	--
	dball_data.rra_mt_patrol_alarm = 0	-- Has the patrol sounded the alarm?

	-- RRA SHQ
	dball_data.rra_shq_int = 0	-- Have Supreme HQ Internal Autoturrets been disabled?
	dball_data.rra_shq_ext = 0	-- Have Supreme HQ External Missile Turrets been disabled?
	dball_data.rra_shq_cam = 0	-- Have Supreme HQ Cameras been disabled?
	-- No ikey
	-- dball_data.rra_shq_ikey = 0	-- Has the Internal Turret control room key been recovered?
	dball_data.rra_shq_ekey = 0	-- Has the External Turret control room key been recovered?
	dball_data.rra_shq_ckey = 0	-- Has the Camera control room key been recovered?

	dball_data.rra_gong_cam = 0	-- Only play ominous gong once per special level
	dball_data.rra_gong_int = 0
	dball_data.rra_gong_ext = 0
	dball_data.rra_gong_shq = 0


	dball_data.vault_gen = 0	-- Only once: Vault gen

	-- Gah!
	dball_data.shq_loc1 = 1	-- Set these to zero once destroyed
	dball_data.shq_loc2 = 2 -- (If we no longer want them placed?)
	dball_data.shq_loc3 = 3 -- (Why would we want that?)
	dball_data.shq_loc4 = 4

	for mixi = 1, 7 do
		local sillyness = dball.true_rand(4)
		if sillyness == 1 then
			dball_data.shq_loc1, dball_data.shq_loc2 = dball_data.shq_loc2, dball_data.shq_loc1
		elseif sillyness == 2 then
			dball_data.shq_loc1, dball_data.shq_loc3 = dball_data.shq_loc3, dball_data.shq_loc1
		elseif sillyness == 3 then
			dball_data.shq_loc1, dball_data.shq_loc4 = dball_data.shq_loc4, dball_data.shq_loc1
		elseif sillyness == 4 then
			dball_data.shq_loc2, dball_data.shq_loc3 = dball_data.shq_loc3, dball_data.shq_loc2
		elseif sillyness == 5 then
			dball_data.shq_loc2, dball_data.shq_loc4 = dball_data.shq_loc4, dball_data.shq_loc2
		else
			dball_data.shq_loc3, dball_data.shq_loc4 = dball_data.shq_loc4, dball_data.shq_loc3
		end
	end

	if dball_data.shq_loc1 + dball_data.shq_loc2 + dball_data.shq_loc3 + dball_data.shq_loc4 ~= 10 then
		message(color.VIOLET, "DBT: SHQ ALLOCATION ERROR! Attempting to recover...")
		error("DBT: SHQ checksum is: " .. dball_data.shq_loc1 .. "-" .. dball_data.shq_loc2 .. "-" .. dball_data.shq_loc3 .. "-" .. dball_data.shq_loc4)
		dball_data.shq_loc1 = 1
		dball_data.shq_loc2 = 2
		dball_data.shq_loc3 = 3
		dball_data.shq_loc4 = 4
	end

	-- Karin dialogue states
	dball_data.karin_state = 0	-- 
	dball_data.karin_fight = 0	-- 1=challenged
	dball_data.karin_first_visit = 0 -- Character level at time of first visit. Used to award senzu beans
	dball_data.karin_senzu = 0	-- Total number of senzu beans awarded
	dball_data.karin_kami = 0	-- Has Karin mentioned Kami in dialogue? (Set by Karin, checked by Kami)
	dball_data.karin_kaio_chess = 0 -- Has Karin mentioned that the North Kaio plays chess?
	dball_data.karin_daio = 0	-- Has Karin mentioned Emma Daio?
	dball_data.karin_hole = 0	-- Hole dialogue state: 0=no mention 1=spoke to Karin 2=spoke to Rosshi	3=Ineligible, Nyoibo found
	dball_data.karin_kinto = 0	-- Has Karin given Kinto Un to the player yet?
	dball_data.kinto_howto = 0	-- Only once per game describe how to summon Kinto Un

	dball_data.emma_state = 0		-- General dialogue state
	dball_data.emma_reincarnate = 0	-- Has the reincarnation counter ever been incremented by this character?
	dball_data.emma_mentioned_kaio = 0  -- Has Emma mentinoed the Nroth Kaio?

	dball_data.recursive_death = 0	-- Used to allow 'actual' deaths that result from 'possible' deaths
							-- while executing dialogue within the death hook.
							-- 0=not active
							-- 1=Emma recycling 2=remote stop device

	dball_data.fugu = false			-- Has eaten fugu. This is bad.

	dball_data.special_abilities = 0 -- 0=none 1=has

	-- Chi: Constant Effect Counters
	dball_data.cur_chi_pool = 0
	dball_data.max_chi_pool = 0
	dball_data.chi_drain_rate = 0
	dball_data.chi_aura_setting = 0
	dball_data.chi_haste_setting = 0
	dball_data.chi_flight_setting = 0
	dball_data.chi_regeneration_setting = 0
	dball_data.chi_absorbtion_setting = 0
	dball_data.chi_light_setting = 0

	-- "Flying High"
	dball_data.flying_high = 0

	-- Sanity
	dball_data.cur_sanity = 0
	dball_data.max_sanity = 0
	dball_data.android_sanity = 0

	-- Chi Instant Effect trackers
	dball_data.chi_heal_default = 1
	dball_data.chi_burst_default = 1

	-- ********************************************
	-- ********************************************
	-- Dragonball Drop System: Which Dragonballs
	-- are CURRENTLY in existence?
	earth_dragonballs[1] = 0
	earth_dragonballs[2] = 0
	earth_dragonballs[3] = 0
	earth_dragonballs[4] = 0
	earth_dragonballs[5] = 0
	earth_dragonballs[6] = 0
	earth_dragonballs[7] = 0
	namek_dragonballs[1] = 0
	namek_dragonballs[2] = 0
	namek_dragonballs[3] = 0
	namek_dragonballs[4] = 0
	namek_dragonballs[5] = 0
	namek_dragonballs[6] = 0
	namek_dragonballs[7] = 0

	-- Totally reset:
	tourny_uniques = {}

	-- Cellphone?

--[[
	-- Playtesting game modes
	local game_mode = player.get_mode()
	if game_mode == "PlayTestEarly" then
		player.au = player.au + 2000
		player.lev = 10
		player.exp = 350
		-- player.m_exp = 350
	elseif game_mode == "PlayTestEarly" then
		player.au = player.au + 10000
		player.lev = 30
		player.exp = 45000
		-- player.m_exp = 45000
	elseif game_mode == "PlayTestEarly" then
		player.au = player.au + 1000000
		player.lev = 50
		player.exp = 2400000
		-- player.m_exp = 2400000
	end
]]


end -- dball.data_clearing()

--*******************************************************************
--*******************************************************************
--************************* HOOKS ***********************************
--*******************************************************************
--*******************************************************************

-- Workaround for FS#108
-- With thanks to EtMarc
hook(hook.NEW_LEVEL, function(dun_level)
	for r_idx = 1, max_r_idx do
		r_info[r_idx].cur_num = 0
	end
end)

-- Front-loaded skill points
hook(hook.INIT_DONE, function()
	player.skill_points = 5
end)

-- Want it sooner than this
--[[
hook(hook.INIT, function()
	if rng(1,2) == 1 then
		sound.play_sample("intro1")
	else
		sound.play_sample("intro2")
	end
end)
]]

-----------------
-- Spirit Hooks--
-----------------
hook(hook.GET_PRE, function(obj, item)
	if dball_data.alive ~= 0 and not is_artifact(obj) then
		message("Your ghostly hands pass right through it.")
		return true
	end
end)
hook(hook.WIELD_PRE, function(obj, item)
	if dball_data.alive ~= 0 and not is_artifact(obj) then
		message("Your ghostly hands pass right through it.")
		return true
	end
end)
hook(hook.KEYPRESS, function(key)
	if key == strbyte('q') then
		if dball_data.alive ~= 0 then
			message("You're dead. You can't drink.")
			return true
		end
	end
end)

---------------------
-- End Spirit Hooks--
---------------------
--[[
hook(hook.KEYPRESS, function(key)
	if key == strbyte('z') then
		local to_show = player.calc_bonuses(true)
		term.save()
		show_arr_as_list(to_show, "Player calculations", true)
		term.load()
		return true
	end
end)
]]

-- Kinto Un
hook(hook.KEYPRESS, function(key)
	if key == strbyte('K') then
		if dball_data.karin_kinto == 0 then
			message("You call out...but nothing happens.")
		elseif dball_data.karin_kinto == 1 then
			if dball.am_i_on_earth() then
				if dun_level == 0 then
					monster_random_say{
					"#GKinto Un responds to your call!",
					"#GKinto Un swoops up to you!",
					"#GKinto Un comes!",}
					local obj = create_artifact(ART_KINTO_UN)
					make_item_fully_identified(obj)
					drop_near(obj, -1, player.py, player.px)
					sound.play_sample("kintocall")
				else
					message("You call out, but Kinto Un does not appear.")
				end
			else
				message("You call out, but seriously doubt Kinto Un will hear you from here.")
			end
		elseif dball_data.karin_kinto == 2 then
			if dball.am_i_on_earth() then
				if dun_level == 0 then
					monster_random_say{
					"#YEvil Kinto Un responds to your call!",
					"#YEvil Kinto Un swoops up to you!",
					"#YEvil Kinto Un comes!",}
					local obj = create_artifact(ART_EVIL_KINTO_UN)
					make_item_fully_identified(obj)
					drop_near(obj, -1, player.py, player.px)
				else
					message("You call out, but Kinto Un does not appear.")
				end
			else
				message("You call out, but seriously doubt Kinto Un will hear you from here.")
			end
		end

		return true
	end
end)


-- Lite
hook(hook.CALC_LITE,function()

		player.cur_lite = player.cur_lite + dball_data.chi_light_setting

		if dball_data.alive ~= 0 then
			player.cur_lite = player.cur_lite + 2
		end

		if dball_data.chi_aura_setting == 1 then
			-- Remember the stored value is * 100
			if dball_data.cur_chi_pool > 99900 then
				player.cur_lite = player.cur_lite + 1
			end
			if dball_data.cur_chi_pool > 49900 then
				player.cur_lite = player.cur_lite + 1
			end
			if dball_data.cur_chi_pool > 19900 then
				player.cur_lite = player.cur_lite + 1
			end
			if dball_data.cur_chi_pool > 9900 then
				player.cur_lite = player.cur_lite + 1
			end
			player.cur_lite = player.cur_lite + 1
		end
end)



-- Movement issues: Map wrap and spaceships
hook
{
	[hook.MOVE_PRE] = function(y, x, dir, do_pickup, run, disarm)
		-- message("y: " .. y .. " x: " .. x)

		-- Capsule flyers
		if dball.player_in_flight_craft() == true then
			if dball_data.flying_high == 0 then
				message("You're still on the ground. Press < to launch.")
				return true, false
			end
		end

		-- Can't walk around in a spaceship
		if player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_VEHICLE_SPACESHIP] and not player.wild_mode then
			if not cave(y, x).feat == FEAT_DEEP_SPACE then
				message("Spaceships don't taxi very well. Press < to launch.")
				return true, false
			end
		end

		-- World Map Wrap check
		-- dball.planet_edge(y, x)
-- ***
		if dun_level == 0 and not player.wild_mode and dball.am_i_on_earth() then

			local mapchange = 0
			local ppy, ppx = player.wilderness_y, player.wilderness_x

			if y == 0 then
				ppy = ppy - 1
				player.py = cur_hgt - 2
				mapchange = 1
			elseif y == cur_hgt - 1 then
				ppy = ppy + 1
				player.py = 1
				mapchange = 1
			end
			if x == 0 then
				ppx = ppx - 1
				player.px = cur_wid - 2
				mapchange = 1
			elseif x == cur_wid - 1 then
				ppx = ppx + 1
				player.px = 1
				mapchange = 1
			end

			if mapchange == 1 then
				if ppy < 6 then
					ppy = 8
				elseif ppy > 8 then
					ppy = 6
				end
				if ppx < 4 then
					ppx = 6
				elseif ppx > 6 then
					ppx = 4
				end
				player.wilderness_y = ppy
				player.wilderness_x = ppx
				player.regen_town()
				return true, false
			end

		elseif dun_level == 0 and not player.wild_mode and dball.am_i_on_namek() then

			local mapchange = 0
			local ppy, ppx = player.wilderness_y, player.wilderness_x

			if y == 0 then
				ppy = ppy - 1
				player.py = cur_hgt - 2
				mapchange = 1
			elseif y == cur_hgt - 1 then
				ppy = ppy + 1
				player.py = 1
				mapchange = 1
			end
			if x == 0 then
				ppx = ppx - 1
				player.px = cur_wid - 2
				mapchange = 1
			elseif x == cur_wid - 1 then
				ppx = ppx + 1
				player.px = 1
				mapchange = 1
			end

			if mapchange == 1 then
				if ppy < 13 then
					ppy = 14
				elseif ppy > 14 then
					ppy = 13
				end
				if ppx < 14 then
					ppx = 15
				elseif ppx > 15 then
					ppx = 14
				end
				player.wilderness_y = ppy
				player.wilderness_x = ppx
				player.regen_town()
				return true, false
			end
		end
-- ***

	end
}

-- Level feelings
hook(hook.FEELING, function()
	-- Summon Trunks? 
	if dball_data.trunks_hunt == 1 and rng(1, 3) == 1 then
		dball.place_monster(rng(1, cave_wid - 2), rng(1, cave_hgt - 2) , "Trunks", 0)
		for_each_monster(function(m_idx, monst)
			if monst.r_idx == RACE_TRUNKS then
				monst.ai = ai.DBT_DEFAULT
				monst.faction = FACTION_DUNGEON
			end
		end)
	end

	if dball.current_location() == "Muscle Tower" then
		if dun_level == 1 then
		elseif dun_level == 2 then
		end
	elseif dball.current_location() == "Buyon's Lair" then
		term.blank_print("", 0, 0) -- To place the cursor
		dialogue.BUYON_LAIR()
	elseif dball.current_location() == "Sewers" then
		if dun_level == 9 then
			message(color.YELLOW, "You feel like this level has not been implemented.")
		end
	elseif dball.current_location() == "Uranai Baba's House" then
		if dun_level == 26 then
			message(color.YELLOW, "The air is moist with a foul stench.")
		end
	elseif dball.current_location() == "Underwater Cavern" then
		if dun_level == 27 then
			message(color.YELLOW, "You feel the calm before the storm.")
		end
	elseif current_dungeon_idx == DUNGEON_RRA_SHQ1 then
		if dun_level == 42 and dball_data.level_tracker == -1 then
			if dball_data.rra_shq_cam == 0 then
				message(color.YELLOW, "A voice shouts: 'Intruder alert! Security to camera control!'")
			end
		elseif dun_level == 45 and dball_data.rra_gong_cam == 0 then
			sound.play_sample("ominous")
			dball_data.rra_gong_cam = 1
		end
	elseif current_dungeon_idx == DUNGEON_RRA_SHQ2 then
		if dun_level == 42 and dball_data.level_tracker == -1 then
			if dball_data.rra_shq_ext == 0 then
				message(color.YELLOW, "A voice shouts: 'Intruder alert! Security to missile control!'")
			end
		elseif dun_level == 45 and dball_data.rra_gong_ext == 0 then
			sound.play_sample("ominous")
			dball_data.rra_gong_ext = 1
		end
	elseif current_dungeon_idx == DUNGEON_RRA_SHQ3 then
		if dun_level == 42 and dball_data.level_tracker == -1 then
			if dball_data.rra_shq_int == 0 then
				message(color.YELLOW, "A voice shouts: 'Intruder alert! Security to turret control!'")
			end
		elseif dun_level == 45 and dball_data.rra_gong_int == 0 then
			sound.play_sample("ominous")
			dball_data.rra_gong_int = 1
		end
	elseif current_dungeon_idx == DUNGEON_RRA_SHQ4 then
		if dun_level == 42 and dball_data.level_tracker == -1 then
			if race_info_idx(RACE_RRA_RED, 0).max_num > 0 then
				message(color.YELLOW, "A voice shouts: 'Intruder alert! Security to SHQ!'")
			end
		elseif dun_level == 45 and dball_data.rra_gong_shq == 0 then
			sound.play_sample("ominous")
			dball_data.rra_gong_shq = 1
		end
	elseif dball.current_location() == "Dr. Gero's Lab" then
		-- if dun_level == 80 and dball_data.level_tracker == -1 and dball_data.gero_entrance == 0 then
		if dun_level == 80 and dball_data.gero_entrance == 0 then
			dball_data.gero_entrance = 1
			message(color.YELLOW, "...you have a very bad feeling about this...")
			sound.play_sample("ominous")
		end
	elseif dball.current_location() == "Land of Karin" then
		if dun_level == 1 and dball_data.level_tracker == -1 then
			-- message(color.YELLOW, "There's a wire rung ladder here, but it looks like a VERY LONG climb.")
		end
		if dun_level == 3 and dball_data.level_tracker == -1 then
			message(color.YELLOW, "Careful. There's no guard rail.")
		end
		if dun_level == 4 then
			message(color.YELLOW, "You feel at peace")
		end
		if dun_level == 5 then
			if dball_data.death_dialogue == 1 then
				dialogue.KAMI_RESSURECT()
			end
		end

	elseif dball.current_location() == "Foot Lair" then
		if dun_level == 12 and dball_data.level_tracker == -1 and dball_data.goods_warehouse == 0 then
			message(color.YELLOW, "Loud heavy metal music fills the air.")
		end
	elseif dball.current_location() == "Buddhist Temple" then
		if dun_level == 17 then
			-- if wizard then message("Hello? Test? Test? Hello?") end
			-- message(color.YELLOW, "Silly monks, keep it awfully dark in here.")
			if quest(QUEST_SAVE_THE_TEMPLE).status ~= QUEST_STATUS_TAKEN then
				if dball.how_many_exist(RACE_ABBOT) < 1 then
					dball.place_monster(7, 21, "The Abbot", 0)
				end
			end
		end
	elseif dball.current_location() == "Castle Oolong" then
		if dball_data.oolong_married == RACE_LUNCH and dball_data.oolong_lunch_only_once == 0 then
			dball_data.oolong_lunch_only_once = 1
			message(color.YELLOW, "You have a feeling things aren't entirely ok.")
		end
		
		
	elseif dball.current_location() == "The Serpent's Path" then
		if dball_data.emma_state == 2 or dball_data.emma_state == 3 then
			-- We're here because we're dead
			dialogue.EMMA()
		elseif dun_level == 80 then
			message(color.YELLOW, "Walk, don't run. Be careful...falling now would be bad.")
		end

	elseif dball.current_location() == "Hell" then
		if dball_data.demon_comic_dialogue == 0 then
			dball_data.demon_comic_dialogue = rng(1, 5)
			dialogue.DCD()
		end
	end

	if dball_data.dragon_radar > 0 then
		if dball.dragonballs_carried() > 0 then
			sound.play_sample("dbbwarp")
		elseif player.inventory[INVEN_TOOL][1] and player.inventory[INVEN_TOOL][1].flags[FLAG_DRAGON_RADAR] then
			message(color.YELLOW, "The Dragon Radar indicates a Dragonball is nearby!")
			sound.play_sample("radarblip")
		end
		dball_data.dragon_radar = 0
	end

	return true
end)


-- Add stat skills to stats
-- What about Android mods?
hook(hook.CALC_BONUS, function ()
	if game.started then
		local str_mod = dball_data.workout + (dball_data.muscle_stimulator / 10)
		player.stat_add[0] = player.stat_add[0] + get_skill(SKILL_STRENGTH) + dball_data.mod_strength + str_mod
		player.stat_add[1] = player.stat_add[1] + get_skill(SKILL_INTELLIGENCE) + dball_data.mod_intelligence + dball_data.study
		player.stat_add[2] = player.stat_add[2] + get_skill(SKILL_WILLPOWER) + dball_data.mod_willpower
		player.stat_add[3] = player.stat_add[3] + get_skill(SKILL_DEXTERITY) + dball_data.mod_dexterity
		player.stat_add[4] = player.stat_add[4] + get_skill(SKILL_CONSTITUTION) + dball_data.mod_constitution
		player.stat_add[5] = player.stat_add[5] + get_skill(SKILL_CHARISMA) + dball_data.mod_charisma
		player.stat_add[6] = player.stat_add[6] + get_skill(SKILL_SPEED) + dball_data.mod_speed

		-- Hack: Android mods must be factored AFTER the above
		-- if corruption(pos[ret], true)
		if corruption.__corruptions_aux[1] == true then
			-- Synthetic Muscle: Str
			player.stat_add[0] = 60 - player.stat_ind[0]
		end
		if corruption.__corruptions_aux[2] == true then
			-- Cortex Processor: Int
			player.stat_add[1] = 60 - player.stat_ind[1]
		end
		if corruption.__corruptions_aux[3] == true then
			-- Brainstem Processor: Dex
			player.stat_add[3] = 60 - player.stat_ind[3]
		end
		if corruption.__corruptions_aux[4] == true then
			-- Titanium lacing
			player.stat_add[4] = 60 - player.stat_ind[4]
		end
		if corruption.__corruptions_aux[5] == true then
			-- Adrenal Glands: Spd
			player.stat_add[6] = 60 - player.stat_ind[6]
		end
	end
end)

-- No resting on level 1 of Karin tower
-- You're climbing a ladder...where would you rest?
hook(hook.KEYPRESS, function (key)
	if key == strbyte('R') or key == strbyte('5') then
		if dball.current_location() == "Karin Tower" and dun_level == 1 then
			message(color.YELLOW, "You're climbing a ladder! There's nowhere to rest!")
			return true
		end
	end
end)

-- Need a watch to know the time
hook(hook.KEYPRESS, function (key)
	if key == KTRL('T') then
		if player.inventory[INVEN_WRIST][1] and player.inventory[INVEN_WRIST][1].flags[FLAG_TIMEPIECE] == true then
			if dball.am_i_on_earth() then
			else
			end
		else
			if dun_level == 0 then
				local turn = time.display_turn(turn)
				local hour = time(time.HOUR, turn)
				local minute = time(time.MINUTE, turn)
				if hour < 3 then
					message("It is the deep of night.")
				elseif hour < 5 then
					message("It is very early morning.")
				elseif hour < 6 then
					message("It will be morning soon.")
				elseif hour < 10 then
					message("It is morning.")
				elseif hour < 14 then
					message("It's about midday.")
				elseif hour < 16 then
					message("It's a little after noon.")
				elseif hour == 16 then
					message("It is early evening.")
				elseif hour == 17 then
					message("It will be dark soon.")
				else
					message("It's night time.")
				end
			else
				message("You have no idea what time it is.")
			end
			return true
		end
	end
end)

-- Need binoculars to scout around the map
hook(hook.KEYPRESS, function(key)
	if key == strbyte('L') then
		if corruption.__corruptions_aux[10] == true then
			if dball.am_i_on_earth() then
			elseif player.inventory[INVEN_TOOL][1] and player.inventory[INVEN_TOOL][1].flags[FLAG_BINOCULARS] == true then
			else
				message("You're unable to connect to a sattelite.")
				return true
			end
		else
			if player.inventory[INVEN_TOOL][1] and player.inventory[INVEN_TOOL][1].flags[FLAG_BINOCULARS] == true then
			else
				message("You need binoculars to do this.")
				return true
			end
		end
	end
end)


-- Suicide, for joke Pilaf quest
hook(hook.KEYPRESS, function (key)
	if key == strbyte('Q') and quest(QUEST_PILAF_EXECUTE).status == QUEST_STATUS_TAKEN then
		local ret, raw_key = get_com("Really execute yourself? (y/n)")
		if not ret then
			key = "n"
		end
		local key = strlower(strchar(raw_key))
		if key == "y" then
			if dball.current_location() == "Castle Pilaf" then
				dball_data.pilaf_execute = 1
				take_hit(10000, "following orders")
			else
				message("...ok.")
				take_hit(10000, "following orders")
			end
		end

		return true
	end
end)

-- No opening/closing doors while riding a motorcycle (or any other vehicle)
hook(hook.KEYPRESS, function (key)
	if key == strbyte('o') or key == strbyte('c') then
		if player.inventory[INVEN_VEHICLE][1] then
			if player.inventory[INVEN_VEHICLE][1].flags[FLAG_KINTO_UN] == true then
				-- Allow
			else
				message("It's not practical to open doors while riding.")
				return true
			end
		end
	elseif key == strbyte('g') then
		if player.inventory[INVEN_VEHICLE][1] then
			if player.inventory[INVEN_VEHICLE][1].flags[FLAG_KINTO_UN] == true then
				-- Allow
			else
				message("It's not practical to pick things up from the ground while riding.")
				return true
			end
		end
	end
end)

hook(hook.KEYPRESS, function (key)
	if key == strbyte('m') then
		if dball_data.max_chi_pool == 0 then
			message("You cannot manipulate Chi, yet.")
		else
			dball.mchi()
		end
		return true
	end
end)

-- 'U'se special skills/abilities
-- This should probably go into its own file
-- Regarding Planetary Teleport: Towns all hard coded still
-- I think town_info[] is what we want, but with no examples or directory
-- of array indexes, it's a lousy, unpleasant guessing game trying to
-- figure out where the coordinates are.
-- I don't think I like this policy of using data structures as
-- array indexes. It has to be slow, too. I'm sure the compiler is
-- just trying all the elements until it finds a match.
-- Anyway...someday we should probably download CVS
hook(hook.KEYPRESS, function (key)
	if key == strbyte('U') then
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nUse which ability?\n")

		dialogue.helper("Cancel", "a")

		-- Android Abilities
		if corruption.__corruptions_aux[10] == true then
			dialogue.helper("Satellite Mapping", "z")
		end

		if has_ability(AB_CHI_BURST) then
			local ddisp = get_skill(SKILL_CHI_OFFENSE) / 5
			if ddisp < 1 then ddisp = 1 end
			dialogue.helper("Chi Burst - Damage: 1-" .. ddisp .. " per point of Chi", "b")
		end
		if has_ability(AB_THROW) then
			dialogue.helper("Throw: not implemented", "c")
		end
		if has_ability(AB_TELEPORTATION) then
			local t_ab_str
			if has_ability(AB_PLANETARY_TELEPORT) then
				t_ab_str = "Teleport - Cost: 1"
			else
				t_ab_str = "Teleport - Cost = Range"
			end
			dialogue.helper(t_ab_str, "d")
		end
		if has_ability(AB_PLANETARY_TELEPORT) then
			dialogue.helper("Planetary Teleport - Cost: 1", "e")
		end
		if has_ability(AB_TELEPATHY) then
			dialogue.helper("Telepathy: not implemented", "f")
		end
		if has_ability(AB_BLINK) then
			local bos_cost = 11 - (get_skill(SKILL_CHI_GUNG) / 10)
			dialogue.helper("Burst of Speed: - Cost: " .. bos_cost .. " per step", "g")
		end
		-- Cure/heal only affects physical bodies
		if dball_data.alive == 0 then
			if has_ability(AB_CURE) then
				dialogue.helper("Cure Condition - Cost: 5", "h")
			end
			if has_ability(AB_HEAL) then
				local heal_cost = 21 - (get_skill(SKILL_CHI_GUNG) / 10)
				dialogue.helper("Heal - Cost: " .. heal_cost .. " per 100hp", "i")
			end
		end
		if has_ability(AB_JUMP) then
			dialogue.helper("Jump", "j")
		end

		-- Technomancers can enhance items with ego powers
		if get_skill(SKILL_TECHNOLOGY) >= 30 then
			-- dialogue.helper("Techno-Enhance", "k")
		end

		term.text_out("\n")
		local ans = dialogue.answer()

		term.load()
			
		if ans == "a" then -- Cancel

		-- ANDROID
		elseif ans == "z" then -- Satellite mapping
			-- No energy cost
			if dball.am_i_on_earth() then
				message("You check on your location via satellite.")
				message()
				-- wiz_lite(true)
				map_area(player.py, player.px, 200)
			else
				message("You're unable to connect to a sattelite.")
			end

		-- CHI
		elseif ans == "b" then -- Chi Burst
			local max_burst = (dball_data.cur_chi_pool) / 100
			local ignore_change = false

			local burst_select = dball_data.chi_burst_default
			if burst_select > max_burst then
				ignore_change = true
				burst_select = max_burst
			end
			while not nil do
				term.save()
				term.blank_print("How much Chi? (Arrow keys/Enter/ESC): " .. burst_select, 0, 0)

				local key = term.inkey()

				term.load()

				if strchar(key) == "4" then
					burst_select = burst_select - 1
				elseif strchar(key) == "6" then
					burst_select = burst_select + 1
				elseif strchar(key) == "\r" then
					break
				elseif key == ESCAPE then
					return true
				end

				if burst_select > max_burst then
					burst_select = max_burst
				elseif burst_select < 0 then
					burst_select = 0
				end
			end

			local ret, dir
			ret, dir = get_aim_dir()
			if ret then
				if ignore_change == false then
					dball_data.chi_burst_default = burst_select
				end
				local d_type = dam.CHI
				if get_skill(SKILL_CHI_OFFENSE) > 29 then
					d_type = dam.DISINTIGRATION
				end

				local max_dam = get_skill(SKILL_CHI_OFFENSE) / 5
				if max_dam < 1 then max_dam = 1 end
				max_dam = max_dam * burst_select
				local dddam = rng(1, max_dam)
				local rad = 1
				if dddam > 999 then
					rad = 4
				elseif dddam > 499 then
					rad = 3
				elseif dddam > 199 then
					rad = 2
				end
				-- fire_bolt(d_type, dir, rng(1, max_dam))
				dball.chi_burst(d_type, 0, player.py, player.px, -1, -1, dir, dddam, rad)
				local burst_cost = 0 - (burst_select * 100)
				dball.mod_chi(burst_cost)
				energy_use = get_player_energy(SPEED_CAST)
			end
			message()
		elseif ans == "c" then
			message("Implement me!")
		elseif ans == "d" then	-- Teleport
			if dball_data.cur_chi_pool < 10 then
				message("You haven't enough energy!")
				return true
			end

			local ret, dir, x, y, c_ptr
			ret, x, y = tgt_pt()
			if not ret then
				return true
			end

			if has_ability(AB_PLANETARY_TELEPORT) then
				tele_cost = 10
			else
				tele_cost = 10 * distance(player.py, player.px, y, x)
			end

			if tele_cost > dball_data.max_chi_pool then
				message("You haven't enough energy to teleport that far!")
				return true
			else
				if cave_empty_bold(y, x) then
					teleport_player_to(y, x)
				else
					y, x = dball.find_open_space(y, x, tele_cost / 2)
					if y > 0 then
						teleport_player_to(y, x)
					end
					message("You attempt to teleport inside something solid, and are badly jarred!")
					take_hit(rng(10, 100), "improper materialization")
				end
			end

			dball.mod_chi(-tele_cost * 10)
			-- No energy cost for teleport! It's instantaneous.
			return true

		elseif ans == "e" then
			if dball_data.cur_chi_pool < 50 then
				message("You haven't enough energy")
				return true
			end

			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "\nTeleport to which planet?\n")
			dialogue.helper("Cancel", "a")
			dialogue.helper("Earth, Southwest Quadrant", "b")
			dialogue.helper("Earth, Northwest Quadrant", "c")
			dialogue.helper("Earth, Southeast Quadrant", "d")
			dialogue.helper("Earth, Northeast Quadrant", "e")

			if dball_data.planet_kaio ~= 0 or (wizard) then
				dialogue.helper("The North Kaio's Planet", "f")
			end
			if dball_data.planet_namek ~= 0 or (wizard) then
				dialogue.helper("Namek", "g")
			end
			if dball_data.planet_plant ~= 0 or (wizard) then
				dialogue.helper("The Ruins of Planet Plant", "h")
			end
			if dball_data.planet_79 ~= 0 or (wizard) then
				dialogue.helper("Planet 79", "i")
			end
			-- Oops! > 9 answers doesn't work, now does it?
			--if dball_data.planet_babidi ~= 0 or (wizard) then
			--	dialogue.helper("Babidi's Spaceship", "a"0)
			--end
			term.text_out("\n")
			local ans = dialogue.answer()

			term.load()

			local y, x, which_town

			-- ...planet sequencing is generally inconsistent...
			if ans == "a" then
				return true
			elseif ans == "b" then
				y, x, which_town = 8, 4, "Earth, SW"
			elseif ans == "c" then
				y, x, which_town = 7, 4, "Earth, NW"
			elseif ans == "d" then
				y, x, which_town = 8, 5, "Earth, SE"
			elseif ans == "e" then
				y, x, which_town = 7, 5, "Earth, NE"
			elseif ans == "f" then
				y, x, which_town = 2, 24, "Kaio"
			elseif ans == "g" then
				y, x, which_town = 13, 14, "Namek"
			elseif ans == "h" then
				y, x, which_town = 9, 26, "Plant"
			elseif ans == "i" then
				y, x, which_town = 16, 44, "79"
			end

			-- No redundancy checking?
			if dball.current_location() == which_town then
				message("Already there!")
				return true
			else
				dun_level = 0
				player.wilderness_y = y
				player.wilderness_x = x
				-- We might consider varying py/px by destination
				-- Currently, mountain lions and RRA guardsmen
				-- make some destinations dangerous
				player.py = 34
				player.px = 111
				player.leaving = true
				dball.mod_chi(-50)
			end

			-- No energy use for Planetary Teleport

		elseif ans == "f" then
			message("Implement me!")
		elseif ans == "g" then	-- Burst of Speed (Blink, LOS-only)
			local bos_cost = 11 - (get_skill(SKILL_CHI_GUNG) / 10)
			if dball_data.cur_chi_pool < bos_cost then
				message("You haven't enough energy!")
				return true
			end

			local ret, dir, dx, dy, tele_cost
			ret, dx, dy = tgt_pt()
			if not ret then
				return true
			end

			-- clear the display
			message()

			-- Note that this is extremely similar to dball.teleport_player()


			local tdis = distance(player.py, player.px, dy, dx)
			local by = player.py
			local bx = player.px
			local y = player.py
			local x = player.px
			local ny, nx

			for cur_dis = 0, tdis do
				-- Place the player if we make it to the destination
				if ((y == dy) and (x == dx)) then
					teleport_player_to(dy, dx)
					return true
				end

				-- Only continue if we have enough energy
				local bos_cost = 11 - (get_skill(SKILL_CHI_GUNG) / 10) -- How many times do we need to define this???
				if dball_data.cur_chi_pool >= (bos_cost * 100) then
					dball.mod_chi(-(bos_cost * 100))
				else
					teleport_player_to(y, x)
					message("You run out of energy before you reach your target!")
					-- Use energy if this happens
					energy_use = get_player_energy(SPEED_CAST)
					return true
				end

				-- Calculate the new location
				ny = y
				nx = x
				ny, nx = mmove2(ny, nx, by, bx, dy, dx)

				-- Have we smashed into a wall or door?
				-- implement more descriptive 'what we crashed into' text
				if (cave_floor_bold(ny, nx) == nil) then
					monster_random_say
					{
						"Ouch!",
						"You smash headfirst into a wall!",
						"You smack into a wall!",
					}
					teleport_player_to(y, x) -- Note this is still 'previous' location
					take_hit(rng(1, 50), "smashing into a wall")
					return true
				end

				-- Have we smashed into a monster?
				local c_ptr = cave(ny, nx)
				local m_ptr
				if c_ptr.m_idx > 0 then
					local monst = monster(c_ptr.m_idx)
					local m_name = monster_desc(monst, 0)
					monster_random_say
					{
						"You smash into " ..m_name,
						"You collide with " .. m_name,
					}
					-- Collission hurts monster too
					local collission_dam = rng(1, 30)
					project(WHO_PLAYER, 0, ny, nx, collission_dam, dam.CRUSH, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
					teleport_player_to(y, x) -- Note this is still 'previous' location
					take_hit(collission_dam, "smashing into" .. m_name)
					-- Use energy if collide
					energy_use = get_player_energy(SPEED_CAST)
					return true
				end
				-- Save the new location
				x = nx
				y = ny
			end
			-- No energy cost for burst of speed! It's instantaneous.
			return true

		elseif ans == "h" then	-- Cure Conditions
			if dball_data.cur_chi_pool < 50 then
				message("You haven't enough energy")
				return true
			end

			dball.cure_cond()
			dball.mod_chi(-50)
			energy_use = get_player_energy(SPEED_CAST)
			message("You purify yourself.")

		elseif ans == "i" then	-- Heal
			local heal_cost = 11 - (get_skill(SKILL_CHI_GUNG) / 10)
			if dball_data.cur_chi_pool < heal_cost then
				message("Not enough energy!")
				return true
			end
			
			local heal_select = 1
			while not nil do
				term.blank_print("Heal how much? (Arrow keys/Enter): ".. heal_select * 100 .. "hp Cost: " .. heal_select * heal_cost, 0, 0)

				local key = strchar(term.inkey())

				if key == '4' then
					heal_select = heal_select - 1
				elseif key == '6' then
					heal_select = heal_select + 1
				elseif key == "\r" then
					break
				elseif key == ESCAPE then
					-- break
					return true
				end

				if heal_select * heal_cost > dball_data.cur_chi_pool then
					heal_select = heal_select - 1
				elseif heal_select < 0 then
					heal_select = 0
				end
			end

			local chi_cost = heal_select * heal_cost * -1
			dball.mod_chi(chi_cost * 100)
			hp_player(heal_select * 100)
			energy_use = get_player_energy(SPEED_CAST)
			message(" You flood your body with healing energy!")
		elseif ans == "j" then	-- Jump
			if dball_data.chi_flight_setting == 1 then
				message("You're flying! How would you jump?")
				return
			end
			
			local ret, dir = get_rep_dir()
			if not ret then return end
			local y, x = explode_dir(dir)
			y, x = y + y + player.py, x + x + player.px
			-- message("y: " .. y .. "  x: " .. x)
			if player_can_see_bold(y, x) and los(player.px, player.py, x, y) then
				dball.teleport_player(y, x) -- Does collision handling
			else
				message("That spot is inaccessible")
			end

			energy_use = get_player_energy(SPEED_CAST)
		elseif ans == "k" then	-- Techomancer Enhance item with ego
				local ret, item = get_item("Use which item?",
							"Enhance what? (Experimental)",
							USE_INVEN | USE_EQUIP,
								function(o)
									return true
							   end)
				if not ret or not item then return nil end

				-- Get the item (in the pack)
				local object = get_object(item)


		else
			message("Error: Unknown ability!")
		end

	-- Energy handled case by case above
	return true
	end
end)

-- The 'Neutral' faction is often used for temporary settings
hook(hook.STAIR_DO, function(updown, ask_leave)
	-- factions.set_friendliness(FACTION_PLAYER, FACTION_NEUTRAL, 0)
	-- factions.set_friendliness(FACTION_NEUTRAL, FACTION_PLAYER, 0)
	dueling = 0 -- Reset all duels on level change
end)

hook(hook.GIVE_PRE, function(m_idx, item)
	local monst = monster(m_idx)
	local r_ptr = r_info[monst.r_idx + 1]

	local obj = get_object(item)

	-- Catnip for cats
	if obj.k_idx == lookup_kind(TV_FOOD, SV_CATNIP) then
		if monst.flags[FLAG_NO_CATNIP] then
			message("Thank you, but I don't do catnip. They say it's addictive.")
		elseif monst.flags[FLAG_KITTY] then
			-- message("Disabled since V077 due to new bug appearing with alpha12") -- Implement fix me
			item_increase(item, -1)
			item_describe(item)
				item_optimize(item)
			if monst.faction == FACTION_PLAYER then
				message(monster_desc(monst, 0) .. " happily takes it")
			elseif rng(1, monst.level) <= 1 + (player.stat(A_CHR) - 10) then
				monst.faction = FACTION_PLAYER
				monst.flags[FLAG_PERMANENT] = true
				message("You have made a friend!")
			else
				message(monster_desc(monst, 0) .. " cautiously takes it...")
			end
		end
		return true
	end

	-- Healing for companions
	if monst.faction == FACTION_PLAYER and obj.k_idx == lookup_kind(TV_FOOD, SV_SENZU_BEAN) then
		item_increase(item, -1)
		item_describe(item)
		item_optimize(item)
		monst.hp = monst.maxhp
		message(monster_desc(monst, 0) .. " eats it and is completely healed!")
	end

	-- Dragonballs?
	if obj.k_idx == lookup_kind(TV_DBALL, SV_DRAGONBALL) then
		message("Giving away dragonballs via 'give' not yet implemented.")
	end
end)

-- Update Quest display on level-up
-- Note: This appears to execute at every XP gain
hook(hook.PLAYER_LEVEL,
function()
	if dball_data.member_gym ~= 0 then
		if dball_data.workout <= (player.lev / 5) then
			quest(QUEST_GYMMEMBER).status = QUEST_STATUS_TAKEN
		end
	end

	if dball_data.member_library ~= 0 then
		if dball_data.study <= (player.lev / 5) then
			quest(QUEST_LIBRARYMEMBER).status = QUEST_STATUS_TAKEN
		end
	end
end)

-- General 'stuff' to do only once at character creation
hook(hook.GAME_START, function(new)
	if new == true then
		-- Generate a Seiyan name for the Radditz plotline
		dball_data.seiyan_name = dball.generate_seiyan_name()

		-- Hide the abilities
		ability(AB_MOTORCYCLIST).hidden = true
		ability(AB_PILOT).hidden = true
		ability(AB_SKATING).hidden = true
		ability(AB_SWIMMING).hidden = true
		ability(AB_JUMP).hidden = true
		ability(AB_FIRST_AID).hidden = true
		ability(AB_ACUPUNCTURE).hidden = true

		ability(AB_MEDITATION).hidden = true
		ability(AB_IMMOVABILITY).hidden = true
		ability(AB_SNEAK).hidden = true
		ability(AB_THROW).hidden = true
		ability(AB_ULTIMATE).hidden = true
		ability(AB_SUSHI).hidden = true

		ability(AB_DOUBLE_ATTACK).hidden = true
		ability(AB_BLOCKING).hidden = true
		ability(AB_TAMESHIWARI).hidden = true

		ability(AB_PAIRED_WEAPONS).hidden = true
		ability(AB_RIPOSTE).hidden = true
		ability(AB_IAIJUTSU).hidden = true
		ability(AB_BLEED_ATTACK).hidden = true

		ability(AB_PAIRED_FIREARMS).hidden = true
		ability(AB_POINT_BLANK).hidden = true
		ability(AB_MULTI_TARGET).hidden = true

		ability(AB_CHI_BURST).hidden = true
		ability(AB_HASTE).hidden = true
		ability(AB_BLINK).hidden = true
		ability(AB_AURA).hidden = true
		ability(AB_LIGHT).hidden = true
		ability(AB_POWER_DETECTION).hidden = true
		ability(AB_FLIGHT).hidden = true
		ability(AB_CURE).hidden = true
		ability(AB_HEAL).hidden = true
		ability(AB_REGENERATION).hidden = true
		ability(AB_ABSORBTION).hidden = true
		ability(AB_TELEPATHY).hidden = true
		ability(AB_TELEPORTATION).hidden = true
		ability(AB_PLANETARY_TELEPORT).hidden = true

		ability(AB_SPIRIT_BOMB).hidden = true
		ability(AB_FUSION).hidden = true
	end
end)

-- Replace conversation with DBTCHAT
hook(hook.KEYPRESS, function (key)
	local x_mod = 0
	local y_mod = 0
	if key == strbyte('Y') then
		local ret, dir = get_rep_dir()
		if not ret then return end
		local y, x = explode_dir(dir)
		y, x = y + player.py, x + player.px

		local c_ptr = cave(y, x)

		if c_ptr.m_idx == 0 then
			message("You don't see anyone there to talk to.")
			return true, false
		else

		local m_ptr = monster(c_ptr.m_idx)
		local r_ptr = r_info[m_ptr.r_idx + 1]

		local m_name = monster_desc(m_ptr, 0)

			if m_ptr.flags[FLAG_DBTCHAT] then
				local func
				func = get_function_registry_from_flag(r_ptr.flags, FLAG_DBTCHAT)
				func()
			else
				message(m_name .. " doesn't have anything to say.")
			end
		end
		return true, false
	end
end)
--[[
-- Chat
hook(hook.CHAT,
function(m_idx)
	local monst = monster(m_idx)
	local r_ptr = r_info[monst.r_idx + 1]
	local m_name = monster_desc(monst, 0)

	if r_ptr.flags[FLAG_DBTCHAT] then
		local func = get_function_registry_from_flag(r_ptr.flags, FLAG_DBTCHAT)
		func(m_name, m_idx, monst)
		return true
	end
end)
]]

-- Item drop prohibitions
hook(hook.KEYPRESS, function (key)
	if key == strbyte('g') then
		if dball.current_location() == "Dr. Briefs' Laboratory" then
			if race_info_idx(RACE_BRIEFS, 0).max_num > 0 and quest(QUEST_BRIEFS_UPGRADE).status ~= QUEST_STATUS_FINISHED then
				message("Dr. Briefs: Don't move anything! I might forget where I put it!")
				return true, false
			end
		end
	end
end)

-- Item get prohibitions
hook(hook.KEYPRESS, function (key)
	if key == strbyte('d') then
		if dball.current_location() == "Dr. Briefs' Laboratory" then
			if race_info_idx(RACE_BRIEFS, 0).max_num > 0 and quest(QUEST_BRIEFS_UPGRADE).status ~= QUEST_STATUS_FINISHED then
				message("Dr. Briefs: I think I have enough clutter without anyone adding to it!")
				return true, false
			end
		end
	end
end)

-- Every step you take...
hook(hook.MOVE_POST, function(oy, ox)
	-- Time warning (What about SURFACE_LIGHT=true dungeons?
	if dball.am_i_on_earth() == true then
		if dun_level == 0 then
			local turn = time.display_turn(turn)
			local hour = time(time.HOUR, turn)

			if hour == 5 and dball.time_warning == 1 then
				message(color.YELLOW, "It will be morning soon.")
				dball.time_warning = 0
			elseif hour == 16 and dball.time_warning == 0 then
				message(color.YELLOW, "The sun is setting. It will be dark soon.")
				dball.time_warning = 1
			end	
		end
	end

	-- The Foot periodically send assassins
	if quest(QUEST_BEING_WATCHED).status == QUEST_STATUS_TAKEN and rng.number(2000) == 1 then
		if place_named_monster_near(player.py, player.px, "foot ninja", 0) then
			dball_data.foot_assassin = 1
			message(color.YELLOW, "Suddenly a ninja appears from nowhere!")
		end
	end

	-- Check for traps if you are using a trap detecting tool such as a metal detector
	if player.inventory[INVEN_TOOL][1] then
		if player.inventory[INVEN_TOOL][1].flags[FLAG_TRAP_DETECTOR] then
			traps.detect(1)
		end
	end

	-- If you're in hell, count steps
	if dball.current_location() == "Hell" then
		dball_data.steps_in_hell = dball_data.steps_in_hell + 1
		if dball_data.demon_comic_dialogue == 1 and dball_data.steps_in_hell == 7 then
			dialogue.GOZMEZ_PAYUP()
		end
	end

	-- Move to Process world?
	-- Neuro toxins are bad
	if dball_data.fugu == true then
		message("You are dying!")
		take_hit(100, "fugu neuro toxins")
	end

end)

hook(hook.PROCESS_WORLD, function()
	-- Grow ajasa seed
	-- Hackish until Namek has been migrated to SAVE_LEVEL=true
	if dball_data.namek_ajasa_state > 0 then
		dball_data.namek_ajasa_state = dball_data.namek_ajasa_state - 1
		if dball_data.namek_ajasa_state == 0 then
			dball_data.namek_ajasa_total = dball_data.namek_ajasa_total + 1
		end
	end

	-- Regenerate Chi
	dball.chi_regen()

-- Whoops...is the engine doing this for us now?
-- ...I'm not using the lite subsystem...
--[[
	-- Lights in hands lose charge over time
	for i = 1, 2 do
		if player.inventory[INVEN_WIELD][i] then
			if player.inventory[INVEN_WIELD][i].flags[FLAG_FUEL] then
				local when = player.inventory[INVEN_WIELD][i].flags[FLAG_FUEL_USE]
				local deplete = false
				if when == FLAG_USE_ALWAYS then
					deplete = true
				elseif when == FLAG_USE_IN_WATER then
				else
				end
				if deplete == true then
					if player.inventory[INVEN_WIELD][i].flags[FLAG_FUEL] > 0 then
						player.inventory[INVEN_WIELD][i].flags[FLAG_FUEL] = player.inventory[INVEN_WIELD][i].flags[FLAG_FUEL] - 1
					end
				end
			end
		end
	end
]]

	-- Special handling to avoid recursive death loop bugs. (Wow! That would be a cool monster type!)
	if dball_data.recursive_death ~=  0 then
		if dball_data.recursive_death == 1 then
			kill_player("Soul Recycling")
		elseif dball_data.recursive_death == 2 then
			kill_player("Remote Stop Device")
		else
			message("Whoa! You have an unknown recursive death value! Talk about weird errors!")
			dball_data.recursive_death = 0
		end
	end
end)

-- Monsters and FEAT's that need to be placed via code
-- (Note: as of alpha 6/7 some of this is no longer strictly
-- necessary, but it's here...it works...and there isn't
-- much reason to move it back to the map files)
hook(hook.WILD_GEN_MON, function()
--hook(hook.WILD_LARGE_NEW_AREA_POST, function()

	-- Do this now:
	local c_ptr

	-- Reset all duels
	dueling = 0

	-- Unannoy neutrals
	dball.faction_unannoy(FACTION_NEUTRAL)

	-- Reset Muscle Tower Patrol Alarm
	dball_data.rra_mt_patrol_alarm = 0

	-- Workaround for Hanger rental
	if quest(QUEST_PILOTMEMBER).status == QUEST_STATUS_TAKEN then
		if dball_data.hanger_start_date + dball_data.hanger_rental - dball.dayofyear() < 1 then
			quest(QUEST_PILOTMEMBER).status = QUEST_STATUS_FAILED
			-- Auction!
			--local town = town_info[1 + 1]
			--local st_ptr = town.stores[store.STORE_HOME_HANGER];
			--while st_ptr->stock_num > 0 do
			--	store_delete()
			--end
		end
	end

	-- Once they've been tripped, Androids 16 and 17 can appear anywhere on earth
	if dball_data.android_quest_status == 1 and dball.am_i_on_earth() then
		 -- 1:10 chance of them appearing
		if rng(1,10) then
			local yy, xx = rng(1,55), rng(1,180)
			if cave(yy, xx).feat == FEAT_GRASS or cave(yy, xx).feat == FEAT_DIRT then
				dball.place_monster(yy, xx, "Android 17", 0)
				dball.place_monster(yy + 1, xx, "Android 18", 0)
				if (wizard) then
					message(color.VIOLET, "Wizard: Androids are present")
				end
			end
		end
	elseif dball_data.android_quest_status == 2 and dball.am_i_on_earth() then
		 -- 1:3 chance, once they've been seen
		if rng(1,3) then
			local yy, xx = rng(1,55), rng(1,180)
			if cave(yy, xx).feat == FEAT_GRASS or cave(yy, xx).feat == FEAT_DIRT then
				dball.place_monster(yy, xx, "Android 17", 0)
				dball.place_monster(yy + 1, xx, "Android 18", 0)
				if (wizard) then
					message(color.VIOLET, "Wizard: Androids are present")
				end
			end
		end
	end

	-- Buruma may also appear anywhere above ground on earth
	if quest(QUEST_BRIEFS_FIND_BURUMA).status == QUEST_STATUS_UNTAKEN or quest(QUEST_BRIEFS_FIND_BURUMA).status == QUEST_STATUS_TAKEN then
		if starts_with(dball.current_location(), "Earth") then
			if rng(1,100) > 89 then
				local yy, xx = rng(1,60), rng(1,180)
				if cave(yy, xx).feat == FEAT_GRASS or cave(yy, xx).feat == FEAT_DIRT then
					dball.place_monster(yy, xx, "Buruma", 0)
					 if (wizard) then
						message(color.VIOLET, "Wizard: Buruma is present")
					end
				end
			end
		end
	end




	-- Recalc which dragonballs are available!
	-- dball.???

	-- Earth 1:
	if dball.current_location() == "Earth 1" then
	end
	-- Earth 2:
	if dball.current_location() == "Earth 2" then
	end
	-- Earth 3: Yamcha, ChichiHouse
	if dball.current_location() == "Earth 3" then
		if dball_data.yamcha_state < 5 then
			dball.place_monster(29, 50, "Yamcha, the desert bandit")
			dball.place_monster(30, 50, "Puar")
			dball_data.yamcha_state = 0
		end
		if dball_data.married == FLAG_MARRIED_CHICHI then
			c_ptr = cave(16, 129)
			flag_empty(c_ptr.flags)
			cave_set_feat(16, 129, FEAT_SHOP)
			c_ptr.flags[FLAG_CONTAINS_BUILDING] = store.STORE_HOME_CHICHI
			c_ptr.flags[FLAG_STORE_OWNER] = store.OWNER_PLAYER
			cave(16, 129).inventory[INVEN_LIMIT_KEY] = 0
		end
	end
	-- Earth 4: Oolong, Aru
	if dball.current_location() == "Earth 4" then
		if race_info_idx(RACE_OOLONG, 0).max_num < 1 then
			cave_set_feat(35, 60, FEAT_FLOOR)
			cave(35, 60).flags[FLAG_MOVE_POST_DEST] = function() message("With Oolong dead, creditors have seized his estate.") end
		elseif dball_data.married == FLAG_MARRIED_OOLONG then
			c_ptr = cave(35, 62)
			flag_empty(c_ptr.flags)
			cave_set_feat(35, 62, FEAT_SHOP)
			c_ptr.flags[FLAG_CONTAINS_BUILDING] = store.STORE_HOME_OOLONG
			c_ptr.flags[FLAG_STORE_OWNER] = store.OWNER_PLAYER
			cave(35, 62).inventory[INVEN_LIMIT_KEY] = 0
		end
		if quest(QUEST_ARU_THUGS).status == QUEST_STATUS_TAKEN then
			place_named_monster(53, 79, "Ginkako, the thug", 0)
			place_named_monster(54, 79, "Kinkaku, the thug", 0)
		end
	end
	-- Earth 5: 6Schools, Electronics, Wishhouse
	if dball.current_location() == "Earth 5" then
		if c_schools[FLAG_KARATE] == FLAG_SCHOOL_CLOSED then
			cave_set_feat(52, 88, FEAT_FLOOR)
			-- cave(52, 88).flags[FLAG_MOVE_POST_DEST] = function() message("With Nakamura gone, this dojo has closed") end
		end
		if c_schools[FLAG_KICKBOXING] == FLAG_SCHOOL_CLOSED then
			cave_set_feat(54, 90, FEAT_FLOOR)
			-- cave(54, 90).flags[FLAG_MOVE_POST_DEST] = function() message("With Bob gone, this gym has closed.") end
		end
		if c_schools[FLAG_JUDO] == FLAG_SCHOOL_CLOSED or dball_data.fled_sumo == 1 then
			cave_set_feat(55, 96, FEAT_FLOOR)
			-- cave(55, 96).flags[FLAG_MOVE_POST_DEST] = function() message("With Yawara gone, this dojo has closed.") end
		end
		if c_schools[FLAG_SUMO] == FLAG_SCHOOL_CLOSED then
			cave_set_feat(55, 102, FEAT_FLOOR)
			-- cave(55, 102).flags[FLAG_MOVE_POST_DEST] = function() message("With Honda gone, this dojo has closed.") end
		end
		if c_schools[FLAG_KUNGFU] == FLAG_SCHOOL_CLOSED then
			cave_set_feat(54, 108, FEAT_FLOOR)
			-- cave(54, 106).flags[FLAG_MOVE_POST_DEST] = function() message("With Fong Sai Yuk gone, this studio has closed.") end
		end
		if c_schools[FLAG_FENCING] == FLAG_SCHOOL_CLOSED then
			cave_set_feat(52, 110, FEAT_FLOOR)
			-- cave(52, 106).flags[FLAG_MOVE_POST_DEST] = function() message("With Jacque gone, this school has closed.") end
		end
		if c_schools[FLAG_BALLET] == FLAG_SCHOOL_CLOSED then
			cave_set_feat(36, 111, FEAT_FLOOR)
			-- cave(36, 111).flags[FLAG_MOVE_POST_DEST] = function() message("Elizabeth's school is gone.") end
		end
		if dball_data.goods_store_closed == 1 then
			cave_set_feat(36, 87, FEAT_FLOOR)
			-- cave(36, 87).flags[FLAG_MOVE_POST_DEST] = function() message("George has closed his shop and left town.") end
		end
		if dball_data.wishhouse_earth > 0 then
			dball.place_wishhouse("Earth")
		end
	end
	-- Earth 6: White Wolf escort
	if dball.current_location() == "Earth 6" then
		if race_info_idx(RACE_WHITE_WOLF, 0).max_num == 0 and dball_data.wolf_escort == 0 then
			dball_data.wolf_escort = 1
			place_named_monster(51, 9, "wolf", 0)
			place_named_monster(51, 10, "wolf", 0)
			place_named_monster(51, 11, "wolf", 0)
			place_named_monster(51, 12, "wolf", 0)
			place_named_monster(52, 9, "wolf", 0)
			place_named_monster(52, 10, "wolf", 0)
			place_named_monster(52, 12, "wolf", 0)
			place_named_monster(53, 9, "wolf", 0)
			place_named_monster(53, 10, "wolf", 0)
			place_named_monster(53, 11, "wolf", 0)
			place_named_monster(53, 12, "wolf", 0)

			place_named_monster(52, 13, "wolf", 0)

			-- No running back into the cave to escape
			for_each_monster(function(m_idx, monst)
				if monst.r_idx == RACE_WOLF then
					monst.flags[FLAG_PERMANENT]=true
				end
			end)

		end
	end
	-- Earth 7: Underwater Caves
	if dball.current_location() == "Earth 7" then
		if dball_data.rra_blue_bd ~= 0 then
			cave_set_feat(30, 91, FEAT_DEEP_WATER)
		end
	end
	-- Earth 8: KameHouse, VidelHouse, Marksmanship, Lunch
		if dball_data.married == FLAG_MARRIED_ROSSHI then
			c_ptr = cave(20, 58)
			flag_empty(c_ptr.flags)
			cave_set_feat(20, 58, FEAT_SHOP)
			c_ptr.flags[FLAG_CONTAINS_BUILDING] = store.STORE_HOME_ROSSHI
			c_ptr.flags[FLAG_STORE_OWNER] = store.OWNER_PLAYER
			cave(20, 58).inventory[INVEN_LIMIT_KEY] = 0
		end
		if dball.current_location() == "Earth 8" then
			if dball_data.married == FLAG_MARRIED_VIDEL then
				c_ptr = cave(45, 138)
				c_ptr.info = 3
				flag_empty(c_ptr.flags)
				cave_set_feat(45, 138, FEAT_SHOP)
				cave_set_feat(46, 138, FEAT_SIDEWALK)
				c_ptr.flags[FLAG_CONTAINS_BUILDING] = store.STORE_HOME_VIDEL
				c_ptr.flags[FLAG_STORE_OWNER] = store.OWNER_PLAYER
				cave(45, 138).inventory[INVEN_LIMIT_KEY] = 0
			end
			if c_schools[FLAG_MARKSMANSHIP] == FLAG_SCHOOL_CLOSED then
				c_ptr = cave(46, 172) 
				c_ptr.info = 3
				flag_empty(c_ptr.flags)
				cave_set_feat(46, 172, FEAT_FLOOR)
				cave(46, 172).inventory[INVEN_LIMIT_KEY] = 0
			end
		end
		if (player.lev > 9) and (rng(1,100) > 89) then
			local yy, xx = rng(1,60), rng(1,180)
			if cave(yy, xx).feat == FEAT_GRASS or cave(yy, xx).feat == FEAT_DIRT then
				dball.place_monster(yy, xx, "Lunch", 0)
				if (wizard) then
					message(color.VIOLET, "Wizard: Lunch is present")
				end
			end
		end
	-- Earth 9: Ninjutsu, RRA Guards and Patrol, RRA SHQ
	if dball.current_location() == "Earth 9" then
		if c_schools[FLAG_NINJUTSU] == FLAG_SCHOOL_CLOSED then
			cave_set_feat(15, 41, FEAT_GRASS)
			-- cave(15, 41).flags[FLAG_MOVE_POST_DEST] = function() message("There is nothing here.") end
		end
		if race_info_idx(RACE_RRA_WHITE, 0).max_num ~= 0 then
			dball.place_monster(47, 90, "red ribbon army patrol", 0)
			dball.place_monster(46, 105, "red ribbon army patrol", 0)
			dball.place_monster(35, 110, "red ribbon army patrol", 0)
			dball.place_monster(30, 116, "red ribbon army patrol", 0)
			dball.place_monster(33, 80, "red ribbon army patrol", 0)
			dball.place_monster(28, 70, "red ribbon army patrol", 0)
			dball.place_monster(22, 93, "red ribbon army patrol", 0)
			dball.place_monster(37, 99, "red ribbon army patrol", 0)
		end

		-- Place the missile turrets
		if (dball_data.rra_shq_ext == 0) and (race_info_idx(RACE_RRA_RED, 0).max_num ~= 0) then
			dball.place_monster(29, 147, "missile turret", 0)
			dball.place_monster(29, 156, "missile turret", 0)
			dball.place_monster(34, 140, "missile turret", 0)
			dball.place_monster(34, 163, "missile turret", 0)
			dball.place_monster(42, 140, "missile turret", 0)
			dball.place_monster(42, 163, "missile turret", 0)
			dball.place_monster(47, 148, "missile turret", 0)
			dball.place_monster(47, 156, "missile turret", 0)
		end

		local shq_locs = {DUNGEON_RRA_SHQ1,DUNGEON_RRA_SHQ2,DUNGEON_RRA_SHQ3,DUNGEON_RRA_SHQ4}
		for i = 1, 4 do
			if i == 1 then
				c_ptr = cave(37, 149)
				flag_empty(c_ptr.flags)
				cave_set_feat(37, 149, FEAT_MORE)
				c_ptr.flags[FLAG_DUNGEON] = shq_locs[dball_data.shq_loc1]
				c_ptr.flags[FLAG_LEVEL_CHANGER] = 1
				c_ptr.flags[FLAG_TERRAIN_TEXT] = "an entrance to Red Ribbon Army Headquarters"
				-- c_ptr.flags[FLAG_TERRAIN_NAME] = "Why"
			elseif i == 2 then
				c_ptr = cave(37, 154)
				flag_empty(c_ptr.flags)
				cave_set_feat(37, 154, FEAT_MORE)
				c_ptr.flags[FLAG_DUNGEON] = shq_locs[dball_data.shq_loc2]
				c_ptr.flags[FLAG_LEVEL_CHANGER] = 1
				c_ptr.flags[FLAG_TERRAIN_TEXT] = "an entrance to Red Ribbon Army Headquarters"
				-- c_ptr.flags[FLAG_TERRAIN_NAME] = "doesn't"
			elseif i == 3 then
				c_ptr = cave(39, 149)
				flag_empty(c_ptr.flags)
				cave_set_feat(39, 149, FEAT_MORE)
				c_ptr.flags[FLAG_DUNGEON] = shq_locs[dball_data.shq_loc3]
				c_ptr.flags[FLAG_LEVEL_CHANGER] = 1
				c_ptr.flags[FLAG_TERRAIN_TEXT] = "an entrance to Red Ribbon Army Headquarters"
				-- c_ptr.flags[FLAG_TERRAIN_NAME] = "this"
			elseif i == 4 then
				c_ptr = cave(39, 154)
				flag_empty(c_ptr.flags)
				cave_set_feat(39, 154, FEAT_MORE)
				c_ptr.flags[FLAG_DUNGEON] = shq_locs[dball_data.shq_loc4]
				c_ptr.flags[FLAG_LEVEL_CHANGER] = 1
				c_ptr.flags[FLAG_TERRAIN_TEXT] = "an entrance to Red Ribbon Army Headquarters"
				-- c_ptr.flags[FLAG_TERRAIN_NAME] = "work?"
			end
		end

	end

	-- Namek: Leviathan
	-- Is this neccesary now that Namek is level 44?
	if dball.current_location() == "Namek NE" then
		local yy = rng(2, cur_hgt - 1)
		local xx = rng(2, cur_wid - 1)
		place_named_monster(yy, xx, "leviathan", 0)
	end


	if dball.current_location() == "Kaio" then
		message(color.YELLOW, "The gravity here is oppressive!")
	end

	-- Place player when exiting the teleport-store-dungeons
	if dball_data.teleport_dungeon == 0 then
	elseif dball_data.teleport_dungeon == 1 then	-- Karate Studio
		player.py = 52
		player.px = 88
	elseif dball_data.teleport_dungeon == 2 then	-- Kung Fu Studio
		player.py = 54
		player.px = 108
	elseif dball_data.teleport_dungeon == 3 then	-- Kickboxing Studio
		player.py = 54
		player.px = 90
	elseif dball_data.teleport_dungeon == 4 then	-- TKD Studio
		player.py = 28
		player.px = 17
	elseif dball_data.teleport_dungeon == 5 then	-- Ninja Duel
	elseif dball_data.teleport_dungeon == 6 then	-- Reserved for Ballet
		player.py = 36
		player.px = 111
	elseif dball_data.teleport_dungeon == 7 then	-- Sumo School
		player.py = 55
		player.px = 102
	elseif dball_data.teleport_dungeon == 8 then	-- Judo School
		player.py = 55
		player.px = 96
	elseif dball_data.teleport_dungeon == 9 then	-- Sushi Bar
		player.py = 45
		player.px = 137
	elseif dball_data.teleport_dungeon == 10 then	-- Fencing School
		player.py = 52
		player.px = 110
	elseif dball_data.teleport_dungeon == 11 then	-- Charleton's Shooting Range / Gun Store
		player.py = 56
		player.px = 85
	elseif dball_data.teleport_dungeon == 12 then	-- Foot Lair, Shredder escort
		player.py = 18
		player.px = 170

	elseif dball_data.teleport_dungeon == 100 then	-- North Kaio's planet
		player.py = 32
		player.px = 111
	end
	dball_data.teleport_dungeon = 0

end)


hook(hook.OBJECT_VALUE, function(obj, value)
	-- Blueprint prices are based on the recipe
	if obj.flags[FLAG_TECHNO_PLANS] then
		local k_ptr = obj.flags[FLAG_TECHNO_PLANS]
		local item = k_info[k_ptr]
		value = 100 * (item.level)
	end

	-- HACK: Not sure how to affect price from
	-- ON_MAKE
	if has_flag(obj, FLAG_PRICE_MOD) then
		value = (value * 100) / obj.flags(FLAG_PRICE_MOD)
	end

	-- Akira gives discounts to Oolong's friends
	-- Not working
	if obj.tval == TV_SUSHI and dball_data.oolong_akira == 2 then
		value = value / 2
	end

	-- Modify values for tohit/dam/ac bonuses

	local net_bonus = 0
	if obj.to_h then
		net_bonus = net_bonus + obj.to_h
	end
	if obj.to_d then
		net_bonus = net_bonus + obj.to_d
	end
	if obj.to_a then
		net_bonus = net_bonus + obj.to_a
	end

	-- Modify for ego's
	if has_flag(obj, FLAG_DBT_EGO_VALUE) then
		net_bonus = net_bonus + obj.flags[FLAG_DBT_EGO_VALUE]
	end

	if net_bonus > 0 then
		value = value + ((value * net_bonus) / 10)
	elseif net_bonus < 0 then
		value = value + ((value * net_bonus) / 20)
	end
	return true, value
end)

-- Deal with Wield issues:
-- 1) With two wield slots, default ToME MUST2H handling no longer works. Make my own.
-- 2) Disallow wields for weapon types players lack abilities for
hook(hook.WIELD_PRE, function (obj)
	-- Encapsulated items cannot be wielded
	if dball.capsuled(obj) then
		message("You must remove it from the capsule first.")
		return true, false
	end

	-- Wield limitations while riding
	if obj.flags[FLAG_WIELD_SLOT] and obj.flags[FLAG_WIELD_SLOT] == INVEN_WIELD then
		if player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_KINTO_UN] ~= true then
			if obj.flags[FLAG_MUST2H] then
				message("You must keep at least one hand free while piloting/riding a vehicle.")
				return true, false
			elseif player.inventory[INVEN_WIELD][1] then
				message("You must keep at least one hand free while piloting/riding a vehicle.")
				return true, false
			end
		end
	end
		
	-- If it has a Tech requirement, disallow as necessary
	if obj.flags[FLAG_TECH_REQUIRE] and get_skill(SKILL_TECHNOLOGY) < obj.flags[FLAG_TECH_REQUIRE] then
		message("You're not technically savvy enough to use this.")
		return true, false
	end

	-- Don't allow MUST2H weapons to equip if either/both hands are in use
	if obj.flags[FLAG_MUST2H] then
		if player.inventory[INVEN_WIELD][1] or player.inventory[INVEN_WIELD][2] then
			message("You must have both hands free before you can equip this.")
			return true, false
		end
	end
	-- Don't allow anything to equip to the second hand if a MUST2H weapon is in the first hand
	-- ...if I do this correctly, MUST2H weapons will never make it into the second slot...
	if obj.flags[FLAG_WIELD_SLOT] == INVEN_WIELD then
		if player.inventory[INVEN_WIELD][1] and player.inventory[INVEN_WIELD][1].flags[FLAG_MUST2H] then
			message("Both of your hands are already full!")
			return true, false
		end
	end

	-----------------------------------------------------------
	-- Now, deal with special DBT thematic combat ability rules
	-----------------------------------------------------------

	-- If what we're trying to equip is a weapon
	if obj.flags[FLAG_DAM] and not has_flag(obj, FLAG_MAGLIGHT) then
		-- And if we lack the paired weapon ability
		if not has_ability(AB_PAIRED_WEAPONS) then
			-- If either hand has a weapon, then disallow wield
			for i = 1,2 do
				if player.inventory[INVEN_WIELD][i] and player.inventory[INVEN_WIELD][i].flags[FLAG_DAM] then
					message("You haven't learned how to fight florentine (with two weapons)")
					return true, false
				end
			end
		end
	end

	-- If what we're trying to equip is a gun
	if obj.flags[FLAG_MISSILE_WEAPON] and not obj.flags[FLAG_TECHNOMANCE] then
		if get_skill(SKILL_MARKSMANSHIP) > 0 then
			-- And if we lack the paired gun ability
			if dball_data.ab_paired_firearm == 0 then
				-- If either hand has a gun, then disallow wield
				for i = 1,2 do
					if player.inventory[INVEN_WIELD][i] and player.inventory[INVEN_WIELD][i].flags[FLAG_MISSILE_WEAPON] then
						message("You haven't learned how to fight with two guns simultaneously.")
						return true, false
					end
				end
			end
		else
			message("You don't know how to use this, yet.")
			return true, false
		end
	end
		
end)

-- Dragonball T Monster Death stuff
hook(hook.MONSTER_DEATH, function(m_idx)
	local monst = monster(m_idx)
	local r_ptr = race_info(monst)

	-- Restore settings for uniques summoned to the tournament
	if race_info_idx(monst.r_idx, 0).max_num == 2 then
		race_info_idx(monst.r_idx, 0).max_num = 1
	end

	-- Note that this means the player may prematurely end duels
	-- by doing things like killing innocents
	-- This is probably reasonable, but may have side effects?
	dueling = 0 -- Reset all duels

	-- Mr Popo duel
	-- if monst.r_idx == RACE_MR_POPO and monst.flags[FLAG_FACTION] == FACTION_DUEL then
	if monst.r_idx == RACE_MR_POPO and monst.faction == FACTION_DUEL then
		dialogue.POPO_DUEL_OVER()
		-- Does this work as intended? Implement me!
		race_info_idx(RACE_MR_POPO, 0).max_num = race_info_idx(RACE_MR_POPO, 0).max_num + 1
		dball.place_monster(monst.fy, monst.fx, "Mr Popo", 0)

	elseif dball_data.tourny_now == 0 then
		-- Not really killing people in the Tournament

		-- Change Alignment when killing GOOD/EVIL monsters
		if (has_flag(r_ptr, FLAG_KARMA)) then
			dball.chalign(monst.flags[FLAG_KARMA])
		elseif (has_flag(r_ptr, FLAG_GOOD)) then
			dball.chalign(-monst.level)
		elseif (has_flag(r_ptr, FLAG_EVIL)) and dball_data.alignment > -99 then
			dball.chalign(monst.level)
		end
	elseif has_flag(monst, FLAG_NAMEKSEIJIN) then
		-- Kill a Namek, alienate all Nameks
		dball_data.namek_general_state = 999
	end
end)

-- Allow Spaceflight only to those with the abliity, or in a spaceship
hook(hook.KEYPRESS, function (key)
	if key == strbyte('<') then

		if dun_level == 0 then
			if player.wild_mode then
				-- Do nothing
			else
				if dball.player_flying() == true and dball_data.flying_high == 0 then
					message("You climb to greater altitude.")
					dball_data.flying_high = 1
					return true
				elseif player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_KINTO_UN] then
					message("Kinto Un can't fly any higher.")
					return true
				elseif (wizard) then
					message("You invoke wizard mode and fly up, up and away!")
				else
					if player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_VEHICLE_SPACESHIP] then
						-- Allow
					elseif dball_data.chi_flight_setting == 1 and dball_data.chi_aura_setting == 1 then
						message("You gather your aura around you and burst free from the atmosphere!")
					else
						message("You gaze longingly at the stars...")
						return true
					end
				end
			end
		end

		-- No level transitions while riding:
		if player.inventory[INVEN_VEHICLE][1] then
			if player.inventory[INVEN_VEHICLE][1].flags[FLAG_KINTO_UN] == true then
				-- Allow
			else
				message("You can't squeeze your vehicle through.")
				return true
			end
		end

		-- Every map transition means you have to shower again before bathing
		dball_data.showered = 0

		-- No leaving the WT during fights to the death
		if cave(player.py, player.px).feat == FEAT_LESS and dball_data.tourny_type_of_fight ~= 0 then
			message(color.YELLOW, "This fight is to the death!")
			return true
		end

		-- Isn't there a better place for this?
		dball_data.level_tracker = 1

		-- Reset rra cameras
		dball_data.rra_alarm_msg = 0

		-- Hack: Workaround for Serpent's Path Placement Problem:
		if cave(player.py, player.px).feat == FEAT_SERPENT_KAIO then
			dball.planetary_teleport_helper("Kaio via Serpent")
			return true
		elseif cave(player.py, player.px).feat == FEAT_SERPENT_EARTH then
			message(player.wilderness_y .. " : " .. player.wilderness_x)
			dball.planetary_teleport_helper("Earth via Serpent")
			message(player.wilderness_y .. " : " .. player.wilderness_x)
			return true
		end
	end
end)

hook(hook.KEYPRESS, function (key)
	if key == strbyte('>') then

		-- Return to near-ground flying
		if dball.player_flying() == true and dball_data.flying_high == 1 then
			if player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_CAPSULE_FLYER] ~= true then
				message("This aircraft is not suitable for low altitude flight.")
				return true
			else
				if player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_CAPSULE_FLYER] == true then
					message("You land.")
					dball_data.flying_high = 0
					return true
				else
					message("You drop to a lower altitude.")
					dball_data.flying_high = 0
					return true
				end
			end
		end

		-- No level transitions while riding:
		if player.inventory[INVEN_VEHICLE][1] and player.inventory[INVEN_VEHICLE][1].flags[FLAG_KINTO_UN] ~= true then
			message("You can't squeeze your vehicle through.")
			return true
		end

		-- No going back down once Blue's Cavern is submerging
		if dball_data.rra_blue_submerge == 1 and dball.current_location() == "Underwater Cavern" then
			message("The next level down is almost completely submerged.")
			return true
		end

		-- Every map transition means you have to shower again before bathing
		dball_data.showered = 0

		-- Other half of level tracker 
		dball_data.level_tracker = -1

		-- Reset rra cameras
		dball_data.rra_alarm_msg = 0
	end
end)

-- Refill/refuel: anything that takes batteries or fuel of any kind
hook(hook.KEYPRESS, function (key)
	if key == strbyte('F') then

	local ret, item = get_item("Recharge what?",
							   "You have nothing that requires batteries or fuel.",
							   USE_INVEN | USE_EQUIP | USE_FLOOR,
							   function(o)
								   return has_flag(o, FLAG_FUEL_REQUIRE)
							   end)
	if not ret or not item then return true end

	local zqy_recharge_me = get_object(item)
	local zqy_recharge_with = zqy_recharge_me.flags[FLAG_FUEL_REQUIRE]

	local ret, item2 = get_item("With what?",
							   "You have nothing to recharge that with.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
								   return has_flag(o, %zqy_recharge_with)
							   end)
	if not ret or not item2 then return true end

	item_increase(item2, -1)
	item_describe(item2)
	item_optimize(item2)
	zqy_recharge_me.flags[FLAG_FUEL] = zqy_recharge_me.flags[FLAG_FUEL_CAPACITY]

	message("Recharged!")

	return true
	end
end)

-- The various Dragonball Death clauses
-- (Could stand to be cleaned a bit)
hook(hook.PLAYER_TAKE_HIT, function(value, modif)
	if value + modif >= 0 then return end

	-- This shouldn't be neccessary!
	if dball_data.death_dialogue ~= 0 then
		return true, true
	end


	-- World Tournament
	if dball_data.tourny_now == 1 then
		if dball_data.win_world_tournament > 0 then
			-- Wait...what? If we've won the tournament, how can we be in a round?
			-- What is this for?
			message("You take a solid blow to the stomache, and reel forward...")
			message("hitting the top of your head on your opponents chin as you do,")
			message("knocking them unconscious.")
			message("Implement path")
		else
			term.save()
			term.clear()
			message("You reel from that last blow, and everything goes dark!")
			message("You've lost the match, and have been eliminated from the Tournament.")
			dball.tourny_disqualify() -- Implement checking for 'to the death' matches
			dball_data.tourny_now = 0
			dball_data.tourny_registered = 2 -- Defeated in combat
			teleport_player_to(21, 10)
			term.load() 
			message("The EMT says 'Wow! That was so cool! You almost died! Isn't that great!?!?")
			return true, true
		end
	elseif dball_data.popo_fight_now == 1 then
		-- Mr. Popo does not kill duelers
		term.save()
		term.clear()
		term.text_out(color.YELLOW, "You reel from that last blow, and everything goes dark!\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.YELLOW, "When you come to, you are lying on your back and Mr. Popo is kneeling beside you.\n\n")
		term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
		term.text_out("You are weak. No see Kami.\n\n")
		dialogue.conclude()
		term.load()
		dialogue.POPO_DUEL_OFF()
		return true, true
	end

	-- Dr. Gero capture
	-- Incidentally, is this really how we want to handle this? As is
	-- I think capture occurs if you die ANYWHERE in the entire gero dungeon,
	-- not just his lab/lair. Is that what we want?
	if d_info[current_dungeon_idx + 1].name and d_info[current_dungeon_idx + 1].name == "Dr. Gero's Lab" then
		if drgero.capture == 1 then
			drgero.unannoy()
			term.save()
			term.clear()
			message(color.YELLOW, "You are struck hard and everything goes black!")
			term.load()
			-- This is a problem! If Gero activates the remote stop device, it issues a damage
			-- call...but we're still in one right now...thus problem. Hmm. Solution?
			dialogue.GERO_REMOTE_STOP()
			return true, true
		end
	end

	-- Are we immortal? Can we become a spirit? Is this a PERMA death?
	if dball_data.alive == 0 then
		if dball_data.immortality == 1 then
			-- Basically what I'm going for here is that immortal players can't die,
			-- but the game might become not-fun if they not-die too many times.
			-- Eventually the penalties would probably also make it impractical
			-- to defeat any of the end game uniques.
			message(color.LIGHT_RED, "You are heavily damaged, and your body crumbles.")
			dball_data.mod_strength = dball_data.mod_strength - 1
			dball_data.mod_intelligence = dball_data.mod_intelligence - 1
			dball_data.mod_willpower = dball_data.mod_willpower - 1
			dball_data.mod_dexterity = dball_data.mod_dexterity - 1
			dball_data.mod_constitution = dball_data.mod_constitution - 1
			dball_data.mod_charisma = dball_data.mod_charisma - 1
			dball_data.mod_speed = dball_data.mod_speed - 1
			dball.drop_everything()
			message(color.YELLOW, "But you are immortal, and cannot die!")
			dball.cure_cond()
			-- Note also, they don't get auto healed, so the non-death from
			-- immortality is liable to occur several times 'at a time.'
			-- player.chp(player.mhp())
			player.calc_bonuses()
			player.redraw[FLAG_PR_BASIC] = true
			-- player.window = player.window | PW_PLAYER
			return true, true

		-- Rulechange: Kami will intervene once for
		-- ANY player who has releaed Piccolo.
		-- elseif dball_data.piccolo_hurt_player > 0 and dball.how_many_exist(RACE_DEMON_KING_PICCOLO) and dball_data.kami_rescued_player == 0 then
		elseif dball_data.piccolo_state == 1 and dball_data.kami_rescued_player == 0 then

			message(color.RED, "You feel your body crumple, and everything turns dark.")

			current_dungeon_idx = DUNGEON_KARIN
			dun_level = 5
			player.leaving = true

			if dball_data.alignment > 99 then
				dball_data.alive = 4
			elseif dball_data.alignment < 0 then
				dball_data.alive = 3
			else
				dball_data.alive = 2
			end

			-- dball_data.death_dialogue = FLAG_DEATH_KAMI_RESCUE -- Why doesn't this work?
			dball_data.death_dialogue = 1

			-- Go easy on the usual death routine when Kami intervenes
			-- dball_data.mod_willpower = dball_data.mod_willpower - 1
			-- dball.drop_everything()
			-- dball.reward(create_object(TV_PARCHMENT, SV_RECENTLY_DECEASED))

			dball_data.times_died = dball_data.times_died + 1
				dball.cure_cond()
				player.calc_bonuses()
				player.calc_hitpoints()
				counter.state(counter.LIFE, "silent", true)
				-- player.chp(player.mhp())
				player.redraw[FLAG_PR_BASIC] = true
			return true, true


		elseif player.lev > 24 then
			message(color.RED, "You die.")

			dialogue.DCD_POST_DEATH()

			dball.drop_everything()
			dball.reward(create_object(TV_PARCHMENT, SV_RECENTLY_DECEASED))

			-- message(color.YELLOW, "Your spirit refuses to let death stop you!")

			if dball_data.alignment > 99 then
				dball_data.alive = 4
				dball.dungeon_teleport("Heaven")
			elseif dball_data.alignment < 0 then
				dball_data.alive = 3
				dball.dungeon_teleport("Hell")
			else
				-- Teleport to Emma Daio
				-- player.py = 20
				-- player.px = 50
				dball_data.alive = 2
				-- This does NOT account for people who walk the Serpent's Path
				-- and talk to Daio the first time while alive!
				if dball_data.emma_state == 0 then
					dball_data.emma_state = 2
				else
					dball_data.emma_state = 3
				end
				dball.dungeon_teleport("The Serpent's Path")
			end

			dball_data.mod_willpower = dball_data.mod_willpower - 1
			dball_data.times_died = dball_data.times_died + 1
				dball.cure_cond()
				player.calc_bonuses()
				player.calc_hitpoints()
				counter.state(counter.LIFE, "silent", true)
				player.chp(player.mhp())
				player.redraw[FLAG_PR_BASIC] = true
			return true, true
		end
	else
		-- Already a spirit. This is PERMA-death
	end

end)

-- The various post-death comic dialogues
-- These are here because they need to excute after the 'you die' message
hook(hook.DIE_PRE, function()
	dialogue.DCD_POST_DEATH()
	dialogue.PILAF_EXECUTE()
end)

-----------------------------------
-- Traps
-----------------------------------

-- Traps
hook(hook.TRAP_TRIP_PRE, function(trap, who, y, x, obj)
	if who == 0 then
		if dball_data.alive ~= 0 then
			return false
		elseif dball.player_flying() == true then
			return false
		end
	end
end)

-----------------------------------
--
-----------------------------------
