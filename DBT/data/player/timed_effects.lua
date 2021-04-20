-- Timed effects for Dragonball T

timed_effect.create
{
	name = "ROBBED"
	desc = "Robbed"
	type = "physical"
	status = "detrimental"
	parameters = { {"power",0} }
--	redraw = FLAG_PR_CUT
	on_gain = "Well, that wasn't so bad."
	on_lose = "You suddenly realize all your money is gone!"
	on_timeout = function()
		player.au = 0
		player.redraw[FLAG_PR_BASIC] = true
	end
}

-- When cut, people start to bleed, bleeding is bad for their health
-- it may lead to dangerous conditions, even death
timed_effect.create
{
	name = "CUT"
	desc = "Bleeding"
	type = "physical"
	status = "detrimental"
	parameters = { {"power",0} }
	redraw = FLAG_PR_CUT
	on_gain = "You start to bleed."
	on_lose = "You stop bleeding."
	on_timeout = function()
		local power = min(40, max(1, timed_effect.get() / 10)) * timed_effect.get("power")
		if power > 2 then
			power = power / 2
		end
		take_hit(power, "bleeding")
	end
}

-- Poison is nasty,
-- it may lead to dangerous conditions, even death
timed_effect.create
{
	name = "POISON"
	desc = "Poisoned"
	type = "physical"
	status = "detrimental"
	parameters = { {"power",0} }
	redraw = FLAG_PR_POISONED
	on_gain = "You are poisoned!"
	on_lose = "You are no longer poisoned."
	on_timeout = function()
		local power = min(40, max(1, timed_effect.get() / 10)) * timed_effect.get("power")
		take_hit(power, "poison")
	end
}

-- Stuns make it harder to move around and to cast spells
timed_effect.create
{
	name = "STUN"
	desc = "Stunned"
	type = "physical"
	status = "detrimental"
	parameters = { {"power",0} }
	redraw = FLAG_PR_STUN
	on_gain = "You have been stunned."
	on_lose = "You are no longer stunned."
	on_timeout = function()
		-- Each turn we must recompute speed bonus
		-- This is slow, if this is too slow, other stun speed reducing
		-- technics will need to be found
		player.update = player.update | PU_BONUS
	end
	bonus = function()
		local power = min(20, max(1, timed_effect.get() / 10)) * timed_effect.get("power")
		player.inc_speed(SPEED_WALK, -power)
		player.inc_intrinsic(FLAG_SPELL_FAILURE, power)
	end
}

-- Blind make it harder to see things
timed_effect.create
{
	name = "BLIND"
	desc = "Blind"
	type = "physical"
	status = "detrimental"
	parameters = {}
	redraw = FLAG_PR_BLIND
	on_gain = "You are blind!"
	on_lose = "You can see again."
	bonus = function()
		player.set_intrinsic(FLAG_BLIND, true)
	end
}

-- Confused makes you .. confused
timed_effect.create
{
	name = "CONFUSED"
	desc = "Confused"
	type = "mental"
	status = "detrimental"
	parameters = {}
	redraw = FLAG_PR_CONFUSED
	on_gain = "You are confused!"
	on_lose = "You feel less confused now."
	bonus = function()
		player.set_intrinsic(FLAG_CONFUSED, true)
	end
}

-- Hallucinate makes you .. hallucinate
timed_effect.create
{
	name = "HALLUCINATE"
	desc = "Hallucinating"
	type = "mental"
	status = "detrimental"
	parameters = {}
	redraw = FLAG_PR_CONFUSED
	on_gain = "Oh, wow! Everything looks so cosmic now!"
	on_lose = "You can see clearly again."
	bonus = function()
		player.set_intrinsic(FLAG_HALLUCINATE, true)
		player.redraw[FLAG_PR_MAP] = 1
		player.update = player.update | PU_MONSTERS
		player.window = player.window | PW_OVERHEAD | PW_M_LIST
	end
}

-- Afraid makes you scared
timed_effect.create
{
	name = "AFRAID"
	desc = "Scared"
	type = "mental"
	status = "detrimental"
	parameters = {}
	redraw = FLAG_PR_AFRAID
	on_gain = "You are terrified!"
	on_lose = "You feel bolder now."
	bonus = function()
		player.set_intrinsic(FLAG_FEAR, true)
	end
}

-- Paralyzed makes lose turns
timed_effect.create
{
	name = "PARALYZED"
	desc = "Paralyzed"
	type = "physical"
	status = "detrimental"
	parameters = {}
	redraw = FLAG_PR_STATE
	on_gain = "You are paralyzed!"
	on_lose = "You can move again."
	bonus = function()
		player.set_intrinsic(FLAG_PARALYZED, true)
	end
}

-- When invisibile, monsters have an harder time seeing you
-- But "wraith" like monsters(invisibile ones) see you easily
-- and you are more vulnerable to them
timed_effect.create
{
	name = "INVISIBILITY"
	desc = "Invisible"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "Your body fades away!"
	on_lose = "Your body is once again visible."
	bonus = function()
		player.inc_intrinsic(FLAG_INVIS, timed_effect.get("power"))
	end
}

-- Allows you to see invisible things
timed_effect.create
{
	name = "SEE_INVISIBILITY"
	desc = "Invisible detection"
	type = "magical"
	status = "beneficial"
	parameters = {}
	on_gain = "Your eyes seem much more perceptive."
	on_lose = "Your eyes get back to their normal sensory level."
	bonus = function()
		player.set_intrinsic(FLAG_SEE_INVIS, true)
	end
}

