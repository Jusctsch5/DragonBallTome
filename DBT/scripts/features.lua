constant("features", {})

-----------------------------------------------------------
--[[
-- Void jumpgates

function features.make_between_pair(y1, x1, y2, x2)
	local c_ptr1 = cave(y1, x1)
	local feat1  = f_info[c_ptr1.feat + 1]

	local c_ptr2 = cave(y2, x2)
	local feat2  = f_info[c_ptr2.feat + 1]

	if c_ptr1.feat == FEAT_BETWEEN or c_ptr2.feat == FEAT_BETWEEN then
		wiz_print("One of the jumpgate ends already had a jumpgate.")
		return false
	end

	if feat1.flags[FLAG_PERMANENT] or feat2.flags[FLAG_PERMANENT] then
		wiz_print("One of the jumpgate ends was on a permanent feature.")
		return false
	end

	if feat1.flags[FLAG_WALL] or feat2.flags[FLAG_WALL] then
		wiz_print("One of the jumpgate ends was in a wall.")
		return false
	end

	if not feat1.flags[FLAG_FLOOR] or not feat2.flags[FLAG_FLOOR] then
		wiz_print("One of the jumpgate ends had no floor.")
		return false
	end

	cave_set_feat(y1, x1, FEAT_BETWEEN)
	cave_set_feat(y2, x2, FEAT_BETWEEN)

	flag_set_full(c_ptr1.flags, FLAG_COORD, FLAG_FLAG_BOTH, y2, x2)
	flag_set_full(c_ptr2.flags, FLAG_COORD, FLAG_FLAG_BOTH, y1, x1)

	return true
end

function features.do_between()
	local c_ptr = cave(player.py, player.px)

	if c_ptr.feat ~= FEAT_BETWEEN then
		wiz_print("features.do_between() called without a jumpgate")
		return false
	end

	if not c_ptr.flags[FLAG_COORD] then
		wiz_print("Jumpgate doesn't have a destination coordinate")
		return false
	end

	if has_flag(level_flags, FLAG_NO_TELEPORT) or
		player.has_intrinsic(FLAG_RES_CONTINUUM) or
		player.has_intrinsic(FLAG_NO_TELE) then
		message("Something prevents you from entering the jumpgate.")
		return false
	end

	message("You fall into the void.");
	message("Brrrr! It's deadly cold.");

	local y = flag_get( c_ptr.flags, FLAG_COORD)
	local x = flag_get2(c_ptr.flags, FLAG_COORD)

	swap_position(y, x)

	return true
end

-------------------------------------------------------------------------

-- Fountains

function features.fountain_potion_tester(k_idx)
	local item = k_info[k_idx + 1]

	if item.tval == TV_POTION and item.flags[FLAG_FOUNTAIN] then
		return true
	end

	return false
end

function features.fountain_do()
	local c_ptr = cave(player.py, player.px)

	if player.has_intrinsic(FLAG_HALLUCINATE) then
		message("Is that a fountain you see, or the gaping maw of some " ..
				"horrid monster?")
		return
	end

	if c_ptr.feat ~= FEAT_EMPTY_FOUNTAIN and c_ptr.feat ~= FEAT_FOUNTAIN then
		message("You see no fountain here.")
		return
	end

	if c_ptr.feat == FEAT_EMPTY_FOUNTAIN then
		message("The fountain is dried out.")
		return
	end

	-- Do some sanity checking
	local obj = c_ptr.flags[FLAG_FOUNTAIN]

	if not obj then
		message("Strange, the fountain seems to already be dry.")
		cave_set_feat(player.py, player.px, FEAT_EMPTY_FOUNTAIN)
		return
	end

	if obj.number == 0 then
		message("Strange, the fountain seems to already be dry.")
		c_ptr.flags[FLAG_FOUNTAIN] = nil
		cave_set_feat(player.py, player.px, FEAT_EMPTY_FOUNTAIN)
		return
	end

	if not obj.flags[FLAG_ON_QUAFF] then
		message(color.VIOLET, "ERROR: Fountain contains something other " ..
				"than a potion.")
		return
	end

	if not obj.flags[FLAG_FOUNTAIN] then
		message(color.VIOLET, "ERROR: Fountain contains a potion which " ..
				"shouldn't show up in fountains.")
		return
	end

	-- Sanity checks were all good

	-- Can only fill into a bottle when not blind, since if it was
	-- done when blind the character would get info on the color/type
	-- of potion, which is something that has to be seen.
	local prompt = "Do you want to [Q]uaff or [F]ill from the fountain? "
	if player.has_intrinsic(FLAG_BLIND) then
		prompt = "Quaff from the fountain? [y/n] "
	end

	local ret, key = get_com(prompt)
	if not ret then
		return
	end
	key = strlower(strchar(key))

	if player.has_intrinsic(FLAG_BLIND) then
		if key == 'y' then
			features.fountain_quaff()
		end
		return
	end

	if key == 'q' then
		features.fountain_quaff()
	elseif key == 'f' then
		features.fountain_fill()
	end
end -- features.fountain_do()

function features.fountain_consume(amount)
	local c_ptr = cave(player.py, player.px)
	local obj   = c_ptr.flags[FLAG_FOUNTAIN]

	if obj.number < amount then
		obj.number = 0
	else
		obj.number = obj.number - amount
	end

	if obj.number == 0 then
		c_ptr.flags[FLAG_FOUNTAIN] = nil
		cave_set_feat(player.py, player.px, FEAT_EMPTY_FOUNTAIN)
		message("You have emptied the fountain.")
	end
end -- features.fountain_consume()

function features.fountain_quaff()
	local c_ptr  = cave(player.py, player.px)
	local potion = c_ptr.flags[FLAG_FOUNTAIN]

	flag_learn(c_ptr.flags, FLAG_FOUNTAIN, true)
	potions.use_aux(potion)
	features.fountain_consume(1)
end -- features.fountain_quaff()

function features.fountain_fill()
	local c_ptr  = cave(player.py, player.px)
	local potion = c_ptr.flags[FLAG_FOUNTAIN]

	-- Collect all the empty bottles we can use
	local bottle_objs = {}

	__core_objects.clean_get_item()
	for_inventory(player, INVEN_INVEN, INVEN_TOTAL,
		function(obj, inven, slot, item)
			if obj.tval == TV_BOTTLE and
				obj.sval == SV_BOTTLE_EMPTY then
				tinsert(%bottle_objs, {obj=obj, item=item})
			end
		end)

	for_inventory_inven(c_ptr.inventory,
		function(obj, item)
			if obj.tval == TV_BOTTLE and
				obj.sval == SV_BOTTLE_EMPTY then
				item = generate_item_floor_index(obj.iy, obj.ix, item)
				tinsert(%bottle_objs, {obj=obj, item=item})
			end
		end)

	local bottle_amount = 0
	for i = 1, getn(bottle_objs) do
		bottle_amount = bottle_amount + bottle_objs[i].obj.number
	end

	if bottle_amount == 0 then
		message("You have no empty bottles into which to place the potions.")
		return
	end

	local get_num = get_quantity("How many bottles to fill? (1 - " ..
								 bottle_amount ..") ", bottle_amount)

	if get_num <= 0 then
		return
	end

	if get_num > potion.number then
		get_num = potion.number
	end

	if get_num > bottle_amount then
		get_num = bottle_amount
	end

	local out_obj = new_object()
	object_prep(out_obj, potion.k_idx)
	out_obj.number = get_num

	message("You extract " .. object_desc(out_obj, true) .. " from " ..
			"the fountain.")

	for i = getn(bottle_objs), 1, -1 do
		if get_num <= 0 then
			break
		end

		local bottle = bottle_objs[i]

		bottle_amount = bottle.obj.number

		if bottle_amount > get_num then
			bottle_amount = get_num
		end

		item_increase(bottle.item, -bottle_amount)
		item_optimize(bottle.item)

		get_num = get_num - bottle_amount

		features.fountain_consume(bottle_amount)
	end


	inven_carry(out_obj, false)
end -- features.fountain_fill()

hook(hook.KEYPRESS,
function (key)
	if key == strbyte('H') then
		features.fountain_do()
		return true
	end
end)
]]