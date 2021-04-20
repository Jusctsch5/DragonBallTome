--
-- Informations for the various store actions
-- When action is a number it is an hardcoded action
--

new_store_action
{
	define_as = "store.ACTION_NONE"
	name = "Nothing"
	letter = '.'
	action = function() end
	action_restr = "all"
	costs = { 0, 0, 0 }
}

-- Capsule Corp 'about us'
new_store_action
{
	define_as = "store.ACTION_ABOUT"
	name = "About Us"
	letter = 'a'
	action = function()
			dialogue.CAPSULE_CORP()
		end
	action_restr = "all"
	costs = { 0, 0, 0 }
}

new_store_action
{
	define_as = "store.ACTION_TECH"
	name = "Technomancer"
	letter = 't'
	action = function()
			--if get_skill(SKILL_TECHNOLOGY) < 30 then
			--	message("You're not a Technomancer")
			--	return
			--end
			message("Implement me!")

		end
	action_restr = "all"
	costs = { 0, 0, 0 }
}

new_store_action
{
	define_as = "store.ACTION_EAT"
	name = "Eat"
	letter = 'e'
	action = function(store_info, info)
		if dball_data.alive ~= 0 then
			message("You are dead. You can't even salivate over the pizza you can't eat.")
			player.au = player.au + 5 -- storehack
		elseif player.au > 4 then
			if timed_effect.get(timed_effect.FOOD) < 15000 then
				message("You stuff yourself full of yummy pizza!")
				-- player.au = player.au - 5 storehack
				timed_effect(timed_effect.FOOD, 14999)
			else
				message("You couldn't eat another bite.")
			end
		else
			message("You haven't the zeni to buy pizza? How sad. :/")
		end
	end
	action_restr = "all"
	costs = { 5, 5, 5 }
}

new_store_action
{
	define_as = "store.ACTION_SHARPEN"
	name = "Sharpen Blade"
	letter = 's'
	action = function(store_info, info)
		if player.au > 99 then
			local ret, item = get_item("Have the swordsmith sharpen which blade?",
							   "You have no bladed weapons.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_BLADED) then
										return true
									else
										return false
									end
							   end)
			if not ret or not item then return nil end

			-- Get the item (in the pack)
			local object = get_object(item)

			if object.number > 1 then
				message("Only one at a time, please.")
			else
				-- Perform the sharpening
				if object.to_d < (player.lev + 4) / 5 then
					player.au = player.au - 100
					object.to_d = object.to_d + 1
					player.calc_bonuses()
					message("Sharpened to +" .. object.to_d .. "!")
				else
					message("I don't think you're quite skilled enough yet for a blade any sharper than that.")
				end
			end

		else
			message("You haven't enough zeni.")
		end
	end
	action_restr = "all"
	costs = { 100, 100, 100 }
}
new_store_action
{
	define_as = "store.ACTION_BALANCE"
	name = "Balance Blade"
	letter = 'b'
	action = function(store_info, info)
		if player.au > 99 then
			local ret, item = get_item("Have the swordsmith re-balance which blade?",
							   "You have no bladed weapons.",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_BLADED) then
										return true
									else
										return false
									end
							   end)
			if not ret or not item then return nil end

			-- Get the item (in the pack)
			local object = get_object(item)

			if object.number > 1 then
				message("Only one at a time, please.")
			else
				-- Re-balance the blade
				if object.to_h < (player.lev + 4) / 5 then
					player.au = player.au - 100
					object.to_h = object.to_h + 1
					player.calc_bonuses()
					message("Rebalanced to +" .. object.to_h .. "!")
				else
					message("I don't think you're quite skilled enough yet to benefit from a better blade.")
				end
			end

		else
			message("You haven't enough zeni.")
		end
	end
	action_restr = "all"
	costs = { 100, 100, 100 }
}
new_store_action
{
	define_as = "store.ACTION_REINFORCE"
	name = "Reinforce Armor"
	letter = 'r'
	action = function(store_info, info)
		if player.au > 999 then
			local ret, item = get_item("Have Joesephine repair/reinforce which armor?",
							   "You have no suitable armor",
							   USE_INVEN | USE_FLOOR,
							   function(o)
									if has_flag(o, FLAG_REINFORCEABLE) then
										return true
									else
										return false
									end
							   end)
			if not ret or not item then return nil end

			-- Get the item (in the pack)
			local object = get_object(item)

			if object.number > 1 then
				message("Only one at a time, please.")
			else
				-- Perform the repair/reinforcement
				if object.to_a < (player.lev + 4) / 5 then
					-- player.au = player.au - 1000
					object.to_a = object.to_a + 1
					player.calc_bonuses()
					if object.to_a < 1 then
						message("Repaired to +" .. object.to_a .. "!")
					else
						message("Reinforced to +" .. object.to_a .. "!")
					end
				else
					message("I really don't think you deserve to have that made any stronger yet.")
				end
			end

		else
			message("Haha! You can't afford it! Now you know what it's like!")
		end
	end
	action_restr = "all"
	costs = { 1000, 1000, 1000 }
}new_store_action
{
	define_as = "store.ACTION_PAY_FEE"
	name = "Pay Fee"
	letter = 'p'
	letter_aux = 'f'
	action = function(store_info, info)
		local dbtowner = (ow_info[store_info.owner+1].name)
		-- Hanger rental/Pilot's Club at the Airport
		if dbtowner == "Mike" then
			if player.au > 999 then
				-- player.au = player.au - 1000
				dball_data.hanger_rental = dball_data.hanger_rental + 1
				if quest(QUEST_PILOTMEMBER).status == QUEST_STATUS_UNTAKEN then
					dball_data.hanger_start_date = dball.dayofyear()
					message("Thank you! You are now a member. You can have hanger 18")
	 				change_quest_status(QUEST_PILOTMEMBER, QUEST_STATUS_TAKEN)
					player.regen_town()
				elseif quest(QUEST_PILOTMEMBER).status == QUEST_STATUS_TAKEN then
					message("Thank you! It's always a good idea to pay a little in advance.")
				elseif quest(QUEST_PILOTMEMBER).status == QUEST_STATUS_FAILED then
					message("Welcome back. I'm sorry, but everything you had in storage has already")
					message("gone to auction. In the future please be more prompt with your payments.")
	 				quest(QUEST_PILOTMEMBER).status = QUEST_STATUS_TAKEN
					player.regen_town()
				end
			else
				message("Sorry, we only take payments in increments of 1000zn.")
			end
		else	-- Paying from home
			if player.au > 999 then
				-- player.au = player.au - 1000
				dball_data.hanger_rental = dball_data.hanger_rental + 1
				message("You pay for 1000zn another day in advance.")
			else
				message("Sorry, the facility only accepts advance payments in 1000zn increments.")
			end
		end
	end
	action_restr = "all"
	costs = { 0, 0, 0 }
}
new_store_action
{
	define_as = "store.ACTION_HOTEL"
	name = "Stay in the Hotel"
	letter = 'h'
	action_restr = "all"
	costs = { 100, 100, 100 }
	action = function()
		if player.au < 100 then
			message("You haven't 100 zeni!")
			return
		end

		-- player.au = player.au - 100

		-- Must cure HP draining status first
		if timed_effect.get(timed_effect.POISON) or timed_effect.get(timed_effect.CUT) then
			message("You'd better heal your wounds or you might just die from them in your sleep.")
			return
		end

		-- Wait for sunset/sunrise
		local was_daylight = time.is_daylight(turn)
		while time.is_daylight(turn) == was_daylight do
			turn = turn + 10 * time.MINUTE
		end

		-- Regen
		player.chp(player.mhp())
		dball_data.cur_chi_pool = dball_data.max_chi_pool

		-- Restore status
		timed_effect(timed_effect.BLIND, 0)
		timed_effect(timed_effect.CONFUSED, 0)
		timed_effect(timed_effect.STUN, 0)

		-- Message
		if not time.is_daylight(turn) then message("You awake refreshed for the new night.")
		else message("You awake refreshed for the new day.") end

		-- Dungeon stuff
		player.regen_town()
	end
}

