-- Dragonball T ai: Chaozu

ai.new
{
	name	= "CHAOZU"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)

		-- Ignore party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		if dball_data.tourny_now == 1 then
			if cave(y, x).feat ~= FEAT_FIGHTING_RING then
				if dball_data.tourny_flier == 0 then
					dball_data.tourny_flier = 1
					message(color.YELLOW, "Chaozu floats into the air!")
					monst.ai_action = ai.action.REST
				else
					if distance(monst.fy, monst.fx, player.py, player.px) > 3 then
						-- Players far away are more likely to
						-- be pelted at range
						if rng(1,10) > 3 then
							ai.exec(ai.RANDOM_CAST, m_idx, monst)
						else
							ai.exec(ai.DBT_DEFAULT, m_idx, monst)
						end
					else
						ai.exec(ai.DBT_DEFAULT, m_idx, monst)
					end
				end
			else
				ai.exec(ai.DBT_DEFAULT, m_idx, monst)
			end

		elseif party.is_partied(RACE_CHAOZU) > 0 then
			ai.exec(ai.FOLLOW, m_idx, monst)

		elseif trainer[FLAG_ENROLL_ROSSHI] > 0 then
			-- Enemies of crane
			if distance(monst.fy, monst.fx, player.py, player.px) > 2 then
				monst.ai_move_y = player.py
				monst.ai_move_x = player.px
				monst.ai_action = ai.action.MOVE
			else
				monst.ai_action = ai.action.REST
			end
			if rng(1,10) == 1 and los(player.py, player.px, monst.fy, monst.fx) then
				monster_random_say{
					"Chaozu stares at you",
					"Chaozu laughs 'Stupid turtle!'",
					"Chaozu looks at you with wide eyes.",
					"Chaozu looks at you but says nothing.",
				}
			end

		else
			-- Stay close to Tenshinhan
			if dball.how_many_exist(RACE_TENSHINHAN) > 0 then
				local ten = party.get_midx_of(RACE_TENSHINHAN)
				local teny, tenx = monster(ten).fy, monster(ten).fx
				if distance(monst.fy, monst.fx, teny, tenx) > 3 then
					monst.ai_move_y = teny
					monst.ai_move_x = tenx
					monst.ai_action = ai.action.MOVE
				else
					ai.exec(ai.DBT_RANDOM, m_idx, monst)
				end
			else
				ai.exec(ai.DBT_RANDOM, m_idx, monst)
			end
		end
	end
}
