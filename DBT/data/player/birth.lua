--
-- Birth sequence
--

-- Point based stats generation
birth.gen_stats_point = function()
	local poyntz = 0

	-- hook.process(hook.CHARACTER_GENERATED)

	local cur =
	{
		sel = 0
		points = {}
		stat_base = {}
	}
	-- Redefine the display_stat function of the engine to display the selected stat
	local old_display = character_sheet.display_stat
	character_sheet.display_stat = function(stat)
		local stat_color = "#G"
	        local text = format("%2d", player.stat_ind[stat] + (%cur.points[stat] or 0))
	        --local text = format("%2d", player.stat_ind[stat] + (%cur.points[stat] or 0)).." (Cost "..format("%2d", %stat_costs[%cur.points[stat] or 0])..")"
		
		if %cur.sel == stat then
			return format(":#y>%19s", text)
		else
			return format(":#G%20s", text)
		end

		--if %cur.sel == stat then
		--	stat_color = "#B"
		--end
		--return format(":%s%20s", stat_color, text)
	end
	
	-- Save the base stats after backing out race/class adjustments.
	for i = 0, stats.MAX do
		cur.stat_base[i] = player.stat_ind[i] - player.stat_add[i]
	end

	while not nil do
		character_sheet.display(1)
		term.blank_print("Arrow Keys to arrange points, ENTER when done: "..poyntz..")", 0, 0)

		local key = strchar(term.inkey())

		if key == '8' and cur.sel > 0 then
			cur.sel = cur.sel - 1
		elseif key == '2' and cur.sel < stats.MAX then
			cur.sel = cur.sel + 1
		elseif key == '6' or key == '+' then

			if poyntz > 0 and player.stat_max[cur.sel] < 14 then
				poyntz = poyntz - 1
				player.stat_ind[cur.sel] = player.stat_ind[cur.sel] + 1
				player.stat_cur[cur.sel] = player.stat_cur[cur.sel] + 1
				player.stat_max[cur.sel] = player.stat_max[cur.sel] + 1
				player.update = player.update | PU_BONUS | PU_HP | PU_MANA | PU_SANITY
				update_stuff()
			end

		elseif key == '4' or key == '-' then
			if player.stat_max[cur.sel] > 6 then 
				poyntz = poyntz + 1
				player.stat_ind[cur.sel] = player.stat_ind[cur.sel] - 1
				player.stat_cur[cur.sel] = player.stat_cur[cur.sel] - 1
				player.stat_max[cur.sel] = player.stat_max[cur.sel] - 1
				player.update = player.update | PU_BONUS | PU_HP | PU_MANA | PU_SANITY
				update_stuff()
			end
		elseif key == "\r" or key == ESCAPE then
            for i = 0, stats.MAX do player.stat_cur[i] = player.stat_max[i] end
		player.update = player.update | PU_BONUS | PU_HP | PU_MANA | PU_SANITY
            update_stuff()
			break
		end
	end

	-- Set the normal displayt stat function back
	character_sheet.display_stat = old_display
end


-- Setup random names table
birth.set_random_names
{
	DEFAULT = "Human"
	Human =
	{
		[1] =
		{
			"Ab", "Ac", "Ad", "Af", "Agr", "Ast", "As", "Al", "Adw", "Adr", "Ar",
			"B", "Br", "C", "Cr", "Ch", "Cad", "D", "Dr", "Dw", "Ed", "Eth", "Et",
			"Er", "El", "Eow", "F", "Fr", "G", "Gr", "Gw", "Gal", "Gl", "H", "Ha",
			"Ib", "Jer", "K", "Ka", "Ked", "L", "Loth", "Lar", "Leg", "M", "Mir",
			"N", "Nyd", "Ol", "Oc", "On", "P", "Pr", "R", "Rh", "S", "Sev", "T",
			"Tr", "Th", "V", "Y", "Z", "W", "Wic",
		},
		[2] =
		{
			"a", "ae", "au", "ao", "are", "ale", "ali", "ay", "ardo", "e", "ei",
			"ea", "eri", "era", "ela", "eli", "enda", "erra", "i", "ia", "ie",
			"ire", "ira", "ila", "ili", "ira", "igo", "o", "oa", "oi", "oe",
			"ore", "u", "y",
		},
		[3] =
		{
			"a", "and", "b", "bwyn", "baen", "bard", "c", "ctred", "cred", "ch",
			"can", "d", "dan", "don", "der", "dric", "dfrid", "dus", "f", "g",
			"gord", "gan", "l", "li", "lgrin", "lin", "lith", "lath", "loth",
			"ld", "ldric", "ldan", "m", "mas", "mos", "mar", "mond", "n",
			"nydd", "nidd", "nnon", "nwan", "nyth", "nad", "nn", "nnor", "nd",
			"p", "r", "ron", "rd", "s", "sh", "seth", "sean", "t", "th", "tha",
			"tlan", "trem", "tram", "v", "vudd", "w", "wan", "win", "wyn", "wyr",
			"wyr", "wyth",
		}
	}
}

birth.sequence
{
	{ descriptor_type = "base" },
	{
		title = "Select your sex"
		descriptor_type = "sex"
	},
--	{
--		title = "Choose your gameplay mode"
--		descriptor_type = "mode"
--	},
	{ custom = function()
		dball.data_clearing()
	end},
	{ action = "finalize" },
	{ action = "random_name" random_name_descriptor = "base" },
	{ custom = birth.gen_stats_point },
	{ action = "ask_name" },
}

