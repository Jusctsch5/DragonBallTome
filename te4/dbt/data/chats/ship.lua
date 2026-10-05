-- The capsule spaceship. The old planet flags are never set, so a ship you are holding can leave.

local function go(zone)
	return function(npc, player)
		game:changeLevel(1, zone)
	end
end

newChat{ id="where",
	text = [[The landing pods fold in. Where to?]],
	answers = {
		{"Earth", action=go("earth5")},
		{"Namek, southwest", action=go("nameksw")},
		{"Namek, southeast", action=go("namekse")},
		{"Namek, northwest", action=go("nameknw")},
		{"Namek, northeast", action=go("namekne")},
		{"North Kaio's planet", action=go("kaio")},
		{"Planet Plant", action=go("plant")},
		{"Planet 79", action=go("p79")},
		{"Babidi's ship", action=go("babidi")},
		{"Stay here."},
	},
}

return "where"
