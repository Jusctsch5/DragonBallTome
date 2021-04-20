-----------------------------------------------------------
-- Tunnelling
-----------------------------------------------------------

--new_flag("SUBST_ICE")
--new_flag("SUBST_TREE")
--new_flag("EASY_DIG")

load_subsystem("tunnel",
{
	no_digger_msg = "You need to have a shovel or pick in your tool slot.",

	get_dig_power =
		function(how_type, how_what, known, feat, y, x)
			local power = 0

			-- When it doubt, rip its guts out
			if player.inventory[INVEN_TOOL][1] then
				if player.inventory[INVEN_TOOL][1].flags[FLAG_DBT_DIGGER] then
					power = player.inventory[INVEN_TOOL][1].flags[FLAG_DBT_DIGGER]
				end
			end

			if power > 0 then
				power = power + (player.stat(A_STR) / 2)
			end

			return power
		end -- get_dig_power()

	get_digger_name =
		function(how_type, how_what)
			if how_type == kill_wall.how_type.INTRINSIC then
				return "your hands", true
			end

			if how_type == kill_wall.how_type.OBJECT then
				local obj = how_what

				if wield_slot_ideal(obj, true) == INVEN_HANDS then
					return "your hands", true
				end

				local desc = object_desc(obj)
				--if obj.tval == TV_LITE and obj.sval == SV_LITE_TORCH then
				--	-- Get rig of "turns of light" part of desc
				--	desc = gsub(desc, " %(.*%)", "")
				--end

				if is_artifact(obj) then
					return "the " .. desc, tunnel.is_plural(obj)
				else
					return "your " .. desc, tunnel.is_plural(obj)
				end
			end
			return "CAN'T GET DIGGER NAME", false
		end -- get_digger_name()

	-- Special message for burning through web with a torch.
	get_digger_msgs =
		function(feat, y, x, how_type, how_what)
			return nil, nil
		end -- get_digger_msgs()

	is_plural =
		function(obj)
			if obj.tval == TV_GLOVES or obj.tval == TV_BOOTS then
				return true
			end
			return false
		end
})

tunnel.dig_power_desc = {
	[FLAG_SUBST_ROCK]     = "tunnel into rock",
	[FLAG_SUBST_GRANITE]  = "tunnel into granite",
	[FLAG_SUBST_RUBBLE]   = "dig into rubble",
	[FLAG_SUBST_ICE]      = "tunnel into ice",
	[FLAG_DEAD_TREE_FEAT] = "chop down living trees",
	[FLAG_SUBST_TREE]     = "chop down trees",
}

tunnel.add_no_digger_msgs_by_flag {
}

tunnel.add_working_msgs_by_flag {
	[FLAG_SUBST_TREE]   = "You chop away at the @feat@.",
	[FLAG_SUBST_ICE]    = "You tunnel into the @feat@."
}

tunnel.add_done_msgs_by_flag {
	[FLAG_SUBST_TREE]   = "You have cleared away the @feat@.",
	[FLAG_SUBST_ICE]    = "You have removed the @feat@."
}

tunnel.add_min_power_by_flags {
	[FLAG_SUBST_TREE]   = 10,
}

tunnel.add_hardness_by_flags {
	[FLAG_SUBST_TREE]   = 400,
}
