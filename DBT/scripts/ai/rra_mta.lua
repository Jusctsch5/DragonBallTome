-- Dragonball T: AI for the Automatons of Muscle Tower
-- Automatic Defense will function only if the tower
-- defense system is in tact

ai.new
{
	name	= "RRA_MTA"
	state	=
	{
	}
	init	= function(monst, state)
	end
	exec	= function(m_idx, monst, state)

		if dball_data.rra_mta == 0 then
			ai.exec(ai.RANDOM_CAST, m_idx, monst)
		else
			monst.ai_action = ai.action.REST
		end
	end
}
