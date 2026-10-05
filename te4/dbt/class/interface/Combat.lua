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
local DamageType = require "engine.DamageType"
local Map = require "engine.Map"
local Target = require "engine.Target"
local Talents = require "engine.interface.ActorTalents"

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
	local reaction = self:reactionToward(target)
	if reaction < 0 then
		return self:attackTarget(target)
	elseif self.player and target.can_talk then
		local Chat = require "engine.Chat"
		Chat.new(target.can_talk, target, self):invoke()
		return
	elseif reaction >= 0 then
		if self.move_others then
			-- Displace
			game.level.map:remove(self.x, self.y, Map.ACTOR)
			game.level.map:remove(target.x, target.y, Map.ACTOR)
			game.level.map(self.x, self.y, Map.ACTOR, target)
			game.level.map(target.x, target.y, Map.ACTOR, self)
			self.x, self.y, target.x, target.y = target.x, target.y, self.x, self.y
		end
	end
end

--- Melee or a monster blow. Armor is the to-hit number, not a damage soak.
function _M:attackTarget(target)
	if self.player then
		self:playerMelee(target)
	else
		self:monsterStrike(target)
	end
	self:useEnergy(game.energy_to_act)
end

function _M:hand(which)
	if not self.getInven or not self.inven then return nil end
	local wield = self:getInven("WIELD")
	return wield and wield[which] or nil
end

function _M:handKind(o)
	if not o then return "empty" end
	if o.dbt_kind == "firearm" then return "firearm" end
	if o.dbt_kind == "weapon" or (o.combat and (o.combat.dice or o.combat.dam)) then return "weapon" end
	return "junk"
end

function _M:meleePreview()
	local weapon
	for i = 1, 2 do
		local o = self:hand(i)
		if o and self:handKind(o) == "weapon" then
			weapon = o
			break
		end
	end
	if weapon and weapon.combat and weapon.combat.dice then
		local bonus = self:effStat("str") - 10 + (weapon.dbt_to_d or 0)
		local sign = bonus < 0 and "-" or "+"
		local hit = (self:effStat("dex") - 10) - (weapon.difficulty or 0) + self:skillLevel("martialarts") + self:skillLevel("weapons") + (weapon.dbt_to_h or 0)
		return ("to-hit %d, %d-%d %s%d"):format(hit, weapon.combat.dice[1], weapon.combat.dice[2], sign, math.abs(bonus))
	end
	local hit = (self:effStat("dex") - 10) + self:skillLevel("martialarts") + self:skillLevel("hand")
	return ("barehand to-hit %d, damage %d"):format(hit, math.max(0, self:effStat("str") - 10))
end

function _M:targetArmor(target)
	if target.armorClass then return target:armorClass() end
	return target.combat_armor or 0
end

function _M:dbtHit(to_hit, ac)
	return to_hit + rng.range(1, 100) > (ac or 0)
end

function _M:hurt(target, dam)
	if dam < 0 then dam = 0 end
	if dam > 0 then
		DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, dam)
	end
	return dam
end

function _M:strikeMessage(kind, dam, target)
	local name = target.name or "it"
	if kind == "pierce" then
		if dam > 20 then return "You heavily pierce " .. name .. "."
		elseif dam > 8 then return "You pierce " .. name .. "."
		elseif dam > 2 then return "You poke " .. name .. "."
		elseif dam > 0 then return "You barely poke " .. name .. "."
		else return "You connect, but too weakly to penetrate skin." end
	elseif kind == "slash" then
		if dam > 20 then return "You heavily cut " .. name .. "."
		elseif dam > 8 then return "You cut " .. name .. "."
		elseif dam > 2 then return "You scratch " .. name .. "."
		elseif dam > 0 then return "You barely scratch " .. name .. "."
		else return "You land a pathetic attack that does no damage." end
	end
	if dam > 20 then return "You smash " .. name .. "."
	elseif dam > 8 then return "You hit " .. name .. "."
	elseif dam > 2 then return "You tap " .. name .. "."
	elseif dam > 0 then return "You barely tap " .. name .. "."
	else return "You land a pathetic attack that does no damage." end
