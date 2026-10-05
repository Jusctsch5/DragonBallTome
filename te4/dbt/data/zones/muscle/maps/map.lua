-- Muscle Tower, from towerhq.map.

defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("A", "FLOOR", nil, "RACE_RRA_PRIVATE")
defineTile("d", "DOOR")
defineTile("B", "FLOOR", nil, "RACE_RRA_CORPORAL")
defineTile("C", "FLOOR", nil, "RACE_RRA_LIETENANT")
defineTile("a", "FLOOR", nil, "RACE_RRA_WHITE")
defineTile("Y", "FLOOR")
defineTile("c", "FLOOR", nil, "RACE_RRA_CAMERA")
defineTile("b", "FLOOR", nil, "RACE_RRA_TURRET")
defineTile("Z", "FLOOR")
defineTile("w", "GLASS")
defineTile("<", "UP_HOUSE")
defineTile("D", "WALL")

startx = 16
starty = 10
endx = 16
endy = 10

return [[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXXXXXXX...............XXXXXXXXX
XXXXXX....XXXXXXXXXXXXX....XXXXXX
XXXX...XXXXXXXXXXXAAAAXXXX...XXXX
XXX..XXX...d...XXXAABAXXXXXX..XXX
XX..XXXX.C.X.B.d.dAAAAXX.a.XX..XX
XX.XX..d...X...XdXXXXXXX.Y.XXX.XX
X..XX.XXXXXXXXXX.XAAAAXX...XcX..X
X.XXXdXXXXbXXXXX.XAAAAXXXZXXwXX.X
X.X....XX...XXXX.XXXXdXXX..d..d.X
X.X.AB.Xc...d...<...d.XXXXXXXXXXX
X.X....XX...XXXX.XXXXXXXbXXX..d.X
X.XXXXdXXXbXXAAX.XAAAXb...D..XX.X
X..XXX.XXXXXXAAX.XAAAXXX.XXXXX..X
XX.XXX.d....dAAXdXXdXXXX.XXXXX.XX
XX..XXXX..C.XXXX....XXXXdXXXX..XX
XXX..XXX....d..XXXXXX....XXX..XXX
XXXX...XXXXXXX........XXXX...XXXX
XXXXXX....XXXXXXXXXXXXX....XXXXXX
XXXXXXXXX...............XXXXXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]]
