-- Dragonball T ai: Tatsu
-- Behavior depends on players relation to the clan

ai.new
{
	name	= "TATSU"
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

		-- Tatsu uses a 'Thrower' ai
		if dball.tourny_now == 1 or
		 dball_data.foot_clan_rapport == 3 or
		  dball_data.foot_clan_rapport == 0 then

			if distance(player.py, player.px, monst.fy, monst.fx) < 2 and rng.percent(monst.freq_spell) then
				ai.exec(ai.RANDOM_CAST, m_idx, monst)
				return
			else
				ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
			end

		elseif dball_data.foot_clan_rapport == 5 then
			-- Implement companion ai's!
			monst.ai_action = ai.action.REST
		else
			monst.ai_action = ai.action.REST
		end
	end
}
