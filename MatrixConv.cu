#include "activation.cu"


__global__ void convolve2d(float* C, float* M, float* K, int n, int ksize){

    int idx= blockDim.x * blockIdx.x + threadIdx.x;
    int x= (idx%(n*n))/n;
    int y= idx%n; 
    int w = idx/(n*n);
    if (idx==0){
        printf("You are in the first convolve \n");
    }
    float tmp = float(0);
    
    for(int i=0; i<ksize;i++){
        for (int j=0; j<ksize;j++){
            if (idx==0){
                printf("%d \n", (x+i)*n+y+j);
                printf("K[(ksize-i)*ksize+(ksize-j)] = %f \n", K[(ksize-i-1)*ksize+(ksize-j-1)]);
                printf("M[(x+i)*n+y+j] = %f \n", M[(x+i)*n+y+j]);
                printf("K[(ksize-i)*ksize+(ksize-j)]*M[(x+i)*n+y+j] = %f \n", K[(ksize-i-1)*ksize+(ksize-j-1)]*M[(x+i)*n+y+j]);
                printf("tmp = %f \n", tmp);
            }
            tmp+=K[(ksize-i-1)*ksize+(ksize-j-1)+w*5*5]*M[(x+i)*n+y+j];
        }

    }
    
    C[idx]=activation(tmp/(n*n));
}


