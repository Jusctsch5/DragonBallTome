-- Dragonball T: Tools handler

constant("dbtools", {})

-- Probably don't need categories
-- dbtools.??? = {}

function dbtools.tech_check(obj)
	-- If it has a Tech requirement, disallow as necessary
	if obj.flags[FLAG_TECH_REQUIRE] and get_skill(SKILL_TECHNOLOGY) < obj.flags[FLAG_TECH_REQUIRE] then
		message("You're not technically savvy enough to use this.")
		return false
	else
		return true
	end
end

function dball.ttest(kidx)
	local obj = new_object()
	object_prep(obj, lookup_kind(TV_GOLD, rng(10,18)))
	set_flag(obj, FLAG_GOLD_VALUE, rng(50,200))
	drop_near(obj, -1, player.py, player.px)
--[[
 	local obj = new_object()
	object_prep(obj, kidx)
	obj.ego_id[1]  = DBTEGO_FURLINED
	apply_magic(obj, 1, true, nil, nil)
	make_item_fully_identified(obj)
	dball.reward(obj)
]]
end

function dbtools.use()

	-- Spirits cannot use items (What about Dragonballs?)
	--if dball_data.alive ~= 0 then
	--	message("You are a discarnate spirit. You cannot use items.")
	--	return
	--end

	-- Use of most devices during the World Tournament is
	-- grounds for disqualification
	local wtdisqualify = 0

	-- Get an item
	local ret, item = get_item("Use which item?",
							   "You don't have any useable devices or tools.",
							   USE_INVEN | USE_EQUIP,
							   function(o)
									if has_flag(o, FLAG_USEABLE) or dball.capsuled(o) or has_flag(o, FLAG_INTEGRATED_CAPSULE) then
										return true
									else
										return false
									end
							   end)
	if not ret or not item then return nil end

	-- Get the item (in the pack)
	local object = get_object(item)
	local what_it_does = object.flags[FLAG_USEABLE]
	local ret, raw_key, key

	-- local ident = false

	if not dbtools.tech_check(object) then
		return
	end

	-- If it's an integrated capsule-item, toggle its state
	if has_flag(object, FLAG_INTEGRATED_CAPSULE) then
		-- if in equipment, disallow
		if dball.capsuled(object) then
			if has_flag(object, FLAG_CAPSULE_BOAT) then
				if dball.player_adjacent_to_water() == true then
					near_water = true
				end
				if near_water == false then
					message("You must be near water.")
				end
			end


			ret, raw_key = get_com("Restore it from it's capsuled state? (y/n)")
			if not ret then
				return
			end

			key = strlower(strchar(raw_key))
			if key ~= "y" then
				return
			end
			message("You press the button and toss it to the ground.")
			object.flags[FLAG_CAPSULED] = false
			object.weight = object.flags[FLAG_CAPSULE_WEIGHT]
			-- drop_near(obj, -1, player.py, player.px)
			inven_drop(item, 100, player.py, player.px, false)
		else
			message("You restore it to it's capsuled state.")
			object.flags[FLAG_CAPSULED] = true
			object.flags[FLAG_CAPSULE_WEIGHT] = object.weight
			object.weight = 1

		end
		return

	-- If it's in a capsule, query to remove
	elseif dball.capsuled(object) then
		ret, raw_key = get_com("Remove it from the capsule? (y/n)")
		if not ret then
			return
		end

		key = strlower(strchar(raw_key))
		if key ~= "y" then
			return
		end

		-- Handle encapsulated water
		if has_flag(object, FLAG_STORED_WATER) then
			local dbfeat = FEAT_SHAL_WATER
			if has_flag(object, FLAG_ITEM_NAMEK) then
				dbfeat = FEAT_NAMEK_WATER
			end
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
			if cave(player.py, player.px).feat == FEAT_NAMEK_EMPTY_WELL then
				cave_set_feat(player.py, player.px, FEAT_NAMEK_WELL)
				if quest(QUEST_NAMEK_WATER).status == QUEST_STATUS_TAKEN then
					change_quest_status(QUEST_NAMEK_WATER, QUEST_STATUS_COMPLETED)
				end
			elseif cave(player.py, player.px).feat == FEAT_NAMEK_WELL then
				message("You add more water to the well.")
			else
				message("Water pours out from the capsule")
			end
			cave_set_feat(player.py, player.px, dbfeat)
			local obj_cap = create_object(TV_CAPSULE, SV_CAPSULE_CAPSULE)
			make_item_fully_identified(obj_cap)
			dball.reward(obj_cap)
			return
		end

		object.flags[FLAG_CAPSULED] = false
		object.weight = object.flags[FLAG_CAPSULE_WEIGHT]
		local obj_cap = create_object(TV_CAPSULE, SV_CAPSULE_CAPSULE)
		make_item_fully_identified(obj_cap)
		dball.reward(obj_cap)

		return
	end

	-- Do we need fuel/charge? If so, have we?
	if has_flag(object, FLAG_FUEL) and object.flags[FLAG_FUEL] == 0 then
		message("It is out of charge.")
		return
	end

	if what_it_does == 1 then		-- Capsule
		-- Does the player want to store water?
		if cave(player.py, player.px).feat == FEAT_SHAL_WATER or 
		  cave(player.py, player.px).feat == FEAT_DROWNING_WATER or 
		    cave(player.py, player.px).feat == FEAT_DEEP_WATER or 
		     cave(player.py, player.px).feat == FEAT_NAMEK_WATER then

			ret, raw_key = get_com("Fill the capsule with water? (y/n)")
			if not ret then
				return
			end

			key = strlower(strchar(raw_key))
			if key == "y" then
				-- make water
				local obj_water = new_object()
				if cave(player.py, player.px) == FEAT_NAMEK_WATER then
					 obj_water = create_object(TV_MISC, SV_NAMEK_WATER)
				else
					 obj_water = create_object(TV_MISC, SV_EARTH_WATER)
				end
				obj_water.flags[FLAG_CAPSULED] = true
				obj_water.flags[FLAG_CAPSULE_WEIGHT] = obj_water.weight
				obj_water.weight = 1
				make_item_fully_identified(obj_water)
				-- remove the capsule
				item_increase(item, -1)
				item_describe(item)
				item_optimize(item)
				-- give the capsuled water to the player
				dball.reward(obj_water)
				-- if the water is not an ocean, make it go away
				-- this should really check adjacent terrain
				if dun_level ~= 0 then
					
				end
				return
			end
		end

		-- Otherwise, get an item
		local ret, item2 = get_item("Store which item?",
							   "You have nothing to store.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if (dball.capsuled(o) == false) and (o.tval ~= TV_CAPSULE) then
										-- message("True")
										return true
									else
										return false
									end
							   end)
		if not ret or not item2 then return nil end

		-- Get it
		local object2 = get_object(item2)

		if object2.number > 1 then
			message("Only single items may be placed in capsules")
		else
			message("Item has been encapsulated!")
			object2.flags[FLAG_CAPSULED] = true
			object2.flags[FLAG_CAPSULE_WEIGHT] = object2.weight
			object2.weight = 1
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
		end

	elseif what_it_does == 2 then		-- Ballistic Plate
		-- Get an item
		local ret, item2 = get_item("Install into which ballistic armor?",
							   "You have no suitable armors to put this in.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_BALLISTIC_PLATED) and o.flags[FLAG_BALLISTIC_PLATED] == 1 then
										return true
									else
										return false
									end
							   end)
		if not ret or not item2 then return nil end

		-- Get it
		local object2 = get_object(item2)

		if object2.number > 1 then
			message("Isolate item for 'u'se command, please, no stacking.")
		else
			message("Ballistic plate installed!")
			object2.weight = object2.weight + 200
			object2.ac = object2.ac + 10
			object2.to_h = object2.to_h - 10
			object2.flags[FLAG_RESIST][dam.BALLISTIC] = object2.flags[FLAG_RESIST][dam.BALLISTIC] + 10
			object2.flags[FLAG_RESIST][dam.SHARDS] = object2.flags[FLAG_RESIST][dam.SHARDS] + 10
			object2.flags[FLAG_BALLISTIC_PLATED] = 2
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
		end
	elseif what_it_does == 3 then		-- Silencer
		-- Get an item
		local ret, item2 = get_item("Attach to which gun?",
							   "You have no suitable guns to mount this on.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_SILENCED) and o.flags[FLAG_SILENCED] == 1 then
										return true
									else
										return false
									end
							   end)
		if not ret or not item2 then return nil end

		-- Get it
		local object2 = get_object(item2)

		if object2.number > 1 then
			message("Isolate item for 'u'se command, please, no stacking.")
		else
			message("Silencer mounted!")
			object2.weight = object2.weight + 20
			object2.flags[FLAG_SILENCED] = 2
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
		end
	elseif what_it_does == 4 then		-- Scope
		-- Get an item
		local ret, item2 = get_item("Attach to which gun?",
							   "You have no suitable guns to mount this on.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_SCOPABLE) and o.flags[FLAG_SCOPABLE] == 1 then
										return true
									else
										return false
									end
							   end)
		if not ret or not item2 then return nil end

		-- Get it
		local object2 = get_object(item2)

		if object2.number > 1 then
			message("Isolate item for 'u'se command, please, no stacking.")
		else
			message("Scope mounted!")
			object2.weight = object2.weight + 5
			object2.flags[FLAG_SCOPABLE] = 2
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
		end
	elseif what_it_does == 5 then		-- Any firearm that may toggle beam/spray modes
			if object.flags[FLAG_AMMO_AOE] == FLAG_MISSILE_BOLT then
				object.flags[FLAG_AMMO_AOE] = FLAG_MISSILE_SPRAY
				object.flags[FLAG_AMMO_VOLLEY] = 5
				message("Weapon set to spray mode")
			elseif object.flags[FLAG_AMMO_AOE] == FLAG_MISSILE_SPRAY then
				object.flags[FLAG_AMMO_AOE] = FLAG_MISSILE_BEAM
				object.flags[FLAG_AMMO_VOLLEY] = 1
				message("Weapon set to burst mode")
			else
				message("Error: Unknown firearm setting")
			end
			energy_use = get_player_energy(SPEED_USE)	


	elseif what_it_does == 10 then	-- Acupuncture Needles
		wtdisqualify = 1
		if has_ability(AB_ACUPUNCTURE) then
			-- Heal everything except hp/sn/chi
			dball.cure_cond()
			set_aware(object)
			message("You feel rejuvenated! (Note: Acupuncture delay not implemented)")

			-- Can we just use a BUNCH of energy to get the delay we want?
			-- Try this:
			energy_use = 480
			-- energy_use = get_player_energy(SPEED_USE)
		elseif dball_data.learned_acupuncture == 1 then
			message("You're not entirely certain how to use these.")
			ret, raw_key = get_com("Try anyway? (y/n)")
			if not ret then
				return
			end

			key = strlower(strchar(raw_key))
			if key ~= "y" then
				return
			end

			if rng(1,100) < 50 then
				message("You feel a little better. (Note: Acupuncture delay not implemented)")
				timed_effect(timed_effect.BLIND, 0)
				timed_effect(timed_effect.CONFUSED, 0)
				timed_effect(timed_effect.CUT, 0)
				timed_effect(timed_effect.POISON, 0)
				timed_effect(timed_effect.STUN, 0)
				-- energy_use = get_player_energy(SPEED_USE)
				energy_use = get_player_energy(480)
			else
				message("Owww!")
				take_hit(rng(1,10), "misusing a set of acupuncture needles")
			end
		else
			message("You really have no clue how to use these. ")
			ret, raw_key = get_com("Try anyway? (y/n)")
			if not ret then
				return
			end

			key = strlower(strchar(raw_key))
			if key ~= "y" then
				return
			end

			message("Gaaaahhhh.....OUCH!")
			take_hit(rng(1,100), "self mutilation")
		end
	elseif what_it_does == 11 then	-- First Aid Kit
		if has_ability(AB_FIRST_AID) or get_skill(SKILL_TECHNOLOGY) >= 30 then
			wtdisqualify = 1
			local dur = timed_effect.get(timed_effect.CUT)
			if dur and dur > 0 then
				timed_effect(timed_effect.CUT, 0)
				-- message("You clean up any cuts and scrapes you have")
			else
				message("You are not bleeding")
			end
		else
			wtdisqualify = 1
			message("You fumble with the gauze, but don't really know what you're doing.")
		end
	elseif what_it_does == 12 then	-- Blood Coagulant
		if has_ability(AB_FIRST_AID) or get_skill(SKILL_TECHNOLOGY) >= 5 then
			local dur = timed_effect.get(timed_effect.CUT)
			if dur and dur > 0 then
				timed_effect(timed_effect.CUT, 0)
			else
				message("You are not bleeding")
			end
		else
			message("You try to apply the salve, but don't really know what you're doing.")
		end
		item_increase(item, -1)
		item_describe(item)
		item_optimize(item)
		wtdisqualify = 1

	elseif what_it_does == 13 then	-- Zheng Gu Shui
		-- timed_effect handling copy and pasted, not needful to do it this way, power is ignored for ZGS
		local dur = timed_effect.get(timed_effect.ZHENG)
		if dur and dur > 0 then
			timed_effect.inc(timed_effect.ZHENG, 10 + rng(10))
		else
			timed_effect.set(timed_effect.ZHENG, 10 + rng(10), 20)
		end
		item_increase(item, -1)
		item_describe(item)
		item_optimize(item)
		wtdisqualify = 1

	elseif what_it_does == 14 then	-- Zheng Gu Shui
		-- timed_effect handling copy and pasted, not needful to do it this way, power is ignored for ZGS
		local dur = timed_effect.get(timed_effect.BODY_OIL)
		if dur and dur > 0 then
			timed_effect.inc(timed_effect.BODY_OIL, 100 + rng(100))
		else
			timed_effect.set(timed_effect.BODY_OIL, 100 + rng(10), 20)
		end
		item_increase(item, -1)
		item_describe(item)
		item_optimize(item)
		wtdisqualify = 1

	elseif what_it_does == 20 then	-- Compass
		if player.inventory[INVEN_HEAD][1] and player.inventory[INVEN_HEAD][1].flags[FLAG_RYOGA] then
			message("That's strange. Weren't you here before?")
		elseif dball.am_i_on_earth() then
			message("You get your bearings")
			map_area(player.py, player.px, DEFAULT_RADIUS)
			-- map_area(player.py, player.px, 5)
		else
			message("You don't seem to be able to get a bearing.")
		end
	
	elseif what_it_does == 21 then	-- GPS
		if player.inventory[INVEN_HEAD][1] and player.inventory[INVEN_HEAD][1].flags[FLAG_RYOGA] then
			message("That's strange. Weren't you here before?")
		elseif dball.am_i_on_earth() then
			message("You check on your location via satellite.")
			message()
			-- wiz_lite(true)
			map_area(player.py, player.px, 200)
		else
			message("You're unable to connect to a sattelite.")
		end
	
	elseif what_it_does == 22 then	-- Cell Phone
		if dball.am_i_on_earth() then
			message("Cell Phone not implemented! (Might be a while)")
		else
			message("You're out of cell phone range.")
		end
	
	elseif what_it_does == 23 then	-- Flame Thrower
		if object.flags[FLAG_FUEL] == 0 then
			message("It is empty.")
			return
		end
		local ret, dir = get_rep_dir()
		if not ret then return end
		--local y, x = explode_dir(dir)
		--y, x = y + player.py, x + player.px

		local m_damage = rng(6, 36)

		fire_cone(dam.FIRE, dir, m_damage, 5)

		--local m_idx = cave(y,x).m_idx
		--if m_idx ~= 0 then
		--	local monst = monster(m_idx)
		--	if monst.ml then health_track(m_idx) end
		--end

		wtdisqualify = 1
	
	elseif what_it_does == 24 then	-- Laser Pointer
		local ret, dir = get_aim_dir()
		if not ret then return SPELL_NOTHING end

		fire_bolt(dam.LITE, dir, 0)
		wtdisqualify = 1

	-- Note: SCUBA Gear requries no activation
	-- Should we skip a useable number, just to be paranoid?

	elseif what_it_does == 25 then	-- Laptop
		if dball.am_i_on_earth() then
			message("You bring up google.")
			local throwaway = identify_fully()
			-- make_item_fully_identified(obj)
		else
			message("You can't find any wireless network to connect to.")
		end

	elseif what_it_does == 26 then	-- Denshi Jar (AKA Rice Cooker)
		-- Get an item
		local ret, item2 = get_item("Cook a batch from which bag?",
							   "You have no uncooked rice.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_WHITE_RICE) or has_flag(o, FLAG_BROWN_RICE) then
										return true
									else
										return false
									end
							   end)
		if not ret or not item2 then return nil end

		-- Get it
		local object2 = get_object(item2)
		if object2.weight > 1 then
			object2.weight = object2.weight - 1
			message("You cook a batch of rice.")
		else
			item_increase(item2, -1)
			-- item_describe(item2)
			item_optimize(item2)
			message("You cook the last of your rice.")
		end
		local obj_rice = new_object()
		if has_flag(object2, FLAG_WHITE_RICE) then
			object_prep(obj_rice, lookup_kind(TV_FOOD, SV_COOKED_WHITE_RICE))
		else
			object_prep(obj_rice, lookup_kind(TV_FOOD, SV_COOKED_BROWN_RICE))
		end
		make_item_fully_identified(obj_rice)
		dball.reward(obj_rice)

	elseif what_it_does == 27 then	-- Megaphone
		local ret, dir = get_rep_dir()
		if not ret then return end
		local y, x = explode_dir(dir)
		y, x = y + player.py, x + player.px

		local m_damage = rng(1, 6)

		message("You scream into the megaphone!")
		wtdisqualify = 1
		--aggravate_monsters(spell_caster)

		-- project cone? fire_cone?
		project(WHO_PLAYER, 0, y, x, m_damage, dam.SOUND, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)

		local m_idx = cave(y,x).m_idx
		if m_idx ~= 0 then
			local monst = monster(m_idx)
			if monst.ml then health_track(m_idx) end
		end

	elseif what_it_does == 28 then	-- Road Flare
		-- Wouldn't it be nicer if flares had to be dropped
		-- and only lit the area around them so long as they
		-- remained?
		message("You ignite the flare")
		fire_ball(dam.LITE, 0, 5, 1) -- <-- Doesn't work as intended. Monsters don't seem to blind
		fire_cloud(dam.PLITE, 0, 0, 5, 40, player.speed()) --Speed? What's that for?
		-- lite_area(rng.roll(2, 8), 2)
		item_increase(item, -1)
		item_describe(item)
		item_optimize(item)
		wtdisqualify = 1

	elseif what_it_does == 29 then	-- Fire Extinguisher
		if object.flags[FLAG_FUEL] == 0 then
			message("It is empty.")
			return
		end
		local ret, dir = get_rep_dir()
		if not ret then return end
		local y, x = explode_dir(dir)
		y, x = y + player.py, x + player.px

		local m_damage = rng(1, 6)

		project(WHO_PLAYER, 0, y, x, m_damage, dam.WATER, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)

		local m_idx = cave(y,x).m_idx
		if m_idx ~= 0 then
			local monst = monster(m_idx)
			if monst.ml then health_track(m_idx) end
		end

		wtdisqualify = 1
	elseif what_it_does == 30 then	-- Muscle Stimulator
			if dball_data.muscle_stimulator == 0 then
				term.save()
				term.text_out("You apply the stimulator to a set of muscles and turn it on. Instantly a steady, rythmic pulse of current is sent through your muscle, causing them to twitch slightly. It is a most curious sensation...your muscles contarcting and relaxing without you consciously telling them to. It is a slow process, but after some time, you feel ever so slightly stronger.\n\n")
				dialogue.conclude()
				term.load() 
				dball_data.muscle_stimulator = dball_data.muscle_stimulator + 1
			elseif dball_data.muscle_stimulator < player.lev then
				message("You feel ever so slightly stronger.")
				dball_data.muscle_stimulator = dball_data.muscle_stimulator + 1
			else
				message("You apply the stimulator, but don't feel like you're getting much benefit.")
			end
		wtdisqualify = 1

	elseif what_it_does == 31 then	-- poison
		wtdisqualify = 1	-- Big time! Maybe even create a new wt_lost category for this?
		-- Get an item
		local ret, item2 = get_item("Poison which weapon?",
							   "You have no bladed weapons to poison.",
							   USE_INVEN | USE_EQUIP | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_BLADED) then
										return true
									else
										return false
									end
							   end)
		if not ret or not item2 then return nil end

		-- Get it
		local object2 = get_object(item2)

		if object2.number > 1 then
			message("Only one blade may be poisoned at a time.")
		else
			message("...you pour poison across the blade...")
			object2.flags[FLAG_POISON_BLADE] = object2.flags[FLAG_POISON_BLADE] + 4 + rng(1, 3)
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
		end
	elseif what_it_does == 32 then	-- Widgets!
		if rng(1, 10) < 2 then
			message("You play with your widget...and it breaks!!! Oh no! You'd better go buy a new one right away!")
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
		else
			monster_random_say
			{
				"You play with the widget. You feel happy.",
				"You spend some time marveling at the widget.",
				"Maybe it's time you bought a new widget?",
				"When you think about your widget, you feel less empty inside.",
				"It is such a beautiful color, isn't it?",
				"You play with your widget. You feel very important for owning a widget.",
				"You proudly admire your widget. Feelings of power and joy rush through you.",
				"You love your widget. But curiosly, you feel the need to have more of them.",
			}
		end
	elseif what_it_does == 33 then	-- Blowtorch
		if object.flags[FLAG_FUEL] == 0 then
			message("It is empty.")
			return
		end
		local ret, dir = get_rep_dir()
		if not ret then return end
		local y, x = explode_dir(dir)
		y, x = y + player.py, x + player.px

		local m_damage = rng(1, 6)

		project(WHO_PLAYER, 0, y, x, m_damage, dam.FIRE, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)

		local m_idx = cave(y,x).m_idx
		if m_idx ~= 0 then
			local monst = monster(m_idx)
			if monst.ml then health_track(m_idx) end
		end

		if cave(y, x).feat == FEAT_DOOR or cave(y, x).feat == FEAT_DOOR_LOCKED_HEAD or cave(y, x).feat == FEAT_DOOR_LOCKED_HEAD+6 then
			message("You burn through the handle")
			cave_set_feat(y, x, FEAT_BROKEN)
		end

		wtdisqualify = 1

	elseif what_it_does == 34 then	-- Scouter
			local ret, dir, x, y, c_ptr
			ret, x, y = tgt_pt()
			if not ret then
				return
			end

			c_ptr = cave(y, x)
			if c_ptr.m_idx > 0 then
				local m_idx = cave(y,x).m_idx
				if m_idx ~= 0 then
					local monst = monster(m_idx)
					local r_ptr = r_info[monst.r_idx + 1]
					local mem_entry = memory.get_entry(r_ptr, 0)
					if r_ptr.r_sights == 0 then
						r_ptr.r_sights = 1
					end

					local mem_entry = memory.get_entry(r_ptr, 0)
					mem_entry.knowall = 1

					term.save()
					local old_screen = term.save_to()

					term.gotoxy(1, 0)
					memory.main(r_ptr, 0)

					term.inkey()

					term.load_from(old_screen, true)
					term.load()
					if monst.ml then health_track(m_idx) end
				end
			else
				message("There is no creature there")
			end

	elseif what_it_does == 35 then	-- Jackhammer
		message("Implement me!")
