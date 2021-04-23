#include <stdio.h>
#include <stdlib.h>
#include "jikken.h"

int main(int argc, char *argv[])
{
/* ここに変数を定義します */
  int size;

  if ((argc != 2) || (size=atoi(argv[1]))<=0) {
    fprintf(stderr,"Invalid Argument\n");
    exit(1);
  }

/* ここまで実行すると、size に行列サイズが代入されます。*/
/* これより下にプログラムを作成してください。*/

  double A[size][size], B[size][size], C[size][size];
  for(int i=0; i<size; i++){
    for(int j=0; j<size; j++){
      C[i][j] = 0.0;
      for(int k=0; k<size; k++){
        C[i][j] += A[i][k] * B[k][j];
      }
    }
  }
  return 0;
}
