-- ToME - Tales of Middle-Earth
-- Copyright (C) 2009 - 2019 Nicolas Casalini
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

require "engine.class"
require "engine.Actor"
require "engine.Autolevel"
require "engine.interface.ActorTemporaryEffects"
require "engine.interface.ActorLife"
require "engine.interface.ActorProject"
require "engine.interface.ActorLevel"
require "engine.interface.ActorStats"
require "engine.interface.ActorTalents"
require "engine.interface.ActorResource"
require "engine.interface.ActorFOV"
require "mod.class.interface.Combat"
local Map = require "engine.Map"
local ActorInventory = require "engine.interface.ActorInventory"

-- wornInven() looks these ids up on the engine inventory class, not on the actor.
local WORN_SLOTS = {
	{"WIELD", "In hand", "Weapons you are holding."},
	{"BODY", "On body", "Clothes and armor."},
	{"OUTER", "Over clothes", "A coat or cloak."},
	{"HANDS", "On hands", "Gloves."},
	{"ARMS", "On arms", "Arm wraps."},
	{"TOOL", "Tool", "A carried tool."},
	{"RING", "On finger", "Rings."},
	{"HEAD", "On head", "Hats and helmets."},
	{"WRIST", "On wrist", "Watches and bracers."},
	{"FEET", "On feet", "Shoes."},
	{"VEHICLE", "Vehicle", "A vehicle."},
	{"BACKPACK", "Backpack", "A pack worn on the back."},
}
for _, slot in ipairs(WORN_SLOTS) do
	ActorInventory:defineInventory(slot[1], slot[2], true, slot[3], true)
end

module(..., package.seeall, class.inherit(
	engine.Actor,
	engine.interface.ActorTemporaryEffects,
	engine.interface.ActorLife,
	engine.interface.ActorProject,
	engine.interface.ActorLevel,
	engine.interface.ActorStats,
	engine.interface.ActorTalents,
	engine.interface.ActorResource,
	engine.interface.ActorFOV,
	engine.interface.ActorInventory,
	mod.class.interface.Combat
))

function _M:bodySlots()
	return {
		INVEN = 23,
		WIELD = 2,
		BODY = 1,
		OUTER = 1,
		HANDS = 1,
		ARMS = 1,
		TOOL = 1,
		RING = 2,
		HEAD = 1,
		WRIST = 1,
		FEET = 1,
		VEHICLE = 1,
		BACKPACK = 1,
	}
end

function _M:init(t, no_default)
	-- Define some basic combat stats
	self.combat_armor = 0

	-- Default regen. Monsters do not heal unless the race says so.
	t.power_regen = t.power_regen or 1
	if t.player then
		t.life_regen = t.life_regen or 0.25
	else
		t.life_regen = t.life_regen or 0
	end

	-- Default melee barehanded damage
	self.combat = { dam=1 }

	engine.Actor.init(self, t, no_default)
	engine.interface.ActorTemporaryEffects.init(self, t)
	engine.interface.ActorLife.init(self, t)
	engine.interface.ActorProject.init(self, t)
	engine.interface.ActorTalents.init(self, t)
	engine.interface.ActorResource.init(self, t)
	engine.interface.ActorStats.init(self, t)
	engine.interface.ActorLevel.init(self, t)
	engine.interface.ActorFOV.init(self, t)
	self.body = self:bodySlots()
	engine.interface.ActorInventory.init(self, t)
	self:applyStatEffects()
end

--- Saves from before these stats existed are missing the later ids.
function _M:ensureStats()
	if not self.stats or not self.inc_stats then return end
	local defs = require("engine.interface.ActorStats").stats_def
	for i, s in ipairs(defs) do
		if not self.stats[i] then self.stats[i] = s.def end
		if not self.inc_stats[i] then self.inc_stats[i] = 0 end
	end
end

local STAT_SKILL = {
	str = "strength", int = "intelligence", wil = "willpower", dex = "dexterity",
	con = "constitution", chr = "charisma", spd = "speed",
}

