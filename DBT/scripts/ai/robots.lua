-- Dragonball T: Generic AI for Dr. Gero's robots

ai.new
{
	name	= "ROBOT"
	exec	= function(m_idx, monst, state)
		local spl = flag_get_rand(monst.spells)
		local range = flag_get(state, FLAG_BEST_RANGE)
		local dist = ai.distance(monst)
		local y, x = ai.target(monst)

		if drgero.annoyed == 0 or factions.get_friendliness(FACTION_PLAYER, FACTION_GERO) < 0 then
			ai.exec(ai.DBT_DEFAULT, m_idx, monst)
		else
			if dball.current_location() == "Dr. Gero's Lab" then and dun_level == 80 then
				monst.ai_action = ai.action.REST
			else
				ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
			end
		end
	end
}
