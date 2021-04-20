-- Dragonball T Monster abilities

declare_global_constants {
	"monster_breath",
	"monster_saving_throw",
	"split_monster_player",
	"make_breath",
	"SCHOOL_MONSTER_BREATH",
}

-- tries to do a monster saving throw
function monster_saving_throw(source, m_ptr)
	local lev
	if source == 0 then
		lev = (player.lev * 3) - 10
	else
		lev = source.level - 10
	end
	if lev < 1 then lev = 1 end

	return (m_ptr.level > rng(lev) + 10)
end

-- Global breathing function
function monster_breath(type, damage, div)
	local ret, dir = get_aim_dir()
	if not ret then return SPELL_NOTHING end

	fire_cone(type, dir, get_caster_damage(damage, div), 2)
	return true
end


-- Helper function to split player/monster effects
function split_monster_player(play, monst)
	return function()
			local ret, x, y = tgt_pt()
			if not ret then return SPELL_NOTHING end
			local c_ptr = cave(y, x)
			local source = player

			if spell_caster ~= 0 then source = monster(spell_caster) end

			if c_ptr.m_idx == 0 then
				%play(source)
			else
				%monst(source, monster(c_ptr.m_idx), monster_desc(monster(c_ptr.m_idx), 0), spell_caster, c_ptr.m_idx)
			end
			return true
	end
end

add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Buzz",
	["memory"]    = "buzz",
	["action"]	  = "@Source@ buzzes noisily about.",
	["spell"]	  = function()
			aggravate_monsters(spell_caster)
			return true
	end,
}
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Alarm",
	["memory"]    = "alarm",
	["action"]	  = "",
	["spell"]	  = function()
			local y, x = get_spell_caster_info()
			if los(y,x, player.py, player.px) then
				-- Always alert monsters, but only annoy player
				-- with the message once per dungeon level
				if dball_data.rra_alarm_msg == 0 then
					message("You hear an alarm going off in the distance.")
					dball_data.rra_alarm_msg = 1
				end
				aggravate_monsters(spell_caster)
			end
			return true
	end,
}
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Shriek",
	["memory"]    = "shriek",
	["action"]	  = "@Source@ makes a high pitched shriek.",
	["spell"]	  = function()
			aggravate_monsters(spell_caster)
			return true
	end,
}

add_monster_spell
{
	["school"]  = SCHOOL_MONSTER_ABILITY,
	["name"]	= "Powder",
	["memory"]  = "throw powder",
	["action"]	= "@Source@ throws a handle of white powder into the air, burning @target_possesive@ eyes.",
	["spell"]	= split_monster_player
	(
		function(source)
			if player.resist_blind then
				message("You are unaffected!")
			else
				timed_effect.set(timed_effect.BLIND, rng(get_cast_level()) + 4)
			end
		end,
		function(source, m_ptr, m_name)
			if tolua.type(source) == "monster_type" then
				local r_ptr = race_info(m_ptr)
				if has_flag(r_ptr, FLAG_NO_CONF) then
					monster_msg(strcap(m_name).." is unaffected!.", m_ptr.ml)
				elseif monster_saving_throw(source, m_ptr) then
					monster_msg(strcap(m_name).." is unaffected!", m_ptr.ml)
				else
					monster_msg(strcap(m_name).." is blinded!", m_ptr.ml)
					m_ptr.confused = m_ptr.confused + rng(get_cast_level()) + 4
				end
			end
		end
	),
}

add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Shuriken",
	["memory"]    = "throw a shuriken",
	["action"]	  = "@Source@ throws a shuriken at @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_bolt(dam.PIERCE, dir, rng.roll(get_cast_level(), 6))
			return true
	end,
}

add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Dart",
	["memory"]    = "throw poisoned darts",
	["action"]	  = "@Source@ throws a small dart at @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_bolt(dam.POISDAM, dir, rng.roll(get_cast_level(), 6))
			return true
	end,
}