new_store_action
{
	define_as = "store.ACTION_APPLY"
	name = "Apply for membership"
	letter = 'a'
	letter_aux = 'm'
	action = function(store_info, info)
		local dbtowner = (ow_info[store_info.owner+1].name)
		if dbtowner == "Miss Eliott, the Librarian" then
			if dball_data.member_library == 0 then
				if player.au >= 1000 then
					-- player.au = player.au - 1000
					message("Thank you. You are now a member of the library.")
					dball_data.member_library = 1
	 				change_quest_status(QUEST_LIBRARYMEMBER, QUEST_STATUS_TAKEN)
				else
					message("I'm sorry, you haven't the money. That's ok, not everyone needs to be literate.")
				end
			else
				if player.au >= 1000 then
					player.au = player.au + 1000
					message("You're already a member.")
				else
					message("Good thing you become a member back when you had the money for it, huh?")
				end
			end		
		elseif dbtowner == "Arnold, the Gym Coach" then
			if dball_data.member_gym == 0 then
				if player.au >= 1000 then
					-- player.au = player.au - 1000
					message("Thank you. You are now a member of the gym.")
					dball_data.member_gym = 1
	 				change_quest_status(QUEST_GYMMEMBER, QUEST_STATUS_TAKEN)
				else
					message("I'm sorry, you haven't the money. Wow...scrawny AND poor. That's gotta be tough.")
				end
			else
				if player.au >= 1000 then
					player.au = player.au + 1000
					message("You're already a member.")
				else
					message("Good thing you became a member back when you had the money for it, huh?")
				end
			end
		else
			message("Error: Invalid owner name in store actions.lua!")
		end
	end
	action_restr = "all"
	costs = { 1000, 1000, 1000 }
}

new_store_action
{
	define_as = "store.ACTION_WORKOUT"
	name = "Work out"
	letter = 'w'
	letter_aux = 'w'
	action = function(store_info, info)
		if dball_data.alive ~= 0 then
			message("You are a discarnate spirit. Which muscle groups are you going to work?")
		elseif dball_data.member_gym == 0 then
			message("Sorry...members only. Care to sign up? 1000 zeni.")
		else
			if dball_data.workout == 0 then
				message("Whew! What a great first workout! You feel stronger already.")
				message("Maybe you should do this regularly.")
				message("Strength Skill increases by 1")
				dball_data.workout = dball_data.workout + 1
			elseif dball_data.workout <= (player.lev / 5) then
				message("You feel stronger")
				message("Strength Skill increases by 1")
				dball_data.workout = dball_data.workout + 1
			else
				message("You're still tired from your last workout!")
			end
			if dball_data.workout > (player.lev / 5) then
				quest(QUEST_GYMMEMBER).status = QUEST_STATUS_FINISHED
			end
			player.calc_bonuses()
		end
	end
	action_restr = "all"
	costs = { 0, 0, 0 }
}

