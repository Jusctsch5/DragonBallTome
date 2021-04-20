-- Dragonball T: calc

function player.calc_hitpoints()
	local bonus = 0
	local mhp = 0

	-- Are we alive?
	if dball_data.alive == 0 then
		mhp = player.stat(A_CON) * player.lev
	else
		-- mhp = dball_data.cur_chi_pool / 100
		mhp = 0
	end

	-- New maximum hitpoints
	if player.mhp() ~= mhp then
		-- Enforce maximum
		if player.chp() >= mhp then
			player.chp(mhp)
		end

		-- Save the new max-hitpoints
		player.mhp(mhp)

		-- Display hitpoints (later)
		player.redraw[FLAG_PR_HP] = true
	end
end

-- Chi
function player.calc_mana()
	-- dball_data.cur_chi_pool = 0
	dball_data.max_chi_pool = 0

	local mchi

	if get_skill(SKILL_CHI) >= 1 then
		mchi = get_skill(SKILL_CHI) * player.stat(A_WIL) * 100
	else
		mchi = 0
	end

	if mchi < 0 then
		mchi = 0
	end
	dball_data.max_chi_pool = mchi

	if dball_data.cur_chi_pool > dball_data.max_chi_pool then
		dball_data.cur_chi_pool = dball_data.max_chi_pool
	end
	return mchi
end

-- Sanity
function player.calc_sanity()
	local msane

	msane = player.lev + player.stat(A_INT) + player.stat(A_WIL)

	if dball_data.max_sanity ~= msane then
		-- Sanity carries over between levels.
		local new_csane = dball_data.cur_sanity + msane - dball_data.max_sanity

		dball_data.max_sanity = msane
		dball_data.cur_sanity = new_csane

		if dball_data.cur_sanity >= msane then
			dball_data.cur_sanity = dball_data.max_sanity
		end
	end
end

-- Weight Limit
function player.weight_limit()
	return (player.stat(A_STR) * 200)
end

-- Class
function player.determine_class()
 	local playerprofession = "Wannabe"
	local martialskills = get_skill(SKILL_MARTIALARTS) + get_skill(SKILL_HAND) + get_skill(SKILL_WEAPONS) + get_skill(SKILL_DODGE) + get_skill(SKILL_PARRYING) + get_skill(SKILL_PAIRED)
	local techskills = get_skill(SKILL_TECHNOLOGY) + get_skill(SKILL_CONSTRUCTION) + get_skill(SKILL_DISASSEMBLY)
	local chiskills = get_skill(SKILL_CHI) + get_skill(SKILL_CHI_OFFENSE) + get_skill(SKILL_CHI_DEFENSE) + get_skill(SKILL_CHI_REGENERATION) + get_skill(SKILL_CHI_GUNG) 

 	if enrollments[FLAG_BALLET] == 1 and martialskills == 0 then
		playerprofession = "Dancer"
		-- player.set_intrinsic(FLAG_FREE_ACT)
		-- This appears to not work
		-- flag_add_increase(player.intrinsic_flags[FLAG_SUST_STATS], getter.stats{[A_STR]=1 [A_DEX]=1 [A_CON]=1 })

 	elseif techskills > martialskills then playerprofession = "Technomancer"
	elseif chiskills > martialskills then playerprofession = "Spiritualist"
	elseif enrollments[FLAG_NINJUTSU] == 1 and get_skill(SKILL_STEALTH) > 10 then playerprofession = "Ninja"
	-- Also allow ninja if have only studied ninjutsu, Marksman?
	-- elseif enrollments[FLAG_NINJUTSU] == 1 and (enrollments[FLAG_KARATE] + enrollments[FLAG_KUNGFU] + enrollments[FLAG_KICKBOXING] + enrollments[FLAG_TAEKWONDO] + enrollments[FLAG_BALLET] + enrollments[FLAG_SUMO] + enrollments[FLAG_JUDO]) == 0  then playerprofession = "Ninja"
	elseif get_skill(SKILL_MARKSMANSHIP) > martialskills then playerprofession = "Sniper"
 	elseif martialskills > 0 then playerprofession = "MartialArtist"
 	end 
 	dball_data.p_class = playerprofession
 	return playerprofession
 end

-- Adjust prices by charisma
function player.calc_price_factor()
	-- Smaller numbers are 'better'
	local chr_adjust
	if player.stat(A_CHR) < 10 then
		chr_adjust = 100 - ((player.stat(A_CHR) - 10) * 5)
	else
		chr_adjust = 100 + (10 - player.stat(A_CHR))
	end
	return chr_adjust
end

