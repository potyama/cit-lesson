#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
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
int i,j, k;
double sum;
double start=0.0,end=0.0;
//行列計算
start = omp_get_wtime();
//#pragma omp parallel for private(j,k)
  for(i=0; i<size; i++){
    for(j=0; j<size; j++){
          sum=0.0;

      #pragma omp parallel for reduction(+:sum)
      for(k=0; k<size; k++){
        //printf("i=%d, j=%d,k=%d id =%d \n",i,j,k, omp_get_thread_num());
        sum +=  A[i][k] * B[k][j];
        //C[i][j] += A[i][k] * B[k][j];
      }
      C[i][j] = sum;
    }
  }


  end = omp_get_wtime();
  check_matrix(size, C, 1931702);
  printf("%lf\n", end-start);
  return 0;
}

