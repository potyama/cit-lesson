[Memory]
adr value
 70    21
 73     7
 75    34

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  70 #   21         # R1 <- [M(70)]
  2:     ADD  1  73 #   28         # R1 <- [R1] + [M(73)]
  3:     ADD  1  75 #   62         # R1 <- [R1] + [M(75)]
  4:     STR  1  80 #              # [R1] = 62 -> M(80)
  5:     HLT        
## halt (1635815377)

[Memory]
adr value
 70    21
 73     7
 75    34
 80    62

[Register]
R1:  62
R2: undef
 X: undef