--- Base is the stat. Gear is worn bonuses. Skill is the trained stat skill. Result is what the game uses.
function _M:statParts(short)
	self:ensureStats()
	local base = self:getStat(short, nil, nil, true)
	local gear = self:getStat(short) - base
	local ego = self.wornStat and self:wornStat(short) or 0
	local skill = 0
	if self.skillLevel and STAT_SKILL[short] then skill = self:skillLevel(STAT_SKILL[short]) end
	return base, gear + ego, skill, base + gear + ego + skill
end

function _M:effStat(short)
	local _, _, _, total = self:statParts(short)
	return total
end

--- Every worn object, including both hands.
function _M:eachWorn(fn)
	if not self.getInven then return end
	for _, slot in ipairs({"WIELD", "BODY", "OUTER", "HANDS", "ARMS", "TOOL", "HEAD", "WRIST", "FEET", "RING", "BACKPACK", "VEHICLE"}) do
		local inv = self:getInven(slot)
		if inv then
			for _, o in ipairs(inv) do
				if o then fn(o) end
			end
		end
	end
end

function _M:wornStat(short)
	local n = 0
	self:eachWorn(function(o)
		if o.dbt_stats and o.dbt_stats[short] then n = n + o.dbt_stats[short] end
	end)
	return n
end

function _M:wornArmorBonus()
	local n = 0
	self:eachWorn(function(o) n = n + (o.dbt_to_a or 0) end)
	return n
end

--- Percent resist from worn egos. 10 means one tenth of that damage is ignored.
function _M:resistDamage(effect, dam)
	local kind
	if effect == "COLD" then kind = "cold"
	elseif effect == "SLASH" or effect == "CUT" then kind = "slash"
	end
	if not kind then return dam end
	local resist = 0
	self:eachWorn(function(o)
		if o.dbt_resist and o.dbt_resist[kind] then resist = resist + o.dbt_resist[kind] end
	end)
	if resist <= 0 then return dam end
	if resist > 100 then resist = 100 end
	return math.floor(dam * (100 - resist) / 100)
end

--- Armor is worn armor, plus Dexterity minus 10, plus twice Dodging. A vehicle keeps only a Dexterity penalty.
function _M:armorClass()
	local gear = (self.combat_armor or 0) + self:wornArmorBonus()
	if not self.player then return gear end
	local vehicle = self.getInven and self:getInven("VEHICLE")
	local riding = vehicle and vehicle[1]
	local dex = self:effStat("dex") - 10
	local dodge = self.skillLevel and self:skillLevel("dodge") or 0
	if riding then
		if dex < 0 then return gear + dex end
		return gear
	end
	local ac = gear + dex + (dodge * 2)
	if self.hasAbility and self:hasAbility("blocking") and self.handKind then
		local empty = 0
		for i = 1, 2 do
			if self:handKind(self:hand(i)) == "empty" then empty = empty + 1 end
		end
		local hands = self:skillLevel("hand")
		if empty == 2 and self:hasAbility("double_attack") then ac = ac + hands + hands
		elseif empty >= 1 then ac = ac + hands end
	end
	if self.handKind then
		for i = 1, 2 do
			if self:handKind(self:hand(i)) == "weapon" then
				ac = ac + self:skillLevel("parrying")
				break
			end
		end
	end
	return ac
end

--- Life is Constitution times level. Speed 10 is a normal turn.
function _M:applyStatEffects(fill)
	self:ensureStats()
	if not self.player then
		local bonus = self.dbt_speed or 0
		self.global_speed = math.max(0.1, (110 + bonus) / 110)
		return
	end
	local spd = (self.effStat and self:effStat("spd") or (self.getSpd and self:getSpd() or 10)) + (self.chi_haste or 0)
	self.global_speed = math.max(0.1, (100 + spd) / 110)
	local level = math.max(1, self.level or 1)
	local max = math.max(1, (self:effStat("con") or 10) * level)
	if fill or not self.max_life or self.max_life <= 0 then
		self.life = max
	else
		local ratio = self.life / self.max_life
		self.life = math.max(0, math.min(max, math.floor(max * ratio + 0.5)))
	end
	self.max_life = max
	if self.player and self.updateChi then self:updateChi() end
