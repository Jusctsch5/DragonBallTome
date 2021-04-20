-- Dragonball T: Item descriptions

object_desc_tvals=
{
	-- [TV_CLIP] = { weapon=true }
	-- [TV_MISSILE] = { weapon=true }
	[TV_DBALL] = function(obj, name, mode)
		-- Dragonballs glow when others are nearby
		-- Do we need to distinguish Earth vs Namek balls?
		if dball.dragonballs_carried() +  dball.dragon_radar() > 1 then
			name.suffix1 = "(Glowing)"
		end
	end
	-- [TV_AMULET] = function(obj, desc) end
	-- [TV_RING] = function(obj, desc)	end

	-- Need to display AC values if present
	[TV_ENTANGLEARM] = { weapon=true }
	[TV_POLEARM] = { weapon=true }
	[TV_SWORDARM] = { weapon=true }
	[TV_SMALLARM] = { weapon=true }
	[TV_NAMEK_WEAPON] = { weapon=true }
		-- Armour
	[TV_BOOTS] = { armor=true }
	[TV_GLOVES] = {
		armor=true
--		name.show_ac_mods = true	-- Doesnt do what it should. Engine.
	}
	[TV_BRACERS] = { armor=true }
	[TV_HEADPIECE] = { armor=true }
	[TV_SHIELD] = { armor=true }
	[TV_BODY_ARMOUR] = { armor=true }
	[TV_CLOAK] = { armor=true }
	[TV_NAMEK_ARMOR] = { armor=true }

	-- Shouldn't everything have a capsule display?
	[TV_VEHICLE] = function(obj, name, mode)
		if dball.capsuled(obj) then
			name.suffix1 = "(Capsuled)"
		end
	end
	[TV_MISC] = function(obj, name, mode)
		if dball.capsuled(obj) then
			name.suffix1 = "(Capsuled)"
		end
	end

	[TV_BLUEPRINTS] = function(obj, name, mode)
		--if (obj.ident & IDENT_STOREB ~= 0) then
			-- name.suffix1 = "(Store)"
		--	name.suffix1 = "(" .. k_info[1 + obj.flags[FLAG_TECHNO_PLANS]].name .. ")"
		--end
	end

	[TV_GUN] = function(obj, name, mode)
					if mode == 0 then
						return
					end

					obj = generic_or_specific(obj)

					local rounds = get_flag(obj, FLAG_AMMO_CURRENT)
					local capacity = get_flag(obj, FLAG_AMMO_CAPACITY)

					local mult = get_flag(obj, FLAG_MULTIPLIER)

					if obj.flags[FLAG_XTRA_MIGHT] then
						mult = mult + get_flag(obj, FLAG_XTRA_MIGHT)
					end

					local ammo_type = ""
					local c_kidx = obj.flags[FLAG_AMMO_LOADED]
					if c_kidx ~= FLAG_AMMO_NONE then
						local clip = firearmcombat.get_ammo(c_kidx)
						if clip.flags[FLAG_AMMO] == FLAG_AMMO_NONE then
							ammo_type = ""
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_STANDARD then
							ammo_type = ""
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_AP then
							ammo_type = "(AP)"
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_I then
							ammo_type = "(I)"
						end
					end

					local silenced = ""
					if has_flag(obj, FLAG_SILENCED) and obj.flags[FLAG_SILENCED] == 2 then
						silenced = "(Silenced) "
					end
					local scoped = ""
					if has_flag(obj, FLAG_SCOPABLE) and obj.flags[FLAG_SCOPABLE] == 2 then
						scoped = "(Scope) "
					end

					name.suffix1 = scoped .. silenced .. "(x" .. mult .. ") " .. ammo_type .. " (" .. rounds .. "/" .. capacity .. ")"
				end

	[TV_SHOTGUN] = function(obj, name, mode)
					if mode == 0 then
						return
					end

					obj = generic_or_specific(obj)

					local rounds = get_flag(obj, FLAG_AMMO_CURRENT)
					local capacity = get_flag(obj, FLAG_AMMO_CAPACITY)

					local mult = get_flag(obj, FLAG_MULTIPLIER)

					if obj.flags[FLAG_XTRA_MIGHT] then
						mult = mult + get_flag(obj, FLAG_XTRA_MIGHT)
					end

					local ammo_type = ""
					local c_kidx = obj.flags[FLAG_AMMO_LOADED]
					if c_kidx ~= FLAG_AMMO_NONE then
						local clip = firearmcombat.get_ammo(c_kidx)
						if clip.flags[FLAG_AMMO] == FLAG_AMMO_NONE then
							ammo_type = ""
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_STANDARD then
							ammo_type = ""
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_AP then
							ammo_type = "(AP)"
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_I then
							ammo_type = "(I)"
						end
					end

					local silenced = ""
					if has_flag(obj, FLAG_SILENCED) and obj.flags[FLAG_SILENCED] == 2 then
						silenced = "(Silenced) "
					end
					local scoped = ""
					if has_flag(obj, FLAG_SCOPABLE) and obj.flags[FLAG_SCOPABLE] == 2 then
						scoped = "(Scope) "
					end

					name.suffix1 = scoped .. silenced .. "(x" .. mult .. ") " .. ammo_type .. " (" .. rounds .. "/" .. capacity .. ")"
				end

	[TV_LAUNCHER] = function(obj, name, mode)
				if mode == 0 then
					return
				end

				obj = generic_or_specific(obj)

				local rounds = get_flag(obj, FLAG_AMMO_CURRENT)
				local capacity = get_flag(obj, FLAG_AMMO_CAPACITY)

				local mult = get_flag(obj, FLAG_MULTIPLIER)

				if obj.flags[FLAG_XTRA_MIGHT] then
					mult = mult + get_flag(obj, FLAG_XTRA_MIGHT)
				end

					local ammo_type = ""
					local c_kidx = obj.flags[FLAG_AMMO_LOADED]
					if c_kidx ~= FLAG_AMMO_NONE then
						local clip = firearmcombat.get_ammo(c_kidx)
						if clip.flags[FLAG_AMMO] == FLAG_AMMO_NONE then
							ammo_type = ""
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_STANDARD then
							ammo_type = ""
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_AP then
							ammo_type = "(AP)"
						elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_I then
							ammo_type = "(I)"
						end
					end

					if has_flag(obj, FLAG_SCOPABLE) and obj.flags[FLAG_SCOPABLE] == 2 then
						name.suffix1 = "(Scope) "
					end

					-- HACK?
					-- Aethetically I prefer this:
					if rounds > 0 then
						name.suffix1 = "(x" .. mult .. ") " .. ammo_type .. " (LOADED)"
					else
						name.suffix1 = "(x" .. mult .. ") (empty)"
					end
					-- to this:
					--name.suffix1 = "(x" .. mult .. ") (" .. rounds .. "/" .. capacity .. ")"
					--But this will be less informative if there ever come to be
					--launchers with > 1 missile capacity
				
			end

	[TV_ELECTRONICS] = function(obj, desc)
		desc.mod = desc.base

		local flavour, color = flavour.get(TV_ELECTRONICS, obj.sval)
		-- obj.color = color

		if desc.aware or (obj.ident & IDENT_STOREB ~= 0) then
			desc.base = "& #~"
			-- desc.base = "#"
			if has_flag(obj, FLAG_FUEL) then
				local e_fuel = get_flag(obj, FLAG_FUEL)
				local e_capacity = get_flag(obj, FLAG_FUEL_CAPACITY)

				desc.suffix1 = "(" .. e_fuel .. "/" .. e_capacity .. ")"
			end
		else
			desc.base = "& "..flavour.."~"
			-- desc.base = flavour
		end
	end

	[TV_HIGH_TECH_COMPONENTS] = function(obj, desc)
		desc.mod = desc.base
		local flavour, color = flavour.get(TV_HIGH_TECH_COMPONENTS, obj.sval)

		if desc.aware or (obj.ident & IDENT_STOREB ~= 0) then
			desc.base = "& #~"
		else
			desc.base = "& " .. flavour .. "~"
		end
	end

	[TV_POTION] = function(obj, desc)
		desc.mod = desc.base
		local flavour, color = flavour.get(TV_POTION, obj.sval)

		if desc.aware or (obj.ident & IDENT_STOREB ~= 0) then
			desc.base = "& #~"
		else
			desc.base = flavour
		end
	end

	[TV_SALVE] = function(obj, desc)
		desc.mod = desc.base
		local flavour, color = flavour.get(TV_CHEMISTRY, obj.sval)

		if desc.aware or (obj.ident & IDENT_STOREB ~= 0) then
			desc.base = "& bottle~ of #"
		else
			desc.base = "& bottle~ of " .. flavour .. " liquid"
		end
	end

	[TV_CHEMISTRY] = function(obj, desc)
		desc.mod = desc.base
		local flavour, color = flavour.get(TV_CHEMISTRY, obj.sval)

		if desc.aware or (obj.ident & IDENT_STOREB ~= 0) then
			desc.base = "& ounce~ of #"
		else
			desc.base = "& ounce~ of " .. flavour .. " chemicals"
		end
	end

	[TV_PARCHMENT] = function(obj, desc)
		desc.mod = desc.base
		desc.base = "& parchment~ - #"
	end

--[[
	[TV_CORPSE] = function(obj, desc)
		local race = r_info[1 + get_flag(obj, FLAG_MONSTER_IDX)]
		desc.mod = desc.base

		if has_flag(race, FLAG_UNIQUE) then
			desc.base = race.name.."'s #~"
		else
			desc.base = "& "..race.name.." #~"
		end
	end
]]
	[TV_CORPSE] = function(obj, desc)
		desc.mod = desc.base

		local monst = obj.flags[FLAG_MONSTER_OBJ]
		if not monst then
			desc.mod  = desc.base
			desc.base = "& BUGGY CORPSE #~"
			return
		end

		local name = monster_desc(monst, 512 | 256 | 128)
		if has_flag(monst, FLAG_UNIQUE) then
			name = book_capitals(name) .. "'s"
			desc.no_article = true
		end

		local rotenness = ""
		if obj.flags[FLAG_DECAY] and obj.flags[FLAG_MONSTER_DECAY] and
			obj.flags[FLAG_ORIG_DECAY]
		then
			local freshness = 200 * obj.flags[FLAG_MONSTER_DECAY] /
				obj.flags[FLAG_ORIG_DECAY]

			if freshness > 200 then
				rotenness = "cured "
			elseif freshness < 17 then
				rotenness = "completely rotten "
			elseif freshness < 33 then
				rotenness = "exremely rotten "
			elseif freshness < 50 then
				rotenness = "very rotten "
			elseif freshness < 67 then
				rotenness = "rotten "
			elseif freshness < 83 then
				rotenness = "moderatly rotten "
			elseif freshness < 100 then
				rotenness = "slightly rotten "
			end
		elseif not has_flag(monst, FLAG_UNIQUE) then
			rotenness = "unrotting "
		end

		desc.base = "& ".. rotenness .. name .. " #~"
	end


	[TV_LITE] = function(obj, desc)
		if obj.flags[FLAG_FUEL_LITE] then
			desc.mod = "(with ".. obj.flags[FLAG_FUEL] .." turns of light)"
		end
	end

	[TV_TOOL] = function(obj, desc, mode)
		mode = mode or 0

		if mode == 0 then
			return
		end

		local suffix = ""

		desc.mod = desc.base
		obj      = generic_or_specific(obj)

		if obj.flags[FLAG_DBT_DIGGER] then
			suffix = suffix .. " (x" .. obj.flags[FLAG_DBT_DIGGER] .. ")"
		end

		desc.suffix1 = clean_whitespace(suffix)
	end

}

