-- Dragonball T ai: Mr. Popo

ai.new
{
	name	= "POPO"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)

		local popo_hp = (monst.hp * 100) / monst.maxhp

		-- Ignore party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		if dball_data.popo_fight_now == 1 then
			if (popo_hp < 100) or (dball_data.popo_injured > 0) then
				if dball_data.popo_injured == 0 then
					dialogue.POPO_INJURED()
					dball_data.popo_injured = 1
				end
				ai.exec(ai.DBT_DEFAULT, m_idx, monst)
				
			else
				-- Need to NOT move into player, we're FACTION_DUEL right now!
				local yy, xx
				while not nil do
					yy = monst.fy + rng(-1, 1)
					xx = monst.fx + rng(-1, 1)
					if (yy == player.py) and (xx == player.px) then
					else
						break
					end
				end
				monst.ai_move_y = yy
				monst.ai_move_x = xx
				monst.ai_action = ai.action.MOVE
			end
		elseif dball_data.popo_state == 999 then
			-- Genuine aggressive
			if popo_hp < 100 then
				ai.exec(ai.DBT_DEFAULT, m_idx, monst)
			else
				-- This should probably duplicate above non-aggressive random
				ai.exec(ai.DBT_RANDOM, m_idx, monst)
			end
		else
			-- Not fighting or dueling
			ai.exec(ai.DBT_RANDOM, m_idx, monst)
		end
	end
}
