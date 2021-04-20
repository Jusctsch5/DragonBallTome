-- Dragonball T: AI for Seargent Major Murasaki

ai.new
{
	name	= "MURASAKI"
	exec	= function(m_idx, monst, state)
		local spl = flag_get_rand(monst.spells)
		local range = flag_get(state, FLAG_BEST_RANGE)
		local dist = ai.distance(monst)
		local y, x = ai.target(monst)

		-- Ignore party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		-- Is this a tourny fight?
		if dball.tourny_now == 1 then
			-- Yes. Be a zombie.
			ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
		else
			-- Nope! Let at it!
			local player_is_faster = (player.pspeed > 17)

			local player_is_adjacent
			if dist > 1 then
				player_is_adjacent = false
			else
				player_is_adjacent = true
			end

			local murasaki_hp = (monst.hp * 100) / monst.maxhp

			local in_los			
			local y, x = ai.target(monst)
			if los(monst.fy, monst.fx, y, x) then
				in_los = true
			else
				in_los = false
			end

			local random_cast = false

			if murasaki_hp < 30 then
				if not in_los then
					delete_monster_idx(m_idx)	-- We're hurt, player can't see us, so RUN!
				elseif player_is_adjacent == true then
					if player_is_faster == true then
						ai.exec(ai.DBT_DEFAULT, m_idx, monst)
					else
						ai.exec(ai.RUN_AWAY, m_idx, monst)
					end
				else
					ai.exec(ai.RANDOM_CAST, m_idx, monst)
				end
			elseif murasaki_hp < 70 then
				if player_is_adjacent == true then
					if player_is_faster == true then
						ai.exec(ai.DBT_DEFAULT, m_idx, monst)
					else
						ai.exec(ai.RUN_AWAY, m_idx, monst)
					end
				else
					ai.exec(ai.RANDOM_CAST, m_idx, monst)
				end
			else
				ai.exec(ai.DBT_DEFAULT, m_idx, monst)
				if rng(1,10) == 1 and los(player.py, player.px, monst.fy, monst.fx) then
					monster_random_say{
					"Murasaki shouts 'I am Seargent Major Ninja Purple Murasaki! BANZAI!'",
					"Murasaki digs through his pack and mumbles 'Hmm. Where did I put my ninja darts?'",
					"Murasaki exlaims loudy 'I am a sneaky ninja! You will never hear me coming!'",
					"Murasaki trips on a small crack in the floor.",
					"Murasaki absentmindedly hums a song about being stealthy.",
					"Murasaki steps on a twig. The only twig in the entire area.",}
				end
			end
		end
	end
}
