#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>


// __device__ float Mulsub(){
//     float out;

// }

__global__ void MatrixMul(float *M1,float *M2,float *M3, int n, int m, int p){

    int idx= blockIdx.x * blockDim.x + threadIdx.x;
    
    if(idx<n*p){ 
        int x=idx/p;
        int y=idx%p;
        float tmp;
        for (int i=0; i<m;i++){
            tmp+=M1[x*m+i]*M2[i*p+y];
        }
        M3[idx]=tmp;
    }

}

// __host__ int main(void){


//     int n=3;
//     int p=3;

//     float *M_h1, *M_h2,*M_h3, *M_d1,*M_d2,*M_d3;
//     printf("Etape 1 \n");
//     M_h1=(float*)malloc(n*p*sizeof(float));
//     M_h2=(float*)malloc(n*p*sizeof(float));
//     M_h3=(float*)malloc(n*p*sizeof(float));
//     // for (int m=0;m<n;m++){
//     //     M_h1[m]=(float*)malloc(p*sizeof(float));
//     //     M_h2[m]=(float*)malloc(p*sizeof(float));
//     //     M_h3[m]=(float*)malloc(p*sizeof(float));
//     // }

//     int Nthread=p;
//     int Nblock= n;
    
//     for (int i=0;i<n*p;i++){
        
//         M_h1[i]=1;
//         M_h2[i]=2;
        
//     }
//     printf("Etape 2 \n");
//     cudaMalloc((void **) &M_d1, n*p*sizeof(float));
//     cudaMalloc((void **) &M_d2, n*p*sizeof(float));
//     cudaMalloc((void **) &M_d3, n*p*sizeof(float));

//     cudaMemcpy(M_d1,M_h1,n*p*sizeof(float),cudaMemcpyHostToDevice);
//     cudaMemcpy(M_d2,M_h2,n*p*sizeof(float),cudaMemcpyHostToDevice);
//     //cudaMemcpy(M_d3,M_h3,n*sizeof(float*),cudaMemcpyHostToDevice);

//     printf("Etape 3 \n");

//     MatrixMul<<<Nblock,Nthread>>>(M_d1,M_d2,M_d3,n);

//     cudaMemcpy(M_h3,M_d3,n*p*sizeof(float),cudaMemcpyDeviceToHost);

//     cudaFree(M_d1);
//     cudaFree(M_d2);
//     cudaFree(M_d3);

//     int s;
//     printf("Which value to disp? \n");
//     scanf("%d", &s);
//     printf("%f \n", M_h3[s]);
//     // for(int i=0;i<n;i++){
//     //     printf("Etape 3.1 \n");
//     //     cudaMalloc((void **) &(M_d1[i]), p*sizeof(float));
//     //     printf("Etape 3.2 \n");
//     //     cudaMemcpy(M_d1[i],M_h1[i],p*sizeof(float),cudaMemcpyHostToDevice);
//     //     cudaMalloc((void **) &(M_d2[i]), p*sizeof(float));
//     //     printf("Etape 3.2 \n");
//     //     cudaMemcpy(M_d2[i],M_h2[i],p*sizeof(float),cudaMemcpyHostToDevice);
//     // }


// }