end

function _M:onWear(o, inven_id)
	engine.interface.ActorInventory.onWear(self, o, inven_id)
	if self.applyStatEffects then self:applyStatEffects() end
end

function _M:onTakeoff(o, inven_id)
	engine.interface.ActorInventory.onTakeoff(self, o, inven_id)
	if self.applyStatEffects then self:applyStatEffects() end
end

function _M:startingZeni()
	local c = self.getChr and self:getChr() or 10
	if c < 9 then return c * 50
	elseif c == 9 then return 500
	elseif c == 10 then return 600
	elseif c == 11 then return 800
	elseif c == 12 then return 1000
	elseif c == 13 then return 1500
	elseif c == 14 then return 2500
	else return c * 200 end
end

--- Smaller is a better price. Charisma 10 is full price.
function _M:priceFactor()
	local c = self.effStat and self:effStat("chr") or (self.getChr and self:getChr() or 10)
	if c < 10 then return 100 - ((c - 10) * 5) end
	return 100 + (10 - c)
end

function _M:ensureInventory()
	if self.inven then return end
	self.body = self:bodySlots()
	self:initBody()
end

-- Return a reason to refuse. High heels are the only sex-locked birth item.
function _M:canWearObjectCustom(o)
	if o.female_only and not self.female then
		return "made for women"
	end
end

function _M:act()
	if not engine.Actor.act(self) then return end

	self.changed = true

	-- Cooldown talents
	self:cooldownTalents()
	if self.chiTick then self:chiTick() end
	-- Regen resources
	self:regenLife()
	self:regenResources()
	-- Compute timed effects
	self:timedEffects()

	-- Still enough energy to act ?
	if self.energy.value < game.energy_to_act then return false end

	return true
end

function _M:move(x, y, force)
	local moved = false
	local ox, oy = self.x, self.y
	if force or self:enoughEnergy() then
		moved = engine.Actor.move(self, x, y, force)
		if not force and moved and (self.x ~= ox or self.y ~= oy) and not self.did_energy then self:useEnergy() end
	end
	self.did_energy = nil
	return moved
end

function _M:tooltip()
	return ([[%s%s
#00ffff#Level: %d
#ff0000#HP: %d (%d%%)
Str %d  Int %d  Wil %d  Dex %d  Con %d  Chr %d  Spd %d
%s]]):format(
	self:getDisplayString(),
	self.name,
	self.level,
	self.life, self.life * 100 / self.max_life,
	self:getStr(),
	self:getInt(),
	self:getWil(),
	self:getDex(),
	self:getCon(),
	self:getChr(),
	self:getSpd(),
	self.desc or ""
	)
end

function _M:onTakeHit(value, src)
	if self.player and (self.chi_absorb or 0) > 0 then
		value = math.max(0, value - self.chi_absorb)
	end
	return value
end

function _M:die(src)
	local x, y = self.x, self.y
	if self.dbt_tourny_fighter and game and game.onTournamentWin then game:onTournamentWin(self) end
	if game and game.onDuelDeath then game:onDuelDeath(self) end
	if game and game.dropLoot then game:dropLoot(self, x, y) end
	if src and src.player and game and game.noteKill then game:noteKill(self, src) end
	engine.interface.ActorLife.die(self, src)

	-- Gives the killer some exp for the kill
	if src and src.gainExp then
		src:gainExp(self:worthExp(src))
	end

	return true
end

function _M:levelup()
	if self.player then
		self:applyStatEffects(true)
	else
		self.max_life = self.max_life + 2
		self.life = self.max_life
	end

	self:incMaxPower(3)
	self.power = self.max_power
end

--- Notifies a change of stat value
function _M:onStatChange(stat, v)
	if stat == self.STAT_CON or stat == self.STAT_SPD then
		self:applyStatEffects()
	end
end

--- The engine calls block_move(x, y, mover, act, couldpass). A passability check does not attack.
function _M:block_move(x, y, e, act, couldpass)
	if couldpass then return false end
	if type(e) == "table" and e ~= self and act and e.attack then
		if e.player and e.bumpCreature then
			e:bumpCreature(self)
		elseif not e.player then
			e:attack(self)
		end
	end
	return true
