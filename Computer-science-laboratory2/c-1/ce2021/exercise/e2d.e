[Memory]
adr value
 53     8
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
  2:     LOD  1  53 #    8         # R1 <- [M(53)]
  3:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 8 -> M(70)
  8:     SUBI 1   1 #    7         # R1 <- [R1] - 1
  9:     ADDI X   1 #           71 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 7 -> M(71)
  8:     SUBI 1   1 #    6         # R1 <- [R1] - 1
  9:     ADDI X   1 #           72 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 6 -> M(72)
  8:     SUBI 1   1 #    5         # R1 <- [R1] - 1
  9:     ADDI X   1 #           73 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 5 -> M(73)
  8:     SUBI 1   1 #    4         # R1 <- [R1] - 1
  9:     ADDI X   1 #           74 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 4 -> M(74)
  8:     SUBI 1   1 #    3         # R1 <- [R1] - 1
  9:     ADDI X   1 #           75 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 3 -> M(75)
  8:     SUBI 1   1 #    2         # R1 <- [R1] - 1
  9:     ADDI X   1 #           76 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 2 -> M(76)
  8:     SUBI 1   1 #    1         # R1 <- [R1] - 1
  9:     ADDI X   1 #           77 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] != 0 then jump to line 7
  7: L   STRX 1   0 #              # [R1] = 1 -> M(77)
  8:     SUBI 1   1 #    0         # R1 <- [R1] - 1
  9:     ADDI X   1 #           78 # X <- [X] + 1
 10:     JMP  1   L #              # [R1] == 0 then go next
 11:     STRX 1   0 #              # [R1] = 0 -> M(78)
 12: M   HLT        
## halt (1635824889)

[Memory]
adr value
 53     8
 70     8
 71     7
 72     6
 73     5
 74     4
 75     3
 76     2
 77     1
 78     0
 79     8

[Register]
R1:   0
R2: undef
 X:  78

