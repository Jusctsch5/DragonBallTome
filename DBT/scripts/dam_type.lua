--
-- Configure the automatic creation of temporary resists for every
-- damage type we make
--
dam.on_damage_creation = function(t)
	timed_effect.create
	{
		name = "RES_"..strupper(gsub(t.desc, "( )", "_"))
		desc = "Resist "..t.desc
		type = "magical"
		status = "beneficial"
		parameters = { {"power",66} }
		on_gain = "You feel resistant to "..t.desc.."!"
		on_lose = "You feel less resistant to "..t.desc.."."
		bonus = function()
			local t = %t
			player.resists[t.index] = 100 - (((100 - (player.resists[t.index] or 0)) * (100 - timed_effect.get("power"))) / 100)
		end
	}
end

function dam.res.get_temp_name(dam_type)
	local desc = get_dam_type_info(dam_type, "desc")
	return "RES_" .. strupper(gsub(desc, "( )", "_"))
end

function dam.res.sum(list)
	local high_res  = 0
	local high_vuln = 0

	for i = 1, getn(list) do
		if list[i] > high_res then
			high_res = list[i]
		elseif list[i] < high_vuln then
			high_vuln = list[i]
		end
	end

	return dam.res.stack({high_res, high_vuln})
end

-------------------------------------------------------
-------------------- Melee damages --------------------
-------------------------------------------------------

dam.PURE = dam.add
{
	gfx	       = 0,
	desc       = "damage",
	color      = { color.SLATE },
	text_color = "#w",
}
dam.SLASH = dam.add
{
	gfx        = 0,
	desc       = "slashing",
	color      = { color.SLATE },
	text_color = "#w",
}
dam.CRUSH = dam.add
{
	gfx	    = 0,
	desc    = "crushing",
	color   = { color.SLATE },
	text_color = "#w",
}
dam.PIERCE = dam.add
{
	gfx        = 0,
	desc       = "piercing",
	color      = { color.SLATE },
	text_color = "#w",
}
dam.BHAND = dam.add
{
	gfx	    = 0,
	desc    = "barehand",
	color   = { color.SLATE },
	text_color = "#w",
}
dam.CHI = dam.add
{
	gfx	       = 0,
	desc       = "damage",
	color      = { color.SLATE },
	text_color = "#w",
}

dam.RADIATION = dam.add
{
	gfx        = 0,
	desc       = "radiation",
	color      = { color.RED },
	text_color = "#w",
}
dam.BALLISTIC = dam.add
{
	gfx        = 0,
	desc       = "ballistic",
	color      = { color.SLATE },
	text_color = "#w",
}

-------------------------------------------------------
--------------------- Base damages --------------------
-------------------------------------------------------
dam.FIRE = dam.add
{
	gfx	       = 0,
	desc       = "fire",
	color      = function() return iif(rng(6)<4, color.yellow, iif(rng(4)==1, color.RED, color.LIGHT_RED)) end,
	text_color = "#r",
	grid       = function(state)
		local y, x = state.y, state.x
		local c_ptr = cave(y, x)
		local f_ptr = f_info[c_ptr.feat + 1]

		if cave_feat_is(c_ptr, FLAG_PERMANENT) then return nil end

		if f_ptr.flags[FLAG_DEAD_TREE_FEAT] then
			cave_set_feat(y, x, f_ptr.flags[FLAG_DEAD_TREE_FEAT])
		elseif c_ptr.feat == FEAT_ICE then
			local k = rng(100)
			if k < 10 then cave_set_feat(y, x, FEAT_DIRT)
			elseif k < 30 then cave_set_feat(y, x, FEAT_SHAL_WATER)
			end
		elseif cave_feat_is(c_ptr, FLAG_FLOOR) then
			local k = rng(100)
			if k < 10 then cave_set_feat(y, x, FEAT_SHAL_LAVA)
			elseif k < 25 then cave_set_feat(y, x, FEAT_ASH)
			end
		elseif c_ptr.feat == FEAT_SANDWALL or
			c_ptr.feat == FEAT_SANDWALL_H or
			c_ptr.feat == FEAT_SANDWALL_K then
			local k = rng(100)
			if k < 30 then
				cave_set_feat(y, x, FEAT_GLASS_WALL)
				player.update = (player.update | PU_VIEW | PU_MONSTERS |
								 PU_MON_LITE)
			end
		end
	end
	object = function(state)
		if rng.percent(-state.resist) then
			return { kill=true, note_kill=" burn@s@ up!" }
		end
	end,
	player	= function(state)
		return { fuzzy=state.fuzzy or "You are hit by fire!", obvious=true }
	end,
}

