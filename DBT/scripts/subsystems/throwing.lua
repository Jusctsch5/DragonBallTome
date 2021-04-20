-- Dragonball T Throwing subsystem
--
-- Since grenades deliver area effect damage, we
-- need deviate trajectory based on something like
-- 'to hit'

-- For grenades
new_flag("DBT_THROW_EFFECT")

hook(hook.KEYPRESS, function (key)
	if key == strbyte('v') then dbt_throw.throw() return true end
end)

-- For functions
constant("dbt_throw", {})

function dbt_throw.throw()
	-- Get an item
	local ret, item = get_item("Throw which item?",
							   "You don't have anything to throw",
							   USE_INVEN | USE_EQUIP,
							   function(o)
									return true
							   end)
	if not ret or not item then return nil end

	-- Get the item (in the pack)
	local obj = get_object(item)
	local ret, raw_key, key

	-- Remove it
	item_increase(item, -1)
	-- item_describe(item)
	item_optimize(item)

	energy_use = get_player_energy(SPEED_GLOBAL)

	-- Get a target
	local ret, dir
	ret, dir = get_aim_dir()

	if (not ret) then
		return
	end
	-- Maximum distance
	local tdis = dbt_throw.get_range(obj)

	-- Start at the player
	local by = player.py
	local bx = player.px
	local y = player.py
	local x = player.px
	local ny, nx

	-- Predict the "target" location
	local dy, dx = explode_dir(dir)
	local tx = player.px + 99 * dx
	local ty = player.py + 99 * dy

	-- Check for "target request"
	if (dir == 5) and (target_okay()) then
		tx = target_col
		ty = target_row
	end

	-- 'Tweak' target location based on skill
	-- Note that odds of a tweak occurring are quite high,
	-- but a slight deviation will still be a hit if it's
	-- close enough
	if rng(1, 100) > get_skill(SKILL_THROWING) then
		-- Maybe this should be further modified by dexterity?
		local max_deviate = distance(player.py, player.px, ty, tx)
		if (wizard) then
			message("(wizard) Max deviation: " .. max_deviate)
		end

		local actual_deviate = rng(-max_deviate, max_deviate)
		local t_skill = get_skill(SKILL_THROWING)
		if t_skill < 1 then
			t_skill = 1
		end
		actual_deviate = actual_deviate - (actual_deviate * t_skill / 100)
		tx = tx + actual_deviate

		actual_deviate = rng(-max_deviate, max_deviate)
		actual_deviate = actual_deviate - (actual_deviate * t_skill / 100)
		ty = ty + actual_deviate
	end

	-- Travel until stopped
	for cur_dis = 0, tdis do
		-- Hack -- Stop at the target
		if ((y == ty) and (x == tx)) then
			dbt_throw.detonate_at(obj, y, x)
			break
		end

		-- Calculate the new location (see "project()")
		ny = y
		nx = x
		ny, nx = mmove2(ny, nx, by, bx, ty, tx)

		-- Stopped by walls/doors
		if (cave_floor_bold(ny, nx) == nil) then
			dbt_throw.detonate_at(obj, y, x)
			return
		end

		-- Save the new location
		x = nx
		y = ny

		local c_ptr = cave(y, x)
		local m_ptr

		-- We hit something
		if c_ptr.m_idx > 0 then
			m_ptr = c_ptr.m_idx
			local monst = monster(m_ptr)

			-- Shall we allow DEFLECT to catch/eat thrown objects here?

			if dbt_throw.do_we_stop_at_monster(obj, tdis, m_ptr) then
				dbt_throw.detonate_at(obj, y, x)
				return
			else
				-- We missed, so keep going
				-- Projectile may hit/detonate elsewhere
			end
		end
	end

	-- detonate whereever we end up, if we havent' already
	dbt_throw.detonate_at(obj, y, x)
end

function dbt_throw.get_range(obj)
	-- Base distance of 5
	local how_far = 5

	-- +1 per 5 strength
	how_far = how_far + (player.stat(A_STR) / 5)

	-- Modify by weight of the item being thrown
	how_far = how_far - (obj.weight / 50)

	-- Apply limits
	if how_far < 0 then
		how_far = 0	-- No throwing massive corpses or saceships for thousands of damage
	elseif how_far > 20 then
		how_far = 20
	end
	return how_far
end

function dbt_throw.do_we_stop_at_monster(obj, t_dist, m_idx)
	local to_hit = get_skill(SKILL_THROWING) + player.stat(A_DEX) + obj.to_h - (t_dist * 5)
	local monst = monster(m_idx)

	-- Note: By doing it this way, well armored barnyards will be 'missed'
	-- just like tiny, agile flies
	if to_hit >= monst.ac + rng(1, 100) then
		return true
	else
		return false
	end

end

function dbt_throw.detonate_at(obj, y, x)
	local c_ptr = cave(y, x)
	local m_ptr


	if c_ptr.m_idx > 0 then
		m_ptr = monster(c_ptr.m_idx)
	end

	-- Shall we allow DEFLECT to catch/eat thrown objects here?

	if has_flag(obj, FLAG_DBT_THROW_EFFECT) then
		-- local func = obj.flags[FLAG_DBT_THROW_EFFECT]
		local func = get_function_registry_from_flag(obj.flags, FLAG_DBT_THROW_EFFECT)
		func(y, x)
		if (wizard) then
			message("(wizard) grenade Detonated at: " .. y .. ": " .. x)
		end
	else
		local t_dam = rng(0, obj.weight / 10)
		project(WHO_PLAYER, 0, y, x, t_dam, dam.CRUSH, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
		-- drop_near(obj, -1, y, x)
		if (wizard) then
			message("(wizard) object landed at: " .. y .. ": " .. x)
		end
	end
end
