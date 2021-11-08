  1:     LOD  1  54  #  R1 <- [M(54)]
  2:     LOD  2  54  #  R2 <- [M(54)]
  3:     ADDI 1   2  #  R1 <- [R1] + 2
  4:     SUBI 2   2  #  R2 <- [R2] - 2
  5:     JMP  2   L  #  [R2] != 0 then jump to L
  6:     STR  1  93  #  [R1] -> M(93)
  7:     JMP  1   M  #  [R1] != 0 then jump to M
  8: L   ADD  1  54  #  R1 <- [R1] + [M(54)]
  9:     ADDI 1   2  #  R1 <- [R1] + 2
 10:     SUBI 2   1  #  R2 <- [R2] - 1
 11:     JMP  2   L  #  [R2] != 0 then jump to L
 12:     STR  1  93  #  [R1] -> M(93)
 13: M   HLT         #  halt
 14: 54  Data   2  #  