dam.COLD = dam.add
{
	color      = function() return iif(rng(6)<4, color.WHITE, color.LIGHT_WHITE) end,
	text_color = "#W",
	gfx        = 1,
	desc       = "cold",
	grid       = function(state)
		local y, x = state.y, state.x
		local chance = 40
		if dam.aux.boring_grid(y, x) and rng.percent(chance) then
			cave_set_feat(y, x, FEAT_ICE)
		end
	end,
	object = function(state)
		if rng.percent(-state.resist) then
			return { kill=true, note_kill=" shatter@s@!" }
		end
	end,
	player	= function(state)
		return { fuzzy=state.fuzzy or "You are hit by cold!", obvious=true }
	end,
}

dam.ELEC = dam.add
{
	color      = function() return iif(rng(7)<6, color.WHITE, iif(rng(4)==1, color.BLUE, color.LIGHT_BLUE)) end,
	text_color = "#b",
	gfx	       = 2,
	desc       = "electricity",
	grid       = function(state)
		local y, x = state.y, state.x
		local c_ptr = cave(y, x)
		local f_ptr = f_info[c_ptr.feat + 1]

		if cave_feat_is(c_ptr, FLAG_PERMANENT) then return nil end
		if f_ptr.flags[FLAG_DEAD_TREE_FEAT] then
			cave_set_feat(y, x, f_ptr.flags[FLAG_DEAD_TREE_FEAT])
		end
	end,
	object = function(state)
		if rng.percent(-state.resist) then
			return {kill=true, note_kill= " melt@s@!" }
		end
	end,
	player	= function(state)
		return { fuzzy=state.fuzzy or "You are hit by electricity!",
			obvious=true }
	end,
}

-- Poison is split into two parts, pure damage and pure lasting
-- The idea for a new poison system would probably be better, but
-- that needs engine changes
-- http://wiki.t-o-m-e.net/IdeaArchive_2fA_20little_20bit_20poisoned_3f

-- As it is now poison resistance id counted twice. No resistance should
-- be counted twice, so I think state should have a member that keeps track
-- of which resists have been accountet for. This needs a small change in
-- dam.implicit_resist and a change in dam.call.

-- We reserve dam.POIS tu be able to use it to define the two base poison types
dam.POIS = dam.reserve()
dam.POISONING = dam.implicit_resist(dam.add
{
	color      = function() return iif(rng(5)<3, color.LIGHT_GREEN, color.GREEN) end,
	text_color = "#g",
	gfx        = 3,
	desc       = "slow poison",
	monster    = function(state)
		return { pois = state.dam, dam=0 }
	end,
	player     = function(state)
		local time, power = state.dam, 1

		if time > 100 then    power = time / 100; time = 100
		elseif time > 10 then power = max(3, time / 10); time = 10 + (time / 5) end

		timed_effect(timed_effect.POISON, (timed_effect.get(timed_effect.POISON) or 0) + time, max(power, timed_effect.get(timed_effect.POISON, "power") or 0))
		return { dam=0, fuzzy=state.fuzzy or "You are hit by poison!" }
	end,
}, {dam.POIS})

dam.POISDAM = dam.implicit_resist(dam.add
{
	color      = function() return iif(rng(5)<3, color.LIGHT_GREEN, color.GREEN) end,
	text_color = "#g",
	gfx        = 3,
	desc       = "fast poison",
	player     = function(state)
		return { fuzzy=state.fuzzy or "You are hit by poison!", obvious=true }
	end,
}, { dam.POIS })

-- We use the reserved dam.POIS to actually define it
dam.combine({dam.POISDAM, dam.POISONING}, false, false, "poison", dam.POIS,
			function()
				return iif(rng(5)<3, color.LIGHT_GREEN, color.GREEN)
			end)

-------------------------------------------------------
------------------ "Annoying" damages -----------------
-------------------------------------------------------

