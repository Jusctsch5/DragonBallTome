-- Character sheet display

set_character_sheet
{
	name = "Character Sheet"
	page = 1
	display =
	{
		-- basic char info
		[{ 2, 0, "s", 1 }] = { title="Name  :", data="player_name()" color=color.LIGHT_BLUE }
		[{ 3, 0, "s", 1 }] = { title="Sex   :", data="dball_data.p_sex" color=color.LIGHT_BLUE }

-- Do we want this?
--[[
		[{ 4, 0, "s", 1 }] = {
					title="Race  :"
					data=function()
						if player.body_monster == 0 then
							return dball_data.p_race
						else
							-- Umm, what? I don't understand this, but
							-- copied from ToME, alpha17
							return monster_desc(player.body_monster, 512 | 256 | 128)
						end
					end
					color=color.LIGHT_BLUE
				     }
]]

  		[{ 5, 0, "s", 1 }] = { title="Class :", data="dball_data.p_class" color=color.LIGHT_BLUE }

		-- Midscreen info
		[{ 2, 27, "d", -26 }] = { title="Level", data="player.lev" color=color.LIGHT_GREEN }
		[{ 3, 27, "d", -26 }] = { title="Total Exp", data="player.exp" color=color.LIGHT_GREEN }
		[{ 4, 27, "s", -26 }] = { title="Exp to Adv", data=function() if player.lev < 100 then return (player_exp[player.lev] * player.expfact) / 100 else return "****" end end color=color.LIGHT_GREEN }
		[{ 5, 27, "s", -26 }] = { title="Exp modifier", data=function()
									if dball_data.p_xpmod > 0 then
										return "+" .. dball_data.p_xpmod .. " pct"
									elseif dball_data.p_xpmod < 0 then
										return dball_data.p_xpmod .. " pct"
									else
										return "none"
									end
								end
								color=color.LIGHT_GREEN }
--		[{ 6, 27, "d", -26 }] = { title="Exp to Spend", data="dball_data.xp" color=color.LIGHT_BLUE }

		[{ 9, 27, "d", -26 }] = { title="Stealth", data="player.skill_stl" color=color.LIGHT_BLUE }

		-- stats
		[{ 2, 55, "s", 0 }] = { title="STR", data="character_sheet.display_stat(A_STR)" color=color.WHITE }
		[{ 3, 55, "s", 0 }] = { title="INT", data="character_sheet.display_stat(A_INT)" color=color.WHITE }
		[{ 4, 55, "s", 0 }] = { title="WIL", data="character_sheet.display_stat(A_WIL)" color=color.WHITE }
		[{ 5, 55, "s", 0 }] = { title="DEX", data="character_sheet.display_stat(A_DEX)" color=color.WHITE }
		[{ 6, 55, "s", 0 }] = { title="CON", data="character_sheet.display_stat(A_CON)" color=color.WHITE }
		[{ 7, 55, "s", 0 }] = { title="CHR", data="character_sheet.display_stat(A_CHR)" color=color.WHITE }
		[{ 8, 55, "s", 0 }] = { title="SPD", data="character_sheet.display_stat(A_SPD)" color=color.WHITE }

		-- counters
		[{ 10,55, "d", -24 }] = { title="Zeni", data="player.au" color=color.LIGHT_GREEN }
		[{ 11,55, "s", -24 }] = { title="General Speed", data="player.speed()" color=color.LIGHT_GREEN }
		[{ 12,55, "s", -24 }] = { title="Hit Points", data=function()
											if dball_data.alive == 0 then
												return player.chp() .. '/' .. player.mhp()
											else
												return "Dead!"
											end
										end color=color.LIGHT_GREEN }
		-- [{ 13,55, "s", -24 }] = { title="Chi", data="(dball_data.cur_chi_pool / 100) .. '/' .. (dball_data.max_chi_pool / 100)" color=color.LIGHT_GREEN }
		-- [{ 13,55, "s", -24 }] = { title="Chi", data="            player.csp() / 1000 .. '/' ..             player.msp() / 1000" color=color.LIGHT_GREEN }
		-- [{ 14,55, "s", -24 }] = { title="Sanity", data="dball_data.cur_sanity..'/'..dball_data.max_sanity" color=color.LIGHT_GREEN }

		-- Should be cleaned in calc, but this is so much easier
		[{ 9, 0, "s", -26 }] = { title="ArmorClass:", data="player.dis_ac + player.dis_to_a" color=color.LIGHT_GREEN }

-- Old Style Combat Display:
		[{ 10, 0, "s", -26 }] = { title=" Left hand:",
						data=function()
							if dball_data.lhand_valid == -1 then return "Non-Weapon" end
							if dball_data.lhand_valid == 0 then return "Barehand" end
							if dball_data.lhand_valid == 1 then return "Weapon" end
							if dball_data.lhand_valid == 2 then return "Firearm" end
						end color=color.LIGHT_GREEN
					}
		[{ 13, 0, "s", -26 }] = { title="Right hand:", data=function()
						if dball_data.rhand_valid == -1 then return "Non-Weapon" end
						if dball_data.rhand_valid == 0 then return "Barehand" end
						if dball_data.rhand_valid == 1 then return "Weapon" end
						if dball_data.rhand_valid == 2 then return "Firearm" end
					end color=color.LIGHT_GREEN
		}
--[[
		[{ 10, 0, "s", -26 }] = { title="",
						data=function()
							if dball_data.rhand_valid == 0 then
								if dball_data.lhand_valid == -1 then return "###wFighting :     ###GNo melee!" end
								if dball_data.lhand_valid == 0 then return "###wFighting :     ###GBarehand" end
								if dball_data.lhand_valid == 1 then return "###wFighting :       ###GWeapon" end
								if dball_data.lhand_valid == 2 then return "###wFighting :      ###GFirearm" end
							else
								if dball_data.lhand_valid == -1 then return "###wLeft hand :  ###GNon-Weapon" end
								if dball_data.lhand_valid == 0 then return "###wLeft hand :    ###GBarehand" end
								if dball_data.lhand_valid == 1 then return "###wLeft hand :      ###GWeapon" end
								if dball_data.lhand_valid == 2 then return "###wLeft hand :     ###GFirearm" end
							end
						end color=color.LIGHT_GREEN
					}
]]

		[{ 11, 0, "s", -26 }] = { title="    To-Hit:", data=function()
						if dball_data.lhand_valid ~= -1 then return dball_data.lhand_dis_th end
						return "nil"
					end color=color.LIGHT_GREEN
		}
		[{ 12, 0, "s", -26 }] = { title="    Damage:", data=function()
						if dball_data.lhand_valid == -1 then return "nil"
						elseif dball_data.lhand_valid == 0 then
							if get_skill(SKILL_HAND) > 0 then
								return "1d".. get_skill(SKILL_HAND) .."+".. dball_data.lhand_dis_td
							else
								return dball_data.lhand_dis_td
							end
						elseif dball_data.lhand_valid == 1 then
							--Note: Copied from somwhere in the engine
							--Works, but is always dangerous using stuff I don't understand
							--Seems ok, though
							local obj = player.inventory[INVEN_WIELD][1]
							local dams = obj.flags[FLAG_DAM]
							local min, max = 0, 0

							for i = 1, dams.size do
								if (dams.node[i].flags & FLAG_FLAG_USED) ~= 0 then
									local dam_type = dams.node[i].key
									min, max = min + flag_get(dams, dam_type), max + flag_get2(dams, dam_type)
								end
							end
							return min .."to"..max .."+".. dball_data.lhand_dis_td
								
						elseif dball_data.lhand_valid == 2 then return "not implmntd"
						else return "Error?"
						end
					end color=color.LIGHT_GREEN
		}

--[[
		[{ 13, 0, "s", -26 }] = { title="",
						data=function()
							if dball_data.lhand_valid == 0 then
								-- if dball_data.rhand_valid == -1 then return "" end
								if dball_data.rhand_valid == 0 then return "###wFighting :     ###GBarehand" end
								if dball_data.rhand_valid == 1 then return "###wFighting :       ###GWeapon" end
								if dball_data.rhand_valid == 2 then return "###wFighting :      ###GFirearm" end
							else
								-- if dball_data.rhand_valid == -1 then return "" end
								if dball_data.rhand_valid == 0 then return "###wRight hand:     ###GBarehand" end
								if dball_data.rhand_valid == 1 then return "###wRight hand:       ###GWeapon" end
								if dball_data.rhand_valid == 2 then return "###wRight hand:      ###GFirearm" end
							end
						end color=color.LIGHT_GREEN
					}
]]

		[{ 14, 0, "s", -26 }] = { title="    To-Hit:", data=function()
						if dball_data.rhand_valid ~= -1 then return dball_data.rhand_dis_th end
						return "nil"
					end color=color.LIGHT_GREEN
		}
		[{ 15, 0, "s", -26 }] = { title="    Damage:", data=function()
						if dball_data.rhand_valid == -1 then return "nil"
						elseif dball_data.rhand_valid == 0 then
							if get_skill(SKILL_HAND) > 0 then
								return "1d".. get_skill(SKILL_HAND) .."+".. dball_data.rhand_dis_td
							else
								return dball_data.rhand_dis_td
							end
						elseif dball_data.rhand_valid == 1 then
							local obj = player.inventory[INVEN_WIELD][2]
							local dams = obj.flags[FLAG_DAM]
							local min, max = 0, 0

							for i = 1, dams.size do
								if (dams.node[i].flags & FLAG_FLAG_USED) ~= 0 then
									local dam_type = dams.node[i].key
									min, max = min + flag_get(dams, dam_type), max + flag_get2(dams, dam_type)
								end
							end
							return min .."to"..max .."+".. dball_data.rhand_dis_td
								
						elseif dball_data.rhand_valid == 2 then return "not implmntd"
						else return "Error?"
						end
					end color=color.LIGHT_GREEN
		}

	}
	keys =
	{
		['c'] = {
			name = "change name"
			action = function()
				local new_name = input_box("New name?", 40, player_name())
				if new_name ~= "" then
					player_name(new_name)
				end
			end
		}
	}
}

