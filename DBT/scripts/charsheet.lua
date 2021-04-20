-- Dragonball T Charsheet
-- Not convenient to use the default charater sheet functions
-- Actually, I think the default sytem *could* do what I want
-- but as usual, I'm pulling its guts out and making my own.
-- *shrug*

constant("dbtcs", {})

function dbtcs.charsheet()
	term.save()

	dbtcs.general()
	local current_page = 0
	local cur_sel = 1
	local key

	while not nil do

		key = strchar(term.inkey())
		if key == strchar(ESCAPE) then
			break
		elseif key == 'g' and current_page ~= 0 then
			dbtcs.general()
			current_page = 0
		elseif key == 'a' and current_page ~= 1 then
			dbtcs.ability()
			current_page = 1
		elseif key == 'r' and current_page ~= 2 then
			dbtcs.resist()
			current_page = 2
		elseif key == 'm' and current_page ~= 3 then
			dbtcs.memberships()
			current_page = 3
		end


	end
	term.load()
end

-- Footer
function dbtcs.footer()
	term.color_text(color.WHITE, "<g> General <a> Abilities <r> Resistances <m> Memberships", 20, 1)
end

-- General Information
function dbtcs.general()
	term.clear()
	term.color_text(color.WHITE, "Dragonball T: Character Sheet", 0, 25)
	term.color_text(color.WHITE, "Name   :", 2, 0)
	term.color_text(color.WHITE, "Sex    :", 3, 0)
	term.color_text(color.WHITE, "Race   :", 4, 0)
	term.color_text(color.WHITE, "Class  :", 5, 0)
	term.color_text(color.LIGHT_BLUE, player_name(), 2, 9)
	term.color_text(color.LIGHT_BLUE, player.get_sex(), 3, 9)
	term.color_text(color.LIGHT_BLUE, dball_data.p_race, 4, 9)
	term.color_text(color.LIGHT_BLUE, dball_data.p_class, 5, 9)

	term.color_text(color.WHITE, "Level", 2, 27)
	term.color_text(color.WHITE, "Exp", 3, 27)
	term.color_text(color.WHITE, "Exp to Adv", 4, 27)
	term.color_text(color.LIGHT_BLUE, format("%" .. strlen(player.lev) .. "s", player.lev), 2,40)
	term.color_text(color.LIGHT_BLUE, format("%" .. strlen(player.exp) .. "s", player.exp), 3,40)
	term.color_text(color.LIGHT_BLUE, format("%" .. strlen((player_exp[player.lev] * player.expfact) / 100) .. "s", (player_exp[player.lev] * player.expfact) / 100), 4,40)

	dbtcs.footer()

end

function dbtcs.ability()
	term.clear()
	term.color_text(color.WHITE, "Dragonball T: Abilities", 0, 25)
	dbtcs.footer()
end

function dbtcs.resist()
	term.clear()
	term.color_text(color.WHITE, "Dragonball T: Resistances", 0, 25)
	dbtcs.footer()
end

function dbtcs.memberships()
	term.clear()
	term.color_text(color.WHITE, "Dragonball T: Memberships", 0, 25)

	local sx = 2

	if quest(QUEST_PILOTMEMBER).status == QUEST_STATUS_TAKEN then
		term.color_text(color.YELLOW, "You are a member of the Pilot's Club", sx, 0)
			if dball_data.hanger_rental > 0 then
				term.color_text(color.WHITE, "Your membership and hanger rental is valid for " .. dball_data.hanger_rental .. " more days", sx + 1, 3)
			else
				term.color_text(color.WHITE, "Your membership has expired", sx + 1, 3)
			end
		sx = sx + 3
	end

	if dball_data.member_library == 1 then
		term.color_text(color.LIGHT_BLUE, "You are a member of the library", sx, 0)
		if dball_data.study <= ((player.lev + 1) / 10) then
			term.color_text(color.WHITE, "It's been a while since you've done any reading", sx + 1, 3)
		else
			term.color_text(color.WHITE, "Your mind is abuzz with all you've learned", sx + 1, 3)
		end
		sx = sx + 3
	end

	if dball_data.member_gym == 1 then
		term.color_text(color.LIGHT_GREEN, "You are a 24/7 gym member", sx, 0)
		if dball_data.workout <= ((player.lev + 1) / 10) then
			term.color_text(color.WHITE, "You feel like you're due for a workout", sx + 1, 3)
		else
			term.color_text(color.WHITE, "You're feeling good from your last workout", sx + 1, 3)
		end
		sx = sx + 3
	end

	if dball_data.tourny_registered == 1 then
		term.color_text(color.ORANGE, "You are a registered fighter in the World Tournament", sx, 0)
			if dball_data.tourny_round == 0 then
				term.color_text(color.WHITE, "You haven't passed the qualification round yet", sx + 1, 3)
			elseif dball_data.tourny_round == 1 then
				term.color_text(color.WHITE, "You have passed the preliminary round", sx + 1, 3)
			elseif dball_data.tourny_round < 6 then
				term.color_text(color.WHITE, "You are in round " .. dball_data.tourny_round .. " of the first set of eliminations", sx + 1, 3)
			elseif dball_data.tourny_round < 12 then
				term.color_text(color.WHITE, "You are in round " .. dball_data.tourny_round .. " of the second set of eliminations", sx + 1, 3)
			else
				term.color_text(color.WHITE, "You are in round " .. dball_data.tourny_round .. " of the final set of eliminations", sx + 1, 3)
			end
		sx = sx + 3

	if sx == 2 then
		term.color_text(color.LIGHT_GREEN, "You are not a member or subscriber to any services or organizations", sx, 0)
	end

	dbtcs.footer()
	end
end
