-- Dragonball T: AI for the security cameras
-- of the RRA Supreme HQ. Cameras will only function
-- if their control system is still intact.

ai.new
{
	name	= "RRA_SHQ_CAM"
	state	=
	{
	}
	init	= function(monst, state)
	end
	exec	= function(m_idx, monst, state)

		if dball_data.rra_shq_cam == 0 then
			ai.exec(ai.RANDOM_CAST, m_idx, monst)
		else
			monst.ai_action = ai.action.REST
		end
	end
}
