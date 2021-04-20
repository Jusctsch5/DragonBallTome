-- Monster combat

load_subsystem("monster_combat", {
	test_hit = function(power, level, ac, luck)
		-- What is power?
		local k = rng.number(100)
		if k <= 5 then
			return true
		elseif k + power + (level * 5) >= ac then
			return true
		else
			return false
		end
	end
	
	on_hit = function(y, x, c_ptr, m_idx, m_ptr, t_idx, t_ptr, t_flags, blow, params, special)
		-- only one of cut or stun
		if special.cut and special.stun then
			-- Cancel cut
			if (rng.number(100) < 50) then
				special.cut = 0
			-- Cancel stun
			else
				special.stun = 0
			end
		end

		-- Handle cut
		if (special.cut) then
			local k =0

			-- Critical hit (zero if non-critical)
			local tmp = combat_monster.default.critical_hit(blow.d_dice, blow.d_side, params.dam)

			-- Roll for damage
			local t =
			{
				[0] = 0,
				[1] = rng(5),
				[2] = rng(5) + 5,
				[3] = rng(20) + 20,
				[4] = rng(50) + 50,
				[5] = rng(100) + 100,
				[6] = 300,
			}
			if t[tmp] then k = t[tmp]
			else k = 500 end

			-- Apply the cut
			if (k > 0) then
				if t_ptr == player then
					timed_effect(timed_effect.CUT, k, 1)
				else
					monster_msg(strcap(t_name).." is bleeding.", t_ptr.ml)
					t_ptr.bleeding = t_ptr.bleeding + k
				end
			end
		end

		-- Handle stun
		if (special.stun) then
			local k = 0

			-- Critical hit (zero if non-critical)
			local tmp = combat_monster.default.critical_hit(blow.d_dice, blow.d_side, params.dam)

			-- Roll for damage
			local t =
			{
				[0] = 0,
				[1] = rng(5),
				[2] = rng(10) + 10,
				[3] = rng(20) + 20,
				[4] = rng(30) + 30,
				[5] = rng(40) + 40,
				[6] = 100,
			}
			if t[tmp] then k = t[tmp]
			else k = 200 end

			-- Apply the stun
			if (k > 0) then
				if t_ptr == player then
					timed_effect(timed_effect.STUN, k, 1)
				end
			end
		end
	end
})

-- All the monster attack methods
add_monster_attack_method
{
	["name"]	= "HIT",
	["desc"]	= "hit",
	["action"]	= "hits @target@",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
		special.stun = true
		special.cut = true
	end,
}
add_monster_attack_method
{
	["name"]	= "TOUCH",
	["desc"]	= "touch",
	["action"]	= "touches @target@",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
	end,
}
add_monster_attack_method
{
	["name"]	= "PUNCH",
	["desc"]	= "punch",
	["action"]	= "punches @target@",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
		special.stun = true
	end,
}
add_monster_attack_method
{
	["name"]	= "KICK",
	["desc"]	= "kick",
	["action"]	= "kicks @target@",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
		special.stun = true
	end,
}
add_monster_attack_method
{
	["name"]	= "BONK",
	["desc"]	= "bonk",
	["action"]	= "bonks @target@ on the head",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
		special.stun = true
	end,
}
add_monster_attack_method
{
	["name"]	= "CLAW",
	["desc"]	= "claw",
	["action"]	= "claws @target@",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
		special.cut = true
	end,
}
add_monster_attack_method
{
	["name"]	= "BITE",
	["desc"]	= "bite",
	["action"]	= "bites @target@",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
		special.cut = true

		local m = monster(m_idx)
	end,
}
add_monster_attack_method
{
	["name"]	= "STING",
	["desc"]	= "sting",
	["action"]	= "stings @target@",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
	end,
}

add_monster_attack_method
{
	["name"]	= "CRUSH",
	["desc"]	= "crush",
	["action"]	= "crushes @target@",
	["fct"]		= function(special, type, m_idx)
		special.touched = true
		special.stun = true
	end,
}

