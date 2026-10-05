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
local ListColumns = require "engine.ui.ListColumns"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(store, actor, stock)
	self.store = store
	self.actor = actor
	self.stock = stock
	Dialog.init(self, store.name, 680, 460)

	self.c_note = Textzone.new{width=self.iw, auto_height=true, text=self:noteText(), can_focus=false}
	self.c_list = ListColumns.new{
		width = self.iw,
		height = self.ih - self.c_note.h - 10,
		scrollbar = true,
		all_clicks = true,
		columns = {
			{name = "Name", width = 100, display_prop = "name"},
			{name = "Type", width = {140, "fixed"}, display_prop = "kind"},
			{name = "Cost", width = {130, "fixed"}, direct_draw = function(row, x, y, w, h) return self:drawPrice(row, x, y, w, h) end},
		},
		list = self:buildList(),
		fct = function(item, sel, button, event) self:onClick(item, button, event) end,
	}
	local col_w = self.c_list.columns[2].width
	local rh = self.c_list.row_height
	self.price_w = math.max(24, col_w - 12)
	self.price_h = math.max(14, rh - 8)
	self.price_frame = self.c_list:makeFrame("ui/button", self.price_w, self.price_h)

	self:loadUI{
		{left = 0, top = 0, ui = self.c_note},
		{left = 0, top = self.c_note.h + 8, ui = self.c_list},
	}
	self:setupUI()
	self:bindListKeys()
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end }
	self.key:addCommands{ _s = function() self:sell() end, _e = function() self:train() end, _c = function() self:challenge() end }
end

function _M:bindListKeys()
	self.c_list.key:addCommands{ _s = function() self:sell() end, _e = function() self:train() end, _c = function() self:challenge() end }
end

function _M:noteText()
	local train = ""
	if self.store.dbt_id and game.storeSchool and game:storeSchool(self.store.dbt_id) then
		train = " Press e to train."
		if game.dojoDef and game:dojoDef(game:storeSchool(self.store.dbt_id)) then
			train = train .. " Press c to challenge."
		end
	end
	return ("You have %d zeni.\nHover a name for its description. Left-click its cost to buy. Press s to sell.%s"):format(self.actor.money or 0, train)
end

function _M:askPrice(cost)
	local factor = self.actor.priceFactor and self.actor:priceFactor() or 100
	return math.max(0, math.floor((cost or 0) * factor / 100))
end

function _M:typeLabel(o)
	local kind = o.type or "item"
	return (kind:gsub("(%a)([%w']*)", function(a, rest) return a:upper() .. rest end))
end

