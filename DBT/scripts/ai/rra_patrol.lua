-- Dragonball T ai: The Red Ribbon Army Snow patrol
-- The RRA Snow Patrol tirelessly wanders back and forth in the vicinity of
-- Muscle Tower. Should the player step on the snow, he is considered a threat,
-- and will come under fire, and provoke the Patrol to radio in for additional
-- troops from the Tower.

-- Implement: As is the patrol abandons their pursuit as soon as the player leaves
-- the snow. Maybe they should chase to the ends of the earth? Maybe when in
-- 'pursuit' mode they should do something more interesting than ai.DBT_DEFAULT?

ai.new
{
	name	= "RRA_PATROL"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)

		local patrol_hp = (monst.hp * 100) / monst.maxhp

		-- No shooting them with impunity, as reported by Sirrocco
		if patrol_hp < 100 then
			dball_data.rra_mt_patrol_alarm = 1
		end

		if dball_data.flying_high < 1 and (cave(player.py, player.px).feat == FEAT_RRA_SNOW or patrol_hp < 100 or dball_data.rra_mt_patrol_alarm == 1) then
			-- Defend the Tower!
			ai.exec(ai.DBT_DEFAULT, m_idx, monst)
		else

			-- Ignore players if they're not advancing on Muscle Tower
			local previous_dir = monst.flags[FLAG_DBT_AI_STATE]
			if previous_dir < 1 then
				-- Not allocated. Assign a random patrol direction.
				local which_way = rng(1,4)
				if which_way == 1 then
					monst.flags[FLAG_DBT_AI_STATE] = 1	-- West to east
				elseif which_way == 2 then
					monst.flags[FLAG_DBT_AI_STATE] = 2	-- East to wesr
				elseif which_way == 3 then
					monst.flags[FLAG_DBT_AI_STATE] = 3	-- North to south
				else
					monst.flags[FLAG_DBT_AI_STATE] = 4	-- South to north
				end
				previous_dir = monst.flags[FLAG_DBT_AI_STATE]
			end

			local yy, xx
			if previous_dir == 1 then
				yy, xx = 0, -1
			elseif previous_dir == 2 then
				yy, xx = 0, 1
			elseif previous_dir == 3 then
				yy, xx = -1, 0
			elseif previous_dir == 4 then
				yy, xx = 1, 0
			end

			-- Keep going whichever direction we're going until
			-- we reach the end of the snow...
			if cave(monst.fy + yy, monst.fx + xx).feat == FEAT_RRA_SNOW then
				monst.ai_move_y = monst.fy + yy
				monst.ai_move_x = monst.fx + xx
				monst.ai_action = ai.action.MOVE
			else
				-- At which point we usually turn around, and resume
				-- going in the opposite direction on the following
				-- turn, but occassionally change patrol direction
				-- just to keep things interesting
				if rng(1,5) ~= 3 then
					if previous_dir == 1 then
						monst.flags[FLAG_DBT_AI_STATE] = 2	-- East
					elseif previous_dir == 2 then
						monst.flags[FLAG_DBT_AI_STATE] = 1	-- West
					elseif previous_dir == 3 then
						monst.flags[FLAG_DBT_AI_STATE] = 4	-- South
					else
						monst.flags[FLAG_DBT_AI_STATE] = 3	-- North
					end
				else
					monst.flags[FLAG_DBT_AI_STATE] = rng(1,4)
				end
			end
		end
	end
}
