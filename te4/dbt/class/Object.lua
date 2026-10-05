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
require "engine.Object"

module(..., package.seeall, class.inherit(engine.Object))

function _M:init(t, no_default)
	engine.Object.init(self, t, no_default)
	if self.encumber == nil then self.encumber = 0 end
end

function _M:getName(t, force)
	if self.identified == false and self.dbt_plain_name then return self.dbt_plain_name end
	return engine.Object.getName(self, t, force)
end

function _M:getDesc()
	if self.identified == false then return "You have not identified this item." end
	if type(self.desc) == "string" and self.desc ~= "" then return self.desc end
	return self.name
end
