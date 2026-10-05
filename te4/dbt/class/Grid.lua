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
require "engine.Grid"
local DamageType = require "engine.DamageType"

module(..., package.seeall, class.inherit(engine.Grid))

function _M:init(t, no_default)
	engine.Grid.init(self, t, no_default)
end

function _M:block_move(x, y, e, act, couldpass)
	if self.dbt_wt_door and e and e.player and (e.tourny_registered or 0) < 1 then
		-- The exit stairs are west of this door. Unregistered fighters can always walk back out.
		if e.x and x and e.x > x then return false end
		if act then game.log("The door is for registered fighters.") end
		return true
	end
	if self.dbt_ring_edge and e and not e.player and not e.flying then
		return true
	end
	if self.dbt_temple_lock and e and e.player and (e.temple_key or 0) < 1 then
		if act then game.log("This door looks quite sturdy.") end
		return true
	end
	if self.dbt_temple_lock then return false end

	-- Open doors
	if self.door_opened and act then
		game.level.map(x, y, engine.Map.TERRAIN, game.zone.grid_list.DOOR_OPEN)
		return true
	elseif self.door_opened and not couldpass then
		return true
	end

	if e and e.flying and self.does_block_move then
		local kind = self.define_as or ""
		if kind:find("WATER") or kind:find("TREE") or kind:find("MOUNTAIN") or kind:find("LAVA") then
			return false
		end
	end

	-- Pass walls
	if e and self.can_pass and e.can_pass then
		for what, check in pairs(e.can_pass) do
			if self.can_pass[what] and self.can_pass[what] <= check then return false end
		end
	end

	return self.does_block_move
end

function _M:on_move(x, y, who, forced)
	if forced then return end
	if who and who.player and self.change_level then
		local how = self.desc
		if not how or how == "Press > to enter." then
			game.log("#LIGHT_BLUE#%s.#LAST# Press > to enter.", (self.name or "Entrance"):capitalize())
		else
			game.log("#LIGHT_BLUE#%s.#LAST# %s", (self.name or "Entrance"):capitalize(), how)
		end
	elseif who and who.player and self.notice and self.desc and not self.change_level then
		game.log("#LIGHT_BLUE#%s#LAST#", self.desc)
	end
	if who and who.player and who.tourny_now and not who.flying and not who.tourny_death then
		if self.dbt_ring_edge or self.dbt_ring_out then
			if game.loseTournament then game:loseTournament("ring") end
		end
	end
	if who.move_project and next(who.move_project) then
		for typ, dam in pairs(who.move_project) do
			DamageType:get(typ).projector(who, x, y, typ, dam)
		end
	end
end
function _M:tooltip()
	if self.show_tooltip then
		local name = ((self.show_tooltip == true) and self.name or self.show_tooltip)
		if self.desc then
			return self:getDisplayString()..name.."\n"..self.desc
		else
			return self:getDisplayString()..name
		end
	else
		return self:getDisplayString()..self.name
	end
end
