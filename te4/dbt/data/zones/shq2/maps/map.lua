-- RRA Control, from control2.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("i", "FLOOR")
defineTile("c", "SIGN_A_sign_on_the_door_reads_Authorized_Pers")
defineTile("+", "DOOR")
defineTile("I", "FLOOR", nil, "RACE_RRA_COMMANDER")
defineTile("J", "FLOOR", nil, "RACE_RRA_SNIPER")
defineTile("T", "FLOOR", nil, "RACE_RRA_SHQ_INT")
defineTile("K", "FLOOR", nil, "RACE_RRA_LIETENANT")
defineTile("C", "FLOOR", nil, "RACE_RRA_SHQ_CAM")
defineTile("G", "GLASS")
defineTile("D", "WALL")
defineTile("<", "UP_EARTH")
defineTile("g", "FLOOR")
defineTile("H", "FLOOR", nil, "RACE_RRA_CAPTAIN")
defineTile("~", "WALL")
defineTile("E", "SIGN_A_bed", nil, "RACE_RRA_PRIVATE")
defineTile("a", "SIGN_The_floor_in_this_area_has_not_been_smoo")
defineTile("F", "SIGN_A_bed", nil, "RACE_RRA_CORPORAL")
defineTile("m", "FURNITURE")
defineTile("L", "FLOOR")
defineTile("f", "FLOOR")

startx = 33
starty = 17
endx = 33
endy = 17

return [[*******************************************************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*XXXXXXXXX......................XXXXXXXXXXXXXXXX...X.....XXXXXXXXX*
*XXXXXX....XXXXXXXXXXXXXXXXXXXXiXXXXXXXXXXXXXXc+.I.X.XXX....XXXXXX*
*XXXX...XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX+X...X.XXXXXX...XXXX*
*XXX..XXXXXXX..................................XXXXX.XXXXXXXX..XXX*
*XX..XXXXXXXX..................................XXX.........XXX..XX*
*XX.XX.+....+.............................J....XXX.XXXXXXX.XXXX.XX*
*X..XX.X....X..................................XXX....TXXX....X..X*
*X.XXX.X...KX..................................XCG....TXXXXX..XX.X*
*X.XXX.X..K.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX....TXX..X..XX.X*
*X.XXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.XXXXXX..X..XX.X*
*X.XXX.+...KXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX......X..X..XX.X*
*X.XXX.X....XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.X..X..XX.X*
*X.XXX.X..K.XT...........TXX...........XXT...........TX.X..X..XX.X*
*X.XXX+XXXXXX.............X..XXXXDXXXX..X.............X.X..X..XX.X*
*X.XT.......X.....XGX.....X.XX...c...XX.X.....XGX.....X.X..X..XX.X*
*X.XC.......+.....GCG.....+.XC...<...CX.+.....GCG.....+.X..X..XX.X*
*X.XT.......X.....XGX.....X.XX.......XX.X.....XGX.....XXXXXX..XX.X*
*X.XXX+XXXXXX.............X..XXXXDXXXX..X.............XCG..Dc.XX.X*
*X.XXX.X..KKXT...........TXX....X.X....XXT...........TXCG.XX..XX.X*
*X.XXX.+....XXXXXXXXXXXXXXXXXXX.....XXXXXXXXXXXXXXXXXXXCGgXX..XX.X*
*X.XXX.XK.H.XXXXXXXXXXXXXXXXXXXXX+XXXXXXXXXXXXXXXXXXXXXXX~XX..XX.X*
*X.XXX.XXXXXXXXXXXXXXXXXXXXE+....a....+EXXXX..T.T.T.T.T.X.XX..XX.X*
*X.XXX.X.K..K.....XXXXXXXXXXX.XXXXXXX.XXXXXX.KKK........X.XX..XX.X*
*X.XXX.X........K.XXXXXXXXXE+.+.FXF.+.+EXXXXHH..........X.XX..XX.X*
*X..XX.+........m.XXXXXXXXXXX.XXXXXXX.XXXXXXIL..........DfXXTTX..X*
*XX.XXXX.....H..K.XXXXXXXXXE+.+.FXF.+.+EXXXXHH..........XGXXXXX.XX*
*XX..XXXK..K......XXXXXXXXXXX.XXXXXXX.XXXXXX.KKK........XCXXXX..XX*
*XXX..XXXXXXXXXXXXXXXXXXXXXE+.+.FXF.+.+EXXXX..T.T.T.T.T.XXXXX..XXX*
*XXXX...XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX...XXXX*
*XXXXXX....XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX....XXXXXX*
*XXXXXXXXX...............................................XXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*******************************************************************]]
