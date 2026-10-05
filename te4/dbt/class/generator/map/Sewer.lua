-- City sewers. Soft walls, then mud, shallow water, and swamp. No doors.
-- Depths 5-8 are this generator. The turtles' lair is a static map.

require "engine.class"
local Map = require "engine.Map"
require "engine.Generator"

module(..., package.seeall, class.inherit(engine.Generator))

function _M:init(zone, map, level, data)
	engine.Generator.init(self, zone, map, level, data)
	self.data = data
	self.grid_list = zone.grid_list
end

function _M:put(x, y, which)
	local g = self:resolve(which)
	if g then self.map(x, y, Map.TERRAIN, g) end
end

function _M:dig(x, y)
	if x <= 0 or y <= 0 or x >= self.map.w - 1 or y >= self.map.h - 1 then return end
	self:put(x, y, "mud")
end

function _M:hall(x1, y1, x2, y2)
	local x, y = x1, y1
	while x ~= x2 do
		self:dig(x, y)
		x = x + (x2 > x and 1 or -1)
	end
	while y ~= y2 do
		self:dig(x, y)
		y = y + (y2 > y and 1 or -1)
	end
	self:dig(x2, y2)
end

function _M:generate(lev, old_lev)
	local map = self.map
	for x = 0, map.w - 1 do
		for y = 0, map.h - 1 do
			self:put(x, y, "wall")
		end
	end

	local rooms = {}
	for _ = 1, 60 do
		if #rooms >= 9 then break end
		local w, h = rng.range(6, 12), rng.range(4, 8)
		local x = rng.range(2, map.w - w - 3)
		local y = rng.range(2, map.h - h - 3)
		local ok = true
		for _, room in ipairs(rooms) do
			if x < room.x + room.w + 2 and x + w + 2 > room.x and y < room.y + room.h + 2 and y + h + 2 > room.y then
				ok = false
				break
			end
		end
		if ok then
			rooms[#rooms + 1] = {x = x, y = y, w = w, h = h, cx = x + math.floor(w / 2), cy = y + math.floor(h / 2)}
			for i = x, x + w - 1 do
				for j = y, y + h - 1 do
					self:dig(i, j)
				end
			end
		end
	end
	if #rooms == 0 then
		rooms[1] = {x = 4, y = 4, w = 12, h = 8, cx = 10, cy = 8}
		for i = 4, 15 do
			for j = 4, 11 do
				self:dig(i, j)
			end
		end
	end
	for i = 1, #rooms - 1 do
		self:hall(rooms[i].cx, rooms[i].cy, rooms[i + 1].cx, rooms[i + 1].cy)
	end

	for x = 1, map.w - 2 do
		for y = 1, map.h - 2 do
			local g = map(x, y, Map.TERRAIN)
			if g and g.define_as == "MUD" then
				local roll = rng.range(1, 100)
				if roll > 90 then self:put(x, y, "swamp")
				elseif roll > 45 then self:put(x, y, "water") end
			end
		end
	end

	local up = rooms[1]
	local ux, uy = up.cx, up.cy
	self:put(ux, uy, lev == 1 and "up_earth" or "up")

	local dx, dy
	if lev < self.zone.max_level then
		local down = rooms[#rooms]
		dx, dy = down.cx, down.cy
		if dx == ux and dy == uy then
			dx = math.min(map.w - 2, ux + 3)
		end
		self:dig(dx, dy)
		self:put(dx, dy, "down")
	end
	return ux, uy, dx, dy, {}
end
