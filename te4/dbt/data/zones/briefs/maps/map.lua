-- Capsule Corporation, from DBT/data/maps/briefs.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile("H", "SIGN_This_long_workbench_is_cluttered_with_ha")
defineTile(".", "FLOOR")
defineTile("T", "FLOOR", nil, "RACE_TAMA")
defineTile("B", "FLOOR", nil, "RACE_BRIEFS")
defineTile("+", "DOOR")
defineTile("r", "CARPET_RED")
defineTile("=", "CARPET_BLUE")
defineTile("F", "SIGN_Dr_Briefs_bed_hasn_t_been_made")
defineTile("m", "WALL")
defineTile("<", "UP_EARTH")

startx = 11
starty = 11
endx = 11
endy = 11

return [[***********************
*XXXXXXXXXXXXXXXXXXXXX*
*XHHHHHHHH...HHHHHHHHX*
*XHHHHHHHH...HHHHHHHHX*
*XHH...............HHX*
*XHH..TB...........HHX*
*XHH...............HHX*
*XHH...............HHX*
*XXXXXX+XXX.XXX+XXXXXX*
*XrrrrrrrrX.X=======FX*
*XrrrrrrrrX.X=======FX*
*XmmmmmmmmX<X========X*
*XXXXXXXXXXXXXXXXXXXXX*
***********************]]