function character_sheet.not_impl()
	local str  = ""
	local vals = {str = str}

	for_inventory(player, INVEN_WIELD, INVEN_TOTAL,
		function(obj, i, j, slot)
			%vals.str = %vals.str .. "?"
		end)

	return vals.str
end

function character_sheet.display_equip_char()
	local str = " "
	local vals = {str = str}

	for_inventory(player, INVEN_WIELD, INVEN_TOTAL,
		function(obj, pos, slot, item)
			local c = strchar(pos + strbyte('a') - 1)
			%vals.str = %vals.str .. c .. "  "
		end)

	return vals.str
end

function character_sheet.display_equip_symb()
	local str = " "
	local vals = {str = str}

	for_inventory(player, INVEN_WIELD, INVEN_TOTAL,
		function(obj, pos, slot, item)
			local kind = k_info[obj.k_idx + 1]
			local symb = "#" .. strchar(conv_color[kind.x_attr + 1]) ..
				strchar(kind.x_char)

			%vals.str = %vals.str .. symb .. "  "
		end)

	return vals.str
end

function character_sheet.resist(dam_type)
	local str, out_color = "", color.WHITE

	-- Collect all known inventory resistances

	local vals = {str = str}
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL,
		function(obj, pos, slot, item)
			local val = 0

			if known_flag(obj, FLAG_RESIST) then
				local resists = obj.flags[FLAG_RESIST]
				
				if flag_is_known(resists, %dam_type) then
					val = resists[%dam_type]
				end
			end

			-- All we care about here is spacing
			if val == 0 then
				%vals.str = %vals.str .. "   "
			elseif val < 10 then
				%vals.str = %vals.str .. "#G" .. val .. "  "
			elseif val < 100 then
				%vals.str = %vals.str .. "#G" .. val .. " "
			elseif val >= 100 then
				-- Immune
				%vals.str = %vals.str .. "#G" .. val
			elseif val < -99 then
				-- Vulnerable
				%vals.str = %vals.str .. "#rv" .. val
			elseif val < -9 then
				-- Vulnerable
				%vals.str = %vals.str .. "#rv" .. val .. "  "
			else
				-- ?
			end
		end) -- for_inventory_inven()

	return vals.str, out_color