-- Used by the snow patrol to request reinforcements from Muscle Tower
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Snow Patrol",
	["memory"]    = "radio for backup",
	["action"]	  = "@Source@ requests reinforcements",
	["spell"]	  = function()
			local what_to_summon = rng.number(100)
			if what_to_summon < 50 then
				dball.place_monster(42, 100, "red ribbon army private")
			elseif what_to_summon < 80 then
				dball.place_monster(42, 100, "red ribbon army seargent")
			elseif what_to_summon < 90 then
				dball.place_monster(42, 100, "red ribbon army corporal")
			else
				dball.place_monster(42, 100, "red ribbon army patrol")
			end
	end,
}
-- This should be able to miss. Especially since it's RRA people using it.
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Shoot",
	["memory"]    = "shoot",
	["action"]	  = "@Source@ shoots at @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_bolt(dam.BALLISTIC, dir, rng.roll(get_cast_level(), 6))
			return true
	end,
}

add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Grenade",
	["memory"]    = "throw grenades",
	["action"]	  = "@Source@ lobs a grenade at @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_ball(dam.SHARDS, dir, 30 + get_cast_level(50), 2 + get_cast_level(5))
			return true
	end,
}

add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Bazooka",
	["memory"]    = "launch missiles",
	["action"]	  = "@Source@ launches a missile at @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_ball(dam.SHARDS, dir, 30 + get_cast_level(100), 2 + get_cast_level(5))
			return true
	end,
}
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Missile Turret",
	["memory"]    = "launch missiles",
	["action"]	  = "@Source@ launches a missile at @target@.",
	["spell"]	  = function()
			if monster(spell_caster).flags[FLAG_AMMO] > 0 then
				-- local ret, dir = get_aim_dir()
				-- if not ret then return SPELL_NOTHING end
				-- Must fire over trees, so use project
				local ddamage, rrad = 30 + get_cast_level(100), 5
				project(spell_caster, rrad, player.py, player.px, ddamage, dam.SHARDS, PROJECT_GRID | PROJECT_KILL)
				monster(spell_caster).flags[FLAG_AMMO] = monster(spell_caster).flags[FLAG_AMMO] - 1
				return true
			end
	end,
}
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Flashlight",
	["memory"]    = "shine bright light",
	["action"]	  = "@Source@ shines a flashlight in @target@ eyes.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_bolt(dam.BLIND, dir, rng.roll(get_cast_level(), 6))
			return true
	end,
}

-- Bacterium
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "PoisonBreath",
	["memory"]    = "breathe foul breath",
	["action"]	  = "@Source@ breathes on @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_bolt(dam.POISDAM, dir, rng.roll(get_cast_level(), 6))
			return true
	end,
}

-- Buyon
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Lightning Antenna",
	["memory"]    = "discharge lightning",
	["action"]	  = "@Source@ discharges lightning from his antenna!",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_bolt(dam.ELEC, dir, rng.roll(get_cast_level(), 6))
			return true
	end,
}

-- Giran
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "TailWhip",
	["memory"]    = "tail whip",
	["action"]	  = "",
	["spell"]	  = function()
			-- Note: This will die if the player takes Giran's Body and uses this ability
			local source = monster(spell_caster)
			if distance(player.py, player.px, source.fy, source.fx) < 2 then
				--if has_ability(AB_IMMOVABILITY) then
				-- This is tacky. Implement a nicer reference
				if player.movement_mode == 4 then
					monster_random_say{
						"Giran smacks you with his tail. It stings, slightly.",
						"Giran smacks you with his tail, but you shrug it off.",}
				else
					if dball.grapple(get_cast_level(), false) == true then
						message("Giran whips you with his tail!")
						dball.teleport_player(player.py + rng(1,6) - 3, player.px + rng(1,6) - 3)
						-- teleport_player_to(player.py + rng(1,6) - 3, player.px + rng(1,6) - 3)
						take_hit(rng(1,50), "tail whipped")
						if dball_data.tourny_now > 0 and cave(player.py, player.px).feat ~= FEAT_FIGHTING_RING then
							if dball.tourny_disqualify() then
								message(color.YELLOW, "You have been thrown from the ring! The match is lost!")
								dball_data.tourny_registered = 3 -- Disqualified
							end
						end
					else
						message("Giran swings his tail at you, but you dodge!")
					end
				end
			else
				monster_random_say{
					"Giran laughs at you!",
					"Giran looks at you menancingly",
					"Giran flexes his muscles",
					"Giran says 'I look forward to squashing you like a bug!'",}
			end
	end,
}