--[[
		if object.flags[FLAG_FUEL] == 0 then
			message("It is empty.")
			return
		end
		local ret, dir = get_rep_dir()
		if not ret then return end
		local y, x = explode_dir(dir)
		y, x = y + player.py, x + player.px

		local m_damage = rng(1, 6)

		project(WHO_PLAYER, 0, y, x, m_damage, dam.FIRE, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)

		local m_idx = cave(y,x).m_idx
		if m_idx ~= 0 then
			local monst = monster(m_idx)
			if monst.ml then health_track(m_idx) end
		end

		if cave(y, x).feat == FEAT_DOOR or cave(y, x).feat == FEAT_DOOR_LOCKED_HEAD or cave(y, x).feat == FEAT_DOOR_LOCKED_HEAD+6 then
			message("You burn through the handle")
			cave_set_feat(y, x, FEAT_BROKEN)
		end

		wtdisqualify = 1
]]
	elseif what_it_does == 36 then	-- Remote Stop Device
		local did_we_destroy = false
		for i = -1, 1 do
			for j = -1, 1 do
				local m_idx = cave(player.py + i, player.px + j).m_idx
				if m_idx ~= 0 then
					local monst = monster(m_idx)
					if monst.flags[FLAG_REMOTE_DESTROY] then
						if monst.flags[FLAG_UNIQUE] then
							local r_ptr = r_info[monst.r_idx + 1]
							race_info_idx(r_ptr, 0).max_num = 0
						end
						local m_name = monster_desc(monst, 0)
						message(color.YELLOW, m_name .. " explodes in a ball of fury!")
						delete_monster_idx(m_idx)
						did_we_destroy = true
					end
				end
			end
		end
		if did_we_destroy == false then
			message("Nothing happens")
		end

	elseif what_it_does == 37 then	-- Ajasa seed
		local c_feat = cave(player.py, player.px).feat

		if dball_data.namek_ajasa_state ~= -1 then
			term.save()
			term.text_out(color.GREEN, "Due ")
			term.text_out("to rather hackish code, it is only possible to plant one ajasa seed. This will probably be remedied at a later date.")
			dialogue.conclude()
			term.load()
		elseif c_feat == FEAT_NAMEK_GROUND then
			if (player.wilderness_y == 13 and player.wilderness_x == 15) then
				dball_data.namek_ajasa_state = 10000
				dball_data.namek_ajasa_y = player.py
				dball_data.namek_ajasa_x = player.px
			else
				term.save()
				term.text_out(color.GREEN, "At ")
				term.text_out("present it is only possible to plant ajasa seeds in locations that count for quest completion. This is not a suitable location. The planting code will likely be refined at a later date.")
				dialogue.conclude()
				term.load()
			end
		elseif c_feat == FEAT_DIRT then
			message("Planting ajasa on earth has not been implemented.")
		else
			message("The ground here is not suitable for planting.")
		end
		energy_use = get_player_energy(SPEED_USE)	

	elseif what_it_does == 38 then	-- Television Remote Control
		-- Remote uses energy no matter what
		energy_use = get_player_energy(SPEED_USE)	
		if dball.current_location() == "Kame House" then
			if dball_data.rosshi_state == 0 then
				dialogue.ROSSHI("television")
			else
				message("It would be best not to antagonize Rosshi further.")
			end
		else
			message("You play with the controls, but nothing happens.")
		end

		message("Implement me!")

	elseif what_it_does == 100 then	-- Nyoi-bo
		-- Nyoi-bo uses energy no matter what
		energy_use = get_player_energy(SPEED_USE)	

		if cave(player.py, player.px).feat == FEAT_RECEPTACLE then
			message("You insert the Nyoi-bo and command it to extend to the platform above you.")
			for i = 46, 3, -1 do
				cave_set_feat(i, 53, FEAT_NYOIBO)
			end
			change_quest_status(QUEST_CURIOUS_HOLE, QUEST_STATUS_FINISHED)
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
		else

			local ret, dir, x, y, c_ptr
			ret, x, y = tgt_pt()
			if not ret then
				return
			end

			c_ptr = cave(y, x)
			if c_ptr.m_idx > 0 then
				message("You thwap it with the Nyoi-bo!")
				local nyoi_dam = 5

				-- Why does none of this work?
				-- set_get_aim_dir(y, x)
				-- ret, dir = get_aim_dir()
				-- unset_get_aim_dir()
				target_col = x
				target_row = y
				dir = 5

				--message("Thwapping monster doesn't work yet, but here's some coords for you: y:x = ")
				--message(y .. ":" .. x)

				-- See engine: utility spell functions:
				fire_bolt(dam.CRUSH, dir, nyoi_dam)
			else
				-- Can't vault in space
				if player.wild_mode then
					message("Extend the Nyoi-bo and then retract it again")

				-- Low ceilings in dungeons limit vaulting range
				elseif dun_level ~= 0 then
					local too_far = 0
					if x > player.px + 2 then too_far = 1 end
					if y > player.py + 2 then too_far = 1 end
					if x < player.px - 2 then too_far = 1 end
					if y < player.py - 2 then too_far = 1 end

					if too_far == 1 then
						message("The low ceiling prevents you from vaulting that far")
					else
						if not los(player.px, player.py, x, y) then
							message("No clear path.")
							return
						end
						local oy, ox = player.py, player.px
						teleport_player_to(y, x)
						if oy == player.py and ox == player.ox then
								message("You extend the Nyoi-bo and then retract it again")
						else
							message("You extend the Nyoi-bo and vault over!")
						end
					end

				else
					local falling_damage = (5 * (abs(player.px - x) + abs(player.py - y))) - 10
					local oy, ox = player.py, player.px
					teleport_player_to(y, x)
					if oy == player.py and ox == player.ox then
						message("You extend the Nyoi-bo and then retract it again")
					else
						message("You extend the Nyoi-bo and vault over!")
						if falling_damage > 0 then
							message("You hit the ground hard.")
							take_hit(falling_damage, "overly ambitious vaulting")
						end
					end
				end
			end
		end
	elseif what_it_does == 101 then	-- The Ruby Slippers
		message("There's no place like home...")
		message("There's no place like home...")
		message("There's no place like home!")
		if player.inventory[INVEN_HEAD][1] and player.inventory[INVEN_HEAD][1].flags[FLAG_RYOGA] then
			message("That's strange. Are you home yet? You can't tell.")
		elseif not dball.planetary_teleport_helper("Earth") then
			message("Oh, wait. You're ALREADY home!")
		elseif player.chp() < player.mhp() / 3 then
			-- To prevent abuse...
			dialogue.BALANCE_GOD()
			-- Remove it. <pout>
			for_inventory(player, INVEN_INVEN, INVEN_TOTAL,
				function(obj, i, j, item)
					if has_flag(obj, FLAG_GAME_BALANCE) then
						item_increase(item, -99)
						item_describe(item)
						item_optimize(item)
					end
				end)
		end
	elseif what_it_does == 102 then	-- Uranai Baba's Crystal Ball
		-- Ryoga?
		message("As you gaze into the crystal ball, secrets are revealed to you.")
		do_res_stat(A_WIL, true)
		do_res_stat(A_INT, true)
		do_res_stat(A_CHR, true)
		identify_fully()
		wiz_lite(true)
		-- Implement display update for stat restore

	elseif what_it_does == 103 then	-- The Rice Cooker in which Piccolo is contained
		if dball_data.piccolo_state == 0 then
			dialogue.PICCOLO_INCEPTION()
		else
			message("Haven't you caused enough trouble?")
			-- item_increase(item, -1)
			-- item_describe(item)
			-- item_optimize(item)
		end

	elseif what_it_does == 200 then	-- Mechanical Toolkit
		ret, raw_key = get_com("Build, dismantle, enhance or view recipe? (b/d/e/v)")
		if not ret then
			return
		end

		key = strlower(strchar(raw_key))
		if key == "b" then
			technomancy.interface_to_build(1)
			return
		elseif key == "v" then
			technomancy.show_known_recipes(1)
			return
		elseif key == "e" then
			technomancy.interface_to_enhance(1)
			return
		elseif key == "d" then
			-- Get an item
			local ret, item2 = get_item("Dismantle what?",
							   "You have nothing that can be dismantled with this tool.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if (has_flag(o, FLAG_DISCIPLINE) and o.flags[FLAG_DISCIPLINE] == 1) or has_flag(o, FLAG_WIDGET) then
										return true
									else
										return false
									end
							   end)
			if not ret or not item2 then return nil end

			local object2 = get_object(item2)
			local kind = object2.k_idx

			if object2.flags[FLAG_CAPSULED] == true then
				message("Remove it from the capsule first.")
			elseif has_flag(object2, FLAG_WIDGET) then
				message("You tinker with it extensively.")
			else
				technomancy.dismantle(item2, kind)
			end
		else
			return
		end

	elseif what_it_does == 201 then	-- Electrical Toolkit
		ret, raw_key = get_com("Build, dismantle, enhance or view recipes? (b/d/e/v)")
		if not ret then
			return
		end

		key = strlower(strchar(raw_key))
		if key == "b" then
			technomancy.interface_to_build(2)
			return
		elseif key == "v" then
			technomancy.show_known_recipes(2)
			return
		elseif key == "e" then
			technomancy.interface_to_enhance(2)
			return
		elseif key == "d" then
			-- Get an item
			local ret, item2 = get_item("Dismantle what?",
							   "You have nothing that can be dismantled with this tool.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if (has_flag(o, FLAG_DISCIPLINE) and o.flags[FLAG_DISCIPLINE] == 2) or has_flag(o, FLAG_WIDGET) then
										return true
									else
										return false
									end
							   end)
			if not ret or not item2 then return nil end

			local object2 = get_object(item2)
			local kind = object2.k_idx

			if object2.flags[FLAG_CAPSULED] == true then
				message("Remove it from the capsule first.")
			else
				technomancy.dismantle(item2, kind)
			end
		else
			return
		end

	elseif what_it_does == 202 then	-- Chemistry Kit
		-- concoct/extract?
		ret, raw_key = get_com("Concoct, extract, or view recipes? (c/b/d/e/v)")
		if not ret then
			return
		end

		key = strlower(strchar(raw_key))
		if key == "b" then
			technomancy.interface_to_build(3)
			return
		elseif key == "v" then
			technomancy.show_known_recipes(3)
			return