new_store_action
{
	define_as = "store.ACTION_STUDY"
	name = "Study"
	letter = 's'
	action = function(store_info, info)
		if dball_data.member_library == 0 then
			message("Sorry...members only. Care to sign up? 1000 zeni.")
		else
			if dball_data.study == 0 then
				message("You spend several hours reading.")
				message("Maybe you should do this regularly.")
				message("Intelligence Skill increases by 1")
				dball_data.study = dball_data.study + 1
				-- Update Quest text
			elseif dball_data.study <= (player.lev / 5) then
				message("You feel more intelligent")
				message("Intelligence Skill increases by 1")
				dball_data.study = dball_data.study + 1
			else
				message("You spend some time reading. It is quite refreshing.")
			end
			if dball_data.study > (player.lev / 5) then
				quest(QUEST_LIBRARYMEMBER).status = QUEST_STATUS_FINISHED
			end
			player.calc_bonuses()
		end
	end
	action_restr = "all"
	costs = { 0, 0, 0 }
}
new_store_action
{
	define_as = "store.ACTION_SELL"
	name = "Sell an item"
	letter = 's'
	letter_aux = 'd'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action = function(store_info, info)
		if st_info[store_info.st_idx+1].max_obj == 0 then
			message(color.VIOLET, "Store can't hold anything!")
			return
		end
		if dball_data.alive ~= 0 then
			message("Discarnate spirits cannot buy or sell things.")
			return
		end

		local ret, item = get_item("Sell which item?", "You have no items to sell.", USE_INVEN, get_function_registry("st_info", st_info[store_info.st_idx+1].buy))
		if not ret then return end
		local obj = object_dup(get_object(item))

		-- Quantity ?
		local qt = 1
		if obj.number > 1 then
			qt = get_quantity("Quantity (1-"..obj.number.."):", obj.number)
			if qt < 1 then delete_object(obj) return end
		end
		obj.number = qt

		local desc, price
		price = store.price_item(store_info, obj, true) * obj.number
		if known_flag(obj, FLAG_ID_VALUE) then
			desc = object_desc(obj, true, 3, true)
		else
			desc = object_desc(obj, false, 0)
		end
		

		-- Confirm
		if not get_check("Sell ".. desc .. " for " .. price .. "zn ?") then
			delete_object(obj)
			return
		end

		-- Remove it
		item_increase(item, -qt)
		item_optimize(item)

		-- ID it
		make_item_fully_identified(obj)

		-- Grab it
		inven_carry_inven(store_info.stock, obj, FALSE)

		-- Add gold
		player.au = player.au + price

		message("Done! You sold ".. desc .. " for " .. price .. "zeni.")
	end
}

new_store_action
{
	define_as = "store.ACTION_BUY"
	name = "Purchase an item"
	letter = 'p'
	letter_aux = 'g'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action =
	function(store_info, info)
	if dball_data.alive ~= 0 then
		message("You are a discarnate spirit. You wouldn't be able to hold anything.")
		return
	end

	--Check the various schools to see if player may purchase
	local dbtowner = (ow_info[store_info.owner+1].name)

	if dbtowner == "Nakamura Sensei, the Karate Master" and enrollments[FLAG_KARATE] == 0 then
		message(color.VIOLET, "I'm sorry, I can only sell to students.")
		return
	end
	if dbtowner == "Bob, the Kickboxing Trainer" and enrollments[FLAG_KICKBOXING] == 0 then
		message(color.VIOLET, "I'm sorry, I can only sell to students.")
		return
	end
	if dbtowner == "Fong-Sai Yuk, the Kung-Fu Master" and enrollments[FLAG_KUNGFU] == 0 then
		message(color.VIOLET, "I'm sorry, I can only sell to students.")
		return
	end
	if dbtowner == "Jacque, the Fencing Master" and enrollments[FLAG_FENCING] == 0 then
		message(color.VIOLET, "I'm sorry, I can only sell to students.")
		return
	end
	if dbtowner == "Honda, the Sumo Instructor" and enrollments[FLAG_SUMO] == 0 then
		message(color.VIOLET, "You're kind of small. You'd look really funny in these.")
		return
	end
	if dbtowner == "Yawara, the Judo Instructor" and enrollments[FLAG_JUDO] == 0 then
		message(color.VIOLET, "I'm sorry, I can only sell to students.")
		return
	end
	-- Sakura will to sell to anybody. :)
	if dbtowner == "Grandmaster Hatsumi" and enrollments[FLAG_NINJUTSU] == 0 then
		message(color.VIOLET, "I'm sorry, I can only sell to students.")
		return
	end

--[[
	if dbtowner == "Master Lee, the Tae Kwon Do Master" and enrollments[FLAG_TAEKWONDO] == 0 then
		message(color.VIOLET, "I'm sorry, I can only sell to students.")
		return
	end
]]
	
		local store_type = st_info[store_info.st_idx + 1]

		-- ???
		if flag_max_key(store_type.table) == 0 then
			-- message(color.VIOLET, "No item_kinds to sell!")
			-- return
		end

		if is_inven_empty(store_info.stock) then
			message("Nothing in store to buy.")
			return
		end

		if store_type.max_obj == 0 then
			-- message("I'm sorry, but I don't have any more room for new stock.)
			return
		end

		while not nil do
			local ret, key = get_com("(Items a-" .. strchar(strbyte('a') + info.last_displayed) .. ", ESC to exit) Which item are you interested in?")
			if not ret then return end

			key = strchar(key)
			if info.key_table.items[key] and (strbyte(key) - strbyte('a') <= info.last_displayed) then
				local obj = object_dup(store_info.stock[info.key_table.items[key]])

				-- Quantity ?
				local qt = 1
				if obj.number > 1 then
					qt = get_quantity("Quantity (1-"..obj.number.."):", obj.number)
					if qt < 1 then delete_object(obj) break end
				end
				obj.number = qt

				local desc, price = object_desc(obj, true, 3, true), store.price_item(store_info, obj, nil) * obj.number

				-- Check player gold
				if player.au < price then
					message("You do not have enough zeni.")
					delete_object(obj)
					break
				end

				-- Confirm
				if not get_check("Buy ".. desc .. " for " .. price .. "zn ?") then
					delete_object(obj)
					break
				end

				-- Check capacity
				if not inven_carry_okay(obj) then
					message("You cannot carry that many different items.")
					delete_object(obj)
					break
				end

				-- Grab it
				inven_carry_inven(player.inventory[INVEN_INVEN], obj, FALSE)

				-- Remove it from the store
				local item = object_make_idx("store", 0, info.key_table.items[key], store_info)
				item_increase(item, -qt)
				item_optimize(item)

				-- Remove gold
				player.au = player.au - price

				message("Done! You bought ".. desc .. " for " .. price .. " zeni.")
				break
			end
		end
	end
}

