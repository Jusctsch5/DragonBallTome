-- Dragonball T: Enrollment Subsystem

-- This wasn't really designed with adaptation to other modules in mind,
-- but it shouldn't take too much effort to do so.
-- Note that about 80% of this file is the actual school definitions for
-- Dragonball T, so it's not as big as it looks.

new_flag("SS_SKILL")
new_flag("SS_ABILITY")
new_flag("SS_SPECIAL")

function dball.count_closed_schools()
	local count = 0
	if c_schools[FLAG_KARATE] == FLAG_SCHOOL_CLOSED then
		count = count + 1
	end
	if c_schools[FLAG_KICKBOXING] == FLAG_SCHOOL_CLOSED then
		count = count + 1
	end
	if c_schools[FLAG_KUNGFU] == FLAG_SCHOOL_CLOSED then
		count = count + 1
	end
	if c_schools[FLAG_FENCING] == FLAG_SCHOOL_CLOSED then
		count = count + 1
	end
	if c_schools[FLAG_SUMO] == FLAG_SCHOOL_CLOSED then
		count = count + 1
	end
	if c_schools[FLAG_JUDO] == FLAG_SCHOOL_CLOSED then
		count = count + 1
	end
	if c_schools[FLAG_BALLET] == FLAG_SCHOOL_CLOSED then
		count = count + 1
	end
--	if c_schools[FLAG_MARKSMANSHIP] == FLAG_SCHOOL_CLOSED then
--		count = count + 1
--	end
--	if c_schools[FLAG_TAEKWONDO] == FLAG_SCHOOL_CLOSED then
--		count = count + 1
--	end
	if c_schools[FLAG_NINJUTSU] == FLAG_SCHOOL_CLOSED then
		count = count + 1
	end

	return count
end

function dball.show_class_display(qty_classes, school_data, which_school, zeni_cost, school_flag)

	local school_name = dball.flagtoschool(which_school)

	term.blank_print(color.YELLOW, school_name .. " Press (ESC) to exit", 0, 0) -- '(?) for help'...?

	-- Note: Tony, Tofu, YMCA don't have entries in here...
	if enrollments[which_school] then
		if enrollments[which_school] > 1 then
			term.blank_print("You have trained here " .. enrollments[which_school] .. " times", 1, 0)
		elseif enrollments[which_school] == 1 then
			term.blank_print("You have trained here once before", 1, 0)
		else
			term.blank_print("You've never trained here", 1, 0)
		end
	end

	term.blank_print(color.LIGHT_RED, "You have", 2, 0)
	term.blank_print(" Zeni:", 3, 0)
	term.blank_print("Skill:", 4, 0)
	term.blank_print(color.LIGHT_BLUE, player.au, 3, 7)
	term.blank_print(color.LIGHT_BLUE, player.skill_points, 4, 7)

	term.blank_print(color.LIGHT_RED, "Classes cost", 2, 18)
	term.blank_print(" Zeni:", 3, 17)
	term.blank_print(color.LIGHT_BLUE, zeni_cost, 3, 24)	-- Zeni

	term.blank_print(color.LIGHT_RED, "Class            Current  Gain    Cap  SkillCost", 6, 0)

	for i = 1, qty_classes do
		local func = school_data[i].reqfct
		if func() then
			if school_data[i].type == FLAG_SS_SKILL then
				term.blank_print(color.YELLOW, "(" .. school_data[i].key .. ") " .. skill(school_data[i].skill).name, 7 + i, 0)
				term.blank_print(color.LIGHT_BLUE, dball.sk(school_data[i].skill), 7 + i, 17)
			elseif school_data[i].type == FLAG_SS_ABILITY then
				-- Silly me...thinking it might use the standard convention...
				-- term.blank_print(color.YELLOW, "(" .. school_data[i].key .. ") " .. ability(school_data[i].skill).name, 7 + i, 0)
				term.blank_print(color.YELLOW, "(" .. school_data[i].key .. ") " .. dball.ability_lookup(school_data[i].skill), 7 + i, 0)
				if ability(school_data[i].skill).acquired == true then
					term.blank_print(color.LIGHT_BLUE, "Known", 7 + i, 17)
				else
					term.blank_print(color.LIGHT_BLUE, "Not Known", 7 + i, 17)
				end
			elseif school_data[i].type == FLAG_SS_SPECIAL then
				term.blank_print(color.YELLOW, "(" .. school_data[i].key .. ") " .. skill(school_data[i].skill).name, 7 + i, 0)
				term.blank_print(color.LIGHT_BLUE, chi_masters[which_school][school_data[i].skill], 7 + i, 17)
			end
			term.blank_print(color.LIGHT_BLUE, dball.sknum_to_str(school_data[i].gain), 7 + i, 27)
			func = school_data[i].cap
			if func() and func() > 0 then
				local foo = func() + dball.capsystem(school_data[i].skill)
				local color_by_level_cap = color.LIGHT_BLUE
				--if func() > player.lev + 10 then
				--	color_by_level_cap = color.YELLOW
				--end
				term.blank_print(color_by_level_cap, foo, 7 + i, 34)
			end
			term.blank_print(color.LIGHT_BLUE, school_data[i].skcost, 7 + i, 39)
			if school_data[i].type == FLAG_SS_SPECIAL then
				term.blank_print(color.LIGHT_RED, "(Chi Master: Relative cap)", 7 + i, 44)
			end
		else
			func = school_data[i].visible
			if func() then
				if school_data[i].type == FLAG_SS_SKILL then
					term.blank_print(color.LIGHT_UMBER, "(" .. school_data[i].key .. ") " .. skill(school_data[i].skill).name, 7 + i, 0)
					term.blank_print(color.LIGHT_BLUE, dball.sk(school_data[i].skill), 7 + i, 17)
				elseif school_data[i].type == FLAG_SS_ABILITY then
					term.blank_print(color.LIGHT_UMBER, "(" .. school_data[i].key .. ") " .. dball.ability_lookup(school_data[i].skill), 7 + i, 0)
				elseif school_data[i].type == FLAG_SS_SPECIAL then
					-- Implement me! (Is this possible?)
				end
				term.blank_print(color.LIGHT_UMBER, school_data[i].reqtxt, 7 + i, 27)
			end
		end
	end
