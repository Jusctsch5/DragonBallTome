-- Dragonball T ai: Bubbles plays randomly, except during the Chase quest

ai.new
{
	name	= "BUBBLES"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
			if quest(QUEST_KAIO_BUBBLES).status == QUEST_STATUS_TAKEN then
				ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
			else
				ai.exec(ai.DBT_RANDOM, m_idx, monst)
			end
	end
}
