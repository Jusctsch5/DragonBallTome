-- Dragonball T: Ai for generic Nameks

ai.new
{
	name	= "NAMEK"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local dist = ai.distance(monst) -- Does this ONLY target player? That's what we want.
		local namek_hp = (monst.hp * 100) / monst.maxhp

		if dball_data.namek_general_state == 0 then
			-- Nameks are cautious about strangers
			-- Chase the player down and make polite inquiries
			if dist < 2 then
				dialogue.NAMEK_GENERIC()
			else
				if los(player.py, player.px, monst.fy, monst.fx) then
					ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
				end
			end
		elseif dball_data.namek_general_state == 1 then
			ai.exec(ai.DBT_RANDOM, m_idx, monst)
		elseif dball_data.namek_general_state == 2
		 or dball_data.namek_general_state == 999 then
			-- Converge and attack!
			if namek_hp < 33 then
				ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
			else
				ai.exec(ai.ZOMBIE, m_idx, monst)
			end
		elseif dball_data.namek_general_state == 3 then
			-- Partied?
			if has_flag(monst, FLAG_PERMANENT) then
				ai.exec(ai.FOLLOW, m_idx, monst)
			else
				monst.ai_action = ai.action.REST
			end
		end
	end
}
