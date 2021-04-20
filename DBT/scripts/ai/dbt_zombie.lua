-- Dragonball T: Zombie ai
ai.new
{
	name	= "DBT_ZOMBIE"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local range = flag_get(state, FLAG_BEST_RANGE)
		if range == -1 then range = flag_get(state, FLAG_MIN_RANGE) end
		local y, x = ai.target(monst)
		local dist = ai.distance(monst)

		-- Ignroe party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		-- Ignore high flyers
		if dball_data.flying_high > 0 then
			ai.exec(ai.DBT_RANDOM, m_idx, monst)
			return
		end

		-- Fear and range
		if (monst.monfear > 0) or (monst.hp * 100 / monst.maxhp <= flag_get(state, FLAG_FEAR_LEVEL) and not has_flag(monst, FLAG_NO_FEAR)) then
			if has_flag(monst, FLAG_SMART) then
				local ok, y2, x2 = find_safety(monst)
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
			if range > -1 and dist <= range and los(monst.fy, monst.fx, y, x) then
				y = monst.fy * 2 - y
				x = monst.fx * 2 - x
			end
		end

		monst.ai_action = ai.action.MOVE
		monst.ai_move_y = y
		monst.ai_move_x = x
	end
}
