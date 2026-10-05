-- Buddhist Temple, from DBT/data/maps/catacomb.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("H", "FLOOR", nil, "RACE_MEDITATING_MONK")
defineTile(",", "FLOOR")
defineTile("D", "TEMPLE_LOCK")
defineTile("z", "FLOOR", nil, "RACE_CORRUPT_MONK_D")
defineTile("|", "SIGN_This_old_lantern_provides_some_illuminat")
defineTile("<", "UP_HOUSE")
defineTile("x", "FLOOR", nil, "RACE_CORRUPT_MONK_B")
defineTile("y", "FLOOR", nil, "RACE_CORRUPT_MONK_C")
defineTile("w", "FLOOR", nil, "RACE_CORRUPT_MONK_A")
defineTile("u", "FLOOR", nil, "RACE_MONK_RINGLEADER")
defineTile("B", "BUDDHA")
defineTile("A", "FLOOR", nil, "RACE_ABBOT")

startx = 52
starty = 9
endx = 52
endy = 9

return [[*******************************************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXXXX...........................X*
*XXXXXXXXXXXXXXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXX.X*
*XXXXXXXXXXXXXXX.....................XXXXXXXXXXXXXXX.X*
*XXXXXXXXXXXXXXX........XXXXX........XXXXXXXXXXXXXXX.X*
*X...XX...XX...X.....................X...XX...XX...X.X*
*X.H.XX...XX...X.....................X...XX...XX...X.X*
*X...XX...XX...X...,,,.........,,,...X...XX...XX...X.X*
*XXDXXXXDXXXXDXXzz.,|,....z....,|,.zzXXDXXXXDXXXXDXX<X*
*X.................,,,...xyx...,,,.................XXX*
*XXDXXXXDXXXXDXX........wwwww........XXDXXXXDXXXXDXXXX*
*X...XX...XX...X.....................X...XX...XX...XXX*
*X...XX...XX.H.X.X....w..,,,..w....X.X.H.XX...XX.H.XXX*
*X...XX...XX...X.X...xw.,,u,,.wx...X.X...XX...XX...XXX*
*XXXXXXXXXXXXXXX.X..zyw.,,B,,.wyz..X.XXXXXXXXXXXXXXXXX*
*X...XX...XX...X.X...xw.,,,,,.wx...X.X...XX...XX...XXX*
*X.H.XX...XX...X.X....w..,,,..w....X.X...XX...XX.H.XXX*
*X...XX...XX...X.....................X...XX...XX...XXX*
*XXDXXXXDXXXXDXX........wwwww........XXDXXXXDXXXXDXXXX*
*X.................,,,...xyx...,,,.................XXX*
*XXDXXXXDXXXXDXX...,|,....z....,|,...XXDXXXXDXXXXDXXXX*
*X...XX...XX...X...,,,.........,,,...X...XX...XX...XXX*
*X...XX.H.XX.A.X.....................X...XX.H.XX...XXX*
*X...XX...XX...X.....................X...XX...XX...XXX*
*XXXXXXXXXXXXXXX........XXXXX........XXXXXXXXXXXXXXXXX*
*XXXXXXXXXXXXXXX.....................XXXXXXXXXXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*******************************************************]]
