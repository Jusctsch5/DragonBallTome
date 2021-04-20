-- The Dragonball T food subsystem
-- 
-- This is mostly straight copied from the default subsystem...
-- but there were a couple minor tweaks that I wanted
-- to make, and doing it this way was much, much easier.
--
-- Generally more interesting 'eat' messages
-- Zero energy use for martial arts eaters...
-- Tougher rules of eating corpses
-- Different eating rules for dead people
-- Eliminating no-travel rule
-- I might remove xp for eating, etc.

constant("food", {})

new_flag("EAT_PRE")
new_flag("ON_EAT")
new_flag("ON_CORPSE_EAT")
safe_new_flag("FOOD_VALUE")

food.FOOD_HARD_MAX = 20000 -- Maximal counter value
food.FOOD_MAX = 15000	-- Food value (Bloated)
food.FOOD_FULL = 10000	-- Food value (Normal)
food.FOOD_ALERT = 2000	-- Food value (Hungry)
food.FOOD_WEAK = 1000	-- Food value (Weak)
food.FOOD_FAINT = 500	-- Food value (Fainting)
food.FOOD_STARVE = 100	-- Food value (Starving)
food.DEFAULT_VALUE = food.FOOD_MAX

food.messages_up =
{
	[1] = "You are still weak."
	[2] = "You are still hungry."
	[3] = "You are no longer hungry."
	[4] = "You are pleasantly full."
	[5] = "You have gorged yourself!"
}
food.messages_down =
{
	[0] = "You are getting faint from hunger!"
	[1] = "You are getting weak from hunger!"
	[2] = "You are getting hungry."
	[3] = "You are no longer full."
	[4] = "You are no longer gorged."
}


-- Food, food .. ahhh food..
-- Hunger is just a timed effect
-- except it starts filled up
timed_effect.create
{
	name = "FOOD"
	desc = "Hunger"
	type = "physical"
	status = "hidden"
	parameters = {}
	redraw = FLAG_PR_HUNGER
	amount_from_intrinsic = FLAG_FOOD_VALUE
	max_value = food.FOOD_HARD_MAX
	on_change = function(val)
		local old_aux, new_aux
		local notice = false
		local cur_val = timed_effect.get(timed_effect.FOOD) or 0

		-- Fainting / Starving
		if (cur_val < food.FOOD_FAINT) then
			old_aux = 0
		-- Weak
		elseif (cur_val < food.FOOD_WEAK) then
			old_aux = 1
		-- Hungry
		elseif (cur_val < food.FOOD_ALERT) then
			old_aux = 2
		-- Normal
		elseif (cur_val < food.FOOD_FULL) then
			old_aux = 3
		-- Full
		elseif (cur_val < food.FOOD_MAX) then
			old_aux = 4
		-- Gorged
		else
			old_aux = 5
		end

		-- Fainting / Starving
		if (val < food.FOOD_FAINT) then
			new_aux = 0
		-- Weak
		elseif (val < food.FOOD_WEAK) then
			new_aux = 1
		-- Hungry
		elseif (val < food.FOOD_ALERT) then
			new_aux = 2
		-- Normal
		elseif (val < food.FOOD_FULL) then
			new_aux = 3
		-- Full
		elseif (val < food.FOOD_MAX) then
			new_aux = 4
		-- Gorged
		else
			new_aux = 5
		end

		-- Dead people ignore food effects and messages

		if dball_data.alive ~= 0 then
			-- Should wipe the hunger status message
		else
			-- Food increase
			if (new_aux > old_aux) then
				-- Describe the state
				message(food.messages_up[new_aux])
				-- Change
				notice = true
				player.redraw[FLAG_PR_HUNGER] = true

			-- Food decrease
			elseif (new_aux < old_aux) then
				-- Disturb when hunger state decreased
				term.disturb(0, true)

				-- Describe the state
				message(food.messages_down[new_aux])
				-- Change
				notice = true
				player.redraw[FLAG_PR_HUNGER] = true

				-- Knock the player out of travel mode if weak
				if val < food.FOOD_WEAK and player.wild_mode then
					player.wilderness_x = player.px
					player.wilderness_y = player.py
					change_wild_mode()
				end
			end

			-- Starve to death (slowly)
			if val < food.FOOD_STARVE then
				-- Take damage
				take_hit((food.FOOD_STARVE - val) / 10, "starvation")
				term.disturb(true, true)
			end
		end -- end different behavior for dead characters
	end

	on_reset = function()
		timed_effect(timed_effect.FOOD, food.DEFAULT_VALUE - 1)
	end

	bonus = function()
		if timed_effect.get() > food.FOOD_MAX then
			player.inc_speed(-10)
			-- Digest faster
			player.inc_intrinsic(FLAG_FOOD_VALUE, 100)
		end
	end
}

