-- Dragonball T: Chi Counter
--
-- Simple adaptation from default ToME mana subsystem:
--
-- 1) Apparantly the default math
-- fails to correctly compute fractional negative
-- regeneration rates between 0 and -2 mana per round.
-- This is a problem for DBT's Constant Effect magic
-- system, so I'm multiplying the counter by 1000.
--
-- 2) Decreasing minimum to -1 instead of zero to
-- facilitate constant effect shutdowns.
--
-- V085: Adding in Chi drain to allow effects to turn of
-- when the Chi runs out

declare_global_constants
{
	"increase_mana",
}

new_flag("REGEN_MANA")

counter.create
{
	name = "MANA"
	min = -1
	max = 1000
	reset = "max"
	on_decrease = function(value, modif, reason)
		player.redraw[FLAG_PR_MANA] = true
		-- player.window = player.window | PW_PLAYER
	end
	on_increase = function(value, modif, reason)
		player.redraw[FLAG_PR_MANA] = true
		-- player.window = player.window | PW_PLAYER
	end
	auto_regen = function()
		-- If we have enough Chi, then just subtract it all
		--if player.csp() + dball_data.chi_drain_rate >= 0 then
		--	return dball_data.chi_drain_rate or 0
		--else
			-- Otherwise, we have to subtract for each effect, and turn off anything
			-- we don't have the Chi to maintain

			-- First, regenerate if we can
			local mana_amt = 0
			mana_amt = (get_skill(SKILL_CHI_REGENERATION) * 200)
			if has_ability(AB_MEDITATION) then
				mana_amt = mana_amt + (get_skill(SKILL_CHI_REGENERATION) * 200)
			end
			increase_mana(mana_amt)

			-- Compute the Chi Gung drain modifier
			local ndbyz
			if get_skill(SKILL_CHI_GUNG) < 1 then 
				ndbyz = 100000
			else
				ndbyz = 100000 / get_skill(SKILL_CHI_GUNG)
			end

			-- Flight
			if dball_data.chi_flight_setting == 1 then
				mana_amt = (ndbyz / 2)
				if player.csp() - mana_amt < 1 then
					dball_data.chi_flight_setting = 0
					message(color.YELLOW, "You fall from the air!")
				else
					increase_mana(-mana_amt)
				end
			end

			-- Battle Aura
			if dball_data.chi_aura_setting == 1 then
				mana_amt = (ndbyz / 2)
				if player.csp() - mana_amt < 1 then
					dball_data.chi_flight_setting = 0
					message(color.YELLOW, "Your aura crumbles!")
				else
					increase_mana(-mana_amt)
				end
			end

			-- Haste
			if dball_data.chi_haste_setting > 0 then
				mana_amt = (dball_data.chi_haste_setting * (ndbyz / 10))
				if player.csp() - mana_amt < 0 then
					dball_data.chi_haste_setting = 0
					message(color.YELLOW, "You slow down!")
				else
					increase_mana(-mana_amt)
				end
			end

			-- Regeneration
			if dball_data.chi_regeneration_setting > 0 then
			mana_amt = (dball_data.chi_regeneration_setting * (ndbyz / 5))
				if player.csp() - mana_amt < 0 then
					dball_data.chi_regeneration_setting = 0
					message(color.YELLOW, "You stop regenerating!")
				else
					increase_mana(-mana_amt)
				end
			end

			-- Absorbtion
			if dball_data.chi_absorbtion_setting > 0 then
				mana_amt = (dball_data.chi_absorbtion_setting * ndbyz / 10)
				if player.csp() - mana_amt < 0 then
					dball_data.chi_absorbtion_setting = 0
					message(color.YELLOW, "Your aura weakens!")
				else
					increase_mana(-mana_amt)
				end
			end

		-- end

		-- Return zero. We're handling all regen/drain effects
		return 0
	end
}

function player.csp(val)
	if val then counter.set(counter.MANA, val * 1000) end
	return counter.get(counter.MANA)
end
function player.msp(val)
	return counter.max(counter.MANA, val)
end

-- modify mana
-- returns true if there is a pb
function increase_mana(amt)
	counter.inc(counter.MANA, amt)
	return false
end
