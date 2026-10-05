newTalentType{ type="chi/chi", name = "chi", description = "Spiritual energies taught by a master." }

newTalent{
	name = "Chi Burst",
	short_name = "CHI_BURST",
	type = {"chi/chi", 1},
	mode = "activated",
	points = 1,
	range = 20,
	no_energy = true,
	action = function(self, t)
		self:chiBurstPrompt(t)
		return nil
	end,
	info = function(self, t)
		local per = math.max(1, math.floor((self:skillLevel("chi_offense") or 0) / 5))
		return ("Hurl a bolt of chi. Each point you spend rolls 1 to %d damage. The bolt is a * ."):format(per)
	end,
}

local function known(self, ability)
	return self:hasAbility(ability) and (self:skillLevel("chi") or 0) >= 1
end

newTalent{
	name = "Light Aura",
	short_name = "CHI_LIGHT",
	type = {"chi/chi", 1},
	mode = "activated",
	points = 1,
	no_energy = true,
	action = function(self, t)
		if not known(self, "light") then game.log("You don't know how to light your aura.") return nil end
		self.chi_light = ((self.chi_light or 0) + 1) % 21
		self:updateChi()
		game.log("Light aura: %s.", self.chi_light == 0 and "off" or ("radius " .. self.chi_light))
		return nil
	end,
	info = function(self, t)
		return "Raise the light around you by one, up to 20. The next use after 20 turns it off. Press m to lower it."
	end,
}

newTalent{
	name = "Battle Aura",
	short_name = "CHI_AURA",
	type = {"chi/chi", 1},
	mode = "sustained",
	points = 1,
	no_energy = true,
	activate = function(self, t)
		if not known(self, "aura") then game.log("You don't know battle aura.") return nil end
		self.chi_aura = 1
		game.log("Your battle aura ignites. Chi Offense adds to your melee.")
		return {}
	end,
	deactivate = function(self, t)
		self.chi_aura = 0
		self.chi_absorb = 0
		game.log("Your aura fades.")
		return true
	end,
	info = function(self, t)
		return "While this burns, Chi Offense is added to melee to-hit and damage. It drains chi every turn."
	end,
}

newTalent{
	name = "Haste",
	short_name = "CHI_HASTE",
	type = {"chi/chi", 1},
	mode = "activated",
	points = 1,
	no_energy = true,
	action = function(self, t)
		if not known(self, "haste") then game.log("You don't know haste.") return nil end
		self.chi_haste = math.min(20, (self.chi_haste or 0) + 1)
		self:applyStatEffects()
		game.log("Haste %+d speed.", self.chi_haste)
		return nil
	end,
	info = function(self, t)
		return "Each use adds 1 speed, up to 20. Press m to lower it. It drains chi every turn."
	end,
}

newTalent{
	name = "Flight",
	short_name = "CHI_FLIGHT",
	type = {"chi/chi", 1},
	mode = "sustained",
	points = 1,
	no_energy = true,
	activate = function(self, t)
		if not known(self, "flight") then game.log("You don't know flight.") return nil end
		self.chi_flight = 1
		game.log("You rise into the air.")
		return {}
	end,
	deactivate = function(self, t)
		self.chi_flight = 0
		game.log("You settle to the ground.")
		return true
	end,
	info = function(self, t)
		return "Stay aloft, draining chi. Walls still stop you."
	end,
}

newTalent{
	name = "Physical Regeneration",
	short_name = "CHI_REGEN",
	type = {"chi/chi", 1},
	mode = "activated",
	points = 1,
	no_energy = true,
	action = function(self, t)
		if not known(self, "regeneration") then game.log("You don't know regeneration.") return nil end
		self.chi_regen_hp = math.min(20, (self.chi_regen_hp or 0) + 1)
		game.log("Regeneration %+d life per turn.", self.chi_regen_hp)
		return nil
	end,
	info = function(self, t)
		return "Each use heals 1 more life per turn, up to 20. Press m to lower it."
	end,
}

newTalent{
	name = "Damage Absorption",
	short_name = "CHI_ABSORB",
	type = {"chi/chi", 1},
	mode = "activated",
	points = 1,
	no_energy = true,
	action = function(self, t)
		if not known(self, "absorbtion") then game.log("You don't know absorption.") return nil end
		if (self.chi_aura or 0) ~= 1 then game.log("Absorption needs your battle aura.") return nil end
		self.chi_absorb = math.min(20, (self.chi_absorb or 0) + 1)
		game.log("Absorption %+d.", self.chi_absorb)
		return nil
	end,
	info = function(self, t)
		return "While your battle aura is up, each point subtracts from a hit. Press m to lower it."
	end,
}
