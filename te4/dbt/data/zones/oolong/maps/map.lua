-- Castle Oolong, from DBT/data/maps/oolong.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile("g", "CARPET_GREEN")
defineTile("b", "CARPET_BLUE")
defineTile(".", "FLOOR")
defineTile("o", "CARPET_BLUE", nil, "RACE_OOLONG")
defineTile("e", "CARPET_BLUE")
defineTile("d", "DOOR")
defineTile("c", "CARPET_RED")
defineTile("r", "CARPET_RED")
defineTile("a", "CARPET_RED")
defineTile("D", "WALL")
defineTile("p", "CARPET_GREEN", nil, "RACE_WHINY_ARU")
defineTile("q", "CARPET_RED", nil, "RACE_WHINY_ARU")
defineTile("V", "SIGN_A_beautiful_fountain")
defineTile("<", "UP_EARTH")

startx = 20
starty = 17
endx = 20
endy = 17

return [[*****************************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*XggggggXbbbbbbXXXXXXXXXX.......XggggggX*
*XggggggXbobbbbXXXXXXXXXX.......XggggggX*
*XggggggXbbbbbbedcrrrrraD.......XggggggX*
*XgggpggXbbbbbbXXXXXrXXXX.......XgggpggX*
*XggggggXbbbbbbXXXXXrXXXX.......XggggggX*
*XggggggXbbbbbbXXXXXdXXXX.......XggggggX*
*XXXXdXXXXXXXXXXXrrrrrrrXXXXXXXXXXXdXXXX*
*XrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrX*
*XrrrrrrrrqrrrrrqrrVVVrrrrqrrrrrrrrrqrrX*
*XrrrrrrrrrrrrrrrrrVVVrrrrrrrrrrrrrrrrrX*
*XXXXdXXXXXdXXXrrrrrrrrrrrXXXdXXXXXXdXXX*
*XggggggXgggggXXXrrrrrrrXXXgggggXggggggX*
*XggggggXgggggXXXXXrrrXXXXXgggggXggggggX*
*XggpgggXggpggXXXXXrrrXXXXXggpggXgggpggX*
*XggggggXgggggXXXXXrrrXXXXXgggggXggggggX*
*XggggggXgggggXXXXXr<rXXXXXgggggXggggggX*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*****************************************]]
