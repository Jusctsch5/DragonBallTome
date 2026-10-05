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
local ActorAI = require "engine.interface.ActorAI"
local Faction = require "engine.Faction"
require "mod.class.Actor"

module(..., package.seeall, class.inherit(mod.class.Actor, engine.interface.ActorAI))

function _M:init(t, no_default)
	mod.class.Actor.init(self, t, no_default)
	-- A race with no faction is a bystander. Hostiles set faction to "enemies".
	if t.faction == nil then self.faction = "neutral" end
	ActorAI.init(self, t)
	if not self.can_talk and game and game.loadTraining then
		game:loadTraining()
		local talk = dbt_talks and (dbt_talks[self.define_as] or dbt_talks["RACE_" .. (self.define_as or "")])
		if talk then self.can_talk = talk end
	end
end

function _M:resolve(t, last, ...)
	mod.class.Actor.resolve(self, t, last, ...)
	if last and self.db_hd and not self.db_force_hp and not self.dbt_hp_rolled then
		local dice = self.db_hd[1] or 1
		local sides = math.max(1, self.db_hd[2] or 1)
		local hp = 0
		for _ = 1, dice do hp = hp + rng.range(1, sides) end
		self.max_life = math.max(1, hp)
		self.life = self.max_life
		self.dbt_hp_rolled = true
	end
end

function _M:act()
	if not mod.class.Actor.act(self) then return end
	if self.dbt_partied and game.player and not game.player.dead and self.x then
		local p = game.player
		local dx, dy = p.x - self.x, p.y - self.y
		local dist = math.max(math.abs(dx), math.abs(dy))
		if dist > 1 then
			local sx = dx == 0 and 0 or (dx > 0 and 1 or -1)
			local sy = dy == 0 and 0 or (dy > 0 and 1 or -1)
			self:move(self.x + sx, self.y + sy)
		end
		self:useEnergy()
		return
	end
	if (self.dbt_stun or 0) > 0 then
		self.dbt_stun = self.dbt_stun - 1
		game.logSeen(self, "%s is stunned.", (self.name or "It"):capitalize())
		self:useEnergy()
		return
	end
	self:computeFOV(self.sight or 20)
	if self.tryMonsterSpell and self:tryMonsterSpell() then
		if not self.energy.used then self:useEnergy() end
		return
	end
	if self.never_move and self.faction == "enemies" and self.monsterStrike then
		local p = game.player
		if p and not p.dead and p.x and math.max(math.abs(p.x - self.x), math.abs(p.y - self.y)) == 1 then
			self:monsterStrike(p)
			self:useEnergy()
			return
		end
	end
	if self:specialMove() then
		if not self.energy.used then self:useEnergy() end
		return
	end
	self:doAI()
	if not self.energy.used then self:useEnergy() end
end

