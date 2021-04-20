-- Dragonball T ai: Chichi
-- She mostly stands around, but becomes violent around perverts

ai.new
{
	name	= "CHICHI"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local r_ptr = r_info[monst.r_idx + 1]
		local max = rng.maxroll(r_ptr.hdice, r_ptr.hside)
		local chichi_hp = (monst.hp * 100) / max

		local chichi_state = dball_data.chichi_state

		-- Handle married and allied states!

		if monst.faction == FACTION_PLAYER then
			-- Implement companion AI!
			monst.ai_action = ai.FOLLOW
		elseif chichi_state == 0 then
			-- Chichi unmolested
			monst.ai_action = ai.action.REST
		elseif chichi_state == 1 then
			-- Player has walked in on her, but she's not mad yet
			monst.ai_action = ai.action.REST
		elseif chichi_state == 2 then
			-- She's not happy. Kill.
			ai.exec(ai.DBT_DEFAULT, m_idx, monst)
		else
			-- Post quest-resolution. Be a nice girl.
			monst.ai_action = ai.action.REST
		end

	end
}