end

function _M:barehandStrike(target)
	local aura = (self.chi_aura or 0) == 1 and self:skillLevel("chi_offense") or 0
	local to_hit = (self:effStat("dex") - 10) + self:skillLevel("martialarts") + self:skillLevel("hand") + aura
	if not self:dbtHit(to_hit, self:targetArmor(target)) then
		game.log("You miss.")
		return
	end
	local dam = self:hurt(target, self:effStat("str") - 10 + aura)
	game.log(self:strikeMessage("crush", dam, target))
	if dam > 0 and game.dbtPlay then game:dbtPlay("effects", "smash") end
end

function _M:weaponStrike(target, weapon)
	local aura = (self.chi_aura or 0) == 1 and self:skillLevel("chi_offense") or 0
	local to_hit = (self:effStat("dex") - 10) - (weapon.difficulty or 0) + self:skillLevel("martialarts") + self:skillLevel("weapons") + aura + (weapon.dbt_to_h or 0)
	if not self:dbtHit(to_hit, self:targetArmor(target)) then
		game.log("You miss.")
		return
	end
	local dice = weapon.combat and weapon.combat.dice
	local roll = dice and rng.range(dice[1], dice[2]) or (weapon.combat and weapon.combat.dam or 0)
	if weapon.dbt_vorpal and dice and rng.range(1, 200) <= self:skillLevel("weapons") then
		roll = roll + rng.range(dice[1], dice[2])
	end
	if weapon.dbt_stun then
		local stun = rng.range(weapon.dbt_stun[1], weapon.dbt_stun[2])
		if stun > 0 then
			target.dbt_stun = (target.dbt_stun or 0) + math.max(1, math.floor(stun / 20))
			game.log("%s is stunned.", target.name or "It")
		end
	end
	if target.define_as == "RACE_GREGORY" then
		local q = self.quests and self.quests.kaio_gregory
		if q and q.status == "taken" then
			q.status = "completed"
			game.log("You have hit Gregory!")
		end
	end
	local dam = self:hurt(target, (self:effStat("str") - 10) + roll + aura + (weapon.dbt_to_d or 0))
	game.log(self:strikeMessage(weapon.dbt_blow or "crush", dam, target))
	if dam > 0 and game.dbtPlay then game:dbtPlay("effects", "smash") end
end

--- One turn of melee. Skills that allow a second hand, or a point-blank shot, are not learned yet.
function _M:playerMelee(target)
	local left, right = self:handKind(self:hand(1)), self:handKind(self:hand(2))
	local function swing(which, kind)
		if kind == "weapon" then self:weaponStrike(target, self:hand(which))
		elseif kind == "empty" then self:barehandStrike(target) end
	end

	if left == "weapon" or right == "weapon" then
		if left == "weapon" then swing(1, "weapon") end
		if target.dead then return end
		if right == "weapon" then swing(2, "weapon") end
		return
	end
	if left == "firearm" or right == "firearm" then
		game.log("You haven't the skill to fire in such close proximity.")
		return
	end
	if left == "junk" or right == "junk" then
		if self:hasAbility("double_attack") and (left == "empty" or right == "empty") then
			self:barehandStrike(target)
			return
		end
		game.log("You can't fight with that.")
		return
	end
	self:barehandStrike(target)
	if self:hasAbility("double_attack") and not target.dead then
		self:barehandStrike(target)
	end
end

function _M:loadFirearm(gun)
	if (gun.ammo_current or 0) > 0 then return true end
	local pack = self:getInven("INVEN")
	if not pack then return false end
	for i, o in ipairs(pack) do
		if o.dbt_ammo then
			local rounds = o.dbt_rounds or 1
			if gun.capacity and gun.capacity > 0 then rounds = math.min(rounds, gun.capacity) end
			gun.ammo_current = rounds
			gun.loaded_dice = o.dbt_ammo
			gun.loaded_pierce = o.dbt_pierce and true or false
			self:removeObject(self.INVEN_INVEN, i)
			game.log("You load %s (%d rounds).", o:getName(), rounds)
			return true
		end
	end
	return false