-- Are there any chemistry enhance recipes?
--		elseif key == "e" then
--			technomancy.interface_to_enhance(3)
--			return
		elseif key == "d" or key == "e" then
			-- Get an item
			local ret, item2 = get_item("Extract from what?",
							   "You have no suitable complex chemicals to work with.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_DISCIPLINE) and o.flags[FLAG_DISCIPLINE] == 3 then
										return true
									else
										return false
									end
							   end)
			if not ret or not item2 then return nil end

			local object2 = get_object(item2)
			local kind = object2.k_idx

			if object2.flags[FLAG_CAPSULED] == true then
				message("Remove it from the capsule first.")
			else
				technomancy.dismantle(item2, kind)
			end
		else
			return
		end

	elseif what_it_does == 203 then	-- Lathe
		ret, raw_key = get_com("Build, dismantle, enhance or view recipes? (b/d/e/v)")
		if not ret then
			return
		end

		key = strlower(strchar(raw_key))
		if key == "b" then
			technomancy.interface_to_build(4)
			return
		elseif key == "v" then
			technomancy.show_known_recipes(4)
			return
		elseif key == "e" then
			technomancy.interface_to_enhance(4)
			return
		elseif key == "d" then
			-- Get an item
			local ret, item2 = get_item("Dismantle what?",
							   "You have nothing that can be dismantled with this tool.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_DISCIPLINE) and o.flags[FLAG_DISCIPLINE] == 4 then
										return true
									else
										return false
									end
							   end)
			if not ret or not item2 then return nil end

			local object2 = get_object(item2)
			local kind = object2.k_idx

			if object2.flags[FLAG_CAPSULED] == true then
				message("Remove it from the capsule first.")
			else
				technomancy.dismantle(item2, kind)
			end
		else
			return
		end

	elseif what_it_does == 204 then	-- Sewing kit
		local ret, item = get_item("Repair/reinforce which piece of clothing?",
						   "You have no suitable clothing",
						   USE_INVEN | USE_FLOOR,
						   function(o)
								if has_flag(o, FLAG_REINFORCEABLE) then
									return true
								else
									return false
								end
						   end)
		if not ret or not item then return nil end

		-- Use energy
		energy_use = get_player_energy(SPEED_USE)	

		-- Get the item (in the pack)
		local object = get_object(item)

		if object.number > 1 then
			message("Only one at a time, please.")
		else
			-- Perform the repair/reinforcement
			local r_max = 8 + (get_skill(SKILL_CONSTRUCTION) / 4)

			if object.to_a < r_max then
				object.to_a = object.to_a + 1
				player.calc_bonuses()
				if object.to_a < 1 then
					message("Repaired to +" .. object.to_a .. "!")
				else
					message("Reinforced to +" .. object.to_a .. "!")
				end
			else
				message("You don't think you could make this much better.")
			end
		end
	elseif what_it_does == 205 then	-- Scissors
		local ret, item = get_item("What would you like to cut?",
						   "You have no suitable to cut.",
						   USE_INVEN | USE_FLOOR,
						   function(o)
								if has_flag(o, FLAG_SCISSORABLE) then
									return true
								else
									return false
								end
						   end)
		if not ret or not item then return nil end

		-- Use energy
		energy_use = get_player_energy(SPEED_USE)	

		-- Get the item (in the pack)
		local object = get_object(item)

		local qty = object.weight * object.number

		item_increase(item, -1)
		item_describe(item)
		item_optimize(item)

		local obj_cloth = create_object(TV_MISC, SV_CLOTH)
		obj_cloth.number = qty
		make_item_fully_identified(obj_cloth)
		dball.reward(obj_cloth)

	elseif what_it_does == 999999 then	-- Playtest Device
		dialogue.PLAYTEST()
	elseif what_it_does == 300 then	-- The Dragonballs!!!
		local which, racename, whom, flagtocheck, dragon, secret
		if has_flag(object, FLAG_EARTH_DRAGONBALL) then
			which = "Earth"
			racename = RACE_KAMI
			whom = "Kami"
			flagtocheck = FLAG_EARTH_DRAGONBALL
			dragon = "Shenron"
			secret = "Dragonballs"
		else
			which = "Namek"
			racename = RACE_NAMEK_GREAT_ELDER
			whom = "The Great Elder"
			flagtocheck = FLAG_NAMEK_DRAGONBALL
			dragon = "Porunga"
			secret = "Namek Dragonballs"
		end

		-- Is the appropriate Namek alive?
		if race_info_idx(RACE_NAMEK_GREAT_ELDER, 0).max_num == 0 then
			message(whom .. " is dead. The " .. secret .. " have turned to stone.")
			return
		end

		local dball_count = 0
		-- Allow using dragonballs so long as you have seven of them
		for i = 1, player.inventory_limits(INVEN_INVEN) do
			local obj = player.inventory[INVEN_INVEN][i]
			if obj then
				if has_flag(obj, flagtocheck) then
					dball_count = dball_count + obj.number
				end
			end
		end
		if dball_count < 6 then
			message("You must have all seven dragonballs to summon " .. dragon)
			return
		end

		-- Must speak Namek to summon Porunga. :P
		if flagtocheck == FLAG_NAMEK_DRAGONBALL then
			if dball.party_with_flag(FLAG_NAMEKSEIJIN) < 1 then
				dialogue.NO_NAMEKS_DRAGONBALL()
				return
			end
		end

		-- Remove the dragonballs from inventory
		dball.dragonballs_deliver(flagtocheck)

		-- Mark them as available
		if flagtocheck == FLAG_EARTH_DRAGONBALL then
			for i = 1, 7 do
				earth_dragonballs[i] = 0
			end
			dialogue.SUMMON_SHENRON()
			dialogue.SHENRON()
		else
			for i = 1, 7 do
				namek_dragonballs[i] = 0
			end
			dialogue.SUMMON_PORUNGA()
			dialogue.PORUNGA()
		end

		-- And, oh...no fair summoning dragons during WT matches. :P
		wtdisqualify = 1
		-- No object, is dieing on the fuel check below
		return

	else
		message("Error: Item USEABLE flag unrecognized in tools.lua!")
	end

	-- Use energy
	energy_use = get_player_energy(SPEED_USE)	

	-- Reduce charge
	if has_flag(object, FLAG_FUEL) then
		object.flags[FLAG_FUEL] = object.flags[FLAG_FUEL] - 1
	end

	if wtdisqualify == 1 and dball_data.tourny_now == 1 then
		-- Note that the following function performs additional checks
		-- You can't be disqualified for illegal equipment use while
		-- fighting the Androids, for example
		if dball.tourny_disqualify() then
			message("You have been disqualified for illegal equipment use!")
			dball_data.tourny_registered = 4 -- Disqualified for equipment
		end
	end

	player.calc_bonuses()

	return
end

--[[
function dbtools.android_helper(oobj)
	if oobj.tval == TV_CORPSE then
		if oobj.sval == SV_CORPSE_CORPSE then
			local race = r_info[1 + get_flag(oobj, FLAG_MONSTER_IDX)]
			if has_flag(race, FLAG_ANDROID) then
				return true
			end
		end
	end
	return false
end
]]

-- Use
hook(hook.KEYPRESS, function (key)
	if key == strbyte('u') then dbtools.use() return true end
end)


