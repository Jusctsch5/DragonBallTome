-- Dragonball T: 3d effects

-- Ox Castle, lower level
function dball.td_ox_1()
	for i = 19, 23 do
		cave_set_feat(24, i, FEAT_RED_CARPET)
		cave_set_feat(25, i, FEAT_RED_CARPET)
		cave_set_feat(26, i, FEAT_RED_CARPET)
		cave_set_feat(27, i, FEAT_RED_CARPET)
	end
	cave_set_feat(27, 18, FEAT_PERMA_WALL)
	cave_set_feat(27, 21, FEAT_LESS)
	cave_set_feat(27, 24, FEAT_PERMA_WALL)

	if quest(QUEST_RING_OF_FIRE).status == QUEST_STATUS_FINISHED then
		cave_set_feat(7, 1, FEAT_FLOOR)
		cave_set_feat(7, 2, FEAT_FLOOR)
		cave_set_feat(7, 3, FEAT_PERMA_WALL)
	else
		for i = 1, 4 do
			cave_set_feat(7, i, FEAT_WALL_OF_FIRE)
		end
	end
	cave_set_feat(6, 3, FEAT_PERMA_WALL)
	cave_set_feat(8, 3, FEAT_PERMA_WALL)
end
-- Ox Castle, Upper level
function dball.td_ox_2()
	for i = 18, 24 do
		cave_set_feat(24, i, FEAT_PERMA_WALL)
		cave_set_feat(25, i, FEAT_PERMA_WALL)
		cave_set_feat(26, i, FEAT_PERMA_WALL)
		cave_set_feat(27, i, FEAT_FLOOR)
	end
	cave_set_feat(27, 21, FEAT_DRAWBRIDGE)

	cave_set_feat(7, 1, FEAT_PERMA_WALL)
	cave_set_feat(7, 2, FEAT_PERMA_WALL)
	cave_set_feat(7, 3, FEAT_FLOOR)
	cave_set_feat(7, 4, FEAT_PERMA_WALL)

	cave_set_feat(6, 3, FEAT_FLOOR)
	cave_set_feat(8, 3, FEAT_FLOOR)
end