-- Item details
function object_desc_details(obj, trim_down)
	-- Setup
	desc_obj.cur_obj = obj

	-- Weapons description broken off into subroutine
	desc_obj.desc_weapon(obj, trim_down)

	-- Before anything else, are we in a capsule?
	if dball.capsuled(obj) then
		desc_obj.text_out("It is inside a capsule. ")
		return
	end

	-- Handle Blueprints
	if has_flag(obj, FLAG_TECHNO_PLANS) then
		if known_flag(obj, FLAG_TECHNO_PLANS) or (obj.ident & IDENT_STOREB ~= 0) then
			local k_ptr = obj.flags[FLAG_TECHNO_PLANS]
			local item = k_info[k_ptr]
			desc_obj.text_out("These blueprints describe how to build a " .. item.name .. ". ")
			return
		end
	end

	-- Display ID requirements
	-- if (!object_known_p(obj)) then
	-- if obj.ident then
	--[[
	if not has_flag(obj, FLAG_EASY_KNOW) then
		if known_flag(obj, FLAG_ID_VALUE) then
		else
			desc_obj.text_out("You'll need a " .. s_info[obj.flags[FLAG_ID_SKILL] + 1].name .. " skill of ")
			desc_obj.text_out(obj.flags[FLAG_ID_VALUE] - player.stat(A_INT) + 10 .. " to know more about it. ")
			-- desc_obj.value_flag(FLAG_ID_VALUE, " skill of $V to know more about it. ")
		end
	end
	]]

	-- if not obj.ident and IDENT_STOREB ~= 0
	-- if not obj.ident then
	-- *Shrug*
	-- The weirdest things cause crashes when moving to new alphas...	
	if has_flag(obj, FLAG_ID_VALUE) and has_flag(obj, FLAG_ID_SKILL) then
		if not known_flag(obj, FLAG_ID_VALUE) then
			desc_obj.text_out("You'll need a " .. s_info[obj.flags[FLAG_ID_SKILL] + 1].name .. " skill of ")
			local skill_needed = obj.flags[FLAG_ID_VALUE] - player.stat(A_INT) + 10
			desc_obj.text_out( skill_needed .. " to know more about it. ")
		end
	end

	-- Experience Modifiers
	if known_flag(obj, FLAG_XP_MOD) then
		desc_obj.value_flag(FLAG_XP_MOD, "You'll train $V percent more quickly while wearing it. ")
		-- desc_obj.text_out("You'll gain experience more quickly while wearing it. ")
	end

	-- Note: Gun and weapon mods only ever apply to themselves,
	-- Do any items modified only them, other than themselves?
	if known_flag(obj, FLAG_WHEN_TO_DBCOMBAT_MOD) then
		if obj.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_HANDS then
			desc_obj.text_out("Combat modifiers for this item are applied only to barehanded combat. ")
		--elseif obj.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_WEAPONS then
		--	desc_obj.text_out("Combat modifiers for this item are applied only to weapons combat. ")
		elseif obj.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_MELEE then
			desc_obj.text_out("Combat modifiers for this item are applied to all melee combat. ")
		--elseif obj.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_GUNS then
		--	desc_obj.text_out("Combat modifiers for this item are applied only to firearm combat. ")
		elseif obj.flags[FLAG_WHEN_TO_DBCOMBAT_MOD] == FLAG_DBCOMBAT_MOD_ALWAYS then
			desc_obj.text_out("Combat modifiers for this item are applied to all forms of combat. ")
		else
			-- desc_obj.text_out("Description error: When do combat modifiers apply?")
		end
	end

	-- Speeds
	desc_obj.value_flag(FLAG_SPEED, "It modifies your general speed by $V.")

