[Memory]
adr value
 31    -2

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  31 #   -2         # R1 <- [M(31)]
  2:     LOD  2  31 #       -2     # R2 <- [M(31)]
  3: L   ADDI 1   1 #   -1         # R1 <- [R1] + 1
  4:     SUBI 2   1 #       -3     # R2 <- [R2] - 1
  5:     JMP  1   M #              # [R1] != 0 then jump to line 9
  9: M   JMP  2   L #              # [R2] != 0 then jump to line 3
  3: L   ADDI 1   1 #    0         # R1 <- [R1] + 1
  4:     SUBI 2   1 #       -4     # R2 <- [R2] - 1
  5:     JMP  1   M #              # [R1] == 0 then go next
  6:     ADDI 1 444 #  444         # R1 <- [R1] + 444
  7:     STR  1  75 #              # [R1] = 444 -> M(75)
  8:     JMP  1   N #              # [R1] != 0 then jump to line 12
 12: N   HLT        
## halt (1635823256)

[Memory]
adr value
 31    -2
 75   444

[Register]
R1: 444
R2:  -4
 X: undef

