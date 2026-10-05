require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local ListColumns = require "engine.ui.ListColumns"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
	self.actor = actor
	actor:updateChi()
	Dialog.init(self, "Chi", 640, 420)

	self.c_note = Textzone.new{width=self.iw, auto_height=true, text=self:noteText(), can_focus=false}
	self.c_list = ListColumns.new{
		width = self.iw,
		height = self.ih - self.c_note.h - 10,
		scrollbar = true,
		all_clicks = true,
		columns = {
			{name = "Effect", width = 100, display_prop = "name"},
			{name = "Setting", width = {140, "fixed"}, display_prop = "setting"},
			{name = "Drain", width = {100, "fixed"}, display_prop = "drain"},
		},
		list = self:buildList(),
		fct = function(item, sel, button, event)
			if event == "key" or not item or not item.adjust then return end
			item.adjust(button == "right" and -1 or 1)
			self:refresh()
		end,
	}

	self:loadUI{
		{left = 0, top = 0, ui = self.c_note},
		{left = 0, top = self.c_note.h + 8, ui = self.c_list},
	}
	self:setupUI()
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end }
end

function _M:noteText()
	local a = self.actor
	return ("Chi %d/%d. Regeneration %0.2f per turn before drains.\nLeft-click raises or toggles. Right-click lowers. These also sit on your hotbar once you know them."):format(
		math.floor(a.chi or 0), a.max_chi or 0, a:chiNaturalRegen()
	)
end

function _M:row(name, setting, drain, adjust)
	return {name = name, setting = setting, drain = ("%.2f"):format(drain), adjust = adjust, desc = name}
end

function _M:buildList()
	local a = self.actor
	local list = {}
	if a:hasAbility("light") then
		list[#list + 1] = self:row("Light Aura", (a.chi_light or 0) == 0 and "Off" or ("radius " .. a.chi_light), a:chiEffectDrain("light"), function(dir)
			a.chi_light = math.max(0, math.min(20, (a.chi_light or 0) + dir))
			a:updateChi()
		end)
	end
	if a:hasAbility("aura") then
		list[#list + 1] = self:row("Battle Aura", (a.chi_aura or 0) == 1 and "On" or "Off", a:chiEffectDrain("aura"), function()
			if (a.chi_aura or 0) == 1 then a:forceUseTalent(a.T_CHI_AURA, {ignore_energy=true})
			else a:forceUseTalent(a.T_CHI_AURA, {ignore_energy=true, no_confirm=true}) end
		end)
	end
	if a:hasAbility("haste") then
		list[#list + 1] = self:row("Haste", (a.chi_haste or 0) == 0 and "Off" or ("+" .. a.chi_haste .. " speed"), a:chiEffectDrain("haste"), function(dir)
			a.chi_haste = math.max(0, math.min(20, (a.chi_haste or 0) + dir))
			a:applyStatEffects()
		end)
	end
	if a:hasAbility("flight") then
		list[#list + 1] = self:row("Flight", (a.chi_flight or 0) == 1 and "On" or "Off", a:chiEffectDrain("flight"), function()
			a:forceUseTalent(a.T_CHI_FLIGHT, {ignore_energy=true, no_confirm=true})
		end)
	end
	if a:hasAbility("regeneration") then
		list[#list + 1] = self:row("Physical Regeneration", (a.chi_regen_hp or 0) == 0 and "Off" or ("+" .. a.chi_regen_hp .. " life"), a:chiEffectDrain("regen"), function(dir)
			a.chi_regen_hp = math.max(0, math.min(20, (a.chi_regen_hp or 0) + dir))
		end)
	end
	if a:hasAbility("absorbtion") then
		list[#list + 1] = self:row("Damage Absorption", (a.chi_absorb or 0) == 0 and "Off" or ("+" .. a.chi_absorb), a:chiEffectDrain("absorb"), function(dir)
			if (a.chi_aura or 0) ~= 1 then game.log("Absorption needs your battle aura.") return end
			a.chi_absorb = math.max(0, math.min(20, (a.chi_absorb or 0) + dir))
		end)
	end
	if #list == 0 then
		list[1] = {name = "You don't know any constant effects.", setting = "", drain = "", desc = "A master teaches these."}
	end
	return list
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
	if not row or not row.desc or row.desc == "" then return end
	return row.name .. "\nLeft-click raises. Right-click lowers. Drain is chi per turn, reduced by Chi Gung after 1."
end

function _M:toScreen(x, y, nb_keyframes)
	Dialog.toScreen(self, x, y, nb_keyframes)
	local tip = self:tipUnderMouse()
	if tip then game:showTooltip(tip) end
end
