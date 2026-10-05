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
require "mod.class.Actor"
require "engine.interface.PlayerRest"
require "engine.interface.PlayerRun"
require "engine.interface.PlayerMouse"
require "engine.interface.PlayerHotkeys"
local Map = require "engine.Map"
local Dialog = require "engine.Dialog"
local ActorTalents = require "engine.interface.ActorTalents"
local DeathDialog = require "mod.dialogs.DeathDialog"
local Astar = require"engine.Astar"
local DirectPath = require"engine.DirectPath"

--- Defines the player
-- It is a normal actor, with some redefined methods to handle user interaction.<br/>
-- It is also able to run and rest and use hotkeys
module(..., package.seeall, class.inherit(
	mod.class.Actor,
	engine.interface.PlayerRest,
	engine.interface.PlayerRun,
	engine.interface.PlayerMouse,
	engine.interface.PlayerHotkeys
))

function _M:init(t, no_default)
	t.display=t.display or '@'
	t.color_r=t.color_r or 230
	t.color_g=t.color_g or 230
	t.color_b=t.color_b or 230

	t.player = true
	t.type = t.type or "humanoid"
	t.subtype = t.subtype or "player"
	t.faction = t.faction or "players"

	t.lite = t.lite or 0

	mod.class.Actor.init(self, t, no_default)
	engine.interface.PlayerHotkeys.init(self, t)

	self.descriptor = {}
end

function _M:move(x, y, force)
	if not force and game.tryEarthEdge and game:tryEarthEdge(self, x, y) then
		if game.level and game.level.map then
			game.level.map:moveViewSurround(self.x, self.y, 8, 8)
		end
		return true
	end
	local moved = mod.class.Actor.move(self, x, y, force)
	if moved then
		game.level.map:moveViewSurround(self.x, self.y, 8, 8)
	end
	return moved
end

function _M:act()
	if not mod.class.Actor.act(self) then return end

	-- Clean log flasher
	game.flash:empty()

	if self.player then self:tickHunger() end

	-- Resting ? Running ? Otherwise pause
	if not self:restStep() and not self:runStep() and self.player then
		game.paused = true
	end
end

function _M:hungerBand(v)
	if v < 500 then return 0
	elseif v < 1000 then return 1
	elseif v < 2000 then return 2
	elseif v < 10000 then return 3
	elseif v < 15000 then return 4
	else return 5 end
end

function _M:tickHunger()
	if self.hunger == nil then self.hunger = 15000 end
	local before = self:hungerBand(self.hunger)
	self.hunger = math.max(0, self.hunger - 1)
	local after = self:hungerBand(self.hunger)
	if after < before then
		local down = {
			[0] = "You are getting faint from hunger!",
			[1] = "You are getting weak from hunger!",
			[2] = "You are getting hungry.",
			[3] = "You are no longer full.",
			[4] = "You are no longer gorged.",
		}
		if down[after] then game.log(down[after]) end
	end
	if self.hunger < 100 and not self.dead then
		local dam = math.max(1, math.floor((100 - self.hunger) / 10))
		self.life = self.life - dam
		if self.life <= 0 then
			game.log("You have starved.")
			self.life = 0
			self:die(self)
		end
	end
end

function _M:eatObject(o, item)
	if self.tourny_now and game.loseTournament then
		game.log("You have been disqualified for eating during a match!")
		game:loseTournament("eat")
	end
	if o.define_as == "SENZU_BEAN" then
		self.life = self.max_life
		game.log("You eat the senzu bean and are fully restored.")
	else
		local before = self.life
		self.life = math.min(self.max_life, self.life + (o.heal or 0))
		local food = o.dbt_food or 3000
		if self.hunger == nil then self.hunger = 15000 end
		local prev = self:hungerBand(self.hunger)
		self.hunger = math.min(20000, self.hunger + food)
		local now = self:hungerBand(self.hunger)
		if now > prev then
			local up = {
				[1] = "You are still weak.",
				[2] = "You are still hungry.",
				[3] = "You are no longer hungry.",
				[4] = "You are pleasantly full.",
				[5] = "You have gorged yourself!",
			}
			if up[now] then game.log(up[now]) end
		end
		local gained = self.life - before
		if gained > 0 then game.log("You eat %s and recover %d life.", o:getName(), gained)
		else game.log("You eat %s.", o:getName()) end
		if o.name and o.name:find("corpse") then
			self.alignment = (self.alignment or 0) - 1
			game.log("You don't feel very good about this.")
		end
	end
	self:removeObject(self.INVEN_INVEN, item)
	if not (self:hasAbility("sushi")) then self:useEnergy() end
