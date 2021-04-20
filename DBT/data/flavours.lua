-- Dragonball T: Item flavours
--
-- Issues:
-- circuitry and high-tech could probably gain flavours
-- flavour handling of # and ~ isn't very good

flavour.tech = {
	{ "device", color.LIGHT_WHITE },
	{ "strange device", color.GREEN },
	{ "very strange device", color.LIGHT_GREEN },
	{ "peculiar device", color.LIGHT_BLUE },
	{ "odd device", color.LIGHT_WHITE },
	{ "complicated-looking device", color.GREEN },
	{ "high-tech device", color.LIGHT_WHITE },
	{ "unfamiliar device", color.LIGHT_WHITE },
	{ "wierd device", color.LIGHT_WHITE },
	{ "unlikely device", color.LIGHT_WHITE },
	--
	{ "gizmo", color.LIGHT_BLUE },
	{ "strange gizmo", color.GREEN },
	{ "very strange gizmo", color.LIGHT_GREEN },
	{ "peculiar gizmo", color.LIGHT_BLUE },
	{ "odd gizmo", color.LIGHT_WHITE },
	{ "complicated-looking gizmo", color.GREEN },
	{ "high-tech gizmo", color.LIGHT_WHITE },
	{ "unfamiliar gizmo", color.LIGHT_WHITE },
	{ "wierd gizmo", color.LIGHT_WHITE },
	{ "unlikely gizmo", color.LIGHT_WHITE },
	--
	{ "gadget", color.LIGHT_BLUE },
	{ "strange gadget", color.GREEN },
	{ "very strange gadget", color.LIGHT_GREEN },
	{ "peculiar gadget", color.LIGHT_BLUE },
	{ "odd gadget", color.LIGHT_WHITE },
	{ "complicated-looking gadget", color.GREEN },
	{ "high-tech gadget", color.LIGHT_WHITE },
	{ "unfamiliar gadget", color.LIGHT_WHITE },
	{ "wierd gadget", color.LIGHT_WHITE },
	{ "unlikely gadget", color.LIGHT_WHITE },
	--
	-- Hmm. Grammatically correct, but misleading, I think...
	{ "instrument", color.LIGHT_WHITE },
	{ "strange instrument", color.GREEN },
	{ "very strange instrument", color.LIGHT_GREEN },
	{ "peculiar instrument", color.LIGHT_BLUE },
	{ "odd instrument", color.LIGHT_WHITE },
	{ "complicated-looking instrument", color.GREEN },
	{ "high-tech instrument", color.LIGHT_WHITE },
	{ "unfamiliar instrument", color.LIGHT_WHITE },
	{ "wierd instrument", color.LIGHT_WHITE },
	{ "unlikely instrument", color.LIGHT_WHITE },
}

flavour.pots = {
	{ "vial of green liquid", color.GREEN },
	{ "vial of green liquid", color.GREEN },
	{ "small cylinder", color.VIOLET },
}

flavour.colors = {
	{ "green", color.LIGHT_GREEN },
	{ "red", color.LIGHT_RED },
	{ "blue", color.LIGHT_BLUE },
	{ "brown", color.TAN },
	{ "yellow", color.YELLOW },
	{ "orange", color.ORANGE },
	{ "purple", color.VIOLET },
	{ "white", color.WHITE },
}

flavour.chem = {
	{ "foul smelling", color.TAN },
	{ "powdered", color.GREEN },
	{ "isolated", color.LIGHT_RED },
	{ "purified", color.WHITE },
	{ "toxic", color.YELLOW },
	{ "non toxic", color.LIGHT_BLUE },
	{ "stable", color.ORANGE },
	{ "unstable", color.RED },
}

flavour.hightech = {
	{ "massively complicated device", color.TAN },
	{ "absolutely bizarre device", color.GREEN },
	{ "mind-numbingly complex device", color.LIGHT_RED },
	{ "super high-tech device", color.WHITE },
	{ "unbelievably complicated device", color.YELLOW },
	{ "some sort of device", color.LIGHT_BLUE },
	{ "very strange device", color.ORANGE },
}

flavour.add_generator(TV_ELECTRONICS,
function(flavs, number)
	number = infinity
	flavour.make_from_list(flavs, number, flavour.tech)
end)

flavour.add_generator(TV_HIGH_TECH_COMPONENTS,
function(flavs, number)
	number = infinity
	flavour.make_from_list(flavs, number, flavour.hightech)
end)

flavour.add_generator(TV_POTION,
function(flavs, number)
	number = infinity
	flavour.make_from_list(flavs, number, flavour.pots)
end)

flavour.add_generator(TV_SALVE,
function(flavs, number)
	number = infinity
	flavour.make_from_list(flavs, number, flavour.colors)
end)

flavour.add_generator(TV_CHEMISTRY,
function(flavs, number)
	number = infinity
	flavour.make_from_list(flavs, number, flavour.chem)
end)
