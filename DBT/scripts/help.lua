-------------------------------------------------------------------------------
-----------------------Here comes the definition of help-----------------------
-------------------------------------------------------------------------------

ingame_help
{
	["no_test"] =   true,
	["callback"] =  "select_context",
	["fct"] =       function(typ, name)
			-- list of files for classes, { filename, anchor }
			local t =
			{
				["race"] =
				{
					["Human"] = { "r_human.txt", 0 },
					["Seiyan"] = { "r_seiyan.txt", 0 },
					["Super Seiyan"] = { "r_sseiya.txt", 0 },
					["Android"] = { "r_androi.txt", 0 },
					["Bio-Android"] = { "r_bioand.txt", 0 },
				},
				["class"] =
				{
					["Wannabee"] = { "c_wannab.txt", 0 },
					["Martial Artist"] = { "c_martia.txt", 0 },
					["Technologist"] = { "c_techno.txt", 0 },
					["Chi Person (Name?)"] = { "c_chi.txt", 0 },
				},
				["skill"] =
				{
					["Strength"] = { "skills.txt", 00 },
					["Intelligence"] = { "skills.txt", 01 },
					["Willpower"] = { "skills.txt", 02 },
					["Dexterity"] = { "skills.txt", 03 },
					["Constitution"] = { "skills.txt", 04 },
					["Charisma"] = { "skills.txt", 05 },
					["Speed"] = { "skills.txt", 06 },
					["Martial-Arts"] = { "skills.txt", 07 },
					["Barehanded"] = { "skills.txt", 08 },
					["Weapons"] = { "skills.txt", 09 },
					["Parrying"] = { "skills.txt", 10 },
					["Paired"] = { "skills.txt", 11 },
					["Stealth"] = { "skills.txt", 12 },
					["Dodging"] = { "skills.txt", 13 },
					["Chi"] = { "skills.txt", 14 },
					["Chi-Offense"] = { "skills.txt", 15 },
					["Chi-Defense"] = { "skills.txt", 16 },
					["Chi-Regeneration"] = { "skills.txt", 17 },
					["Chi-Gung"] = { "skills.txt", 18 },
					["Technology"] = { "skills.txt", 19 },
					["Construction"] = { "skills.txt", 20 },
					["Disassembly"] = { "skills.txt", 21 },
				},
				["ability"] =
				{
				    ["Spread blows"] = { "ability.txt", 02 },
				},
			}

			if t[typ][name] then ingame_help_doc(t[typ][name][1], t[typ][name][2])
			else ingame_help_doc("help.hlp", 0)
			end
	end,
}

