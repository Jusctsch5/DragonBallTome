-- dbt-generated-talk dialogue.ANDROID8
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.rra_android8 or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.rra_android8 or 0) == 1 then
		player.rra_android8 = 2
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.rra_android8 or 0) == 2 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Android 8: ]=] .. [=[Please stop fighting! All of you!]=] end
		if which == [=[2]=] then return [=[Android 8: ]=] .. [=[Such sorrow. Such sadness. Such death. I was created to partake in such horrors as this, but I cannot. I will not. But despite my fortitude, it seems the world around me is made of death. Very well. I will accept the world how it is, but I simply choose not to live in it.

]=] .. [=[BEEP!

]=] .. [=[Android 8: ]=] .. [=[There. It will all be over soon. I have initiated an irrevocable countdown to trigger my Remote Stop Device. They're intended to be used only to stop us should we get out of control, but we're all able to activate them ourselves, as well. I will self destruct in a few minutes. Please, leave while there's still time. Escape...live.

]=] end
		if which == [=[3]=] then return [=[Android 8: ]=] .. [=[Please hurry. There isn't much time left.]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
