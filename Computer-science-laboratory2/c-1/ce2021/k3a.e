[Memory]
adr value
 54     2

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  54 #    2         # R1 <- [M(54)]
  2:     LOD  2  54 #        2     # R2 <- [M(54)]
  3:     ADDI 1   2 #    4         # R1 <- [R1] + 2
  4:     SUBI 2   2 #        0     # R2 <- [R2] - 2
  5:     JMP  2   L #              # [R2] == 0 then go next
  6:     STR  1  93 #              # [R1] = 4 -> M(93)
  7:     JMP  1   M #              # [R1] != 0 then jump to line 13
 13: M   HLT        
## halt (1635820085)

[Memory]
adr value
 54     2
 93     4

[Register]
R1:   4
R2:   0
 X: undef