-- Generic Throw
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Throw",
	["memory"]    = "throw",
	["action"]	  = "",
	["spell"]	  = function()
			-- What about characters using monster bodies?
			local source = monster(spell_caster)
			local m_name = monster_desc(source, 0)
			if distance(player.py, player.px, source.fy, source.fx) < 2 then
				-- if has_ability(AB_IMMOVABILITY) then
				if player.movement_mode == 4 then
					monster_random_say{
						m_name .. " attempts to throw you, but you are unmoved!",
						m_name .. " tries to throw you, but you are immovable!",}
				else
					if dball.grapple(get_cast_level(), true) == true then
						monster_random_say{
							m_name .. " redirects your motions!",
							m_name .. " throws you!",
							m_name .. " picks you up and throws you!",}
						local th_lim = get_cast_level()
						if th_lim < 1 then
							th_lim = 1
						end
						local ty_rng, tx_rng = 0, 0

						-- If we're in a Tournament match...
						if dball_data.tourny_now > 0 then
							-- Never throw player towards center of ring
							-- If on the mid-point for the axis, allow random
							if player.py < 12 then
								ty_rng = rng(-th_lim, -1)
							elseif player.py > 12 then
								ty_rng = rng(1, th_lim)
							end
							if player.px < 21 then
								tx_rng = rng(-th_lim, -1)
							elseif player.px > 21 then
								tx_rng = rng(1, th_lim)
							end
						end
						-- otherwise, just throw randomly
						if ty_rng == 0 then ty_rng = rng(-th_lim, th_lim) end
						if tx_rng == 0 then rng(-th_lim, th_lim) end

						dball.teleport_player(player.py + ty_rng, player.px + tx_rng)
						take_hit(rng(1, get_cast_level() * 10), "being thrown too hard")
						if dball_data.tourny_now > 0 and cave(player.py, player.px).feat ~= FEAT_FIGHTING_RING then
							if dball.tourny_disqualify() then
								message(color.YELLOW, "You have been thrown from the ring! The match is lost!")
								dball_data.tourny_registered = 3 -- Disqualified
							end
						end
					else
						message(m_name .. " grapples, but you manage to break free!")
					end
				end
			else
				-- Any message?
			end
	end,
}
-- Bearhug
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Bearhug",
	["memory"]    = "bear hug",
	["action"]	  = "",
	["spell"]	  = function()
			-- What about characters using monster bodies?
			local source = monster(spell_caster)
			local m_name = monster_desc(source, 0)
			if distance(player.py, player.px, source.fy, source.fx) < 2 then
				--if has_ability(AB_IMMOVABILITY) then
				if player.movement_mode == 4 then
					monster_random_say{
						m_name .. " attempts to grab you, but you evade.",
						m_name .. " tries to put you in a hold, but you shrug it off.",}
				else
					if dball.grapple(get_cast_level(), true) == true then
						-- Once this starts, the player better hope he saves
						monster_random_say{
							m_name .. " crushes the life out of you!",
							m_name .. " grabs you and squeezes!",}
						take_hit(rng(1, get_cast_level() * 10), "bear hug")
						energy_use = get_player_energy(1000)
					else
						message(m_name .. " tries to grab you, but you manage to break free!")
					end
				end
			else
				-- Any message?
			end
	end,
}

-- Ranfan
add_monster_spell
{ 
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Seduce",
	["memory"]    = "gaze seductively",
	["action"]	  = "",
	["spell"]	  = function()
				if player.has_intrinsic(FLAG_BLIND) then
					message("You hear the shuffling of clothing")
				else
					if player.get_sex() == "Female" then
						message("Ranfan glares at you.")
					else
						monster_random_say{
						"Ranfan smiles coyly at you.",
						"Ranfan's heavy breathing is making her chest bob up and down in a most distracting way...",
						"Ranfan strikes a martial pose, with one leg very visible through the slit in her dress...",
						"Ranfan smiles at you and blushes.",}
						local how_much = get_cast_level() - (rng(player.stat(A_WIL)) + player.stat(A_WIL))
						if how_much < 1 then
							message("You maintain your focus!")
						else
							message("You feel warm and fuzzy.")
							timed_effect.inc(timed_effect.PARALYZED, how_much)
						end
					end
				end

			return true
	end,
}

