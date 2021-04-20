-- The Quests for Dr. Briefs

-- As of: V0.8.5
-- Find Buruma: 		Issuable, not completable
-- Tournament Reward: 	Complete
-- First: 			Complete
-- Satan: 			Complete
-- Satan Delivery:	Complete
-- Upgrade:			Complete
-- Random:			Complete

add_quest
{
	global = "QUEST_BRIEFS_FIND_BURUMA"
	name = "Find Buruma",
	desc = {
		"Dr. Briefs of Capsule Corporation mentioned that he has completed work on a",
		"device for his daughter Buruma, and asked you to let her know if you happen",
		"to see her.",
	}
	level = 3
	hooks = {}
}


add_quest
{
    global = "QUEST_BRIEFS_FIRST"
    name = "Time Machine!",
    desc = {
      	"After much effort, the genius scientist, Dr Briefs, has identified the",
		"cause of a problem he has been having with his time machine, and is in",
		"needs of some materials to repair it. He has asked you to bring him a",
		"spool of wire, and a spool of solder."
    }
    level = 99
    hooks = {}
}

add_quest
{
	global = "QUEST_BRIEFS_TOURNAMENT_REWARD"
	name = "Tournament Prize"
	desc = function()
		if quest(QUEST_BRIEFS_TOURNAMENT_REWARD).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yTournament Prize (Danger level: 35)\n" ..
				"Dr. Briefs of Capsule Corporation says that he is a big fan of martial arts " ..
				"tournaments, and has prepared a very 'special' prize to be awarded to the " ..
				"winner of this year's World Tournament. What could it be? Looks like you'll " ..
				"have to win the Tournament first to find out."
			}
			return line
		elseif quest(QUEST_BRIEFS_TOURNAMENT_REWARD).status == QUEST_STATUS_COMPLETED then
			local line = {
				"#GTournament Prize (completed)\n" ..
				"Now that you've won the World Tournament, you're eager to find out " ..
				"about this special prize Dr. Briefs says he's set aside for the winner."
			}
			return line
		end
	end
	level = 35
	hooks =
	{
	}
}
add_quest
{
    global = "QUEST_BRIEFS_UPGRADE"
    name = "Technical Assistant",
    desc = {
      	"Dr. Briefs has agreed to take you on as an assistant on a volunteer basis. You",
		"will be responsible for assembling custom orders for Capsule Corporation as an",
		"unpaid intern. However, he has asked you to supply your own tools. In particular,",
		"he has asked you to find both mechanical and electrical toolkits, as well as a",
		"chemistry kit. Once you have all three simply show up at his laboratory, and",
		"you can begin.",
    }
    level = 1
    hooks = {}
}


add_quest
{
    global = "QUEST_BRIEFS_SATAN"
    name = "Battery for Mr Satan",
    desc = {
 		"Dr. Briefs has asked you to retreive a battery for him to install in an",
		"electric muscle stimulator for a wealthy client who's a famous tournament",
		"fighter who goes by the stage name of Mr. Satan. Once the device is repaired,",
		"surely Dr Briefs will let you make the delivery for him as well. This could be",
		"your chance to size up the competition for the World Tournament!",
    }
    level = 3
    hooks = {}
}

add_quest
{
	global = "QUEST_BRIEFS_SATAN_DELIVERY"
	name = "Martial Arts Deliery Service",
	desc = {
		"After having repaired the muscle stimulator, Dr. Briefs has asked you to",
		"deliver to its owner, Mr. Satan. The gate guard will let you in now.",
	}
	level = 10
	hooks = {}
}


add_quest
{
	global = "QUEST_BRIEFS_RANDOM"
	name = "Errand for Dr. Briefs",
	desc = function()
		-- ?????
		if quest(QUEST_BRIEFS_RANDOM).status == QUEST_STATUS_TAKEN then
			local line = {
					"#yErrand for Dr. Briefs (Danger level: 1)",
					"Dr. Briefs has asked you to assemble:"
				}
			if drbriefs.quest_qty1 > 0 then
				local obj = new_object()
				object_prep(obj, drbriefs.quest_kidx1)
				obj.number = drbriefs.quest_qty1
				make_item_fully_identified(obj)
				tinsert(line, " * " .. drbriefs.quest_qty1 .. " " .. object_desc(obj))
				delete_object(obj)
			end

			if drbriefs.quest_qty2 > 0 then
				local obj = new_object()
				object_prep(obj, drbriefs.quest_kidx2)
				obj.number = drbriefs.quest_qty2
				make_item_fully_identified(obj)
				tinsert(line, " * " .. drbriefs.quest_qty2 .. " " .. object_desc(obj))
				delete_object(obj)
			end

			return line
		end
	end
    level = 1
    hooks = {}
}

constant("drbriefs", {})

add_loadsave("drbriefs.intro", 0)
add_loadsave("drbriefs.polite_done", 0)
add_loadsave("drbriefs.quest_no", 0)
add_loadsave("drbriefs.quest_rating", 0)
add_loadsave("drbriefs.quest_issued", 0)
add_loadsave("drbriefs.quest_kidx1", 0)
add_loadsave("drbriefs.quest_qty1", 0)
add_loadsave("drbriefs.quest_kidx2", 0)
add_loadsave("drbriefs.quest_qty2", 0)

-- Called by dball.data_clearing
function drbriefs.clear_data()
	drbriefs.quest_no = 0	-- 1 is fixed, thereafter is random, 11 quests total
	drbriefs.quest_rating = 0
	drbriefs.quest_issued = 0
	drbriefs.quest_kidx1 = 0
	drbriefs.quest_qty1 = 0
	drbriefs.quest_kidx2 = 0
	drbriefs.quest_qty2 = 0
end

function drbriefs.upgrade_check()
	local br_mechkit = 0
	local br_eleckit = 0
	local br_chemkit = 0
	for i = 1, player.inventory_limits(INVEN_INVEN) do
		if player.inventory[INVEN_INVEN][i] then
			if player.inventory[INVEN_INVEN][i].k_idx == lookup_kind(TV_ELECTRONICS, SV_MECHANICAL_TOOLKIT) then br_mechkit = 1 end
			if player.inventory[INVEN_INVEN][i].k_idx == lookup_kind(TV_ELECTRONICS, SV_ELECTRICAL_TOOLKIT) then br_eleckit = 1 end
			if player.inventory[INVEN_INVEN][i].k_idx == lookup_kind(TV_ELECTRONICS, SV_CHEMISTRY_KIT) then br_chemkit = 1 end
		end
	end

	if br_mechkit + br_eleckit + br_chemkit == 3 then
		return true
	end
	return false
end

function drbriefs.deliver_item(k_idx, qty)

	if qty == 0 then
		return 0
	end

	local item
	local obj
	local adj_qty

	for i = 1, player.inventory_limits(INVEN_INVEN) do
		obj = player.inventory[INVEN_INVEN][i]
		if obj and obj.k_idx == k_idx then
			item = i
		end
	end

	if not item then
		return 0
	end

	obj = player.inventory[INVEN_INVEN][item]


	if qty > obj.number then
		adj_qty = obj.number
	else
		adj_qty = qty
	end

	local ret, raw_key, key
	ret, raw_key = get_com("Hand over your " .. object_desc(obj) .. "? (y/n)")

	if not ret then
		return 0
	end

	key = strlower(strchar(raw_key))

	if key ~= 'y' then
		return 0
	end

	item_increase(item, -adj_qty)
	item_describe(item)
	item_optimize(item)
	return adj_qty
end
