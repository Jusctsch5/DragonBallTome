-- Dragonball T: ai for monsters that are zombie + throw
-- Only necesary so throw only occurs when adjacent to player

ai.new
{
	name	= "DBT_THROWER"
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

		if distance(player.py, player.px, monst.fy, monst.fx) < 2 and rng.percent(monst.freq_spell) then
			ai.exec(ai.RANDOM_CAST, m_idx, monst)
			return
		else
			ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
		end
	end
}
