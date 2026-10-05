require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local ListColumns = require "engine.ui.ListColumns"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
	self.actor = actor
	actor:ensureSkills()
	Dialog.init(self, "Skills", 640, 520)

	self.c_note = Textzone.new{width=self.iw, auto_height=true, text=self:noteText(), can_focus=false}
	self.c_list = ListColumns.new{
		width = self.iw,
		height = self.ih - self.c_note.h - 10,
		scrollbar = true,
		columns = {
			{name = "Skill", width = 100, display_prop = "name"},
			{name = "Level", width = {90, "fixed"}, display_prop = "level"},
		},
		list = self:buildList(),
		fct = function() end,
	}

	self:loadUI{
		{left = 0, top = 0, ui = self.c_note},
		{left = 0, top = self.c_note.h + 8, ui = self.c_list},
	}
	self:setupUI()
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end }
end

function _M:noteText()
	return ("Skill points: %d. Hover a row for what it does. Train at a school: press e inside."):format(self.actor.skill_points or 0)
end

local STAT_SKILLS = {
	strength = true, intelligence = true, willpower = true, dexterity = true,
	constitution = true, charisma = true, speed = true,
}

function _M:buildList()
	local list = {}
	for _, s in ipairs(dbt_skills or {}) do
		if not STAT_SKILLS[s.id] then
			list[#list + 1] = {name = s.name, level = self.actor:skillText(self.actor:skillValue(s.id)), desc = s.desc}
		end
	end
	for _, a in ipairs(dbt_abilities or {}) do
		if self.actor:hasAbility(a.id) then
			list[#list + 1] = {name = a.name, level = "Known", desc = a.desc}
		end
	end
	if #list == 0 then list[1] = {name = "No skills", level = "", desc = ""} end
	return list
end

function _M:tipUnderMouse()
	local mx, my = core.mouse.get()
	local ui = self.ui_by_ui[self.c_list]
	if not ui then return end
	local x = self.display_x + ui.x
	local y = self.display_y + ui.y
	if mx < x or mx >= x + self.c_list.w or my < y or my >= y + self.c_list.h then return end
	if my - y < self.c_list.row_height then return end
	local row = self.c_list.list[self.c_list.sel]
	if not row or not row.desc or row.desc == "" then return end
	return row.name .. "\n" .. row.desc
end

function _M:toScreen(x, y, nb_keyframes)
	Dialog.toScreen(self, x, y, nb_keyframes)
	local tip = self:tipUnderMouse()
	if tip then game:showTooltip(tip) end
end
