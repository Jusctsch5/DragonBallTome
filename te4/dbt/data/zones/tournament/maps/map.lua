-- World Tournament, from DBT/data/maps/tournament.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "OUTSIDE_RING")
defineTile("d", "FLOOR", nil, "WT_CROWD_GREEN")
defineTile("c", "FLOOR", nil, "WT_CROWD_BLUE")
defineTile("e", "FLOOR", nil, "WT_CROWD_YELLOW")
defineTile("w", "WALL")
defineTile("i", "RING_EDGE")
defineTile("-", "RING")
defineTile("f", "WT_BLOCKER")
defineTile("a", "FLOOR", nil, "WT_TICKET")
defineTile("m", "FLOOR", nil, "WT_MEDIC")
defineTile("b", "FLOOR", nil, "WT_GUARD")
defineTile("h", "FLOOR", nil, "WT_BACKSTAGE")
defineTile("g", "WT_DOOR")
defineTile("<", "UP_EARTH")

startx = 3
starty = 23
endx = 3
endy = 23

return [[*******************************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*X......d...c.e.....c..d..e..c..d.....c..X*
*X..e...c......d.c..e....c.......ec....d.X*
*X..c.wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww.e.X*
*X..d.w..............................w...X*
*X.c..w..............................w.c.X*
*X.e..w......iiiiiiiiiiiiiiiiiii.....w...X*
*X.d..w......i-----------------i.....w...X*
*X..c.w......i-----------------i.....w.d.X*
*X....w......i-----------------i.....w.e.X*
*X.c..w......i-----------------i.....w.c.X*
*X..e.w......i-----------------i.....w...X*
*X....w......i-----------------i.....w...X*
*X....w......i-----------------i.....w.d.X*
*X....w......i-----------------i.....w.c.X*
*XXfXXX......i-----------------i.....w.e.X*
*Xa...X......i-----------------i.....w...X*
*X....X......i-----------------i.....w...X*
*X....X.m....iiiiiiiiiiiiiiiiiii.....w.c.X*
*X....XXXXXXXX.......................w.e.X*
*X....X......X.......................w.d.X*
*X...bX....h.Xwwwwwwwwwwwwwwwwwwwwwwww.c.X*
*X....g......X..c....d...c..d.......d....X*
*X.<..X......X.e....c...e....c...ec......X*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*******************************************]]

