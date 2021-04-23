#include <stdio.h>
#include <omp.h>

int main(int argc, char *argv[]){
  int i;
  #pragma omp parallel for private(i)
  for(i=0; i<10; i++)
    printf("Hello World! %d\n",i);
}
    