--[[
	-- Does DBT use any speed other than general?
	if known_flag(obj, FLAG_SPEEDS) then
		foreach_flags(obj.flags[FLAG_SPEEDS],
			function(flags, f)
				desc_obj.value_flag({FLAG_SPEEDS,f}, "It modifies your " .. get_speed_desc(f) .. " speed by $V.")
			end
		)
	end
]]

--[[
	-- Do these exist?
	-- Percent modifiers
	desc_obj.value_group({
		[FLAG_MANA] = "mana"
		[FLAG_LIFE] = "life"
		}, "It modifies ", nil, nil, {color = "%"})
]]

	-- Non-percent (absoulte) modifiers
	desc_obj.value_group({
		[{FLAG_STATS, A_STR}] = "strength",
		[{FLAG_STATS, A_INT}] = "intelligence"
		[{FLAG_STATS, A_WIL}] = "wisdom"
		[{FLAG_STATS, A_CON}] = "constitution"
		[{FLAG_STATS, A_DEX}] = "dexterity"
		[{FLAG_STATS, A_CHR}] = "charisma"
		[{FLAG_STATS, A_SPD}] = "speed"
		[FLAG_STEALTH] = "stealth"
		[FLAG_INFRA] = "infravision"
		}, "It modifies ")

	-- Resistances
	if known_flag(obj, FLAG_RESIST) then
		local tbl = {}
		foreach_flags(obj.flags[FLAG_RESIST],
			function(flags, f)
				%tbl[{FLAG_RESIST,f}] = get_dam_color_desc(f)
			end)
		desc_obj.value_group(tbl, "It provides resistance ", "to ",
							 nil, {color = "%"})
	end

	-- Resist Blindness
	if known_flag(obj, FLAG_RES_BLIND) then
		desc_obj.text_out("It will be difficult to blind you while wearing this. ")
	end

	-- Tech Require
	-- if obj.flags[FLAG_TECH_REQUIRE] then
		desc_obj.value_flag(FLAG_TECH_REQUIRE, "It requires a Tech skill of $V to be worn or used.")
	-- end

	-- Ballistic Plates
	if known_flag(obj, FLAG_BALLISTIC_PLATED) then
		if obj.flags[FLAG_BALLISTIC_PLATED] == 1 then
			desc_obj.text_out("It has a slot into which a ballistic plate may be installed.  ")
		elseif obj.flags[FLAG_BALLISTIC_PLATED] == 2 then
			desc_obj.text_out("It has a ballistic plate installed.  ")
		end
	end

	-- Silencers
	if known_flag(obj, FLAG_SILENCED) then
		if obj.flags[FLAG_SILENCED] == 1 then
			desc_obj.text_out("It may have a silencer attached to it.  ")
		elseif obj.flags[FLAG_SILENCED] == 2 then
			desc_obj.text_out("It has a silencer mounted on it.  ")
		end
	end

	-- Sscopes
	if known_flag(obj, FLAG_SCOPABLE) then
		if obj.flags[FLAG_SCOPABLE] == 1 then
			desc_obj.text_out("It may have a scope attached to it.  ")
		elseif obj.flags[FLAG_SCOPABLE] == 2 then
			desc_obj.text_out("It has a scope mounted on it.  ")
		end
	end

	-- Toggleable firearms
	if has_flag(obj, FLAG_USEABLE) and obj.flags[FLAG_USEABLE] == 5 then
		desc_obj.text_out("This weapon may fire in single road or fully automatic modes. ")
		if obj.flags[FLAG_USEABLE] == FLAG_MISSILE_SPRAY then
			desc_obj.text_out("It is currently firing in fully automatic mode.  ")
		else
			desc_obj.text_out("It is currently firing in single burst mode.  ")
		end
	end

	-- Ammunition
	-- Meh. This is not very pretty, but it works.
	if has_flag(obj, FLAG_AMMO_LOADED) then
		local c_kidx = obj.flags[FLAG_AMMO_LOADED]
		if obj.flags[FLAG_AMMO_CURRENT] == 0 then
				desc_obj.text_out("It is not loaded.  ")
		elseif c_kidx == FLAG_AMMO_NONE then
				-- GAH! This is bad!
				-- It's not likely...but FLAG_AMMO_NONE could happen
				-- to match the kidx of the ammo!
				desc_obj.text_out("It is not loaded.  ")
		else	
			local clip = firearmcombat.get_ammo(c_kidx)
			if obj.flags[FLAG_AMMO] == TV_CLIP then
				if clip.flags[FLAG_AMMO] == FLAG_AMMO_STANDARD then
					desc_obj.text_out("It is loaded with standard ammunition.  ")
				elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_AP then
					desc_obj.text_out("It is loaded with armor piercing ammunition.  ")
				elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_I then
					desc_obj.text_out("It is loaded with incindiary ammunition.  ")
				end
			elseif obj.flags[FLAG_AMMO] == TV_SHOTGUN_ROUND then
				if clip.flags[FLAG_AMMO] == FLAG_AMMO_STANDARD then
					desc_obj.text_out("It is loaded with scattershot.  ")
				elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_AP then
					if obj.flags[FLAG_AMMO_CURRENT] > 1 then
						desc_obj.text_out("It is loaded with lead slugs.  ")
					else
						desc_obj.text_out("It is loaded with a lead slug.  ")
					end
				end
			elseif obj.flags[FLAG_AMMO] == TV_MISSILE then
				if clip.flags[FLAG_AMMO] == FLAG_AMMO_STANDARD then
					desc_obj.text_out("It is loaded with a surface-to-suface missile.  ")
				elseif clip.flags[FLAG_AMMO] == FLAG_AMMO_I then
					desc_obj.text_out("It is loaded with an incindiary missile.  ")
				end
			end
		end
	end

	-- Skill bonuses
	if known_flag(obj, FLAG_SKILL_BONUS) then
		local tbl = {}
		foreach_flags(obj.flags[FLAG_SKILL_BONUS],
			function(flags, f)
				%tbl[{FLAG_SKILL_BONUS,f}] =
					s_info[f + 1].name .. " skill"
			end
		)
		desc_obj.value_group_frac(tbl, "It modifes ", 3, "your ")
	end

