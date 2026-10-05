-- RRA Control, from control1.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("T", "FLOOR", nil, "RACE_RRA_SHQ_INT")
defineTile("i", "FLOOR")
defineTile("c", "SIGN_A_sign_on_the_door_reads_Authorized_Pers")
defineTile("D", "WALL")
defineTile("g", "SIGN_A_sign_on_the_door_reads_Mess_Hall")
defineTile("C", "FLOOR", nil, "RACE_RRA_SHQ_CAM")
defineTile("h", "SIGN_A_sign_on_the_wall_reads_Training_this_w")
defineTile("I", "FLOOR", nil, "RACE_RRA_COMMANDER")
defineTile("H", "FLOOR", nil, "RACE_RRA_CAPTAIN")
defineTile("G", "GLASS")
defineTile("d", "SIGN_There_s_a_control_room_on_the_other_side")
defineTile("o", "SIGN_This_room_intentionally_left_blank")
defineTile("L", "FLOOR")
defineTile("e", "SIGN_A_sign_on_the_door_reads_Storage")
defineTile("j", "SIGN_A_sign_on_the_door_reads_Restrooms_Autho")
defineTile("+", "DOOR")
defineTile("~", "WALL")
defineTile("K", "FLOOR", nil, "RACE_RRA_LIETENANT")
defineTile("f", "FLOOR")
defineTile("A", "FLOOR", nil, "RACE_RRA_PRIVATE")
defineTile("B", "FLOOR", nil, "RACE_RRA_CORPORAL")
defineTile("E", "FLOOR", nil, "RACE_RRA_LIETENANT")
defineTile("k", "SIGN_It_s_a_restroom_stall")
defineTile("l", "FLOOR")
defineTile("<", "UP_EARTH")
defineTile("a", "SIGN_A_sign_on_the_door_reads_Closet")
defineTile("b", "SIGN_Hmm_It_really_is_a_closet")
defineTile("p", "SIGN_The_brig")
defineTile("n", "SIGN_Shooting_range")
defineTile("=", "SIGN_A_bed")
defineTile("m", "FURNITURE")

startx = 33
starty = 17
endx = 33
endy = 17

return [[*******************************************************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*XXXXXXXXX......................XTXTXXX...XXXX.....X.....XXXXXXXXX*
*XXXXXX....XXXXXXXXXXXXXXXXXXXXiX.X..cD..cD.XX.....X.XXX....XXXXXX*
*XXXX...XXXXXXXXXXXXXXXXXXXXXXXXX.X.XXX...X.gD.....X.XXXXXX...XXXX*
*XXX..XXXXXXXXXXXXXXXXXXXXXCc.........XXXXXXXXXXXXXXhXXXXXXXX..XXX*
*XX..XX.........XI.....HXXXXDXXXX.X.X......XXXXXXXXX.XXXXXXXXX..XX*
*XX.XXX.........X.......Gd...X..X.X.XXXXXX.XXXXXXXXX.XXXXXXXXXX.XX*
*X..XXX....o....X...L...Gd...D..X.X.eD...X...........XXXXXXX..X..X*
*X.XXXX.........X.......Gd.c.XXXX.XXXX...X.XXXXXXXXX.XXXXXXX..XX.X*
*X.XXXX.........XH......XXXDXXT.....TX...XjXXXXXXXXX.XXXXXXXX+XX.X*
*X.XXXXXXXXXXXXXXXXXXX~XX....XXXX.XXXXXXXXDXXXXXXXXX........Ke.X.X*
*X.XXXXXXXXXXXXXXXXXXTfTX....XT.....TXG.........XXXX.XXXXXXXXX.X.X*
*X.XXXXXXX......ABEXXX.XX....XXXX.XXXXG.........XXXX.XXXXXXXXX.X.X*
*X.XXXXXXX.........XXT.TX....XT.....TXXk.k.k.k.kXXXX.XXXXXXXXX.X.X*
*X.XXXXXXX......ABEXXX.XX.c..XXXXDXXXXX+X+X+X+X+XXXX.XXXXXXXXX.X.X*
*X.XXXXXXX.........XXT.TXXDXXX...c...XXCX.X.X.XlXXXX.XXXXXXXXX.X.X*
*X.XXXXXXX......ABEXXX.XXX.XXC...<...CXXXXXXXXXXXXXX.XXXXXXXXX.X.X*
*X.XXXXXXX.........XXX.XXX.XXX...a...XXXXXXXXXXXXXXX.XXXXXXXXX.X.X*
*X.XXXXXXX......ABEX...GCX...XXXXDXXXXXXXXXX........KXXXXXXXXX.X.X*
*X.XXXXXXX.........X.XGXXXXX....XbXXXXXXXXXX.XXXXXXXXXXXXXXXXX.X.X*
*X.XXXXXXX......ABEX.XCXTTTXXXX.XXXA.AXXXXXX.XXXXXXXXXXXXXXXXX.X.X*
*X.XXXXXXX.........X.XXX...XXXX.XXX...XXXXXX.XXXXXXXXXXXXXXXXX.X.X*
*X.XXXXXXX......ABEX...D...+c...XXXA.AXXXXXX.XXXXXXXXXXXXXXXXX.X.X*
*X.XXXXXXXXXX...XXXXXXXX...XXXXXXXX...XpXXXX.XXXXXXXXXXXXXXXX..X.X*
*X.XXXXXXXXXXX.nXXXXXXXXTTTXXXXXXXXA..+.......................XX.X*
*X..XXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.XXXXXXXXXX..X*
*XX.XXXXX....D.......................................D....XXXXX.XX*
*XX..XXXX=...XXXXDXXXXDXXXXDXXXXDXDXXXXDXXXXDXXXXDXXXX....XXXX..XX*
*XXX..XXX....X....X....X....X....X...=X....X....X....X...=XXX..XXX*
*XXXX...XXXXXX.m..X...=X=...X.=..X....X...=X...=X...=XXXXXX...XXXX*
*XXXXXX....XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX....XXXXXX*
*XXXXXXXXX...............................................XXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*******************************************************************]]