dam.CONFUSION = dam.reserve()
dam.CONFUSE = dam.add
{
	gfx	       = 0,
	desc	   = "confusion",
	color	   = {color.RED, color.GREEN, color.BLUE, color.YELLOW},
	text_color = "#U",
	color_desc = "#Wc#so#on#Bf#Ru#Gs#yi#Uo#Rn#w",
	monster    = function(state)
		return{dam = 0, conf = state.dam}
	end
	player	= function(state)
		local time = state.dam

		if time > 100 then time = 100
		elseif time > 10 then time = 10 + (time / 5) end

		if state.resist < 50 and not rng.percent(state.resist * 2) then
			timed_effect.inc(timed_effect.CONFUSED, time)
		end

		return { dam=0, obvious=true,
			fuzzy=state.fuzzy or "You are hit by something very confusing!"}
	end,
}
dam.CONFUSEDAM = dam.add
{
	gfx	       = 0,
	desc	   = "confusion damage",
	color	   = {color.RED, color.GREEN, color.BLUE, color.YELLOW},
	text_color = "#U",
	player	= function(state)
		return { obvious=true,
			fuzzy=state.fuzzy or "You are hit by something very confusing!"}
	end,
}
dam.combine({dam.CONFUSE, dam.CONFUSEDAM}, true, false, "confusion",
			dam.CONFUSION,
			{color.RED, color.GREEN, color.BLUE, color.YELLOW})

dam.FEAR = dam.add
{
	gfx	       = 0,
	desc	   = "fear",
	text_color = "#s",
	color	   = { color.SLATE },
	monster = function(state)
		if not has_flag(monst, FLAG_RES_FEAR) then
			local time = state.dam

			if time > 100 then time = 100
			elseif time > 10 then time = 10 + (time / 5) end
		
			return { dam=0 fear=time }
		end
	end,
	player	   = function(state)
		if not player.has_intrinsic(FLAG_RES_FEAR) then
			local time = state.dam

			if time > 100 then time = 100
			elseif time > 10 then time = 10 + (time / 5) end

			timed_effect.inc(timed_effect.AFRAID, time)
			return { dam=0, obvious=true,
				fuzzy=state.fuzzy or "You are hit by something fearful!"}
		end
	end,
}

dam.BLIND = dam.add
{
	gfx	       = 0,
	desc	   = "blindness",
	color	   = { color.UMBER },
	text_color = "#w",
	monster	   = function(state)
		return { dam=0 }
	end,
	player	= function(state)
		-- Blind ?
		-- if (state.resist < 100 and not rng.percent(state.resist)) then
		if (not player.has_intrinsic(FLAG_RES_BLIND)) and (not player.has_intrinsic(FLAG_BLIND)) then
				timed_effect.inc(timed_effect.BLIND, rng(3, 10))
		end

		return { dam=0, obvious=true }
	end,
}

dam.CUT = dam.add
{
	gfx	       = 0,
	desc	   = "bleeding",
	color	   = { color.RED },
	text_color = "#r",
	monster = function(state)
		local time, power = state.dam, 1

		if time > 100 then    power = time / 100; time = 100
		elseif time > 10 then power = max(3, time / 10); time = 10 + (time / 5) end

		-- Implement me! Why doesn't this work?
		-- Are monster effects not being loaded?
		-- local cnt, pow = monster_effect.get(state.m_ptr, monster_effect.CUT)
		-- monster_effect(state.m_ptr, monster_effect.CUT, (cnt or 0) + time, max(power, pow or 0))
		return { dam=0 }
	end
	player	= function(state)
		local time, power = state.dam, 1

		if state.resist >= 50 and rng.percent(state.resist * 2) then
			return {dam=0, obvious=true}
		end

		if time > 100 then    power = time / 100; time = 100
		elseif time > 10 then power = max(3, time / 10); time = 10 + (time / 5) end

		timed_effect(timed_effect.CUT,
					 (timed_effect.get(timed_effect.CUT) or 0) + time,
					 max(power, timed_effect.get(timed_effect.CUT, "power") or 0))
		return { dam=0, obvious=true,
			fuzzy=state.fuzzy or "You are hit by something sharp!" }
	end,
}