new_store_action
{
	define_as = "store.ACTION_DROP"
	name = "Drop an item"
	letter = 'd'
	letter_aux = 's'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action = function(store_info, info)
		if dball_data.alive ~= 0 then
			message("Discarnate spirits cannot manipulate objects")
			return
		end
		local ret, item = get_item("Drop which item?", "You have no items to drop.", USE_INVEN, function(obj) return true end)
		if not ret then return end
		local obj = object_dup(get_object(item))

		-- Quantity ?
		local qt = 1
		if obj.number > 1 then
			qt = get_quantity("Quantity (1-"..obj.number.."):", obj.number)
			if qt < 1 then delete_object(obj) return end
		end
		obj.number = qt

		local desc
		if known_flag(obj, FLAG_ID_VALUE) then
			desc = object_desc(obj, true, 3, true)
		else
			desc = object_desc(obj, false, 0)
		end

		-- Grab it
		if inven_carry_inven(store_info.stock, obj, false) == -1 then
			message("There is no space to store it.")
			return
		end

		-- Remove it
		item_increase(item, -qt)
		item_optimize(item)

		message("You dropped ".. desc .. ".")
	end
}

new_store_action
{
	define_as = "store.ACTION_GET"
	name = "Get an item"
	letter = 'g'
	letter_aux = 'p'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action = function(store_info, info)
		if dball_data.alive ~= 0 then
			message("Discarnate spirits cannot manipulate objects")
			return
		end
		if is_inven_empty(store_info.stock) then
			message("Nothing in store to get")
			return
		end

		while not nil do
			local ret, key = get_com("(Items a-" .. strchar(strbyte('a') + info.last_displayed) .. ", ESC to exit) Which item are you interested in?")
			if not ret then return end

			key = strchar(key)
			if info.key_table.items[key] and (strbyte(key) - strbyte('a') <= info.last_displayed) then
				local obj = object_dup(store_info.stock[info.key_table.items[key]])

				-- Quantity ?
				local qt = 1
				if obj.number > 1 then
					qt = get_quantity("Quantity (1-"..obj.number.."):", obj.number)
					if qt < 1 then delete_object(obj) break end
				end
				obj.number = qt

				local desc = object_desc(obj, true, 3, true)

				-- Check capacity
				if not inven_carry_okay(obj) then
					message("You cannot carry that many different items.")
					delete_object(obj)
					break
				end

				-- Grab it
				inven_carry_inven(player.inventory[INVEN_INVEN], obj, FALSE)

				-- Remove it from the store
				local item = object_make_idx("store", 0, info.key_table.items[key], store_info)
				item_increase(item, -qt)
				item_optimize(item)

				message("You picked up ".. desc .. ".")
				break
			end
		end
	end
}

new_store_action
{
	define_as = "store.ACTION_EXAMINE"
	name = "Examine an item"
	letter = 'x'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action = function(store_info, info)
		if is_inven_empty(store_info.stock) then
			message("Nothing in store to examine")
			return
		end

		while not nil do
			local ret, key = get_com("(Items a-" .. strchar(strbyte('a') + info.last_displayed) .. ", ESC to exit) Which item do you want to examine?")
			if not ret then return end

			key = strchar(key)
			if info.key_table.items[key] and (strbyte(key) - strbyte('a') <= info.last_displayed) then
				local obj = object_dup(store_info.stock[info.key_table.items[key]])

				-- Identify it, if appropriate
				dball.id_if(obj)

				-- Display it
				object_out_desc (obj)

				break
			end
		end
	end
}

new_store_action
{
	define_as = "store.ACTION_REST_FREE"
	name = "Rest for the night/day"
	letter = 'r'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action = function()
		-- Must cure HP draining status first
		if timed_effect.get(timed_effect.POISON) or timed_effect.get(timed_effect.CUT) then
			message("You'd better heal your wounds or you might just die from them in your sleep.")
			return
		end

		-- Wait for sunset/sunrise
		local was_daylight = time.is_daylight(turn)
		while time.is_daylight(turn) == was_daylight do
			turn = turn + 10 * time.MINUTE
		end

		-- Regen
		player.chp(player.mhp())
		dball_data.cur_chi_pool = dball_data.max_chi_pool

		-- Restore status
		timed_effect(timed_effect.BLIND, 0)
		timed_effect(timed_effect.CONFUSED, 0)
		timed_effect(timed_effect.STUN, 0)

		-- Message
		if not time.is_daylight(turn) then message("You awake refreshed for the new night.")
		else message("You awake refreshed for the new day.") end

		-- Dungeon stuff
		player.regen_town()
	end
}

