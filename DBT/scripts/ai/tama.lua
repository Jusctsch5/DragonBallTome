-- Dragonball T ai: Tama follows Dr Briefs unless he's dead, in which case she follows the player

ai.new
{
	name	= "TAMA"
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
				if mon and mon.r_idx == RACE_BRIEFS then
					monst.ai_move_y = mon.fy
					monst.ai_move_x = mon.fx
					-- Here's the hack to keep Briefs and Tama out of the hallway
					if monst.ai_move_y > 5 then
						monst.ai_move_y = 5
					end
					monst.ai_action = ai.action.MOVE
					return
				end
			end
		end

		monst.ai_action = ai.action.MOVE
		monst.ai_move_y = player.py
		monst.ai_move_x = player.px
	end
}
