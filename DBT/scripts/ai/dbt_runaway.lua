-- Movement AI: RUNAWAY!!!!!!

ai.new
{
	name	= "DBT_RUN_AWAY"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local y, x = ai.target(monst)

		local ok, y2, x2 = find_safety(monst)
		if ok then
			y = y2
			x = x2
		else
			y = monst.fy * 2 - y
			x = monst.fx * 2 - x
		end

		monst.ai_action = ai.action.MOVE
		monst.ai_move_y = y
		monst.ai_move_x = x
	end
}
