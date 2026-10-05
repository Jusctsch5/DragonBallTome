-- Judo Dojo, from DBT/data/maps/d_judo.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("-", "CARPET_GREEN")
defineTile("m", "WALL")
defineTile("a", "CARPET_GREEN", nil, "RACE_YAWARA")
defineTile("w", "WALL")
defineTile("d", "DOOR")
defineTile("A", "SIGN_a_chair")
defineTile("D", "SIGN_office")
defineTile("B", "SIGN_a_desk")
defineTile("<", "UP_DOJO")

startx = 3
starty = 12
endx = 3
endy = 12

return [[*************************
*XXXXXXXXXXXXXXXXXXXXXXX*
*X...X----------------mX*
*X...X----------------mX*
*X...X----------------mX*
*X...X-----------a----mX*
*X...X----------------mX*
*X...X----------------mX*
*X...X----------------mX*
*X...XXXwwwwXXdXXXwwwwXX*
*X..............X...A..X*
*X.............Dd...AB.X*
*X.<.XXXXXXXXXXXX......X*
*XXXXXXXXXXXXXXXXXXXXXXX*
*************************]]
