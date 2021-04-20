-- Targetting system customization

target.PATH_GOOD_COLOR = color.AQUAMARINE
target.PATH_WRONG_COLOR = color.CRIMSON

target.extra_display = function(flags, mode, coords, cur, cur_desc)
	local ret, wid, hgt = term.get_size()
	local key = "any key"
	if flags.target_key then key = "'"..flags.target_key.."'" end
	local monst = ""
	if coords[cur] and coords[cur].y and coords[cur].x and cave(coords[cur].y, coords[cur].x).m_idx > 0 then monst = "Monster memory: 'r', " end
	term.c_prt(color.ORANGE,"Target: [Move: Dir keys, "..monst.."Free look: 'o', Accept: "..key.."]", hgt - 1, 0)
end

target.describe_stuff =
{
	[target.MONSTER] = function(flags, mode, descs, m_idx, monst)
		local prefix
		local status = is_friend(monst)
		if status < 0 then prefix = "Enemy"
		elseif status > 0 then prefix = "Ally"
		else prefix = "Neutral" end

--		if party.is_partied(monst.m_idx) then
--			prefix = "(Party)"
--		end

		local wiz = ""
		if wizard then wiz = ", m_idx "..m_idx end
		tinsert(descs, prefix.."("..factions.faction_names[monst.faction].."): "..monster_desc(monst, 8).." (Level "..monst.level..wiz..")")
	end
	[target.OBJECT] = function(flags, mode, descs, c_ptr)
		for_inventory_inven(c_ptr.inventory, function(obj)
			if obj.marked > 0 then
				tinsert(%descs, "Object: "..object_desc(obj, 0))
			end
		end)
	end
	[target.TRAP] = function(flags, mode, descs, c_ptr, y, x)
		local desc
		if get_num_location_traps(y, x, true, -1, false, false) > 1 then desc = "multiple traps"
		else
			local trap = traps.get_trap(-1, -1, y, x)
			local idx = flag_get(trap, FLAG_TRAP_IDX)
			local level = flag_get(trap, FLAG_LEVEL)

			if traps.is_ident(idx) then
				desc = traps.ident_name(idx, trap)
				if wizard then desc = desc.."(level "..level..")" end
			else
				desc = "an unknown trap";
			end
		end
		tinsert(descs, "Trap: "..desc)
	end
	[target.CAVE] = function(flags, mode, descs, c_ptr, y, x)
		if wizard or (c_ptr.info & CAVE_MARK > 0) or player_can_see_bold(y, x) then
			local feat = c_ptr.feat
			if c_ptr.mimic > 0 then feat= c_ptr.mimic end

			local wiz = ""
			if wizard then wiz = ", feat "..c_ptr.feat..", mimic "..c_ptr.mimic..", info "..c_ptr.info end

			local desc = "Terrain: "..f_info[1 + feat].name
			if cave_feat_is(c_ptr, FLAG_CONTAINS_BUILDING) then
				if ((get_flag(c_ptr, FLAG_CONTAINS_BUILDING) + 1) > __st_num)
				then
					tinsert(descs, "WARNING: Unimplemented store!")
					return
				end
				desc = "Building: "..
					st_info(get_flag(c_ptr, FLAG_CONTAINS_BUILDING)).name
			elseif c_ptr.flags[FLAG_DUNGEON] then desc = "There is "..dungeon(get_flag(c_ptr, FLAG_DUNGEON)).text
			elseif c_ptr.feat == FEAT_TOWN then desc = "Town: "..wf_info[wild_map(y, x).feat + 1].name.."("..wf_info[wild_map(y, x).feat + 1].text..")"
			elseif cave_feat_is(c_ptr, FLAG_TERRAIN_NAME) then desc = "Terrain: "..c_ptr.flags[FLAG_TERRAIN_NAME]
			end

			tinsert(descs, desc..wiz)
		else
			tinsert(descs, "Terrain: Unknown grid")
		end
	end
}
