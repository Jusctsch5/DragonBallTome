-- Castle Pilaf, from DBT/data/maps/pilaf.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("r", "CARPET_RED")
defineTile("a", "CARPET_RED", nil, "RACE_PILAF")
defineTile("b", "FLOOR", nil, "RACE_MAI")
defineTile("c", "FLOOR", nil, "RACE_SHUU")
defineTile("d", "SIGN_The_Glorious_Emperor_Pilaf_s_Castle_is_u")
defineTile("<", "UP_EARTH")

startx = 20
starty = 17
endx = 20
endy = 17

return [[*****************************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*X..............rrrXXXrrr..............X*
*X..............rrrXaXrrr..............X*
*X..............brrrrrrrc..............X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................rrr.................X*
*X.................dr..................X*
*X..................<..................X*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*****************************************]]
