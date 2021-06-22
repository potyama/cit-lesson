#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>

#define INPUTSIZE 2
#define THETA 0.1
#define LOOPNUM 10

double **read_csv(char *fname);
double Forward(double *input, int ni, double wio[ni]);
int Backward(double *input, double output, int ni,
double wio[ni], double eta, double teacher);

double **read_csv(char *fname){
	FILE *fp;

	double **buf;
	buf = (double **)malloc(sizeof(double *)*9);
	for(int i=0;i<9; i++){
		buf[i] = (double *)malloc(sizeof(double *)*3);
	}

	fp = fopen(fname, "r");
	if(fp == NULL){
		fprintf(stderr, "file open error");
		return NULL;
	}

	for(int i=0; i<9; i++){
		fscanf(fp, "%lf, %lf, %lf",&buf[i][0], &buf[i][1], &buf[i][2]);
		printf("%lf, %lf, %lf\n", buf[i][0], buf[i][1], buf[i][2]);
	}
	fclose(fp);
	return buf;
}

double Forward(double *input, int ni, double wio[ni]){
  double f=0,y=0;
  for(int i=0;i<ni;i++){
    f += input[i]*wio[i];
  }

  if(f-THETA>0){
    y=1;
  }else{
    y=0;
  }

  return y;
}

int Backward(double *input, double output, int ni, double wio[ni], double eta, double teacher){
  for(int i=0; i<ni; i++){
    wio[i] += eta * (teacher-output)*input[i];
  }

  if(wio == NULL){
    return -1;
  }else{
    return 0;
  }
}

//AND
/*double teacher[4][3] = {
	{0., 0., 0.},
	{1., 0., 0.},
	{0., 1., 0.},
	{1., 1., 1.}
};*/

//OR
/*double teacher[4][3] = {
	{0., 0., 0.},
	{1., 0., 1.},
	{0., 1., 1.},
	{1., 1., 1.}
};*/

//XOR
double teacher[4][3] = {
	{0., 0., 0.},
	{1., 0., 1.},
	{0., 1., 1.},
	{1., 1., 0.}
};



int main(int argc, char *argv[])
{
	double input[INPUTSIZE], output;
	double weight_io[INPUTSIZE];
	double rms=0.;
	int i, j,i_rms=0;

	srand(1);
	double **a = read_csv(argv[1]);
	double **b = read_csv(argv[2]);
	for(i=0; i<INPUTSIZE; i++)
	{
		weight_io[i] = ((double)rand()/RAND_MAX)/10;
	}


	for(i=0; i<LOOPNUM; i++){
		for(j=0; j<4; j++){
			input[0] = a[j][0];
			input[1] = a[j][1];
			output=Forward(input, INPUTSIZE,  weight_io);
			Backward(input, output, INPUTSIZE,
			 weight_io, 0.01, a[j][2]);
		}
	}


	for(i=0; i<=2; i++){
		for(j=0; j<=2; j++){
			input[0] = b[i*3+j][0];
			input[1] = b[i*3+j][1];
			output=Forward(input, INPUTSIZE, weight_io);
			rms+=(b[i*(3)+j][2]-output)*(b[i*(3)+j][2]-output);
			i_rms++;
			//printf("INPUT: %d %d OUTPUT: %f %f\n", i, j,
			 //output,(b[i*(3)+j][2]));
			printf("LOOPNUM:%d RMS:%f\n",i*3+j,sqrt(rms)/i_rms);

		}
	}



	return 0;
}

