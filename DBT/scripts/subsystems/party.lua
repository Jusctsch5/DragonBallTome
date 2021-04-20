-- Dragonball T: Party subsystem

-- NOTE: This system is assumed to be used with UNIQUES.
-- If this system is adapted to another module, use of
-- this system to add non-unique monsters to the party
-- is very likely to create strange effects

----------------------
-- Declarations
----------------------
constant("party", {})
declare_globals {
	"party_roster",
	"party_locs",
	"monster_counter_hack",
	"dueling",
}
party_roster = {}
party_locs = {}
monster_counter_hack = 0
dueling = 0
add_loadsave("party_roster", {})
add_loadsave("party_locs", {})
add_loadsave("monster_counter_hack", {})
add_loadsave("dueling", {})

----------------------
-- Flags
----------------------
new_flag("PARTY_PARTIED")		-- Is monster currently partied?
new_flag("PARTY_ALLOWED")
new_flag("PARTY_FORBIDDEN")
new_flag("PARTY_LOW_CHARISMA")
new_flag("PARTY_TOO_MANY")
new_flag("PARTY_FORCE_ALLOW")		-- Allow this unique to join the party even if charisma is insufficient
new_flag("PARTY_PILOT")			-- Allows use of Capsule craft
new_flag("PARTY_PURE_OF_HEART") 	-- Allow as passenger on Kinto Un
new_flag("PARTY_OWNER")			-- Capsule craft belongs to whom?
new_flag("PARTY_CONDITION")		-- Special conditions that must be met for a monster to join the party
new_flag("PARTY_STATE")			-- What behavior is this party member currently engaged in?
new_flag("PARTY_ACTS")			-- Which actions are allowable by this unique?
new_flag("PARTY_ACT_FOLLOW")		-- Don't engage. Just follow me.
new_flag("PARTY_ACT_STAY")		-- Don't move
new_flag("PARTY_ACT_FIGHT")		-- Engage freely
new_flag("PARTY_ACT_PELT")		-- Fight at range only
new_flag("PARTY_ACT_GUARD")		-- Stay near player
new_flag("PARTY_ACT_AVOID")		-- Play it safe
new_flag("PARTY_ACT_HELP")		-- Don't engage, but try to help from a safe distance
new_flag("PARTY_ACT_RUN")		-- Run away!
new_flag("PARTY_ACT_BOARD")		-- Board a craft
new_flag("PARTY_ACT_LOW_KEY")		-- Lunch
new_flag("PARTY_ACT_MINOR_CHAOS")	-- Lunch
new_flag("PARTY_ACT_MAJOR_CHAOS")	-- Lunch
			-- PARTY_ACTS={FLAG_PARTY_ACT_FOLLOW, FLAG_PARTY_ACT_STAY, FLAG_PARTY_ACT_AVOID}
			-- PARTY_ACTS={FLAG_PARTY_ACT_MINOR_CHAOS, FLAG_PARTY_MAJOR_CHAOS}

----------------------
-- Hooks
----------------------
hook(hook.KEYPRESS, function (key)
	if key == strbyte('p') then
		-- Oops. m_idx's aren't preserved on level transitions
		party.update_roster()
--		if party.size() > 0 then
			party.configure()
--		else
--			message("No one is in your party at the moment.")
--		end
		return true
	end
end)

----------------------
-- Functions
----------------------
-- Returns number of people in party
-- not including the player
function party.size()
	local foo = getn(party_roster)
	if foo then
		return foo
	else
		return 0
	end
	-- return getn(party_roster)
end

function party.update_roster()
	party_roster = {}
	for_each_monster(function(m_idx, monst)
		if has_flag(monst, FLAG_PARTY_PARTIED) and
			monst.flags[FLAG_PARTY_PARTIED] == true then
				party_roster[party.size() + 1] = m_idx
		end
	end)
end

-- Makes the requested monster a companion
-- Note this is only intended for use with
-- uniques. Returns number of successes.
function party.party(race_name)
	monster_counter_hack = 0
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == %race_name then
			monst.faction = FACTION_PLAYER
			monst.flags[FLAG_PERMANENT] = true
			monst.flags[FLAG_PARTY_PARTIED] = true
			monster_counter_hack = monster_counter_hack + 1
			party_roster[party.size() + 1] = m_idx
			-- Add/Update to the friends list
			if monst.flags[FLAG_UNIQUE] then
				party.loc_mark(monst.r_idx)
			end
		end
	end)
	return monster_counter_hack
end

