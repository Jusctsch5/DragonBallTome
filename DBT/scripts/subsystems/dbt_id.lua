-- The Dragonball T Identification system

-- This subsystem is intended as a replacement for the
-- standard system, though it can peacefully co-exist
-- with the standard one. It allows any character with
-- sufficient skill to automaticaly identify any item
-- of a pre-defined type. Every TV/SV may have unique
-- skills requirements.

-- It's 98% functional. There are still some oddities
-- related to store items, and a section in desc.lua
-- that hasn't been LUA'fied, but otherwise it's done.

-- Define both of these flags for every time you'd
-- like to work with the system.
new_flag("ID_SKILL")	-- Which skill is used to ID
new_flag("ID_VALUE")	-- Required skill to auto-ID

-- Note: It would be cleaner and easier to hook into
-- item creation than to do it this way, but there
-- appears to not be an item creation hook.

-- Migrated to inventory subsystem
--[[
-- Every time you check your inventory, everything is ID'd
hook(hook.KEYPRESS, function (key)
	if key == strbyte('i') then
		local obj
		for i = player.inventory_limits(INVEN_INVEN), 1, -1 do
			if player.inventory[INVEN_INVEN][i] then
				obj = player.inventory[INVEN_INVEN][i]
				if has_flag(obj, FLAG_ID_SKILL) and has_flag(obj, FLAG_ID_VALUE) then
					if get_skill(obj.flags[FLAG_ID_SKILL]) + player.stat(A_INT) - 10 >= obj.flags[FLAG_ID_VALUE] then
						make_item_fully_identified(obj)
					end
				end
			end
		end
	end
end)
]]

-- Id stuff before we pick it up
hook(hook.GET_PRE, function (obj, item)
	if has_flag(obj, FLAG_ID_SKILL) and has_flag(obj, FLAG_ID_VALUE) then
		if get_skill(obj.flags[FLAG_ID_SKILL]) + player.stat(A_INT) - 10 >= obj.flags[FLAG_ID_VALUE] then
			make_item_fully_identified(obj)
		end
		if dball_data.wish_autoid == 1 then
			make_item_fully_identified(obj)
		end
	end
end)

-- Id stuff before we equip it
hook(hook.WIELD_PRE, function (obj, item)
	if has_flag(obj, FLAG_ID_SKILL) and has_flag(obj, FLAG_ID_VALUE) then
		if get_skill(obj.flags[FLAG_ID_SKILL]) + player.stat(A_INT) - 10 >= obj.flags[FLAG_ID_VALUE] then
			make_item_fully_identified(obj)
		end
		if dball_data.wish_autoid == 1 then
			make_item_fully_identified(obj)
		end
	end
end)

-- This does not behave as itended...but it's better with this than without
hook(hook.OBJECT_DESC, function (obj)
	if has_flag(obj, FLAG_ID_SKILL) and has_flag(obj, FLAG_ID_VALUE) then
		if get_skill(obj.flags[FLAG_ID_SKILL]) + player.stat(A_INT) - 10 >= obj.flags[FLAG_ID_VALUE] then
			make_item_fully_identified(obj)
		end
		if dball_data.wish_autoid == 1 then
			make_item_fully_identified(obj)
		end
	end
end)