end


function dball.flagtoschool(which)
	if which == FLAG_KARATE then
		return "Karate"
	elseif which == FLAG_KICKBOXING then
		return "Kickboxing"
	elseif which == FLAG_KUNGFU then
		return "Kung fu"
	elseif which == FLAG_FENCING then
		return "Fencing"
--	elseif which == FLAG_TAEKWONDO then
--		return "Tae Kwon Do"
	elseif which == FLAG_NINJUTSU then
		return "Ninjutsu"
	elseif which == FLAG_BALLET then
		return "Ballet"
	elseif which == FLAG_SUMO then
		return "Sumo"
	elseif which == FLAG_JUDO then
		return "Judo"
	elseif which == FLAG_MARKSMANSHIP then
		return "Firing Range"
	elseif which == FLAG_TONY then
		return "Robbins Foundation"
	elseif which == FLAG_TOFU then
		return "Acupuncture Clinic"
	elseif which == FLAG_YMCA then
		return "Y.M.C.A"
	elseif which == FLAG_FLIGHT_SCHOOL then
		return "Flight School"

	-- Uniques
	elseif which == FLAG_ENROLL_ROSSHI then
		return "Rosshi"
--	elseif which == FLAG_ENROLL_URANAI_BABA then
--		return "Uranai Baba"
	elseif which == FLAG_ENROLL_CRANE_HERMIT then
		return "Tsuru Sen'Nin"
	elseif which == FLAG_ENROLL_ABBOT then
		return "Abbot"
	elseif which == FLAG_ENROLL_KARIN then
		return "Karin"
	elseif which == FLAG_ENROLL_MUSASHI then
		return "Miyamoto Musashi"
	elseif which == FLAG_ENROLL_POPO then
		return "Mr. Popo"
	elseif which == FLAG_ENROLL_KAMI then
		return "Kami"
	elseif which == FLAG_ENROLL_NORTH_KAIO then
		return "The North Kaio"
	elseif which == FLAG_ENROLL_TRUNKS then
		return "Trunks"

	elseif which == FLAG_ENROLL_SPLINTER then
		return "Splinter"
	elseif which == FLAG_ENROLL_SHREDDER then
		return "Oroku Saki"
	elseif which == FLAG_ENROLL_BRIEFS_SOME then
		return "Dr Briefs"
	elseif which == FLAG_ENROLL_BRIEFS_ALL then
		return "Dr Briefs"

	elseif which == FLAG_ENROLL_MONK then
		return "Buddhist Monk"




	else
		return "Trainer needs name"
	end
end

-- Since ability(n).name doesn't seem to work
function dball.ability_lookup(which)
	if which == AB_BLOCKING then
		return "Blocking"
	elseif which == AB_DOUBLE_ATTACK then
		return "Double Attack"
	elseif which == AB_TAMESHIWARI then
		return "Tameshiwari"
	elseif which == AB_PAIRED_WEAPONS then
		return "Paired Weapons"
	elseif which == AB_RIPOSTE then
		return "Riposte"
	elseif which == AB_IAIJUTSU then
		return "Iaijutsu"
	elseif which == AB_BLEED_ATTACK then
		return "Bleed Attack"
	elseif which == AB_JUMP then
		return "Jumping"
	elseif which == AB_PAIRED_FIREARMS then
		return "Paired Firearms"
	elseif which == AB_POINT_BLANK then
		return "Point Blank Firing"
	elseif which == AB_MULTI_TARGET then
		return "Not Implemented"
--		return "Multi Targeting"
	elseif which == AB_MOTORCYCLIST then
		return "Motorcycling"
	elseif which == AB_PILOT then
		return "Aircraft Pilot"
	elseif which == AB_SKATING then
		return "Skating"
	elseif which == AB_SWIMMING then
		return "Swimming"
	elseif which == AB_FIRST_AID then
		return "First Aid"
	elseif which == AB_ACUPUNCTURE then
		return "Acupuncture"
	elseif which == AB_IMMOVABILITY then
		return "Immovability"
	elseif which == AB_SNEAK then
		return "Sneaking"
	elseif which == AB_THROW then
		return "Not implemented"
--		return "Throw"
	elseif which == AB_ULTIMATE then
		return "Not implemented"
