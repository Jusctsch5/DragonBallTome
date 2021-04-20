-- Dragonball T: Movement Modes

mov_mode.new
{
	name = "Normal"
	desc = {
		"This is the default movement mode, with no specific benefits or penalities."
	}
	update = function()
		player.update = player.update | PU_BONUS
		player.redraw[FLAG_PR_STATE] = true
		player.redraw[FLAG_PR_SPEED] = true
		player.redraw[FLAG_PR_ARMOR] = true
	end
}

mov_mode.new
{
	name = "Searching"
	desc = {
		"Search for hidden features and traps around you, but walk slowly."
	}
	bonus = function()
		if not player.inventory[INVEN_VEHICLE][1] then
			player.inc_intrinsic(FLAG_SEARCH_POWER, player.stat(A_INT))
			player.inc_intrinsic(FLAG_SEARCH_FREQ, player.stat(A_INT))
		
			player.inc_speed(-7)
		end
	end
	update = function()
		player.update = player.update | PU_BONUS
		player.redraw[FLAG_PR_STATE] = true
		player.redraw[FLAG_PR_SPEED] = true
		player.redraw[FLAG_PR_ARMOR] = true
	end
}

mov_mode.new
{
	name = "Running"
	desc = {
		"Run like the wind! This gives you a good movement speed but reduces your"
		"stealth and searching abilities, as well as your ability to defend yourself."
	}
	bonus = function()
		if not player.inventory[INVEN_VEHICLE][1] then
			local eff = (player.stat(A_SPD) / 5) + (player.stat(A_DEX) / 10) 

			-- Running pretty much eliminates searching
			local search = player.stat(A_INT) / 2
			player.set_intrinsic(FLAG_SEARCH_POWER, search)
			player.set_intrinsic(FLAG_SEARCH_FREQ, search)

			-- Does bad things to stealth, though sneaking is still possible
			player.skill_stl = player.skill_stl - eff

			-- More difficult to defend yourself
			local ac_pen = 0
			if player.stat(A_DEX) < 10 then
				ac_pen = 10 - player.stat(A_DEX)
			elseif player.stat(A_DEX) > 10 then
				ac_pen = (player.stat(A_DEX) - 10) / 2 
			end

			ac_pen = ac_pen + get_skill(SKILL_DODGE) / 2 


			player.ac = player.ac - ac_pen
			player.dis_ac = player.dis_ac - ac_pen

		
			player.inc_speed(eff)
		end
	end
	update = function()
		player.update = player.update | PU_BONUS
		player.redraw[FLAG_PR_STATE] = true
		player.redraw[FLAG_PR_SPEED] = true
		player.redraw[FLAG_PR_ARMOR] = true
	end
}

mov_mode.new
{
	name = "Immovable"
	desc = {
		"Center, and feel your center of gravity sink into the ground beneath"
		"you. It will be tremendously difficult for anyone to move you, but it"
		"will also be slow for you to move on your own."
	}
	allow = function()
		return has_ability(AB_IMMOVABILITY)
	end
	bonus = function()
		if not player.inventory[INVEN_VEHICLE][1] then
			player.inc_speed(-7)
		end
	end
	update = function()
		player.update = player.update | PU_BONUS
		player.redraw[FLAG_PR_STATE] = true
		player.redraw[FLAG_PR_SPEED] = true
		player.redraw[FLAG_PR_ARMOR] = true
	end
}

mov_mode.new
{
	name = "Sneaking"
	desc = {
		"Walk slowly without making much sound."
	}
	allow = function()
		return has_ability(AB_SNEAK)
	end
	bonus = function()
		if not player.inventory[INVEN_VEHICLE][1] then
			-- Affect Skill -- stealth
			player.skill_stl = player.skill_stl + player.skill_stl
		
			player.inc_speed(-7)
		end
	end
	update = function()
		player.update = player.update | PU_BONUS
		player.redraw[FLAG_PR_STATE] = true
		player.redraw[FLAG_PR_SPEED] = true
		player.redraw[FLAG_PR_ARMOR] = true
	end
}

