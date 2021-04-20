-- Dragonball T: 'Player information'
-- (Functions that are here are simply to follow convention)

-- Add searching
load_subsystem("search", {})
search.add_default_type("traps")
search.add_default_type("terrain")

-- Define how to stop resting
load_subsystem("resting",
{
	stop_check = function()
		-- Can't rest if impaired in ways that make resting
		-- dangerous
		if player.has_intrinsic(FLAG_FEAR) or
			player.has_intrinsic(FLAG_BLIND) or
			player.has_intrinsic(FLAG_CONFUSED)
		then
			return true
		end

		-- Continue resting if HP is less then max and resting will
		-- regenerate it
		if player.chp() < player.mhp() and player.intrinsic(FLAG_REGEN_LIFE) > 0 then
			return false
		end

		-- Continue resting if mana is less then max and resting will
		-- regenerate it
		if dball_data.cur_chi_pool < dball_data.max_chi_pool then
			if dball.mchi_calculate_drain() ~= 0 then
				return false
			end
		end

		-- Otherwise, no need to rest
		return true
	end
})


function player.get_sex()
	return player.get_descriptor("sex").title
end

function player.get_mode()
	return player.get_descriptor("mode").title
end

function player.gain_exp_from_monster(monst)
	-- Maximum player level
	local div = player.max_plv

	if is_friend(monst) <= 0 then
		local race = race_info(monst)

		-- Give some experience for the kill
		local new_exp = (race.mexp * monst.level) / div

		-- apply any experience modifers we have
		if dball_data.p_xpmod then
			local xp_frac = (new_exp * dball_data.p_xpmod) / 100
			new_exp = new_exp + xp_frac
		end

		-- Handle fractional experience
		local new_exp_frac = (imod((race.mexp * monst.level), div) * 65536 / div) + player.exp_frac

		-- Keep track of experience
		if new_exp_frac >= 65536 then
			new_exp = new_exp + 1
			player.exp_frac = new_exp_frac - 65536
		else
			player.exp_frac = new_exp_frac
		end

		return new_exp
	end

	return 0
end

