[Memory]
adr value
 15     0
 28     2

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  15 #    0         # R1 <- [M(15)]
  2:     LODI 2   1 #        1     # R2 <- 1
  3:     ADDI 1   3 #    3         # R1 <- [R1] + 3
  4:     SUB  1  28 #    1         # R1 <- [R1] - [M(28)]
  5:     ADDI 1   1 #    2         # R1 <- [R1] + 1
  6:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #    0         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #    1         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        2     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   -1         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #    0         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        3     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] == 0 then go next
 14:     STR  2  39 #              # [R2] = 3 -> M(39)
 15: M   HLT        
## halt (1635822435)

[Memory]
adr value
 15     0
 28     2
 39     3

[Register]
R1:   0
R2:   3
 X: undef