-- Eat something (from the pack or floor).
function food.use()
	-- Get an item
	local question = "Eat what?"
	local no_food  = "You have nothing to eat."
	local ret, item = get_item(question, no_food, USE_INVEN | USE_FLOOR,
		function(obj) return obj.flags[FLAG_ON_EAT] ~= nil end, "E")
	if not ret then return end

	-- Get the item
	local obj = get_object(item)

	if check_prevent_cmd(obj, 'E') then
		return
	end

	local func

	if obj.flags[FLAG_EAT_PRE] then
		-- Check if there is an embeded lua bytecode
		func = get_function_registry_from_flag(obj.flags, FLAG_EAT_PRE)

		if func and func(obj) then
			-- Object disallowed being eaten
			return
		end
	end

	local wt_disqualify = false

	-- Take a turn
	if not has_ability(AB_SUSHI) then
		energy_use = get_player_energy(SPEED_EAT)
		if dball_data.tourny_now == 1 then
			wt_disqualify = true
		end
	end

	-- Object level
	local lev

	if obj.artifact_id > 0 then
		lev = a_info[obj.artifact_id + 1].level
	else
		lev = k_info[obj.k_idx + 1].level
	end

	-- Not identified yet
	local ident   = nil
	local used_up = true

	-- Check if there is an embeded lua bytecode

	if obj.flags[FLAG_FOOD_VALUE] then
		func = get_function_registry_from_flag(obj.flags, FLAG_ON_EAT)
		used_up, ident = func(obj)
	else
		-- The ON_EAT flag is the food value, so just use the default
		-- eating function
		local food_value = get_flag(obj, FLAG_ON_EAT)
		if enrollments[FLAG_SUMO] > 0 then
			local max_mod = enrollments[FLAG_SUMO]
			if max_mod > 100 then
				max_mod = 100
			end
			local sumo_mod = rescale(max_mod, 100, 50)
			food_value = (food_value * sumo_mod) / 100
		end
		food.eat_good(obj, food_value)
	end

	-- Fortunes
	if has_flag(obj, FLAG_FORTUNE) then
		dball.clue("Your fortune says: ")
	end

	-- Combine / Reorder the pack (later)
	player.notice = player.notice | PN_COMBINE | PN_REORDER

	-- The item was tried
	if not obj.artifact_id then
		k_info[obj.k_idx + 1].tried = true
	end

	-- An identification was made
	if ident and not is_aware(obj) then
		set_aware(obj)
		gain_exp((lev + (player.lev / 2)) / player.lev)
	end

	-- Window stuff
	player.window[FLAG_PW_INVEN] = true
	player.window[FLAG_PW_EQUIP] = true
	player.window[FLAG_PW_PLAYER] = true

	if not used_up then
		-- Some things, like corpses, can't be consumed in just one
		-- sitting
		return
	end

	-- Destroy a food item in the pack
	item_increase(item, -1)
	item_describe(item)
	item_optimize(item)

	if wt_disqualify == true then
		if dball.tourny_disqualify() == true then
			message("You have been disqualified for eating during a macth!")
			dball_data.tourny_registered = 4
		end
	end

end

-- Init
hook(hook.KEYPRESS, function (key)
	if key == strbyte('E') then
		if dball_data.alive == 0 then
			food.use()
		else
			message("You're dead. You can't eat.")
		end
		return true
	end
end)

-- ON_EAT convenience functions
function food.eat_good(obj, food_value)
	-- Only eating one of them, so temporarily set the number of objects
	-- to one to get the correct pluralization
	local old_num = obj.number
	obj.number = 1

	if not food_value then
		food_value = get_flag(obj, FLAG_FOOD_VALUE)
	end

	if has_ability(AB_SUSHI) then
		monster_random_say{
			"You slurp it down like lightning!",
			"Poof! Gone!",
			"Wow, you're a fast eater!",
			}
	else
		monster_random_say{
			"Delicious!",
			"Mmm! Yummy!",
			"You savor every last bite.",
			"That really hit the spot!"
			"That may have been the best " .. object_desc(obj) .. " you've ever had."
			}
	end

	timed_effect.inc(timed_effect.FOOD, food_value)
	obj.number = old_num
	return true, nil
end

