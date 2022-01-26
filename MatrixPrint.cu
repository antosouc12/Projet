#include <stdio.h>
#include <stdlib.h>

__host__ void MatrixPrint(float* M, int n,int p){


    for(int i=0;i<n;i++){
        for(int j=0;j<p;j++){
            if (i==0 && j==0){
                printf("[[ %f, " , M[0]);
            }

            else if(i==(n-1) && j==(p-1)){
                printf(" %f ]] \n" , M[n*i+j]);
            }

            else if (j==(p-1)){
               printf(" %f ]  \n" , M[n*i+j]); 
            }

            else if (j==0){
               printf("[ %f,  " , M[n*i+j]); 
            }

            else {
                printf(" %f, " , M[n*i+j]); 
            }
        }
    }


}