end

function character_sheet.value_flag(flag1, flag2, divisor)
	local str, out_color = "", color.WHITE

	divisor = divisor or 1

	local vals = {str = str}
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL,
		function(obj, i, j, slot)
			local val = 0

			if known_flag(obj, %flag1) then
				if not %flag2 then
					val = obj.flags[%flag1]
				else
					local flags = obj.flags[%flag1]

					if flag_is_known(flags, %flag2) then
						val = flags[%flag2]
					end
				end
			end

			local disp_val = div_round(val, %divisor)

			if val == 0 then
				-- Neutral
				%vals.str = %vals.str .. "#w"
			elseif val > 0 then
				-- Good
				%vals.str = %vals.str .. "#g"
			elseif val < 0 then
				-- Bad
				%vals.str = %vals.str .. "#r"
			end

			if disp_val == 0 then
				if val == 0 then
					%vals.str = %vals.str .. "."
				elseif val > 0 then
					%vals.str = %vals.str .. "+"
				else
					%vals.str = %vals.str .. "-"
				end
			elseif abs(disp_val) > 9 then
				%vals.str = %vals.str .. "*"
			else
				%vals.str = %vals.str .. abs(disp_val)
			end
		end) -- for_inventory_inven()

	return vals.str, out_color
end -- character_sheet.value_flag()