-- Just return an array of lines.  The engine will either put it up on
-- the terminal or save it to a file
function player.self_knowledge()
	local lines    = {}

	tinsert(lines, "Your attributes are:")

	-- Is the player alive?
	local death_str = "You are alive"
	if dball.alive == 2 then
		dead_str = "You are a lost soul"
	elseif dball.alive == 3 then
		dead_str = "You are a demon"
	elseif dball.alive == 4 then
		dead_str = "You are a saint"
	end
	tinsert(lines, death_str)

	if reincarnation.emma_freebie_ress == 2 then
		tinsert(lines, "You have come to know the true meaning of 'only once.'")
	end

	if dball_data.persuades > 0 then
		tinsert(lines, "You have persuaded people " .. dball_data.persuades .. " times.")
	end

	local dbss = dball_data.bear_thief_dbs + dball_data.hasuki_dbs
	if dbss > 0 then
		tinsert(lines, "A total of " .. dbss .. " dragonballs have been stolen from you.")
	end

	if dball_data.summoned_shenron > 0 then
		tinsert(lines, "You have summon Shenron " .. dball_data.summoned_shenron .. " times.")
	end

	local xp_spent = -1 * ((dball_data.xp - 50) - player.exp)
	if xp_spent > 0 then
		tinsert(lines, "You have spent a total of " .. xp_spent .. " experience points.")
	end

	if dball_data.immune_to_chocolate ~= 0 then
		tinsert(lines, "You are immune to chocolate.")
	end
	
	if dball_data.immortality ~= 0 then
		tinsert(lines, "You are an immortal being.")
	end

	if dball_data.win_world_tournament ~= 0 then
		tinsert(lines, "You are fated to win the World Tournamnet.")
	end

	if dball_data.fugu == true then
		tinsert(lines, "You have neuro-toxins in your bloodstream.")
	end

	-- Report resistances
	local resists = player.resists_list()

	for i = 1, getn(resists) do
		local dam_idx    = resists[i]
		local dam_name   = get_dam_type_info(dam_idx, "desc")
		local dam_resist = player.resist(dam_idx)
		local resist_str

		if dam_resist == 0 then
			resist_str = nil
		elseif dam_resist < -99 then
			resist_str = "horribly vulnerable to "
		elseif dam_resist < -88 then
			resist_str = "incredibly vulnerable to "
		elseif dam_resist < -77 then
			resist_str = "extremely vulnerable to "
		elseif dam_resist < -66 then
			resist_str = "very vulnerable to "
		elseif dam_resist < -55 then
			resist_str = "rather vulnerable to "
		elseif dam_resist < -44 then
			resist_str = "vulnerable to "
		elseif dam_resist < -33 then
			resist_str = "moderately vulnderable to "
		elseif dam_resist < -22 then
			resist_str = "somewhat vulnerable to "
		elseif dam_resist < -11 then
			resist_str = "a little bit vulnerable to "
		elseif dam_resist < 0 then
			resist_str = "a tiny bit vulnerable to "
		elseif dam_resist > 99 then
			resist_str = "completely immune to "
		elseif dam_resist >= 90 then
			resist_str = "almost completely immune to "
		elseif dam_resist >= 80 then
			resist_str = "incredibly resistant to "
		elseif dam_resist >= 70 then
			resist_str = "extremely resistant to "
		elseif dam_resist >= 60 then
			resist_str = "very resistant to "
		elseif dam_resist >= 50 then
			resist_str = "rather resistant to "
		elseif dam_resist >= 40 then
			resist_str = "resistant to "
		elseif dam_resist >= 30 then
			resist_str = "moderatly resistant to "
		elseif dam_resist >= 20 then
			resist_str = "somewhat resistant to "
		elseif dam_resist >= 10 then
			resist_str = "a little resistant to "
		elseif dam_resist > 0 then
			resist_str = "a tiny bit resistant to "
		else
			error("Resistance value '" .. dam_resist ..
			      "' not covered!!")
		end

		if resist_str then
			resist_str = "You are " .. resist_str ..
				dam_name .. "."
			if wizard then
				resist_str = resist_str .. " (" ..
					dam_resist .. "%)"
			end
			tinsert(lines, resist_str)
		end
	end -- end reporting resistances

	-- Report ESPs
	if player.has_intrinsic(FLAG_ESP) then
		local esp_flags = player.intrinsic_flags[FLAG_ESP]

		if esp_flags[FLAG_ESP] then
			local str = "You have telepathic powers."
			if wizard then
				str = str .. " (radius " .. esp_flags[FLAG_ESP] .. ")"
			end
			tinsert(lines, str)
		end

		for i = 1, flag_max_key(esp_flags) do
			if esp_flags[i] and i ~= FLAG_ESP then
				local str = "You can sense " .. esp.desc_flag(i) .. "."
				if wizard then
					str = str .. " (radius " .. esp_flags[i] .. ")"
				end
				tinsert(lines, str)
			end
		end
	end

	-- Report metabolism altering things
	if player.intrinsic_flags[FLAG_METAB_PCT] then
		local pct = player.intrinsic(FLAG_METAB_PCT)
		local str

		if pct == 0 then
			str = "Your metabolism is halted."
		elseif pct < 0 then
			str = "Your metabolism is reversed."
		elseif pct < 100 then
			str = "Your metabolism is slowed."
		elseif pct > 100 then
			str = "Your metabolism is accelerated."
		end

		if str then
			tinsert(lines, str)
		end
	end

	if player.has_intrinsic(FLAG_NUTRI_MOD) then
		local mod = player.intrinsic(FLAG_NUTRI_MOD)
		local str

		if mod > 0 then
			str = "You are supplied with nutrition."
		elseif mod < 0 then
			str = "You are drained of nutrition."
		end

		if str then
			tinsert(lines, str)
		end
	end

	if player.intrinsic(FLAG_FOOD_VALUE) < 1 then
		local val = player.intrinsic(FLAG_FOOD_VALUE)
		local str

		if val == 0 then
			str = "You do not grow hungry over time."
		else
			str = "You become more full over time."
		end

		tinsert(lines, str)
	end

	-- Report on blow responses (passive attacks)
	if player.has_intrinsic(FLAG_BLOW_RESPONSE) then
		local responses = player.intrinsic_flags[FLAG_BLOW_RESPONSE]

		for i = 1, flag_max_key(responses) do
			if responses[i] then
				local response = get_blow_response(i)

				if response.self_know then
					if tag(response.self_know) == TAG_STRING then
						tinsert(lines, response.self_know)
					elseif tag(response.self_know) == TAG_FUNCTION then
						response.self_know(lines, response)
					end
				end
			end
		end -- for i = 1, flag_max_key(resposnes) do
	end -- if player.has_intrinsic(FLAG_BLOW_RESPONSE) then

	-- Passwall stuff
	if player.has_intrinsic(FLAG_PASS_WALL) then
		local pass_wall = player.intrinsic_flags[FLAG_PASS_WALL]

		local desc = {
			[FLAG_PASS_INCORP] =
				"You can pass through solid obstables.",
			[FLAG_PASS_STONE] =
				"You can pass through stone.",
			[FLAG_PASS_DOOR] =
				"You can pass through doors.",
			[FLAG_PASS_LIQUID] =
				"You can pass through non-watertight obstables.",
			[FLAG_PASS_GASEOUS] =
				"You can pass through non-airtight obstables.",
			[FLAG_PASS_WEB] =
				"You can pass through webs.",
			[FLAG_PASS_ICE] =
				"You can pass through ice.",
			[FLAG_PASS_TREES] =
				"You can pass through trees."
		}

		for i, v in desc do
			if pass_wall[i] then
				local str = v

				if wizard then
					str = str .. " (power " .. pass_wall[i] .. ")"
				end

				tinsert(lines, str)
			end
		end
	end -- Passwall stuff


	-- Misc stuff
	if player.has_intrinsic(FLAG_SEE_INVIS) then
		tinsert(lines, "You can see invisible creatures.")
	end

	if player.has_intrinsic(FLAG_BLIND) then
		tinsert(lines, "You cannot see.")
	end

	if player.has_intrinsic(FLAG_CONFUSED) then
		tinsert(lines, "You are confused.")
	end

	if player.has_intrinsic(FLAG_HALLUCINATE) then
		tinsert(lines, "You are hallucinating.")
	end

	if player.has_intrinsic(FLAG_REFLECT) then
		local str = "You reflect arrows and bolts."

		if wizard then
			str = str .. "(" .. player.intrinsic(FLAG_REFLECT) ..
				"% of the time)"
		end
		tinsert(lines, str)
	end

	-- Done!  Now indent all of that info a litte, except for the
	-- "Your attributes" line
	for i = 2, getn(lines) do
		lines[i] = "  " .. lines[i]
	end

	return lines
