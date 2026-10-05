-- Karate Dojo, from DBT/data/maps/d_kara.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile("m", "WALL")
defineTile("-", "CARPET_GREEN")
defineTile("a", "CARPET_GREEN", nil, "RACE_NAKAMURA")
defineTile(".", "FLOOR")
defineTile("d", "DOOR")
defineTile("w", "WALL")
defineTile("<", "UP_DOJO")
defineTile("T", "SIGN_Supplies")

startx = 2
starty = 16
endx = 2
endy = 16

return [[*******************
*XXXXXXXXXXXXXXXXX*
*Xm--------------X*
*Xm--------------X*
*Xm--------------X*
*Xm--------------X*
*Xm--------------X*
*Xm-----------a--X*
*Xm--------------X*
*Xm--------------X*
*Xm--------------X*
*Xm--------------X*
*Xm--------------X*
*XXXXXXXX...XXXXXX*
*X..........X..d.X*
*X.X...........w.X*
*X<X.......TX..w.X*
*XXXXXXXXXXXXXXXXX*
*******************]]
