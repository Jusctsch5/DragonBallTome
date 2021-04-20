-- Dragonball T: AI for the monks in Orinji Catacombs
ai.new
{
	name	= "EVIL_MONK"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local range = flag_get(state, FLAG_BEST_RANGE)
		if range == -1 then range = flag_get(state, FLAG_MIN_RANGE) end
		local y, x = ai.target(monst)
		local dist = ai.distance(monst)

		if current_dungeon_idx == DUNGEON_TEMPLE and dun_level == 23 then
			-- we're good
		else
			-- Meh.
			ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
			return
		end

		-- Wait to draw the player out
		if dball_data.temple_alarm == 0 then
			if monst.hp < monst.maxhp or (player.py > 8 and player.px < 50) then
				-- Sound the alarm
				dball_data.temple_alarm = 1	
				term.save()
				term.gotoxy(0, 0)
				term.text_out(color.LIGHT_RED, "Minion: ")
				term.text_out("Hey! Somebody's here! Let's get " .. gendernouns.himher .. "!\n\n")
				dialogue.conclude()
				term.load()
			else
				-- Do nothing
				return
			end
		end

		-- Ok! Go!
		ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
	end
}