dam.STUN = dam.add
{
	gfx	       = 0,
	desc	   = "stunning",
	color	   = { color.UMBER },
	text_color = "#u",
	monster	   = function(state)
		if rng(100 - player.lev) < 50 then
			return { stun = (10 + rng(15) + state.rad) / (state.rad + 1) }
		end
	end,
	player	= function(state)
		local time, power = state.dam, 1

		if state.resist >= 50 and rng.percent(state.resist * 2) then
			return {dam=0, obvious=true}
		end

		if time > 100 then    power = time / 100; time = 100
		elseif time > 10 then power = max(3, time / 10); time = 10 + (time / 5) end

		timed_effect(timed_effect.STUN,
					 (timed_effect.get(timed_effect.STUN) or 0) + time,
					 max(power, timed_effect.get(timed_effect.STUN, "power") or 0))
		return { dam=0, obvious=true,
			fuzzy=state.fuzzy or "You are hit by something stunning!", }
	end,
}

-------------------------------------------------------
-------------------- Cosmetic Effects------------------
-------------------------------------------------------
-- Passive (Harmless) Lite
dam.PLITE = dam.add
{
	color      = function() return iif(rng(4) == 1, color.ORANGE, color.YELLOW) end,
	text_color = "#y"
	gfx        = 1,
	desc       = "lite",
	grid       = function(state)
		local y, x = state.y, state.x
		-- Turn on the light
		cave(y, x).info = cave(y, x).info | CAVE_GLOW

		-- Notice & redraw
		if cave_plain_floor(y, x) and player_has_los_bold(y, x) then
			cave(y, x).info = cave(y, x).info | CAVE_MARK
		end

		note_spot(y, x)
		lite_spot(y, x)

		player.update = player.update | PU_VIEW
		--player.redraw[FLAG_PR_MAP] = 1
	end,
	monster	= function(state)
			return {dam = 0}
	end,
	player	= function(state)
		return
	end,
}

-- Pretty Blue Time Travel Visuals
dam.TIME_TRAVEL = dam.add
{
	color      = function() return iif(rng(4) == 1, color.BLUE, color.LIGHT_BLUE) end,
	text_color = "#b"
	gfx        = 1,
	desc       = "lite",
	grid       = function(state)
		local y, x = state.y, state.x
		-- Turn on the light
		cave(y, x).info = cave(y, x).info | CAVE_GLOW

		-- Notice & redraw
		if cave_plain_floor(y, x) and player_has_los_bold(y, x) then
			cave(y, x).info = cave(y, x).info | CAVE_MARK
		end

		note_spot(y, x)
		lite_spot(y, x)

		player.update = player.update | PU_VIEW
		--player.redraw[FLAG_PR_MAP] = 1
	end,
	monster	= function(state)
			return {dam = 0}
	end,
	player	= function(state)
		return
	end,
}


-------------------------------------------------------
-------------------- General damages ------------------
-------------------------------------------------------

-- Light and darkness
dam.LITE = dam.add
{
	color      = function() return iif(rng(4) == 1, color.ORANGE, color.YELLOW) end,
	text_color = "#y"
	gfx        = 1,
	desc       = "lite",
	grid       = function(state)
		local y, x = state.y, state.x
		-- Turn on the light
		cave(y, x).info = cave(y, x).info | CAVE_GLOW

		-- Notice & redraw
		if cave_plain_floor(y, x) and player_has_los_bold(y, x) then
			cave(y, x).info = cave(y, x).info | CAVE_MARK
		end

		note_spot(y, x)
		lite_spot(y, x)

		player.update = player.update | PU_VIEW
		--player.redraw[FLAG_PR_MAP] = 1
	end,
	monster	= function(state)
		if state.resist < 1 then
			-- Monsters don't seem to respond to blindness?
			-- return{dam = state.dam, blind = state.dam msg=" is blinded!"}
			-- Using conf for now
			-- return{dam = state.dam, conf = state.dam msg=" is blinded!"}
			local l_dam = 5
			if state.dam > 5 then
				l_dam = state.dam
			end
			return{dam = 0, conf = l_dam}
		end
	end,
	player	= function(state)
		-- Blind ?
		if (not player.has_intrinsic(FLAG_RES_BLIND)) and (not player.has_intrinsic(FLAG_BLIND)) then
				-- state.resist < 50 and not rng.percent(state.resist * 2)) then
			timed_effect.inc(timed_effect.BLIND, rng(3, 10))
		end
		if state.resist < 0 then
			dam.add_msg(state, "The light scorches your flesh!")
			return { fuzzy=state.fuzzy or "You are hit by light!",
				obvious=true}
		end

		if player.has_intrinsic(FLAG_BLIND) then
			return { fuzzy=state.fuzzy or "You are hit by something!" }
		else
			return { fuzzy=state.fuzzy or "You are hit by light!",
				obvious=true}
		end
	end,
}

