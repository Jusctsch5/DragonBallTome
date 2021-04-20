-- Dragonball T: Chi System, Constant Effects

-- Yes, this code is ugly, even silly in a few places.
-- Deal with it.
--
-- By the way...WHY can LUA not deal with array indexes of zero?
--
-- See? I'm not the only one who does weird stuff.

-- Oh...also, how do we make the cursor invisible?

function dball.mchi()
	local available_effects = {}
	local ae_counter = 1

	if has_ability(AB_LIGHT) then
		available_effects[ae_counter] = "  Light Aura              : "
		ae_counter = ae_counter + 1
	end
	if has_ability(AB_AURA) then
		available_effects[ae_counter] = "  Battle Aura             : "
		ae_counter = ae_counter + 1
	end
	if has_ability(AB_HASTE) then
		available_effects[ae_counter] = "  Haste                   : "
		ae_counter = ae_counter + 1
	end
	if has_ability(AB_FLIGHT) then
		available_effects[ae_counter] = "  Flight                  : "
		ae_counter = ae_counter + 1
	end
	if has_ability(AB_REGENERATION) then
		available_effects[ae_counter] = "  Physical Regeneration   : "
		ae_counter = ae_counter + 1
	end
	if has_ability(AB_ABSORBTION) then
		available_effects[ae_counter] = "  Aural Damage Absorbtion : "
		ae_counter = ae_counter + 1
	end

	if ae_counter == 1 then
		message("You don't know any Chi constant effects.")
		return
	end

	local cursor_position = 3
	ae_counter = ae_counter - 1

	while not nil do

		dball.mchi_calculate_drain()

		term.save()
		term.text_out("Change which effects? (up/down to scroll, right/left to modify)\n")

--[[
		-- This is old, and no longer accurate as of V085
		term.text_out("Pure Regeneration rate: ")
		term.text_out(color.LIGHT_BLUE, dball_data.chi_drain_rate)
		--(1000=1mana per turn, 500=1mana every 2 turn, ...)
]]