function _M:buildList()
	local list = {}
	for _, id in ipairs(self.store.items) do
		local o = self.stock[id]
		if o then
			local price = self:askPrice(o.cost)
			list[#list + 1] = {name = o:getName(), kind = self:typeLabel(o), object = o, price = price, price_text = tostring(price)}
		end
	end
	if #list == 0 then list[1] = {name = "Nothing for sale.", kind = "", price_text = ""} end
	return list
end

function _M:drawPrice(row, x, y, w, h)
	if not row.price_text or row.price_text == "" or not self.price_frame then return h, h end
	if not row._price_tex then
		row._price_tex = self.c_list:drawFontLine(self.c_list.font, row.price_text, w - 16)
	end
	local fx = x + math.floor((w - self.price_w) / 2)
	local fy = y + math.floor((h - self.price_h) / 2)
	self.c_list:drawFrame(self.price_frame, fx, fy)
	local tex = row._price_tex
	if tex then
		local tx = fx + math.floor((self.price_w - (tex.w or 0)) / 2)
		local ty = fy + math.floor((self.price_h - (tex.h or 0)) / 2)
		self.c_list:textureToScreen(tex, tx, ty)
	end
	return h, h
end

function _M:refresh()
	self.c_note.text = self:noteText()
	self.c_note:generate()
	self.c_note.can_focus = false
	self.c_list:setList(self:buildList())
	self:bindListKeys()
end

function _M:mouseOnPrice()
	local mx, my = core.mouse.get()
	local ui = self.ui_by_ui[self.c_list]
	if not ui then return false end
	local x = self.display_x + ui.x
	local y = self.display_y + ui.y
	local rel_x = mx - x
	local rel_y = my - y
	if rel_y < self.c_list.row_height or rel_y >= self.c_list.h then return false end
	if rel_x < 0 or rel_x >= self.c_list.w then return false end
	local price_x = 0
	for i = 1, #self.c_list.columns - 1 do price_x = price_x + self.c_list.columns[i].width end
	return rel_x >= price_x
end

function _M:onClick(item, button, event)
	if button ~= "left" or event == "key" or not item or not item.object then return end
	if not self:mouseOnPrice() then return end
	self:buy(item)
end

function _M:buy(item)
	local proto = item and item.object
	if not proto then return end
	local price = item.price or self:askPrice(proto.cost)
	if (self.actor.money or 0) < price then
		game.log("You need %d zeni. You have %d.", price, self.actor.money or 0)
		return
	end
	local o = proto:clone()
	o:resolve()
	o:resolve(nil, true)
	if not self.actor:addObject(self.actor.INVEN_INVEN, o) then
		game.log("Your pack is full.")
		return
	end
	self.actor.money = self.actor.money - price
	game.log("You buy %s for %d zeni. You have %d left.", o:getName(), price, self.actor.money)
	self:refresh()
end

function _M:train()
	local school_id = self.store.dbt_id and game:storeSchool(self.store.dbt_id)
	if not school_id then
		game.log("Nobody here teaches classes.")
		return
	end
	if not dbt_schools or not dbt_schools[school_id] then
		game.log("This school is not teaching yet.")
		return
	end
	local why = game:schoolRefusal(self.actor, school_id)
	if why then
		game.log("%s", why)
		return
	end
	local Trainer = require "mod.dialogs.Trainer"
	game:registerDialog(Trainer.new(school_id, self.actor))
end

function _M:challenge()
	local school_id = self.store.dbt_id and game:storeSchool(self.store.dbt_id)
	if not school_id or not game.dojoDef or not game:dojoDef(school_id) then
		game.log("Nobody here will accept a challenge.")
		return
	end
	local ok, msg = game:challengeReady(self.actor, school_id)
	if not ok then
		if msg then game.log("%s", msg) end
		return
	end
	game:unregisterDialog(self)
	game:beginDojo(school_id)
end

function _M:sell()
	local actor = self.actor
	actor:showInventory("Sell", actor:getInven("INVEN"), nil, function(o, item)
		if o.identified == false and game.identifyObject then game:identifyObject(o) end
		local price = math.floor((o.cost or 0) / 2)
		actor:removeObject(actor.INVEN_INVEN, item, true)
		actor.money = (actor.money or 0) + price
		game.log("You sell %s for %d zeni.", o:getName(), price)
		self:refresh()
		return true
	end)
end

function _M:tipUnderMouse()
	if self:mouseOnPrice() then return end
	local mx, my = core.mouse.get()
	local ui = self.ui_by_ui[self.c_list]
	if not ui then return end
	local x = self.display_x + ui.x
	local y = self.display_y + ui.y
	if mx < x or mx >= x + self.c_list.w or my < y or my >= y + self.c_list.h then return end
	if my - y < self.c_list.row_height then return end
	local row = self.c_list.list[self.c_list.sel]
	if not row or not row.object then return end
	return row.object:getName() .. "\n" .. row.kind .. "\n" .. row.object:getDesc()
end

function _M:toScreen(x, y, nb_keyframes)
	Dialog.toScreen(self, x, y, nb_keyframes)
	local tip = self:tipUnderMouse()
	if tip then game:showTooltip(tip) end
end