-- Apply flags
-- Wow, this is delicate!
function player.apply_flags(flags, src)
	src = src or {}

	player.set_intrin_by_list(flags,
		{FLAG_AGGRAVATE, FLAG_TELEPORT,
		FLAG_REGEN, FLAG_SEE_INVIS, FLAG_FREE_ACT,
		FLAG_RES_BLIND, FLAG_REFLECT,
		FLAG_WATER_BREATH, FLAG_CLIMB})

	player.add_intrin_higher_by_list(flags, {FLAG_ESP, FLAG_FLY, FLAG_PASS_WALL, FLAG_PASS_TREES, FLAG_PASS_CLIMB})

	player.inc_field_by_list(flags, {
		{FLAG_MANA,       "to_m"}, -- Mana capacity
		{FLAG_LIFE,       "to_l"}, -- Life capacity
		{FLAG_STEALTH,    "skill_stl"},
		{FLAG_INFRA,      "see_infra"},
		{FLAG_SPEED,      "pspeed"}, -- General speed
	})

	player.inc_flagset_by_list(flags, {
		{FLAG_STATS,       "stat_add"},
		{FLAG_SKILL_BONUS, "skill_bonuses"},
		{FLAG_SPEEDS,      "speeds"}
	})

	--------------------------------------------

	-- Sustain stats
	if flag_exists(flags, FLAG_SUST_STATS) then
		flag_add_increase(player.intrinsic_flags[FLAG_SUST_STATS], flags[FLAG_SUST_STATS])
	end

	-- Copy FLAG_FLY into FLAG_CAN_FLY
	if flag_exists(flags, FLAG_FLY) then
		player.add_intrinsic_higher(FLAG_CAN_FLY, flag_get(flags, FLAG_FLY))
	end

	-- Breaths
	if flag_exists(flags, FLAG_MAGIC_BREATH) then
		player.set_intrinsic(FLAG_MAGIC_BREATH, true)
		player.set_intrinsic(FLAG_WATER_BREATH, true)
	end

	-- Blow responses (passive attacks)
	if flag_exists(flags, FLAG_BLOW_RESPONSE) then
		player.add_intrin_blow_resp(flags[FLAG_BLOW_RESPONSE])
	end
end

-- Gather flags, for when we need to see the flags for all the different
-- pieces of equipment at once, rather than one at a time.
function player.gather_flags(array, flags, src)
	if flag_exists(flags, FLAG_RESIST) then
		if not array[FLAG_RESIST] then
			array[FLAG_RESIST] = {}
		end

		local resists = flags[FLAG_RESIST]

		for i = 1, flag_max_key(resists) do
			if resists[i] then
				if not array[FLAG_RESIST][i] then
					array[FLAG_RESIST][i] = {}
				end
				tinsert(array[FLAG_RESIST][i], resists[i])
			end
		end
	end

	if flag_exists(flags, FLAG_METAB_PCT) then
		if not array[FLAG_METAB_PCT] then
			array[FLAG_METAB_PCT] = {}
		end

		tinsert(array[FLAG_METAB_PCT], flag_get(flags, FLAG_METAB_PCT))
	end
end -- player.gather_flags()

-- Apply the flags which have been gathered together
function player.apply_gathered_flags(array)
	if array[FLAG_RESIST] then
		local resists = array[FLAG_RESIST]
		for i = 1, getn(resists) do
			if resists[i] then
				local val = 0
				-- In Dragonball T, ALL resists stack
				for j = 1, getn(resists[i]) do
					val = val + resists[i][j]
				end
				player.resists[i] = val
			end
		end
	end

	-- Are we using absorbtion?
	-- Ballistic plate? Clothing against cold? Seiyan armor?

	if array[FLAG_METAB_PCT] then
		local pcts     = array[FLAG_METAB_PCT]
		local high_pct = 100
		local low_pct  = 100

		for i = 1, getn(pcts) do
			if pcts[i] > high_pct then
				high_pct = pcts[i]
			elseif pcts[i] < low_pct then
				low_pct  = pcts[i]
			end
		end

		local final_pct = high_pct * low_pct / 100

		if final_pct ~= 100 then
			player.set_intrinsic(FLAG_METAB_PCT, final_pct)
		end
	end
end

