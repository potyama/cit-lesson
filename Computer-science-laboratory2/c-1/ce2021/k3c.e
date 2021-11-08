[Memory]
adr value
 54     4

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  54 #    4         # R1 <- [M(54)]
  2:     LOD  2  54 #        4     # R2 <- [M(54)]
  3:     ADDI 1   2 #    6         # R1 <- [R1] + 2
  4:     SUBI 2   2 #        2     # R2 <- [R2] - 2
  5:     JMP  2   L #              # [R2] != 0 then jump to line 8
  8: L   ADD  1  54 #   10         # R1 <- [R1] + [M(54)]
  9:     ADDI 1   2 #   12         # R1 <- [R1] + 2
 10:     SUBI 2   1 #        1     # R2 <- [R2] - 1
 11:     JMP  2   L #              # [R2] != 0 then jump to line 8
  8: L   ADD  1  54 #   16         # R1 <- [R1] + [M(54)]
  9:     ADDI 1   2 #   18         # R1 <- [R1] + 2
 10:     SUBI 2   1 #        0     # R2 <- [R2] - 1
 11:     JMP  2   L #              # [R2] == 0 then go next
 12:     STR  1  93 #              # [R1] = 18 -> M(93)
 13: M   HLT        
## halt (1635820095)

[Memory]
adr value
 54     4
 93    18

[Register]
R1:  18
R2:   0
 X: undef

