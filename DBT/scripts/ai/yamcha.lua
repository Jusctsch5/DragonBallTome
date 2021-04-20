-- Dragonball T ai: Yamcha:
-- * Is intelligent
-- * Doesn't like girls, usually.
-- * Can leave the map any time he chooses
-- * Can be allied
-- * Can be an enemy
-- * Starts as a psuedo-neutral bandit

-- What about Puar?

ai.new
{
	name	= "YAMCHA"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local dist = ai.distance(monst) -- Does this ONLY target player? That's what we want.
		local yamcha_state = dball_data.yamcha_state
		local girls_in_party = party.girls_in_party()

		-- Ignore party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		local yamcha_hp = (monst.hp * 100) / monst.maxhp

		if yamcha_state == 0 then
			-- Initial State: Chase player down and start talking once in range
			-- BUT, only pursue players on the sand
			if dist < 2 then
				-- Haha! Yamcha can initiate dialogue! :)
				dialogue.YAMCHA()
			else
				if cave(player.py, player.px).feat == FEAT_SAND then
					if los(player.py, player.px, monst.fy, monst.fx) then
						ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
					end
				end
			end
		elseif yamcha_state == 1 then
			-- We're running away, for one reason or another.
			-- Girls in party, player out of money, or yamcha is injured
			if (girls_in_party > 0) and (dist < 10) and (rng(1,3) == 1) then
				monster_random_say
				{
					"Yamcha shrieks, 'Aaarrrhhhhhh!!! It's a girl! Eeek!",
					"Yamcha screams, 'Runaway! Runaway!!!",
					"Yamcha shrieks, 'Oh no! It's one of them!",
					"Yamcha whines, 'Can't a bandit make an honest thieving anymore?",
					"Yamcha cringes in terror.",
				}
			end
			ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
		elseif yamcha_state == 2 then
			-- Run if we're hurt, or we've already stolen all the players money.
			-- Otherwise rob 'em blind!
			if yamcha_hp < 33 then
				dball_data.yamcha_state = 1 -- Set to run
				message("Yamcha grimaces in pain and turns to flee!")
				ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
			elseif player.au == 0 then
				message("Yamcha sees that you have no more money, and leaves.")
				dball_data.yamcha_state = 1 -- Set to run
				ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
			else
				ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
			end
		elseif yamcha_state == 3 then
			-- Yamcha is allied. If partied, follow. Otherwise, sit and wait.
			if has_flag(monst, FLAG_PERMANENT) then
				ai.exec(ai.FOLLOW, m_idx, monst)
			else
				monst.ai_action = ai.action.REST
			end
		elseif yamcha_state == 4 then
			-- We're 'running away'
			-- but because the player has willfully given us everything we want
			-- So be nice. (dialogue)
			ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
		end
	end
}