-- Makes the requested monster no longer a companion
-- Returns the number of not-companions, so made
function party.unparty(race_name)
	monster_counter_hack = 0
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == %race_name then
			monst.flags[FLAG_PERMANENT] = false
			monst.flags[FLAG_PARTY_PARTIED] = false
			monster_counter_hack = monster_counter_hack + 1
			-- Keep track of where they are for the party screen
			if (wizard) then message("Unpartied: " .. %race_name) end
			-- Add/Update to the friends list
			if monst.flags[FLAG_UNIQUE] then
				party.loc_mark(monst.r_idx)
			end
		end
	end)
	return monster_counter_hack
end

-- Returns number of specified race that are currently partied
function party.qty_partied(race_name)
	monster_counter_hack = 0
	for_each_monster(function(m_idx, monst)
		if monst.flags[FLAG_PARTY_PARTIED] and monst.r_idx == %race_name then
			monster_counter_hack = monster_counter_hack + 1
		end
	end)
	return monster_counter_hack
end

-- Returns the m_idx of a partied RACE
-- ASSUMES only one
function party.is_partied(whom)
	monster_counter_hack = 0
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == %whom then
			if monst.flags[FLAG_PARTY_PARTIED] and monst.flags[FLAG_PARTY_PARTIED] == true then
				monster_counter_hack = m_idx
			end
		end
	end)
	return monster_counter_hack
end
-- Checks an midx to see if it's partied
function party.is_midx_partied(m_idx)
	local monst = monster(m_idx)
	if monst.flags[FLAG_PARTY_PARTIED] and monst.flags[FLAG_PARTY_PARTIED] == true then
		return true
	else
		return false
	end
end

-- Returns midx of first instance of a monster
-- in the monster array
function party.get_midx_of(whom)
	monster_counter_hack = 0
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == %whom then
			monster_counter_hack = m_idx
			-- Why can't I simply return the m_idx from here???
			-- It returns null
		end
	end)
	return monster_counter_hack
end

-- Returns the number of girls in the party, including the player
function party.girls_in_party()
	local foo = party.partied_with_flag(FLAG_FEMALE)
	if player.get_sex() == "Female" then
		foo = foo + 1
	end
	return foo
end

-- Returns the number of party members with the requested flag
function party.partied_with_flag(which_flag)
	monster_counter_hack = 0
	for_each_monster(function(m_idx, monst)
		if monst.flags[FLAG_PARTY_PARTIED] then
			if monst.flags[%which_flag] then
				monster_counter_hack = monster_counter_hack + 1
			end
		end
	end)
	return monster_counter_hack
end

function party.may_i_party(whom)
	local monst = monster(party.get_midx_of(whom))

	-- This is nice and all, but if we handle it case by case
	-- it will look cleaner as far as the user is concerned
	if has_flag(monst, FLAG_PARTY_CONDITION) then
		local func = get_function_registry_from_flag(monst.flags, FLAG_PARTY_CONDITION)
		if func() == false then
			return FLAG_PARTY_FORBIDDEN
		elseif func() == FLAG_PARTY_FORCE_ALLOW then
			-- Ignore charisma requirements
			return FLAG_PARTY_ALLOWED
		end
	end

	-- Basic charisma check
	-- if player.stat(A_CHR) < 10 then
	--	return FLAG_PARTY_LOW_CHARISMA
	-- end

	local max_allow = 5 * (player.stat(A_CHR) - 10)
	max_allow = max_allow - party.party_total_levels()
	if monst.level > max_allow then
		return FLAG_PARTY_FORBIDDEN
	else
		return FLAG_PARTY_ALLOWED
	end
end
function party.party_total_levels()
	monster_counter_hack = 0
	for_each_monster(function(m_idx, monst)
		if monst.flags[FLAG_PARTY_PARTIED] and monst.flags[FLAG_PARTY_PARTIED] == true then
			monster_counter_hack = monster_counter_hack + monst.lev
		end
	end)
	return monster_counter_hack
end


-- This doesn't seem to work
function party.teleport_party(where_func)
	monster_counter_hack = 0
	for_each_monster(function(m_idx, monst)
		if monst.flags[FLAG_PARTY_PARTIED] and monst.flags[FLAG_PARTY_PARTIED] == true then
			local yy, xx = %where_func(monster_counter_hack)
			monst.fy = yy
			monst.fx = xx
			monster_counter_hack = monster_counter_hack + 1
		end
	end)
	-- player.update = player.update | PU_MONSTERS
	-- player.redraw[FLAG_PR_BLIND] = true
	player.redraw[FLAG_PR_MAP] = true
end

