-- Player panel for the left column. Portrait, name, level, zeni, life, chi.

require "engine.class"

module(..., package.seeall, class.make)

function _M:init()
	self.font = core.display.newFont("/data/font/DroidSans.ttf", 12)
	self.name_font = core.display.newFont("/data/font/DroidSans-Bold.ttf", 14)
	self.font_h = self.font:lineSkip()
	self.name_h = self.name_font:lineSkip()
	self.cache = {}
end

function _M:text(font, str, r, g, b)
	local key = tostring(font) .. "#" .. str .. "#" .. r .. "#" .. g .. "#" .. b
	local s = self.cache[key]
	if not s then
		local gen = font:draw(str, 400, r, g, b)
		s = gen and gen[1]
		if s then self.cache[key] = s end
	end
	return s
end

function _M:blit(s, x, y)
	if s and s._tex then
		s._tex:toScreenFull(x, y, s.w, s.h, s._tex_w, s._tex_h)
	end
end

function _M:width(font, str)
	local w = font:size(str)
	return w or 0
end

function _M:fit(font, str, maxw)
	if self:width(font, str) <= maxw then return str end
	local s = str
	while #s > 1 do
		s = s:sub(1, #s - 1)
		if self:width(font, s .. "...") <= maxw then return s .. "..." end
	end
	return s
end

function _M:quad(x, y, w, h, r, g, b, a)
	if w > 0 and h > 0 then core.display.drawQuad(x, y, w, h, r, g, b, a or 255) end
end

function _M:bar(x, y, w, h, frac, fill, track)
	self:quad(x, y, w, h, track[1], track[2], track[3], 255)
	local fw = math.floor(w * util.bound(frac or 0, 0, 1))
	if fw > 0 then self:quad(x, y, fw, h, fill[1], fill[2], fill[3], 255) end
end

function _M:toScreen(player)
	if not player or not player.life or game.creating_player then return end

	local x, y, w, h = 4, 6, 190, 112
	self:quad(x, y, w, h, 14, 12, 16, 235)
	self:quad(x, y, 3, h, 196, 154, 72, 255)

	local ax, ay, as = x + 10, y + 8, 36
	self:quad(ax, ay, as, as, 26, 22, 30, 255)
	player:toScreen(nil, ax + 2, ay + 2, 32, 32)

	local name = player.name or "You"
	local level = math.max(1, player.level or 1)
	local lv = "Lv " .. level
	local lv_w = self:width(self.font, lv)
	local name_x = ax + as + 8
	local name_max = x + w - 8 - lv_w - 8 - name_x
	self:blit(self:text(self.name_font, self:fit(self.name_font, name, name_max), 236, 228, 210), name_x, y + 8)
	self:blit(self:text(self.font, lv, 176, 176, 176), x + w - 8 - lv_w, y + 10)

	local zeni = tostring(math.floor(player.money or 0)) .. " zeni"
	self:blit(self:text(self.font, zeni, 212, 184, 96), name_x, y + 8 + self.name_h)

	local life = math.max(0, player.life or 0)
	local max_life = math.max(1, player.max_life or 1)
	local life_frac = life / max_life
	local life_fill = life_frac < 0.25 and {210, 64, 52} or {168, 42, 48}

	local max_chi = player.max_chi or 0
	local chi = math.max(0, player.chi or 0)
	local chi_frac = max_chi > 0 and (chi / max_chi) or 0
	local chi_num = max_chi > 0 and (math.floor(chi + 0.5) .. "/" .. math.floor(max_chi + 0.5)) or "--"

	local by = y + 52
	self:row(x, by, "Life", life_frac, life_fill, {48, 20, 22}, math.floor(life + 0.5) .. "/" .. math.floor(max_life + 0.5))
	self:row(x, by + 22, "Chi", chi_frac, {90, 168, 214}, {20, 36, 52}, chi_num)
end

function _M:row(x, y, label, frac, fill, track, num)
	self:blit(self:text(self.font, label, 200, 196, 188), x + 10, y)
	local bx, bw, bh = x + 46, 78, 14
	self:bar(bx, y, bw, bh, frac, fill, track)
	self:blit(self:text(self.font, num, 230, 230, 230), bx + bw + 6, y)
end