--[[
	-- Does any object in DBT offer sustain? Artifacts maybe?
	desc_obj.bool_group({
		[{FLAG_SUST_STATS, A_STR}] = "strength",
		[{FLAG_SUST_STATS, A_INT}] = "intelligence"
		[{FLAG_SUST_STATS, A_WIL}] = "willpower"
		[{FLAG_SUST_STATS, A_CON}] = "constitution"
		[{FLAG_SUST_STATS, A_DEX}] = "dexterity"
		[{FLAG_SUST_STATS, A_CHR}] = "charisma"
		[{FLAG_SUST_STATS, A_SPD}] = "speed"
		}, "It sustains ")
]]

	-- Misc
	if known_flag(obj, FLAG_FUEL_LITE) then
		desc_obj.value_flag(FLAG_LITE, "It provides light (radius $V) when fueled.")
	else
		desc_obj.value_flag(FLAG_LITE, "It provides light (radius $V) forever.")
	end

	desc_obj.bool_flag(FLAG_FEATHER, "It allows you to levitate.")
	desc_obj.bool_flag(FLAG_FLY, "It allows you to fly.")
	desc_obj.bool_flag(FLAG_CLIMB, "It allows you to climb mountains.")

	-- Object can't be harmed by...
	if is_known(obj) and is_artifact(obj) then
		desc_obj.text_out("It is indestructable. ")
	elseif known_flag(obj, FLAG_IGNORE) then
		local tbl = {}
		foreach_flags(obj.flags[FLAG_IGNORE],
			function(flags, f)
				%tbl[{FLAG_IGNORE,f}] = get_dam_color_desc(f)
			end
		)
		desc_obj.bool_group(tbl, "It cannot be harmed by ", false, " or ")
	end

