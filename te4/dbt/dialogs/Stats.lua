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
local Button = require "engine.ui.Button"
local ActorStats = require "engine.interface.ActorStats"

module(..., package.seeall, class.inherit(Dialog))

local ORDER = { "str", "int", "wil", "dex", "con", "chr", "spd" }
local NAME_W = 280
local VALUE_W = 72

function _M:init(actor, on_done)
	self.actor = actor
	self.on_done = on_done
	self.points = 0
	self.rows = {}

	self.c_head_name = Textzone.new{width=NAME_W, auto_height=true, text="Stat", can_focus=false}
	self.c_head_value = Textzone.new{width=VALUE_W, auto_height=true, text="Value", can_focus=false}

	for _, id in ipairs(ORDER) do
		local def = ActorStats.stats_def[id]
		local name = Textzone.new{width=NAME_W, auto_height=true, text=def.name, can_focus=false}
		local value = Button.new{
			text = tostring(actor:getStat(id)),
			width = VALUE_W,
			can_focus = false,
			can_focus_mouse = true,
			fct = function() end,
		}
		self.rows[#self.rows + 1] = {stat = id, name = name, value = value, desc = def.name .. "\n" .. (def.description or "")}
	end

	self.c_note = Textzone.new{width=NAME_W + VALUE_W + 16, auto_height=true, text=self:noteText(), can_focus=false}

	Dialog.init(self, "Arrange your stats", 420, 420)

	local ui = {}
	local y = 0
	ui[#ui + 1] = {left=0, top=y, ui=self.c_head_name}
	ui[#ui + 1] = {left=NAME_W + 16, top=y, ui=self.c_head_value}
	y = y + self.c_head_name.h + 8
	for _, row in ipairs(self.rows) do
		local name_top = y + math.max(0, math.floor((row.value.h - row.name.h) / 2))
		ui[#ui + 1] = {left=0, top=name_top, ui=row.name}
		ui[#ui + 1] = {left=NAME_W + 16, top=y, ui=row.value}
		row.top = y
		row.row_h = row.value.h
		y = y + row.value.h + 4
	end
	y = y + 8
	ui[#ui + 1] = {left=0, top=y, ui=self.c_note}
	self:loadUI(ui)
	self:setupUI(true, true)

	for _, row in ipairs(self.rows) do
		self:bindValue(row)
	end
	self.key:addBinds{
		ACCEPT = function() self:finish() end,
		EXIT = function() self:finish() end,
	}
end

function _M:noteText()
	local actor = self.actor
	local level = math.max(1, actor.level or 1)
	return ("Points %d    Life %d    Starting zeni %d\nLeft-click a value to lower it, down to 6, and bank a point. Right-click spends a point, up to 14. Enter accepts."):format(
		self.points, actor:getCon() * level, actor:startingZeni()
	)
end

function _M:bindValue(row)
	local button = row.value
	button.mouse:reset()
	button.mouse:registerZone(0, 0, button.w, button.h, function(btn, x, y, xrel, yrel, bx, by, event)
		if event ~= "button" then return end
		if btn == "left" then self:adjust(row.stat, -1)
		elseif btn == "right" then self:adjust(row.stat, 1) end
	end)
end

function _M:refresh()
	for _, row in ipairs(self.rows) do
		row.value.text = tostring(self.actor:getStat(row.stat))
		row.value:generate()
		self:bindValue(row)
	end
	self.c_note.text = self:noteText()
	self.c_note:generate()
	self.c_note.can_focus = false
end

function _M:adjust(stat, dir)
	local cur = self.actor:getStat(stat)
	if dir < 0 then
		if cur <= 6 then return end
		self.actor:incStat(stat, -1)
		self.points = self.points + 1
	else
		if self.points <= 0 or cur >= 14 then return end
		self.actor:incStat(stat, 1)
		self.points = self.points - 1
	end
	self:refresh()
end

function _M:tipUnderMouse()
	local mx, my = core.mouse.get()
	for _, row in ipairs(self.rows) do
		local ui = self.ui_by_ui[row.name]
		if ui then
			local x = self.display_x + ui.x
			local y = self.display_y + ui.y
			if mx >= x and mx < x + NAME_W and my >= y and my < y + row.row_h then
				return row.desc
			end
		end
	end
end

function _M:toScreen(x, y, nb_keyframes)
	Dialog.toScreen(self, x, y, nb_keyframes)
	local tip = self:tipUnderMouse()
	if tip then game:showTooltip(tip) end
end

function _M:finish()
	if self.done then return end
	self.done = true
	game:unregisterDialog(self)
	if self.on_done then self.on_done() end
end
