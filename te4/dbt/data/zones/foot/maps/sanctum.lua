-- Foot Lair, from foot_lair.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(" ", "FLOOR")
defineTile("D", "WALL")
defineTile("s", "DOOR")
defineTile(".", "FLOOR")
defineTile("a", "FLOOR", nil, "RACE_JUVINILE_RED")
defineTile("w", "GLASS")
defineTile("b", "FLOOR", nil, "RACE_JUVINILE_GREEN")
defineTile("S", "FLOOR", nil, "RACE_SHREDDER")
defineTile("c", "FLOOR", nil, "RACE_JUVINILE_YELLOW")
defineTile("e", "FLOOR", nil, "RACE_DELIVERY_BOY")
defineTile("<", "UP_HOUSE")
defineTile("l", "FLOOR")
defineTile("P", "FLOOR", nil, "RACE_FOOT_HIGH")
defineTile("N", "FLOOR", nil, "RACE_FOOT_BASIC")
defineTile("-", "CARPET_GREEN")
defineTile("R", "FLOOR", nil, "RACE_FOOT_HIGH")
defineTile("B", "FLOOR")
defineTile("Q", "CARPET_GREEN", nil, "RACE_FOOT_HIGH")
defineTile("r", "FLOOR")
defineTile("O", "FLOOR", nil, "RACE_FOOT_MIDDLE")

startx = 9
starty = 10
endx = 9
endy = 10

return [[************************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*X    X                           X*
*X    D XXXXXXXXXXXXsXXXXXXXXXXXX X*
*X    X X....a.aw       wa.a....X X*
*XXXXXX X....b.bw   S   wb.b....X X*
*X    X X....c.cw   .   wc.c....X X*
*X    D X..e.a.aw   .   wa.a....X X*
*X    X X....b.bw   .   wb.b....X X*
*XXXXXX X....c.cw   .   wc.c....X X*
*X    X X<......w   .   w......<X X*
*X    D XXXXsXXXXXXX.XXXXXXXsXXXX X*
*X    X XXXXlXXXXXX . XXXXXXlXXXX X*
*XXXXXX XXXXsXXXXXX . XXXXXXsXXXX X*
*X    X XXXXPXNXPXP . PXXXXXPXXXX X*
*X    D XXXX     sP . Ps          X*
*X    XPXXXXXXXXXXP . PXXXXXXXXXXsX*
*XXXXXXXXXXXXXXXXXP . PX          X*
*XXXPPPPPPPPPPPPPPP . PX -------- X*
*XRX                . PX -------- X*
*XBX................. PX Q---Q--- X*
*XrX                  PX -------- X*
*XrXPPPPPPPPPPPPPPPPPPPX --Q---Q- X*
*XrXXXXXXXXXXXXXXXXXXXXX -------- X*
*X<XX  DO              s          X*
*XXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*XXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*XXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
************************************]]
