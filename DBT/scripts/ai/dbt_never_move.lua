-- Dragonball T ai: No, REALLY never move. *sigh*

ai.new
{
	name	= "DBT_NEVER_MOVE"
	exec	= function(m_idx, monst, state)
		local y, x = ai.target(monst)
		if not ai.adjacent(monst, y, x) then
			monst.ai_action = ai.action.REST
		end
	end
}
