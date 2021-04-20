-- Dragonball T: Hp
--
-- The default life subsystem is modifed to simplify life/death handling.
-- In DBT, when a character is 'dead' physical damage is deducted from chi

new_flag("REGEN_LIFE")
new_flag("REGEN_LIFE_TURN")

hook.new_hook_type("PLAYER_TAKE_HIT")

counter.create
{
	name = "LIFE"
	min = -1
	max = 10
	reset = "max"
	on_decrease = function(value, modif, reason)
		local ret, new_modif = hook.process(hook.PLAYER_TAKE_HIT, value, modif)
		if ret then
			modif = new_modif
		end

		if wizard then message("You take hit for #G"..-modif.."#w damage.") end

		-- Die!
		if value + modif < 0 then
			message(color.RED, "You die.")
			kill_player(reason)
		end
		player.redraw[FLAG_PR_HP] = true
		player.window[FLAG_PW_PLAYER] = true
		return true, modif
	end
	on_increase = function(value, modif, reason)
		if value < counter.max(counter.LIFE) and not counter.state(counter.LIFE, "silent") then
			counter.state(counter.LIFE, "silent", false)

--[[
			if modif > 0 then
				if modif < 5 then
					message("You feel a little better.");
				elseif modif < 15 then
					message("You feel better.");
				elseif modif < 35 then
					message("You feel much better.");
				else
					message("You feel very good.");
				end
			end
]]
		end

		player.redraw[FLAG_PR_HP] = true
		player.window[FLAG_PW_PLAYER] = true
		return true, modif
	end
	auto_regen = function()
		-- Only regenerate if alive!
		if dball_data.alive == 0 then
			if player.has_intrinsic(FLAG_REGEN_LIFE) then
				local nb = abs(player.intrinsic(FLAG_REGEN_LIFE))
				local amt = nb / 1000
				local im = imod(nb, 1000)
				if im ~= 0 then
					if imod(turn / 10, 1000 / im) == 0 then
						amt = amt + 1
					end
				end

				if amt ~= 0 then
					if player.intrinsic(FLAG_REGEN_LIFE) < 0 then amt = -amt end
					counter.state(counter.LIFE, "silent", true)
					return amt
				end
			end
		end
	end
}

function take_hit(dam, die_from)
	if dball_data.alive == 0 then
		counter.dec(counter.LIFE, dam, die_from)
	else
		if dam > dball_data.cur_chi_pool then
			kill_player(die_from)
		else
			dam = dam * 100
			dball.mod_chi(-dam)
		end
	end
end

function hp_player(heal)
	-- NOTE: No chi-gain effects here!
	-- hp effecting cure/heal does NOT
	-- help you when you're dead!
	counter.inc(counter.LIFE, heal)
end

function player.chp(val)
	if val then counter.set(counter.LIFE, val, "setting life") end
	return counter.get(counter.LIFE)
end
function player.mhp(val)
	return counter.max(counter.LIFE, val)
end
