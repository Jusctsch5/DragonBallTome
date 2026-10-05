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
require "engine.GameTurnBased"
require "engine.interface.GameTargeting"
require "engine.KeyBind"
local Savefile = require "engine.Savefile"
local DamageType = require "engine.DamageType"
local Zone = require "engine.Zone"
local Map = require "engine.Map"
local Level = require "engine.Level"
local Birther = require "engine.Birther"

local Grid = require "mod.class.Grid"
local Actor = require "mod.class.Actor"
local Player = require "mod.class.Player"
local NPC = require "mod.class.NPC"

local HotkeysDisplay = require "engine.HotkeysDisplay"
local ActorsSeenDisplay = require "engine.ActorsSeenDisplay"
local LogDisplay = require "engine.LogDisplay"
local LogFlasher = require "engine.LogFlasher"
local DebugConsole = require "engine.DebugConsole"
local FlyingText = require "engine.FlyingText"
local Tooltip = require "engine.Tooltip"
local Hud = require "mod.class.Hud"

local QuitDialog = require "mod.dialogs.Quit"

module(..., package.seeall, class.inherit(engine.GameTurnBased, engine.interface.GameTargeting))

function _M:init()
	engine.GameTurnBased.init(self, engine.KeyBind.new(), 1000, 100)

	-- Pause at birth
	self.paused = true

	-- Same init as when loaded from a savefile
	self:loaded()
end

function _M:run()
	self.flash = LogFlasher.new(0, 0, self.w, 20, nil, nil, nil, {255,255,255}, {0,0,0})
	self.logdisplay = LogDisplay.new(0, self.h * 0.8, self.w * 0.5, self.h * 0.2, nil, nil, nil, {255,255,255}, {30,30,30})
	self.hotkeys_display = HotkeysDisplay.new(nil, self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2, {30,30,0})
	self.npcs_display = ActorsSeenDisplay.new(nil, self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2, {30,30,0})
	self.tooltip = Tooltip.new(nil, nil, {255,255,255}, {30,30,30})
	self.dialog_tooltip = Tooltip.new(nil, nil, {255,255,255}, {30,30,30})
	self.flyers = FlyingText.new()
	self:setFlyingText(self.flyers)
	self.hud = Hud.new()

	self.log = function(style, ...) if type(style) == "number" then self.logdisplay(...) self.flash(style, ...) else self.logdisplay(style, ...) self.flash(self.flash.NEUTRAL, style, ...) end end
	self.logSeen = function(e, style, ...) if e and self.level.map.seens(e.x, e.y) then self.log(style, ...) end end
	self.logPlayer = function(e, style, ...) if e == self.player then self.log(style, ...) end end
	self.logNewest = function() return self.logdisplay:getNewestLine() end

	self:syncDbtSettings()

	self.log(self.flash.GOOD, "Welcome to #00FF00#Dragonball T#LAST#. You are on Earth, southwest. Walk off the edge of the map to the next region. Press > on a stair to enter. Walk onto a shop door to buy.")

	-- Setup inputs
	self:setupCommands()
	self:setupMouse()

	-- Starting from here we create a new game
	if not self.player then self:newGame() end

	self.hotkeys_display.actor = self.player
	self.npcs_display.actor = self.player

	-- Setup the targetting system
	engine.interface.GameTargeting.init(self)

	-- Ok everything is good to go, activate the game in the engine!
	self:setCurrent()

	if self.level then self:setupDisplayMode() end
end

function _M:newGame()
	self:ensureDbtSettings()
	self:playIntro()
	self.player = Player.new{name=self.player_name, game_ender=true}
	Map:setViewerActor(self.player)
	self:setupDisplayMode()

	self.creating_player = true
	local birth = Birther.new(nil, self.player, {"base", "sex"}, function()
		self:changeLevel(1, "earth5")
		print("[PLAYER BIRTH] resolve...")
		self.player:resolve()
		self.player:resolve(nil, true)
		self.paused = true
		self:registerDialog(require("mod.dialogs.Stats").new(self.player, function()
			self.player:applyStatEffects(true)
			self:grantGear()
			self.player.energy.value = self.energy_to_act
			self.paused = true
			self.creating_player = false
			print("[PLAYER BIRTH] resolved!")
		end))
	end)
	self:registerDialog(birth)
end

function _M:grantGear()
	local Object = require "mod.class.Object"
	local stock = Object:loadList("/data/general/objects/stock.lua")
	local notes = Object:loadList("/data/general/objects/gear.lua")
	local player = self.player
	player.money = player:startingZeni()
	if player.ensureSkills then self:loadTraining() player:ensureSkills() end
	local function take(list, id)
		local e = list[id]
		assert(e, "missing object "..tostring(id))
		local o = e:clone()
		o:resolve()
		o:resolve(nil, true)
		return o
	end
	local function wear(id)
		local o = take(stock, id)
		local worn = player:wearObject(o, true, true)
		if not worn then
			player:addObject(player.INVEN_INVEN, o)
			self.log("You are carrying %s.", o:getName())
		end
	end
	wear("KUBOTAN")
	wear("STREET_CLOTHES")
	local female = player.female or (player.descriptor and player.descriptor.sex == "Female")
	if female then wear("HIGH_HEELS") else wear("TENNIS_SHOES") end
	player:addObject(player.INVEN_INVEN, take(stock, "POWER_BAR"))
	local note = take(notes, "SLICE_NOTE")
	player:addObject(player.INVEN_INVEN, note)
	if player.ensureQuests then player:ensureQuests() end
	player:sortInven(player.INVEN_INVEN)
	self.log("#LIGHT_BLUE#You have %d zeni. Street clothes, shoes, and a kubotan are worn. A power bar is in your pack.", player.money)
	self.log("#LIGHT_BLUE#%s:#LAST# %s", note.name:capitalize(), note.desc)
end

function _M:loaded()
	engine.GameTurnBased.loaded(self)
	Zone:setup{npc_class="mod.class.NPC", grid_class="mod.class.Grid", object_class="mod.class.Object"}
	if self.player and self.player.ensureQuests then self.player:ensureQuests() end
	if self.player and self.player.ensureInventory then self.player:ensureInventory() end
	if self.player and self.player.ensureSkills then self:loadTraining() self.player:ensureSkills() end
	if self.player and self.player.syncChiTalents then self.player:syncChiTalents() end
	if self.player and self.player.applyStatEffects then self.player:applyStatEffects() end
	if self.openUranaiBasement then self:openUranaiBasement() end
	if self.syncTournamentQuest and self.player then self:syncTournamentQuest(self.player) end
	if self.retargetEntrances then self:retargetEntrances() end
	if self.calmTournament then self:calmTournament() end
	if self.populateEarth then self:populateEarth() end
	Map:setViewerActor(self.player)
	Map:setViewPort(200, 20, self.w - 200, math.floor(self.h * 0.80) - 20, 32, 32, nil, 22, true)
	self.key = engine.KeyBind.new()
end

function _M:setupDisplayMode()
	self:ensureDbtSettings()
	local tiles = config.settings.dbt.tiles and self:dbtTilesReady()
	print("[DISPLAY MODE] 32x32", tiles and "tiles" or "ASCII")
	Map:setViewPort(200, 20, self.w - 200, math.floor(self.h * 0.80) - 20, 32, 32, nil, 22, true)
	Map:resetTiles()
	Map.tiles.use_images = tiles and true or false

	if self.level then
		self.level.map:recreate()
		engine.interface.GameTargeting.init(self)
		self.level.map:moveViewSurround(self.player.x, self.player.y, 8, 8)
	end
end

function _M:dbtTilesReady()
	return fs.exists("/data/gfx/dbz.png") and fs.exists("/data/gfx/blasts.png")
end

function _M:ensureDbtSettings()
	config.settings.dbt = config.settings.dbt or {}
	local d = config.settings.dbt
	local audio = config.settings.audio or {}
	if d.music == nil then d.music = true end
	if d.effects == nil then d.effects = true end
	if d.tiles == nil then d.tiles = false end
	if d.music_volume == nil then d.music_volume = audio.music_volume or 100 end
	if d.effects_volume == nil then d.effects_volume = audio.effects_volume or 100 end
	d.music = d.music and true or false
	d.effects = d.effects and true or false
	d.tiles = (d.tiles and self:dbtTilesReady()) and true or false
	d.music_volume = util.bound(math.floor(d.music_volume + 0.5), 0, 100)
	d.effects_volume = util.bound(math.floor(d.effects_volume + 0.5), 0, 100)
end

function _M:mirrorDbtSettings()
	self:ensureDbtSettings()
	local d = config.settings.dbt
	self.dbt_settings = {
		tiles = d.tiles,
		music = d.music,
		effects = d.effects,
		music_volume = d.music_volume,
		effects_volume = d.effects_volume,
	}
end

function _M:syncDbtSettings()
	self:ensureDbtSettings()
	if self.dbt_settings then
		local s = self.dbt_settings
		local d = config.settings.dbt
		if s.music ~= nil then d.music = s.music and true or false end
		if s.effects ~= nil then d.effects = s.effects and true or false end
		if s.tiles ~= nil then d.tiles = s.tiles and true or false end
		if s.music_volume ~= nil then d.music_volume = s.music_volume end
		if s.effects_volume ~= nil then d.effects_volume = s.effects_volume end
	end
	self:ensureDbtSettings()
	self:mirrorDbtSettings()
end

function _M:saveDbtSettings()
	self:mirrorDbtSettings()
	local d = self.dbt_settings
	self:saveSettings("dbt", ([[dbt = {
	tiles = %s,
	music = %s,
	effects = %s,
	music_volume = %d,
	effects_volume = %d,
}
]]):format(tostring(d.tiles), tostring(d.music), tostring(d.effects), d.music_volume, d.effects_volume))
end

function _M:setDbtTiles(on)
	self:ensureDbtSettings()
	local want = on and self:dbtTilesReady()
	config.settings.dbt.tiles = want and true or false
	self:saveDbtSettings()
	local use_images = want and true or false
	if Map.tiles.use_images ~= use_images then self:setupDisplayMode() end
	return config.settings.dbt.tiles
end

function _M:setDbtChannel(channel, on)
	self:ensureDbtSettings()
	config.settings.dbt[channel] = on and true or false
	if channel == "music" and not config.settings.dbt.music then self:dbtStopMusic() end
	if channel == "effects" and not config.settings.dbt.effects then self:dbtStopEffects() end
	if channel == "music" and config.settings.dbt.music_volume <= 0 then self:dbtStopMusic() end
	if channel == "effects" and config.settings.dbt.effects_volume <= 0 then self:dbtStopEffects() end
	self:saveDbtSettings()
end

function _M:setDbtVolume(channel, vol)
	self:ensureDbtSettings()
	vol = util.bound(math.floor(vol + 0.5), 0, 100)
	if channel == "music" then
		config.settings.dbt.music_volume = vol
		if vol <= 0 or not config.settings.dbt.music then
			self:dbtStopMusic()
		elseif self.dbt_music then
			self.dbt_music:volume(vol / 100)
		end
	else
		config.settings.dbt.effects_volume = vol
		if vol <= 0 or not config.settings.dbt.effects then
			self:dbtStopEffects()
		elseif self.dbt_effects then
			for source, _ in pairs(self.dbt_effects) do source:volume(vol / 100) end
		end
	end
	self:saveDbtSettings()
end

function _M:dbtStopSource(source)
	if not source then return end
	pcall(function() source:stop() end)
end

function _M:dbtStopMusic()
	self:dbtStopSource(self.dbt_music)
	self.dbt_music = nil
end

