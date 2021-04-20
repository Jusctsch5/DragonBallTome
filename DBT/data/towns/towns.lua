-- Dragonball T: Planets

do
	-- Add towns in here
	local towns =
	{
		[1] = { "towns/earth1.map", 	"towns/earth1.map" }
		[2] = { "towns/earth2.map", 	"towns/earth2.map" }
		[3] = { "towns/earth3.map", 	"towns/earth3.map" }
		[4] = { "towns/earth4.map", 	"towns/earth4.map" }
		[5] = { "towns/earth5.map", 	"towns/earth1.map" }
		[6] = { "towns/earth6.map", 	"towns/earth6.map" }
		[7] = { "towns/earth7.map", 	"towns/earth7.map" }
		[8] = { "towns/earth8.map", 	"towns/earth8.map" }
		[9] = { "towns/earth9.map", 	"towns/earth9.map" }
		[10] = { "towns/nameksw.map", "towns/nameksw.map" }
		[11] = { "towns/namekse.map", "towns/namekse.map" }
		[12] = { "towns/nameknw.map", "towns/nameknw.map" }
		[13] = { "towns/namekne.map", "towns/namekne.map" }
		[14] = { "towns/kaiow.map", 	"towns/kaiow.map" }
		[15] = { "towns/79.map", 	"towns/79.map" }
		[16] = { "towns/plant.map", 	"towns/plant.map" }
		[17] = { "towns/babidi.map", 	"towns/babidi.map" }
	}

	assert(towns[player.town_num], "unknown town "..player.town_num)

	-- Selects the correct map based on destroyed state
	if town(player.town_num).destroyed then
		map.import(towns[player.town_num][2])
	else
		map.import(towns[player.town_num][1])
	end
end
