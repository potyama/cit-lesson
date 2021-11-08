  1:     LODI X  70  #  X <- 70
  2:     LOD  1  53  #  R1 <- [M(53)]
  3:     JMP  1   L  #  [R1] != 0 then jump to L
  4:     STRX 1   0  #  [R1] -> M([X]+0)
  5:     ADDI 1   1  #  R1 <- [R1] + 1
  6:     JMP  1   M  #  [R1] != 0 then jump to M
  7: L   STRX 1   0  #  [R1] -> M([X]+0)
  8:     SUBI 1   1  #  R1 <- [R1] - 1
  9:     ADDI X   1  #  X <- [X] + 1
 10:     JMP  1   L  #  [R1] != 0 then jump to L
 11:     STRX 1   0  #  [R1] -> M([X]+0)
 12: M   HLT         #  halt
 13: 70  Data  25  #  
 14: 71  Data   4  #  
 15: 72  Data  18  #  
 16: 73  Data  92  #  
 17: 74  Data   0  #  
 18: 75  Data  43  #  
 19: 76  Data  56  #  
 20: 77  Data   6  #  
 21: 78  Data  33  #  
 22: 79  Data   8  #  
 23: 53  Data   0  #  
