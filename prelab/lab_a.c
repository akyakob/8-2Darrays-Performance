/*---------------------------------------------------------------------------
  This program demonstrates a faster 2d dynamic array
  10/08/2019   R. Repka    Initial version
  student version
  
  valgrind --tool=memcheck --leak-check=yes --track-origins=yes
---------------------------------------------------------------------------*/
#include<stdio.h>
#include <stdlib.h>

void free_all_matrix (double **A);

/* Dynamically Allocated Arrays */  
int main(int argc, char *argv[]) {   
   // row/index counters and row/col sizes
   int i,j; 
   int rows=3,cols=5; 

   // The key trick to a 2D matrix
   double **A = NULL; 
   
   // Used for pointer  management
   double *ptr = NULL;  

   // Allocate space for array of pointers
   A = malloc( rows * sizeof(double *));
   
   // Allocate all matrix at ocolse 
   ptr = calloc( rows * cols , sizeof(double));
   
   // Set array of row pointers properly
   for (i = 0; i < rows; i++) {
      A[i] = ptr + cols*i; 
   }
   
   // Initialize the matrix to nice data
   for (i = 0; i < rows; i++) {
      for (j = 0; j < cols; j++) {
         A[i][j] = (double)i +(double)j/10.0;
      }
   }
   
   // Print out the matrix
   printf("The %dx%d 2D dynamic matrix\n", rows, cols); 
   for (i=0; i< rows; i++){
      for (j=0; j< cols; j++){
         printf("%4.1f\t", A[i][j]);
      }
      printf("\n");
   }

   // Complex return of space
   free_all_matrix(A);

  return 0;
}

/*---------------------------------------------------------------------------
  This function frees a 2D matrix generated using block row allocations
  
  where:  double **M - Point to an array of pointers to free  
  Returns: nothing
  Error handling: none
---------------------------------------------------------------------------*/
void free_all_matrix (double **A) {
   free(A[0]);  /* free array of elements     */
   A[0] = NULL;
   free(A);       /* free array of ptrs to rows */
   A = NULL;
}