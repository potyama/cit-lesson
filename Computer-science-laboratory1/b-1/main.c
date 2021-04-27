#include <stdio.h>
#include <stdlib.h>
#include "jikken.h"

int main(int argc, char *argv[])
{
/* ここに変数を定義します */
  int size;
	double val;
  if ((argc != 2) || (size=atoi(argv[1]))<=0) {
    fprintf(stderr,"Invalid Argument\n");
    exit(1);
  }

  double **A, **B, **C;
  A = malloc(sizeof(double *)*size);
  B = malloc(sizeof(double *)*size);
  C = malloc(sizeof(double *)*size);

  for(int i=0;i<size; i++){
    A[i] = malloc(sizeof(double)*size);
    B[i] = malloc(sizeof(double)*size);
    C[i] = malloc(sizeof(double)*size);
  }

make_matrix(size, 1, A, B, 1931702);

/* ここまで実行すると、size に行列サイズが代入されます。*/
/* これより下にプログラムを作成してください。*/

//行列計算
  for(int i=0; i<size; i++){
    for(int j=0; j<size; j++){
      for(int k=0; k<size; k++){
        C[i][j] += A[i][k] * B[k][j];
      }
    }
  }
  check_matrix(size, C, 1931702);
  return 0;
}