function party.get_ai_name(ai_flag)
	if ai_flag == FLAG_PARTY_ACT_FOLLOW then
		return "Follow me"
	elseif ai_flag == FLAG_PARTY_ACT_STAY then
		return "Stay here"
	elseif ai_flag == FLAG_PARTY_ACT_FIGHT then
		return "Engage in melee"
	elseif ai_flag == FLAG_PARTY_ACT_PELT then
		return "Engage at range"
	elseif ai_flag == FLAG_PARTY_ACT_GUARD then
		return "Guard me (Poorly implemented)"
	elseif ai_flag == FLAG_PARTY_ACT_AVOID then
		return "Avoid harm"
	elseif ai_flag == FLAG_PARTY_ACT_HELP then
		return "Assist (Not implemented)"
	elseif ai_flag == FLAG_PARTY_ACT_RUN then
		return "Run"
	elseif ai_flag == FLAG_PARTY_ACT_BOARD then
		return "Board craft (Not implemented)"


	-- NOTE TO MODULE MAKERS:
	-- These last three AI's are an extremely special case for a Dragonball T
	-- unique with a personality disorder. They are largely intended for
	-- comedic value. You probably don't want to use them.

	elseif ai_flag == FLAG_PARTY_ACT_LOW_KEY then
		return "Be sneaky"
	elseif ai_flag == FLAG_PARTY_ACT_MINOR_CHAOS then
		return "Blow stuff up"
	elseif ai_flag == FLAG_PARTY_ACT_MAJOR_CHAOS then
		return "Wreck Havoc"
	else
		return "Unrecognized AI"
	end
end

function party.configure()
	--if party.size() < 1 then
	--	message("ERROR: party.go() called with zero members in party!")
	--	return
	--end

	local cursor_position = 4
	local mode = 0

	while not nil do

		term.save()
		if mode == 0 then
			term.text_out("Party Roster: C to change mode\n")
			term.text_out("up/down to scroll, right/left to modify, esc to exit\n")
			term.text_out("\n\n")

			local width_hack = 1

			for i = 1, party.size() do
				local monst = monster(party_roster[i])
				local m_name = monster_desc(monst, 0)
				if strlen(m_name) > width_hack then
					width_hack = strlen(m_name)
				end
			end

			if party.size() == 0 then
				term.text_out(color.LIGHT_BLUE, "Nobody in party\n\n")
			else
				for i = 1, party.size() do

					local monst = monster(party_roster[i])
					local m_hp = (monst.hp * 100) / monst.maxhp
					if m_hp < 100 then
						m_hp = " " .. tostring(m_hp)
					end
					local m_name = monster_desc(monst, 0)
					while strlen(m_name) < width_hack do
						m_name = m_name .. " "
					end

					local ai_name = party.get_ai_name(monst.flags[FLAG_PARTY_STATE])

					term.text_out("  " .. m_name .. " ")
					term.text_out(color.LIGHT_BLUE, ai_name)

					-- term.text_out(color.ORANGE, "ACT:" .. monst.flags[FLAG_PARTY_ACTS])

					term.text_out("\n")
					term.print(color.LIGHT_RED, ">", cursor_position, 0)
				end
			end
		else
			term.text_out("Friends list: C to change mode\n\n\n")
			for i = 1, getn(party_locs) do
				local r_ptr = r_info[party_locs[i].who + 1]
				term.text_out(" " .. r_ptr.name)
				for j = strlen(r_ptr.name) - 21, 22 do
					term.text_out(".")
				end
				if party.qty_partied(party_locs[i].who) == 0 then
					local location = party_locs[i].where
					if wizard then message(location) end
					term.text_out(color.LIGHT_BLUE, d_info[location].name)
				else
					term.text_out(color.LIGHT_BLUE, "In Party")
				end
				term.text_out("\n")
			end
		end


		local key = term.inkey()

		if key == "\r" or key == ESCAPE then
			break
		end

		if mode == 0 then
			if strchar(key) == "c" or strchar(key) == "C" then
				mode = 1
			elseif strchar(key) == "8" then
				cursor_position = cursor_position - 1
				if cursor_position < 4 then
					cursor_position = party.size() + 3
				end
			elseif strchar(key) == "2" then
				cursor_position = cursor_position + 1
				if cursor_position > party.size() + 3 then
					cursor_position = 4
				end
			elseif strchar(key) == "6" or strchar(key) == "+" then
				local monst = monster(party_roster[cursor_position - 3])
				local func
				func = get_function_registry_from_flag(monst.flags, FLAG_PARTY_ACTS)
				local ai_choices = func()
				if getn(ai_choices) > 1 then
					local ai_slot = party.conf_helper(ai_choices, monst.flags[FLAG_PARTY_STATE])
					if ai_slot == getn(ai_choices) then
						monst.flags[FLAG_PARTY_STATE] = ai_choices[1]
					else
						monst.flags[FLAG_PARTY_STATE] = ai_choices[ai_slot + 1]
					end
				end
			elseif strchar(key) == "4" or strchar(key) == "-" then
				local monst = monster(party_roster[cursor_position - 3])
				local func
				func = get_function_registry_from_flag(monst.flags, FLAG_PARTY_ACTS)
				local ai_choices = func()
				if getn(ai_choices) > 1 then
					local ai_slot = party.conf_helper(ai_choices, monst.flags[FLAG_PARTY_STATE])
					if ai_slot == 1 then
						monst.flags[FLAG_PARTY_STATE] = ai_choices[getn(ai_choices)]
					else
						monst.flags[FLAG_PARTY_STATE] = ai_choices[ai_slot - 1]
					end
				end
			end
		else
			-- mode 1
			if strchar(key) == "c" or strchar(key) == "C" then
				mode = 0
			end
		end

		term.load()
	end
	term.load()
