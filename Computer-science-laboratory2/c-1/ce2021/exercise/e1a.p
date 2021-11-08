  1:     LOD  1  31  #  R1 <- [M(31)]
  2:     LOD  2  31  #  R2 <- [M(31)]
  3: L   ADDI 1   1  #  R1 <- [R1] + 1
  4:     SUBI 2   1  #  R2 <- [R2] - 1
  5:     JMP  1   M  #  [R1] != 0 then jump to M
  6:     ADDI 1 444  #  R1 <- [R1] + 444
  7:     STR  1  75  #  [R1] -> M(75)
  8:     JMP  1   N  #  [R1] != 0 then jump to N
  9: M   JMP  2   L  #  [R2] != 0 then jump to L
 10:     ADDI 2 888  #  R2 <- [R2] + 888
 11:     STR  2  75  #  [R2] -> M(75)
 12: N   HLT         #  halt
 13: 31  Data   1  #  