dam.SOUND = dam.reserve()
dam.SOUNDDAM = dam.implicit_resist(dam.add
{
	color      = function()
					 return iif(rng(4) == 1, color.VIOLET, color.LIGHT_WHITE)
				 end,
	text_color = "#W",
	gfx        = 1,
	desc       = "sound damage",
	player     = function(state)
		return { fuzzy=state.fuzzy or "You are hit by a loud noise!" }
	end,

}, {dam.SOUND})
dam.combine({dam.SOUNDDAM, dam.STUN}, true, false, "sound", dam.SOUND,
			function()
				return iif(rng(4) == 1, color.DARK, color.LIGHT_DARK)
			end)

dam.SHARDS = dam.reserve()
dam.SHARDSDAM = dam.implicit_resist(dam.add
{
	color      = function()
					 return iif(rng(4) == 1, color.UMBER, color.LIGHT_UMBER)
				 end,
	text_color = "#D",
	gfx        = 1,
	desc       = "shards damage",
	grid       = function(state)
		local y, x = state.y, state.x
		local c_ptr = cave(y, x)
		local f_ptr = f_info[c_ptr.feat + 1]

		if cave_feat_is(c_ptr, FLAG_PERMANENT) then return nil end

		if f_ptr.flags[FLAG_DEAD_TREE_FEAT] then
			cave_set_feat(y, x, f_ptr.flags[FLAG_DEAD_TREE_FEAT])
		end
	end,
	player     = function(state)
		return { fuzzy=state.fuzzy or "You are hit by a something sharp!" }
	end,

}, {dam.SHARDS})
dam.combine({dam.SHARDSDAM, dam.CUT}, true, false, "shards", dam.SHARDS,
			function()
				return iif(rng(4) == 1, color.UMBER, color.LIGHT_UMBER)
			end)


dam.PLASMA = dam.derive
{
	source = dam.FIRE,
	desc = "plasma"
	modifier = function(target, state)
		dam.call(dam.STUN, target, state)

		-- Plasma destroys electricity vulnerable objects and
		-- terrain as well as fire vulnerable ones
		if target == "object" or target == "grid" then
			dam.call(dam.ELEC, target, state)
		end

		if player.has_intrinsic(FLAG_BLIND) then
			state.fuzzy = "You are hit by something *HOT*!"
		else
			state.fuzzy   = "You are hit by plasma!"
			state.obvious = true
		end
	end
}

-- Destroy everything
-- NOTE: Used for the building-destroy plot events
-- The Phoenix breathes this, also
-- As do high level monster chi bursts
-- Caution is advised
dam.DISINTIGRATION = dam.add
{
	color      = function() return iif(rng(4) == 1, color.LIGHT_DARK, color.SLATE) end,
	text_color = "#D",
	desc       = "disintigration"
	grid       = function(state)
		local y, x  = state.y, state.x
		local c_ptr = cave(y, x)
		local f_ptr = f_info[c_ptr.feat + 1]

		if f_ptr.flags[FLAG_PERMANENT] then
			return nil
		end

		if f_ptr.flags[FLAG_DEAD_TREE_FEAT] then
			cave_set_feat(y, x, FEAT_ASH)
			-- Visibility change
			player.update = (player.update | PU_VIEW | PU_MONSTERS |
							 PU_MON_LITE | PU_FLOW)
		elseif f_ptr.flags[FLAG_WALL] then
			local c_remains = rng(100)
			if c_remains < 30 then
				cave_set_feat(y, x, FEAT_ASH)
			elseif c_remains < 70 then
				cave_set_feat(y, x, FEAT_FLOOR)
			else
				cave_set_feat(y, x, FEAT_RUBBLE)
			end
			-- Visibility change
			player.update = (player.update | PU_VIEW | PU_MONSTERS |
							 PU_MON_LITE | PU_FLOW)
		else
			cave_set_feat(y, x, FEAT_FLOOR)
		end

	end,
	object = function(state)
		return { kill=true, note_kill= "evaporate@s@!" }
	end
	monster = function(state)
			--if state.m_ptr.flags[FLAG_UNIQUE] then
			--	return {msg=" resists.", dam = state.dam / 8,
			--		resist=88}
			--end
		end,
	player = function(state)
			return { fuzzy=state.fuzzy or "You are hit by pure energy!" }
		end,
}

