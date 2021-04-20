-- Dragonball T: AI for Dr. Briefs
--
-- Random, but don't get logded in the hallway.

ai.new
{
	name	= "BRIEFS"
	state	=
	{
		MOVE_RATE = 50
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local range = flag_get(state, FLAG_BEST_RANGE)
		if range == -1 then range = flag_get(state, FLAG_MIN_RANGE) end
		local y, x = ai.target(monst)
		local dist = ai.distance(monst)

		-- Fear and range
		if (monst.monfear > 0) or (monst.hp * 100 / monst.maxhp <= flag_get(state, FLAG_FEAR_LEVEL) and not has_flag(monst, FLAG_NO_FEAR)) then
			if has_flag(monst, FLAG_SMART) then
				local ok, y2, x2 = find_safety(m_idx)
				if ok then
					y = y2
					x = x2
				else
					y = monst.fy * 2 - y
					x = monst.fx * 2 - x
				end
			else
				y = monst.fy * 2 - y
				x = monst.fx * 2 - x
			end
		else

			y = monst.fy + rng(-1, 1)
			x = monst.fx + rng(-1, 1)

		end

		-- Here's the hack to keep Briefs and Tama out of the hallway
		if y > 5 then
			y = 5
		end

		-- Compute the next coordinates
		monst.ai_move_y = y
		monst.ai_move_x = x

		-- Move Randomly. (No, really!)
		monst.ai_action = ai.action.MOVE
	end
}
