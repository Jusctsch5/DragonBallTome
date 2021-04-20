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

		-- Converted Rates:
		local chi_rate = dball.show_me_a_dec(dball_data.chi_drain_rate, 100)

		if dball_data.chi_drain_rate == 0 then
			term.text_out("(1) Chi Drain rate: ")
			term.text_out(color.YELLOW, "none")
		elseif dball_data.chi_drain_rate > 0 then
			term.text_out("(2) Chi Regeneration rate: ")
			term.text_out(color.LIGHT_BLUE, chi_rate .. " / round")
		elseif dball_data.chi_drain_rate < 0 then
			term.text_out("(3) Chi Drain rate: ")
			term.text_out(color.LIGHT_RED, chi_rate .. " / round")
		end

		term.text_out("   (Pure Rate: " .. dball_data.chi_drain_rate .. ")")

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
				if dball_data.chi_light_setting < 20 then
					-- Engine limits light radius to 20
					dball_data.chi_light_setting = dball_data.chi_light_setting + 1
				end
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

	local cumulative_drain = 0

	cumulative_drain = cumulative_drain + dball.chi_get_drain(AB_LIGHT)
	cumulative_drain = cumulative_drain + dball.chi_get_drain(AB_HASTE)
	cumulative_drain = cumulative_drain + dball.chi_get_drain(AB_REGENERATION)
	cumulative_drain = cumulative_drain + dball.chi_get_drain(AB_ABSORBTION)
	if dball_data.chi_aura_setting == 1 then
		cumulative_drain = cumulative_drain + dball.chi_get_drain(AB_AURA)
	end
	if dball_data.chi_flight_setting == 1 then
		cumulative_drain = cumulative_drain + dball.chi_get_drain(AB_FLIGHT)
	end

	-- Misnomer: This is actually the 'standard' regen, whatever value that may turn out to be
	cumulative_drain = cumulative_drain + dball.chi_get_drain(AB_MEDITATION)

	-- Set it
	dball_data.chi_drain_rate = dball_data.chi_drain_rate - cumulative_drain

end

-- Eliminates duplication of drain rates here and in calc.lua
-- Note: negative drain = postitive regeneration, and vice versa
function dball.chi_get_drain(which)
	local drain_rate
	local cg_effect = true
	if which == AB_LIGHT then
		drain_rate = dball_data.chi_light_setting * 500
	elseif which == AB_HASTE then
		drain_rate = dball_data.chi_haste_setting * 1000
	elseif which == AB_REGENERATION then
		drain_rate = dball_data.chi_regeneration_setting * 1000
	elseif which == AB_ABSORBTION then
		drain_rate = dball_data.chi_absorbtion_setting * 500
	elseif which == AB_FLIGHT then
		drain_rate = 2500
	elseif which == AB_AURA then
		drain_rate = 2500
	elseif which == AB_MEDITATION then
		-- Regeneration Rate: 1 skill = 1 point every five turns
		local regen_rate = get_skill(SKILL_CHI_REGENERATION) * 20
		if has_ability(AB_MEDITATION) then
			regen_rate = regen_rate + regen_rate
		end

		-- Even with no skill we still regenerate a little bit...
		if regen_rate < 5 then
			regen_rate = 5
		end

		drain_rate = regen_rate * -1
		cg_effect = false

	else
		error("Error: Unknown chi ability requested from dball.chi_drain_rate()")
		return 0
	end

	-- Standard regeneration unaffected by Chi Gung
	if cg_effect == true then
		if get_skill(SKILL_CHI_GUNG) > 1 then
			drain_rate = drain_rate / get_skill(SKILL_CHI_GUNG)
		end
	end

	return drain_rate
end