-- Compute the player "state" from various data
function player.calc_bonuses(silent)
	if not silent then
		silent = true
	end

	-- Convenient place to put this:
	-- You're given three days of safety after Trunks' arrival before
	-- Androids 16 and 17 are allowed to appear. After that...
	if quest(QUEST_ANDROIDS).status == QUEST_STATUS_TAKEN and dball_data.android_quest_status == 0 then
		if (dball.dayofyear() - dball_data.ttq_day_tripped) > 3 then
			dball_data.android_quest_status = 1
		end
	end

	local i, j, hold
	local old_invis
	local old_speed
	local old_esp
	local old_see_inv
	local old_dis_ac
	local old_dis_to_a
	local o_ptr

	-- What class are we?
	dball_data.p_class = player.determine_class()

	-- Why does it freak out if I put this in birth?
	if game.started then
	else
		-- ***HACK***
		-- zeni assignment is in engine/birth.lua, can't touch it.
		if player.stat(A_CHR) < 9 then
			player.au = player.stat(A_CHR) * 50
		elseif player.stat(A_CHR) == 9 then
			player.au = 500
		elseif player.stat(A_CHR) == 10 then
			player.au = 600
		elseif player.stat(A_CHR) == 11 then
			player.au = 800
		elseif player.stat(A_CHR) == 12 then
			player.au = 1000
		elseif player.stat(A_CHR) == 13 then
			player.au = 1500
		elseif player.stat(A_CHR) == 14 then
			player.au = 2500
		else
			player.au = player.stat(A_CHR) * 200
		end
		if player.get_descriptor("sex").title == "Female" then
			dball_data.p_sex = "Female"
		else
			dball_data.p_sex = "Male"
		end
	end

	-- Save the old speed
	old_speed = player.pspeed

	-- Save the old vision stuff
	old_see_inv = player.intrinsic(FLAG_SEE_INVIS)
	if player.has_intrinsic(FLAG_ESP) then
		old_esp = flag_dup(player.intrinsic_flags[FLAG_ESP])
	else
		old_esp = flag_new()
	end

	-- Martial Arts Eating skill!
	-- Are we using this anymore? Doesn't dbthunger.lua handle it?
	if has_ability(AB_SUSHI) then
		player.inc_speed(SPEED_EAT, 100)
	end

	-- Save the old armor class
	old_dis_ac = player.dis_ac
	old_dis_to_a = player.dis_to_a

	-- Save the old invisibility
	old_invis = player.intrinsic(FLAG_INVIS)

	-- Basic stuff
	-- Grr! I want to remove this! I might! Grr! Grr!
	player.basic_calc_bonuses(silent)

	-- Duplications someplace...
	-- Undo the armor class settings we just retrieved
	--player.to_a = 0
	--player.dis_to_a = 0

	-- Set blind while wearing a blindfold
	if player.inventory[INVEN_HEAD][1] then
		if player.inventory[INVEN_HEAD][1].flags[FLAG_BE_BLIND] then
			player.set_intrinsic(FLAG_BLIND, true)
			player.update = player.update | PU_MONSTERS
			player.redraw[FLAG_PR_BLIND] = true
			-- player.window = player.window | PW_PLAYER
		end
	end

	-- This should be a player flag, or an intrinsic...
	-- But how to make that work?
	dball_data.p_xpmod = 0
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL, function(o_ptr)
		if o_ptr.flags[FLAG_XP_MOD] then
			dball_data.p_xpmod = dball_data.p_xpmod + o_ptr.flags[FLAG_XP_MOD]
		end
	end)
	

-- alpha17 corpse/monster changes
-- But I'm not actually using it anyway
--[[
	local body_flags = r_info[1 + player.body_monster].flags
	if body_flags[FLAG_PASS_WALL] then
		player.add_intrinsic_higher(FLAG_PASS_WALL, body_flags[FLAG_PASS_WALL])
	end
]]

	local new_esp
	if player.has_intrinsic(FLAG_ESP) then
		new_esp = flag_dup(player.intrinsic_flags[FLAG_ESP])
	else
		new_esp = flag_new()
	end

	if not flag_equal(old_esp, new_esp) then
		player.update = player.update | PU_MONSTERS
	end

	-- We dont want memory leaks do we :)
	flag_free(old_esp, true)
	flag_free(new_esp, true)

	-- Hack -- See Invis Change
	if player.intrinsic(FLAG_SEE_INVIS) ~= old_see_inv then
		player.update = player.update | PU_MONSTERS
	end

	-- Extract the current weight (in tenth pounds)
	j = calc_total_weight()

	-- Extract the "weight limit" (in tenth pounds)
	i = player.weight_limit() / 2

	local encumberance = 0
	
	if j > i then
		encumberance = ((j - i) / 50)
	end

	-- Things are computed differently when dead
	if dball_data.alive ~= 0 then
		-- Ghosts don't need to eat
		player.set_intrinsic(FLAG_FOOD_VALUE, 0)
		-- timed_effect(timed_effect.FOOD, food.FOOD_ALERT - 1)
		-- Speed is based on intelligence
		player.pspeed = player.pspeed + player.stat(A_INT) - 10
		-- Add speed from Chi: Constant Effect: Speed
		player.pspeed = player.pspeed + dball_data.chi_haste_setting
		-- Dodge, but no Dex bonus to AC
		player.to_a = player.to_a get_skill(SKILL_DODGE)
		-- Ghosts can pass through objects
		-- Not working
		-- player.add_intrinsic_higher(FLAG_PASS_WALL, 20)
		-- player.set_intrinsic(FLAG_PASS_INCORP)
		-- player.set_intrinsic(FLAG_PROB_TRAVEL_UPDOWN)
		-- player.set_intrinsic(FLAG_PROB_TRAVEL_WALLS)
	else
		-- Set the food usage.  Do this before slowing the player down
		-- from carrying too much weight, so that carrying a ton of stuff
		-- won't slow down digestion.
		local food_usage = 1 + (player.speed() / 5)

		if food_usage < 1 then
			food_usage = 1
		end

		if encumberance > 10 then
			food_usage = food_usage + 10
		else
			food_usage = food_usage + encumberance
		end

		if player.intrinsic_flags[FLAG_METAB_PCT] then
			food_usage = food_usage * player.intrinsic(FLAG_METAB_PCT) / 100
		end

		if player.has_intrinsic(FLAG_NUTRI_MOD) then
			food_usage = food_usage - player.intrinsic(FLAG_NUTRI_MOD)
		end

		-- Food is presumed to be available in a spaceship
		if player.inventory[INVEN_VEHICLE][1] then
			if player.inventory[INVEN_VEHICLE][1].flags[FLAG_VEHICLE_SPACESHIP] then
				food_usage = 0
			end
		end

		player.inc_intrinsic(FLAG_FOOD_VALUE, food_usage)

		-- Apply "encumbrance" from weight
		player.pspeed = player.pspeed - encumberance

		-- Apply speed stat to general speed
		player.pspeed = player.pspeed + player.stat(A_SPD) - 10

	      -- Gravity on the North Kaio's planet is oppressive
		if dball.current_location() == "Kaio" then
			player.pspeed = player.pspeed - 30
		end
	      -- Gravity on Namek is high, too
		if dball.am_i_on_namek() == true then
			player.pspeed = player.pspeed - 15
		end

		-- Searching slows the player down
		-- Where is the searchign bonus for this being applied?
		if player.searching then player.pspeed = player.pspeed - 10 end

		-- Add speed from Chi: Constant Effect: Speed
		player.pspeed = player.pspeed + dball_data.chi_haste_setting

		-- Vehicles overide all other speed settings,
		-- and do not affect food consumption
		if player.inventory[INVEN_VEHICLE][1] then
			if player.inventory[INVEN_VEHICLE][1].flags[FLAG_VEHICLE_SET_SPEED] then
				player.pspeed = 110 + player.inventory[INVEN_VEHICLE][1].flags[FLAG_VEHICLE_SET_SPEED]
			end
		end

		-- Armor Class
		-- Displayed values handled after weapon computations below:
		-- No Dex or Dodge bonuses while riding a vehicle (INCLUDING Kinto Un)
		if not player.inventory[INVEN_VEHICLE][1] then
			player.to_a = player.to_a + player.stat(A_DEX) - 10 + get_skill(SKILL_DODGE) + get_skill(SKILL_DODGE)
		else
			-- But dex PENALTIES do apply
			if player.stat(A_DEX) < 10 then
				player.to_a = player.to_a + player.stat(A_DEX) - 10
			end

		end

	end -- different computations for dead characters

	-- Display the speed (if needed)
	if player.pspeed ~= old_speed then player.redraw[FLAG_PR_SPEED] = true end
