-- Foot Lair, from juvinile.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile(">", "DOWN_HOUSE")
defineTile("a", "FLOOR", nil, "RACE_JUVINILE_RED")
defineTile("l", "FLOOR")
defineTile("e", "FLOOR")
defineTile("c", "FLOOR", nil, "RACE_JUVINILE_YELLOW")
defineTile("b", "FLOOR", nil, "RACE_JUVINILE_GREEN")
defineTile("w", "GLASS")
defineTile("N", "FLOOR", nil, "RACE_FOOT_BASIC")
defineTile("m", "FURNITURE")
defineTile("<", "UP_EARTH")
defineTile("d", "SIGN_A_sign_on_the_door_reads_Restricted_Acce")
defineTile("D", "WALL")

startx = 2
starty = 13
endx = 2
endy = 13

return [[*************************
*XXXXXXXXXXXXXXXXXXXXXXX*
*X...XXXXXXXXXXX.......X*
*X.X.XXX...XXXXX.....X.X*
*X.X...X.X.X...X.....X.X*
*X.XXX.X.X...X.X.....X>X*
*X...X...XXXXXaX.....XXX*
*XXXlXXXXXXXXX.X.......X*
*X.....e.......X.......X*
*X...c.....c.XXX.......X*
*X.......e....bw..N...mX*
*X.X.a......e..w......mX*
*X.X..e.b......X......mX*
*X<X..........dD......mX*
*XXXXXXXXXXXXXXXXXXXXXXX*
*************************]]
