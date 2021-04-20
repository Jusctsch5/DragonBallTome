-- Dragonball T ai: Rosshi, the Turtle Hermit

ai.new
{
	name	= "ROSSHI"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local dist = ai.distance(monst) -- Does this ONLY target player? That's what we want.
		local girls_in_party = party.girls_in_party()

		-- Ignore party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		-- Run for cover when Lunch is rampaging
		if dball_data.rosshi_girl == RACE_LUNCH and dball_data.lunch_state == 1 then
			monst.ai_move_y = 5
			monst.ai_move_x = 18
			monst.ai_action = ai.action.MOVE
			return
		end

		-- Isn't there a more direct way to do this?
		local mon_hp = (monst.hp * 100) / monst.maxhp

		-- World Tournament
		if dball_data.tourny_now ~= 0 then
			-- Would be nice to allow throws in the beginning
			if mon_hp > 30 then
				ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
			else
				ai.exec(ai.DBT_DEFAULT, m_idx, monst)
			end
		--elseif monst.faction == FACTION_PLAYER
		-- Partied

		--elseif monst.FACTION ~= FACTION_GOOD then
		--	-- Duel?
		--	ai.exec(ai.DBT_DEFAULT, m_idx, monst)
		elseif (is_friend(monst) < 0) then
			if player.get_sex() == "Female" then
				if rng(1,3) == 1 then
					monster_random_say
						{
							"Rosshi says 'You look good all sweaty like that.'",
							"Rosshi says 'I'm really more of a lover than a fighter.'",
							"Rosshi says 'You wanna put me in a choke hold? I don't mind.'",
							"Rosshi is completely mesmerized by your boobs",
							"Rosshi reaches out...and grabs you!",
							"Rosshi tries to punch you, but misses and squeezes your butt instead.",
						}
				end
			elseif girls_in_party > 0 then
				if rng(1,3) == 1 then
					monster_random_say
						{
							"Implement girl-in-party messages for Rosshi ai!",
						}
				end
			else
				ai.exec(ai.DBT_DEFAULT, m_idx, monst)
			end
		else
			monst.ai_action = ai.action.REST
		end
	end
}
