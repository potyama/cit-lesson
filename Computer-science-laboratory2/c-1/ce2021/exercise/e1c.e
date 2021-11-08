[Memory]
adr value
 31    -1

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  31 #   -1         # R1 <- [M(31)]
  2:     LOD  2  31 #       -1     # R2 <- [M(31)]
  3: L   ADDI 1   1 #    0         # R1 <- [R1] + 1
  4:     SUBI 2   1 #       -2     # R2 <- [R2] - 1
  5:     JMP  1   M #              # [R1] == 0 then go next
  6:     ADDI 1 444 #  444         # R1 <- [R1] + 444
  7:     STR  1  75 #              # [R1] = 444 -> M(75)
  8:     JMP  1   N #              # [R1] != 0 then jump to line 12
 12: N   HLT        
## halt (1635823272)

[Memory]
adr value
 31    -1
 75   444

[Register]
R1: 444
R2:  -2
 X: undef

