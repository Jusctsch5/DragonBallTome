-- Land of Karin, from karinno.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("w", "GLASS")
defineTile("-", "GRASS")
defineTile(">", "SIGN_Roof_Access")
defineTile("d", "DOOR")
defineTile("r", "CARPET_RED")
defineTile("a", "CARPET_RED", nil, "RACE_KARIN")
defineTile("<", "UP_HOUSE")

startx = 2
starty = 12
endx = 2
endy = 12

return [[***********************
*XXXXXXXXXXXXXXXXXXXXX*
*X...................X*
*X.wwwwwwwwwwwwwww.X.X*
*X.w-------------w.X>X*
*X.w-------------w.XXX*
*X.wwwwwwwwdwwwwww...X*
*X...................X*
*X...rrrrrrrrrrrrrrr.X*
*X...rrrrrrrrrrrrrrr.X*
*X.X.rrrrrrrrrrarrrr.X*
*X.X.rrrrrrrrrrrrrrr.X*
*X<X.................X*
*XXXXXXXXXXXXXXXXXXXXX*
***********************]]