end

function _M:playerEat()
	self:showInventory("Eat", self:getInven("INVEN"), function(o) return o.dbt_use == "eat" or o.type == "food" end, function(o, item)
		self:eatObject(o, item)
	end)
end

function _M:mayParty(actor)
	if not actor then return false end
	self.party = self.party or {}
	local levels = 0
	for _, mate in ipairs(self.party) do levels = levels + (mate.level or 1) end
	local max_allow = 5 * (self:effStat("chr") - 10) - levels
	return (actor.level or 1) <= max_allow
end

function _M:isPartied(define_as)
	self.party = self.party or {}
	for _, mate in ipairs(self.party) do
		if mate.define_as == define_as then return true end
	end
	return false
end

function _M:partyWith(actor)
	if not actor or not actor.define_as then return false end
	if self:isPartied(actor.define_as) then return true end
	if not self:mayParty(actor) then
		game.log("%s will not join you.", actor.name or "They")
		return false
	end
	self.party[#self.party + 1] = {define_as = actor.define_as, name = actor.name, level = actor.level or 1}
	actor.dbt_partied = true
	actor.faction = self.faction or "neutral"
	actor.ai = "none"
	actor.never_move = false
	game.log("%s joins you.", actor.name or "Someone")
	return true
end

function _M:unparty(define_as)
	if not self.party then return end
	local kept = {}
	for _, mate in ipairs(self.party) do
		if mate.define_as ~= define_as then kept[#kept + 1] = mate end
	end
	self.party = kept
end

function _M:useEnergy(val)
	mod.class.Actor.useEnergy(self, val)
	if self.player and self.energy.value < game.energy_to_act then
		game.paused = false
	end
end

-- Precompute FOV form, for speed
local fovdist = {}
for i = 0, 30 * 30 do
	fovdist[i] = math.max((20 - math.sqrt(i)) / 14, 0.6)
end

function _M:playerFOV()
	-- Clean FOV before computing it
	game.level.map:cleanFOV()
	-- Compute both the normal and the lite FOV, using cache
	self:computeFOV(self.sight or 20, "block_sight", function(x, y, dx, dy, sqdist)
		game.level.map:apply(x, y, fovdist[sqdist])
	end, true, false, true)
	self:computeFOV(self.lite, "block_sight", function(x, y, dx, dy, sqdist) game.level.map:applyLite(x, y) end, true, true, true)
end

--- Called before taking a hit, overload mod.class.Actor:onTakeHit() to stop resting and running
function _M:onTakeHit(value, src)
	self:runStop(_t"taken damage")
	self:restStop(_t"taken damage")
	local ret = mod.class.Actor.onTakeHit(self, value, src)
	if src and src ~= self and src.takeHit and not src.dead and self.hasAbility and self:hasAbility("blocking") and self.eachWorn then
		local dice
		self:eachWorn(function(o) if o.dbt_spike then dice = o.dbt_spike end end)
		if dice then
			local back = 0
			for _ = 1, dice[1] do back = back + rng.range(1, dice[2]) end
			if back > 0 then
				src:takeHit(back, self)
				game.logSeen(self, "Your spikes pierce %s.", src.name or "it")
			end
		end
	end
	if self.tourny_now and not self.tourny_death and ret >= self.life and game.loseTournament then
		game:loseTournament("defeat")
		return 0
	end
	if self.life < self.max_life * 0.3 then
		local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
		game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, 2, _t"LOW HEALTH!", {255,0,0}, true)
	end
	return ret
end

function _M:die(src)
	if self.game_ender then
		engine.interface.ActorLife.die(self, src)
		game.paused = true
		self.energy.value = game.energy_to_act
		game:registerDialog(DeathDialog.new(self))
	else
		mod.class.Actor.die(self, src)
	end
end

function _M:setName(name)
	self.name = name
	game.save_name = name
end

--- Notify the player of available cooldowns
function _M:onTalentCooledDown(tid)
	local t = self:getTalentFromId(tid)

	local x, y = game.level.map:getTileToScreen(self.x, self.y)
	game.flyers:add(x, y, 30, -0.3, -3.5, ("%s available"):format(t.name:capitalize()), {0,255,00})
	game.log("#00ff00#Talent %s is ready to use.", t.name)
end

function _M:levelup()
	mod.class.Actor.levelup(self)

	local x, y = game.level.map:getTileToScreen(self.x, self.y)
	game.flyers:add(x, y, 80, 0.5, -2, _t"LEVEL UP!", {0,255,255})
	game.log("#00ffff#Welcome to level %d.", self.level)
end

--- Tries to get a target from the user
function _M:getTarget(typ)
	return game:targetGetForPlayer(typ)
end

--- Press a direction. The engine accepts that key immediately when immediate_keys is set.
function _M:pickAdjacent(prompt, act)
	local co = coroutine.create(function()
		local x, y = self:getTarget{
			type = "hit", range = 1, immediate_keys = true, nowarning = true, no_restrict = true,
			default_target = self, start_x = self.x, start_y = self.y, msg = prompt,
		}
		if not x or not y then return end
		if math.max(math.abs(x - self.x), math.abs(y - self.y)) ~= 1 then
			game.log("Pick a direction next to you.")
			return
		end
		act(x, y)
	end)
	local ok, err = coroutine.resume(co)
	if not ok and err then error(err) end
end

--- Walking into a hostile swings. Walking into anyone else asks first
function _M:bumpCreature(target)
	if not target or target.dead or target == self then return end
	if self:reactionToward(target) < 0 then
		self:attackTarget(target)
		return
	end
	if self.dbt_attack_prompt then return end
	self:runStop("bump")
	self:restStop("bump")
	self.dbt_attack_prompt = true
	local Dialog = require "engine.ui.Dialog"
	Dialog:yesnoPopup("Attack", ("Attack %s?"):format(target.name or "them"), function(ret)
		self.dbt_attack_prompt = nil
		if not ret or target.dead then return end
		self:attackTarget(target)
	end, "Yes", "No")
end

function _M:playerAttack()
	self:pickAdjacent("Attack in which direction?", function(x, y)
		local target = game.level.map(x, y, Map.ACTOR)
		if not target or target == self or target.dead then
			game.log("There is nothing there to attack.")
			return
		end
		self:attackTarget(target)
	end)
end

function _M:playerChat()
	self:pickAdjacent("Talk in which direction?", function(x, y)
		local target = game.level.map(x, y, Map.ACTOR)
		if not target or target == self or not target.can_talk then
			game.log("There is no one to talk to there.")
			return
		end
		local Chat = require "engine.Chat"
		Chat.new(target.can_talk, target, self):invoke()
	end)
end

--- Sets the current target
function _M:setTarget(target)
	return game:targetSetForPlayer(target)
end

local function spotHostiles(self)
	local seen = false
	-- Check for visible monsters, only see LOS actors, so telepathy wont prevent resting
	core.fov.calc_circle(self.x, self.y, game.level.map.w, game.level.map.h, 20, function(_, x, y) return game.level.map:opaque(x, y) end, function(_, x, y)
		local actor = game.level.map(x, y, game.level.map.ACTOR)
		if actor and self:reactionToward(actor) < 0 and self:canSee(actor) and game.level.map.seens(x, y) then seen = true end
	end, nil)
	return seen
end

--- Can we continue resting ?
-- We can rest if no hostiles are in sight, and if we need life/mana/stamina (and their regen rates allows them to fully regen)
function _M:restCheck()
	if spotHostiles(self) then return false, "hostile spotted" end

	-- Check resources, make sure they CAN go up, otherwise we will never stop
	if self:getPower() < self:getMaxPower() and self.power_regen > 0 then return true end
	if self.life < self.max_life and self.life_regen> 0 then return true end

	return false, "all resources and life at maximum"
end

--- Can we continue running?
-- We can run if no hostiles are in sight, and if we no interesting terrains are next to us
function _M:runCheck()
	if spotHostiles(self) then return false, "hostile spotted" end

	-- Notice any noticeable terrain
	local noticed = false
	self:runScan(function(x, y)
		-- Only notice interesting terrains
		local grid = game.level.map(x, y, Map.TERRAIN)
		if grid and grid.notice then noticed = "interesting terrain" end
	end)
	if noticed then return false, noticed end

	self:playerFOV()

	return engine.interface.PlayerRun.runCheck(self)
end

--- Move with the mouse
-- We just feed our spotHostile to the interface mouseMove
function _M:mouseMove(tmx, tmy)
	return engine.interface.PlayerMouse.mouseMove(self, tmx, tmy, spotHostiles)
end

function _M:pickupFloor(i, vocal)
	local map = game.level and game.level.map
	local o = map and map:getObject(self.x, self.y, i)
	if o and o.dbt_zeni then
		local amount = o.dbt_zeni
		self.money = (self.money or 0) + amount
		map:removeObject(self.x, self.y, i)
		if vocal ~= false then
			if o.dbt_zeni_named then
				game.log("You have found %s with %d zeni.", o.name, amount)
			else
				game.log("You have found %d zeni.", amount)
			end
		end
		return true
	end
	return mod.class.Actor.pickupFloor(self, i, vocal)
end

function _M:playerPickup()
	local nb = game.level.map:getObjectTotal(self.x, self.y)
	if nb == 0 then
		game.log("There is nothing to pick up.")
		return
	end
	if nb == 1 then
		self:pickupFloor(1, true)
		self:useEnergy()
		return
	end
	self:showPickupFloor("Pick up", nil, function(o, item)
		self:pickupFloor(item, true)
		self:useEnergy()
	end)
end

function _M:playerDrop()
	self:showInventory("Drop", self:getInven("INVEN"), nil, function(o, item)
		if self:dropFloor(self.INVEN_INVEN, item, true) then
			self:useEnergy()
		end
	end)
end

function _M:playerWear()
	self:showInventory("Wear", self:getInven("INVEN"), function(o) return o.slot end, function(o, item)
		local removed = self:removeObject(self.INVEN_INVEN, item, true)
		if not removed then return true end
		local ret = self:wearObject(removed, true, true)
		if not ret then
			self:addObject(self.INVEN_INVEN, removed)
			return true
		end
		if type(ret) == "table" then
			self:addObject(self.INVEN_INVEN, ret)
		end
		self:sortInven(self.INVEN_INVEN)
		self:useEnergy()
	end)
end

function _M:playerTakeoff()
	self:showEquipment("Take off", nil, function(o, inven, item)
		local removed = self:takeoffObject(inven, item)
		if not removed then return end
		if not self:addObject(self.INVEN_INVEN, removed) then
			self:addObject(inven, removed)
			game.log("Your pack is full.")
			return
		end
		self:useEnergy()
		game.log("You take off %s.", removed:getName())
	end)
end

function _M:grantWish(text)
	local wish = (text or ""):lower()
	if wish:sub(1, 7) ~= "i wish " then
		game.log("That is not the proper form. Wishes must begin with 'I wish'.")
		return false
	end
	if wish:find("dragonball") then
		game.log("Once you have made your wish the dragonballs will be once again scattered across the earth.")
		return false
	end
	if wish:find("points") or wish:find("level") or wish:find("%d") then
		game.log("Your wish is unclear. If you desire something, speak it in clear language.")
		return false
	end
	if wish:find("to die") or wish:find("to kill") or wish:find("kill me") then
		if wish == "i wish to die" or wish == "i wish to be dead" or wish:find("kill me") then
			game.log("You die.")
			self:die(self)
			return true
		end
		game.log("Impertinent fool! I will not violate free will.")
		return false
	end
	local travel = {
		earth = "earth5", namek = "nameksw", kaio = "kaio", plant = "plant", ["planet 79"] = "p79", ["79"] = "p79",
	}
	if wish:find("travel") or wish:find("send me") or wish:find("teleport") or wish:find("return to") then
		for word, zone in pairs(travel) do
			if wish:find(word) then
				game.log("Granted.")
				game:changeLevel(1, zone)
				return true
			end
		end
		game.log("I do not recognize the location you are asking for.")
		return false
	end
	if wish:find("female") or wish:find("woman") or wish:find("girl") then
		if self.female then game.log("You appear to be female already.") return false end
		self.female = true
		if self.descriptor then self.descriptor.sex = "Female" end
		game.log("Granted.")
		return true
	end
	if wish:find("male") or wish:find(" man") or wish:find("boy") then
		if not self.female then game.log("You appear to be male already.") return false end
		self.female = false
		if self.descriptor then self.descriptor.sex = "Male" end
		game.log("Granted.")
		return true
	end
	local stats = {strength="str", dexterity="dex", constitution="con", intelligence="int", willpower="wil", charisma="chr", speed="spd"}
	for word, short in pairs(stats) do
		if wish:find(word) then
			local amt = rng.range(4, 6)
			self:incStat(short, amt)
			self:applyStatEffects()
			game.log("Granted. Your %s increases.", word)
			return true
		end
	end
	if wish:find("heal") or wish:find("health") or wish:find("restored") then
		self.life = self.max_life
		game.log("Granted. You are restored.")
		return true
	end
	if wish:find("senzu") then
		local o = game.cloneStock and game:cloneStock("SENZU_BEAN")
		if o then
			o:resolve()
			o:resolve(nil, true)
			self:addObject(self.INVEN_INVEN, o)
			game.log("Granted. A senzu bean appears.")
			return true
		end
	end
	if wish:find("zeni") or wish:find("money") or wish:find("rich") then
		self.money = (self.money or 0) + 50000
		game.log("Granted. Fifty thousand zeni appears.")
		return true
	end
	game.log("I do not understand that wish.")
	return false
end

function _M:promptWish()
	local Dialog = require "engine.ui.Dialog"
	local choices = {
		{name="I wish to be healed"},
		{name="I wish for zeni"},
		{name="I wish for a senzu bean"},
		{name="I wish for strength"},
		{name="I wish for dexterity"},
		{name="I wish for constitution"},
		{name="I wish to travel to Namek"},
		{name="I wish to travel to Earth"},
		{name="I wish to travel to Kaio"},
		{name="I wish to be a woman"},
		{name="I wish to be a man"},
	}
	if Dialog.listPopup then
		Dialog:listPopup("Wish", "Wishes begin with 'I wish'.", choices, 500, 400, function(sel)
			if sel and sel.name then self:grantWish(sel.name) end
		end)
	else
		self:grantWish(choices[1].name)
	end
end

function _M:tryFusion()
	if not self:hasAbility("fusion") then
		game.log("You do not know how to fuse.")
		return
	end
	if self.fusion then
		if self.fusion_bonus then self:incStat("str", -self.fusion_bonus) end
		self.fusion, self.fusion_bonus, self.fusion_name = nil, nil, nil
		self:applyStatEffects()
		game.log("You separate.")
		return
	end
	local Map = require "engine.Map"
	for dy = -1, 1 do
		for dx = -1, 1 do
			if not (dx == 0 and dy == 0) then
				local a = game.level.map(self.x + dx, self.y + dy, Map.ACTOR)
				if a and a ~= self and (a.dbt_partied or self:reactionToward(a) >= 0) and a.define_as then
					local bonus = math.max(1, math.floor((a.level or 1) / 2))
					self.fusion = a.define_as
					self.fusion_name = a.name
					self.fusion_bonus = bonus
					self:incStat("str", bonus)
					self:applyStatEffects()
					game.level.map:remove(a.x, a.y, Map.ACTOR)
					if game.level.removeEntity then game.level:removeEntity(a) end
					a.dead = true
					game.log("You fuse with %s.", a.name or "them")
					return
				end
			end
		end
	end
	game.log("Nobody you can fuse with is beside you.")
end

function _M:dismantleItem()
	self:showInventory("Dismantle", self:getInven("INVEN"), function(o)
		return o.type == "Electronics" or o.type == "Gun" or o.dbt_kind == "firearm"
	end, function(o, item)
		if self:skillLevel("disassembly") < 1 and self:skillLevel("technology") < 1 then
			game.log("You don't know how to take that apart.")
			return
		end
		self.tech_parts = (self.tech_parts or 0) + 1
		self.tech_known = self.tech_known or {}
		self.tech_known[o.define_as or o.name] = o.name
		self:removeObject(self.INVEN_INVEN, item)
		game.log("You dismantle %s. You have %d parts.", o:getName(), self.tech_parts)
	end)
end

function _M:buildDevice()
	if (self.tech_parts or 0) < 3 then
		game.log("You need at least three parts.")
		return
	end
	if self:skillLevel("construction") < 1 and self:skillLevel("technology") < 1 then
		game.log("You don't know how to build anything.")
		return
	end
	local recipe
	for id, name in pairs(self.tech_known or {}) do recipe = id break end
	if not recipe then
		game.log("You have not learned a recipe. Dismantle a device first.")
		return
	end
	self.tech_parts = self.tech_parts - 3
	local list = game.zone and game.zone.object_list
	local proto = list and list[recipe]
	if proto then
		local o = proto:clone()
		o:resolve()
		o:resolve(nil, true)
		self:addObject(self.INVEN_INVEN, o)
		game.log("You build %s.", o:getName())
	else
		game.log("You assemble the parts, but the device is not in this place's catalog. The parts are spent.")
	end
end

function _M:callNimbus()
	local zone = game.zone and game.zone.short_name or ""
	if (self.karin_kinto or 0) < 1 then
		game.log("You call out...but nothing happens.")
		return
	end
	if zone:sub(1, 5) ~= "earth" then
		game.log("You call out, but seriously doubt Kinto Un will hear you from here.")
		return
	end
	self.kinto = true
	self.flying = true
	if game.dbtPlay then game:dbtPlay("effects", "kintocall") end
	game.log("Kinto Un responds to your call!")
end

function _M:playerUseItem()
	self:showInventory("Use", self:getInven("INVEN"), function(o) return o.dbt_use or o.identified == false end, function(o, item)
		if o.identified == false and game.identifyObject then game:identifyObject(o) end
		if o.dbt_use == "eat" or o.type == "food" then
			self:eatObject(o, item)
			return
		end
		if o.dbt_use == "read" then
			game.log("%s: %s", o:getName(), o:getDesc())
			self:useEnergy()
			return
		end
		if o.dbt_use == "nyoibo" then
			self:useNyoibo()
			return
		end
		if o.dbt_use == "ship" then
			local Chat = require "engine.Chat"
			Chat.new("ship", self, self):invoke()
			return
		end
		return true
	end)
end

function _M:useNyoibo()
	local Dialog = require "engine.ui.Dialog"
	local list = {
		{name="north", dx=0, dy=-1},
		{name="northeast", dx=1, dy=-1},
		{name="east", dx=1, dy=0},
		{name="southeast", dx=1, dy=1},
		{name="south", dx=0, dy=1},
		{name="southwest", dx=-1, dy=1},
		{name="west", dx=-1, dy=0},
		{name="northwest", dx=-1, dy=-1},
	}
	Dialog:listPopup("Nyoi-bo", "Command it to extend:", list, 280, 360, function(sel)
		if not sel or not sel.dx then return end
		local Map = require "engine.Map"
		local x, y = self.x, self.y
		local hit
		for i = 1, 6 do
			x, y = x + sel.dx, y + sel.dy
			local g = game.level.map(x, y, Map.TERRAIN)
			if not g or g.does_block_move then break end
			local a = game.level.map(x, y, Map.ACTOR)
			if a and a ~= self then
				hit = a
				break
			end
		end
		self:useEnergy()
		if hit then
			self:hurt(hit, 5)
			game.log("You thwap %s with the Nyoi-bo!", hit.name)
		else
			game.log("The Nyoi-bo stretches out and snaps back.")
		end
	end)
end