function food.eat_sushi(obj, food_value)
	local old_num = obj.number
	obj.number = 1

	if not food_value then
		food_value = get_flag(obj, FLAG_FOOD_VALUE)
	end

	if has_ability(AB_SUSHI) then
		monster_random_say{
			"You slurp it down like lightning!",
			"Poof! Gone!",
			"Wow, you're a fast eater!",
			}
	else
		monster_random_say{
			"Yummy dead fish!",
			"Wow! Cold, raw dead fish is delicious!",
			"Ahh...such delightful yumminess!",
			}
	end

	timed_effect.inc(timed_effect.FOOD, food_value)
	obj.number = old_num
	return true, nil
end

function food.eat_not_so_good(obj, food_value)
	local old_num = obj.number
	obj.number = 1

	if not food_value then
		food_value = get_flag(obj, FLAG_FOOD_VALUE)
	end

	monster_random_say{
		"Hmm. Not very tasty.",
		"You've had better.",
		"That really wasn't all that good."
		"That may have been the worst " .. object_desc(obj) .. " you've ever had."
		}

	timed_effect.inc(timed_effect.FOOD, food_value)
	obj.number = old_num

	if rng.percent(30) then
		timed_effect(timed_effect.POISON, rng(15) + 10, rng(15) + 1)
	end

	return true, nil
end

function food.eat_mre(obj, food_value)
	local old_num = obj.number
	obj.number = 1

	if not food_value then
		food_value = get_flag(obj, FLAG_FOOD_VALUE)
	end

	monster_random_say{
		"Ahh, yes. Reconstituted cow udder a la mode. One of your favorites.",
		"You think that was meatloaf. Or cake. Might have been squash. Hard to say.",
		"The label on this one says it's vegetarian, kosher, pickled pigs feet.",
		"Ahh, spit-roasted cardboard. No, wait...the label says it's pizza. Hmm.",
		"This one wasn't bad. It was awful.",
		"'War' wonton?",
		}
	timed_effect.inc(timed_effect.FOOD, food_value)
	obj.number = old_num

	return true, nil
end

function food.eat_corpse(obj)
	if obj.tval ~= TV_CORPSE then
		message(color.VIOLET, "*ERROR* food.eat_corpse() being called on " ..
				"non-corpse object '" .. object_desc(obj) .. "'")
		return
	end

	local monst = obj.flags[FLAG_MONSTER_OBJ]
	local race, ego
	if monst then
		if monst.sr_ptr then
			race = monst.sr_ptr
		else
			race = r_info(monst.r_idx)
		end

		--if monst.ego ~= 0 then
		--	ego = re_info(monst.ego)
		--end
	end

	-- Enough meat left on corpse?
	if obj.weight <= (obj.flags[FLAG_ORIG_WEIGHT] / 2) then
		message("Not enough left to eat.")
		food.eat_msg = nil
		return
	end

	-- A pound of raw meat taken from the corpse
	obj.weight = obj.weight - 10

	local whatami = strchar(race.d_char)

	if whatami == "p" or whatami == "n" or whatami == "S" then
		-- Why doesn't this work?
		-- if race.body == default_body.humanoid then
		if dball_data.alignment < 0 then
			monster_random_say{
				"Mmm...yummy! ",
				"...must...eat...brains...",
				"Ahh...cannibalism! ",
				}
		else
			message("You don't feel very good about this.")
		end
		dball.chalign(-1)
	elseif whatami == "K" then
		dball.chalign(-100)
		if dball_data.alignment < 0 then
			message("Mmm...divinely yummy.")
		else
			message("You're sure this isn't a good idea. (Literally.)")
		end
	elseif whatami == "i" then
		message("Hmm. Kind of crunchy.")
	else
		message("Ugh! Raw meat!")
		if rng(1,4) == 4 then
			timed_effect(timed_effect.POISON, rng(1, 5) + 2, rng(1, 15) + 1)
		end
	end

--[[
	if obj.timeout then
		-- Meat is still fresh
		message("Ugh!  Raw meat!")
	else
		-- Meat is rotten
		message("Ugh!!!  *Rotten* meat!")
		timed_effect(timed_effect.POISON, rng(1, 15) + 10, rng(1, 15) + 1)
	end
]]

	-- Let monster races be able to do stuff when a corpse is eaten without
	-- having to define an ON_EAT function.  This is primarily for things
	-- like resistances and poisonings you can get from eating a corpse.
	if race.flags[FLAG_ON_CORPSE_EAT] then
		local func = get_function_registry_from_flag(race.flags, FLAG_ON_CORPSE_EAT)
		func(obj)
	end

	-- Different corpses can have different nutrition per pound of meat
	local food_value = get_flag(obj, FLAG_FOOD_VALUE)

	if not obj.timeout then
		-- Meat that isn't fresh loses some of it's nutrition value
		food_value = food_value * 4 / 5
	end

	timed_effect.inc(timed_effect.FOOD, food_value)
end

function food.default_eat_corpse_pre(obj)
end
