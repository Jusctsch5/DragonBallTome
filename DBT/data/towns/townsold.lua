-- Handles the loading of towns

do
	-- Add towns in here
	local towns =
	{
		[1] = { "towns/earthsw.map", 	"towns/earthsw.map" }
		[2] = { "towns/earthse.map", 	"towns/earthse.map" }
		[3] = { "towns/earthnw.map", 	"towns/earthnw.map" }
		[4] = { "towns/earthne.map", 	"towns/earthne.map" }
		[5] = { "towns/nameksw.map", 	"towns/nameksw.map" }
		[6] = { "towns/namekse.map", 	"towns/namekse.map" }
		[7] = { "towns/nameknw.map", 	"towns/nameknw.map" }
		[8] = { "towns/namekne.map", 	"towns/namekne.map" }
		[9] = { "towns/kaiow.map", 	"towns/kaiow.map" }
		[10] = { "towns/79.map", 	"towns/79.map" }
		[11] = { "towns/plant.map", 	"towns/plant.map" }
		[12] = { "towns/babidi.map", 	"towns/babidi.map" }
	}

	assert(towns[player.town_num], "unknown town "..player.town_num)

	-- Selects the correct map based on destroyed state
	if town(player.town_num).destroyed then
		map.import(towns[player.town_num][2])
	else
		map.import(towns[player.town_num][1])
	end
end