-- All monster attack types
add_monster_attack_type
{
	["name"]	= "HURT",
	["desc"]	= "hurt",
	["power"]	= 60,
	["type"]	= dam.PURE,
	["obvious"]	= true,
}
add_monster_attack_type
{
	["name"]	= "SLASH",
	["desc"]	= "slash",
	["power"]	= 60,
	["type"]	= dam.SLASH,
	["obvious"]	= true,
}
add_monster_attack_type
{
	["name"]	= "CRUSH",
	["desc"]	= "crush",
	["power"]	= 60,
	["type"]	= dam.CRUSH,
	["obvious"]	= true,
}
add_monster_attack_type
{
	["name"]	= "PIERCE",
	["desc"]	= "pierce",
	["power"]	= 60,
	["type"]	= dam.PIERCE,
	["obvious"]	= true,
}
add_monster_attack_type
{
	["name"]	= "CUT",
	["desc"]	= "cut",
	["power"]	= 60,
	["type"]	= dam.CUT,
	["obvious"]	= true,
}
add_monster_attack_type
{
	["name"]	= "POISON",
	["desc"]	= "poison",
	["power"]	= 5,
	["type"]	= dam.POIS,
	["obvious"]	= true,
}
add_monster_attack_type
{
	["name"]	= "FEAR",
	["desc"]	= "scare",
	["power"]	= 5,
	["type"]	= dam.FEAR,
	["obvious"]	= true,
}
add_monster_attack_type
{
	["name"]	= "EAT_GOLD",
	["desc"]	= "steal gold",
	["power"]	= 5,
	["type"]	= dam.PURE,
	["obvious"]	= true,
	["player"]	= function(params, special, method, m_idx)
		if dball_data.tourny_now == 1 then
			return
		end
		-- Saving throw (unless paralyzed) based on dex and level
		if (not player.has_intrinsic(FLAG_PARALYZED)) and (rng.number(100) < (player.stat(A_DEX) + player.lev)) then
			-- Saving throw message
			message("You quickly protect your money pouch!")

			-- Occasional blink anyway
			-- if (rng.number(3)) then special.blinked = true end
			special.blinked = false
		else
		-- Eat gold
			local gold = (player.au / 10) + rng(25)
			if (gold < 2) then gold = 2 end
			if (gold > 5000) then gold = (player.au / 20) + rng(3000) end
			if (gold > player.au) then gold = player.au end
			player.au = player.au - gold

			if (gold <= 0) then
				message("Nothing was stolen.")
			elseif (player.au > 0) then
				message("Your purse feels lighter.")
				msg_format("%d coins were stolen!", gold)
			else
				message("Your purse feels lighter.")
				message("All of your coins were stolen!")
			end

			while (gold > 0) do
				local j_ptr = new_object()

				-- Prepare a gold object
				object_prep(j_ptr, lookup_kind(TV_GOLD, 9))

				-- Determine how much the treasure is "worth"
				if gold < 15000 then
					set_flag(j_ptr, FLAG_GOLD_VALUE, gold)
				else
					set_flag(j_ptr, FLAG_GOLD_VALUE, 15000)
				end

				monster_carry(monster(m_idx), m_idx, j_ptr)

				gold = gold - 15000
			end

			-- Redraw gold
			flag_set(player.redraw, FLAG_PR_GOLD,1)

			-- Window stuff
			-- player.window = player.window | PW_PLAYER
			-- player.redraw[FLAG_PR_BASIC] = true

			-- Only blink away if the player has nothing more to steal
			if player.au == 0 then
				-- Several monsters use this...customize the name!
				message("He disappears into the woods!")
				special.blinked = true
			else
				special.blinked = false
			end
		end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "EAT_ITEM",
	["desc"]	= "steal item",
	["power"]	= 5,
	["type"]	= dam.PURE,
	["obvious"]	= true,
	["player"]	= function(params, special, method, m_idx)
		if dball_data.tourny_now == 1 then
			return
		end
		-- Saving throw (unless paralyzed) based on dex and level
		if (not player.has_intrinsic(FLAG_PARALYZED)) and (rng.number(100) < (player.stat(A_DEX) + player.lev)) then
			-- Saving throw message
			message("You grab hold of your backpack!");

			-- Occasional "blink" anyway
			special.blinked = true;

			-- Obvious
			special.obvious = true;
		else
			-- Find an item
			for k = 0, 9 do
				-- Pick an item
				local i = rng(player.inventory_limits(INVEN_INVEN))

				-- Obtain the item
				local o_ptr = player.inventory[INVEN_INVEN][i]

				-- Skip non-objects
				if ((o_ptr) and (is_artifact(o_ptr) == nil)) then
					-- Get a description
					local o_name = object_desc(o_ptr, false, 3)

					-- Message
					local target = "Your"
					if o_ptr.number > 1 then target = "One of your" end
					msg_format("%s %s was stolen!", target, o_name)

					local j_ptr = object_dup(o_ptr)

					-- Modify number
					j_ptr.number = 1;

					-- Forget mark
					-- This line appears to generate
					-- an error?
					--j_ptr.marked = false

					monster_carry(monster(m_idx), m_idx, j_ptr)

					-- Steal the items
					item_increase(compute_slot(INVEN_INVEN, i), -1)
					item_optimize(compute_slot(INVEN_INVEN, i))

					-- Obvious
					special.obvious = true

					-- Blink away
					special.blinked = true

					-- Done
					break
				end
			end
		end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "EAT_DRAGONBALL",
	["desc"]	= "steal dragonballs",
	["power"]	= 5,
	["type"]	= dam.PURE,
	["obvious"]	= true,
	["player"]	= function(params, special, method, m_idx)
		if dball_data.tourny_now == 1 then
			return
		end

		--message("Y")
		-- special.blinked = true
		--hp_player(10000)

		local issue_quest = false
		local monst = monster(m_idx)
		local m_name = monster_desc(monst, 0)
		if dball.dragonballs_carried() < 1 then
			message( m_name .. " reaches into your pack!");
			if (rng.number(100) < 25) then
				message("Not finding what he's looking for, he vanishes!");
				special.obvious = true
				issue_quest = true
				if m_name == "Bear Thief" and dball.current_location() ~= "Bear Cave" then
				else
					teleport_away(m_idx, 100)
				end
			end
		else

			-- Saving throw (unless paralyzed) based on dex and level
			if (not player.has_intrinsic(FLAG_PARALYZED)) and (rng.number(100) < (player.stat(A_DEX) + player.lev)) then
				-- Saving throw message
				message("You stop " .. m_name .. " from stealing a dragonball!");
				special.obvious = true;
			else

				local obj
				for i = 1, player.inventory_limits(INVEN_INVEN) do
					if player.inventory[INVEN_INVEN][i] then
						obj = player.inventory[INVEN_INVEN][i]
						if obj and obj.tval == TV_DBALL then
							item_increase(i, -1)
							item_optimize(i)
							message(m_name .. " steals a dragonball from you, and vanishes!!!")
							if m_name == "Hasuki, the thief" then
								dball_data.hasuki_dbs = dball_data.hasuki_dbs + 1
							elseif m_name == "Bear Thief" then
								dball_data.bear_thief_dbs = dball_data.bear_thief_dbs + 1
							end
							special.obvious = true;
							issue_quest = true
							delete_monster_idx(m_idx)
						end
					end
				end
			end
		end

		if issue_quest == true then
			if m_name == "Hasuki, the thief" then
				change_quest_status(QUEST_HASUKI, QUEST_STATUS_TAKEN)
			elseif m_name == "Bear Thief" then
				change_quest_status(QUEST_BEAR_THIEF, QUEST_STATUS_TAKEN)
			end
		end

	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "EAT_FOOD",
	["desc"]	= "eat food",
	["power"]	= 5,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		if dball_data.tourny_now == 1 then
			return
		end
		-- Steal some food
		special.obvious = false
		for k = 0, 9 do
			-- Pick an item from the pack
			local i = rng(player.inventory_limits(INVEN_INVEN))

			-- Get the item
			local o_ptr = player.inventory[INVEN_INVEN][i]

			-- Skip non-objects
			if (o_ptr) and (o_ptr.tval == TV_FOOD) then
				-- Get a description
				local o_name = object_desc(o_ptr, false, 0)

				-- Message
				local target = "Your"
				if o_ptr.number > 1 then target = "One of your" end
				msg_format("%s %s was eaten!", target, o_name)

				-- Steal the items
				item_increase(i, -1)
				item_optimize(i)

				-- Obvious
				special.obvious = true

				-- Done
				break
			end
		end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "DEMON_PICCOLO",
	["desc"]	= "crush",
	["power"]	= 60,
	["type"]	= dam.CRUSH,
	["obvious"]	= true,
	["player"]	= function(params, special, method, m_idx)
		dball_data.piccolo_hurt_player = dball_data.piccolo_hurt_player + 1
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "ELEC",
	["desc"]	= "electrocute",
	["power"]	= 10,
	["type"]	= dam.ELEC,
	["obvious"]	= true,
	["player"]	= function(params, special, method, m_idx)
		message("You are struck by electricity!")
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "FIRE",
	["desc"]	= "burn",
	["power"]	= 10,
	["type"]	= dam.FIRE,
	["obvious"]	= true,
	["player"]	= function(params, special, method, m_idx)
		message("You are enveloped in flames!")
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "COLD",
	["desc"]	= "freeze",
	["power"]	= 10,
	["type"]	= dam.COLD,
	["obvious"]	= true,
	["player"]	= function(params, special, method, m_idx)
		message("You are covered with frost!")
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "BLIND",
	["desc"]	= "blind",
	["power"]	= 5,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = false

		-- Increase "blind"
		if not player.has_intrinsic(FLAG_RES_BLIND) then
			timed_effect.inc(timed_effect.BLIND,
							10 + rng(monster(m_idx).level))
			special.obvious = true
		end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "HALLU",
	["desc"]	= "hallucinate",
	["power"]	= 5,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = true

		timed_effect.inc(timed_effect.HALLUCINATE,
						10 + rng(monster(m_idx).level))
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "PARALYZE",
	["desc"]	= "paralyze",
	["power"]	= 5,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
			message("IMPLEMENT PARALYZE!")
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "CONFUSE",
	["desc"]	= "confuse",
	["power"]	= 5,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		project(m_idx, 0, player.py, player.px, params.dam, dam.CONFUSE,
				PROJECT_JUMP | PROJECT_STOP | PROJECT_KILL | PROJECT_HIDE |
				PROJECT_HIDE_BLAST | PROJECT_NO_REFLECT)
	end,
	["monster"]	= function(params, special, method, m_idx)
		mon = monster(m_idx)
		project(m_idx, 0, mon.fy, mon.fx, params.dam, dam.CONFUSE,
				PROJECT_JUMP | PROJECT_STOP | PROJECT_KILL | PROJECT_HIDE |
				PROJECT_HIDE_BLAST | PROJECT_NO_REFLECT)
	end,
}
add_monster_attack_type
{
	["name"]	= "TERRIFY",
	["desc"]	= "scare",
	["power"]	= 5,
	["type"]	= dam.FEAR,
	["player"]	= function(params, special, method, m_idx)
		project(m_idx, 0, player.py, player.px, params.dam, dam.FEAR,
				PROJECT_JUMP | PROJECT_STOP | PROJECT_KILL | PROJECT_HIDE |
				PROJECT_HIDE_BLAST | PROJECT_NO_REFLECT)
	end,
	["monster"]	= function(params, special, method, m_idx)
		mon = monster(m_idx)
		project(m_idx, 0, mon.fy, mon.fx, params.dam, dam.FEAR,
				PROJECT_JUMP | PROJECT_STOP | PROJECT_KILL | PROJECT_HIDE |
				PROJECT_HIDE_BLAST | PROJECT_NO_REFLECT)
	end,
}
add_monster_attack_type
{
	["name"]	= "LOSE_STR",
	["desc"]	= "reduce strength",
	["power"]	= 0,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = false
		if (do_dec_stat(A_STR, STAT_DEC_NORMAL)) then special.obvious = true end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "LOSE_INT",
	["desc"]	= "reduce intelligence",
	["power"]	= 0,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = false
		if (do_dec_stat(A_INT, STAT_DEC_NORMAL)) then special.obvious = true end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "LOSE_WIL",
	["desc"]	= "reduce willpower",
	["power"]	= 0,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = false
		if (do_dec_stat(A_WIL, STAT_DEC_NORMAL)) then special.obvious = true end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "LOSE_DEX",
	["desc"]	= "reduce dexterity",
	["power"]	= 0,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = false
		if (do_dec_stat(A_DEX, STAT_DEC_NORMAL)) then special.obvious = true end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "LOSE_CON",
	["desc"]	= "reduce constitution",
	["power"]	= 0,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = false
		if (do_dec_stat(A_CON, STAT_DEC_NORMAL)) then special.obvious = true end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "LOSE_CHR",
	["desc"]	= "reduce charisma",
	["power"]	= 0,
	["type"]	= dam.PURE,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = false
		if (do_dec_stat(A_CHR, STAT_DEC_NORMAL)) then special.obvious = true end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
--[[
add_monster_attack_type
{
	["name"]	= "LOSE_ALL",
	["desc"]	= "ruin",
	["power"]	= 2,
	["type"]	= dam.PURE,
	["obvious"]	= true,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = false
		if (do_dec_stat(A_STR, STAT_DEC_NORMAL)) then special.obvious = true end
		if (do_dec_stat(A_CON, STAT_DEC_NORMAL)) then special.obvious = true end
		if (do_dec_stat(A_DEX, STAT_DEC_NORMAL)) then special.obvious = true end
		if (do_dec_stat(A_INT, STAT_DEC_NORMAL)) then special.obvious = true end
		if (do_dec_stat(A_WIL, STAT_DEC_NORMAL)) then special.obvious = true end
		if (do_dec_stat(A_CHR, STAT_DEC_NORMAL)) then special.obvious = true end
		if (do_dec_stat(A_SPD, STAT_DEC_NORMAL)) then special.obvious = true end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
add_monster_attack_type
{
	["name"]	= "DISEASE",
	["desc"]	= "disease",
	["power"]	= 5,
	["type"]	= dam.POIS,
	["player"]	= function(params, special, method, m_idx)
		special.obvious = FALSE

		-- Damage CON (10% chance)
		if (rng(100) < 11) then
			-- 1% chance for perm. damage
			local perm = STAT_DEC_NORMAL
			if rng(10) == 1 then perm = STAT_DEC_PERMANENT end
			if (dec_stat(A_CON, rng(10), perm)) then special.obvious = true end
		end
	end,
	["monster"]	= function(params, special, method, m_idx)
	end,
}
]]
-----------------------------------------------------------------

function default_monster_drop(m_idx, m_ptr, r_ptr)
	-- No treasure drops in the World Tournament
	if dball.current_location() == "World Tournament" then
		return
	end

	local dflags = flag_new()

	-- Could probably get rid of the error and just return
	-- If there's no theme, then don't drop anything. What's
	-- the problem?
	if not r_ptr.flags[FLAG_DROP_THEME] then
		-- error("default_monster_drop(): no drop theme for race " .. r_ptr.name)
		return
	end

	local num_drop = 0

	if has_flag(r_ptr, FLAG_DROP_60) and rng.number(100) < 60 then
		num_drop = num_drop + 1
	end
	if has_flag(r_ptr, FLAG_DROP_90) and rng.number(100) < 90 then
		num_drop = num_drop + 1
	end
	if has_flag(r_ptr, FLAG_DROP_NUMBER) then
		num_drop = num_drop + rng(get_flag(r_ptr, FLAG_DROP_NUMBER), get_flag2(r_ptr, FLAG_DROP_NUMBER))
	end


	if num_drop > 0 then
		local good  = has_flag(r_ptr, FLAG_DROP_GOOD)
		local great = has_flag(r_ptr, FLAG_DROP_GREAT)

		local only_gold = has_flag(r_ptr, FLAG_ONLY_GOLD)
		local only_item = has_flag(r_ptr, FLAG_ONLY_ITEM)
	
		if only_gold and only_item then
			message(color.VIOLET, "ONLY_ITEM *and* ONLY_GOLD for race " .. r_ptr.name)
			return
		end

		-- Don't mess with the actual flag set
		local drop_flags = flag_new()
		flag_copy(drop_flags, flag_get_flags(r_ptr.flags, FLAG_DROP_THEME))

		if only_item then
			flag_set(drop_flags, FLAG_THEME_TREASURE, 0)
		elseif only_gold then
			drop_flags = flag_new()
			flag_set(drop_flags, FLAG_THEME_TREASURE, 100)
		end

		local old_level = object_level
		object_level = (dun_level + r_ptr.level) / 2

		local e_chance = 5 + (dun_level / 5)
		if e_chance < 50 then
			e_chance = 50
		end
		local egos = { single_chance=e_chance double_chance=0 }
		local artifact_chance = 1 + (dun_level / 5)
		if artifact_chance > 20 then
			artifact_chance = 20
		end

		if great then
			egos = { single_chance=70 double_chance=0 }
			artifact_chance = 5
		elseif good then
			egos = { single_chance=20 double_chance=0 }
			artifact_chance = 1
		end

		for i = 1, num_drop do
			local obj_level = (dun_level + r_ptr.level) / 2
			local obj = rand_obj.get_themed_obj(object_level, drop_flags)
			-- local obj = rand_obj.get_themed_obj(object_level, drop_flags, nil, egos, artifact_chance, good or great)

			if obj then
				dball.egoify(obj, e_chance)
				local obj_power = objects_get_power_level(obj, obj_level, false, false, false)
				objects_on_make_all(obj, obj_power)

				obj.found      = OBJ_FOUND_MONSTER
				obj.found_aux1 = m_ptr.r_idx
				obj.found_aux2 = m_ptr.ego
				obj.found_aux3 = current_dungeon_idx
				obj.found_aux4 = level_or_feat(current_dungeon_idx, dun_level)

				monster_carry(m_ptr, m_idx, obj)
			elseif wizard then
				message(color.VIOLET, "Theme drop item creation " .. "attempt " .. i .. " failed for race " .. r_ptr.name)
			end
		end

		object_level = old_level

	end -- end: if num_drop > 0

	-- Do we drop a dragonball?

	-- Base chance 2:1000 for everybody
	local chance = 2

	-- Except plants and animals, who generally don't carry them
	if has_flag(r_ptr, FLAG_PLANT) or has_flag(r_ptr, FLAG_ANIMAL) then
		chance = -1
	end

	-- But uniques have a base of 20:1000
	if has_flag(r_ptr, FLAG_UNIQUE) then
		chance = 20
	end

	-- But...Immortal beings don't drop them even if they are unique
	if has_flag(r_ptr, FLAG_IMMORTAL) then
		chance = -1
	end

	-- But, if r_info specifies odds, use those instead
	if r_ptr.flags[FLAG_DROP_DRAGONBALL] then
		chance = r_ptr.flags[FLAG_DROP_DRAGONBALL] * 10
	end

	-- The Earth Dragonballs do not spawn off-world
	if not dball.am_i_on_earth() then
		chance = -1
	end

	-- And finally, if we have this, don't drop a ball no matter what
	if has_flag(r_ptr, FLAG_FORCE_NO_DBALL) then
		chance = -1
	end


	-- Do we try to drop a Dragonball?
	if rng(1, 1000) <= chance then

		-- Yes! Now, figure out if a drop is possible, and identify which ball to drop
		local yay_a_dragonball = dball.request_dragonball()

		if yay_a_dragonball then
			-- Note for the dragon radar:
			dball_data.dragon_radar = dball_data.dragon_radar + 1

			yay_a_dragonball.found      = OBJ_FOUND_MONSTER
			yay_a_dragonball.found_aux1 = m_ptr.r_idx
			yay_a_dragonball.found_aux2 = m_ptr.ego
			yay_a_dragonball.found_aux3 = current_dungeon_idx
			yay_a_dragonball.found_aux4 = level_or_feat(current_dungeon_idx, dun_level)

			monster_carry(m_ptr, m_idx, yay_a_dragonball)
			dball_data.dragon_radar = dball_data.dragon_radar + 1
		else
			if wizard then
				message("A monster requested a dragonball, but none are available. Nyeh!")
			end
		end		
	end
end

--------------------------------------------------------------------------

new_flag("DO_DROP_CORPSE", true)
new_flag("DROP_CORPSE_FORCE")
hook(hook.DO_DROP_CORPSE,
function(m_ptr)
	local chance = 10

	chance = item_hooks.process_all_chain_pack(FLAG_DO_DROP_CORPSE, chance, m_ptr)

	-- HACK: No corpse drops in locations that are generally for friendly duels
	if dball.current_location() == "World Tournament" then
		return false
	elseif dball.current_location() == "Duel vs Sumo" then
		return false
	elseif dball.current_location() == "Duel vs Judo" then
		return false
	end

	-- No corpse if we're explicity dueling
	if m_ptr.flags[FLAG_FACTION] == FACTION_DUEL then
		return false
	end

	-- Unique Battle Jacket monster variants shouldn't drop battle jacket corpses
	if m_ptr.flags[FLAG_DBT_FORCE_NO_CORPSE] then
		return false
	end

	if m_ptr.flags[FLAG_DROP_CORPSE_FORCE] then
		return true
	end

	-- Otherwise, uniques ALWAYS drop corpses
	if m_ptr.flags[FLAG_UNIQUE] then
		return true
	end

	if chance and rng.percent(chance) then
		return true
	end
end)

function monster_regen(m_idx, monst)
	if monst.hp < monst.maxhp then
		local regen
		regen = flag_get(monst.flags, FLAG_REGENERATE)

		if regen then
			local nb = abs(regen)
			local amt = nb / 1000
			local im = imod(nb, 1000)
			if im ~= 0 then
				if imod(turn / 10, 1000 / im) == 0 then
					amt = amt + 1
				end
			end

			if amt ~= 0 then
				if regen < 0 then amt = -amt end
				monst.hp = monst.hp + amt
				if monst.hp > monst.maxhp then monst.hp = monst.maxhp end
			end
		end
	end

	-- ??? I presume this reduces counters...not just clears effects?
	-- Get rid of whatever effecst it might have
	monster_effect.timeout(m_idx, monst)
end
