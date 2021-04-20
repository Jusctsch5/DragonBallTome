-- Dragonball T ai: Cute little mice for the Ballet quest

ai.new
{
	name	= "MOUSE"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)

		local final_dest_y, final_dest_x
		local congo_line = 0
		local follow_the_leader = {}

		-- Where does this congo line lead to, the player, or King Mouse?
		if dball.how_many_exist(RACE_KING_MOUSE) > 0 then
			for i = 1, monst_list.size do
				if (monst_list.node[i].flags & FLAG_FLAG_USED) ~= 0 then
					local idx = monst_list.node[i].key
					local mon = monster(idx)
					if mon and mon.r_idx == RACE_KING_MOUSE then
						final_dest_y = mon.fy
						final_dest_x = mon.fx
					end
				end
			end
		else
			final_dest_y = player.py
			final_dest_x = player.px
		end

		-- Gather the mice
		for i = 1, monst_list.size do
			if (monst_list.node[i].flags & FLAG_FLAG_USED) ~= 0 then
				local idx = monst_list.node[i].key
				local mmm = monster(idx)
				if mmm and mmm.r_idx ~= 0 then
					if mmm.flags[FLAG_AI] == ai.MOUSE then
						congo_line = congo_line + 1
						follow_the_leader[congo_line] = i
					end
				end
			end
		end

		local follow_range = rng(1, 3)

		-- Now send them each on their merry little way:
		if m_idx == follow_the_leader[1] then
			if distance(monst.fy, monst.fx, final_dest_y, final_dest_x) > follow_range then
				monst.ai_move_y = final_dest_y
				monst.ai_move_x = final_dest_x
				monst.ai_action = ai.action.MOVE
			end
			return
		else
			for i = 2, congo_line do
				if m_idx == follow_the_leader[i] then
					local dest_y = monster(follow_the_leader[i - 1]).fy
					local dest_x = monster(follow_the_leader[i - 1]).fx
					if distance(monst.fy, monst.fx, dest_y, dest_x) > follow_range then
						monst.ai_move_y = dest_y
						monst.ai_move_x = dest_x
						monst.ai_action = ai.action.MOVE
					end
					return
				end
			end
		end

		-- Why does one mouse need this?
		-- error("ai.MOUSE fell through")
		 monst.ai_action = ai.action.MOVE
		 monst.ai_move_y = final_dest_y
		 monst.ai_move_x = final_dest_x
	end
}