function character_sheet.bool_flag(flag1, flag2)
	local str, out_color = "", color.WHITE

	local vals = {str = str}
	for_inventory(player, INVEN_WIELD, INVEN_TOTAL,
		function(obj, i, j, slot)
			local val = nil

			if known_flag(obj, %flag1) then
				if not %flag2 then
					val = obj.flags[%flag1]
				else
					local flags = obj.flags[%flag1]

					if flag_is_known(flags, %flag2) then
						val = flags[%flag2]
					end
				end
			end

			if val then
				%vals.str = %vals.str .. "+"
			else
				%vals.str = %vals.str .. "."
			end
		end) -- for_inventory_inven()

	return vals.str, out_color
end -- character_sheet.bool_flag()

-- XXX
set_character_sheet
{
	name = "Resistances"
	page = 3
	display =
	{
		-- Resists
		[{ 1, 0, "s", 0 }] = { title="          ", data="character_sheet.display_equip_char()" color=color.LIGHT_BLUE }
		[{ 2, 0, "s", 0 }] = { title="          ", data="character_sheet.display_equip_symb()" color=color.LIGHT_WHITE }
		--[{ 1, 0, "s", 1 }] = { title=character_sheet.section_title("Resists", 26) }
		[{ 3, 0, "s", 1 }] = { title="Fire     :", data="character_sheet.resist(dam.FIRE)" color=color.WHITE }
		[{ 4, 0, "s", 1 }] = { title="Cold     :", data="character_sheet.resist(dam.COLD)" color=color.WHITE }
		[{ 5, 0, "s", 1 }] = { title="Elec     :", data="character_sheet.resist(dam.ELEC)" color=color.WHITE }

		[{ 8, 0, "s", 1 }] = { title="Barehand :", data="character_sheet.resist(dam.BHAND)" color=color.WHITE }
		[{ 9, 0, "s", 1 }] = { title="Crush    :", data="character_sheet.resist(dam.CRUSH)" color=color.WHITE }
		[{ 10, 0, "s", 1 }] = { title="Pierce   :", data="character_sheet.resist(dam.PIERCE)" color=color.WHITE }
		[{ 11, 0, "s", 1 }] = { title="Slash    :", data="character_sheet.resist(dam.SLASH)" color=color.WHITE }

		[{ 13, 0, "s", 1 }] = { title="Poison   :", data="character_sheet.resist(dam.POIS)" color=color.WHITE }
		[{ 14, 0, "s", 1 }] = { title="Lite     :", data="character_sheet.resist(dam.LITE)" color=color.WHITE }
		[{ 15,0, "s", 1 }] = { title="Sound    :", data="character_sheet.resist(dam.SOUND)" color=color.WHITE }
		[{ 16,0, "s", 1 }] = { title="Shards   :", data="character_sheet.resist(dam.SHARDS)" color=color.WHITE }
		[{ 17,0, "s", 1 }] = { title="Ballistic:", data="character_sheet.resist(dam.BALLISTIC)" color=color.WHITE }
		[{ 18,0, "s", 1 }] = { title="Radiation:", data="character_sheet.resist(dam.RADIATION)" color=color.WHITE }

		-- Should be Boolean:
		-- [{ 22,0, "s", 1 }] = { title="Conf     :", data="character_sheet.resist(dam.CONFUSION)" color=color.WHITE }
		-- 23 Blind
		-- [{ 24, 0, "s", 1 }] = { title="Fear     :", data="character_sheet.resist(dam.FEAR)" color=color.WHITE }

	}
}

