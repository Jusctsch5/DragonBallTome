require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local ListColumns = require "engine.ui.ListColumns"
local ActorStats = require "engine.interface.ActorStats"

module(..., package.seeall, class.inherit(Dialog))

local ORDER = { "str", "int", "wil", "dex", "con", "chr", "spd" }

function _M:init(actor)
	self.actor = actor
	if actor.ensureSkills then actor:ensureSkills() end
	Dialog.init(self, "Stats", 760, 560)

	self.c_note = Textzone.new{width=self.iw, auto_height=true, text=self:noteText(), can_focus=false}
	local stats_h = 196
	self.c_stats = ListColumns.new{
		width = self.iw,
		height = stats_h,
		scrollbar = true,
		columns = {
			{name = "Stat", width = 100, display_prop = "name"},
			{name = "Current", width = {80, "fixed"}, display_prop = "current"},
			{name = "Gear", width = {70, "fixed"}, display_prop = "gear"},
			{name = "Skill", width = {70, "fixed"}, display_prop = "skill"},
			{name = "Result", width = {80, "fixed"}, display_prop = "result"},
		},
		list = self:statRows(),
		fct = function() end,
	}
	self.c_mid = Textzone.new{width=self.iw, auto_height=true, text="From your stats, gear, and skills", can_focus=false}
	self.c_derived = ListColumns.new{
		width = self.iw,
		height = self.ih - self.c_note.h - stats_h - self.c_mid.h - 24,
		scrollbar = true,
		columns = {
			{name = "Result", width = 100, display_prop = "name"},
			{name = "Value", width = {160, "fixed"}, display_prop = "value"},
		},
		list = self:derivedRows(),
		fct = function() end,
	}

	self:loadUI{
		{left = 0, top = 0, ui = self.c_note},
		{left = 0, top = self.c_note.h + 6, ui = self.c_stats},
		{left = 0, top = self.c_note.h + stats_h + 12, ui = self.c_mid},
		{left = 0, top = self.c_note.h + stats_h + self.c_mid.h + 16, ui = self.c_derived},
	}
	self:setupUI()
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end }
end

function _M:noteText()
	return ("Zeni %d. Skill points %d. Hover a row for how the number is made. Press k for skills."):format(self.actor.money or 0, self.actor.skill_points or 0)
end

function _M:signed(n)
	if n > 0 then return "+" .. n end
	return tostring(n)
end

function _M:statRows()
	local list = {}
	for _, id in ipairs(ORDER) do
		local def = ActorStats.stats_def[id]
		local base, gear, skill, total = self.actor:statParts(id)
		list[#list + 1] = {
			name = def.name,
			current = tostring(base),
			gear = self:signed(gear),
			skill = self:signed(skill),
			result = tostring(total),
			desc = def.description .. "\nCurrent is the stat. Gear is added by worn items. Skill is the trained " .. def.name .. " skill. Result is current plus gear plus skill.",
		}
	end
	return list
end

function _M:derivedRows()
	local a = self.actor
	local dex = a:effStat("dex") - 10
	local str = a:effStat("str") - 10
	local con = a:effStat("con")
	local level = math.max(1, a.level or 1)
	local dodge = a.skillLevel and a:skillLevel("dodge") or 0
	local martial = a:skillLevel("martialarts")
	local hand = a:skillLevel("hand")
	local weapons = a:skillLevel("weapons")
	local marks = a:skillLevel("marksmanship")
	local aura = (a.chi_aura or 0) == 1 and a:skillLevel("chi_offense") or 0
	local gear = a.combat_armor or 0
	local list = {
		{
			name = "Life",
			value = ("%d/%d"):format(a.life or 0, a.max_life or 0),
			desc = ("Life is Constitution %d times level %d."):format(con, level),
		},
		{
			name = "Armor",
			value = tostring(a:armorClass()),
			desc = ("Worn armor %d. Dexterity adds %d. Dodging adds %d, unless you are in a vehicle. Armor makes attacks miss."):format(gear, dex, dodge * 2),
		},
		{
			name = "Barehand to-hit",
			value = tostring(dex + martial + hand + aura),
			desc = ("Dexterity %d, plus Martial-Arts %d, plus Barehand %d, plus Battle Aura %d."):format(dex, martial, hand, aura),
		},
		{
			name = "Barehand damage",
			value = tostring(math.max(0, str + aura)),
			desc = ("Strength minus 10 is %d. Battle Aura adds %d. Damage does not go below 0."):format(str, aura),
		},
	}
	for i = 1, 2 do
		local o = a:hand(i)
		local kind = a:handKind(o)
		local side = i == 1 and "Left" or "Right"
		if kind == "weapon" then
			local diff = o.difficulty or 0
			local dice = o.combat and o.combat.dice
			local lo, hi = dice and dice[1] or 0, dice and dice[2] or 0
			local bonus_n = str + aura
			local bonus = bonus_n < 0 and ("- %d"):format(-bonus_n) or ("+ %d"):format(bonus_n)
			list[#list + 1] = {
				name = side .. " " .. o:getName(),
				value = ("to-hit %d, %d-%d %s"):format(dex - diff + martial + weapons + aura, lo, hi, bonus),
				desc = ("Dexterity %d, weapon difficulty %d, Martial-Arts %d, Weapons %d, Battle Aura %d. Damage adds Strength %d."):format(dex, diff, martial, weapons, aura, str),
			}
		elseif kind == "firearm" then
			local diff = o.difficulty or 0
			list[#list + 1] = {
				name = side .. " " .. o:getName(),
				value = ("to-hit %d, before range"):format(marks - diff),
				desc = ("Marksmanship %d minus difficulty %d, then minus range squared when you fire."):format(marks, diff),
			}
		end
	end
	a:updateChi()
	list[#list + 1] = {
		name = "Chi",
		value = ("%d/%d"):format(math.floor(a.chi or 0), a.max_chi or 0),
		desc = (a.max_chi or 0) < 1 and "Chi stays empty until a master teaches the Chi skill. Press m after that."
			or ("Chi skill times Willpower. You recover %0.2f per turn before constant effects. Press m to shape them."):format(a:chiNaturalRegen()),
	}
	local price = a.priceFactor and a:priceFactor() or 100
	list[#list + 1] = {
		name = "Shop price",
		value = price .. "%",
		desc = ("Charisma %d sets the price. 100%% is full price. Lower is cheaper."):format(a:effStat("chr")),
	}
	return list
end

function _M:tipUnderMouse()
	local mx, my = core.mouse.get()
	for _, list in ipairs({self.c_stats, self.c_derived}) do
		local ui = self.ui_by_ui[list]
		if ui then
			local x = self.display_x + ui.x
			local y = self.display_y + ui.y
			if mx >= x and mx < x + list.w and my >= y and my < y + list.h and my - y >= list.row_height then
				local row = list.list[list.sel]
				if row and row.desc and row.desc ~= "" then return row.name .. "\n" .. row.desc end
			end
		end
	end
end

function _M:toScreen(x, y, nb_keyframes)
	Dialog.toScreen(self, x, y, nb_keyframes)
	local tip = self:tipUnderMouse()
	if tip then game:showTooltip(tip) end
end
