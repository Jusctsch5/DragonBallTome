-- Dragonball T ai: The TMNT

ai.new
{
	name	= "TURTLES"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		-- Ignore party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		-- ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
		monst.ai_action = ai.action.REST
	end
}
