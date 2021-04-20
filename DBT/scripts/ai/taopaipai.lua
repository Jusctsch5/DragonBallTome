-- Dragonball T: AI for Tao Pai Pai

-- Ehhh...got very lazy on this one.
-- Should be redone.

ai.new
{
	name	= "TAOPAIPAI"
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
		if dball_data.tourny_now == 1 then
			-- Yes. Be a zombie.
			ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
		elseif trainer[FLAG_ENROLL_CRANE_HERMIT] > 0 then
			-- Are we friends of the school?
			if rng(1,10) == 1 and los(player.py, player.px, monst.fy, most.fx) then
				monster_random_say{
				"Tao Pai Pai nods at you.",
				"Tao Pai Pai glances in your direction.",
				"Tao Pai Pai catches a fly with his hand and flicks it away.",}
			end
			ai.exec(ai.DBT_RANDOM, m_idx, monst)
		else
			-- Nope! Let at it!
			local player_is_faster = (player.pspeed > monst.speed)

			local player_is_adjacent
			if dist > 1 then
				player_is_adjacent = false
			else
				player_is_adjacent = true
			end

			local shall_i_blind = false
			if player.has_intrinsic(FLAG_BLIND) and not player.has_intrinsic(FLAG_RES_BLIND) then
				shall_i_blind = true
			end

			local taopaipai_hp = (monst.hp * 100) / monst.maxhp

			local in_los			
			local y, x = ai.target(monst)
			if los(monst.fy, monst.fx, y, x) then
				in_los = true
			else
				in_los = false
			end

			local which_spell = -1

			if taopaipai_hp < 30 then
				if not in_los then
					delete_monster_idx(m_idx)	-- We're hurt, player can't see us, so RUN!
				elseif player_is_adjacent == true then
					if player_is_faster == true then
						-- Spells haven't worked up to now...fight to the death
						ai.exec(ai.DBT_ZOMBIE, m_idx, monst)
					else
						ai.exec(ai.RUN_AWAY, m_idx, monst)
					end
				else
					ai.exec(ai.RANDOM_CAST, m_idx, monst)
				end
				return
			else
				ai.exec(ai.DBT_DEFAULT, m_idx, monst)
			end
		end

	end
}
