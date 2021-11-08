[Memory]
adr value
 70    21
 73     7
 75    34

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LODI X  70 #           70 # X <- 70
  2:     LODX 1   0 #   21         # R1 <- [M(70)]
  3:     ADDX 1   3 #   28         # R1 <- [R1] + [M(73)]
  4:     ADDX 1   5 #   62         # R1 <- [R1] + [M(75)]
  5:     STRX 1  10 #              # [R1] = 62 -> M(80)
  6:     HLT        
## halt (1635815655)

[Memory]
adr value
 70    21
 73     7
 75    34
 80    62

[Register]
R1:  62
R2: undef
 X:  70