end

deathface.background =
{
[[#G    ____                                                         __________  ]]
[[#G   |    `.  ___          ___      __  __  ____       __   __    |          | ]]
[[#G   |_     \|   `.  /\  ,' _ `.   |  \|  ||    \  /\ |  | |  |   |          | ]]
[[#G    |  |\  \ |\  \/  \/ ,' `._\__|   \  || |)  )/  \|  | |  |   |__      __| ]]
[[#G    |  | | | |/  / /\ \ |  __,'  `.     ||    /  /\ \  | |  |      |    |    ]]
[[#G    |  |/  |    < |__| || |_ | () |     ||    \ |__| | |_|  |__    |    |    ]]
[[#G    |     /   .  \ __  |`._,'`.__,' \   || |)  ) __  |    |    |   |    |    ]]
[[#G    |___,' |__|\__\  |_|.___,'   |__|\__||____/_|  |_|____|____|   |____|    ]]
[[                                     #yYou have died!]]
}

deathface.score_background =
{
[[#G    ____                                                         __________  ]]
[[#G   |    `.  ___          ___      __  __  ____       __   __    |          | ]]
[[#G   |_     \|   `.  /\  ,' _ `.   |  \|  ||    \  /\ |  | |  |   |          | ]]
[[#G    |  |\  \ |\  \/  \/ ,' `._\__|   \  || |)  )/  \|  | |  |   |__      __| ]]
[[#G    |  | | | |/  / /\ \ |  __,'  `.     ||    /  /\ \  | |  |      |    |    ]]
[[#G    |  |/  |    < |__| || |_ | () |     ||    \ |__| | |_|  |__    |    |    ]]
[[#G    |     /   .  \ __  |`._,'`.__,' \   || |)  ) __  |    |    |   |    |    ]]
[[#G    |___,' |__|\__\  |_|.___,'   |__|\__||____/_|  |_|____|____|   |____|    ]]
[[                                      #yBest  scores]]
}

function player.register_score()
	local score = player.exp
	local desc = player_name()
	return score, desc
end

-- Describe a savefile
function player.make_savefile_descriptor()
	local place = dball.current_location()

	return
	{
		"#GName  : #w"..player_name(),
		"#GGender: #w"..player.get_sex(),
		"#GLevel : #w"..player.lev,
		"#GCurrent location: #w"..place,
	}
end
