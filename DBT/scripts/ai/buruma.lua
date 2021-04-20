-- Dragonball T Ai: Buruma
--
-- Buruma tends to wander semi-randomly looking for dragonballs
-- But, is involved in a number of quests, and may often join
-- the party. But, she's cowardly and tends to run away a lot.

ai.new
{
	name	= "BURUMA"
	state	=
	{
	}
	init	= function(monst, state)
	end
	exec	= function(m_idx, monst, state)

		local buruma_hp = (monst.hp * 100) / monst.maxhp

		if buruma_hp < 30 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("WAAAAHHHHHHH!!!!!!! THIS ISN'T FUN ANYMORE! I'M GOING HOME!!!\n\n")
			dialogue.conclude()
			term.load()
			message("Buruma leaves.")
			delete_monster_idx(m_idx)
			-- unparty not neccessary, yes?
			return
		end

		if party.is_partied(RACE_BURUMA) > 0 then
			ai.exec(ai.PARTY, m_idx, monst)
		elseif dball.current_location() == "Dr. Briefs' Laboratory" then
			-- Just sit and wait
			monst.ai_action = ai.action.REST
			if rng(1,9) == 1 then
				monster_random_say{
					"Buruma whines 'A girl as pretty as me really deserves better!'",
					"Buruma whines 'I haven't had a shower in days!'",
					"Buruma whines 'Why can't I find a boyfriend?!?!'",
				}
			end
		elseif dball.current_location == "Kame House" then
			-- Default Party wait place
			monst.ai_action = ai.action.REST
		else
			-- Implement a more interesting randomness
			ai.exec(ai.DBT_RANDOM, m_idx, monst)
			if rng(1,9) == 1 then
				if los(player.py, player.px, monst.fy, monst.fx) then
					monster_random_say{
					"Buruma mutters 'I know they're arround here someplace.'",
					"Buruma whines 'Where could they be?'",
					"Buruma whines 'I haven't had a shower in days!'",
					"Buruma grumbles 'They shouldn't have hidden them so well!'",}
				else
					message("You hear someone whining in the distance.")
				end
			end
		end
	end
}