--[[
	-- Fusion
	if dball_data.alive == 0 and dball_data.fusion > 0 then
		local r_ptr = r_info[whom]
		if r_ptr.flags[FLAG_FUSION_GAIN] then
			local func = get_function_registry_from_flag(r_ptr.flags, FLAG_FUSION_GAIN)
			func()
		end
	end
]]

--*******************************
	-- Compute to hit values

	-- Zero it all out:
	dball_data.lhand_th = 0
	dball_data.lhand_td = 0
	dball_data.lhand_dis_th = 0
	dball_data.lhand_dis_td = 0
	dball_data.lhand_valid = 0

	dball_data.rhand_th = 0
	dball_data.rhand_td = 0
	dball_data.rhand_dis_th = 0
	dball_data.rhand_dis_td = 0
	dball_data.rhand_valid = 0

	local w1 = 0
	local w2 = 0

	local m_hand_th = player.stat(A_DEX) - 10 + get_skill(SKILL_MARTIALARTS) + get_skill(SKILL_HAND)
	local m_weap_th = get_skill(SKILL_MARTIALARTS) + get_skill(SKILL_WEAPONS) + player.stat(A_DEX) - 10 
	local m_td = player.stat(A_STR) - 10

	-- Battle Aura adds Chi offense skill to all melee ToHit/Damage
	if dball_data.chi_aura_setting == 1 then
		m_hand_th = m_hand_th + get_skill(SKILL_CHI_OFFENSE)
		m_weap_th = m_weap_th + get_skill(SKILL_CHI_OFFENSE)
		m_td = m_td + get_skill(SKILL_CHI_OFFENSE)
	end
	
	-- What's in our left hand?
	if player.inventory[INVEN_WIELD][1] then
		if player.inventory[INVEN_WIELD][1].flags[FLAG_DAM] then
			dball_data.lhand_valid = 1 -- A melee weapon
			w1 = 1
		elseif player.inventory[INVEN_WIELD][1].flags[FLAG_MISSILE_WEAPON] then
			dball_data.lhand_valid = 2 -- A gun
			w1 = 2
		else
			dball_data.lhand_valid = -1 -- Something else, like a shield or a flashlight.
			w1 = -1
		end
	else
		dball_data.lhand_valid = 0 -- Nothing!
		w1 = 0
	end

	-- What's in our right hand?
	if player.inventory[INVEN_WIELD][2] then
		if player.inventory[INVEN_WIELD][2].flags[FLAG_DAM] then
			dball_data.rhand_valid = 1 -- A melee weapon
			w2 = 1
		elseif player.inventory[INVEN_WIELD][2].flags[FLAG_MISSILE_WEAPON] then
			dball_data.rhand_valid = 2 -- A gun
			w2 = 2
		else
			dball_data.rhand_valid = -1 -- Something else, like a shield or a flashlight.
			w2 = -1
		end
	else
		dball_data.rhand_valid = 0 -- Nothing!
		w2 = 0
	end

	-- Fighting prohibitions while piloting vehicles
	if player.inventory[INVEN_VEHICLE][1] then
		if has_flag(player.inventory[INVEN_VEHICLE][1], FLAG_KINTO_UN) then
			-- Can fight while riding Kinto Un
		else
			if w1 == 0 then
				w1 = -1
			end
			w2 = -1
		end
	end

	-- Retroactively disable maglights if we lack the skill to fight florentine
	if player.inventory[INVEN_WIELD][1] and has_flag(player.inventory[INVEN_WIELD][1], FLAG_MAGLIGHT) then
		if w1 == 1 and w2 == 1 and not has_ability(AB_PAIRED_WEAPONS) then
			w1 = -1
		end
	elseif player.inventory[INVEN_WIELD][2] and has_flag(player.inventory[INVEN_WIELD][2], FLAG_MAGLIGHT) then
		if w1 == 1 and w2 == 1 and not has_ability(AB_PAIRED_WEAPONS) then
			w2 = -1
		end
	end

	-- Next, let's compute tohit chances based on the ruleset we're using:
	-- (hook[wield_pre in dbtstuff.lua has alrady prevented invalid combinations)

	-- Two non weapons...
	if w1 == -1 and w2 == -1 then
		-- Do nothing!

	-- Both hands empty
	elseif w1 == 0 and w2 == 0 then
		-- Compute for left hand
		dball_data.lhand_th = m_hand_th
		dball_data.lhand_td = m_td
		-- Add our AC bonus from Barehand:
		if has_ability(AB_BLOCKING) then
			player.to_a = player.to_a + get_skill(SKILL_HAND)
			if has_ability(AB_DOUBLE_ATTACK) then
				player.to_a = player.to_a + get_skill(SKILL_HAND)
			end
		end
		-- Can we fight with both hands?
		if has_ability(AB_DOUBLE_ATTACK) then
			-- Yes! Copy above over to second hand:
			dball_data.rhand_th = dball_data.lhand_th
			dball_data.rhand_td = dball_data.lhand_td
		else
			-- No...disable the second hand for combat.lua
			dball_data.rhand_valid = -1
		end

	-- Barehand and non-weapon
	elseif (w1 == -1 and w2 == 0) or (w1 == 0 and w2 == -1) then
		-- Can only fight barehand if we have the ability for it:
		if has_ability(AB_DOUBLE_ATTACK) then
			-- Compute. Pick a hand, and display will hide the fact that you can fight
			-- with two. Will add to the mysteriosity of the learning process
			-- and make it really neat-o when somebody firsts discovers they
			-- can fight with two hands!
			dball_data.lhand_th = m_hand_th
			dball_data.lhand_td = m_td
			dball_data.lhand_valid = 0
			dball_data.rhand_valid = -1
			-- Add our AC bonus from Barehand:
			if has_ability(AB_BLOCKING) then
				player.to_a = player.to_a + get_skill(SKILL_HAND)
			end
		else
			-- Let display.lua and combat.lua know we can't fight at all
			dball_data.lhand_valid = -1
			dball_data.rhand_valid = -1
		end

	-- Barehand and Weapon
	elseif (w1 == 0 and w2 == 1) then
		-- First, compute for the weapon
		dball_data.rhand_th = 0 - player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY] + m_weap_th 
		dball_data.rhand_td = m_td
		player.to_a = player.to_a + get_skill(SKILL_PARRYING)
		-- Do we have ultimate fighting?
		if has_ability(AB_ULTIMATE) then
			-- Yes! Compute for Barehand
			dball_data.lhand_th = m_hand_th
			dball_data.lhand_td = m_td
			-- Add our AC bonus from Barehand:
			if has_ability(AB_BLOCKING) then
				player.to_a = player.to_a + get_skill(SKILL_HAND)
			end
		else
			-- No, disable the hand
			dball_data.lhand_valid = -1
			-- But, if we have double attack, then we at least get to defend with it.
			if has_ability(AB_DOUBLE_ATTACK) then
				player.to_a = player.to_a + get_skill(SKILL_HAND)
			end
		end
	-- Weapon and Barehand
	elseif (w1 == 1 and w2 == 0) then
		-- First, compute for the weapon
		dball_data.lhand_th = 0 - player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY] + m_weap_th 
		dball_data.lhand_td = m_td
		player.to_a = player.to_a + get_skill(SKILL_PARRYING)
		-- Do we have ultimate fighting?
		if has_ability(AB_ULTIMATE) then
			-- Yes! Compute for Barehand
			dball_data.rhand_th = m_hand_th
			dball_data.rhand_td = m_td
			-- Add our AC bonus from Barehand:
			player.to_a = player.to_a + get_skill(SKILL_HAND)
		else
			-- No, disable the hand
			dball_data.rhand_valid = -1
			-- But, if we have double attack, then we at least get to defend with it.
			if has_ability(AB_DOUBLE_ATTACK) then
				if has_ability(AB_BLOCKING) then
					player.to_a = player.to_a + get_skill(SKILL_HAND)
				end
			end
		end

	-- Weapon and non-weapon
	elseif (w1 == 1 and w2 == -1) then
		-- Compute th/d: (not including magical pluses)
		dball_data.lhand_th = 0 - player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY] + m_weap_th 
		dball_data.lhand_td = m_td
		-- While we're here, let's add our parry bonus
		player.to_a = player.to_a + get_skill(SKILL_PARRYING)

	-- Non-weapon and Weapon
	elseif (w1 == -1 and w2 == 1) then
		-- Compute th/d: (not including magical pluses)
		dball_data.rhand_th = 0 - player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY] + m_weap_th 
		dball_data.rhand_td = m_td
		-- While we're here, let's add our parry bonus
		player.to_a = player.to_a + get_skill(SKILL_PARRYING)


	-- Special case for combat.lua to deal with!
	-- Here's an easy one: Gun and junk (This and next separate to preserve handedness for (+,+) comps
	elseif (w1 == 2 and w2 == -1) then
		dball_data.lhand_th = get_skill(SKILL_MARKSMANSHIP) - player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY]

	-- Special case for combat.lua to deal with!
	-- And, conversely, junk and gun
	elseif (w1 == -1 and w2 == 2) then
		dball_data.rhand_th = get_skill(SKILL_MARKSMANSHIP) - player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY]

	-- Special case for combat.lua to deal with!
	-- Weapon and gun
	elseif (w1 == 1 and w2 == 2) then
		-- HAVE TO compute both, because even if we can't double melee, we still
		-- need to be able to 'f'ire the gun at range. So, compute and let
		-- combat.lua decide if we have ultimate fighting
		-- Non-matched paired weapon penalty applies to both weapons (obviously they can't naturally pair)
		-- but paired skill reduces penalty to the melee weapon, but not the firearm
		local net_penalty = (player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY] * player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY])
		dball_data.lhand_th =  0 - net_penalty + m_weap_th 
		dball_data.lhand_td = m_td
		player.to_a = player.to_a + get_skill(SKILL_PARRYING)
		dball_data.rhand_th = get_skill(SKILL_MARKSMANSHIP) - net_penalty
	-- Special case for combat.lua to deal with!
	-- Gun and weapon
	elseif (w1 == 2 and w2 == 1) then
		-- Again, compute both. combat.lua will decide whether we can ultimate fight
		local net_penalty = (player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY] * player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY])
		dball_data.rhand_th =  0 - net_penalty + m_weap_th
		dball_data.rhand_dis_th = dball_data.rhand_th
		player.to_a = player.to_a + get_skill(SKILL_PARRYING)
		dball_data.lhand_th = get_skill(SKILL_MARKSMANSHIP) - net_penalty

	-- Weapon and Weapon! Fighting Florentine! Yay!
	elseif (w1 == 1 and w2 == 1) then
		-- Naturally matched weapons?
		if player.inventory[INVEN_WIELD][1].flags[FLAG_PAIRED] and (player.inventory[INVEN_WIELD][1].sval == player.inventory[INVEN_WIELD][2].sval) then
			dball_data.lhand_th =  m_weap_th  - player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY]
			dball_data.rhand_th =  dball_data.lhand_th
		else
			-- Not matched, multiply penalties
			local mismatch_penalty = (player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY] * player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY])
			-- reduce by paired skill
			mismatch_penalty = mismatch_penalty - get_skill(SKILL_PAIRED)
			-- Apply the negative values to each hand
			dball_data.lhand_th = 0 - mismatch_penalty
			dball_data.rhand_th = dball_data.lhand_th
			-- Check to confirm that paired did not reduce penalty beyond the
			-- base difficulty for each weapon
			if dball_data.lhand_th > (0 - player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY]) then
				dball_data.lhand_th = (0 - player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY])
			end
			if dball_data.rhand_th > (0 - player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY]) then
				dball_data.rhand_th = (0 - player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY])
			end
		end
		--Either way:
		dball_data.lhand_th = dball_data.lhand_th + m_weap_th
		dball_data.rhand_th = dball_data.rhand_th + m_weap_th
		dball_data.lhand_td = m_td
		dball_data.rhand_td = m_td
		player.to_a = player.to_a + get_skill(SKILL_PARRYING) + get_skill(SKILL_PARRYING)

	-- Special case for combat.lua to deal with! (ab_paired_firearms does not imply ab_point_blank)
	-- Gun and Gun! hook[wield_pre etc.
	elseif (w1 == 2 and w2 == 2) then
		-- Guns *always* naturally pair, provided you have ab_paired_firearms
		-- (Don't assume difficulty penalty s the same for each firearm)
		dball_data.lhand_th = get_skill(SKILL_MARKSMANSHIP) - player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY]
		dball_data.rhand_th = get_skill(SKILL_MARKSMANSHIP) - player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY]

	-- Special case for combat.lua to deal with!
	-- Gun and Barehand
	elseif (w1 == 2 and w2 == 0) then
		-- No matter what, we have to compute the gun because it can 'f'ire
		dball_data.lhand_th = get_skill(SKILL_MARKSMANSHIP) - player.inventory[INVEN_WIELD][1].flags[FLAG_DIFFICULTY]
		-- But...are we able to fight barehand melee?
		-- (Let combat.lua figure out if we can firearm melee, too. Doesn't matter here)
		if has_ability(AB_DOUBLE_ATTACK) then
			dball_data.rhand_th = m_hand_th
			dball_data.rhand_td = m_td
			-- Add our AC bonus from Barehand:
			if has_ability(AB_BLOCKING) then
				player.to_a = player.to_a + get_skill(SKILL_HAND)
			end
		else
			-- No, can't melee. Disable it.
			dball_data.rhand_valid = -1
		end
	-- Special case for combat.lua to deal with!
	-- Barehand and Gun
	elseif (w1 == 0 and w2 == 2) then
		-- Barehand and gun. Same as previous, only reversed hands.
		dball_data.rhand_th = get_skill(SKILL_MARKSMANSHIP) - player.inventory[INVEN_WIELD][2].flags[FLAG_DIFFICULTY]
		-- Once again, can with melee with the hand?
		if has_ability(AB_DOUBLE_ATTACK) then
			dball_data.lhand_th = m_hand_th
			dball_data.lhand_td = m_td
			-- Add our AC bonus from Barehand:
			if has_ability(AB_BLOCKING) then
				player.to_a = player.to_a + get_skill(SKILL_HAND)
			end
		else
			-- Nope. Disable it.
			dball_data.rhand_valid = -1
		end
	else
		message("Hwaaahuh?!!? Wielding something out of the 16 combat permutations in calc.lua?")
		message("REPORT this bug please! Tell me what you were wielding in each hand!")
	end -- End Compute combat tohit and attacks

	-- Hack: Apply to-hit penalty if fighting from a motorcycle
	if player.inventory[INVEN_VEHICLE][1] then
		if dball_data.lhand_valid > 0 then
			dball_data.lhand_th = dball_data.lhand_th - 30
		end
	end

	-- Battle Aura adds (Chi Defense skill * 2) to AC
	if dball_data.chi_aura_setting == 1 then
		player.to_a = player.to_a + get_skill(SKILL_CHI_DEFENSE) + get_skill(SKILL_CHI_DEFENSE)
	end

	-- Now, since all of the above is always known
	-- copy over to _dis:

	dball_data.lhand_dis_th = dball_data.lhand_th
	dball_data.lhand_dis_td = dball_data.lhand_td
	dball_data.rhand_dis_th = dball_data.rhand_th
	dball_data.rhand_dis_td = dball_data.rhand_td
	player.dis_to_a = player.to_a

-- ************ APPLY ALL EQUIPMENT MODIFIERS HERE!!! ****************
	-- Scan the usable inventory
	local o_ptr
	local gathered = {}
	local equip_ac, equip_toh, equip_tod = 0, 0, 0

	-- First, universals
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL, function(o_ptr)

		-- Already done by player.basic_calc_bonuses() above
		-- apply_flags(o_ptr.flags, o_ptr)
		-- gather_flags(%gathered, o_ptr.flags, o_ptr)


-- Have we already done this somewhere?
--[[
		-- Modify the base armor class
		player.ac = player.ac + o_ptr.ac

		-- The base armor class is always known
		player.dis_ac = player.dis_ac + o_ptr.ac

		-- Apply the magic bonus to armor class
		player.to_a = player.to_a + o_ptr.to_a

		-- Display magic bonus to ac, if known
		if is_known(o_ptr) then
			player.dis_to_a = player.dis_to_a + o_ptr.to_a
		end
]]

		-- Apply combat modifiers that 'always' apply
		-- Headgear
		-- gloves
		-- shields
		-- scuba gear
		if o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] and o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_ALWAYS then

			-- First, actually apply the modifiers
			-- Left hand
			if %w1 >= 0 then
				dball_data.lhand_th = dball_data.lhand_th + o_ptr.to_h
				dball_data.lhand_td = dball_data.lhand_td + o_ptr.to_d
			end
			-- Right hand
			if %w2 >= 0 then
				dball_data.rhand_th = dball_data.rhand_th + o_ptr.to_h
				dball_data.rhand_td = dball_data.rhand_td + o_ptr.to_d
			end

			-- Next, display them if they're known
			if is_known(o_ptr) then
				-- Left hand
				if %w1 >= 0 then
					dball_data.lhand_dis_th = dball_data.lhand_dis_th + o_ptr.to_h
					dball_data.lhand_dis_td = dball_data.lhand_dis_td + o_ptr.to_d
				end
				-- Right hand
				if %w2 >= 0 then
					dball_data.rhand_dis_th = dball_data.rhand_dis_th + o_ptr.to_h
					dball_data.rhand_dis_td = dball_data.rhand_dis_td + o_ptr.to_d
				end
			end
		end
	end)

	-- Mods affect melee, but not firearms:
	-- Flak armors
	-- Cloaks
	-- Bracers
	-- Any melee type mods (barehand or weapon)
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL, function(o_ptr)
		if o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] and o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_MELEE then

			-- First, actually apply the modifiers
			-- Left hand
			if %w1 == 0 or %w1 == 1 then
				dball_data.lhand_th = dball_data.lhand_th + o_ptr.to_h
				dball_data.lhand_td = dball_data.lhand_td + o_ptr.to_d
			end
			-- Right hand
			if %w2 == 0 or %w2 == 1 then
				dball_data.rhand_th = dball_data.rhand_th + o_ptr.to_h
				dball_data.rhand_td = dball_data.rhand_td + o_ptr.to_d
			end

			-- Next, display them if they're known
			if is_known(o_ptr) then
				-- Left hand
				if %w1 == 0 or %w1 == 1 then
					dball_data.lhand_dis_th = dball_data.lhand_dis_th + o_ptr.to_h
					dball_data.lhand_dis_td = dball_data.lhand_dis_td + o_ptr.to_d
				end
				-- Right hand
				if %w2 == 0 or %w2 == 1 then
					dball_data.rhand_dis_th = dball_data.rhand_dis_th + o_ptr.to_h
					dball_data.rhand_dis_td = dball_data.rhand_dis_td + o_ptr.to_d
				end
			end
		end
	end)