--		return "Ultimate Fighting"
	elseif which == AB_HASTE then
		return "Haste"
	elseif which == AB_BLINK then
		return "Burst of Speed"
	elseif which == AB_CHI_BURST then
		return "Chi Burst"
	elseif which == AB_AURA then
		return "Battle Aura"
	elseif which == AB_LIGHT then
		return "Aura Light"
	elseif which == AB_POWER_DETECTION then
		return "Power Detection"
	elseif which == AB_CURE then
		return "Cure Conditions"
	elseif which == AB_HEAL then
		return "Healing"
	elseif which == AB_SPIRIT_BOMB then
		return "Spirit Bomb"  
	elseif which == AB_FUSION then
		return "Fusion (Not impl)"  
	elseif which == AB_TELEPORTATION then
		return "Teleport"  
	elseif which == AB_PLANETARY_TELEPORT then
		return "Planetary Teleport"  
	elseif which == AB_FLIGHT then
		return "Flight"
	elseif which == AB_MEDITATION then
		return "Meditation"
	else
		return "Not implemented"
	end

end

function dball.enroll(which_school)
	local school_data, class_qty, zeni_cost
	school_data, class_qty, zeni_cost = dball.get_school_definition(which_school)

	while not nil do
		term.save()
		term.clear()

		local class_qualify = 1
		local school_name = dball.flagtoschool(which_school)

		dball.show_class_display(class_qty, school_data, which_school, zeni_cost, which_school)

		local key = term.inkey()

		if key == "\r" or key == ESCAPE then
			term.clear()
			dball.cq_check(which_school)
			term.load()
			break
		elseif strchar(key) == "?" then
			
		end

		for i = 1, class_qty do
			if strchar(key) == school_data[i].key then
				if school_data[i].type == FLAG_SS_SKILL then
					if player.au >= zeni_cost and player.skill_points >= school_data[i].skcost then
						local func = school_data[i].reqfct
						if func() then
							func = school_data[i].cap
							local foo = func() + dball.capsystem(school_data[i].skill)
							if skill(school_data[i].skill).value < (foo * 1000) then
								-- if skill(school_data[i].skill).value < ((player.lev + 10) * 1000) then
									player.au = player.au - zeni_cost
								 	player.skill_points = player.skill_points - school_data[i].skcost
									if enrollments[which_school] then
										enrollments[which_school] = enrollments[which_school] + 1
									end
									quest(QUEST_DOJO).status = QUEST_STATUS_FINISHED
									skill(SKILL_MARTIALARTS).dev = true
									skill(SKILL_WEAPONS).dev = true
									skill(SKILL_CHI).dev = true
									skill(SKILL_TECHNOLOGY).dev = true
									skill(school_data[i].skill).value = skill(school_data[i].skill).value + school_data[i].gain
								-- end
							end
						end
					end
				elseif school_data[i].type == FLAG_SS_ABILITY then
					if player.au >= zeni_cost and player.skill_points >= school_data[i].skcost then
						if not has_ability(school_data[i].skill) then
							local func = school_data[i].reqfct
							if func() then
								player.au = player.au - zeni_cost
								player.skill_points = player.skill_points - school_data[i].skcost
								ability(school_data[i].skill).hidden = false
								ability(school_data[i].skill).acquired = true
								if enrollments[which_school] then
									enrollments[which_school] = enrollments[which_school] + 1
								end
							end
						end
					end
				elseif school_data[i].type == FLAG_SS_SPECIAL then
					if player.au >= zeni_cost and player.skill_points >= school_data[i].skcost then
						local func = school_data[i].reqfct
						if func() then
							func = school_data[i].cap
							local foo = func() -- No skillcap bonus! This is a relative amount!
							if chi_masters[which_school][school_data[i].skill] < (foo * 1000) then
								if chi_masters[which_school][school_data[i].skill] < (school_data[i].cap() * 1000) then
									-- player.au = player.au - zeni_cost
								 	player.skill_points = player.skill_points - school_data[i].skcost
									if enrollments[which_school] then
										enrollments[which_school] = enrollments[which_school] + 1
									end
									skill(SKILL_CHI).dev = true
									skill(school_data[i].skill).value = skill(school_data[i].skill).value + school_data[i].gain
									chi_masters[which_school][school_data[i].skill] = chi_masters[which_school][school_data[i].skill] + school_data[i].gain
									player.calc_bonuses(1)
								end
							end
						end
					end
				end
			end
		end

		-- Why doesn't this work properly?
		-- message("hp1: " .. player.mhp())
		player.calc_hitpoints()
		-- message("hp2: " .. player.mhp())
		player.calc_mana()
		player.calc_sanity()
		player.calc_bonuses(1)
		player.calc_hitpoints()
		term.load()
		player.calc_hitpoints()
		message()

	end -- end: enroll
end

