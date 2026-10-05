-- Land of Karin, from k_land.map.

defineTile("B", "MAP_BORDER")
defineTile(" ", "SKY")
defineTile("X", "WALL")
defineTile(">", "DOWN_HOUSE")
defineTile("|", "WALL")
defineTile("c", "CLOUD")
defineTile("-", "GRASS")
defineTile("T", "TREE")
defineTile("a", "GRASS", nil, "RACE_OOPA")
defineTile("b", "GRASS", nil, "RACE_BOSA")
defineTile("<", "UP_EARTH")

startx = 76
starty = 132
endx = 76
endy = 132

return [[BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
B                XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                     B
B                       XXXXXXXXXXXXX>XXXXXXXXXXXXX                            B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                       cccc              B
B                                    |                      ccccc              B
B                                    |                       ccc               B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                     cc             |                                         B
B                    cccc            |                                         B
B                     cc             |  cc                                     B
B                                    | ccccc                                   B
B                                    |   cc                                    B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B        ccc                         |                                         B
B        cccc                        |                                         B
B         cc                         |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                          cc             B
B                                    |                         cccc            B
B                                    |                          cc             B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |            ccc                          B
B                                    |           ccccc                         B
B          ccc                       |            ccc                          B
B         ccccc                      |                                         B
B           cc                       |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                       cccc              B
B                                    |                      ccccc              B
B                                    |                       ccc               B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                     cc             |                                         B
B                    cccc            |                                         B
B                     cc             |  cc                                     B
B                                    | ccccc                                   B
B                                    |   cc                                    B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B        ccc                         |                                         B
B        cccc                        |                                         B
B         cc                         |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                          cc             B
B                                    |                         cccc            B
B                                    |                          cc             B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |            ccc                          B
B                                    |           ccccc                         B
B          ccc                       |            ccc                          B
B         ccccc                      |                                         B
B           cc                       |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B                                    |                                         B
B    ---------       --              |                     -------------       B
BT-----------------------------------|-----------------------------------------B
BTTT-T---T-T---T-T--T--T-----T-------|--------TT-------T---TT--TTT---T--------TB
BTTTT---T-----T--T--T-T---T----------|------T-----T---------T-------T-T----TTTTB
BTTT--------T-------T---T---T----T---|-----T-----T--T---T-----TTT---T-----T-TTTB
BTT--T-T--------T-----T-----T-T---T--|----TT--T-TT--------T------T----T-T----TTB
BTT--T-T----T---T--------T--------T--|---T-T-------T-TTT----T--TT--T------T---TB
BTTT-----T-T----TT-T--------T---T----|---------T--T--T--------T-T--T-T----T--TTB
BTT-T-T--T--T-------T--T--T-T--------|------T-T--TT-------TT--T--T-------T--TTTB
BT------TT--T--T-T--T-T--T-----------|---------T-----TT-----T---T-T--T---T-TTTTB
BTT-T----T-----T-------TT------------|-----------T-T----T---------T------TTTTTTB
BT-T----T--T-T-------T--T-T--------a-------------------T---T----T---T-T-----TTTB
BT-T---T--T----T--T--T--T-T--------------------------------------T------------TB
BTT--------T-------T--T-T------------b------T---T------------T--------------<-TB
BTTTT----T---T-T--T-----T---TTT-------------T--T-----T-T-------------T--------TB
BTT---T-T----T---TT--T-T-------T---T----T-T---T---T------T---------T---T---TTTTB
BTT-T-T----T--T---T--T---TT-TT-T--TTT---T-----T-------TT----TT-T-T---T----TT-TTB
BT-T---T-T------T---TT-T-T--T-TT-----T---T-----T---T--T----------T--T----T--TTTB
BTTTT---T------T-T--------T-------T----T------T---T--T--T---T--T-TT-----TTTTTTTB
BTTTT------TT----------T--T-T--T--TT--T----T--T--T--------T------TT----T-T--TTTB
BTT--TT------T-T---T--T-TT-------T-------T---T-----TT-----T---T-T---T---T--T-TTB
BT---T--T------T--T-T------T--TT----T-T--------T-----T-T--T-------T--T-----T--TB
BTTT-T-T-----T-----T-T----T-----T----TT--T--T----T----T-----T--T-T------T---T-TB
BTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTB
BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB]]
