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
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local Checkbox = require "engine.ui.Checkbox"
local NumberSlider = require "engine.ui.NumberSlider"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
	Dialog.init(self, "Dragonball T Options", 480, 280)
	game:ensureDbtSettings()
	local d = config.settings.dbt

	self.c_note = Textzone.new{
		width = 440,
		auto_height = true,
		text = "Tiles stay ASCII until both sprite sheets are installed. Music and effects each have their own switch and volume.",
	}
	self.c_tiles = Checkbox.new{
		title = "Tiles",
		default = d.tiles,
		fct = function() end,
		on_change = function(s) self:setTiles(s) end,
	}
	self.c_music = Checkbox.new{
		title = "Music",
		default = d.music,
		fct = function() end,
		on_change = function(s) game:setDbtChannel("music", s) end,
	}
	self.c_effects = Checkbox.new{
		title = "Effects",
		default = d.effects,
		fct = function() end,
		on_change = function(s) game:setDbtChannel("effects", s) end,
	}
	self.c_music_vol = NumberSlider.new{
		title = "Music volume: ",
		size_title = "Effects volume: ",
		w = 440,
		max = 100,
		min = 0,
		value = d.music_volume,
		on_change = function(v) game:setDbtVolume("music", v) end,
	}
	self.c_effects_vol = NumberSlider.new{
		title = "Effects volume: ",
		w = 440,
		max = 100,
		min = 0,
		value = d.effects_volume,
		on_change = function(v) game:setDbtVolume("effects", v) end,
	}

	local y = 0
	local function row(ui, gap)
		local item = {left = 0, top = y, ui = ui}
		y = y + ui.h + (gap or 6)
		return item
	end
	self:loadUI{
		row(self.c_note, 12),
		row(self.c_tiles),
		row(self.c_music),
		row(self.c_music_vol),
		row(self.c_effects),
		row(self.c_effects_vol),
	}
	self:setupUI(true, true)

	self.key:addBinds{
		EXIT = function() game:unregisterDialog(self) end,
	}
end

function _M:setTiles(s)
	local on = game:setDbtTiles(s)
	if s and not on then
		self.c_tiles.checked = false
		game.log("#LIGHT_RED#Tiles stay off. Both sprite sheets have to be installed first.")
	end
end