-- Issue a challenge quest?
function dball.cq_check(which)
	if which == FLAG_KARATE and enrollments[FLAG_KARATE] > 0 and trainer[FLAG_KARATE] == 0 then
		if skill(SKILL_HAND).value >= 20000 and quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_UNTAKEN then
			dialogue.CQ_KARATE()
		end
	elseif which == FLAG_KICKBOXING and enrollments[FLAG_KICKBOXING] > 0 and trainer[FLAG_KICKBOXING] == 0 then
		if skill(SKILL_HAND).value >= 20000 and quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_UNTAKEN then
			dialogue.CQ_KICKBOXING()
		end
	elseif which == FLAG_KUNGFU and enrollments[FLAG_KUNGFU] > 0 and trainer[FLAG_KUNGFU] == 0 then
		if skill(SKILL_WEAPONS).value >= 20000 and quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_UNTAKEN then
			dialogue.CQ_KUNGFU()
		end
	elseif which == FLAG_FENCING and enrollments[FLAG_FENCING] > 0 and trainer[FLAG_FENCING] == 0 then
		if skill(SKILL_WEAPONS).value >= 20000 and quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_UNTAKEN then
			dialogue.CQ_FENCING()
		end
--	elseif which == FLAG_TAEKWONDO and enrollments[FLAG_TAEKWONDO] > 0 then
--		if (skill(SKILL_HAND).value >= 20000 or skill(SKILL_WEAPONS).value >= 20000) and quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_UNTAKEN then
--			dialogue.CQ_TAEKWONDO()
--		end
	elseif which == FLAG_NINJUTSU and enrollments[FLAG_NINJUTSU] > 0 then
		-- Mutually exclusive quests on this tree
		if skill(SKILL_STEALTH).value >= 10000 then
			if quest(QUEST_CHALLENGE_BALLET).status == QUEST_STATUS_UNTAKEN then
				if quest(QUEST_KILL_SHREDDER_FOR_HATSUMI).status == QUEST_STATUS_UNTAKEN then
					dialogue.CQ_NINJUTSU()
				end
			end
		end
	elseif which == FLAG_SUMO and enrollments[FLAG_SUMO] > 0 and trainer[FLAG_SUMO] == 0 then
		if (skill(SKILL_HAND).value >= 20000 or skill(SKILL_STRENGTH).value >= 20000) and quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_UNTAKEN then
			dialogue.CQ_SUMO()
		end
	elseif which == FLAG_JUDO and enrollments[FLAG_JUDO] > 0 and trainer[FLAG_JUDO] == 0 then
		if skill(SKILL_DODGE).value >= 20000 and quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_UNTAKEN then
			dialogue.CQ_JUDO()
		end
	elseif which == FLAG_BALLET and enrollments[FLAG_BALLET] > 0 then
		if skill(SKILL_DEXTERITY).value >= 30000 and quest(QUEST_CHALLENGE_NINJUTSU).status == QUEST_STATUS_UNTAKEN then
			dialogue.CQ_BALLET()
		end
	elseif which == FLAG_MARKSMANSHIP and enrollments[FLAG_MARKSMANSHIP] > 0 then
		if skill(SKILL_MARKSMANSHIP).value >= 20000 and quest(QUEST_TAXIDERMY).status == QUEST_STATUS_UNTAKEN then
			if FLAG_ENROLL_info_idx(FLAG_ENROLL_BEAR_THIEF, 0).max_num ~= 0 then
				dialogue.CQ_MARKSMANSHIP()
			end
		end

	-- Chi Master Quests
	-- These should probably check number of CHI gains, not total enrollments
	elseif which == FLAG_ENROLL_CRANE_HERMIT and enrollments[FLAG_ENROLL_CRANE_HERMIT] > 9 then
		if trainer[FLAG_ENROLL_CRANE_HERMIT] == 0 then
			if quest(QUEST_CHI_CRANE).status == QUEST_STATUS_UNTAKEN then
				dialogue.CHI_CRANE()
			end
		end
	elseif which == FLAG_ENROLL_ROSSHI then
		if enrollments[FLAG_ENROLL_ROSSHI] > 9 then
			if dball_data.rosshi_turtle_shells < 2 then
				dialogue.ROSSHI_SHELL_TWO()
			end
		end
	end
end

function dball.capsystem(which_skill)
	return skillcaps[which_skill]
end

