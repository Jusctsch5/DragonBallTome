-- Dragonball T ai: Foot Ninja
-- Behavior depends on players relation to the clan

ai.new
{
	name	= "FOOT_NINJA"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		-- 0 = no formal contact
		-- 1 = spoken with greeter, agreed to speak
		-- 2 = spoken with shredder, neutral
		-- 3 = spoken with shredder, aligned
		-- 4 = spoken with shredder, aligned and allow training
		-- 5 = player is leader of clan
		-- 999 = aggressive(sort of)
		local sanctum = false
		if dball.current_location() == "Foot Lair" and dun_level == 21 then
			sanctum = true
		end
		if dball_data.foot_clan_rapport == 0 then
			-- No formal contact, be aggressive (unless in the Sanctum)
			if sanctum == true then
				-- Inner Sanctum, wait for the player to act
				monst.ai_action = ai.action.REST
			else
				ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
			end
		elseif dball_data.foot_clan_rapport == 1 then
			if sanctum == true then
				-- Inner Sanctum, wait for the player to act
				monst.ai_action = ai.action.REST
			else
				-- Anywhere else. Wander and be a carefree ninja! :)
				ai.exec(ai.DBT_RANDOM, m_idx, monst)
			end
		elseif dball_data.foot_clan_rapport == 2
			or dball_data.foot_clan_rapport == 3
				or dball_data.foot_clan_rapport == 4 then
					-- we are either friendly or neutral
					if sanctum == true then
						-- Inner Sanctum, wait for the player to act
						monst.ai_action = ai.action.REST
					else
						-- Anywhere else. Wander and be a carefree ninja! :)
						ai.exec(ai.DBT_RANDOM, m_idx, monst)
						-- Implement allied fights for Turtle levels
					end
		elseif dball_data.foot_clan_rapport == 5 then
			-- Player is Clan leader, all Foot Ninja are allies
			-- Foot ninja should be in the party
			monst.ai_action = ai.action.REST
		elseif dball_data.foot_clan_rapport == 999 then
			-- State of war, be aggressive
			ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
		else
			message("Unknown foot clan state?")
		end
	end
}
