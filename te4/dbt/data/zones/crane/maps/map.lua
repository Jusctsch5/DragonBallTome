-- Crane Hermit, from DBT/data/maps/crane.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("T", "SIGN_Dinner_Table")
defineTile("b", "FLOOR", nil, "RACE_CHAOZU")
defineTile("c", "FLOOR", nil, "RACE_TENSHINHAN")
defineTile("<", "UP_EARTH")
defineTile("a", "FLOOR", nil, "RACE_CRANE_HERMIT")
defineTile("=", "KAME_TV")

startx = 2
starty = 6
endx = 2
endy = 6

return [[****************
*XXXXXXXXXXXXXX*
*X............X*
*X.TTT.b......X*
*X.TTT....c...X*
*X............X*
*X<.........a.X*
*X............X*
*X.....=......X*
*X............X*
*XXXXXXXXXXXXXX*
****************]]
