-- Dragonball T: AI for Namekian Leviathan

ai.new
{
	name	= "LEVIATHAN"
	exec	= function(m_idx, monst, state)
		local spl = flag_get_rand(monst.spells)
		local range = flag_get(state, FLAG_BEST_RANGE)
		local dist = ai.distance(monst)
		local y, x = ai.target(monst)

		-- Leviathan submerge when they're not chasing prey
		if dball_data.flying_high > 0 then
			monst.flags[FLAG_INVISIBLE] = true
			ai.exec(ai.DBT_RANDOM, m_idx, monst)
		elseif dist > 9 then
			monst.flags[FLAG_INVISIBLE] = true
			if cave(player.py, player.px).feat ~= FEAT_NAMEK_WATER then
				ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
			else
				ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
			end
		else
			monst.flags[FLAG_INVISIBLE] = false
			ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
		end
	end
}