end

function _M:attack(target)
	self:bumpInto(target)
end


--- Called before a talent is used
-- Check the actor can cast it
-- @param ab the talent (not the id, the table)
-- @return true to continue, false to stop
function _M:preUseTalent(ab, silent)
	if not self:enoughEnergy() then print("fail energy") return false end

	if ab.mode == "sustained" then
		if ab.sustain_power and self.max_power < ab.sustain_power and not self:isTalentActive(ab.id) then
			game.logPlayer(self, "You do not have enough power to activate %s.", ab.name)
			return false
		end
	else
		if ab.power and self:getPower() < ab.power then
			game.logPlayer(self, "You do not have enough power to cast %s.", ab.name)
			return false
		end
	end

	if not silent then
		-- Allow for silent talents
		if ab.message ~= nil then
			if ab.message then
				game.logSeen(self, "%s", self:useTalentMessage(ab))
			end
		elseif ab.mode == "sustained" and not self:isTalentActive(ab.id) then
			game.logSeen(self, "%s activates %s.", self.name:capitalize(), ab.name)
		elseif ab.mode == "sustained" and self:isTalentActive(ab.id) then
			game.logSeen(self, "%s deactivates %s.", self.name:capitalize(), ab.name)
		else
			game.logSeen(self, "%s uses %s.", self.name:capitalize(), ab.name)
		end
	end
	return true
end

--- Called before a talent is used
-- Check if it must use a turn, mana, stamina, ...
-- @param ab the talent (not the id, the table)
-- @param ret the return of the talent action
-- @return true to continue, false to stop
function _M:postUseTalent(ab, ret)
	if not ret then return end

	self:useEnergy()

	if ab.mode == "sustained" then
		if not self:isTalentActive(ab.id) then
			if ab.sustain_power then
				self.max_power = self.max_power - ab.sustain_power
			end
		else
			if ab.sustain_power then
				self.max_power = self.max_power + ab.sustain_power
			end
		end
	else
		if ab.power then
			self:incPower(-ab.power)
		end
	end

	return true
end

