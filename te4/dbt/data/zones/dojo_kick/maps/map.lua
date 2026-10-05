-- Kickboxing Gym, from DBT/data/maps/d_kick.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile("m", "WALL")
defineTile("-", "CARPET_GREEN")
defineTile(".", "FLOOR")
defineTile("w", "WALL")
defineTile("d", "DOOR")
defineTile("=", "CARPET_BLUE")
defineTile("B", "SIGN_Men_s_Changing_Room")
defineTile("C", "SIGN_Women_s_Changing_Room")
defineTile("a", "CARPET_BLUE", nil, "RACE_BOB")
defineTile("r", "CARPET_BLUE")
defineTile("<", "UP_DOJO")

startx = 12
starty = 19
endx = 12
endy = 19

return [[**********************
*XXXXXXXXXXXXXXXXXXXX*
*XmmmmmmmmmmmmmmmmmmX*
*X------------------X*
*X------------------X*
*X------------------X*
*X----------..wwwdwwX*
*XXXXX..XXXX..w=====X*
*X...dBCd..X..wa====X*
*X...XXXX..X..w=====X*
*X....X....X..wwwwwwX*
*X....X....X..------X*
*X....X....X..------X*
*X....X....X..------X*
*X....X....X..------X*
*X....XXXXXX..XXXXXXX*
*XXXXXX....d..XrrrrrX*
*X....XwwwwX..XrrrrrX*
*X............drrrrrX*
*X....X.....<.XrrrrrX*
*XXXXXXXXXXXXXXXXXXXX*
**********************]]