-- Ranfan, also
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "ThrowFan",
	["memory"]    = "throw fans",
	["action"]	  = "@Source@ hurls a fan at @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_bolt(dam.SLASH, dir, rng.roll(get_cast_level(), 6))
			return true
	end,
}

-- Basic Chi blast
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "Chi Burst",
	["memory"]    = "throw Chi bursts",
	["action"]	  = "@Source@ gathers a ball of energy and hurls it at @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			local burst_dam = rng.roll(get_cast_level(), 50)
			if not ret then return SPELL_NOTHING end
			
			if get_cast_level() < 21 then
				fire_bolt(dam.PURE, dir, burst_dam)
			elseif get_cast_level() < 30 then
				fire_ball(dam.PURE, dir, burst_dam, 2 + get_cast_level(5))
			else
				fire_ball(dam.DISINTIGRATION, dir, burst_dam, 2 + get_cast_level(9))
			end
			return true
	end,
}

-- Gero's Robots
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "PlasmaBeam",
	["memory"]    = "fire plasma beams",
	["action"]	  = "@Source@ fires a plasma beam at @target@.",
	["spell"]	  = function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			fire_bolt(dam.PURE, dir, rng.roll(get_cast_level(), 6))
			return true
	end,
}

-- Androids 17 and 18 Only!
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "FingerPointer",
	["memory"]    = "fire plasma beams",
	["action"]	  = "@Source@ fires a plasma beam at @target@.",
	["spell"]	  = function()
			if dball_data.android_quest_status ~= 2 then
				dball_data.android_quest_status = 2
				dialogue.ANDROID_INCEPTION()
				return true
			else
				local ret, dir = get_aim_dir()
				if not ret then return SPELL_NOTHING end
				fire_bolt(dam.PURE, dir, rng.roll(get_cast_level(), 6))
				return true
			end
	end,
}

-- Used by The Phoenix and General Blue
add_monster_spell
{ 
	["school"]	= SCHOOL_MONSTER_ABILITY,
	["name"]	= "Gaze Paralysis",
	["memory"]	= "gaze to paralyze",
	["action"]	= "",
	["spell"]	= function()
				if player.has_intrinsic(FLAG_BLIND) then
					message("An eerie sensation crawls up and down your spine.")
				else
					local mmm = monster(spell_caster)
					local m_name = monster_desc(mmm, 0)
					message(m_name .. " gazes into your eyes.")
					if get_cast_level() < rng(player.stat(A_WIL)) + player.stat(A_WIL) then
						message("But you maintain your focus!")
					else
						message("You cannot move!")
						timed_effect.inc(timed_effect.PARALYZED, rng(get_cast_level()) + 2)
					end
				end
				return true
	end,
}

-- Summon Snakes, used by Uranai Baba and Tentacle Demon
add_monster_spell
{
	["school"]	= SCHOOL_MONSTER_ABILITY,
	["name"]	= "SummonSnakes",
	["memory"]	= "summon creepy crawly things",
	["action"]	= "@Source@ magically summons creepy crawly things!",
	["spell"]	=
		function()
			local ret, x, y = tgt_pt()
			if not ret then return SPELL_NOTHING end

			for i = 1, rng(1,4) do
				summon_monster(y, x, rng(1, get_cast_level()), FACTION_DUNGEON, {chars = "s"})
			end
			return true
		end
}

