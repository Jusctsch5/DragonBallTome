-- Ballet School, from d_ball.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("<", "UP_EARTH")
defineTile("d", "DOOR")
defineTile("w", "GLASS")
defineTile("m", "WALL")
defineTile("B", "FLOOR", nil, "RACE_SUMIRE_SENSHI")
defineTile("-", "CARPET_GREEN")
defineTile("C", "FLOOR", nil, "RACE_MARIA_SENSHI")
defineTile("A", "FLOOR", nil, "RACE_SAKURA_SENSHI")
defineTile("D", "FLOOR", nil, "RACE_IRIS_SENSHI")
defineTile("+", "WALL")
defineTile("T", "SIGN_Changing_room")
defineTile(",", "FLOOR")

startx = 18
starty = 2
endx = 18
endy = 2

return [[***********************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*X.........XXX....<.........X....X*
*X.........XXX..............d....X*
*X.........XXXwwwwwwwwwwwX.XX....X*
*X.........XXXm.............X....X*
*X...B.....XXXm.............XXXXXX*
*X.........XXXm.............X----X*
*X......C..XXXm.............X----X*
*X.........XXXm.............X----X*
*X.A.......XXXm.............X----X*
*X.........XXXm.............X----X*
*X.........XXXm.............X----X*
*X.........XXXm.............X----X*
*X.D.......XXXm.............+----X*
*X.........XXXXXXXXXXXdXXXXTX----X*
*X..........d----------XXXXXX----X*
*X.........XXXXXXXXXXXXXXXXXXXXXXX*
*X..........d,,,,,,,,,,,,,,,,,,,,X*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
***********************************]]
