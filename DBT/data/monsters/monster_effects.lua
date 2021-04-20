--------------------------------------------------------------------------
------------------------ Monster timed effects ---------------------------
--------------------------------------------------------------------------

-- When cut, people start to bleed, bleeding is bad for their health
-- it may lead to dangerous conditions, even death
monster_effect.create
{
	name = "CUT"
	desc = "Bleeding"
	type = "physical"
	status = "detrimental"
	on_gain = "%s starts to bleed."
	on_lose = "%s stops bleeding."
	on_timeout = function(m_idx, monst, count, power)
		power = min(40, max(1, count / 10)) * power
		mon_take_hit(m_idx, power, 0, " bleeds to death.")
	end
}

-- Poison is nasty,
-- it may lead to dangerous conditions, even death
monster_effect.create
{
	name = "POISON"
	desc = "Poisoned"
	type = "physical"
	status = "detrimental"
	on_gain = "%s is poisoned!"
	on_lose = "%s is no longer poisoned."
	on_timeout = function(m_idx, monst, count, power)
		power = min(40, max(1, count / 10)) * power
		mon_take_hit(m_idx, power, 0, " dies of poison.")
	end
}

-- Stuns make it harder to move around and to cast spells
monster_effect.create
{
	name = "STUN"
	desc = "Stunned"
	type = "physical"
	status = "detrimental"
	on_gain = "%s is stunned."
	on_lose = "%s is no longer stunned."
	on_timeout = function(m_idx, monst, count, power)
		power = min(50, max(1, count / 5)) * min(40, power * 10)
		monst.energy = monst.energy - ((get_monster_energy(monst, SPEED_GLOBAL) * power) / 100)
	end
}

-- Slow is .. really not fast
monster_effect.create
{
	name = "SLOW"
	desc = "Slowed"
	type = "magical"
	status = "detrimental"
	on_gain = "%s is slowed down."
	on_lose = "%s is no longer slwoed down."
	on_timeout = function(m_idx, monst, count, power)
		message("Implement monster slow!")
	end
}

-- Blind make it harder to see things
monster_effect.create
{
	name = "BLIND"
	desc = "Blind"
	type = "physical"
	status = "detrimental"
	on_gain = "%s is blinded!"
	on_lose = "%s can see again."
	on_timeout = function(m_idx, monst, count, power)
		message("Implement monster blind!")
	end
}

-- Confused makes you .. confused
monster_effect.create
{
	name = "CONFUSED"
	desc = "Confused"
	type = "mental"
	status = "detrimental"
	on_gain = "%s is confused!"
	on_lose = "%s is less confused now."
	on_timeout = function(m_idx, monst, count, power)
		message("Implement monster conf!")
	end
}