new_store_action
{
	define_as = "store.ACTION_CHALLENGE"
	name = "Challenge!"
	letter = 'c'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action = function(store_info)
		if dball_data.alive ~= 0 then
			message("Arrrgghhh!!! A ghost!")
			return
		end
		local dbtowner = (ow_info[store_info.owner+1].name)

		if dbtowner == "Tofu Sensei" then
			message("A challenge...? I'm sorry, I've retired from active practice.")
		elseif dbtowner == "Nakamura Sensei, the Karate Master" then
			if enrollments[FLAG_KARATE] > 0 then
				message("You engage in a few friendly sparring matches with Nakamura.")
			else
				if dball_data.fled_karate ~= 0 then
					message("You again? No, I do not fight cowards like you.")
				elseif dball.challenge_is_ok() then
					message("A challenge? Hmm. I didn't think this happened anymore. Very well, I accept. (Press escape twice)")
					dball.dungeon_teleport("Duel vs Karate")
				end
			end
		elseif dbtowner == "Bob, the Kickboxing Trainer" then
			if enrollments[FLAG_KICKBOXING] > 0 then
				message("You and Bob spend some time together in the ring. It's good practice.")
			else
				if dball_data.fled_kickboxing ~= 0 then
					message("Sorry, I don't think you're up to it.")
				elseif dball.challenge_is_ok() then
					message("Sure! I'll go into the ring with anybody!(Press escape twice)")
					dball.dungeon_teleport("Duel vs Kickboxing")
				end
			end
		elseif dbtowner == "Fong-Sai Yuk, the Kung-Fu Master" then
			if enrollments[FLAG_KUNGFU] > 0 then
				message("You engage in a few friendly sparring matches with Fong-Sai Yuk.")
			else
				if dball_data.fled_kungfu ~= 0 then
					message("Get out of here while you're still able to pretend to have dignity.")
				elseif dball.challenge_is_ok() then
					message("A challenge? Hmm. I didn't think this happened anymore. Very well, I accept. (Press escape twice)")
					dball.dungeon_teleport("Duel vs Kung Fu")
				end
			end
		elseif dbtowner == "Jacque, the Fencing Master" then
			if enrollments[FLAG_FENCING] > 0 then
				message("You engage in a few friendly matches with Jacque.")
			else
				if dball_data.fled_fencing ~= 0 then
					message("Get out of here while you're still able to pretend to have dignity.")
				elseif dball.challenge_is_ok() then
					message("A challenge? Very well, " .. gendernouns.french .. ", I accept!(Press escape twice)")
					dball.dungeon_teleport("Duel vs Fencing")
				end
			end
--		elseif dbtowner == "Master Lee, the Tae Kwon Do Master" then
--			if enrollments[FLAG_TAEKWONDO] > 0 then
--				message("You engage in some friendly sparring with Master Lee. It's good practice.")
--			else
--				if dball_data.fled_taekwondo ~= 0 then
--					message("Master Lee just shakes his head and walks away.")
--				elseif dball.challenge_is_ok() then
--					message("A challenge? Hmm. I didn't think this happened anymore. Very well, I accept. (Press escape twice)")
--					dball.dungeon_teleport("Duel vs TaeKwonDo")
--				end
--			end
		elseif dbtowner == "Grandmaster Hatsumi" then
			-- Grandmaster will duel anyone, anytime (within the level requirement)
			message("Grandmaster Hatsumi agrees to the duel. (Press escape twice)")
			dball.dungeon_teleport("A Ninja Duel")
		elseif dbtowner == "Sakura, the Dance Instructor" then
			if enrollments[FLAG_BALLET] > 0 then
			elseif quest(QUEST_CHALLENGE_BALLET).status == QUEST_STATUS_UNTAKEN then
				term.text_out(color.LIGHT_GREEN, "\n(Sakura looks at you quietly for a few moments before speaking.)\n\n")
				term.text_out(color.LIGHT_BLUE, "\nSakura: ")
				term.text_out("This is a dance school. We don't fight here. Not even a little bit. Fights don't happen in places like dance schools. Perhaps you would like to leave now.\n\n") 
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Hmm. Ok.\n\n") 
				term.text_out(color.LIGHT_RED, "\nSakura: ")
				term.text_out("...but remember that fights do sometimes happen in places other than dance schools.\n\n") 
				dialogue.conclude()
			else
				term.text_out(color.LIGHT_BLUE, "\nSakura: ")
				term.text_out("Challenge...? Me? I don't understand. I'm just a dance instructor. I can't fight you.\n\n") 
				dialogue.conclude()
			end
		elseif dbtowner == "Honda, the Sumo Instructor" then
			if enrollments[FLAG_SUMO] > 0 then
				message("You and Honda have a few matches together. It's exhausting, but excellent practice.")
			else
				if dball_data.fled_sumo ~= 0 then
					message("No, sorry. I must decline.")
				elseif dball_data.ever_challenged_sumo == 1 then
					message("No, thank you. I must train more first.")
				elseif dball.challenge_is_ok() then
					message("A challenge? Of course! We accept wrestling challenges from anybody! (Press escape twice)")
					dball_data.ever_challenged_sumo = 1
					dball.dungeon_teleport("Duel vs Sumo")
				end
			end
		elseif dbtowner == "Yawara, the Judo Instructor" then
			if enrollments[FLAG_JUDO] > 0 then
				message("You and Yawara engage in a few matches together. It's good practice.")
			else
				if dball_data.fled_judo ~= 0 then
					message("I appreciate your enthusiasm, but you really can't expect me to accept...again.")
				-- This could really stand to be cleaned
				--elseif dball_data.ever_challenged_judo == 1 then
				--	message("I appreciate your enthusiasm, I think I'd like to train more first.")
				elseif dball.challenge_is_ok() then
					message("You wish to duel? Very well, I accept. (Press escape twice)")
				--	dball_data.ever_challenged_judo = 1
					dball.dungeon_teleport("Duel vs Judo")
				end
			end
		elseif dbtowner == "Charleton" then
			if enrollments[FLAG_MARKSMANSHIP] > 0 then
				message("You do some skeet shooting with Charles. It's good practice.")
			else
				if dball_data.fled_marksmanship ~= 0 then
					message("Charles laughs in your face.")
				else
					message("Hehe...you may know karate, but I know Smith and Wesson. (Press escape twice)")
					dball.dungeon_teleport("The Gun Store")
				end
			end

		else
			message("Error: Invalid challenge recipient in actions.lua!")
		end
	end
}