--[[
		-- Converted Rates:
		local chi_dr = dball_data.chi_drain_rate / 100
		if dball_data.chi_drain_rate == 0 then
			term.text_out("(1) Chi Drain rate: ")
			term.text_out(color.YELLOW, "none")
		elseif chi_dr < -10 then
			term.text_out("(2) Chi Drain rate: ")
			term.text_out(color.LIGHT_RED, chi_dr / 10 .. " / round")
		elseif chi_dr < 0 then
			term.text_out("(3) Chi Drain rate: ")
			term.text_out(color.LIGHT_RED, "-1 / " .. -(chi_dr / 10) .. " round")
			if -(chi_dr / 10) ~= 1 then
				term.text_out("s")
			end
		elseif chi_dr > 10 then
			term.text_out("(4) Chi Regeneration rate: ")
			term.text_out(color.LIGHT_BLUE, chi_dr / 10 .. " / round")
		else 
			term.text_out("(5) Chi Regeneration rate: ")
			term.text_out(color.LIGHT_BLUE, "1 / " .. 1000 / dball_data.chi_drain_rate .. " rounds")
		end
]]

		term.text_out("   (Pure Drain Rate: " .. dball_data.chi_drain_rate .. ")")

		term.text_out("\n\n")

		------------------- Begin: This should be its own function for clarity ---------------
		for i = 1, ae_counter do
			-- term.text_out(available_effects[i] .. " " .. i)

			if available_effects[i] == "  Light Aura              : " then
				term.text_out("  Light Aura              : ")
				if dball_data.chi_light_setting == 0 then
					term.text_out(color.WHITE, "OFF")
				else
					term.text_out(color.LIGHT_BLUE, "+" .. dball_data.chi_light_setting .. " radius")
				end
			elseif available_effects[i] == "  Battle Aura             : " then
				term.text_out("  Battle Aura             : ")
				if dball_data.chi_aura_setting == 0 then
					term.text_out(color.WHITE, "OFF")
				else
					term.text_out(color.LIGHT_BLUE, "ON")
				end
			elseif available_effects[i] == "  Haste                   : " then
				term.text_out("  Haste                   : ")
				if dball_data.chi_haste_setting == 0 then
					term.text_out(color.WHITE, "OFF")
				else
					term.text_out(color.LIGHT_BLUE, "+" .. dball_data.chi_haste_setting .. " speed")
				end
			elseif available_effects[i] == "  Flight                  : " then
				term.text_out("  Flight                  : ")
				if dball_data.chi_flight_setting == 0 then
					term.text_out(color.WHITE, "OFF")
				else
					term.text_out(color.LIGHT_BLUE, "ON")
				end
			elseif available_effects[i] == "  Physical Regeneration   : " then
				term.text_out("  Physical Regeneration   : ")
				if dball_data.chi_regeneration_setting == 0 then
					term.text_out(color.WHITE, "OFF")
				else
					term.text_out(color.LIGHT_BLUE, "+" .. dball_data.chi_regeneration_setting .. " hp/round")
				end
			elseif available_effects[i] == "  Aural Damage Absorbtion : " then
				term.text_out("  Aural Damage Absorbtion : ")
				if dball_data.chi_absorbtion_setting == 0 then
					term.text_out(color.WHITE, "OFF")
				else
					term.text_out(color.LIGHT_BLUE, "+" .. dball_data.chi_haste_setting .. " damage absorbtion")
				end
			end

		term.text_out("\n")

		end
	------------------- End: This should be its own function for clarity ---------------
		-- term.print(color.LIGHT_RED, cursor_position, cursor_position, 0)
		-- term.print(color.LIGHT_RED, available_effects[cursor_position -2], cursor_position, 0)
		term.print(color.LIGHT_RED, ">", cursor_position, 0)

		local key = term.inkey()

		if key == "\r" or key == ESCAPE then
			break
		elseif strchar(key) == "8" then
			cursor_position = cursor_position - 1
			if cursor_position < 3 then
				cursor_position = ae_counter + 2
			end
		elseif strchar(key) == "2" then
			cursor_position = cursor_position + 1
			if cursor_position > ae_counter + 2 then
				cursor_position = 3
			end
		elseif strchar(key) == "6" or strchar(key) == "+" then
			if available_effects[cursor_position - 2] == "  Light Aura              : " then
				dball_data.chi_light_setting = dball_data.chi_light_setting + 1
			elseif available_effects[cursor_position - 2] == "  Battle Aura             : " then
				if dball_data.chi_aura_setting == 1 then
					dball_data.chi_aura_setting = 0
				else
					dball_data.chi_aura_setting = 1
				end
			elseif available_effects[cursor_position - 2] == "  Haste                   : " then
					dball_data.chi_haste_setting = dball_data.chi_haste_setting + 1
			elseif available_effects[cursor_position - 2] == "  Flight                  : " then
				if dball_data.chi_flight_setting == 1 then
					dball_data.chi_flight_setting = 0
				else
					dball_data.chi_flight_setting = 1
				end
			elseif available_effects[cursor_position - 2] == "  Physical Regeneration   : " then
					dball_data.chi_regeneration_setting = dball_data.chi_regeneration_setting + 1
			elseif available_effects[cursor_position - 2] == "  Aural Damage Absorbtion : " then
					dball_data.chi_absorbtion_setting = dball_data.chi_absorbtion_setting + 1
			else
				error("Invalid Chi Constant Effect entry")
			end
		elseif strchar(key) == "4" or strchar(key) == "-" then
			if available_effects[cursor_position - 2] == "  Light Aura              : " then
				if dball_data.chi_light_setting > 0 then
					dball_data.chi_light_setting = dball_data.chi_light_setting - 1
				end
			elseif available_effects[cursor_position - 2] == "  Battle Aura             : " then
				if dball_data.chi_aura_setting == 1 then
					dball_data.chi_aura_setting = 0
				else
					dball_data.chi_aura_setting = 1
				end
			elseif available_effects[cursor_position - 2] == "  Haste                   : " then
				if dball_data.chi_haste_setting > 0 then
					dball_data.chi_haste_setting = dball_data.chi_haste_setting - 1
				end
			elseif available_effects[cursor_position - 2] == "  Flight                  : " then
				if dball_data.chi_flight_setting == 1 then
					dball_data.chi_flight_setting = 0
				else
					dball_data.chi_flight_setting = 1
				end
			elseif available_effects[cursor_position - 2] == "  Physical Regeneration   : " then
				if dball_data.chi_regeneration_setting > 0 then
					dball_data.chi_regeneration_setting = dball_data.chi_regeneration_setting - 1
				end
			elseif available_effects[cursor_position - 2] == "  Aural Damage Absorbtion : " then
				if dball_data.chi_absorbtion_setting > 0 then
					dball_data.chi_absorbtion_setting = dball_data.chi_absorbtion_setting - 1
				end
			else
				error("Invalid Chi Constant Effect entry")
			end
		end

		player.calc_bonuses()

		term.load()
	end
	term.load()