--[[
set_character_sheet
{
	name = "Movement, Combat"
	page = 4
	display =
	{
		-- Movement
		[{ 1, 0, "s", 0 }] = { title="          ", data="character_sheet.display_equip_char()" color=color.LIGHT_BLUE }
		[{ 2, 0, "s", 0 }] = { title="          ", data="character_sheet.display_equip_symb()" color=color.LIGHT_BLUE }
		[{ 3, 0, "s", 1 }] = { title="Fly      :", data="character_sheet.value_flag(FLAG_FLY)" color=color.WHITE }
		[{ 4, 0, "s", 1 }] = { title="Climb    :", data="character_sheet.not_impl(nil, FLAG_CLIMB, nil)" color=color.WHITE }
		-- [{ 5, 0, "s", 1 }] = { title="Dig      :", data="character_sheet.value_flag(FLAG_TUNNEL)" color=color.WHITE }
		[{ 6, 0, "s", 1 }] = { title="Speed    :", data="character_sheet.not_impl(nil, FLAG_SPEED, nil)" color=color.WHITE }
		[{ 7, 0, "s", 1 }] = { title="Wraith   :", data="character_sheet.not_impl(nil, FLAG_WRAITH, nil)" color=color.WHITE }
		[{ 8, 0, "s", 1 }] = { title="Stealth  :", data="character_sheet.not_impl(nil, FLAG_STEALTH, nil)" color=color.WHITE }
		[{ 9, 0, "s", 1 }] = { title="Teleport :", data="character_sheet.not_impl(nil, FLAG_TELEPORT, nil)" color=color.WHITE }
		[{ 10, 0, "s", 1 }] = { title="Sl.Undead:", data="character_sheet.value_flag(FLAG_SLAY, SLAY_UNDEAD)" color=color.WHITE }
		[{ 11, 0, "s", 1 }] = { title="Sl.Demon :", data="character_sheet.value_flag(FLAG_SLAY, SLAY_DEMON)" color=color.WHITE }
		[{ 12, 0, "s", 1 }] = { title="Sl.Dragon:", data="character_sheet.value_flag(FLAG_SLAY, SLAY_DRAGON)" color=color.WHITE }
		[{ 13, 0, "s", 1 }] = { title="Sl.Orc   :", data="character_sheet.value_flag(FLAG_SLAY, SLAY_ORC)" color=color.WHITE }
		[{ 14, 0, "s", 1 }] = { title="Sl.Troll :", data="character_sheet.value_flag(FLAG_SLAY, SLAY_TROLL)" color=color.WHITE }
		[{ 15, 0, "s", 1 }] = { title="Sl.Giant :", data="character_sheet.value_flag(FLAG_SLAY, SLAY_GIANT)" color=color.WHITE }
		[{ 16, 0, "s", 1 }] = { title="Sl.Evil  :", data="character_sheet.value_flag(FLAG_SLAY, SLAY_EVIL)" color=color.WHITE }
		[{ 17, 0, "s", 1 }] = { title="Sl.Animal:", data="character_sheet.value_flag(FLAG_SLAY, SLAY_ANIMAL)" color=color.WHITE }

		-- Combat
		[{ 1, 40, "s", 0 }] = { title="          ", data="character_sheet.display_equip_char()" color=color.LIGHT_BLUE }
		[{ 2, 40, "s", 0 }] = { title="          ", data="character_sheet.display_equip_symb()" color=color.LIGHT_BLUE }
		[{ 3, 40, "s", 1 }] = { title="Spells   :", data="character_sheet.not_impl(nil, FLAG_SPELL, nil)" color=color.WHITE }
		[{ 4, 40, "s", 1 }] = { title="Blows    :", data="character_sheet.not_impl(nil, FLAG_BLOWS, nil)" color=color.WHITE }
		[{ 5, 40, "s", 1 }] = { title="Crits    :", data="character_sheet.not_impl(nil, FLAG_CRIT, nil)" color=color.WHITE }
		[{ 6, 40, "s", 1 }] = { title="Ammo Mult:", data="character_sheet.not_impl(nil, FLAG_XTRA_MIGHT, nil)" color=color.WHITE }
		[{ 7, 40, "s", 1 }] = { title="Ammo Shot:", data="character_sheet.not_impl(nil, FLAG_XTRA_SHOTS, nil)" color=color.WHITE }
		[{ 8, 40, "s", 1 }] = { title="Vorpal   :", data="character_sheet.not_impl(nil, FLAG_VORPAL, nil)" color=color.WHITE }
		[{ 9, 40, "s", 1 }] = { title="Quake    :", data="character_sheet.not_impl(nil, FLAG_IMPACT, nil)" color=color.WHITE }
		[{ 10, 40, "s", 1 }] = { title="Chaotic  :", data="character_sheet.not_impl(nil, FLAG_CHAOTIC, nil)" color=color.WHITE }
		[{ 11,40, "s", 1 }] = { title="Vampiric :", data="character_sheet.bool_flag(FLAG_VAMPIRIC)" color=color.WHITE }
		[{ 12,40, "s", 1 }] = { title="Poison   :", data="character_sheet.value_flag(FLAG_BRAND, dam.POIS)" color=color.WHITE }
		[{ 13,40, "s", 1 }] = { title="Burns    :", data="character_sheet.value_flag(FLAG_BRAND, dam.FIRE)" color=color.WHITE }
		[{ 14,40, "s", 1 }] = { title="Chills   :", data="character_sheet.value_flag(FLAG_BRAND, dam.COLD)" color=color.WHITE }
		[{ 16,40, "s", 1 }] = { title="Shocks   :", data="character_sheet.value_flag(FLAG_BRAND, dam.ELEC)" color=color.WHITE }
		[{ 17,40, "s", 1 }] = { title="Wound    :", data="character_sheet.not_impl(nil, FLAG_WOUNDING, nil)" color=color.WHITE }
		[{ 18,40, "s", 1 }] = { title="NeverBlow:", data="character_sheet.not_impl(nil, FLAG_NEVER_BLOW, nil)" color=color.WHITE }

	}
}

set_character_sheet
{
	name = "Sight and Miscellaneous"
	page = 5
	display =
	{
		-- Movement
		[{ 1, 0, "s", 0 }] = { title="           ", data="character_sheet.display_equip_char()" color=color.LIGHT_BLUE }
		[{ 2, 0, "s", 0 }] = { title="           ", data="character_sheet.display_equip_symb()" color=color.LIGHT_BLUE }

		[{ 3, 0, "s", 1 }] = { title="See Invis :", data="character_sheet.not_impl(nil, FLAG_SEE_INVIS, nil)" color=color.WHITE }
		[{ 4, 0, "s", 1 }] = { title="Invis     :", data="character_sheet.not_impl(nil, FLAG_INVIS, nil)" color=color.WHITE }
		[{ 5, 0, "s", 1 }] = { title="Infra     :", data="character_sheet.not_impl(nil, FLAG_INFRA, nil)" color=color.WHITE }
		-- [{ 6, 0, "s", 1 }] = { title="Search    :", data="character_sheet.not_impl(nil, FLAG_SEARCH, nil)" color=color.WHITE }
		-- [{ 7, 0, "s", 1 }] = { title="Auto ID   :", data="character_sheet.not_impl(nil, FLAG_AUTO_ID, nil)" color=color.WHITE }
		[{ 8, 0, "s", 1 }] = { title="Light     :", data="character_sheet.value_flag(FLAG_LITE)" color=color.WHITE }
		[{ 9, 0, "s", 1 }] = { title="Sh.Fire   :", data="character_sheet.not_impl(FLAG_BLOW_RESPONSE, AURA_FIRE)" color=color.WHITE }
		[{10, 0, "s", 1 }] = { title="Sh.Elec   :", data="character_sheet.not_impl(FLAG_BLOW_RESPONSE, AURA_ELEC)" color=color.WHITE }
		[{11, 0, "s", 1 }] = { title="Regen     :", data="character_sheet.not_impl(nil, FLAG_REGEN, nil)" color=color.WHITE }
		--[{ 5, 0, "s", 1 }] = { title="SlowDiges:", data="character_sheet.not_impl(nil, FLAG_SLOW_DIGEST, nil)" color=color.WHITE }
		[{12, 0, "s", 1 }] = { title="Precog    :", data="character_sheet.not_impl(nil, FLAG_PRECOGNITION, nil)" color=color.WHITE }
		[{13, 0, "s", 1 }] = { title="Spell In  :", data="character_sheet.not_impl(nil, FLAG_SPELL_CONTAIN, nil)" color=color.WHITE }
		[{14, 0, "s", 1 }] = { title="Blessed   :", data="character_sheet.not_impl(nil, FLAG_BLESSED, nil)" color=color.WHITE }
		[{16, 0, "s", 1 }] = { title="ResMorgul :", data="character_sheet.not_impl(nil, FLAG_RES_MORGUL, nil)" color=color.WHITE }

--[[
		[{ 1, 40, "s", 0 }] = { title="            ", data="character_sheet.display_equip_char()" color=color.LIGHT_BLUE }
		[{ 2, 40, "s", 0 }] = { title="            ", data="character_sheet.display_equip_symb()" color=color.LIGHT_BLUE }
		[{ 3, 40, "s", 1 }] = { title="ESP.Full   :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ESP, 10)" color=color.WHITE }
		[{ 4, 40, "s", 1 }] = { title="ESP.Orc    :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ORC, 10)" color=color.WHITE }
		[{ 5, 40, "s", 1 }] = { title="ESP.Troll  :", data="character_sheet.value_flag(FLAG_ESP, FLAG_TROLL, 10)" color=color.WHITE }
		[{ 6, 40, "s", 1 }] = { title="ESP.Dragon :", data="character_sheet.value_flag(FLAG_ESP, FLAG_DRAGON, 10)" color=color.WHITE }
		[{ 7, 40, "s", 1 }] = { title="ESP.Giant  :", data="character_sheet.value_flag(FLAG_ESP, FLAG_GIANT, 10)" color=color.WHITE }
		[{ 8, 40, "s", 1 }] = { title="ESP.Demon  :", data="character_sheet.value_flag(FLAG_ESP, FLAG_DEMON, 10)" color=color.WHITE }
		[{ 9, 40, "s", 1 }] = { title="ESP.Spider :", data="character_sheet.value_flag(FLAG_ESP, FLAG_SPIDER, 10)" color=color.WHITE }
		[{10, 40, "s", 1 }] = { title="ESP.Evil   :", data="character_sheet.value_flag(FLAG_ESP, FLAG_EVIL, 10)" color=color.WHITE }
		[{11, 40, "s", 1 }] = { title="ESP.Animal :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ANIMAL, 10)" color=color.WHITE }
		[{12, 40, "s", 1 }] = { title="ESP.Thundr :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ANIMAL, 10)" color=color.WHITE }
		[{13, 40, "s", 1 }] = { title="ESP.Good   :", data="character_sheet.value_flag(FLAG_ESP, FLAG_GOOD, 10)" color=color.WHITE }
		[{14, 40, "s", 1 }] = { title="ESP.Nonliv :", data="character_sheet.value_flag(FLAG_ESP, FLAG_NONLIVING, 10)" color=color.WHITE }
		[{15, 40, "s", 1 }] = { title="ESP.Unique :", data="character_sheet.value_flag(FLAG_ESP, FLAG_UNIQUE, 10)" color=color.WHITE }
		[{16, 40, "s", 1 }] = { title="ESP.Hostil :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ESP_HOSTILE, 10)" color=color.WHITE }
		[{17, 40, "s", 1 }] = { title="ESP.Neutr  :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ESP_NEUTRAL, 10)" color=color.WHITE }
		[{18, 40, "s", 1 }] = { title="ESP.Friend :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ESP_FRIENDLY, 10)" color=color.WHITE }
		[{19, 40, "s", 1 }] = { title="ESP.Sleep  :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ESP_SLEEPING, 10)" color=color.WHITE }
		[{20, 40, "s", 1 }] = { title="ESP.Awake  :", data="character_sheet.value_flag(FLAG_ESP, FLAG_ESP_AWAKE, 10)" color=color.WHITE }
]]
	}
}
]]