new_store_action
{
	define_as = "store.ACTION_TALK"
	name = "Talk"
	letter = 't'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action = function(store_info)
		local dbtowner = (ow_info[store_info.owner+1].name)
		if dbtowner == "Dr. Briefs" then
			dialogue.BRIEFS()
		elseif dbtowner == "Akira, the Sushi Chef" then
			dialogue.AKIRA()
		elseif dbtowner == "Billy" then
			-- message("If you're looking to learn to shoot, there's a shooting range")
			-- message("in the mountains on the other side of the lake that offers classes.")
		elseif dbtowner == "Mike" then
			message("Hello! We're renting out hangers to members of the pilots club.")
			message("Cost is 1000zn a day for membership and rental. Interested?")
		elseif dbtowner == "Imelda, the lonely villagess" then
			dialogue.IMELDA()
		elseif dbtowner == "Marcos, the lonely villager" then
			dialogue.MARCOS()
		elseif dbtowner == "Joe" then
			dialogue.JOE()
		elseif dbtowner == "Joesephine" then
			dialogue.JOESEPHINE()
		elseif dbtowner == "Noburo Sensei, the sword smith" then
			dialogue.SWORDSMITH()
		elseif dbtowner == "Plant Receptionist" then
			dialogue.TOXIC()
		elseif dbtowner == "Tofu Sensei" then
			if dball_data.learned_acupuncture == 2 then
				message("Hello! Good to see you again!")
			else
				message("Hello! I can cure most conditions short of broken bones or mental fatigue.")
				message("Only time and rest can cure those. I also offer classes. Interested?")
			end
		elseif dbtowner == "Arnold, the Gym Coach" then
			if dball_data.member_gym == 1 then
				message("Hey! Great to see you! Some people sign up and never actually work out.")
			else
				message("Hey! You look scrawny and weak! Sign up and we'll put some meat on you!")
			end
		elseif dbtowner == "George" then
			dialogue.GEORGE()
		elseif dbtowner == "Lazarus" then
			dialogue.LAZARUS()
		elseif dbtowner == "Nakamura Sensei, the Karate Master" then
			dialogue.KARATE()
		elseif dbtowner == "Bob, the Kickboxing Trainer" then
			dialogue.KICKBOXING()
		elseif dbtowner == "Fong-Sai Yuk, the Kung-Fu Master" then
			dialogue.KUNGFU()
		elseif dbtowner == "Jacque, the Fencing Master" then
			dialogue.FENCING()
		elseif dbtowner == "Honda, the Sumo Instructor" then
			dialogue.SUMO()
		elseif dbtowner == "Yawara, the Judo Instructor" then
			dialogue.JUDO()
		elseif dbtowner == "Sakura, the Dance Instructor" then
			dialogue.BALLET()
		elseif dbtowner == "Grandmaster Hatsumi" then
			dialogue.NINJUTSU()

		elseif dbtowner == "Charleton" then
			dialogue.MARKSMANSHIP()
		else
			message("Unknown store owner for talk in actions.lua!")
		end
	end
}