function _M:tryMonsterSpell()
	local spells = self.dbt_spells
	if self.faction ~= "enemies" or not spells or #spells == 0 then return false end
	if not rng.percent(self.dbt_spell_freq or 0) then return false end
	local spell = spells[rng.range(1, #spells)]
	if spell.name == "PoisonBreath" then return self:breathePoison(spell.level or 1) end
	if spell.name == "SummonSnakes" then return self:summonChar("s", spell.level or 1) end
	return false
end

function _M:breathePoison(level)
	local target = game.player
	if not target or target.dead or not target.x then return false end
	local dist = math.max(math.abs(target.x - self.x), math.abs(target.y - self.y))
	if dist > (self.sight or 10) or dist == 0 then return false end
	local Map = require "engine.Map"
	local steps = math.max(math.abs(target.x - self.x), math.abs(target.y - self.y))
	for i = 1, steps - 1 do
		local x = math.floor(self.x + (target.x - self.x) * i / steps + 0.5)
		local y = math.floor(self.y + (target.y - self.y) * i / steps + 0.5)
		local g = game.level.map(x, y, Map.TERRAIN)
		if g and g.block_sight then return false end
	end
	local dam = 0
	for _ = 1, level do dam = dam + rng.range(1, 6) end
	self:hurt(target, dam)
	game.logSeen(self, "%s breathes on %s.", self.name:capitalize(), target.name or "someone")
	return true
end

function _M:summonChar(char, level)
	local list = game.zone and game.zone.npc_list
	if not list then return false end
	local choices = {}
	local seen = {}
	for _, e in pairs(list) do
		if type(e) == "table" and e.db_char == char and e.define_as and not seen[e.define_as] and (e.level or 1) <= level then
			seen[e.define_as] = true
			choices[#choices + 1] = e
		end
	end
	if #choices == 0 then return false end
	local Map = require "engine.Map"
	local placed = 0
	local want = rng.range(1, 4)
	for dy = -2, 2 do
		for dx = -2, 2 do
			if placed >= want then break end
			local x, y = self.x + dx, self.y + dy
			local g = game.level.map(x, y, Map.TERRAIN)
			local a = game.level.map(x, y, Map.ACTOR)
			if g and not g.does_block_move and not a then
				local proto = choices[rng.range(1, #choices)]
				local m = proto:clone()
				m.faction = "enemies"
				m.ai = "simple"
				m.ai_state = m.ai_state or { talent_in = 3 }
				m.never_move = false
				m:resolve()
				m:resolve(nil, true)
				game.zone:addEntity(game.level, m, "actor", x, y)
				placed = placed + 1
			end
		end
	end
	if placed == 0 then return false end
	game.logSeen(self, "%s magically summons creepy crawly things!", self.name:capitalize())
	return true
end

--- Called by ActorLife interface
-- We use it to pass aggression values to the AIs
function _M:onTakeHit(value, src)
	if not self.ai_target.actor and src.targetable then
		self.ai_target.actor = src
	end

	return mod.class.Actor.onTakeHit(self, value, src)
end

function _M:stepToward(tx, ty)
	if not tx or not self.x then return end
	local dx, dy = tx - self.x, ty - self.y
	if dx == 0 and dy == 0 then return end
	local sx = dx == 0 and 0 or (dx > 0 and 1 or -1)
	local sy = dy == 0 and 0 or (dy > 0 and 1 or -1)
	self:move(self.x + sx, self.y + sy)
end

function _M:stepAway(tx, ty)
	if not tx or not self.x then return end
	local dx, dy = tx - self.x, ty - self.y
	local sx = dx == 0 and 0 or (dx > 0 and -1 or 1)
	local sy = dy == 0 and 0 or (dy > 0 and -1 or 1)
	if sx == 0 and sy == 0 then return end
	self:move(self.x + sx, self.y + sy)
end

function _M:findRace(id)
	if not game.level or not game.level.entities then return nil end
	for _, e in pairs(game.level.entities) do
		if e.define_as == id and not e.dead then return e end
	end
end

function _M:specialMove()
	local id = self.define_as
	local p = game.player
	if not id or not p or not p.x or not self.x or self.dead then return false end
	local stand = {
		RACE_RRA_CAMERA = true, RACE_RRA_TURRET = true, RACE_SHENRON = true,
	}
	local thrower = {
		RACE_NAKAMURA = true, RACE_HONDA = true, RACE_YAWARA = true,
	}
	local flee = id == "RACE_PUAR" or id == "RACE_GREGORY" or id == "RACE_BRIEFS" or id == "RACE_M_LEVIATHAN"
	if id == "RACE_BUBBLES" and p.quests and p.quests.kaio_bubbles and p.quests.kaio_bubbles.status == "taken" then
		flee = true
	end
	if id == "RACE_RRA_WHITE" and self.life >= (self.max_life or self.life) then
		stand[id] = true
	end
	if stand[id] then return true end
	if thrower[id] then
		local dist = math.max(math.abs(p.x - self.x), math.abs(p.y - self.y))
		if dist == 1 and self.monsterStrike then
			self:monsterStrike(p)
			return true
		end
		return false
	end
	if id == "RACE_RRA_SNOW_PATROL" then
		self.dbt_patrol = (self.dbt_patrol or 1)
		if rng.percent(15) then self.dbt_patrol = -self.dbt_patrol end
		self:move(self.x + self.dbt_patrol, self.y)
		return true
	end
	if id == "RACE_TAMA" then
		local briefs = self:findRace("RACE_BRIEFS")
		if briefs then self:stepToward(briefs.x, briefs.y) else self:stepToward(p.x, p.y) end
		return true
	end
	if id == "RACE_CUTE_LITTLE_GIRLMOUSE" or id == "RACE_CUTE_LITTLE_BOYMOUSE" then
		local king = self:findRace("RACE_KING_MOUSE")
		if king then self:stepToward(king.x, king.y) else self:stepToward(p.x, p.y) end
		return true
	end
	if flee then
		self:stepAway(p.x, p.y)
		return true
	end
	local wander = id == "RACE_BUBBLES" or id == "RACE_LUNCH" or id == "RACE_CHAOZU"
	if wander and rng.percent(50) then
		self:move(self.x + rng.range(-1, 1), self.y + rng.range(-1, 1))
		return true
	end
	return false
end

function _M:tooltip()
	local str = mod.class.Actor.tooltip(self)
	return str..([[

Target: %s
UID: %d]]):format(
	self.ai_target.actor and self.ai_target.actor.name or "none",
	self.uid)
end
