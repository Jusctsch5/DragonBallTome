-- Dragonball T ai: General White
-- The general site and patiently waits to lure the player into Buyon's Trap.
-- He fights only if attacked, or if the trap is inneffective.

ai.new
{
	name	= "WHITE"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local white_hp = (monst.hp * 100) / monst.maxhp

		-- If Buyon has already been defeated, fight immediately
		if race_info_idx(RACE_BUYON, 0).max_num < 1 then
			-- Stand and shoot
			ai.exec(ai.RANDOM_CAST, m_idx, monst)
		elseif white_hp < 100 then 
			-- If the player attacks, respond in kind
			ai.exec(ai.RANDOM_CAST, m_idx, monst)
		else
			-- Otherwise, sit and wait.
			monst.ai_action = ai.action.REST
		end
	end
}