function dball.get_school_definition(which)
	local school_data = {}
	local class_qty = 1
	local zeni_cost = 1

	if which == FLAG_KARATE then
		class_qty = 5
		zeni_cost = 10
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_MARTIALARTS,
					["gain"] = 600,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KARATE] == 0 then
								return 10
							else
								return 10 + (5 * dball.count_closed_schools())
							end
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_HAND,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KARATE] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "b",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_WEAPONS,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KARATE] == 0 then
								return 5
							else
								return 5 + (2 * dball.count_closed_schools())
							end
					end
					["key"] = "w",
					["reqtxt"] = "Requires 10 classes and 10 Barehand",
					["reqfct"] = function()
						if enrollments[FLAG_KARATE] >= 10 and skill(SKILL_HAND).value >= 10000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_STRENGTH,
					["gain"] = 400,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KARATE] == 0 then
								return 10
							else
								return 10 + (5 * dball.count_closed_schools())
							end
					end
					["key"] = "s",
					["reqtxt"] = "Requires level 15 and 15 Barehand",
					["reqfct"] = function()
						if player.lev >= 15 and skill(SKILL_HAND).value >= 15000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_BLOCKING,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "k",
					["reqtxt"] = "Requires 20 Barehand",
					["reqfct"] = function()
						if skill(SKILL_HAND).value >= 20000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}

	elseif which == FLAG_KUNGFU then
		class_qty = 7
		zeni_cost = 20
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_MARTIALARTS,
					["gain"] = 700,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KUNGFU] == 0 then
								return 15
							else
								return 15 + (5 * dball.count_closed_schools())
							end
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_HAND,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KUNGFU] == 0 then
								return 10
							else
								return 10 + (2 * dball.count_closed_schools())
							end
					end
					["key"] = "b",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_WEAPONS,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KUNGFU] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "w",
					["reqtxt"] = "Requires 10 Dexterity stat",
					["reqfct"] = function()
						if player.stat(A_DEX) >= 10 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DEXTERITY,
					["gain"] = 400,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KUNGFU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_PARRYING,
					["gain"] = 1500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KUNGFU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "r",
					["reqtxt"] = "Requires 25 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 25000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_PAIRED,
					["gain"] = 2000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KUNGFU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "p",
					["reqtxt"] = "Requires 25 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 30000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[7] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_PAIRED_WEAPONS,
					["gain"] = 0,
					["skcost"] = 20,
					["cap"] = function()
							return 0
					end
					["key"] = "i",
					["reqtxt"] = "Requires 30 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 30000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}

	elseif which == FLAG_FENCING then
		class_qty = 4
		zeni_cost = 20
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_WEAPONS,
					["gain"] = 1200,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_FENCING] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "w",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_PARRYING,
					["gain"] = 1500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_FENCING] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "r",
					["reqtxt"] = "Requires 20 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 20000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_SPEED,
					["gain"] = 300,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_FENCING] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "d",
					["reqtxt"] = "Requires level 15",
					["reqfct"] = function()
						if player.lev >= 15 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_RIPOSTE,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "i",
					["reqtxt"] = "Requires 30 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 30000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}