-- Hurts all that breath
dam.THICK_POISON = dam.derive
{
	source = dam.POISDAM,
	desc = "thick poison"
	modifier = function(target, state)
		-- Compute how hard it hits
		local resist = 0
		if target == "monster" then
			if state.m_ptr.flags[FLAG_NONLIVING] or
				state.m_ptr.flags[FLAG_UNDEAD] then
				resist = 100
			end
		elseif target == "player" then
			if player.has_intrinsic(FLAG_MAGIC_BREATH) then
				resist = 100
			end
		end

		-- Reduce damage based on it
		state.dam, state.resist = dam.apply_resistance(state.dam, resist)
	end
}

dam.ICE = dam.combine({ {dam.COLD, 100}, {dam.CUT,50}, {dam.STUN,10}},
					  true, false, "ice", nil,
					  function()
						  return iif(rng(6) == 1, color.BLUE, color.WHITE)
					  end)

dam.WATER = dam.combine({ {dam.COLD, 70}, {dam.STUN,30}}, true, false,
						"water", nil,
						function()
							return iif(rng(6) == 1,
									   color.BLUE,
									   color.LIGHT_BLUE)
						end)

-------------------------------------------------------
----------------- Specialized damages -----------------
-------------------------------------------------------

-- Special drowning "damage"
dam.DROWN = dam.add
{
	color = { color.BLUE }
	desc = "drowning"
	player = function(state)
		-- Drown in deep water unless the player have levitation, water walking
		-- water breathing, or magic breathing.
		if calc_total_weight() > (player.weight_limit() / 2) then
			if player.has_intrinsic(FLAG_FEATHER) or player.intrinsic(FLAG_FLY) >= 1 or player.walk_water > 0 or player.has_intrinsic(FLAG_MAGIC_BREATH) or player.has_intrinsic(FLAG_WATER_BREATH) then
				return { dam = 0 }
			else
				dam.add_msg(state, "You are drowning!")
			end
		else
			return { dam = 0 }
		end
	end
}

dam.KILL_WALL = dam.add
{
	color      = { color.WHITE }
	text_color = "#w",
	desc       = "wall destruction"
	grid       = function(state)
		local y, x  = state.y, state.x
		local c_ptr = cave(y, x)
		local f_ptr = f_info[c_ptr.feat + 1]

		if f_ptr.flags[FLAG_PERMANENT] then
			return nil
		end
		if not f_ptr.flags[FLAG_WALL] then
			return nil
		end
		if not f_ptr.flags[FLAG_CAN_PASS] then
			return nil
		end

		if f_ptr.flags[FLAG_CAN_PASS][FLAG_PASS_STONE] then
			cave_set_feat(y, x, FEAT_FLOOR)
			-- Visibility change
			player.update = (player.update | PU_VIEW | PU_MONSTERS |
							 PU_MON_LITE | PU_FLOW)
		end
	end,
	monster = function(state)
			return { dam=0 }
		end,
	player = function(state)
			return { dam=0 }
		end,
}

dam.STONE_WALL = dam.add
{
	color      = { color.WHITE }
	text_color = "#w",
	desc       = "wall creation"
	grid       = function(state)
		local y, x  = state.y, state.x
		local c_ptr = cave(y, x)
		local f_ptr = f_info[c_ptr.feat + 1]

		if c_ptr.m_idx > 0 then
			return nil
		end
		if y == player.py and x == player.px then
			return nil
		end
		if f_ptr.flags[FLAG_PERMANENT] then
			return nil
		end
		if f_ptr.flags[FLAG_WALL] then
			return nil
		end

		cave_set_feat(y, x, FEAT_WALL_SOLID)

		-- Visibility change
		player.update = (player.update | PU_VIEW | PU_MONSTERS |
						 PU_MON_LITE | PU_FLOW)
	end
	monster = function(state)
			return { dam=0 }
		end,
	player = function(state)
			return { dam=0 }
		end,
}
