#include <math.h>
#include "MatrixMul.cu"


__host__ int main(float* S,float theta){


    int n=512;
    float a = M_PI/180;

    int Nthread = 1024;
    int Nblock=(n*8+Nthread)/Nthread;
    
    float C[]={(float)1,(float)sqrt(2),(float)0,(float)sqrt(2),(float)0,(float)1,(float)1,(float)1,(float)0,(float)sqrt(2),(float)1,(float)0,(float) sqrt(2),(float) -sqrt(2),(float)0,(float)1, (float)-1,(float)sqrt(2),(float)0,(float)-sqrt(2),(float)1,(float)-sqrt(2),(float)0,(float)sqrt(2),(float)0,(float)1,(float)-1,(float)-1,(float)0,(float)sqrt(2),(float)1,(float)0,(float)-sqrt(2),(float)-sqrt(2),(float)0,(float)1,(float)1,(float)-1,(float)0,(float)-sqrt(2)}
;
    float Y[]={ 1.0, sqrt(2)*cos(a*theta),sqrt(2)*sin(a*theta),sqrt(2)*cos(2*a*theta),sqrt(2)*sin(2*a*theta)};
    float* Sn;

    float* C_d;
    float* Y_d;
    float* G_d;
    float* Sn_d;
    float* S_d;

    Sn=(float*)malloc(n*8*sizeof(float));

    cudaMalloc((void **) &C_d,5*8*sizeof(float));
    cudaMalloc((void **) &Y_d,5*sizeof(float));
    cudaMalloc((void **) &G_d,8*sizeof(float));
    cudaMalloc((void **) &Sn_d,n*8*sizeof(float));
    cudaMalloc((void **) &S_d,8*sizeof(float));
 
    cudaMemcpy(C_d,C,5*8*sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(Y_d,Y,5*sizeof(float),cudaMemcpyHostToDevice);

    MatrixMul<<<Nblock,Nthread>>>(C_d,Y_d,G_d,8,5,1);

    MatrixMul<<<Nblock,Nthread>>>(G_d,Sn_d,S_d,8,1,n);

    cudaMemcpy(Sn,Sn_d,n*8*sizeof(float),cudaMemcpyDeviceToHost);









}
