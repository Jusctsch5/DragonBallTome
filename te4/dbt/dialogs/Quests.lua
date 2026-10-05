require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
	self.actor = actor
	if actor.ensureQuests then actor:ensureQuests() end
	Dialog.init(self, "Quests", 640, 420)
	self.c_note = Textzone.new{width=self.iw, height=self.ih, text=self:body(), can_focus=false}
	self:loadUI{
		{left = 0, top = 0, ui = self.c_note},
	}
	self:setupUI()
	self.key:addBinds{ EXIT = function() game:unregisterDialog(self) end }
end

function _M:body()
	local lines = {}
	for _, q in pairs(self.actor.quests or {}) do
		if type(q) == "table" and q.name and q.status ~= "untaken" then
			local status = q.status or "unknown"
			if status == "taken" then status = "in progress"
			elseif status == "slain" then status = "the demon is dead"
			elseif status == "completed" then status = "completed"
			elseif status == "failed" then status = "failed"
			elseif status == "finished" then status = "done"
			end
			lines[#lines + 1] = ("%s (%s)\n%s"):format(q.name, status, q.desc or "")
		end
	end
	if #lines == 0 then return "You have no quests." end
	table.sort(lines)
	return table.concat(lines, "\n\n")
end