function _M:dbtStopEffects()
	if not self.dbt_effects then return end
	for source, _ in pairs(self.dbt_effects) do self:dbtStopSource(source) end
	self.dbt_effects = {}
end

function _M:dbtCleanSounds()
	if not self.dbt_effects then return end
	local dead = {}
	for source, _ in pairs(self.dbt_effects) do
		local ok, playing = pcall(function() return source:playing() end)
		if not ok or not playing then dead[#dead + 1] = source end
	end
	for i = 1, #dead do self.dbt_effects[dead[i]] = nil end
end

function _M:dbtPlay(channel, name)
	self:ensureDbtSettings()
	local d = config.settings.dbt
	local enabled = channel == "music" and d.music or d.effects
	local vol = channel == "music" and d.music_volume or d.effects_volume
	if not enabled or vol <= 0 then return end
	if config.settings.audio and config.settings.audio.enable == false then return end
	local path = "/data/sound/"..name..".ogg"
	if not fs.exists(path) then
		print("[DBT SOUND] missing", path)
		return
	end
	local ok, sample = pcall(core.sound.load, path, false)
	if not ok or not sample then
		print("[DBT SOUND] failed", name, sample)
		return
	end
	local source = sample:use()
	source:volume(vol / 100)
	if channel == "music" then
		self:dbtStopMusic()
		self.dbt_music = source
	else
		self.dbt_effects = self.dbt_effects or {}
		self.dbt_effects[source] = true
	end
	source:play()
end

function _M:playIntro()
	local sec = tonumber(os.date("%S")) or 1
	local name = "intro3"
	if sec < 21 then name = "intro1"
	elseif sec < 41 then name = "intro2" end
	self:dbtPlay("music", name)
end

function _M:save()
	self:mirrorDbtSettings()
	return class.save(self, self:defaultSavedFields{dbt_settings=true, earth_return=true, uranai_return=true, dojo_return=true, dojo_duel=true, dojo_won=true}, true)
end

function _M:getSaveDescription()
	return {
		name = self.player.name,
		description = ([[Exploring level %d of %s.]]):format(self.level.level, self.zone.name),
	}
end

function _M:leaveLevel(level, lev, old_lev)
	if level:hasEntity(self.player) then
		level.exited = level.exited or {}
		if lev > old_lev then
			level.exited.down = {x=self.player.x, y=self.player.y}
		else
			level.exited.up = {x=self.player.x, y=self.player.y}
		end
		level.last_turn = game.turn
		level:removeEntity(self.player)
	end
end

function _M:changeLevel(lev, zone, params)
	params = params or {}
	local old_lev = (self.level and not zone) and self.level.level or -1000
	if zone then
		if self.zone then
			self.zone:leaveLevel(false, lev, old_lev)
			self.zone:leave()
		end
		if type(zone) == "string" then
			self.zone = Zone.new(zone)
		else
			self.zone = zone
		end
	end
	self.zone:getLevel(self, lev, old_lev)

	local sx, sy
	if params.x and params.y then
		sx, sy = params.x, params.y
	elseif params.spawn == "down" then
		sx, sy = self.level.default_down.x, self.level.default_down.y
	elseif lev > old_lev then
		sx, sy = self.level.default_up.x, self.level.default_up.y
	else
		sx, sy = self.level.default_down.x, self.level.default_down.y
	end
	if self.zone.short_name == "tournament" and not (params.x and params.y) then
		sx, sy = 3, 23
	end
	self.player:move(sx, sy, true)
	self.level:addEntity(self.player)
	if self.bringParty then self:bringParty() end
	self:playArrival()
	if self.level.map then self.level.map:moveViewSurround(self.player.x, self.player.y, 8, 8) end
	if params.crossed then
		self.log("You cross into %s.", self.zone.name)
	elseif self.zone.short_name == "closed" and self.earth_return and self.earth_return.name then
		self.log("%s is not open yet. Press > to go back.", self.earth_return.name)
	end
	if self.retargetEntrances then self:retargetEntrances() end
	if self.calmTournament then self:calmTournament() end
	if self.populateEarth then self:populateEarth() end
end

function _M:playArrival()
	local p = self.player
	local z = self.zone and self.zone.short_name
	if not p or not z then return end
	p.dbt_heard = p.dbt_heard or {}
	if (z == "gero" or z == "shq" or z == "shq1" or z == "shq2" or z == "shq3") and not p.dbt_heard[z] then
		p.dbt_heard[z] = true
		if self.dbtPlay then self:dbtPlay("effects", "ominous") end
		if z == "gero" then self.log("...you have a very bad feeling about this...") end
	end
	local tool = p.getInven and p:getInven("TOOL")
	local held = tool and tool[1]
	if held and held.name and held.name:lower():find("radar") and not p.dbt_heard["radar-" .. z] then
		p.dbt_heard["radar-" .. z] = true
		self.log("The Dragon Radar indicates a Dragonball is nearby!")
		if self.dbtPlay then self:dbtPlay("effects", "radarblip") end
	end
	local balls = 0
	if p.dragonballs then for _ in pairs(p.dragonballs) do balls = balls + 1 end end
	if balls > 0 and held and held.name and held.name:lower():find("radar") and not p.dbt_heard["warp-" .. z] then
		p.dbt_heard["warp-" .. z] = true
		if self.dbtPlay then self:dbtPlay("effects", "dbbwarp") end
	end
end

function _M:bringParty()
	local p = self.player
	local list = self.zone and self.zone.npc_list
	local map = self.level and self.level.map
	if not p or not p.party or not list or not map then return end
	local Map = require "engine.Map"
	local spots = {}
	for dy = -1, 1 do
		for dx = -1, 1 do
			if not (dx == 0 and dy == 0) then spots[#spots + 1] = {p.x + dx, p.y + dy} end
		end
	end
	local n = 1
	for _, mate in ipairs(p.party) do
		if not mate.stay then
			local proto = list[mate.define_as]
			local spot = spots[n]
			n = n + 1
			if proto and spot then
				local x, y = spot[1], spot[2]
				local g = map(x, y, Map.TERRAIN)
				local a = map(x, y, Map.ACTOR)
				if g and not g.does_block_move and not a then
					local m = proto:clone()
					m.faction = p.faction or "neutral"
					m.dbt_partied = true
					m.ai = "none"
					m.never_move = false
					m:resolve()
					m:resolve(nil, true)
					self.zone:addEntity(self.level, m, "actor", x, y)
				end
			end
		end
	end
end

-- 3x3 Earth, matching the wilderness towns. North of Earth 7 wraps to Earth 1.
_M.earth_links = {
	earth1 = {n="earth4", s="earth7", w="earth3", e="earth2"},
	earth2 = {n="earth5", s="earth8", w="earth1", e="earth3"},
	earth3 = {n="earth6", s="earth9", w="earth2", e="earth1"},
	earth4 = {n="earth7", s="earth1", w="earth6", e="earth5"},
	earth5 = {n="earth8", s="earth2", w="earth4", e="earth6"},
	earth6 = {n="earth9", s="earth3", w="earth5", e="earth4"},
	earth7 = {n="earth1", s="earth4", w="earth9", e="earth8"},
	earth8 = {n="earth2", s="earth5", w="earth7", e="earth9"},
	earth9 = {n="earth3", s="earth6", w="earth8", e="earth7"},
}

-- Wilderness min_monsters. Each Earth screen is one wilderness square.
local EARTH_SPAWN_COUNT = 14

--- Old get_mon_num: nothing above the allocation depth, and a race near that depth is more common.
function _M:monsterWeight(mon, depth)
	local lv = mon.level or 1
	if lv > depth then return 0 end
	local gap = math.min(5, depth - lv)
	return math.floor(100 / math.max(1, mon.rarity or 1)) * (6 - gap)
end

function _M:populateEarth()
	local zone = self.zone and self.zone.short_name
	local map = self.level and self.level.map
	local p = self.player
	if not zone or not map or not p then return end
	self:loadTraining()
	local spec = dbt_earth_zones and dbt_earth_zones[zone]
	local book = dbt_earth_monsters
	if not spec or not book then return end
	p.earth_spawned = p.earth_spawned or {}
	if p.earth_spawned[zone] then return end
	local list = self.zone.npc_list
	if not list then return end

	local want = {}
	for _, band in ipairs(spec.bands) do want[band] = true end
	local pool, total = {}, 0
	for _, mon in ipairs(book) do
		if list[mon.id] and (mon.level or 1) <= spec.level then
			local ok = false
			for _, band in ipairs(mon.bands) do
				if want[band] then ok = true; break end
			end
			if ok then
				local dist = math.abs((mon.level or 1) - spec.level)
				local weight = math.max(1, math.floor(100 / math.max(1, mon.rarity or 1))) * math.max(1, 6 - dist)
				total = total + weight
				pool[#pool + 1] = {id = mon.id, weight = weight}
			end
		end
	end
	if total == 0 then
		print("[DBT] no earth spawns for", zone)
		p.earth_spawned[zone] = true
		return
	end

	local function take(spots)
		if #spots == 0 then return end
		return table.remove(spots, rng.range(1, #spots))
	end
	local near, far = {}, {}
	for x = 1, map.w - 2 do
		for y = 1, map.h - 2 do
			local g = map(x, y, Map.TERRAIN)
			if g and not g.does_block_move and not g.change_level and not g.store_id and not map(x, y, Map.ACTOR) then
				local dist = math.max(math.abs(x - p.x), math.abs(y - p.y))
				if dist > 2 and dist <= 45 then near[#near + 1] = {x, y}
				elseif dist > 45 then far[#far + 1] = {x, y} end
			end
		end
	end

	local function choose()
		local roll = rng.range(1, total)
		local acc = 0
		for _, mon in ipairs(pool) do
			acc = acc + mon.weight
			if roll <= acc then return mon.id end
		end
		return pool[1].id
	end

	local placed = 0
	for i = 1, EARTH_SPAWN_COUNT do
		local spot = (i <= 8) and (take(near) or take(far)) or (take(far) or take(near))
		if not spot then break end
		local proto = list[choose()]
		local m = proto:clone()
		m:resolve()
		m:resolve(nil, true)
		m.faction = "enemies"
		m.ai = "simple"
		m.ai_state = m.ai_state or {talent_in = 3}
		m.never_move = false
		self.zone:addEntity(self.level, m, "actor", spot[1], spot[2])
		placed = placed + 1
	end
	p.earth_spawned[zone] = true
	print("[DBT] spawned", placed, "on", zone)
end

--- Sewers are depths 5-8, ten creatures, and the dungeon item theme. The lair is the static bottom.
function _M:stockSewer(level)
	if not level or level.level >= 5 then return end
	local map = level.map
	if not map or not self.zone then return end
	self:loadTraining()
	local depth = 4 + level.level
	local list = self.zone.npc_list or {}
	local pool, total = {}, 0
	for _, mon in ipairs(dbt_sewer_monsters or {}) do
		if list[mon.id] and not (mon.unique and self.player and self.player.sewer_uniques and self.player.sewer_uniques[mon.id]) then
			local weight = self:monsterWeight(mon, depth)
			if weight > 0 then
				total = total + weight
				pool[#pool + 1] = {id = mon.id, weight = weight, unique = mon.unique}
			end
		end
	end
	local function choose()
		if total <= 0 then return end
		local roll, acc = rng.range(1, total), 0
		for _, mon in ipairs(pool) do
			acc = acc + mon.weight
			if roll <= acc then return mon end
		end
		return pool[1]
	end
	local spots = {}
	local ux = level.default_up and level.default_up.x
	local uy = level.default_up and level.default_up.y
	for x = 1, map.w - 2 do
		for y = 1, map.h - 2 do
			local g = map(x, y, Map.TERRAIN)
			if g and not g.does_block_move and not g.change_level and not map(x, y, Map.ACTOR) then
				if not (ux and math.max(math.abs(x - ux), math.abs(y - uy)) <= 2) then
					spots[#spots + 1] = {x, y}
				end
			end
		end
	end
	local function take()
		if #spots == 0 then return end
		return table.remove(spots, rng.range(1, #spots))
	end
	for _ = 1, 10 do
		local mon = choose()
		local spot = take()
		if not mon or not spot then break end
		local proto = list[mon.id]
		local m = proto:clone()
		m:resolve()
		m:resolve(nil, true)
		if mon.id == "RACE_FLORINIFERA" then
			m.faction = "neutral"
			m.ai = "none"
			m.never_move = true
		else
			m.faction = "enemies"
			m.ai = "simple"
			m.ai_state = m.ai_state or {talent_in = 3}
			m.never_move = false
		end
		if mon.unique and self.player then
			self.player.sewer_uniques = self.player.sewer_uniques or {}
			self.player.sewer_uniques[mon.id] = true
		end
		self.zone:addEntity(level, m, "actor", spot[1], spot[2])
	end
	local themes = {PLAIN = 40, ACCESSORY = 30, JUNK = 5, GOLD = 20, TOXIC = 5}
	for _ = 1, rng.range(2, 4) do
		local spot = take()
		local o = self:makeThemedObject(themes, depth, depth)
		if spot and o then
			o:resolve()
			o:resolve(nil, true)
			self.zone:addEntity(level, o, "object", spot[1], spot[2])
		end
	end
end

--- Temple floors under the entrance map and above the catacombs. Twenty monks, martial drops.
function _M:stockTemple(level)
	if not level or level.level < 2 or level.level > 6 then return end
	local map = level.map
	if not map or not self.zone then return end
	self:loadTraining()
	local depth = 16 + level.level
	local list = self.zone.npc_list or {}
	local pool, total = {}, 0
	for _, mon in ipairs(dbt_temple_monsters or {}) do
		if list[mon.id] then
			local weight = self:monsterWeight(mon, depth)
			if weight > 0 then
				total = total + weight
				pool[#pool + 1] = {id = mon.id, weight = weight}
			end
		end
	end
	local function choose()
		if total <= 0 then return end
		local roll, acc = rng.range(1, total), 0
		for _, mon in ipairs(pool) do
			acc = acc + mon.weight
			if roll <= acc then return mon end
		end
		return pool[1]
	end
	local spots = {}
	local ux = level.default_up and level.default_up.x
	local uy = level.default_up and level.default_up.y
	for x = 1, map.w - 2 do
		for y = 1, map.h - 2 do
			local g = map(x, y, Map.TERRAIN)
			if g and not g.does_block_move and not g.change_level and not map(x, y, Map.ACTOR) then
				if not (ux and math.max(math.abs(x - ux), math.abs(y - uy)) <= 2) then
					spots[#spots + 1] = {x, y}
				end
			end
		end
	end
	local function take()
		if #spots == 0 then return end
		return table.remove(spots, rng.range(1, #spots))
	end
	for _ = 1, 20 do
		local mon = choose()
		local spot = take()
		if not mon or not spot then break end
		local m = list[mon.id]:clone()
		m:resolve()
		m:resolve(nil, true)
		m.faction = "enemies"
		m.ai = "simple"
		m.ai_state = m.ai_state or {talent_in = 3}
		m.never_move = false
		self.zone:addEntity(level, m, "actor", spot[1], spot[2])
	end
	for _ = 1, rng.range(2, 4) do
		local spot = take()
		local o = self:makeThemedObject({MARTIAL = 100}, depth, depth)
		if spot and o then
			o:resolve()
			o:resolve(nil, true)
			self.zone:addEntity(level, o, "object", spot[1], spot[2])
		end
	end
end

function _M:noteKill(actor, src)
	if not src or not src.player or not actor then return end
	src:ensureQuests()
	if actor.dbt_quest == "white_wolf" then
		src.white_wolf = "slain"
		local q = src.quests.white_wolf
		if q and q.status == "taken" then
			q.status = "completed"
			self.log("The white wolf is dead.")
		end
	elseif actor.dbt_quest == "temple" then
		local q = src.quests.temple
		if q and q.status == "taken" then
			q.status = "completed"
			self.log("The ringleader falls. The Abbot is free.")
		end
	end
	if src.tourny_now then return end
	local id = actor.define_as
	if id == "RACE_POLICE" then
		src.police_killed = (src.police_killed or 0) + 1
		local q = src.quests.criminal
		if q and q.status == "taken" then
			q.desc = ("Threatening Elizabeth was bad enough, but now you're on the books for the death of %d police officers! It's going to be awfully difficult to clear your name now."):format(src.police_killed)
		end
		return
	end
	local function finishThief(quest_id, dbs, dead_msg)
		local q = src.quests[quest_id]
		if not q or q.status ~= "taken" then return end
		self.log(dead_msg)
		if (dbs or 0) > 1 then
			self.log("Unfortunately he only seems to have a single dragonball on him.")
		end
		src:takeQuest(quest_id, "finished")
	end
	if id == "RACE_BEAR_THIEF" then
		finishThief("bear_thief", src.bear_thief_dbs, "At last! The Bear Thief is dead!")
		return
	elseif id == "RACE_HASUKI" then
		finishThief("hasuki", src.hasuki_dbs, "At last! Hasuki is dead!")
		return
	end
	local schools = {
		RACE_NAKAMURA = {school="KARATE", boost="KICKBOXING", quest="challenge_karate", taken="Yeah, you knew he'd be a pushover.", other="Ashamed of his defeat, Nakamura returns to Japan to train."},
		RACE_BOB = {school="KICKBOXING", boost="KARATE", quest="challenge_kickboxing", taken="Precision and control does indeed defeat callous, brute strength.", other="Ashamed of his defeat, Bob leaves town to train."},
		RACE_FONG_SAI_YUK = {school="KUNGFU", boost="FENCING", quest="challenge_kungfu", taken="Most excellent! Fong-Sai Yuk has been defeated!", other="Ashamed of his defeat, Fong-Sai Yuk closes his school to train in the woods."},
		RACE_JACQUE = {school="FENCING", boost="KUNGFU", quest="challenge_fencing", taken="Yup! Frenchie is gone!", other="Ashamed of his defeat, Jacque closes his school and retires."},
		RACE_MASTER_LEE = {school="TAEKWONDO", quest="challenge_taekwondo", taken="Yeah...you didn't think it would be too tough.", other="Accepting his defeat with courage, Master Lee closes his studio to train."},
		RACE_YAWARA = {school="JUDO", boost="SUMO", quest="challenge_judo", yawara=true},
		RACE_HONDA = {school="SUMO", boost="JUDO", quest="challenge_sumo", taken="Congratulations! You've defeated Honda! Yawara will be ecstatic, I'm sure! As for Honda, he is so shocked at his defeat by someone so much smaller than he, and he decides to close his school to dedicate himself more fully to his training.", other="With Honda dead, his school will now close."},
	}
	local row = schools[id]
	if not row then return end
	local duel = self.dojo_duel and dbt_dojos and dbt_dojos[self.dojo_duel]
	if duel and duel.master == id then return end
	src.schools_closed[row.school] = true
	src.trainers = src.trainers or {}
	if row.boost then src.trainers[row.boost] = true end
	local q = src.quests[row.quest]
	if row.yawara then
		if q and q.status == "completed" then
			self.log("Yawara is saddened, but acknowledges her defeat and decides to close her school so that she may dedicate herself more completely to her training.")
		else
			self.log("With Yawara dead, her school will now close.")
		end
		return
	end
	if q and q.status == "taken" then
		q.status = "completed"
		self.log(row.taken)
	else
		self.log(row.other)
	end
end

--- Generated floors. The static maps in the same zone are outside from_level..to_level.
function _M:stockDen(level)
	if not level or not self.zone then return end
	self:loadTraining()
	local den = dbt_dens and self.zone.short_name and dbt_dens[self.zone.short_name]
	if not den then return end
	if level.level < (den.from_level or 1) or level.level > (den.to_level or 1) then return end
	local map = level.map
	if not map then return end
	local list = self.zone.npc_list or {}
	local depth = (den.depth_base or 0) + level.level
	local pool, total = {}, 0
	for _, mon in ipairs(den.monsters or {}) do
		if list[mon.id] and not (mon.unique and self.player and self.player.den_uniques and self.player.den_uniques[mon.id]) then
			local weight = self:monsterWeight(mon, depth)
			if weight > 0 then
				total = total + weight
				pool[#pool + 1] = mon
			end
		end
	end
	local function choose()
		if total <= 0 then return end
		local roll, acc = rng.range(1, total), 0
		for _, mon in ipairs(pool) do
			acc = acc + self:monsterWeight(mon, depth)
			if roll <= acc then return mon end
		end
		return pool[1]
	end
	local spots = {}
	local ux = level.default_up and level.default_up.x
	local uy = level.default_up and level.default_up.y
	for x = 1, map.w - 2 do
		for y = 1, map.h - 2 do
			local g = map(x, y, Map.TERRAIN)
			if g and not g.does_block_move and not g.change_level and not map(x, y, Map.ACTOR) then
				if not (ux and math.max(math.abs(x - ux), math.abs(y - uy)) <= 2) then
					spots[#spots + 1] = {x, y}
				end
			end
		end
	end
	local function take()
		if #spots == 0 then return end
		return table.remove(spots, rng.range(1, #spots))
	end
	for _ = 1, den.count or 10 do
		local mon = choose()
		local spot = take()
		if not mon or not spot then break end
		local m = list[mon.id]:clone()
		m:resolve()
		m:resolve(nil, true)
		m.faction = "enemies"
		m.ai = "simple"
		m.ai_state = m.ai_state or {talent_in = 3}
		m.never_move = false
		if mon.unique and self.player then
			self.player.den_uniques = self.player.den_uniques or {}
			self.player.den_uniques[mon.id] = true
		end
		self.zone:addEntity(level, m, "actor", spot[1], spot[2])
	end
	for _ = 1, rng.range(2, 4) do
		local spot = take()
		local o = self:makeThemedObject(den.themes or {PLAIN = 100}, depth, depth)
		if spot and o then
			o:resolve()
			o:resolve(nil, true)
			self.zone:addEntity(level, o, "object", spot[1], spot[2])
		end
	end
end

function _M:nearestCrossing(list, index)
	local function spot(i)
		if i < 1 or i > #list - 2 then return end
		local v = list[i + 1]
		if v and v > 0 then return i, v end
	end
	local at, inward = spot(index)
	if at then return at, inward end
	for dist = 1, #list do
		at, inward = spot(index + dist)
		if at then return at, inward end
		at, inward = spot(index - dist)
		if at then return at, inward end
	end
end

function _M:loadStores()
	if dbt_stores then return dbt_stores end
	local f, err = loadfile("/data/stores.lua")
	if not f then
		print("[DBT] could not load stores", err)
		return nil
	end
	local ok, run_err = pcall(f)
	if not ok then
		print("[DBT] stores failed", run_err)
		return nil
	end
	return dbt_stores
end

function _M:stockList()
	if self.dbt_stock then return self.dbt_stock end
	local Object = require "mod.class.Object"
	self.dbt_stock = Object:loadList("/data/general/objects/stock.lua")
	return self.dbt_stock
end

function _M:enterStore(id)
	local stores = self:loadStores()
	local store = stores and stores[id]
	if not store or not store.items or #store.items == 0 then
		self.log("This place is not open yet.")
		return
	end
	local Store = require "mod.dialogs.Store"
	store.dbt_id = id
	self:registerDialog(Store.new(store, self.player, self:stockList()))
end

function _M:loadTraining()
	local function run(path, already)
		if already then return true end
		local f, err = loadfile(path)
		if not f then
			print("[DBT] could not load", path, err)
			return false
		end
		local ok, run_err = pcall(f)
		if not ok then
			print("[DBT] failed", path, run_err)
			return false
		end
		return true
	end
	run("/data/skills.lua", dbt_skills)
	run("/data/schools.lua", dbt_schools)
	run("/data/dojos.lua", dbt_dojos)
	run("/data/dojo_caps.lua", dbt_cap_step)
	run("/data/tournament.lua", dbt_tourny)
	run("/data/earth_spawns.lua", dbt_earth_zones)
	run("/data/drops.lua", dbt_drop_races)
	run("/data/sewers.lua", dbt_sewer_monsters)
	run("/data/masters.lua", dbt_masters)
	run("/data/dens.lua", dbt_dens)
	run("/data/quests.lua", dbt_quest_catalog)
	run("/data/talks.lua", dbt_talks_ready)
	dbt_skill_by_id = dbt_skill_by_id or {}
	dbt_ability_by_id = dbt_ability_by_id or {}
	if dbt_skills then
		for _, s in ipairs(dbt_skills) do dbt_skill_by_id[s.id] = s end
	end
	if dbt_abilities then
		for _, a in ipairs(dbt_abilities) do dbt_ability_by_id[a.id] = a end
	end
	return dbt_skills ~= nil and dbt_schools ~= nil
end

function _M:lootList()
	if self.dbt_loot then return self.dbt_loot end
	local Object = require "mod.class.Object"
	self.dbt_loot = Object:loadList("/data/general/objects/loot.lua")
	return self.dbt_loot
end

function _M:placeDrop(actor, x, y, o)
	if not o or not x or not y then return end
	o:resolve()
	o:resolve(nil, true)
	self.zone:addEntity(self.level, o, "object", x, y)
	local who = actor.name or "Something"
	who = who:gsub("^%l", string.upper)
	self.log("%s drops %s.", who, o.name or "something")
end

function _M:itemCatalog()
	if self.dbt_catalog then return self.dbt_catalog end
	local Object = require "mod.class.Object"
	local cat = {}
	local stock = self:stockList()
	if stock then
		for k, v in pairs(stock) do
			if type(k) == "string" then cat[k] = v end
		end
	end
	local ok, world = pcall(Object.loadList, Object, "/data/general/objects/world.lua")
	if ok and type(world) == "table" then
		for k, v in pairs(world) do
			if type(k) == "string" then cat[k] = v end
		end
	else
		print("[DBT] world items failed", world)
	end
	if cat.CAPSULE_SPACESHIP then cat.CAPSULE_SPACESHIP.dbt_use = "ship" end
	self.dbt_catalog = cat
	return cat
end

function _M:cloneStock(id)
	local list = self:itemCatalog()
	local proto = list and list[id]
	if not proto then return end
	local o = proto:clone()
	local meta = dbt_drop_by_id and dbt_drop_by_id[id]
	if meta then
		o.dbt_tval = meta.tval
		if meta.sval and meta.sval ~= "" then o.dbt_sval = meta.sval end
		if (meta.fuel or 0) > 0 then o.dbt_fuel = meta.fuel end
		if (meta.lite or 0) > 0 then
			o.dbt_lite = meta.lite
			o.wielder = o.wielder or {}
			o.wielder.lite = (o.wielder.lite or 0) + meta.lite
		end
		if (meta.range or 0) > 0 then o.dbt_range = meta.range end
	end
	return o
end

--- dball.egoify. One ego, level at or under the object level, weighted by allocation.
function _M:egoify(o, dun, object_level)
	if not o or not o.dbt_tval then return end
	local e_chance = 5 + math.floor((dun or 0) / 5)
	if e_chance < 50 then e_chance = 50 end
	if rng.range(1, 100) >= e_chance then return end
	local pool, total = {}, 0
	local level = object_level or 0
	for _, ego in ipairs(dbt_egos or {}) do
		if (ego.level or 1) <= level and ego.tvals and ego.tvals[o.dbt_tval] then
			local allow = ego.svals and ego.svals[o.dbt_tval]
			local ok = not allow
			if allow then
				for _, sv in ipairs(allow) do
					if sv == o.dbt_sval then ok = true; break end
				end
			end
			if ok then
				local w = ego.alloc or 100
				pool[#pool + 1] = {ego = ego, w = w}
				total = total + w
			end
		end
	end
	if total <= 0 then return end
	local roll, acc = rng.range(1, total), 0
	for _, entry in ipairs(pool) do
		acc = acc + entry.w
		if roll <= acc then self:applyEgo(o, entry.ego); return end
	end
end

function _M:applyEgo(o, ego)
	o.dbt_plain_name = o.dbt_plain_name or o.name
	o.dbt_ego = ego.id
	o.cost = (o.cost or 0) + (ego.value_add or 0)
	if (ego.to_h or 0) ~= 0 then o.dbt_to_h = (o.dbt_to_h or 0) + ego.to_h end
	if (ego.to_d or 0) ~= 0 then o.dbt_to_d = (o.dbt_to_d or 0) + ego.to_d end
	if ego.place == "after" then
		o.name = (o.name or "item") .. " " .. ego.affix
	else
		o.name = ego.affix .. " " .. (o.name or "item")
	end
	if ego.desc and ego.desc ~= "" then
		o.desc = ((o.desc and o.desc ~= "") and (o.desc .. " ") or "") .. ego.desc
	end
	local effect = ego.effect
	if effect == "weighted" then
		local w = rng.range(1, 10)
		o.encumber = (o.encumber or 0) + (w * 50)
		o.dbt_to_h = (o.dbt_to_h or 0) - w
	elseif effect == "resist" then
		o.dbt_resist = o.dbt_resist or {}
		o.dbt_resist[ego.resist] = (o.dbt_resist[ego.resist] or 0) + (ego.n or 0)
	elseif effect == "stat" then
		o.dbt_stats = o.dbt_stats or {}
		o.dbt_stats[ego.stat] = (o.dbt_stats[ego.stat] or 0) + (ego.n or 0)
	elseif effect == "speed" then
		o.dbt_stats = o.dbt_stats or {}
		o.dbt_stats.spd = (o.dbt_stats.spd or 0) + rng.range(1, 5)
	elseif effect == "to_a" then
		o.dbt_to_a = (o.dbt_to_a or 0) + (ego.n or 0)
	elseif effect == "spike" then
		o.dbt_spike = {1, 6}
	elseif effect == "res_blind" then
		o.dbt_res_blind = true
	elseif effect == "vorpal" then
		o.dbt_vorpal = true
	elseif effect == "steel" then
		local weight = o.encumber or 0
		o.dbt_to_d = (o.dbt_to_d or 0) + math.floor(weight / 2)
		o.dbt_to_h = 0
		o.encumber = weight * 10
		o.difficulty = ((o.difficulty or 0) + 2) * 2
	elseif effect == "poor" or effect == "squeaky" or effect == "price" then
		o.cost = math.max(0, (o.cost or 0) + (ego.n or 0))
		if effect == "poor" then o.difficulty = (o.difficulty or 0) * 2 end
		if effect == "squeaky" then o.dbt_aggravate = true end
	elseif effect == "range" then
		if o.dbt_range and o.dbt_range > 0 then o.dbt_range = o.dbt_range + (ego.n or 0) end
	elseif effect == "capacity" then
		if o.capacity and o.capacity > 0 then
			o.capacity = o.capacity + rng.range(1, o.capacity * 2)
		end
	elseif effect == "inaccurate" then
		o.dbt_inaccurate = true
	elseif effect == "stealth" then
		o.dbt_stealth = (o.dbt_stealth or 0) + (ego.n or 0)
	elseif effect == "lite" then
		o.dbt_lite = (o.dbt_lite or 0) + 1
		o.wielder = o.wielder or {}
		o.wielder.lite = (o.wielder.lite or 0) + 1
	elseif effect == "fuel" then
		if o.dbt_fuel and o.dbt_fuel > 0 then o.dbt_fuel = o.dbt_fuel * 3 end
	elseif effect == "stun" then
		local dice = {TASER = {2, 20}, STUN_BATON = {4, 40}, CATTLE_PROD = {6, 60}}
		o.dbt_stun = dice[o.dbt_sval] or {2, 20}
		if o.combat then o.combat.dice = nil; o.combat.dam = 0 end
	end
end

--- objects_on_make_all. Good and broken rolls add to-hit, damage, or armor.
function _M:applyPower(o, object_level)
	if not o or not o.dbt_tval then return end
	local lev = math.min(100, object_level or 0)
	local f1 = math.min(75, lev + 10)
	local f2 = math.min(20, math.floor(f1 / 2))
	local power = 0
	if rng.range(1, 100) <= f1 then
		power = math.floor(5 + lev / 5)
		if power < 5 then power = 5 end
		if rng.range(1, 100) <= f2 then power = math.floor(10 + lev / 5) end
	elseif rng.range(1, 100) <= f1 then
		power = -1
		if rng.range(1, 100) <= f2 then power = -2 end
	end
	if power == 0 then return end
	local lo, hi
	if power < 0 then lo, hi = power * 5, -1 else lo, hi = 0, power end
	local function roll() return rng.range(lo, hi) end
	local tval = o.dbt_tval
	if tval == "SMALLARM" or tval == "ENTANGLEARM" or tval == "SWORDARM" or tval == "POLEARM" then
		o.dbt_to_h = (o.dbt_to_h or 0) + roll()
		o.dbt_to_d = (o.dbt_to_d or 0) + roll()
	elseif tval == "GUN" or tval == "LAUNCHER" then
		o.dbt_to_h = (o.dbt_to_h or 0) + roll()
	elseif tval == "BODY_ARMOUR" or tval == "BOOTS" or tval == "HEADPIECE" or tval == "CLOAK" or tval == "GLOVES" or tval == "BRACERS" or tval == "SHIELD" then
		o.dbt_to_a = (o.dbt_to_a or 0) + roll()
	end
end

function _M:noteBonuses(o)
	if not o then return end
	local bits = {}
	if (o.dbt_to_h or 0) ~= 0 then bits[#bits + 1] = ("%+d to-hit"):format(o.dbt_to_h) end
	if (o.dbt_to_d or 0) ~= 0 then bits[#bits + 1] = ("%+d damage"):format(o.dbt_to_d) end
	if (o.dbt_to_a or 0) ~= 0 then bits[#bits + 1] = ("%+d armor"):format(o.dbt_to_a) end
	if o.dbt_stats then
		for stat, n in pairs(o.dbt_stats) do
			if n ~= 0 then bits[#bits + 1] = ("%+d %s"):format(n, stat) end
		end
	end
	if o.dbt_resist then
		for kind, n in pairs(o.dbt_resist) do
			if n ~= 0 then bits[#bits + 1] = ("%d%% %s resist"):format(n, kind) end
		end
	end
	if (o.dbt_stealth or 0) ~= 0 then bits[#bits + 1] = ("%+d stealth"):format(o.dbt_stealth) end
	if o.dbt_vorpal then bits[#bits + 1] = "vorpal" end
	if o.dbt_inaccurate then bits[#bits + 1] = "wild kick" end
	if o.dbt_stun then bits[#bits + 1] = "stun" end
	if o.dbt_spike then bits[#bits + 1] = "spikes" end
	if o.dbt_aggravate then bits[#bits + 1] = "noisy" end
	if o.dbt_res_blind then bits[#bits + 1] = "blind resist" end
	if o.dbt_ego and o.capacity and o.capacity > 0 then bits[#bits + 1] = ("%d rounds"):format(o.capacity) end
	if o.dbt_ego and o.dbt_range and o.dbt_range > 0 then bits[#bits + 1] = ("range %d"):format(o.dbt_range) end
	if o.dbt_ego and o.difficulty and o.difficulty > 0 and (o.dbt_tval == "SMALLARM" or o.dbt_tval == "SWORDARM" or o.dbt_tval == "POLEARM" or o.dbt_tval == "ENTANGLEARM") then
		bits[#bits + 1] = ("difficulty %d"):format(o.difficulty)
	end
	if #bits == 0 then return end
	o.dbt_id_note = table.concat(bits, ", ")
	if o.dbt_ego then
		o.dbt_full_name = o.name
		o.name = o.dbt_plain_name or o.name
		o.identified = false
	else
		o.desc = (o.desc or "") .. " [" .. o.dbt_id_note .. "]"
		o.identified = true
	end
end

function _M:identifyObject(o)
	if not o or o.identified ~= false then return end
	o.identified = true
	if o.dbt_full_name then o.name = o.dbt_full_name end
	if o.dbt_id_note and o.dbt_id_note ~= "" then
		o.desc = (o.desc or "") .. " [" .. o.dbt_id_note .. "]"
	end
	self.log("You identify %s.", o:getName())
end

function _M:makeGold(object_level)
	local cap = math.max(1, object_level or 1)
	local best
	for _, pile in ipairs(dbt_gold or {}) do
		if pile.level <= cap and (not best or pile.level >= best.level) then best = pile end
	end
	best = best or (dbt_gold and dbt_gold[1])
	local proto = best and self:lootList() and self:lootList().LOOT_ZENI
	if not proto then return end
	local o = proto:clone()
	o.name = best.name
	o.dbt_zeni = best.value
	o.dbt_zeni_named = best.named and true or false
	o.cost = best.value
	return o
end

function _M:makeThemedObject(themes, object_level, dun)
	local list, total = {}, 0
	for name, weight in pairs(themes) do
		if weight > 0 and dbt_drop_themes and dbt_drop_themes[name] then
			list[#list + 1] = {name = name, weight = weight}
			total = total + weight
		end
	end
	if total <= 0 then return end
	local roll = rng.range(1, total)
	local acc, theme = 0, nil
	for _, entry in ipairs(list) do
		acc = acc + entry.weight
		if roll <= acc then theme = entry.name; break end
	end
	local choices = theme and dbt_drop_themes[theme]
	if not choices or #choices == 0 then return end
	local choice = choices[rng.range(1, #choices)]
	if choice.kind == "gold" then return self:makeGold(object_level) end
	local o
	if choice.kind == "id" then
		o = self:cloneStock(choice.id)
	else
		local pool = {}
		local cap = math.max(1, object_level or 1)
		for _, item in ipairs(dbt_drop_items or {}) do
			local ok = (choice.kind == "tval" and item.tval == choice.id) or (choice.kind == "tag" and item.tags and item.tags[choice.id])
			if ok and (item.level or 0) <= cap then pool[#pool + 1] = item.id end
		end
		if #pool == 0 then return end
		o = self:cloneStock(pool[rng.range(1, #pool)])
	end
	if not o then return end
	self:egoify(o, dun or 0, object_level or 0)
	self:applyPower(o, object_level or 0)
	self:noteBonuses(o)
	return o
end

function _M:dropDragonball(actor, race, x, y)
	local chance = 2
	if race.animal or race.plant then chance = -1 end
	if race.unique then chance = 20 end
	if race.immortal then chance = -1 end
	if race.ball then chance = race.ball * 10 end
	local zone = self.zone and self.zone.short_name or ""
	if not zone:match("^earth[1-9]$") then chance = -1 end
	if race.no_ball then chance = -1 end
	if chance < 1 or rng.range(1, 1000) > chance then return end
	local p = self.player
	if not p then return end
	p.dragonballs = p.dragonballs or {}
	local open = {}
	for _, ball in ipairs(dbt_dragonballs or {}) do
		if not p.dragonballs[ball.star] then open[#open + 1] = ball end
	end
	if #open == 0 then return end
	local ball = open[rng.range(1, #open)]
	local proto = self:lootList() and self:lootList().LOOT_DRAGONBALL
	if not proto then return end
	p.dragonballs[ball.star] = true
	local o = proto:clone()
	o.name = ball.name
	o.desc = ball.desc
	o.unique = ball.name
	self:placeDrop(actor, x, y, o)
end

function _M:dropCorpse(actor, race, x, y)
	local zone = self.zone and self.zone.short_name or ""
	if zone == "tournament" or zone == "dojo_sumo" or zone == "dojo_judo" then return end
	if race and race.no_corpse then return end
	local drop = (race and race.force_corpse) or actor.unique or (race and race.unique) or rng.range(1, 100) <= 10
	if not drop then return end
	local proto = self:lootList() and self:lootList().LOOT_CORPSE
	if not proto then return end
	self:placeDrop(actor, x, y, proto:clone())
end

function _M:dropLoot(actor, x, y)
	if not actor or actor.player or not x or not y then return end
	if self.zone and self.zone.short_name == "tournament" then return end
	self:loadTraining()
	local race = dbt_drop_races and actor.define_as and dbt_drop_races[actor.define_as]
	if race and race.themes and next(race.themes) and not (race.only_gold and race.only_item) then
		local themes = {}
		for name, weight in pairs(race.themes) do themes[name] = weight end
		if race.only_item then themes.TREASURE = nil end
		if race.only_gold then themes = {TREASURE = 100} end
		local n = 0
		if race.drop60 and rng.range(0, 99) < 60 then n = n + 1 end
		if race.drop90 and rng.range(0, 99) < 90 then n = n + 1 end
		if race.lo then
			local hi = race.hi or race.lo
			if hi < race.lo then hi = race.lo end
			n = n + rng.range(race.lo, hi)
		end
		local dun = 0
		if self.zone and self.zone.short_name == "sewers" and self.level then
			dun = 4 + self.level.level
		else
			local spec = dbt_earth_zones and self.zone and dbt_earth_zones[self.zone.short_name]
			if spec then dun = spec.level end
		end
		local object_level = math.floor((dun + (actor.level or 1)) / 2)
		for _ = 1, n do
			self:placeDrop(actor, x, y, self:makeThemedObject(themes, object_level, dun))
		end
		self:dropDragonball(actor, race, x, y)
	end
	self:dropCorpse(actor, race, x, y)
end

function _M:storeSchool(store_id)
	self:loadTraining()
	return dbt_store_school and dbt_store_school[store_id]
end

function _M:trainingInfo(class)
	self:loadTraining()
	local book = class.type == "ability" and dbt_ability_by_id or dbt_skill_by_id
	return (book and book[class.skill]) or {name = class.skill, desc = ""}
end

function _M:schoolRefusal(actor, school_id)
	local n = actor.enrollments or {}
	local fled = actor.fled or {}
	local female = actor.female or (actor.descriptor and actor.descriptor.sex == "Female")
	if actor.schools_closed and actor.schools_closed[school_id] then
		return "The school is closed."
	elseif school_id == "KARATE" and (fled.KARATE or fled.KICKBOXING) then
		return "I would never take as a student a coward such as yourself."
	elseif school_id == "KICKBOXING" and (fled.KARATE or fled.KICKBOXING) then
		return "Hmm. A coward like you obviously needs my training...but I just don't want to give it."
	elseif school_id == "KUNGFU" and (fled.FENCING or fled.KUNGFU) then
		return "I would never take as a student a coward such as yourself."
	elseif school_id == "FENCING" and fled.KUNGFU then
		return "Pardon, I do not wish to further teach a coward such as you."
	elseif school_id == "SUMO" and fled.SUMO then
		return "Hmm. A coward like you obviously needs my training...but I just don't want to give it."
	elseif school_id == "KARATE" and (n.KICKBOXING or 0) > 0 then
		return "Nakamura Sensei does not take students who have studied kickboxing."
	elseif school_id == "KICKBOXING" and (n.KARATE or 0) > 0 then
		return "Bob does not take students who have studied karate."
	elseif school_id == "KUNGFU" and (n.FENCING or 0) > 0 then
		return "Fong-Sai Yuk does not take students who have studied fencing."
	elseif school_id == "FENCING" and (n.KUNGFU or 0) > 0 then
		return "Jacque does not take students who have studied kung fu."
	elseif school_id == "NINJUTSU" and (n.BALLET or 0) > 0 then
		return "Grandmaster Hatsumi does not take students of the ballet school."
	elseif school_id == "BALLET" and (n.NINJUTSU or 0) > 0 then
		return "Sakura does not take students who have studied ninjutsu."
	elseif school_id == "SUMO" and female then
		return "Honda says sumo is for men only. Try Yawara next door."
	elseif school_id == "SUMO" and (n.JUDO or 0) > 0 then
		return "Honda will not take Yawara's students."
	elseif school_id == "JUDO" and (n.SUMO or 0) > 0 then
		return "Yawara will not take Honda's students."
	end
end

function _M:loadDojos()
	self:loadTraining()
	return dbt_dojos
end

function _M:dojoDef(school_id)
	if not school_id then return nil end
	self:loadDojos()
	return dbt_dojos and dbt_dojos[school_id]
end

function _M:dojoOfferedBy(school_id)
	self:loadDojos()
	if not dbt_dojos then return nil end
	for _, duel in pairs(dbt_dojos) do
		if duel.offered_by == school_id then return duel end
	end
end

function _M:closedSchoolCount(actor)
	local n = 0
	local closed = actor and actor.schools_closed or {}
	for _, id in ipairs({"KARATE", "KICKBOXING", "KUNGFU", "FENCING", "SUMO", "JUDO", "BALLET"}) do
		if closed[id] then n = n + 1 end
	end
	return n
end

function _M:classCap(actor, school_id, class)
	local cap = class.cap or 0
	if not actor or not actor.trainers or not actor.trainers[school_id] then return cap end
	local steps = dbt_cap_step and dbt_cap_step[school_id]
	local step = steps and steps[class.skill] or 0
	return cap + step * self:closedSchoolCount(actor)
end

function _M:challengeReady(actor, school_id)
	local duel = self:dojoDef(school_id)
	if not duel then return false, "Nobody here will accept a challenge." end
	actor:ensureQuests()
	if actor.schools_closed and actor.schools_closed[school_id] then
		return false, "The school is closed."
	end
	if (actor.enrollments[school_id] or 0) > 0 then
		return false, duel.spar
	end
	if actor.fled and actor.fled[school_id] then
		return false, duel.fled
	end
	if school_id == "SUMO" and actor.ever_challenged_sumo then
		return false, duel.again
	end
	local tourny = actor.quests and actor.quests.tournament
	if tourny and tourny.status == "finished" then
		return false, "Fight YOU?!!? No way! Honestly, I'm flattered, but you're way out of my league!"
	end
	if (actor.level or 1) < 10 then
		return false, "You wish to duel? Hmm. I'm sorry, but I really don't think you're ready."
	end
	return true
end

function _M:beginDojo(school_id)
	local duel = self:dojoDef(school_id)
	local p = self.player
	local accept = duel.accept
	if accept:find("%%s") then
		local french = (p.female or (p.descriptor and p.descriptor.sex == "Female")) and "mademoiselle" or "monsieur"
		accept = accept:format(french)
	end
	self.log("%s", accept)
	if school_id == "SUMO" then p.ever_challenged_sumo = true end
	self.dojo_return = {zone = self.zone.short_name, x = p.x, y = p.y}
	self.dojo_duel = school_id
	self.dojo_won = nil
	self:changeLevel(1, duel.zone)
	self:onDojoEnter()
end

function _M:onDojoEnter()
	local duel = self.dojo_duel and dbt_dojos and dbt_dojos[self.dojo_duel]
	if not duel or not duel.enter_completes then return end
	local p = self.player
	p:ensureQuests()
	local q = p.quests[duel.quest]
	if q and q.status == "taken" then
		q.status = "completed"
		self.log("%s", duel.enter_msg)
	end
end

function _M:leaveDojo()
	local school_id = self.dojo_duel
	local duel = school_id and dbt_dojos and dbt_dojos[school_id]
	local p = self.player
	if duel and not self.dojo_won and p then
		p:ensureQuests()
		p.fled[school_id] = true
		local q = p.quests[duel.quest]
		if duel.enter_completes then
			self.log("%s", duel.leave_msg or "You have fled from the duel!")
		else
			self.log("You have fled like a coward!")
			if q and q.status == "taken" then
				q.status = "failed"
				if duel.fail_extra then self.log("%s", duel.fail_extra) end
			end
		end
	end
	local back = self.dojo_return
	self.dojo_duel = nil
	self.dojo_won = nil
	if back and back.zone then
		self:changeLevel(1, back.zone, {x=back.x, y=back.y})
	else
		self:changeLevel(1, "earth5")
	end
end

function _M:onDuelDeath(actor)
	if not actor or not self.dojo_duel then return end
	local duel = dbt_dojos and dbt_dojos[self.dojo_duel]
	if not duel or actor.define_as ~= duel.master then return end
	local p = self.player
	if not p then return end
	p:ensureQuests()
	p.schools_closed[duel.id] = true
	p.trainers[duel.boost] = true
	local q = p.quests[duel.quest]
	local quested = q and (q.status == "taken" or (duel.enter_completes and q.status == "completed"))
	if quested and not duel.enter_completes then q.status = "completed" end
	self.log("%s", quested and duel.taken_msg or duel.other_msg)
	self.dojo_won = true
end

function _M:considerDojoOffer(school_id, actor)
	local duel = self:dojoOfferedBy(school_id)
	if not duel or not actor then return end
	actor:ensureQuests()
	if (actor.enrollments[school_id] or 0) <= 0 then return end
	local q = actor.quests[duel.quest]
	if q and q.status == "completed" then
		self.log("%s", duel.congrats)
		q.status = "finished"
		actor.trainers[school_id] = true
		return
	end
	if q and q.status == "taken" then
		self.log("%s", duel.remind)
		return
	end
	if q and q.status == "failed" then
		self.log("%s", duel.failed_talk)
		return
	end
	if q and q.status == "finished" then
		self.log("%s", duel.thanks)
		return
	end
	if actor.trainers and actor.trainers[school_id] then return end
	local ready = false
	for _, req in ipairs(duel.offer_any or {}) do
		if actor:skillValue(req[1]) >= req[2] then ready = true end
	end
	if not ready then return end
	if duel.quest == "challenge_judo" or duel.quest == "challenge_sumo" then
		actor.yawara_wt = 1
	end
	local Dialog = require "engine.ui.Dialog"
	Dialog:yesnoPopup(duel.offer_title, duel.offer, function(ret)
		if not ret then return end
		actor.quests[duel.quest] = {name = duel.name, desc = duel.desc, status = "taken"}
		self.log("Quest accepted: %s", duel.name)
	end, "Yes", "No")
end

function _M:calmTournament()
	if not self.zone or self.zone.short_name ~= "tournament" then return end
	local map = self.level and self.level.map
	if not map then return end
	local Map = require "engine.Map"
	local peaceful = {
		WT_TICKET = true, WT_GUARD = true, WT_BACKSTAGE = true, WT_MEDIC = true,
		WT_CROWD_BLUE = true, WT_CROWD_GREEN = true, WT_CROWD_YELLOW = true,
		RACE_WT_TICKET_GIRL = true, RACE_WT_GUARD = true, RACE_WT_BACKSTAGE_GUY = true,
		RACE_WT_MEDIC = true, RACE_WT_AUDIENCE_BLUE = true, RACE_WT_AUDIENCE_GREEN = true,
		RACE_WT_AUDIENCE_YELLOW = true,
	}
	for x = 0, map.w - 1 do
		for y = 0, map.h - 1 do
			local a = map(x, y, Map.ACTOR)
			if a and not a.dbt_tourny_fighter and (peaceful[a.define_as] or a.name == "audience member") then
				a.faction = "neutral"
				a.ai = "none"
				a.never_move = true
			end
		end
	end
end

function _M:retargetEntrances()
	local map = self.level and self.level.map
	if not map then return end
	local open = {
		ENTER_DUNGEON_TOURNAMENT = "tournament",
		ENTER_DUNGEON_NINJA_SEWERS = "sewers",
		ENTER_DUNGEON_KAME_HOUSE = "kame",
		ENTER_DUNGEON_CRANE = "crane",
		ENTER_DUNGEON_MUSASHI = "musashi",
		ENTER_DUNGEON_WOLFCAVE = "wolfcave",
		ENTER_DUNGEON_OOLONG = "oolong",
		ENTER_DUNGEON_PILAF = "pilaf",
		ENTER_DUNGEON_BRIEFS = "briefs",
		ENTER_DUNGEON_OXKING_HOUSE = "frypan",
		ENTER_DUNGEON_SATAN_ESTATE = "satan",
		ENTER_DUNGEON_TEMPLE = "temple",
		ENTER_DUNGEON_KARIN = "karin",
		ENTER_DUNGEON_MUSCLE_TOWER = "muscle",
		ENTER_DUNGEON_NINJA_WAREHOUSE = "foot",
		ENTER_DUNGEON_RABBIT_HOLE = "rabbit",
		ENTER_DUNGEON_UNDERWATER_CAVERN = "blue",
		ENTER_DUNGEON_VOLCANO = "volcano",
	}
	local Map = require "engine.Map"
	for x = 0, map.w - 1 do
		for y = 0, map.h - 1 do
			local g = map(x, y, Map.TERRAIN)
			local zone = g and g.define_as and open[g.define_as]
			if zone and g.change_zone ~= zone then g.change_zone = zone end
		end
	end
end

function _M:loadTourny()
	self:loadTraining()
	return dbt_tourny
end

function _M:syncTournamentQuest(p)
	if not p or not p.quests then return end
	local q = p.quests.tournament
	if not q then return end
	local round = p.tourny_round or 0
	local reg = p.tourny_registered or 0
	q.name = "The 22nd Annual World Tournament"
	if q.status == "finished" or reg == 5 or round > 18 then
		q.desc = "Congratulations! You've won the World Tournament!"
	elseif q.status == "failed" or reg > 1 then
		q.desc = "You have been eliminated from the World Tournament."
	elseif round == 18 then
		q.desc = "This is it! Win this last round and you've won!"
	elseif round > 11 then
		q.desc = "You're in the final set of eliminations (round " .. round .. "). Everyone left is a skilled veteran."
	elseif round > 5 then
		q.desc = "You're in the second set of eliminations (round " .. round .. "). Competitors here are both strong and skilled."
	elseif round > 0 then
		q.desc = "You're in the first set of eliminations (round " .. round .. "). Competition is still fairly weak, but it's rising."
	elseif reg == 1 then
		q.desc = "Now that you're registered, you'll have to win a qualifying round. Don't worry. You'll be matched with real fighters soon enough."
	else
		q.desc = "The World Tournament is an annual gathering of martial artists from across the world to see who is the best of the best! Since you were little, you've always fantasized about winning, and now is your chance! Make us proud!"
	end
end

function _M:tournyAvailable(p, id)
	if not id then return false end
	self:loadTourny()
	local list = self.zone and self.zone.npc_list
	if not list or not list[id] then return false end
	if p.tourny_fought and p.tourny_fought[id] then return false end
	local school = dbt_tourny.closed and dbt_tourny.closed[id]
	if school and p.schools_closed and p.schools_closed[school] then return false end
	if id == "RACE_YAWARA" and p.yawara_wt then return false end
	return true
end

function _M:tournyPick(p)
	self:loadTourny()
	local round = p.tourny_round or 0
	if round <= 5 then return dbt_tourny.belts[round + 1] end
	if round == 18 then
		if not p.satan_flaked and self:tournyAvailable(p, "RACE_MR_SATAN") then
			return "RACE_MR_SATAN"
		end
		local rosshi = self:tournyAvailable(p, "RACE_ROSSHI")
		if rosshi and rng.range(1, 2) == 1 then return "RACE_ROSSHI" end
		if self:tournyAvailable(p, "RACE_DEMON_KING_PICCOLO") then return "RACE_DEMON_KING_PICCOLO" end
		if rosshi then return "RACE_ROSSHI" end
		return nil
	end
	local choices = {}
	for _, pool in ipairs(dbt_tourny.pools) do
		if round < pool.before then
			for _, id in ipairs(pool.races) do
				if self:tournyAvailable(p, id) then choices[#choices + 1] = id end
			end
			if #choices > 0 then break end
		end
	end
	if #choices == 0 then return nil end
	return choices[rng.range(1, #choices)]
end

function _M:tournyPrepare(p)
	p:ensureQuests()
	if (p.tourny_registered or 0) == 5 or (p.tourny_round or 0) > 18 then return "victory" end
	if p.tourny_now then return "fighting" end
	local id = p.tourny_pending
	if id and not self:tournyAvailable(p, id) then
		p.tourny_pending = nil
		id = nil
	end
	if not id then
		id = self:tournyPick(p)
		p.tourny_pending = id
	end
	if not id then return "autobump" end
	if id == "RACE_MR_SATAN" and (p.tourny_round or 0) ~= 18 then
		p.satan_flaked = true
		p.tourny_pending = nil
		return "bump"
	end
	p.tourny_intro = (dbt_tourny.intro and dbt_tourny.intro[id]) or "Your next opponent is waiting."
	return "ready"
end

function _M:tournySeal(closed)
	local map = self.level and self.level.map
	local list = self.zone and self.zone.grid_list
	if not map or not list then return end
	local Map = require "engine.Map"
	local x, y = 10, 20
	local proto = closed and list.WALL or (list.OUTSIDE_RING or list.FLOOR)
	if not proto then return end
	map(x, y, Map.TERRAIN, proto:clone())
	if map.updateMap then map:updateMap(x, y) end
end

function _M:tournyPlace(id)
	local list = self.zone and self.zone.npc_list
	local proto = list and list[id]
	local map = self.level and self.level.map
	if not proto or not map then return false end
	local Map = require "engine.Map"
	local function empty_ring(x, y)
		local g = map(x, y, Map.TERRAIN)
		local a = map(x, y, Map.ACTOR)
		return g and g.dbt_ring and not a
	end
	local x, y
	if empty_ring(26, 13) then
		x, y = 26, 13
	else
		for yy = 8, 18 do
			for xx = 13, 29 do
				if empty_ring(xx, yy) then x, y = xx, yy break end
			end
			if x then break end
		end
	end
	if not x then return false end
	local m = proto:clone()
	m:resolve()
	m:resolve(nil, true)
	m.faction = "enemies"
	m.ai = "simple"
	m.ai_state = { talent_in = 3 }
	m.never_move = false
	m.unique = false
	m.dbt_tourny_fighter = true
	self.zone:addEntity(self.level, m, "actor", x, y)
	return true
end

function _M:tournyAdvance(p)
	p.tourny_pending = nil
	local round = p.tourny_round or 0
	if round >= 18 then
		p.tourny_round = 18
		self:tournyCrown(p)
		return
	end
	p.tourny_round = round + 1
	self:syncTournamentQuest(p)
end

function _M:tournyBegin(p)
	local id = p.tourny_pending
	if not id or not self:tournyPlace(id) then
		self.log("Your next opponent is a no-show. You advance to the next round.")
		self:tournyAdvance(p)
		return
	end
	p.tourny_pending = nil
	p.tourny_fought[id] = true
	p.tourny_now = true
	p.tourny_opponent = id
	self:tournySeal(true)
	p:move(18, 13, true)
	self.log("Good luck!")
	if (p.tourny_round or 0) > 5 then self:dbtPlay("effects", "gong") end
end

function _M:tournyRemoveFighter()
	local map = self.level and self.level.map
	if not map then return end
	local Map = require "engine.Map"
	local gone = {}
	for y = 0, map.h - 1 do
		for x = 0, map.w - 1 do
			local a = map(x, y, Map.ACTOR)
			if a and a.dbt_tourny_fighter and not a.dead then gone[#gone + 1] = a end
		end
	end
	for _, a in ipairs(gone) do
		map:remove(a.x, a.y, Map.ACTOR)
		if self.level.removeEntity then self.level:removeEntity(a) end
	end
end

function _M:tournyCrown(p)
	if (p.tourny_registered or 0) == 5 then return end
	p.tourny_now = false
	p.tourny_opponent = nil
	p.tourny_registered = 5
	p.money = (p.money or 0) + 100000
	local q = p.quests and p.quests.tournament
	if q then q.status = "finished" end
	local reward = p.quests and p.quests.briefs_tournament_reward
	if reward and reward.status == "taken" then reward.status = "completed" end
	if (p.satan_state or 0) == 3 then p.videl_state = 7 end
	self:tournySeal(false)
	self:syncTournamentQuest(p)
	self.log("The crowd goes wild!!!")
	self.log("You have won the World Tournament. The prize inside the trophy is one hundred thousand zeni.")
end

function _M:onTournamentWin(fighter)
	local p = self.player
	if not p or not p.tourny_now or not fighter or not fighter.dbt_tourny_fighter then return end
	if fighter.define_as == "RACE_MR_SATAN" then p.satan_defeated = true end
	p.tourny_now = false
	p.tourny_opponent = nil
	local round = p.tourny_round or 0
	self:tournySeal(false)
	if round == 5 then
		self.log("You're past the first set of eliminations! It will get tougher from here.")
	elseif round == 18 then
		self:tournyCrown(p)
		return
	else
		self.log("Congratulations! You've won the match.")
	end
	p.tourny_round = round + 1
	self:syncTournamentQuest(p)
end

function _M:loseTournament(how)
	local p = self.player
	if not p or not p.tourny_now or p.tourny_death then return end
	p.tourny_now = false
	p.tourny_opponent = nil
	if how == "ring" then
		p.tourny_registered = 3
		self.log("You have left the ring! The match is lost!")
	elseif how == "gun" or how == "eat" then
		p.tourny_registered = 4
		self.log("You have been disqualified.")
	else
		p.tourny_registered = 2
		self.log("You reel from that last blow, and everything goes dark!")
		self.log("You've lost the match, and have been eliminated from the Tournament.")
	end
	local q = p.quests and p.quests.tournament
	if q and q.status == "taken" then q.status = "failed" end
	self:tournyRemoveFighter()
	self:tournySeal(false)
	if p.max_life and p.max_life > 0 then p.life = p.max_life end
	self:syncTournamentQuest(p)
end

function _M:showQuests()
	if self.player.ensureQuests then self.player:ensureQuests() end
	if self.syncTournamentQuest then self:syncTournamentQuest(self.player) end
	local Quests = require "mod.dialogs.Quests"
	self:registerDialog(Quests.new(self.player))
end

function _M:uranaiQuestOpen()
	local q = self.player and self.player.quests and self.player.quests.tentacle_demon
	return q and (q.status == "taken" or q.status == "slain" or q.status == "finished")
end

function _M:openUranaiBasement()
	if not self:uranaiQuestOpen() then return end
	if not self.zone or self.zone.short_name ~= "uranai" then return end
	if not self.level or not self.level.map then return end
	local proto = self.zone.grid_list and self.zone.grid_list.DOWN_URANAI_CELLAR
	if not proto then return end
	local map = self.level.map
	local placed = false
	local found_spot = false
	local function place(x, y)
		local g = map(x, y, Map.TERRAIN)
		if not g or g.dbt_uranai_down then return end
		local stair = proto:clone()
		map(x, y, Map.TERRAIN, stair)
		if map.updateMap then map:updateMap(x, y) end
		placed = true
	end
	for x = 0, map.w - 1 do
		for y = 0, map.h - 1 do
			local g = map(x, y, Map.TERRAIN)
			if g and g.dbt_basement_spot then
				found_spot = true
				place(x, y)
			end
		end
	end
	if not found_spot and map.w > 16 and map.h > 11 then place(16, 11) end
	if placed then self.log("A stair opens in the floor.") end
end

function _M:giveNyoibo(player)
	local inven = player:getInven("INVEN")
	if inven then
		for _, o in ipairs(inven) do
			if o.dbt_use == "nyoibo" then return end
		end
	end
	local Object = require "mod.class.Object"
	local notes = Object:loadList("/data/general/objects/gear.lua")
	local e = notes.NYOIBO
	if not e then
		self.log("The Nyoi-bo is not here.")
		return
	end
	local o = e:clone()
	o:resolve()
	o:resolve(nil, true)
	if not player:addObject(player.INVEN_INVEN, o) then
		self.log("Your pack is full. The Nyoi-bo clatters to the floor.")
		self.level.map:addObject(player.x, player.y, o)
		return
	end
	player:sortInven(player.INVEN_INVEN)
	self.log("You receive: %s.", o:getName())
end

function _M:showSkills()
	if not self:loadTraining() then
		self.log("Skills are not available.")
		return
	end
	if self.player.ensureSkills then self.player:ensureSkills() end
	local Skills = require "mod.dialogs.Skills"
	self:registerDialog(Skills.new(self.player))
end

function _M:showChi()
	self:loadTraining()
	if self.player.ensureSkills then self.player:ensureSkills() end
	if self.player.syncChiTalents then self.player:syncChiTalents() end
	self.player:updateChi()
	if (self.player.max_chi or 0) < 1 then
		self.log("You cannot manipulate chi yet.")
		return
	end
	local Chi = require "mod.dialogs.Chi"
	self:registerDialog(Chi.new(self.player))
end

function _M:loadEarthEdges()
	if earth_edges then return earth_edges end
	local f, err = loadfile("/data/earth_edges.lua")
	if not f then
		print("[DBT] could not load earth edges", err)
		return nil
	end
	local ok, run_err = pcall(f)
	if not ok then
		print("[DBT] earth edges failed", run_err)
		return nil
	end
	return earth_edges
end

function _M:tryEarthEdge(actor, x, y)
	local links = self.earth_links[self.zone and self.zone.short_name]
	if not links or not self.level or not self.level.map or not self:loadEarthEdges() then return false end
	if not actor:enoughEnergy() then return false end
	local map = self.level.map
	local north, south = y == 0, y == map.h - 1
	local west, east = x == 0, x == map.w - 1
	if not north and not south and not west and not east then return false end
	-- A blocked edge tile is a wall, not an exit. act is omitted so this test does not swing.
	if map:checkAllEntities(x, y, "block_move", actor) then return false end
	local dest = self.zone.short_name
	if north then dest = self.earth_links[dest].n
	elseif south then dest = self.earth_links[dest].s end
	if west then dest = self.earth_links[dest].w
	elseif east then dest = self.earth_links[dest].e end
	local edges = earth_edges[dest]
	if not edges then return false end
	local tx, ty
	if north or south then
		local along, inward = self:nearestCrossing(north and edges.s or edges.n, x)
		tx, ty = along, inward
	end
	if not tx and (west or east) then
		local along, inward = self:nearestCrossing(west and edges.e or edges.w, y)
		ty, tx = along, inward
	end
	if not tx or not ty then return false end
	if actor.runStop then actor:runStop() end
	if actor.restStop then actor:restStop() end
	actor:useEnergy()
	self:changeLevel(1, dest, {x=tx, y=ty, crossed=true})
	return true
end

function _M:getPlayer()
	return self.player
end

--- Says if this savefile is usable or not
function _M:isLoadable()
	return not self:getPlayer(true).dead
end

function _M:tick()
	self:dbtCleanSounds()
	if self.level then
		self:targetOnTick()

		engine.GameTurnBased.tick(self)
		-- Fun stuff: this can make the game realtime, although calling it in display() will make it work better
		-- (since display is on a set FPS while tick() ticks as much as possible
		-- engine.GameEnergyBased.tick(self)
	end
	-- When paused (waiting for player input) we return true: this means we wont be called again until an event wakes us
	if self.paused and not savefile_pipe.saving then return true end
end

--- Called every game turns
-- Does nothing, you can override it
function _M:onTurn()
	-- The following happens only every 10 game turns (once for every turn of 1 mod speed actors)
	if self.turn % 10 ~= 0 then return end

	-- Process overlay effects
	self.level.map:processEffects()
end

function _M:display(nb_keyframe)
	-- If switching resolution, blank everything but the dialog
	if self.change_res_dialog then engine.GameTurnBased.display(self, nb_keyframe) return end

	-- Now the map, if any
	if self.level and self.level.map and self.level.map.finished then
		-- Display the map and compute FOV for the player if needed
		if self.level.map.changed then
			self.player:playerFOV()
		end

		self.level.map:display(nil, nil, nb_keyframe)

		-- Display the targetting system if active
		self.target:display()

		-- And the minimap
		self.level.map:minimapDisplay(self.w - 200, 20, util.bound(self.player.x - 25, 0, self.level.map.w - 50), util.bound(self.player.y - 25, 0, self.level.map.h - 50), 50, 50, 0.6)
	end

	if self.hud and self.player then self.hud:toScreen(self.player) end

	-- We display the player's interface
	self.flash:toScreen(nb_keyframe)
	self.logdisplay:toScreen()
	if self.show_npc_list then
		self.npcs_display:toScreen()
	else
		self.hotkeys_display:toScreen()
	end
	if self.player then self.player.changed = false end

	-- Tooltip is displayed over all else
	self:targetDisplayTooltip()

	engine.GameTurnBased.display(self, nb_keyframe)
end

--- Setup the keybinds
function _M:setupCommands()
	-- Make targeting work
	self.normal_key = self.key
	self:targetSetupKey()

	-- One key handled for normal function
	self.key:unicodeInput(true)
	self.key:addCommands{
		[{"_g","ctrl"}] = function() if config.settings.cheat then
			collectgarbage("collect")
			local nb = 0
			for k, e in pairs(__uids) do nb = nb + 1 end
			game.log("NB: %d", nb)
		end end,
		_a = function() self.player:playerAttack() end,
		_c = function() self.player:playerChat() end,
		_f = function() self.player:playerFire() end,
		_v = function() self.player:playerThrow() end,
		_E = function() self.player:playerEat() end,
		_F = function() self.player:tryFusion() end,
		_D = function() self.player:dismantleItem() end,
		_B = function() self.player:buildDevice() end,
		_N = function() self.player:callNimbus() end,
		_k = function() self:showSkills() end,
		_j = function() self:showQuests() end,
		_m = function() self:showChi() end,
	}
	self.key:addBinds
	{
		-- Movements
		MOVE_LEFT = function() self.player:moveDir(4) end,
		MOVE_RIGHT = function() self.player:moveDir(6) end,
		MOVE_UP = function() self.player:moveDir(8) end,
		MOVE_DOWN = function() self.player:moveDir(2) end,
		MOVE_LEFT_UP = function() self.player:moveDir(7) end,
		MOVE_LEFT_DOWN = function() self.player:moveDir(1) end,
		MOVE_RIGHT_UP = function() self.player:moveDir(9) end,
		MOVE_RIGHT_DOWN = function() self.player:moveDir(3) end,
		MOVE_STAY = function() self.player:useEnergy() end,

		RUN_LEFT = function() self.player:runInit(4) end,
		RUN_RIGHT = function() self.player:runInit(6) end,
		RUN_UP = function() self.player:runInit(8) end,
		RUN_DOWN = function() self.player:runInit(2) end,
		RUN_LEFT_UP = function() self.player:runInit(7) end,
		RUN_LEFT_DOWN = function() self.player:runInit(1) end,
		RUN_RIGHT_UP = function() self.player:runInit(9) end,
		RUN_RIGHT_DOWN = function() self.player:runInit(3) end,

		-- Hotkeys
		HOTKEY_1 = function() self.player:activateHotkey(1) end,
		HOTKEY_2 = function() self.player:activateHotkey(2) end,
		HOTKEY_3 = function() self.player:activateHotkey(3) end,
		HOTKEY_4 = function() self.player:activateHotkey(4) end,
		HOTKEY_5 = function() self.player:activateHotkey(5) end,
		HOTKEY_6 = function() self.player:activateHotkey(6) end,
		HOTKEY_7 = function() self.player:activateHotkey(7) end,
		HOTKEY_8 = function() self.player:activateHotkey(8) end,
		HOTKEY_9 = function() self.player:activateHotkey(9) end,
		HOTKEY_10 = function() self.player:activateHotkey(10) end,
		HOTKEY_11 = function() self.player:activateHotkey(11) end,
		HOTKEY_12 = function() self.player:activateHotkey(12) end,
		HOTKEY_SECOND_1 = function() self.player:activateHotkey(13) end,
		HOTKEY_SECOND_2 = function() self.player:activateHotkey(14) end,
		HOTKEY_SECOND_3 = function() self.player:activateHotkey(15) end,
		HOTKEY_SECOND_4 = function() self.player:activateHotkey(16) end,
		HOTKEY_SECOND_5 = function() self.player:activateHotkey(17) end,
		HOTKEY_SECOND_6 = function() self.player:activateHotkey(18) end,
		HOTKEY_SECOND_7 = function() self.player:activateHotkey(19) end,
		HOTKEY_SECOND_8 = function() self.player:activateHotkey(20) end,
		HOTKEY_SECOND_9 = function() self.player:activateHotkey(21) end,
		HOTKEY_SECOND_10 = function() self.player:activateHotkey(22) end,
		HOTKEY_SECOND_11 = function() self.player:activateHotkey(23) end,
		HOTKEY_SECOND_12 = function() self.player:activateHotkey(24) end,
		HOTKEY_THIRD_1 = function() self.player:activateHotkey(25) end,
		HOTKEY_THIRD_2 = function() self.player:activateHotkey(26) end,
		HOTKEY_THIRD_3 = function() self.player:activateHotkey(27) end,
		HOTKEY_THIRD_4 = function() self.player:activateHotkey(28) end,
		HOTKEY_THIRD_5 = function() self.player:activateHotkey(29) end,
		HOTKEY_THIRD_6 = function() self.player:activateHotkey(30) end,
		HOTKEY_THIRD_7 = function() self.player:activateHotkey(31) end,
		HOTKEY_THIRD_8 = function() self.player:activateHotkey(32) end,
		HOTKEY_THIRD_9 = function() self.player:activateHotkey(33) end,
		HOTKEY_THIRD_10 = function() self.player:activateHotkey(34) end,
		HOTKEY_THIRD_11 = function() self.player:activateHotkey(35) end,
		HOTKEY_THIRD_12 = function() self.player:activateHotkey(36) end,
		HOTKEY_PREV_PAGE = function() self.player:prevHotkeyPage() end,
		HOTKEY_NEXT_PAGE = function() self.player:nextHotkeyPage() end,

		-- Actions
		CHANGE_LEVEL = function()
			local e = self.level.map(self.player.x, self.player.y, Map.TERRAIN)
			if self.player:enoughEnergy() and e.change_level then
				self.player:useEnergy()
				if e.dbt_dojo_return then
					self:leaveDojo()
				elseif e.dbt_uranai_down then
					self.uranai_return = {
						zone = self.zone.short_name,
						x = self.player.x,
						y = self.player.y,
					}
					self:changeLevel(1, "uranai_basement", {spawn="up"})
				elseif e.dbt_uranai_return then
					local back = self.uranai_return
					if back and back.zone then
						self:changeLevel(1, back.zone, {x=back.x, y=back.y})
					else
						self:changeLevel(1, "uranai", {spawn="down"})
					end
				elseif e.dbt_return then
					local back = self.earth_return
					if back and back.zone then
						self:changeLevel(1, back.zone, {x=back.x, y=back.y})
					else
						self:changeLevel(1, e.change_zone or "earth5", {spawn="up"})
					end
				elseif e.change_zone then
					self.earth_return = {
						zone = self.zone.short_name,
						x = self.player.x,
						y = self.player.y,
						name = e.name,
					}
					self:changeLevel(e.change_level, e.change_zone, {spawn="up"})
				else
					self:changeLevel(self.level.level + e.change_level)
				end
			else
				self.log("There is no way out of this level here.")
			end
		end,

		REST = function()
			self.player:restInit()
		end,

		USE_TALENTS = function()
			self.player:useTalents()
		end,

		SAVE_GAME = function()
			self:saveGame()
		end,

		SHOW_INVENTORY = function()
			local p = self.player
			p:showInventory("Inventory", p:getInven("INVEN"), nil, function(o)
				self.log("%s: %s", o:getName(), o:getDesc())
				return true
			end)
		end,

		SHOW_EQUIPMENT = function()
			self.player:showEquipment("Equipment", nil, function(o)
				self.log("%s: %s", o:getName(), o:getDesc())
			end)
		end,

		PICKUP_FLOOR = function() self.player:playerPickup() end,
		DROP_FLOOR = function() self.player:playerDrop() end,
		WEAR_ITEM = function() self.player:playerWear() end,
		TAKEOFF_ITEM = function() self.player:playerTakeoff() end,
		USE_ITEM = function() self.player:playerUseItem() end,

		SHOW_CHARACTER_SHEET = function()
			self:loadTraining()
			if self.player.ensureSkills then self.player:ensureSkills() end
			local Sheet = require "mod.dialogs.CharacterSheet"
			self:registerDialog(Sheet.new(self.player))
		end,

		-- Exit the game
		QUIT_GAME = function()
			self:onQuit()
		end,

		SCREENSHOT = function() self:saveScreenshot() end,

		EXIT = function()
			local menu menu = require("engine.dialogs.GameMenu").new{
				"resume",
				"keybinds",
				"video",
				{"Dragonball T Options", function()
					game:unregisterDialog(menu)
					game:registerDialog(require("mod.dialogs.Options").new())
				end},
				"save",
				"quit"
			}
			self:registerDialog(menu)
		end,

		-- Lua console, you probably want to disable it for releases
		LUA_CONSOLE = function()
			self:registerDialog(DebugConsole.new())
		end,

		-- Toggle monster list
		TOGGLE_NPC_LIST = function()
			self.show_npc_list = not self.show_npc_list
			self.player.changed = true
		end,

		TACTICAL_DISPLAY = function()
			if Map.view_faction then
				self.always_target = nil
				Map:setViewerFaction(nil)
			else
				self.always_target = true
				Map:setViewerFaction("players")
			end
		end,

		LOOK_AROUND = function()
			self.flash:empty(true)
			self.flash(self.flash.GOOD, "Looking around... (direction keys to select interesting things, shift+direction keys to move freely)")
			local co = coroutine.create(function() self.player:getTarget{type="hit", no_restrict=true, range=2000} end)
			local ok, err = coroutine.resume(co)
			if not ok and err then print(debug.traceback(co)) error(err) end
		end,
	}
	-- c is the character sheet in the engine defaults, and a is WASD-left. Claim both for this game.
	local function claim(ks, virtual, fct)
		self.key:addBind(virtual, fct)
		local slot = self.key.binds[ks] or {}
		self.key.binds[ks] = slot
		for other in pairs(slot) do slot[other] = nil end
		slot[virtual] = true
	end
	claim("sym:=c:false:false:false:false", "DBT_CHAT", function() self.player:playerChat() end)
	claim("sym:_a:false:false:false:false", "DBT_ATTACK", function() self.player:playerAttack() end)
	self.key:setCurrent()
end

function _M:setupMouse(reset)
	if reset then self.mouse:reset() end
	self.mouse:registerZone(Map.display_x, Map.display_y, Map.viewport.width, Map.viewport.height, function(button, mx, my, xrel, yrel, bx, by, event)
		-- Handle targeting
		if self:targetMouse(button, mx, my, xrel, yrel, event) then return end

		-- Handle the mouse movement/scrolling
		self.player:mouseHandleDefault(self.key, self.key == self.normal_key, button, mx, my, xrel, yrel, event)
	end)
	-- Scroll message log
	self.mouse:registerZone(self.logdisplay.display_x, self.logdisplay.display_y, self.w, self.h, function(button)
		if button == "wheelup" then self.logdisplay:scrollUp(1) end
		if button == "wheeldown" then self.logdisplay:scrollUp(-1) end
	end, {button=true})
	-- Use hotkeys with mouse
	self.mouse:registerZone(self.hotkeys_display.display_x, self.hotkeys_display.display_y, self.w, self.h, function(button, mx, my, xrel, yrel, bx, by, event)
		self.hotkeys_display:onMouse(button, mx, my, event == "button", function(text) self.tooltip:displayAtMap(nil, nil, self.w, self.h, tostring(text)) end)
	end)
	self.mouse:setCurrent()
end

--- Draw a tooltip beside the pointer. The hardware cursor stays above everything drawn, so the box sits just above it.
function _M:showTooltip(text)
	if not self.dialog_tooltip then
		local Tooltip = require "engine.Tooltip"
		self.dialog_tooltip = Tooltip.new(nil, nil, {255,255,255}, {30,30,30})
	end
	local tip = self.dialog_tooltip
	if not text or text == "" or not tip then return end
	if text ~= tip.old_text then
		tip:set(text)
		tip.old_text = text
	end
	local mx, my = core.mouse.get()
	local x = mx + 18
	local y = my - tip.h - 10
	if y < 4 then y = my + 28 end
	local limit = (self.w or mx) - tip.w - 4
	if x > limit then x = math.max(4, mx - tip.w - 18) end
	if x < 4 then x = 4 end
	tip:toScreen(x, y)
end

--- Ask if we really want to close, if so, save the game first
function _M:onQuit()
	self.player:restStop()

	if not self.quit_dialog then
		self.quit_dialog = QuitDialog.new()
		self:registerDialog(self.quit_dialog)
	end
end

--- Requests the game to save
function _M:saveGame()
	-- savefile_pipe is created as a global by the engine
	savefile_pipe:push(self.save_name, "game", self)
	self.log("Saving game...")
end
