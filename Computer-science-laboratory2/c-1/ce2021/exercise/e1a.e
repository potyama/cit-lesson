[Memory]
adr value
 31     1

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  31 #    1         # R1 <- [M(31)]
  2:     LOD  2  31 #        1     # R2 <- [M(31)]
  3: L   ADDI 1   1 #    2         # R1 <- [R1] + 1
  4:     SUBI 2   1 #        0     # R2 <- [R2] - 1
  5:     JMP  1   M #              # [R1] != 0 then jump to line 9
  9: M   JMP  2   L #              # [R2] == 0 then go next
 10:     ADDI 2 888 #      888     # R2 <- [R2] + 888
 11:     STR  2  75 #              # [R2] = 888 -> M(75)
 12: N   HLT        
## halt (1635823195)

[Memory]
adr value
 31     1
 75   888

[Register]
R1:   2
R2: 888
 X: undef

