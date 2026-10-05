require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local ListColumns = require "engine.ui.ListColumns"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(school_id, actor)
	self.school_id = school_id
	self.school = dbt_schools[school_id]
	self.actor = actor
	actor:ensureSkills()
	Dialog.init(self, self.school.name, 720, 460)

	self.c_note = Textzone.new{width=self.iw, auto_height=true, text=self:noteText(), can_focus=false}
	self.c_list = ListColumns.new{
		width = self.iw,
		height = self.ih - self.c_note.h - 10,
		scrollbar = true,
		columns = {
			{name = "Class", width = 100, display_prop = "name"},
			{name = "Now", width = {70, "fixed"}, display_prop = "now"},
			{name = "Gain", width = {70, "fixed"}, display_prop = "gain"},
			{name = "Cap", width = {60, "fixed"}, display_prop = "cap"},
			{name = "Points", width = {70, "fixed"}, display_prop = "points"},
		},
		list = self:buildList(),
		fct = function(item, sel, button, event) if event ~= "key" then self:take(item) end end,
	}

	self:loadUI{
		{left = 0, top = 0, ui = self.c_note},
		{left = 0, top = self.c_note.h + 8, ui = self.c_list},
	}
	self:setupUI()
	self:bindKeys()
	self.key:addBinds{ EXIT = function()
		local school_id, actor = self.school_id, self.actor
		game:unregisterDialog(self)
		if game.considerDojoOffer then game:considerDojoOffer(school_id, actor) end
	end }
end

function _M:noteText()
	local times = self.actor.enrollments[self.school_id] or 0
	local trained = times == 0 and "You have never trained here." or ("You have trained here %d time%s."):format(times, times == 1 and "" or "s")
	return ("%s\nA class costs %d zeni. You have %d zeni and %d skill points. Left-click a class, or press its letter."):format(
		trained, self.school.cost or 0, self.actor.money or 0, self.actor.skill_points or 0
	)
end

function _M:buildList()
	local list = {}
	for i, class in ipairs(self.school.classes) do
		local info = game:trainingInfo(class)
		local now, cap
		if class.type == "ability" then
			now = self.actor:hasAbility(class.skill) and "Known" or "Not known"
			cap = ""
		else
			now = self.actor:skillText(self.actor:skillValue(class.skill))
			cap = tostring(game.classCap and game:classCap(self.actor, self.school_id, class) or class.cap or 0)
		end
		list[#list + 1] = {
			name = (class.key ~= "" and ("(%s) "):format(class.key) or "") .. info.name,
			now = now,
			gain = class.type == "ability" and "" or self.actor:skillText(class.gain or 0),
			cap = cap,
			points = tostring(class.skcost or 0),
			class = class,
			index = i,
			desc = info.desc or "",
		}
	end
	if #list == 0 then list[1] = {name = "No classes", now = "", gain = "", cap = "", points = "", desc = ""} end
	return list
end

function _M:bindKeys()
	local cmds = {}
	for i, class in ipairs(self.school.classes) do
		if class.key and class.key ~= "" then
			cmds["_" .. class.key] = function() self:take(self.c_list.list[i]) end
		end
	end
	self.key:addCommands(cmds)
	self.c_list.key:addCommands(cmds)
end

function _M:take(item)
	if not item or not item.class then return end
	local ok, msg = self.actor:trainClass(self.school_id, item.class)
	if ok then
		game.log("You train %s. It is now %s.", item.name, item.class.type == "ability" and "known" or self.actor:skillText(self.actor:skillValue(item.class.skill)))
	else
		game.log("%s", msg or "You cannot take that class.")
	end
	self:refresh()
end

function _M:refresh()
	self.c_note.text = self:noteText()
	self.c_note:generate()
	self.c_list:setList(self:buildList())
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
	if not row or not row.class then return end
	local text = row.name .. "\n" .. (row.desc ~= "" and row.desc or "No description.")
	if row.class.reqtxt and row.class.reqtxt ~= "" and not self.actor:meetsReq(row.class.req) then
		text = text .. "\n" .. row.class.reqtxt
	end
	return text
end

function _M:toScreen(x, y, nb_keyframes)
	Dialog.toScreen(self, x, y, nb_keyframes)
	local tip = self:tipUnderMouse()
	if tip then game:showTooltip(tip) end
end
