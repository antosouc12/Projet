#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>



__global__ void MatrixAdd(float *Mat1,float *Mat2,float *Mat3, int n, int p){

    int idx= blockIdx.x* blockDim.x+ threadIdx.x;

    if (idx<n*p){
        Mat3[idx]=Mat2[idx]+Mat1[idx];
    }


}




__host__ int main (void){


    int n=5;
    int p=5;

    float *M_h1, *M_h2,*M_h3, *M_d1,*M_d2,*M_d3;
    printf("Etape 1 \n");
    M_h1=(float*)malloc(n*p*sizeof(float));
    M_h2=(float*)malloc(n*p*sizeof(float));
    M_h3=(float*)malloc(n*p*sizeof(float));
    // for (int m=0;m<n;m++){
    //     M_h1[m]=(float*)malloc(p*sizeof(float));
    //     M_h2[m]=(float*)malloc(p*sizeof(float));
    //     M_h3[m]=(float*)malloc(p*sizeof(float));
    // }

    int Nthread=p;
    int Nblock= n;
    
    for (int i=0;i<n*p;i++){
       
        M_h1[i]=(float)i;
        M_h2[i]=(float)i;
       
    }
    printf("Etape 2 \n");
    cudaMalloc((void **) &M_d1, p*n*sizeof(float));
    cudaMalloc((void **) &M_d2, p*n*sizeof(float));
    cudaMalloc((void **) &M_d3, p*n*sizeof(float));
    cudaMemcpy(M_d1,M_h1,n*p*sizeof(float),cudaMemcpyHostToDevice);
    cudaMemcpy(M_d2,M_h1,n*p*sizeof(float),cudaMemcpyHostToDevice);
    printf("Etape 3 \n");
    // for(int i=0;i<n;i++){
    //     printf("Etape 3.1 \n");
    //     cudaMalloc((void **) &(M_d1[i]), p*sizeof(float));
    //     printf("Etape 3.2 \n");
    //     cudaMemcpy(M_d1[i],M_h1[i],p*sizeof(float),cudaMemcpyHostToDevice);
    //     cudaMalloc((void **) &(M_d2[i]), p*sizeof(float));
    //     printf("Etape 3.2 \n");
    //     cudaMemcpy(M_d2[i],M_h2[i],p*sizeof(float),cudaMemcpyHostToDevice);
    // }

    MatrixAdd<<<Nblock,Nthread>>>(M_d1,M_d2,M_d3,n,p);

    cudaMemcpy(M_h3,M_d3,n*p*sizeof(float),cudaMemcpyDeviceToHost);

    // for(int i=0;i<n;i++){
    //     printf("Etape 3.1 \n");
    //     cudaMalloc((void **) &(M_d3[i]), p*sizeof(float));
    //     printf("Etape 3.2 \n");
    //     cudaMemcpy(M_d3[i],M_h3[i],p*sizeof(float),cudaMemcpyHostToDevice);

    // }




    // for(int i=0;i<n;i++){
    //     cudaFree(M_d1[i]);
    //     cudaFree(M_d2[i]);
    //     cudaFree(M_d3[i]);
    //     free(M_h1[i]);
    //     free(M_h2[i]);
    //     free(M_h3[i]);

    // }

    printf("%f \n", M_h3[5]);

    cudaFree(M_d1);
    cudaFree(M_d2);
    cudaFree(M_d3);

    free(M_h1);
    free(M_h2);
    free(M_h3);

    return(0);

}