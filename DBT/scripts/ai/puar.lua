-- Dragonball T ai: Puar follows Yamcha if he's alive, if not he runs (for now)

ai.new
{
	name	= "PUAR"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		for i = 1, monst_list.size do
			if (monst_list.node[i].flags & FLAG_FLAG_USED) ~= 0 then
				local idx = monst_list.node[i].key
				local mon = monster(idx)
				if mon and mon.r_idx == RACE_YAMCHA then
					if distance(monst.fy, monst.fx, mon.fy, mon.fx) > 2 then
						monst.ai_action = ai.action.MOVE
						monst.ai_move_y = mon.fy
						monst.ai_move_x = mon.fx
					end
					return
				end
			end
		end

		ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
	end
}