end

--- Fire the wielded gun at the nearest enemy you can see. Adjacent shots are point-blank.
function _M:playerFire()
	if self.tourny_now then
		game.log("You have been disqualified for illegal use of firearms!")
		if game.loseTournament then game:loseTournament("gun") end
		return
	end
	local guns = {}
	for i = 1, 2 do
		local o = self:hand(i)
		if o and self:handKind(o) == "firearm" then guns[#guns + 1] = o end
	end
	if #guns == 0 then
		game.log("You are not holding a firearm.")
		return
	end
	local target, dist
	local actors = game.level and game.level.entities or {}
	for _, a in pairs(actors) do
		if a ~= self and a.x and a.reactionToward and not a.dead and self:reactionToward(a) < 0 and self:hasLOS(a.x, a.y) then
			local d = math.max(math.abs(a.x - self.x), math.abs(a.y - self.y))
			if d > 0 and (not dist or d < dist) then target, dist = a, d end
		end
	end
	if not target then
		game.log("You see nothing to shoot.")
		return
	end
	if dist <= 1 and not self:hasAbility("point_blank") then
		game.log("You haven't the skill to fire in such close proximity.")
		return
	end
	local empty = 0
	for _, gun in ipairs(guns) do
		if target.dead then break end
		if gun.dbt_range and gun.dbt_range > 0 and dist > gun.dbt_range then
			game.log("Out of range.")
		elseif (gun.ammo_current or 0) <= 0 and not self:loadFirearm(gun) then
			empty = empty + 1
		else
			local to_hit = self:skillLevel("marksmanship") - (gun.difficulty or 0) - (dist * dist) + (gun.dbt_to_h or 0)
			local ac = self:targetArmor(target)
			if gun.loaded_pierce then ac = math.floor(ac / 2) end
			gun.ammo_current = gun.ammo_current - 1
			local wide = gun.dbt_inaccurate and not (rng.range(-1, 1) == 0 and rng.range(-1, 1) == 0)
			if not wide and self:dbtHit(to_hit, ac) then
				local dice = gun.loaded_dice or {1, 4}
				local dam = self:hurt(target, rng.range(dice[1], dice[2]) * (gun.multiplier or 1) + (gun.dbt_to_d or 0))
				game.log("You hit %s.", target.name)
				if dam <= 0 then game.log("The shot fails to hurt %s.", target.name) end
			else
				game.log("You miss.")
			end
			if gun.ammo_current <= 0 then game.log("Your %s is empty.", gun:getName()) end
		end
	end
	if empty == #guns then
		game.log(#guns == 2 and "Firearms in both hands out of ammo!" or "Out of ammo!")
	elseif empty == 1 and #guns == 2 then
		game.log("One firearm is out of ammo!")
	end
	self:useEnergy(game.energy_to_act)
end

function _M:playerThrow()
	local obj, inven_id, slot
	for i = 1, 2 do
		local o = self:hand(i)
		if o then obj, inven_id, slot = o, self.INVEN_WIELD, i break end
	end
	if not obj then
		local pack = self:getInven("INVEN")
		if pack then
			for i, o in ipairs(pack) do
				if o and (o.subtype == "Thrown items" or o.type == "food" or (o.name and o.name:find("grenade"))) then
					obj, inven_id, slot = o, self.INVEN_INVEN, i
					break
				end
			end
		end
	end
	if not obj then
		game.log("You have nothing to throw.")
		return
	end
	self:pickAdjacent("Throw which way?", function(tx, ty)
		local dx, dy = tx - self.x, ty - self.y
		local range = 5 + math.floor(self:effStat("str") / 5) - math.floor((obj.encumber or 0) / 50)
		if range < 0 then range = 0 elseif range > 20 then range = 20 end
		local x, y = self.x, self.y
		local Map = require "engine.Map"
		local landed = false
		for _ = 1, math.max(1, range) do
			local nx, ny = x + dx, y + dy
			local g = game.level.map(nx, ny, Map.TERRAIN)
			if not g or g.does_block_move then break end
			x, y = nx, ny
			local a = game.level.map(x, y, Map.ACTOR)
			if a and a ~= self then
				local to_hit = self:skillLevel("throwing") + self:effStat("dex") + (obj.dbt_to_h or 0) - (range * 5)
				if to_hit >= self:targetArmor(a) + rng.range(1, 100) then
					landed = true
					break
				end
			end
		end
		self:removeObject(inven_id, slot)
		self:detonateThrow(obj, x, y)
		self:useEnergy()
		landed = landed
	end)
end

function _M:detonateThrow(obj, x, y)
	local Map = require "engine.Map"
	local name = obj.name or "it"
	if name:find("grenade") then
		game.log("The %s detonates.", name)
		local dice, sides = 3, 6
		if name:find("smoke") then
			game.log("Smoke fills the area.")
			return
		end
		for dy = -1, 1 do
			for dx = -1, 1 do
				local a = game.level.map(x + dx, y + dy, Map.ACTOR)
				if a and a ~= self and not a.dead then
					local dam = 0
					for _ = 1, dice do dam = dam + rng.range(1, sides) end
					self:hurt(a, dam)
				end
			end
		end
		return
	end
	local a = game.level.map(x, y, Map.ACTOR)
	local dam = rng.range(0, math.floor((obj.encumber or 0) / 10))
	if a and a ~= self and not a.dead then
		self:hurt(a, dam)
		game.log("You hit %s.", a.name or "someone")
	else
		game.log("The %s lands.", name)
	end
end

--- Monster blows. The hit test is the one monster.lua installs over the default:
--- a roll of 0-5 always hits, otherwise roll + power + level * 5 against armor.
--- Armor does not soak the rolled dice.
local BLOW_POWER = {
	HURT = 60, SLASH = 60, CRUSH = 60, PIERCE = 60, CUT = 60,
	POISON = 5, FEAR = 5, EAT_GOLD = 5, EAT_ITEM = 5, EAT_FOOD = 5, EAT_DRAGONBALL = 5,
	ELEC = 10, FIRE = 10, COLD = 10, BLIND = 5, HALLU = 5, PARALYZE = 5,
	CONFUSE = 5, TERRIFY = 5, DISEASE = 5, DEMON_PICCOLO = 60,
	LOSE_STR = 0, LOSE_INT = 0, LOSE_WIL = 0, LOSE_DEX = 0, LOSE_CON = 0, LOSE_CHR = 0, LOSE_ALL = 0,
}
local BLOW_VERB = {
	HIT = "hits", TOUCH = "touches", PUNCH = "punches", KICK = "kicks",
	BONK = "bonks", CLAW = "claws", BITE = "bites", STING = "stings", CRUSH = "crushes",
}

function _M:monsterStrike(target)
	local blows = self.blows
	if not blows or #blows == 0 then
		blows = { {method = "HIT", effect = "HURT", dice = 1, sides = (self.combat and self.combat.dam) or 1} }
	end
	local level = math.max(1, self.level or 1)
	local ac = self:targetArmor(target)
	for _, blow in ipairs(blows) do
		if self.dead or target.dead then return end
		local k = rng.range(0, 99)
		local power = BLOW_POWER[blow.effect] or 60
		local hit = k <= 5 or (k + power + (level * 5) >= ac)
		local verb = BLOW_VERB[blow.method] or "hits"
		if not hit then
			game.logSeen(self, "%s misses %s.", self.name:capitalize(), target.name or "someone")
		else
			local dam = 0
			local dice = blow.dice or 1
			local sides = math.max(1, blow.sides or 1)
			for _ = 1, dice do dam = dam + rng.range(1, sides) end
			if target.resistDamage then dam = target:resistDamage(blow.effect, dam) end
			self:hurt(target, dam)
			game.logSeen(self, "%s %s %s.", self.name:capitalize(), verb, target.name or "someone")
			if dam > 0 and game.dbtPlay then game:dbtPlay("effects", "smash") end
		end
	end
end
