[Memory]
adr value
 53     1
 70    25
 71     4
 72    18
 73    92
 74     0
 75    43
 76    56
 77     6
 78    33
 79     8

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LODI X  70 #           70 # X <- 70
  2:     LOD  1  53 #    1         # R1 <- [M(53)]
  3:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 1 -> M(70)
  8:     SUBI 1   1 #    0         # R1 <- [R1] - 1
  9:     ADDI X   1 #           71 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] == 0 then go next
 11:     STRX 1   0 #              # [R1] = 0 -> M(71)
 12: M   HLT        
## halt (1635824990)

[Memory]
adr value
 53     1
 70     1
 71     0
 72    18
 73    92
 74     0
 75    43
 76    56
 77     6
 78    33
 79     8

[Register]
R1:   0
R2: undef
 X:  71