--- Return the full description of a talent
-- You may overload it to add more data (like power usage, ...)
function _M:getTalentFullDescription(t)
	local d = {}

	if t.mode == "passive" then d[#d+1] = "#6fff83#Use mode: #00FF00#Passive"
	elseif t.mode == "sustained" then d[#d+1] = "#6fff83#Use mode: #00FF00#Sustained"
	else d[#d+1] = "#6fff83#Use mode: #00FF00#Activated"
	end

	if t.power or t.sustain_power then d[#d+1] = "#6fff83#Power cost: #7fffd4#"..(t.power or t.sustain_power) end
	if self:getTalentRange(t) > 1 then d[#d+1] = "#6fff83#Range: #FFFFFF#"..self:getTalentRange(t)
	else d[#d+1] = "#6fff83#Range: #FFFFFF#melee/personal"
	end
	if t.cooldown then d[#d+1] = "#6fff83#Cooldown: #FFFFFF#"..t.cooldown end

	return table.concat(d, "\n").."\n#6fff83#Description: #FFFFFF#"..t.info(self, t)
end

--- How much experience is this actor worth
-- @param target to whom is the exp rewarded
-- @return the experience rewarded
function _M:worthExp(target)
	if not target.level or self.level < target.level - 3 then return 0 end

	local mult = 2
	if self.unique then mult = 6
	elseif self.egoed then mult = 3 end
	return self.level * mult * self.exp_worth
end

--- Can the actor see the target actor
-- This does not check LOS or such, only the actual ability to see it.<br/>
-- Check for telepathy, invisibility, stealth, ...
function _M:canSee(actor, def, def_pct)
	if not actor then return false, 0 end

	-- Check for stealth. Checks against the target cunning and level
	if actor:attr("stealth") and actor ~= self then
		local def = self.level / 2 + self:getCun(25)
		local hit, chance = self:checkHit(def, actor:attr("stealth") + (actor:attr("inc_stealth") or 0), 0, 100)
		if not hit then
			return false, chance
		end
	end

	if def ~= nil then
		return def, def_pct
	else
		return true, 100
	end
end

--- Can the target be applied some effects
-- @param what a string describing what is being tried
function _M:canBe(what)
	if what == "poison" and rng.percent(100 * (self:attr("poison_immune") or 0)) then return false end
	if what == "cut" and rng.percent(100 * (self:attr("cut_immune") or 0)) then return false end
	if what == "confusion" and rng.percent(100 * (self:attr("confusion_immune") or 0)) then return false end
	if what == "blind" and rng.percent(100 * (self:attr("blind_immune") or 0)) then return false end
	if what == "stun" and rng.percent(100 * (self:attr("stun_immune") or 0)) then return false end
	if what == "fear" and rng.percent(100 * (self:attr("fear_immune") or 0)) then return false end
	if what == "knockback" and rng.percent(100 * (self:attr("knockback_immune") or 0)) then return false end
	if what == "instakill" and rng.percent(100 * (self:attr("instakill_immune") or 0)) then return false end
	return true
end

function _M:takeQuest(id, status)
	self:ensureQuests()
	if game and game.loadTraining then game:loadTraining() end
	status = status or "taken"
	if status == "untaken" then
		self.quests[id] = nil
		return nil
	end
	local cat = dbt_quest_by_id and dbt_quest_by_id[id]
	local q = self.quests[id]
	if not q then
		self.quests[id] = {
			name = (cat and cat.name) or id,
			desc = (cat and cat.desc) or "",
			status = status,
		}
	else
		q.status = status
		if cat and (q.name == nil or q.name == id) then q.name = cat.name end
		if cat and (q.desc == nil or q.desc == "") then q.desc = cat.desc end
	end
	return self.quests[id]
end

function _M:ensureQuests()
	self.quests = self.quests or {}
	self.uranai_state = self.uranai_state or 0
	self.rosshi_uranai_apology = self.rosshi_uranai_apology or 0
	self.schools_closed = self.schools_closed or {}
	self.fled = self.fled or {}
	self.trainers = self.trainers or {}
	if self.player and not self.quests.choose_style then
		self.quests.choose_style = {
			name = "Choose a Style",
			desc = "You should pick a school to learn martial arts at.",
			status = "taken",
		}
	end
	if self.player then
		if self.tourny_registered == nil then self.tourny_registered = 0 end
		if self.tourny_round == nil then self.tourny_round = 0 end
		self.tourny_fought = self.tourny_fought or {}
		if not self.quests.tournament then
			self.quests.tournament = {
				name = "The 22nd Annual World Tournament",
				desc = "The World Tournament is an annual gathering of martial artists from across the world to see who is the best of the best! Since you were little, you've always fantasized about winning, and now is your chance! Make us proud!",
				status = "taken",
			}
		end
	end
end

-- Skills are thousandths, the same scale as ToME 3: 1000 is 1.0.
function _M:ensureSkills()
	self.skills = self.skills or {}
	self.abilities = self.abilities or {}
	self.enrollments = self.enrollments or {}
	if self.player and self.skill_points == nil then self.skill_points = 5 end
	if dbt_skills then
		for _, s in ipairs(dbt_skills) do
			if self.skills[s.id] == nil then self.skills[s.id] = 0 end
		end
	end
end

function _M:skillValue(id)
	self:ensureSkills()
	return self.skills[id] or 0
end

function _M:skillLevel(id)
	return math.floor(self:skillValue(id) / 1000)
end

function _M:skillText(thousandths)
	local v = thousandths or 0
	return ("%d.%d"):format(math.floor(v / 1000), math.floor((v % 1000) / 100))
end

function _M:hasAbility(id)
	return self.abilities and self.abilities[id] and true or false
end

function _M:meetsReq(req)
	self:ensureSkills()
	for _, c in ipairs(req or {}) do
		if c.kind == "enroll" and (self.enrollments[c.school] or 0) < c.n then return false end
		if c.kind == "skill" and self:skillValue(c.skill) < c.n then return false end
		if c.kind == "level" and (self.level or 1) < c.n then return false end
		if c.kind == "ability" and not self:hasAbility(c.ability) then return false end
		if c.kind == "stat" then
			local v = self.effStat and self:effStat(c.stat) or 0
			if v < c.n then return false end
		end
	end
	return true
end

function _M:trainClass(school_id, class)
	self:ensureSkills()
	local school = dbt_schools and dbt_schools[school_id]
	if not school or not class then return false, "This school is not teaching." end
	if not self:meetsReq(class.req) then
		if class.reqtxt and class.reqtxt ~= "" then return false, class.reqtxt end
		return false, "You don't meet the requirement."
	end
	if (self.skill_points or 0) < (class.skcost or 0) then
		return false, "You don't have enough skill points."
	end
	local zeni = school.cost or 0
	if class.type ~= "special" and (self.money or 0) < zeni then
		return false, ("You need %d zeni. You have %d."):format(zeni, self.money or 0)
	end
	if class.type == "ability" then
		if self:hasAbility(class.skill) then return false, "You already know that." end
	else
		local cap = class.cap or 0
		if game and game.classCap then cap = game:classCap(self, school_id, class) end
		if self:skillValue(class.skill) >= cap * 1000 then
			return false, "You are already at the cap for this class."
		end
	end
	self.skill_points = (self.skill_points or 0) - (class.skcost or 0)
	if class.type ~= "special" then self.money = (self.money or 0) - zeni end
	self.enrollments[school_id] = (self.enrollments[school_id] or 0) + 1
	if class.type == "ability" then
		self.abilities[class.skill] = true
	else
		self.skills[class.skill] = self:skillValue(class.skill) + (class.gain or 0)
	end
	if self.quests and self.quests.choose_style and self.quests.choose_style.status == "taken" then
		self.quests.choose_style.status = "finished"
	end
	if self.applyStatEffects then self:applyStatEffects() end
	if self.syncChiTalents then self:syncChiTalents() end
	return true
end

local CHI_TALENTS = {
	chi_burst = "T_CHI_BURST",
	light = "T_CHI_LIGHT",
	aura = "T_CHI_AURA",
	haste = "T_CHI_HASTE",
	flight = "T_CHI_FLIGHT",
	regeneration = "T_CHI_REGEN",
	absorbtion = "T_CHI_ABSORB",
}

function _M:ensureChi()
	if self.chi == nil then self.chi = 0 end
	if self.max_chi == nil then self.max_chi = 0 end
	if self.chi_regen == nil then self.chi_regen = 0 end
	self.chi_light = self.chi_light or 0
	self.chi_aura = self.chi_aura or 0
	self.chi_haste = self.chi_haste or 0
	self.chi_flight = self.chi_flight or 0
	self.chi_regen_hp = self.chi_regen_hp or 0
	self.chi_absorb = self.chi_absorb or 0
	if self.chi_burst_spend == nil then self.chi_burst_spend = 1 end
end

function _M:updateChi()
	self:ensureChi()
	if not self.player then return end
	local skill = self.skillLevel and self:skillLevel("chi") or 0
	if skill < 1 then
		self.max_chi = 0
		self.chi = 0
	else
		self.max_chi = skill * self:effStat("wil")
		if self.chi > self.max_chi then self.chi = self.max_chi end
		if self.chi < 0 then self.chi = 0 end
	end
	self.lite = self.chi_light or 0
	self.flying = (self.chi_flight or 0) == 1
end

function _M:chiEffectDrain(kind)
	self:ensureChi()
	local rate = 0
	if kind == "light" then rate = self.chi_light * 5
	elseif kind == "haste" then rate = self.chi_haste * 10
	elseif kind == "regen" then rate = self.chi_regen_hp * 10
	elseif kind == "absorb" then rate = self.chi_absorb * 5
	elseif kind == "flight" then rate = self.chi_flight == 1 and 25 or 0
	elseif kind == "aura" then rate = self.chi_aura == 1 and 25 or 0
	end
	local gung = self.skillLevel and self:skillLevel("chi_gung") or 0
	if gung > 1 and rate > 0 then rate = rate / gung end
	return rate
end

function _M:chiNaturalRegen()
	if not self.player or (self.max_chi or 0) <= 0 then return 0 end
	local regen = math.max(0.05, (self:skillLevel("chi_regeneration") or 0) * 0.2)
	if self:hasAbility("meditation") then regen = regen * 2 end
	return regen
end

function _M:chiPay(kind, message, clear)
	local cost = self:chiEffectDrain(kind)
	if cost <= 0 then return end
	if self.chi < cost then
		clear()
		if message then game.log(message) end
	else
		self.chi = self.chi - cost
	end
end

function _M:chiTick()
	if not self.player then return end
	self:updateChi()
	if self.max_chi <= 0 then
		self.chi_light, self.chi_aura, self.chi_haste = 0, 0, 0
		self.chi_flight, self.chi_regen_hp, self.chi_absorb = 0, 0, 0
		self.lite = 0
		return
	end
	self.chi = math.min(self.max_chi, self.chi + self:chiNaturalRegen())
	if self.chi_aura ~= 1 then self.chi_absorb = 0 end
	self:chiPay("flight", "You fall from the air!", function()
		self.chi_flight = 0
		self.flying = false
		if self.sustain_talents then self.sustain_talents[self.T_CHI_FLIGHT] = nil end
	end)
	self:chiPay("aura", "Your aura crumbles!", function()
		self.chi_aura = 0
		self.chi_absorb = 0
		if self.sustain_talents then self.sustain_talents[self.T_CHI_AURA] = nil end
	end)
	self:chiPay("haste", "You slow down!", function() self.chi_haste = 0 self:applyStatEffects() end)
	local heal = self.chi_regen_hp
	self:chiPay("regen", "You stop regenerating!", function() self.chi_regen_hp = 0 end)
	if self.chi_regen_hp > 0 and heal > 0 then
		self.life = math.min(self.max_life or self.life, (self.life or 0) + heal)
	end
	self:chiPay("absorb", "Your aura weakens!", function() self.chi_absorb = 0 end)
end

function _M:syncChiTalents()
	if not self.player or not self.learnTalent then return end
	self:ensureSkills()
	for ability, tid in pairs(CHI_TALENTS) do
		if self:hasAbility(ability) and not self:knowTalent(tid) then
			self:learnTalent(tid, true)
		end
	end
end

function _M:chiBurstPrompt(t)
	self:updateChi()
	if not self:hasAbility("chi_burst") or (self.max_chi or 0) < 1 then
		game.log("You don't know how to gather a chi burst.")
		return
	end
	local max_burst = math.floor(self.chi or 0)
	if max_burst < 1 then
		game.log("You haven't enough chi.")
		return
	end
	local per = math.max(1, math.floor(self:skillLevel("chi_offense") / 5))
	local spend = math.min(self.chi_burst_spend or 1, max_burst)
	local GetQuantity = require "engine.dialogs.GetQuantity"
	game:registerDialog(GetQuantity.new("Chi Burst", ("How much chi? Each point rolls 1 to %d"):format(per), spend, max_burst, function(qty)
		self:fireChiBurst(t, qty)
	end, 1))
end

function _M:fireChiBurst(t, qty)
	qty = math.floor(tonumber(qty) or 0)
	self:updateChi()
	if qty < 1 or (self.chi or 0) < qty then
		game.log("You haven't enough chi.")
		return
	end
	local tg = {type="bolt", range=20, talent=t, display={char="*", color=colors.LIGHT_BLUE}}
	local x, y = self:getTarget(tg)
	if not x or not y then return end
	local per = math.max(1, math.floor(self:skillLevel("chi_offense") / 5))
	local dam = rng.range(1, per * qty)
	self.chi = self.chi - qty
	self.chi_burst_spend = qty
	local DamageType = require "engine.DamageType"
	self:projectile(tg, x, y, DamageType.CHI, dam)
	self:useEnergy()
end
