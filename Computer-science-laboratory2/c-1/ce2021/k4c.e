[Memory]
adr value
 15    87
 28     6

[Execution]
num      instruction    R1  R2   X   action
---------------------------------------------------------------
  1:     LOD  1  15 #   87         # R1 <- [M(15)]
  2:     LODI 2   1 #        1     # R2 <- 1
  3:     ADDI 1   3 #   90         # R1 <- [R1] + 3
  4:     SUB  1  28 #   84         # R1 <- [R1] - [M(28)]
  5:     ADDI 1   1 #   85         # R1 <- [R1] + 1
  6:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   79         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   80         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        2     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   74         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   75         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        3     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   69         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   70         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        4     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   64         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   65         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        5     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   59         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   60         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        6     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   54         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   55         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        7     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   49         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   50         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        8     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   44         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   45         # R1 <- [R1] + 1
 12:     ADDI 2   1 #        9     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   39         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   40         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       10     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   34         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   35         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       11     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   29         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   30         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       12     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   24         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   25         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       13     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   19         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   20         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       14     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   14         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   15         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       15     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #    9         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #   10         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       16     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #    4         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #    5         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       17     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] != 0 then jump to line 10
 10: L   SUB  1  28 #   -1         # R1 <- [R1] - [M(28)]
 11:     ADDI 1   1 #    0         # R1 <- [R1] + 1
 12:     ADDI 2   1 #       18     # R2 <- [R2] + 1
 13:     JMP  1   L #              # [R1] == 0 then go next
 14:     STR  2  39 #              # [R2] = 18 -> M(39)
 15: M   HLT        
## halt (1635825828)

[Memory]
adr value
 15    87
 28     6
 39    18

[Register]
R1:   0
R2:  18
 X: undef

