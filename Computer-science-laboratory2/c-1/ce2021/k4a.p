  1:     LOD  1  15  #  R1 <- [M(15)]
  2:     LODI 2   1  #  R2 <- 1
  3:     ADDI 1   3  #  R1 <- [R1] + 3
  4:     SUB  1  28  #  R1 <- [R1] - [M(28)]
  5:     ADDI 1   1  #  R1 <- [R1] + 1
  6:     JMP  1   L  #  [R1] != 0 then jump to L
  7:     ADDI 2   1  #  R2 <- [R2] + 1
  8:     STR  2  39  #  [R2] -> M(39)
  9:     JMP  2   M  #  [R2] != 0 then jump to M
 10: L   SUB  1  28  #  R1 <- [R1] - [M(28)]
 11:     ADDI 1   1  #  R1 <- [R1] + 1
 12:     ADDI 2   1  #  R2 <- [R2] + 1
 13:     JMP  1   L  #  [R1] != 0 then jump to L
 14:     STR  2  39  #  [R2] -> M(39)
 15: M   HLT         #  halt
 16: 15  Data   0  #  
 17: 28  Data   2  #  
