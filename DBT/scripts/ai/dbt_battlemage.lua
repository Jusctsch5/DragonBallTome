-- This was initially an attempt to recreate the generic
-- pre-alpha6 behavior by mixing ai.ZOMBIE and ai.RANDOM_CAST
-- but the actual effect turns out to be considerably nastier:
-- Monsters that stationary stand and cast if they're in LOS,
-- and move towards you if they're not. The second they see
-- you, they stop moving and start casting.
--
-- It's fairly potent, though groups of monsters with this
-- ai will tend to do as much damage to each other as to
-- the character
--
-- It could probably stand to be clean up, though.

ai.new
{
	name	= "DBT_BATTLEMAGE"
	exec	= function(m_idx, monst, state)
		local y, x = ai.target(monst)
		local spl = flag_get_rand(monst.spells)
		local range = flag_get(state, FLAG_BEST_RANGE)
		local dist = ai.distance(monst)

		-- Ignore party members during duels
		if dueling == 1 then
			monst.target = 0
		end

		local ret = true
		if spl > 0 then
			ai.cast.use_spell(m_idx, monst, spl, y, x)
			ret = ai.cast.can(true)
		end

		if not ret then
			monst.ai_action = ai.cast.cast()
		else
			if range == -1 then range = flag_get(state, FLAG_MIN_RANGE) end
	
			-- Fear and range
			if (monst.monfear > 0) or (monst.hp * 100 / monst.maxhp <= flag_get(state, FLAG_FEAR_LEVEL) and not has_flag(monst, FLAG_NO_FEAR)) then
				if has_flag(monst, FLAG_SMART) then
					local ok, y2, x2 = find_safety(m_idx)
					if ok then
						y = y2
						x = x2
					else
						y = monst.fy * 2 - y
						x = monst.fx * 2 - x
					end
				else
					y = monst.fy * 2 - y
					x = monst.fx * 2 - x
				end
			else
				if range > -1 and dist <= range and los(monst.fy, monst.fx, y, x) then
					y = monst.fy * 2 - y
					x = monst.fx * 2 - x
				end
			end

			monst.ai_action = ai.action.MOVE
			monst.ai_move_y = y
			monst.ai_move_x = x
		end
	end
}
