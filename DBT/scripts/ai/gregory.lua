-- Dragonball T ai: Just like Bubbles: Runs during quest, flits about playfully otherwise

ai.new
{
	name	= "GREGORY"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
			if quest(QUEST_KAIO_GREGORY).status == QUEST_STATUS_TAKEN then
				ai.exec(ai.RUN_AWAY, m_idx, monst)
			else
				ai.exec(ai.DBT_RANDOM, m_idx, monst)
			end
	end
}