--	At present, no items modify only barehanded combat (Brass knuckles?)
--[[
	-- Next, check for barehand-only modifiers
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL, function(o_ptr)
		if o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] and o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_HANDS then

		end
	end)
]]
--	The only of these two types are the weapons/guns themselves, so only check the wield slots for them
--[[
	-- Weapon-only mods
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL, function(o_ptr)
		if o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] and o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_WEAPONS then

		end
	end)
	-- Gun-only mods
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL, function(o_ptr)
		if o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] and o_ptr.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_GUNS then

		end
	end)
]]

	-- Finally, if individual weapons/guns are magic, apply their bonuses to themselves only
	-- For instance...if the right hand has a (+5, +5) sword, the sword in the left hand
	-- does not benefit from it
	-- Left hand
	if player.inventory[INVEN_WIELD][1] then
		dball_data.lhand_th = dball_data.lhand_th + player.inventory[INVEN_WIELD][1].to_h
		dball_data.lhand_td = dball_data.lhand_td + player.inventory[INVEN_WIELD][1].to_d
		if is_known(player.inventory[INVEN_WIELD][1]) then
			dball_data.lhand_dis_th = dball_data.lhand_dis_th + player.inventory[INVEN_WIELD][1].to_h
			dball_data.lhand_dis_td = dball_data.lhand_dis_td + player.inventory[INVEN_WIELD][1].to_d
		end
	end
	-- Right hand
	if player.inventory[INVEN_WIELD][2] then
		dball_data.rhand_th = dball_data.rhand_th + player.inventory[INVEN_WIELD][2].to_h
		dball_data.rhand_td = dball_data.rhand_td + player.inventory[INVEN_WIELD][2].to_d
		if is_known(player.inventory[INVEN_WIELD][2]) then
			dball_data.rhand_dis_th = dball_data.rhand_dis_th + player.inventory[INVEN_WIELD][2].to_h
			dball_data.rhand_dis_td = dball_data.rhand_dis_td + player.inventory[INVEN_WIELD][2].to_d
		end
	end