new_store_action
{
	define_as = "store.ACTION_RESEARCH_MON"
	name = "Research"
	letter = 'r'
	action_restr = "all"
	costs = { 500, 500, 500 }
	action = function(store_info, info)
			if dball_data.member_library == 0 then
				message("Sorry...members only. Care to sign up? 1000 zeni.")
				return
			end
			if player.au < 500 then
				message("You don't have enough zeni to research a monster")
				return
			end

			local ret, char = get_com("Enter character to be identified " ..
									 "or (Ctrl-A, Ctrl-U, Ctrl-N, Ctrl-M):")

			if not ret then return end

			local key = strchar(char)

			local by_char, name, unique, non_unique

			if char == KTRL('M') then
				name = get_string("Name: ")

				if not name then
					return
				end
				name = clean_whitespace(name)

				if strlen(name) == 0 then
					return
				end

				name = strlower(name)
			elseif char == KTRL('A') then
				-- All monsters
			elseif char == KTRL('U') then
				unique = true
			elseif char == KTRL('N') then
				non_unique = true
			else
				if get_symbol_info(key) == "Unknown symbol" then
					message("Unknown symbol '" .. key .. "'")
					return
				end
				by_char = true
			end

			local list = {}
			for i = 1, max_r_idx do
				local r_ptr = r_info[i]

				if by_char and r_ptr.d_char ~= char then
				elseif unique and not r_ptr.flags[FLAG_UNIQUE] then
				elseif non_unique and r_ptr.flags[FLAG_UNIQUE] then
				elseif name and not strfind(strlower(r_ptr.name), name) then
				else
					tinsert(list, i - 1)
				end
			end

			if getn(list) == 0 then
				if name then
					message("No monsters matching '" .. name .. "'")
					return
				elseif by_char then
					message("No monster with symbol '" .. key .. "'")
					return
				else
					message(color.VIOLET, "ERROR: No monsters found!")
					return
				end
			end

			-- Remove monsters we already know everything about,
			-- unless the user is researching by monster name (just
			-- in case, for some weird reason, they want to
			-- re-research something they already know everything
			-- about).
			if not name then
				local i = 1
				while i <= getn(list) do
					local r_ptr = r_info[list[i] + 1]
					local mem_entry = memory.get_entry(r_ptr, 0)

					if mem_entry.knowall and mem_entry.knowall ~= 0 then
						-- Already know everything about it
						tremove(list, i)
					else
						i = i + 1
					end
				end

				if getn(list) == 0 then
					message("You already know everything about every " ..
							"monster of that type.  To research a " ..
								" particular alrady-known monster anyways, " ..
								"look it up by name (CTRL-M).")
					return
				end
			end

			local pos = 1
			while true do
				local r_idx = list[pos]
				local r_ptr = r_info[r_idx + 1]
				local str

				term.erase(0, 0, 255)
				term.gotoxy(0, 0)

				if r_ptr.flags[FLAG_UNIQUE] then
					str = book_capitals(r_ptr.name)
				else
					str = "The " .. strcap(r_ptr.name)
				end

				term.addstr(-1, color.WHITE, str)
				term.addstr(-1, color.WHITE, " ('")
				term.addstr(-1, r_ptr.d_attr, strchar(r_ptr.d_char))
				term.addstr(-1, color.WHITE, "')")

				term.addstr(-1, color.WHITE,
							" [(r)esearch, (n)ext, (p)rev]")

				char = term.inkey()

				if char == ESCAPE then
					break
				end

				key = strlower(strchar(char))

				if key == "r" then
					-- Remember/learn the monster
					if r_ptr.r_sights == 0 then
						r_ptr.r_sights = 1
					end

					local mem_entry = memory.get_entry(r_ptr, 0)
					mem_entry.knowall = 1

					term.save()
					local old_screen = term.save_to()

					-- Actually show it
					term.gotoxy(1, 0)
					memory.main(r_idx, 0)

					-- Pause
					term.inkey()

					term.load_from(old_screen, true)
					term.load()

					-- Charge money
					player.au = player.au - 1500

					break
				elseif key == "n" then
					pos = pos + 1
				elseif key == "p" then
					pos = pos - 1
				end

				-- Wrap-around
				if pos > getn(list) then
					pos = 1
				elseif pos < 1 then
					pos = getn(list)
				end
			end -- while true do

			term.erase(0, 0, 255)
			term.gotoxy(0, 0)
		end
} -- store.ACTION_RESEARCH_MON

