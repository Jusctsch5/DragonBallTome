-- This should recreate pre-alpha6 behavior

ai.new
{
	name	= "DBT_DEFAULT"
	state	=
	{
	}
	init	= function(monst, state)
	end
	exec	= function(m_idx, monst, state)

		-- Ignroe party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		if has_flag(monst, FLAG_CAN_SPEAK) then
			if rng(1,12) == 1 then
				if los(monst.fy, monst.fx, player.py, player.px) then
					local r_ptr = r_info[monst.r_idx + 1]
					local func = get_function_registry_from_flag(r_ptr.flags, FLAG_CAN_SPEAK)
					func(monster_desc(monst, 0))
				end
			end
		end

		-- This does not work as intended!
		-- If spells{} is not defined, monst.freq_spell
		-- winds up as 144 for some reason
		local foo = monst.freq_spell or 0
		if rng.percent(foo) then
			ai.exec(ai.RANDOM_CAST, m_idx, monst)
			return
		else
			ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
		end
	end
}