-- Speed up
timed_effect.create
{
	name = "FAST"
	desc = "Fast"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "You feel yourself moving faster!"
	on_lose = "You feel yourself slow down."
	bonus = function()
		player.inc_speed(timed_effect.get("power"))
	end
}

-- Speed down
timed_effect.create
{
	name = "SLOW"
	desc = "Slowed"
	type = "magical"
	status = "detrimental"
	parameters = { {"power",0} }
	on_gain = "You feel yourself moving slower!"
	on_lose = "You feel yourself speed up."
	bonus = function()
		player.inc_speed(-timed_effect.get("power"))
	end
}

-- Timed projection melee damage
timed_effect.create
{
	name = "MELEE_PROJECT"
	desc = "Imbue weapon"
	type = "magical"
	status = "beneficial"
	parameters = { {"type",0}, {"dam",0}, {"rad",0}, {"flags",0} }
	on_gain = "Your weapon starts glowing."
	on_lose = "Your weapon stops glowing."
}

-- Timed projection archery damage
timed_effect.create
{
	name = "ARCHERY_PROJECT"
	desc = "Imbue bow"
	type = "magical"
	status = "beneficial"
	parameters = { {"type",0}, {"dam",0}, {"rad",0}, {"flags",0} }
	on_gain = "Your missile thrower starts glowing."
	on_lose = "Your missile thrower stops glowing."
}

-- Probability travel
timed_effect.create
{
	name = "PROB_TRAVEL"
	desc = "Probability travel"
	type = "magical"
	status = "beneficial"
	parameters = {}
	on_gain = "Your body destabilizes!",
	on_lose = "Your body grows stable again.",
	bonus = function()
		player.set_intrinsic(FLAG_PROB_TRAVEL_UPDOWN)
		player.set_intrinsic(FLAG_PROB_TRAVEL_WALLS)
	end
}

-- Setup a damaging aura on the player
timed_effect.create
{
	name = "AURA"
	desc = "Aura"
	type = "magical"
	status = "beneficial"
	parameters = { {"type",0}, {"dam",0} }
	on_gain = "A magical aura erects around you!"
	on_lose = "The magical aura surrounding you collapses."
}

-- Speed up
timed_effect.create
{
	name = "FLY"
	desc = "Fly"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "You feel like you can fly!"
	on_lose = "You no longer feel like you can fly."
	bonus = function()
		player.add_intrinsic_higher(FLAG_CAN_FLY, timed_effect.get("power"))
	end
}

timed_effect.create
{
	name = "ZHENG"
	desc = "Zheng Gu Shui"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "Your feel your body's natural healing process strengthen"
	on_lose = "The zheng gu shui has been fully absorbed"
	bonus = function()
		player.inc_intrinsic(FLAG_REGEN_LIFE, 3000)
	end
}

timed_effect.create
{
	name = "BODY_OIL"
	desc = "Body Oil"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "You rub oil over yourself"
	on_lose = "The oil seems to have mostly rubbed off"
	bonus = function()
		-- None needed. timed_effect state checked by monster attacks
	end
}

timed_effect.create
{
	name = "LIFE_REGEN"
	desc = "Regeneration"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "Your body regeneration abilities greatly increase!"
	on_lose = "Your body regeneration abilities becomes normal again."
	bonus = function()
		player.inc_intrinsic(FLAG_REGEN_LIFE, timed_effect.get("power"))
	end
}

timed_effect.create
{
	name = "MANA_REGEN"
	desc = "Manaflow"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "Your body pulses with power!"
	on_lose = "Your body no longer pulses with power."
	bonus = function()
		player.inc_intrinsic(FLAG_REGEN_MANA, timed_effect.get("power"))
	end
}

-- Increase AC
timed_effect.create
{
	name = "ARMOR"
	desc = "Magical Armour"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "Your skin turns to stone!"
	on_lose = "Your skin reverts to normal state."
	bonus = function()
		player.to_a = player.to_a + timed_effect.get("power")
		player.dis_to_a = player.dis_to_a + timed_effect.get("power")
	end
}

-- Increase Str
timed_effect.create
{
	name = "STRENGTH"
	desc = "Strength"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "You feel superhumanly strong!"
	on_lose = "Your normal strength returns."
	bonus = function()
		--player.stat_add[0] = player.stat_add[0] + timed_effect.get("power")
		player.modify_stat(A_STR, timed_effect.get("power"))
	end
}
-- Increase Con
timed_effect.create
{
	name = "CONSTITUTION"
	desc = "Constitution"
	type = "magical"
	status = "beneficial"
	parameters = { {"power",0} }
	on_gain = "You feel poweful!"
	on_lose = "Your feel less powerful."
	bonus = function()
		player.stat_add[4] = player.stat_add[4] + timed_effect.get("power")
	end
}

-- Absorb souls into health
timed_effect.create
{
	name = "ABSORB_SOUL"
	desc = "Absorb Soul"
	type = "magical"
	status = "beneficial"
	parameters = { {"chance",0} }
	on_gain = "#DYou start absorbing souls of your foes."
	on_lose = "#DYou stop absorbing souls of dead foes."
}