-- Something in here is causing insta-crash death
-- Strangely appropriate, really...but sort of annoying
-- We don't really need Buu functional for another few
-- real life weeks, so we'll just comment this out
-- and deal with it later
--[[
-- Buu Abilities
add_monster_spell
{
	["school"]    = SCHOOL_MONSTER_ABILITY,
	["name"]	  = "InstaKill",
	["memory"]    = "turn creatures into chocolate and eat them",
	["action"]	  = "@Source@ gestures at @target@",
	["spell"]	= split_monster_player
	(
		function(source)
			if (player.stat(A_WIL) * player.lev) + rng(1,500) > 2000 then
				message(". You feel queasy, but you think you'll live.")
			elseif dball_data.immune_to_chocolate == 1 then
				message(". Nothing happens.")
			else
				message(" and turns you into a piece of chocolate, then eats you.")
				take_hit(25000, "dark chocolate magic")
			end
		end,
		function(source, m_ptr, m_name)
			if tolua.type(source) == "monster_type" then
				local r_ptr = race_info(m_ptr)
				if has_flag(r_ptr, FLAG_UNIQUE) then
					-- Implement: Buu should be able to InstaKill companions
					monster_msg(strcap(m_name).." somehow manages to resist the effect.", m_ptr.ml)
				else
					monster_msg(strcap(m_name).." is turned into chocolate!", m_ptr.ml)
					local obj = create_object(TV_FOOD, SV_CHOCOLATE)
					drop_near(obj, -1, target.fy, target.fx)
					delete_monster_idx(m_ptr)
				end
			end
		end
	),
}
add_monster_spell
{
	["name"]	= "Hold",

	["action"] = {
		-- Player can't see the caster looking or gesturing at the
		-- targeted monster.
		casterunseen_target = ""

		-- Player can see the casting monster, but its casting it at
		-- another monster and the caster has no head or hands to
		-- do anything visible with.
		casterseen_target_nohand_nohead = "",

		-- Unseen casting monster trying to paralyze player.
		casterunseen_player = "@Source@ tries reaching into your mind!",

		casterseen_hand_nohead = "@Source@ gestures at @target@.",
		casterseen_targetunseen_head = "@Source@ stares at something.",

		casterseen_head = "@Source@ stares deep into @target_possesive@ eyes.",

		default = ""
	}

	["spell"]	= split_monster_player
	(
		function(source)
			if (player.free_act) then
				message("You are unaffected!")
			elseif (rng(200) < player.skill_sav) then
				msg_format("You resist the effects!")
			else
				timed_effect.inc(timed_effect.PARALYZED, rng(get_cast_level()) + 4)
			end
		end,
		function(source, m_ptr, m_name, source_idx, m_idx)
			local r_ptr = race_info(m_ptr)
			if (has_flag(r_ptr, FLAG_UNIQUE)) or (has_flag(r_ptr, FLAG_NO_STUN)) then
				monster_msg(strcap(m_name).." staggers, but keeps moving.", m_ptr.ml)
			else
				m_ptr.stunned = m_ptr.stunned + rng(get_cast_level()) + 4
				monster_msg(strcap(m_name).." is paralyzed!", m_ptr.ml)
			end
		end
	),
}

add_monster_spell
{
 	["name"]	= "Teleport To",

	["action"] = {
		casterseen = "@Source@ teleports @target@ to @source_possesive@ side.",
		player = "@Source@ teleports @target@ to @source_possesive@ side.",

		default = ""
	}

	["spell"]	= split_monster_player
	(
		function(source)
			teleport_player_to(source.fy, source.fx)
		end,
		function(source, m_ptr, m_name, source_idx, m_idx)
			teleport_monster_to(m_idx, source.fy, source.fx)
		end
	),
}

-- End Buu Abilities
]]

SCHOOL_MONSTER_BREATH = add_school
{
	["name"]   = "Monster breath spells",
	["memory"] = "breathe",
	["skill"]  = "SKILL_MONSTER",
}

function make_breath(type)
	local name = get_dam_type_info(type, "desc")
	add_monster_spell
	{
		["school"]    = SCHOOL_MONSTER_BREATH,
		["antimagic"] = FALSE,
		["name"]      = "Breathe "..name,
		["memory"]    = get_dam_color_desc(type),
		["action"]    = {
			-- Player is blind, and monster is casting spell at
			-- another monster.
			blind_target = "",

			default = "@Source@ breathes "..name.." at @target@.",
		}
		["spell"]	= function()
			local ret, dir = get_aim_dir()
			if not ret then return SPELL_NOTHING end
			local breath_dam = get_cast_level(1000)
			fire_cone(%type, dir, (breath_dam / 3) + rng((2 * breath_dam) / 3), 1 + get_cast_level(3))
			return true
		end,
	}
end


-- *************************************
-- *************************************
-- *************************************

make_breath(dam.FIRE)
make_breath(dam.PLASMA)
make_breath(dam.POISDAM)
make_breath(dam.DISINTIGRATION)