new_store_action
{
	define_as = "store.ACTION_ENROLL"
	name = "Enroll for classes"
	letter = 'e'
	letter_aux = 'e'
	action_restr = "all"
	costs = { 0, 0, 0 }
	action = function(store_info, info)
		if dball_data.alive ~= 0 then
			message("Hmm. I'm sorry, I generally prefer to teach people who are still alive.")
			return
		end

		term.gotoxy(0, 0)

		local dbtowner = (ow_info[store_info.owner+1].name)
		if dbtowner == "Nakamura Sensei, the Karate Master" then
			if dball_data.fled_kickboxing == 1 or dball_data.fled_karate == 1 then
				message("I would never take as a student a coward such as yourself.")
			elseif enrollments[FLAG_KICKBOXING] > 0 then
				term.text_out(color.LIGHT_BLUE, "\nNakamura Sensei: ")
				term.text_out("I'm sorry. I don't take students who have previously studied kickboxing. Karate requires precision and control. With all the time spent wearing pads and gloves, kickboxing students have a difficult time lerning control, and tend to harm other students.\n\n") 
				dialogue.conclude()
			else
				dball.enroll(FLAG_KARATE)
			end
		elseif dbtowner == "Bob, the Kickboxing Trainer" then
			if dball_data.fled_karate == 1 or dball_data.fled_kickboxing == 1 then
				message("Hmm. A coward like you obviously needs my training...but I just don't want to give it.")
			elseif enrollments[FLAG_KARATE] > 0 then
				term.text_out(color.LIGHT_BLUE, "\nBob: ")
				term.text_out("Sorry. I don't take students who have previously studied karate. It's just too difficult to overcome all the ridiculous training habits. Seriously, can you explain to me deliberately practicing NOT hitting your opponent? It's ridiculous, and experience has shown me that not only are karate practitioners forever damaged as real fighters, they're genuinely happier somewhere else, so let's both save ourselves the hassle.\n\n") 
				dialogue.conclude()
			else
				dball.enroll(FLAG_KICKBOXING)
			end
		elseif dbtowner == "Fong-Sai Yuk, the Kung-Fu Master" then
			if dball_data.fled_fencing == 1 or dball_data.fled_kungfu == 1 then
				message("I would never take as a student a coward such as yourself.")
			elseif enrollments[FLAG_FENCING] > 0 then
				term.text_out(color.LIGHT_BLUE, "\nFong-Sai Yuk: ")
				term.text_out("I'm sorry. I don't take students who have previously studied fencing. The fundamentals are completely different, and it's entirely too much work to un-teach what has already been learned to make room for something new.\n\n") 
				dialogue.conclude()
			else
				dball.enroll(FLAG_KUNGFU)
			end
		elseif dbtowner == "Jacque, the Fencing Master" then
			if dball_data.fled_kungfu == 1 or dball_data.fled_kungfu == 1 then
				message("Pardon, " .. gendernouns.french .. ", I do not I wish to further teach a coward such as you.")
			elseif enrollments[FLAG_KUNGFU] > 0 then
				term.text_out(color.LIGHT_BLUE, "\nJacque: ")
				term.text_out("Pardon, " .. gendernouns.french .. ", I do not take students who have previously studied kungfu. The fundamentals are completely different, and it's entirely too much work to un-teach what has already been learned to make room for something new.\n\n") 
				dialogue.conclude()
			else
				dball.enroll(FLAG_FENCING)
			end
		elseif dbtowner == "Master Lee, the Tae Kwon Do Master" then
			if dball_data.fled_taekwondo == 1 or dball_data.fled_kickboxing == 1 then
				message("I'm sorry, cowards who flee battles haven't the heart to study Tae Kwon Do")
			elseif enrollments[FLAG_KICKBOXING] > 0 then
				term.text_out(color.LIGHT_BLUE, "\nMaster Lee: ")
				term.text_out("Excuse me...but aren't you a student at the kickboxing school across the street? I'm sorry...I can't accept youa s a student. There is some rivalry between our schools, and if I took you in it would look like I was trying to be subversive.\n\n") 
				dialogue.conclude()
			else
				dball.enroll(FLAG_TAEKWONDO)
			end
		elseif dbtowner == "Grandmaster Hatsumi" then
			-- Ballet_pre IS allowed
			-- Just differentiates which Challenge quest Ninjutsu students receive
			-- Players may choose either school at any up until actually training
			if enrollments[FLAG_BALLET] > 0 then
				dialogue.NINJUTSU_REFUSE()
			else
				dball.enroll(FLAG_NINJUTSU)
			end
		elseif dbtowner == "Sakura, the Dance Instructor" then
			if quest(QUEST_BALLET_PRE).status == QUEST_STATUS_FINISHED then
				if enrollments[FLAG_NINJUTSU] > 0 then
					dialogue.BALLET_REFUSE()
				else
					dball.enroll(FLAG_BALLET)
				end
			else
				dialogue.BALLET()
			end
		elseif dbtowner == "Honda, the Sumo Instructor" then
			-- Honda will still take you if you flee from Yawara
			if dball_data.fled_sumo == 1 then
				message("Hmm. A coward like you obviously needs my training...but I just don't want to give it.")
			elseif player.get_sex() == "Female" then
				message("Sorry, sumo is for men only. Try Yawara next door.")
			elseif enrollments[FLAG_JUDO] > 0 then
				term.text_out(color.LIGHT_BLUE, "\nHonda: ")
				term.text_out("Wait...I've seen you before. Your'e one of Yawara's students, aren't you? I'm sorry, I'd love to take you on, but it would be terribly bad form, and I wouldn't Yawara to misunderstand, and maybe think I was trying to steal her students.\n\n") 
				dialogue.conclude()
			else
				dball.enroll(FLAG_SUMO)
			end
		elseif dbtowner == "Yawara, the Judo Instructor" then
			if enrollments[FLAG_SUMO] > 0 then
				term.text_out(color.LIGHT_BLUE, "\nYawara: ")
				term.text_out("Oh...hello. Haven't I seen you practicing next door, at Honda's Sumo school? I'm sorry, I'd love to take you as a student, but somehow I'm not sure it would be quite right. I mean, you being Honda's student...I wouldn't want him to think I was trying to steal his students. It would be very improper.\n\n") 
				dialogue.conclude()
			else
				dball.enroll(FLAG_JUDO)
			end
		elseif dbtowner == "Charleton" then
			dball.enroll(FLAG_MARKSMANSHIP)
		elseif dbtowner == "Tony" then
			dball.enroll(FLAG_TONY)
		elseif dbtowner == "Tofu Sensei" then
			dball.enroll(FLAG_TOFU)
		elseif dbtowner == "Tyrone" then
			dball.enroll(FLAG_YMCA)
		elseif dbtowner == "Mike" then
			dball.enroll(FLAG_FLIGHT_SCHOOL)
		else
			message("Error: Invalid store owner for 'enroll'")
		end
		-- Perform various updates
		-- Archaic?
		dball_data.p_class = player.determine_class()
		player.calc_bonuses(1)
	end
}

new_store_action
{
	define_as = "store.ACTION_HEAL"
	name = "Heal"
	letter = 'h'
	action_restr = "all"
	costs = { 250, 250, 250 }
	action = function()
		if dball_data.alive ~= 0 then
			message("How exactly am I supposed to heal you?")
			return
		end
		if player.au > 249 then
			-- player.au = player.au - 250
			message("You are cured of all conditions.")

			-- Takes about an hour for a session
			turn = turn + 10 * time.HOUR

			-- Heal everything except hp/sn/chi
			restore_level()
			timed_effect(timed_effect.BLIND, 0)
			timed_effect(timed_effect.CONFUSED, 0)
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
		else
			message("Oh dear...I'm afraid you have no money. Still, I couldn't call myself")
			message("a healer and turn you down over such a trivial thing as money. Perhaps")
			message("you'd like to run an errand for me in lieu of payment?")
			message("(Quest not implemented)")
		end
	end
}

-- Currently used store commands
-- . nothing
-- p/f pay fee
-- a/m apply for membership
-- w   work out
-- s   study
-- s/d sell
-- p/g buy
-- d/s drop
-- g/p get
-- x   examine
-- r   rest
-- t   talk 
-- r   research monster
-- e   enroll
-- h   heal
-- c   challenge
-- s	 sharpen