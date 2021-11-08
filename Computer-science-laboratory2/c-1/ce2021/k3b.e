[Memory]
adr value
 54     3

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  54 #    3         # R1 <- [M(54)]
  2:     LOD  2  54 #        3     # R2 <- [M(54)]
  3:     ADDI 1   2 #    5         # R1 <- [R1] + 2
  4:     SUBI 2   2 #        1     # R2 <- [R2] - 2
  5:     JMP  2   L #              # [R2] != 0 then jump to line 8
  8: L   ADD  1  54 #    8         # R1 <- [R1] + [M(54)]
  9:     ADDI 1   2 #   10         # R1 <- [R1] + 2
 10:     SUBI 2   1 #        0     # R2 <- [R2] - 1
 11:     JMP  2   L #              # [R2] == 0 then go next
 12:     STR  1  93 #              # [R1] = 10 -> M(93)
 13: M   HLT        
## halt (1635820088)

[Memory]
adr value
 54     3
 93    10

[Register]
R1:  10
R2:   0
 X: undef