--[[
	elseif which == FLAG_TAEKWONDO then
		class_qty = 4
		zeni_cost = 10
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_MARTIALARTS,
					["gain"] = 700,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_TAEKWONDO] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_HAND,
					["gain"] = 700,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_TAEKWONDO] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "b",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_WEAPONS,
					["gain"] = 700,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_TAEKWONDO] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "w",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DEXTERITY,
					["gain"] = 400,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_TAEKWONDO] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
]]
	elseif which == FLAG_KICKBOXING then
		class_qty = 4
		zeni_cost = 25
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_HAND,
					["gain"] = 1200,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KICKBOXING] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "b",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_SPEED,
					["gain"] = 300,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KICKBOXING] == 0 then
								return 10
							else
								return 10 + (5 * dball.count_closed_schools())
							end
					end
					["key"] = "s",
					["reqtxt"] = "Requires 25 Barehand",
					["reqfct"] = function()
						if skill(SKILL_HAND).value >= 25000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_CONSTITUTION,
					["gain"] = 400,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_KICKBOXING] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "c",
					["reqtxt"] = "Requires 30 Barehand",
					["reqfct"] = function()
						if skill(SKILL_HAND).value >= 30000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_DOUBLE_ATTACK,
					["gain"] = 0,
					["skcost"] = 20,
					["cap"] = function()
							return 0
					end
					["key"] = "a",
					["reqtxt"] = "Requires level 15 and 20 Barehand",
					["reqfct"] = function()
						if player.lev >= 15 and skill(SKILL_HAND).value >= 20000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_BALLET then
		class_qty = 3
		zeni_cost = 100
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DEXTERITY,
					["gain"] = 1000,
					["skcost"] = 2,
					["cap"] = function()
							if trainer[FLAG_BALLET] == 0 then
								return 30
							else
								return 40 + (10 * dball.count_closed_schools())
								-- return 40
							end
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_CONSTITUTION,
					["gain"] = 1000,
					["skcost"] = 2,
					["cap"] = function()
							if trainer[FLAG_BALLET] == 0 then
								return 10
							else
								-- return 20
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "c",
					["reqtxt"] = "Requires 25 dexterity stat",
					["reqfct"] = function()
						if player.stat(A_DEX) >= 25 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_JUMP,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
							return 0
					end
					["key"] = "a",
					["reqtxt"] = "Requires 40 dexterity stat",
					["reqfct"] = function()
						if player.stat(A_DEX) >= 40 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_NINJUTSU then
		class_qty = 6
		zeni_cost = 50
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_MARTIALARTS,
					["gain"] = 600,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_NINJUTSU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_HAND,
					["gain"] = 600,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_NINJUTSU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "b",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_WEAPONS,
					["gain"] = 600,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_NINJUTSU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "w",
					["reqtxt"] = "Requires 10 Dexterity stat",
					["reqfct"] = function()
						if player.stat(A_DEX) >= 10 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_THROWING,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_NINJUTSU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "t",
					["reqtxt"] = "Requires 10 Dexterity stat",
					["reqfct"] = function()
						if player.stat(A_DEX) >= 10 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DEXTERITY,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_NINJUTSU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_STEALTH,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_NINJUTSU] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "s",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}


	elseif which == FLAG_SUMO then
		class_qty = 5
		zeni_cost = 20
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_HAND,
					["gain"] = 800,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_SUMO] == 0 then
								return 5
							else
								return 5 + (5 * dball.count_closed_schools())
							end
					end
					["key"] = "b",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_STRENGTH,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_SUMO] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "s",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_CONSTITUTION,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_SUMO] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "c",
					["reqtxt"] = "Requires 20 Strength stat",
					["reqfct"] = function()
						if player.stat(A_STR) >= 20 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_TAMESHIWARI,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
							return 0
					end
					["key"] = "t",
					["reqtxt"] = "Requires 10 Barehand",
					["reqfct"] = function()
						if skill(SKILL_HAND).value >= 10000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_IMMOVABILITY,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
							return 0
					end
					["key"] = "i",
					["reqtxt"] = "Requires 20 Strength stat",
					["reqfct"] = function()
						if player.stat(A_STR) >= 20 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_JUDO then
		class_qty = 5
		zeni_cost = 10
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_MARTIALARTS,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_JUDO] == 0 then
								return 5
							else
								return 5 + (4 * dball.count_closed_schools())
							end
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_HAND,
					["gain"] = 800,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_JUDO] == 0 then
								return 10
							else
								return 10 + (4 * dball.count_closed_schools())
							end
					end
					["key"] = "b",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DODGE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_JUDO] == 0 then
								return 20
							else
								return 20 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DEXTERITY,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_JUDO] == 0 then
								return 10
							else
								return 10 + (10 * dball.count_closed_schools())
							end
					end
					["key"] = "x",
					["reqtxt"] = "Requires 10 Dodge",
					["reqfct"] = function()
						if skill(SKILL_DODGE).value >= 10000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_SPEED,
					["gain"] = 400,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_JUDO] == 0 then
								return 10
							else
								return 10 + (5 * dball.count_closed_schools())
							end
					end
					["key"] = "s",
					["reqtxt"] = "Requires 20 Dexterity stat",
					["reqfct"] = function()
						if player.stat(A_DEX) >= 20 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_THROW,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "k",
					["reqtxt"] = "Requires 10 classes",
					["reqfct"] = function()
						if enrollments[FLAG_JUDO] >= 10 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_MUSASHI then
		class_qty = 7
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_WEAPONS,
					["gain"] = 700,
					["skcost"] = 1,
					["cap"] = function()
							return 60
					end
					["key"] = "w",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_PARRYING,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return 100
					end
					["key"] = "p",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DEXTERITY,
					["gain"] = 300,
					["skcost"] = 1,
					["cap"] = function()
							return 100
					end
					["key"] = "d",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_SPEED,
					["gain"] = 300,
					["skcost"] = 1,
					["cap"] = function()
							return 60
					end
					["key"] = "s",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_PAIRED_WEAPONS,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "d",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_IAIJUTSU,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
							return 0
					end
					["key"] = "i",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[7] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_BLEED_ATTACK,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "b",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_TONY then
		class_qty = 3
		zeni_cost = 100
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_INTELLIGENCE,
					["gain"] = 1000,
					["skcost"] = 3,
					["cap"] = function()
							return player.lev
					end
					["key"] = "i",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_CHARISMA,
					["gain"] = 1000,
					["skcost"] = 3,
					["cap"] = function()
							return player.lev
					end
					["key"] = "c",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_WILLPOWER,
					["gain"] = 1000,
					["skcost"] = 4,
					["cap"] = function()
							return player.lev
					end
					["key"] = "w",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_TOFU then
		class_qty = 2
		zeni_cost = 100
		school_data[1] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_FIRST_AID,
					["gain"] = 0,
					["skcost"] = 4,
					["cap"] = function()
							return 0
					end
					["key"] = "f",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_ACUPUNCTURE,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "a",
					["reqtxt"] = "Requires knowledge of first aid",
					["reqfct"] = function()
						if has_ability(AB_FIRST_AID) then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_YMCA then
		class_qty = 5
		zeni_cost = 100
		school_data[1] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_FIRST_AID,
					["gain"] = 0,
					["skcost"] = 4,
					["cap"] = function()
							return 0
					end
					["key"] = "f",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_SWIMMING,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
							return 0
					end
					["key"] = "s",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_SKATING,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
							return 0
					end
					["key"] = "k",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_MOTORCYCLIST,
					["gain"] = 0,
					["skcost"] = 20,
					["cap"] = function()
							return 0
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_THROWING,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
								return 50
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_FLIGHT_SCHOOL then
		class_qty = 1
		zeni_cost = 10000
		school_data[1] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_PILOT,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
							return 0
					end
					["key"] = "p",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_ROSSHI then
		class_qty = 10
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_MARTIALARTS,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							return 30
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_STRENGTH,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							return 10
					end
					["key"] = "s",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_CONSTITUTION,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							return 10
					end
					["key"] = "c",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_DOUBLE_ATTACK,
					["gain"] = 0,
					["skcost"] = 20,
					["cap"] = function()
							return 0
					end
					["key"] = "d",
					["reqtxt"] = "Requires 40 Barehand",
					["reqfct"] = function()
						if skill(SKILL_HAND).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ROSSHI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "i",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_OFFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ROSSHI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "o",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[7] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_REGENERATION,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ROSSHI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "r",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[8] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ROSSHI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[9] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_CHI_BURST,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
						return 0
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[10] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_LIGHT,
					["gain"] = 0,
					["skcost"] = 2,
					["cap"] = function()
						return 0
					end
					["key"] = "l",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_CRANE_HERMIT then
		class_qty = 10
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_MARTIALARTS,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							return 30
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DEXTERITY,
					["gain"] = 400,
					["skcost"] = 1,
					["cap"] = function()
							return 20
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_SPEED,
					["gain"] = 400,
					["skcost"] = 1,
					["cap"] = function()
							return 5
					end
					["key"] = "s",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_BLOCKING,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "b",
					["reqtxt"] = "Requires 40 Barehand",
					["reqfct"] = function()
						if skill(SKILL_HAND).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_CRANE_HERMIT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "i",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_DEFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_CRANE_HERMIT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "f",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[7] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_REGENERATION,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_CRANE_HERMIT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "r",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[8] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_CRANE_HERMIT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[9] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_LIGHT,
					["gain"] = 0,
					["skcost"] = 2,
					["cap"] = function()
						return 0
					end
					["key"] = "l",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[10] = 
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_FLIGHT,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
						return 0
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_MONK then
		class_qty = 1
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_MEDITATION,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "m",
					["reqtxt"] = "",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_ABBOT then
		-- Note: Abbot will only train AT ALL if alignment is > 99
		-- And of course, after he and the temple have been resuced
		-- This is handled in dialogue
		class_qty = 6
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_MEDITATION,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "m",
					["reqtxt"] = "",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ABBOT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "i",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_OFFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ABBOT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "f",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_DEFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ABBOT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_REGENERATION,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ABBOT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "r",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_ABBOT] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}	
	elseif which == FLAG_ENROLL_KARIN then
		class_qty = 11
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DEXTERITY,
					["gain"] = 500,
					["skcost"] = 1,
					["cap"] = function()
							return 20
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_SPEED,
					["gain"] = 300,
					["skcost"] = 1,
					["cap"] = function()
							return 20
					end
					["key"] = "s",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_KARIN] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "c",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_REGENERATION,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_KARIN] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "r",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_KARIN] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_HASTE,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
						return 0
					end
					["key"] = "h",
					["reqtxt"] = "Requires Chi Gung of 10",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 10000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[7] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_BLINK,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
						return 0
					end
					["key"] = "b",
					["reqtxt"] = "Requires the Haste ability",
					["reqfct"] = function()
						if has_ability(AB_HASTE) then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[8] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_AURA,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
						return 0
					end
					["key"] = "a",
					["reqtxt"] = "Requires Chi Gung of 10 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 10000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[9] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_LIGHT,
					["gain"] = 0,
					["skcost"] = 2,
					["cap"] = function()
						return 0
					end
					["key"] = "l",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[10] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_CHI_BURST,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
						return 0
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[11] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_BLOCKING,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "k",
					["reqtxt"] = "Requires 20 Barehand",
					["reqfct"] = function()
						if skill(SKILL_HAND).value >= 20000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_POPO then
		class_qty = 5
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_POPO] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "c",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_OFFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_POPO] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "o",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_DEFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_POPO] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_REGENERATION,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_POPO] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "r",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_POPO] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "u",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_POWER_DETECTION,
					["gain"] = 0,
					["skcost"] = 2,
					["cap"] = function()
						return 0
					end
					["key"] = "b",
					["reqtxt"] = "Requires Chi Gung of 20 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 20000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_KAMI then
		class_qty = 10
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_CURE,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
						return 0
					end
					["key"] = "u",
					["reqtxt"] = "Requires Chi Gung of 10 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 10000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_HEAL,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
						return 0
					end
					["key"] = "h",
					["reqtxt"] = "Requires Chi Gung of 20 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 20000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_FLIGHT,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
						return 0
					end
					["key"] = "f",
					["reqtxt"] = "Requires Battle Aura",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 10000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_LIGHT,
					["gain"] = 0,
					["skcost"] = 2,
					["cap"] = function()
						return 0
					end
					["key"] = "l",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_MEDITATION,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "m",
					["reqtxt"] = "",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_KAMI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "c",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[7] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_OFFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_KAMI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "o",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[8] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_DEFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_KAMI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[9] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_REGENERATION,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_KAMI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "r",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[10] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_KAMI] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}	
	elseif which == FLAG_ENROLL_NORTH_KAIO then
		class_qty = 10
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_NORTH_KAIO] * 5
					end
					["key"] = "c",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_OFFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_NORTH_KAIO] * 5
					end
					["key"] = "o",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_DEFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_NORTH_KAIO] * 5
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_REGENERATION,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_NORTH_KAIO] * 5
					end
					["key"] = "r",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_NORTH_KAIO] * 5
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}	
		school_data[6] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_TELEPATHY,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
						return 0
					end
					["key"] = "t",
					["reqtxt"] = "Requires Chi Gung of 20 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 20000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[7] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_SPIRIT_BOMB,
					["gain"] = 0,
					["skcost"] = 1,
					["cap"] = function()
						return 0
					end
					["key"] = "s",
					["reqtxt"] = "Requires Chi Gung of 50 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 50000 and trainer[FLAG_ENROLL_NORTH_KAIO] > 3 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return (trainer[FLAG_ENROLL_NORTH_KAIO] > 0) end
				}	
		school_data[8] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_FUSION,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
						return 0
					end
					["key"] = "s",
					["reqtxt"] = "Requires Chi Gung of 50 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 50000 and trainer[FLAG_ENROLL_NORTH_KAIO] > 3 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return (trainer[FLAG_ENROLL_NORTH_KAIO] > 1) end
				}	
		school_data[9] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_TELEPORTATION,
					["gain"] = 0,
					["skcost"] = 5,
					["cap"] = function()
						return 0
					end
					["key"] = "p",
					["reqtxt"] = "Requires Chi Gung of 30 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 30000 and trainer[FLAG_ENROLL_NORTH_KAIO] > 1 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return (trainer[FLAG_ENROLL_NORTH_KAIO] > 2) end
				}
		school_data[10] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_PLANETARY_TELEPORT,
					["gain"] = 0,
					["skcost"] = 1,
					["cap"] = function()
						return 0
					end
					["key"] = "p",
					["reqtxt"] = "Requires Chi Gung of 40 ",
					["reqfct"] = function()
						if skill(SKILL_CHI_GUNG).value >= 40000 and trainer[FLAG_ENROLL_NORTH_KAIO] > 2 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return (trainer[FLAG_ENROLL_NORTH_KAIO] > 2) end
				}
	elseif which == FLAG_ENROLL_TRUNKS then
		class_qty = 5
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_WEAPONS,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
								return 50
					end
					["key"] = "w",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_PARRYING,
					["gain"] = 1500,
					["skcost"] = 1,
					["cap"] = function()
							return 30
					end
					["key"] = "r",
					["reqtxt"] = "Requires 20 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 30000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_PAIRED_WEAPONS,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "p",
					["reqtxt"] = "Requires 30 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 30000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_RIPOSTE,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "t",
					["reqtxt"] = "Requires 30 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 30000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_IAIJUTSU,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "i",
					["reqtxt"] = "Requires 30 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 30000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[6] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_TRUNKS] * 5
					end
					["key"] = "c",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[7] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_OFFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_TRUNKS] * 5
					end
					["key"] = "o",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[8] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_DEFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_TRUNKS] * 5
					end
					["key"] = "d",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[9] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_REGENERATION,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_TRUNKS] * 5
					end
					["key"] = "n",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[10] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return trainer[FLAG_ENROLL_TRUNKS] * 5
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}	
	elseif which == FLAG_MARKSMANSHIP then
		class_qty = 1
		zeni_cost = 100
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_MARKSMANSHIP,
					["gain"] = 1000,
					["skcost"] = 2,
					["cap"] = function()
							if trainer[FLAG_MARKSMANSHIP] == 0 then
								return 20
							else
								return 100
							end
					end
					["key"] = "m",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_SPLINTER then
		class_qty = 5
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_STEALTH,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
								return 100
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_SNEAK,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_PAIRED_WEAPONS,
					["gain"] = 0,
					["skcost"] = 20,
					["cap"] = function()
							return 0
					end
					["key"] = "i",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_SPLINTER] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "i",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							if trainer[FLAG_ENROLL_SPLINTER] == 0 then
								return 5
							else
								return 10
							end
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}	
	elseif which == FLAG_ENROLL_SHREDDER then
		class_qty = 6
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_STEALTH,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
								return 100
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_SNEAK,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "s",
					["reqtxt"] = " ",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_ABILITY,
					["skill"] = AB_RIPOSTE,
					["gain"] = 0,
					["skcost"] = 10,
					["cap"] = function()
							return 0
					end
					["key"] = "r",
					["reqtxt"] = "Requires 40 Weapons",
					["reqfct"] = function()
						if skill(SKILL_WEAPONS).value >= 40000 then
							return true
						else
							return false
						end
					end
					["visible"] = function() return true end
				}
		school_data[4] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return 5
					end
					["key"] = "i",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[5] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_OFFENSE,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return 10
					end
					["key"] = "o",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}	
		school_data[6] =
				{
					["type"] = FLAG_SS_SPECIAL,
					["skill"] = SKILL_CHI_GUNG,
					["gain"] = 1000,
					["skcost"] = 1,
					["cap"] = function()
							return 5
					end
					["key"] = "g",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}	
	elseif which == FLAG_ENROLL_BRIEFS_SOME then
		class_qty = 1
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_TECHNOLOGY,
					["gain"] = 1000,
					["skcost"] = 3,
					["cap"] = function()
						local foo = player.stat(A_INT)
							if foo > 20 then
							return 20
						else
							return foo
						end
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
	elseif which == FLAG_ENROLL_BRIEFS_ALL then
		class_qty = 3
		zeni_cost = 0
		school_data[1] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_TECHNOLOGY,
					["gain"] = 2000,
					["skcost"] = 1,
					["cap"] = function()
							return 100
					end
					["key"] = "t",
					["reqtxt"] = " ",
					["reqfct"] = function()
						return true
					end
					["visible"] = function() return true end
				}
		school_data[2] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_CONSTRUCTION,
					["gain"] = 2000,
					["skcost"] = 1,
					["cap"] = function()
							return 100
					end
					["key"] = "c",
					["reqtxt"] = "Technomancers only",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
		school_data[3] =
				{
					["type"] = FLAG_SS_SKILL,
					["skill"] = SKILL_DISASSEMBLY,
					["gain"] = 2000,
					["skcost"] = 1,
					["cap"] = function()
							return 100
					end
					["key"] = "d",
					["reqtxt"] = "Technomancers only",
					["reqfct"] = function()
							return true
					end
					["visible"] = function() return true end
				}
	else
		message("Error! Unknown school!")
	end

	return school_data, class_qty, zeni_cost
end
