-- Dragonball T ai: General Blue

-- Valid Tourny fighter, special dialogue situation, never runs.
-- If the player chooses to flee rather than fight, Blue will hunt
-- the player down until the end of time, and be annoyed enough to
-- use his special psychic gaze paralysis ability. Otherwise he
-- fights fairly.

ai.new
{
	name	= "BLUE"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local dist = ai.distance(monst)

		-- Ignore party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		-- Is this a tourny fight?
		if dball.tourny_now == 1 then
			-- Yes. Be a zombie.
			ai.exec(ai.ZOMBIE, m_idx, monst)
		elseif dball.current_location() ~= "Underwater Cavern" then
			-- The player escaped, and Blue is on the hunt.
			-- Pull out all the stops and use his psychic ability
			if los(player.py, player.px, monst.fy, most.fx) and (rng(1,8) == 1) then
				monster_random_say
				{
					"General Blue flexes his muscles.",
					"General Blue swears vengeance.",
					"General Blue shouts 'You will die this day!'",
					"General Blue eyes you angrily.",
				}
			end
			ai.exec(ai.DBT_DEFAULT, m_idx, monst)
		elseif dball_data.rra_blue_bd == 0 then
			-- Blast door has not yet triggered
			if monst.hp == monst.maxhp then
				monst.ai_action = ai.action.REST
			else
				-- Player is pelting from a distance, presumably
				-- to try and avoid the dialogue sequence.
				-- Move out of LOS.
				if los(player.py, player.px, monst.fy, most.fx) then
					message("General Blue looks mildly annoyed")
				end
				monst.ai_action = ai.action.MOVE
				monst.ai_move_y = 15
				monst.ai_move_x = 56
			end
		else
			ai.exec(ai.ZOMBIE, m_idx, monst)
		end
	end
}
