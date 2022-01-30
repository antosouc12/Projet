#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>


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