end

function party.conf_helper(ai_choices, seek)
	for i = 1, getn(ai_choices) do
		if ai_choices[i] == seek then
			return i
		end
	end
end

-- Get the nearest enemy target
function party.get_target(party_idx)
	local party_member = monster(party_idx)
	local t_idx = -1
	local y = 10000
	local x = 10000

	for i = 1, monst_list.size do
		if (monst_list.node[i].flags & FLAG_FLAG_USED) ~= 0 then
			local idx = monst_list.node[i].key
			local monst = monster(idx)
			if monst and monst.r_idx ~= 0 and idx ~= party_idx then
				if is_friend(monst) < 0 then
					if monst.faction ~= FACTION_DUEL then
						if los(party_member.fx, party_member.fx, monst.fy, monst.fx) then
							local dist_to_t = distance(party_member.fx, party_member.fx, monst.fy, monst.fx)
							if dist_to_t < distance(party_member.fx, party_member.fx, y, x) then
								t_idx = idx
								y = monst.fy
								x = monst.fx
							end
						end
					end
				end
			end
		end
	end



	return t_idx, y, x
end

----------------------
-- Party Locations
----------------------
function party.loc_mark(r_idx)
	local silliness = 1
	if not getn(party_locs) then
		silliness = 1
	else
		for i = 1, getn(party_locs) do
			if party_locs[i].who == r_idx then
				party_locs[i] =
					{
						["who"] = r_idx,
						["where"] = current_dungeon_idx,
					}
				return
			end
			silliness = i + 1
		end	
	end
		
	party_locs[silliness] =
		{
			["who"] = r_idx,
			["where"] = current_dungeon_idx,
		}
end

----------------------
-- Party AI's
----------------------
ai.new
{
	name	= "PARTY"
	state	=
	{
	}
	init	= function(monst, state)
	end
	exec	= function(m_idx, monst, state)

		-- Only act if we are currently partied
		if monst.flags[FLAG_PARTY_PARTIED] then
			if monst.flags[FLAG_PARTY_PARTIED] == true then
			else
				monst.ai_action = ai.action.REST
				return
			end
		else
			monst.ai_action = ai.action.REST
			return
		end

		local hp = (monst.hp * 100) / monst.maxhp
		local pai = monst.flags[FLAG_PARTY_STATE]

		-- Run
		if hp < 10 and not has_flag(monst, FLAG_NO_FEAR) then
			ai.exec(ai.DBT_RUN_AWAY, m_idx, monst)
			return
		end

		-- Party members may not intervene with duels
		if dueling == 1 then
			monst.ai_action = ai.action.REST
			return
		end

		if pai == FLAG_PARTY_ACT_FOLLOW then
			ai.exec(ai.FOLLOW, m_idx, monst)
		elseif pai == FLAG_PARTY_ACT_STAY then
			monst.ai_action = ai.action.REST
		elseif pai == FLAG_PARTY_ACT_FIGHT then
			ai.exec(ai.FIGHT, m_idx, monst)
		elseif pai == FLAG_PARTY_ACT_PELT then
			ai.exec(ai.PELT, m_idx, monst)
		elseif pai == FLAG_PARTY_ACT_GUARD then
			ai.exec(ai.FOLLOW, m_idx, monst)
		elseif pai == FLAG_PARTY_ACT_AVOID then
			ai.exec(ai.AVOID, m_idx, monst)
		elseif pai == FLAG_PARTY_ACT_HELP then
			ai.exec(ai.FOLLOW, m_idx, monst)
		elseif pai == FLAG_PARTY_ACT_RUN then
			ai.exec(ai.RUN, m_idx, monst)
		else
			if (wizard) then
				message("Unknown AI State!")
			end
			monst.ai_action = ai.action.REST
		end
	end
}