end

-- Called by calc
function dball.mchi_calculate_drain()
	-- Do Flight and/or Absorbtion require Battle Aura to function?
	if dball_data.chi_aura_setting == 0 then
--		dball_data.chi_flight_setting = 0
		dball_data.chi_absorbtion_setting = 0
	end

	-- No negative settings
	if dball_data.chi_haste_setting < 0 then
		dball_data.chi_haste_setting = 0
	end
	if dball_data.chi_regeneration_setting < 0 then
		dball_data.chi_regeneration_setting = 0
	end
	if dball_data.chi_absorbtion_setting < 0 then
		dball_data.chi_absorbtion_setting = 0
	end

	-- Zero it out
	dball_data.chi_drain_rate = 0

	local ndbyz
	if get_skill(SKILL_CHI_GUNG) < 1 then 
		ndbyz = 10000
	else
		ndbyz = 10000 / get_skill(SKILL_CHI_GUNG)
	end

	-- Light Aura
	if dball_data.chi_light_setting > 0 then
		dball_data.chi_drain_rate = dball_data.chi_drain_rate - (dball_data.chi_light_setting * (ndbyz / 20))
	end

	-- Battle Aura
	if dball_data.chi_aura_setting == 1 then
		dball_data.chi_drain_rate = dball_data.chi_drain_rate - (ndbyz / 2)
	end

	-- Haste
	if dball_data.chi_haste_setting > 0 then
		dball_data.chi_drain_rate = dball_data.chi_drain_rate - (dball_data.chi_haste_setting * (ndbyz / 10))
	end

	-- Flight
	if dball_data.chi_flight_setting == 1 then
		dball_data.chi_drain_rate = dball_data.chi_drain_rate - (ndbyz / 2)
	end

	-- Regeneration
	if dball_data.chi_regeneration_setting > 0 then
		dball_data.chi_drain_rate = dball_data.chi_drain_rate - (dball_data.chi_regeneration_setting * (ndbyz / 5))
	end

	-- Absorbtion
	if dball_data.chi_absorbtion_setting > 0 then
		dball_data.chi_drain_rate = dball_data.chi_drain_rate - (dball_data.chi_absorbtion_setting * ndbyz / 10)
	end

	-- Regeneration Rate
	local regen_rate = get_skill(SKILL_CHI_REGENERATION) * 20
	if has_ability(AB_MEDITATION) then
		regen_rate = regen_rate + regen_rate
	end
	if regen_rate < 20 then
		regen_rate = 20
	end
	dball_data.chi_drain_rate = dball_data.chi_drain_rate + regen_rate

	if has_ability(AB_MEDITATION) then
		dball_data.chi_drain_rate = dball_data.chi_drain_rate + (get_skill(SKILL_CHI_REGENERATION) * 10)
	end

end