-- ******************* End Equipment Bonuses ************************

	-- Redraw armor (if needed)
	if (player.dis_ac ~= old_dis_ac) or (player.dis_to_a ~= old_dis_to_a) then
		-- Redraw
		player.redraw[FLAG_PR_ARMOR] = true

		-- Window stuff
		-- player.window = player.window | PW_PLAYER
	end

	-- Boost digging skill by tool weight
	-- o_ptr = player.inventory[INVEN_TOOL][1]
	-- if o_ptr and o_ptr.flags[FLAG_DIGGER] then
	-- 	player.skill_dig = player.skill_dig + (o_ptr.weight / 10)
	-- end

	-- Dragonball T doesn't use heavy wield
	-- Martial arts weapons are all pretty much five pounds or less.
	-- Last time I weighed a katana, for example, it was 2.2 pounds.
	-- It's a good game mechanic in ToME, but oriental weapons just
	-- don't weigh that much.
	player.heavy_wield = FALSE

	-- Let the scripts do what they need
	-- findme
	hook.process(hook.CALC_BONUS_END, silent)

	-- Stealth
	player.skill_stl = player.skill_stl + 1 + (get_skill_scale(SKILL_STEALTH, 25))
	if player.skill_stl > 30 then player.skill_stl = 30 end
	if player.skill_stl < 0 then player.skill_stl = 0 end

	if player.inventory[INVEN_VEHICLE][1] then
		player.skill_stl = 0
	end

	-- Affect Skill -- digging (STR)
	-- player.skill_dig = player.skill_dig + player.stat(A_STR)
	-- if player.skill_dig < 1 then player.skill_dig = 1 end

	-- Disarming
	player.skill_dis = player.skill_dis + player.stat(A_INT) + get_skill(SKILL_TECHNOLOGY) + get_skill(SKILL_DISASSEMBLY)

	-- Searching
	player.inc_intrinsic(FLAG_SEARCH_POWER, player.stat(A_INT))
	player.inc_intrinsic(FLAG_SEARCH_FREQ, player.stat(A_INT))

	-- Regeneration Rates
	-- NO BASIC REGENERATION ON KARIN TOWER! Nyeh!
	if cave(player.py, player.px).feat ~= FEAT_KARIN_TOWER then
	
		local regen_rate = player.mhp()
		if player.mhp() < 200 then
			player.inc_intrinsic(FLAG_REGEN_LIFE, 200)
		end

		if player.movement_mode > 1 then
			if mov_mode.get_info(player.movement_mode, "name") == "Running" then
				regen_rate = regen_rate / 2
			end
		end

		player.inc_intrinsic(FLAG_REGEN_LIFE, regen_rate)
	end

	-- Chi: Regeneration is the same regardless of death state
	if dball_data.chi_regeneration_setting > 0 then
		player.inc_intrinsic(FLAG_REGEN_LIFE, dball_data.chi_regeneration_setting * 1000)
	end


	-- NOTE!: intrinsic REGEN_MANA is NOT used by DBT!
	dball.mchi_calculate_drain()
	-- player.inc_intrinsic(FLAG_REGEN_MANA, dball_data.chi_drain_rate)

end