ai.new
{
	name	= "FOLLOW"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		if distance(monst.fx, monst.fx, player.py, player.px) > 1 then
			local y, x = player.py, player.px
			monst.ai_action = ai.action.MOVE
			monst.ai_move_y = player.py
			monst.ai_move_x = player.px
		end
	end
}
ai.new
{
	name	= "FIGHT"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		-- Check for available targets
		-- But only cast if our frequency
		-- allows for it. We don't want
		-- Commander Red style behavior
		-- in party members
		local t_idx, y, x = party.get_target(m_idx)
		if t_idx > 0 then
			if (wizard) then message("Party Target is: " .. t_idx) end
			monst.target = t_idx
			monst.ai_move_y = monster(t_idx).fy
			monst.ai_move_x = monster(t_idx).fx
			monst.ai_action = ai.action.MOVE

		elseif distance(monst.fx, monst.fx, player.py, player.px) > 4 then
			-- Otherwise, stay approximately near the player
			local y, x = player.py, player.px
			monst.ai_action = ai.action.MOVE
			monst.ai_move_y = player.py
			monst.ai_move_x = player.px
		else
			ai.exec(ai.DBT_RANDOM, m_idx, monst)
		end
	end
}
ai.new
{
	name	= "PELT"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		-- Run if adjacent to a monster
		for i = 1, 3 do
			for j = 1, 3 do
				if cave(monst.fy + i, monst.fx + j).m_idx > 0 then
					local m2 = cave(monst.fy + i, monst.fx + j).m_idx
					if not party.is_midx_partied(m2) then
						ai.exec(ai.RUN, m_idx, monst)
						return
					end
				end
			end
		end

		-- Next, check for available targets
		-- But only cast if our frequency
		-- allows for it. We don't want
		-- Commander Red style behavior
		-- in party members
		local t_idx, y, x = party.get_target(m_idx)
		if t_idx > 0 then
			monst.target = t_idx
			local foo = monst.freq_spell or 0
			if rng.percent(foo) then
				ai.exec(ai.RANDOM_CAST, m_idx, monst)
				return
			end
		end

		-- Otherwise, keep at distance from player
		if distance(monst.fy, monst.fx, player.py, player.px) > 5 then
			local y, x = player.py, player.px
			monst.ai_move_y = player.py
			monst.ai_move_x = player.px
			monst.ai_action = ai.action.MOVE
		else
			monst.ai_move_y = monst.fy + (monst.fy - player.py)
			monst.ai_move_x = monst.fx + (monst.fx - player.px)
			monst.ai_action = ai.action.MOVE
		end
	end
}
ai.new
{
	name	= "AVOID"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		-- Run if adjacent to a monster
		for i = -1, 1 do
			for j = -1, 1 do
				if cave(monst.fy + i, monst.fx + j).m_idx > 0 then
					local m2 = cave(monst.fy + i, monst.fx + j).m_idx
					if not party.is_midx_partied(m2) then
						ai.exec(ai.RUN, m_idx, monst)
						return
					end
				end
			end
		end

		-- Otherwise, just hover a short distance from the player
		if distance(monst.fy, monst.fx, player.py, player.px) > 5 then
			local y, x = player.py, player.px
			monst.ai_move_y = player.py
			monst.ai_move_x = player.px
			monst.ai_action = ai.action.MOVE
		else
			monst.ai_move_y = monst.fy + (monst.fy - player.py)
			monst.ai_move_x = monst.fx + (monst.fx - player.px)
			monst.ai_action = ai.action.MOVE
		end
	end
}

ai.new
{
	name	= "RUN"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		local y, x = ai.target(monst)

		local ok, y2, x2 = find_safety(monst)
		if ok then
			y = y2
			x = x2
		else
			y = monst.fy * 2 - y
			x = monst.fx * 2 - x
		end

		monst.ai_move_y = y
		monst.ai_move_x = x
		monst.ai_action = ai.action.MOVE
	end
}
ai.new
{
	name	= "BOARD"
	state	=
	{
		MIN_RANGE = -1
		BEST_RANGE = -1
		FEAR_LEVEL = 10
	}
	exec	= function(m_idx, monst, state)
		if distance(monst.fx, monst.fx, player.py, player.px) > 1 then
			local y, x = player.py, player.px
			monst.ai_action = ai.action.MOVE
			monst.ai_move_y = player.py
			monst.ai_move_x = player.px
		end
	end
}


