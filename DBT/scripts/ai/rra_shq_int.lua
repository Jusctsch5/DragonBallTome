-- Dragonball T: AI for the internal Autoturrets
-- of the RRA Supreme HQ. Turrets will only function
-- if their control system is still intact.

ai.new
{
	name	= "RRA_SHQ_INT"
	state	=
	{
	}
	init	= function(monst, state)
	end
	exec	= function(m_idx, monst, state)

		if dball_data.rra_shq_int == 0 then
			ai.exec(ai.RANDOM_CAST, m_idx, monst)
		else
			monst.ai_action = ai.action.REST
		end
	end
}
