-- Win the World Tournament!

-- Desc handling may need to be considered for failure and win conditions
-- Also...the title needs to consider the 22nd Tournament, for those rare
-- players who participate in the Tournament more than once.
add_quest
{
	global = "QUEST_TOURNAMENT"
	name = "The 21st Annual World Tournament"
	desc = function()
		if quest(QUEST_TOURNAMENT).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.tourny_round > 18 then
				line = {
					"#yThe 22nd Annual World Tournament (Victory!)",
					"Congratulations! You've won the 21st Annual World Tournament!"
				}
			elseif dball_data.tourny_round == 18 then
				line = {
					"#yThe 22nd Annual World Tournament (Final Round)",
					"This is it! Win this last round and you've won!"
				}
			elseif dball_data.tourny_round > 11 then
				line = {
					"#yThe 22nd Annual World Tournament (Round " .. dball_data.tourny_round .. ")",
					"You're in the final set of eliminations. Everyone left in this stage of",
					"the Tournament is a skilled and talented veteran. Be prepared for anything."
				}
			elseif dball_data.tourny_round > 5 then
				line = {
					"#yThe 22nd Annual World Tournament (Round " .. dball_data.tourny_round .. ")",
					"You're in the second set of eliminations. Competitors at this",
					"stage are both strong and skilled. Caution is advisable."
				}
			elseif dball_data.tourny_round > 0 then
				line = {
					"#yThe 22nd Annual World Tournament (Round " .. dball_data.tourny_round .. ")",
					"You're in the first set of eliminations. Competition is still fairly",
					"weak at this point, but it's swiftly rising."
				}
			elseif dball_data.tourny_registered == 1 then
				line = {
					"#yThe 22nd Annual World Tournament (Preliminary Round)",
					"Now that you're registered for the Tournament, you'll have to win",
					"a qualifying round against some bozo who probably doesn't have a",
					"clue what he's doing. Don't worry. You'll be matched with real",
					"fighters soon enough."
				}
			else
				line = {
					"#yThe 22nd Annual World Tournament",
					"The World Tournament is an annual gathering of martial artists",
					"from across the world to see who is the best of the best! Since",
					"you were little, you've always fantasized about winning, and now",
					"is your chance! Make us proud!"
				}
			end
			return line
		end
	end
	level = 1
	hooks =
	{
		[hook.GAME_START] = function(new)
			if new == true then
				acquire_quest(QUEST_TOURNAMENT, true)
			end
		end
		[hook.MONSTER_DEATH] = function(m_idx)
			if dball_data.tourny_now == 1 then
				-- If you are in the world tournament, there should only be one monster.
				-- If you kill it, you've won the round, so leave and move on.

				local monst = monster(m_idx)

				-- WT matches are rarely fatal
				if dball_data.tourny_type_of_fight == 0 then
					race_info(monst).max_num = 1
				end

				-- Note if it was Mr Satan who was defeated
				if monst.r_idx == RACE_MR_SATAN then
					dball_data.satan_defeated = 1
				end

				-- No longer in tournament round
				dball_data.tourny_now = 0

				-- Reset the current opponent
				dball_data.tourny_current_opponent = 0

				-- Reset the 'to the death' flag
				dball_data.tourny_type_of_fight = 0

				-- Increment round number
				if dball_data.tourny_round == 5 then
					message(color.YELLOW, "You're past the first set of eliminations! It will get tougher from here.")
				elseif dball_data.tourny_round == 18 then
					message(color.YELLOW, "The crowd goes wild!!!")
					dball.delete_monster(RACE_WT_TICKET_GIRL)
					dball.delete_monster(RACE_WT_GUARD)
					dball.delete_monster(RACE_WT_AUDIENCE_BLUE)
					dball.delete_monster(RACE_WT_AUDIENCE_GREEN)
					dball.delete_monster(RACE_WT_AUDIENCE_YELLOW)
					dball.delete_monster(RACE_WT_BACKSTAGE_GUY)
					dialogue.WT_WINNER()
					player.au = player.au + 100000
					player.redraw[FLAG_PR_BASIC] = true
					local obj = create_artifact(ART_WT_TROPHY)
					make_item_fully_identified(obj)
					dball.reward(obj)
					dball_data.tourny_registered = 5	-- Won
					if dball_data.satan_state == 3 then
						dball_data.videl_state = 7
					end
					quest(QUEST_TOURNAMENT).status = QUEST_STATUS_FINISHED
					if quest(QUEST_BRIEFS_TOURNAMENT_REWARD).status == QUEST_STATUS_TAKEN then
						quest(QUEST_BRIEFS_TOURNAMENT_REWARD).status = QUEST_STATUS_COMPLETED
					end
				else				
					message(color.YELLOW, "Congratulations! You've won the match")
				end
				dball_data.tourny_round = dball_data.tourny_round + 1
				cave_set_feat(20, 10, FEAT_FLOOR)

			end
		end
	}
}