end

-- Greater ID for weapons
function desc_obj.desc_weapon(obj, trim_down)
	desc_obj.value_flag(FLAG_DIFFICULTY, "This weapon has a base difficulty of $V.")
	desc_obj.bool_flag(FLAG_PAIRED, "It can easily be used in pairs.")
	desc_obj.bool_flag(FLAG_RIPOSTABLE, "It may riposte.")
	desc_obj.bool_flag(FLAG_MUST2H, "It must be wielded two-handed.")

	if has_flag(obj, FLAG_POISON_BLADE) then
		if obj.flags[FLAG_POISON_BLADE] > 0 then
			desc_obj.text_out("It is dripping with poison.")
		end
	end

	if has_flag(obj, FLAG_DISCIPLINE) and (skill(SKILL_CONSTRUCTION).value + skill(SKILL_DISASSEMBLY).value) > 0 then
		if obj.flags[FLAG_DISCIPLINE] == 1 then
			desc_obj.text_out("Items of this type may be built and dismantled using a mechanical toolkit. ")
		elseif obj.flags[FLAG_DISCIPLINE] == 2 then
			desc_obj.text_out("Items of this type may be built and dismantled using an electrical tookit. ")
		elseif obj.flags[FLAG_DISCIPLINE] == 3 then
			desc_obj.text_out("Items of this type may be built and dismantled using a chemistry kit. ")
		elseif obj.flags[FLAG_DISCIPLINE] == 4 then
			desc_obj.text_out("Items of this type may be built and dismantled using a lathe. ")
		end
	end

	if has_flag(obj, FLAG_ENTANGLE) then
		if (skill(SKILL_WEAPONS).value / 1000) > 9 then
			local ent_chance = (skill(SKILL_WEAPONS).value / 2000)
			desc_obj.text_out("You will stun your opponents with " .. ent_chance .. " percent of all blows landed with this weapon. ")
		else
			desc_obj.text_out("In the hands of a more skilled user, this weapon may entangle opponents. ")
		end
	end

	local v_chance = 0
	if obj.flags[FLAG_VORPAL] then
		v_chance = v_chance + (skill(SKILL_WEAPONS).value / 1000)
	end
	if obj.flags[FLAG_BLADED] and has_ability(AB_BLEED_ATTACK) then
		v_chance = v_chance + (skill(SKILL_WEAPONS).value / 1000)
	end
	if v_chance > 0 then
		desc_obj.text_out("You will cut your opponents with " .. v_chance .. " percent of all blows landed with this weapon. ")
	end
end
