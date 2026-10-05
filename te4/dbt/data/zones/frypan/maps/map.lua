-- Mount Frypan, from DBT/data/maps/frypan.map.

defineTile("X", "MAP_BORDER")
defineTile("^", "MOUNTAIN")
defineTile("-", "GRASS")
defineTile("T", "TREE")
defineTile("w", "FIRE")
defineTile("#", "WALL")
defineTile(">", "DOWN_HOUSE")
defineTile("<", "UP_EARTH")

startx = 39
starty = 52
endx = 39
endy = 52

return [[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
X^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^X
X^^^^^^^^^^^^^^---^^^^^^T--T-T-T----T----T-T-----T----TT-T-----^^^^^^^^^^^^^^X
X^^^^^^^-----T---^^^T-TT----T--TTTT--T-T-T-T-T-T---T-----T------TT-T--^^^^^^^X
X^^^^----------^^^^-T-T----T-TT------------------TT-T-T----T-T-------T-T-^^^^X
X^--T------T--^^-T------T-T--------------------------TT-------T----------T--^X
X^-------T---T-T---TT--T-------------------------------TT-T-T----T-TT-----T-^X
X^--T------T--T-T--T--T----------wwwwwwwwwwwww-----------T---T-------T-T----^X
X^T---------T---T---T---------wwwwwwwwwwwwwwwwwww--------TT----TT--T-----T--^X
X^-T-T------------T----------wwwwwwwwwwwwwwwwwwwww--------T--T---T---T-T----^X
X^-----TT-------------------wwwwwwwwwwwwwwwwwwwwwww---------TT--T---------T-^X
X^-T-T--T---T--------------wwwwwwwwww----wwwwwwwwwww----------TT-T--T---T---^X
X^-----T-----T--T----------wwwwww-------------wwwwww------------------T--T--^X
X^T---T---T-----T---------wwwwww---##-----##---wwwwww---------T-----T-------^X
X^--------T----T----------wwwww----##-#-#-##----wwwww----------T-----T---T--^X
X^-T-T----T--T-T----------wwwww-----#######-----wwwww----------T-T---------T^X
X^T--T--T---T-T-----------wwwww-----#######-----wwwww------------T---T---T--^X
X^T---T-TT----------------wwwwww----###>###----wwwwww---------T-T-------T---^X
X^-T-T----T-T--T-----------wwwwww-------------wwwwww---------------T--T--T--^X
X^-------T---T-------------wwwwwwwwww-----wwwwwwwwww--------TT--T---T-----T-^X
X^T---TT--TT----T-----------wwwwwwwwwwwwwwwwwwwwwww--------T---T---TT--T----^X
X^T---------T---T------------wwwwwwwwwwwwwwwwwwwww---------T---------T---T--^X
X^---T--T---T-----------------wwwwwwwwwwwwwwwwwww----------T---T--T---T--T--^X
X^-T--T---T-T----T---------------wwwwwwwwwwwww------------T--T-T--T--------T^X
X^-T----T-----T---T--------------------------------------TT------T--T--T----^X
X^--T-----T--T--T-TT-------------------------------------T---T--T-----T--T--^X
X^T--TT-----T------TTT----------------------------------T----T-----T---T--T-^X
X^---T---T---T-----T--TT--------------------------------T--T------T--T------^X
X^T---T--T------T-----T-TT----------------------------T---T-T-T-T-----TT-TT-^X
X^-T--T-----T-----T-T--T--T-------------------------T----TT---T---T--T----T-^X
X^--T-T---T-T--T----T---T--TTT--------------------T-T--T---T----T----TT-T-T-^X
X^---T----T----T-------T--T---T-----------------T----------------T----------^X
X^---T-----T---T----TT---T-T---TT------------T-T--T---T-T----T-T--T--T--T---^X
X^-T-T---T--T---------------T--T-T-------T-T----T-T-T-----T-----T-----T---TT^X
X^--T---T-T---T-T--T--T-----T--T--T------T---TT-------T---TT--TTT---T-------^X
X^TT---T-----T--T--T-T---T---------T-----T-T-----T---------T-------T-T-----T^X
X^---------T-------T---T---T----T--T------T-----T--T---T-----TTT---T-----T--^X
X^--T-T--------T-----T-----T-T---T-TT-----T--T-TT--------T------T----T-T----^X
X^--T-T----T---T-----------------T---T----T-------T-TTT----T--TT--T------T--^X
X^--------T-------T--T-T-----T-T--T--T-----T---T----------T---------TT-T----^X
X^-T---T------T-T--------T-------TT-T-T----T-T---T--T--T---T--T-TT------T--T^X
X^-T------TT----------T--T-T--T--TT--T----T--T-----------T------TT----T-T---^X
X^------T-T----TT-T--------T---T--T-T----T----T--T--T--------T-T--T-T----T--^X
X^T----T--T-T-------T--T-T--T-----TT----T--T---T------T---T----T-----T--T--T^X
X^T---T--T----T--T--T--T-T--T-T-T-T----T---T----TTT-TT--T---T------T-T-T----^X
X^-T----T---T-T--T-----T---TTT-TT-T---T--T-T--T-----T-T--TT----T-T-----T--T-^X
X^---T-T----T---TT--T-T-------T---T----T-T---T---T------T---------T---T-----^X
X^-T-T----T--T---T--T---TT-TT-T--TTT---T-----T-------TT----TT-T-T---T-----T-^X
X^T---T-T------T---TT-T-T--T-TT---T-T---T--T--T---T--T----------T--T----T---^X
X^--TT------T-T---T--T-TT-------T---T----T--T-----TT-----T---T-T---T---T--T-^X
X^--T--T------T--T-T------T--TT----T-T---T----------T-T--T-------T--T-----T-^X
X^-T-T--T--T-------T--T--T-T--T--T-T-T---T-T-T--TT-------TT--T--T-------T---^X
X^---T-TT--T--T-T--T-T--T--T-T-----TTT-<-T----T-----TT-----T---T-T--T---T--T^X
X^-T----T-----T-------TT---T-T---T--TT---T---T--T-T----T---------T-T-T--T-T-^X
X^T-T-T-----T-----T-T----T-----T----TTTTTT-T----T----T-----T--T-T------T---T^X
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]]
