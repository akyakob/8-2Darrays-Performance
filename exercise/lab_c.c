/*---------------------------------------------------------------------------
  This program demonstrates a simple 2d dynamic array
  10/08/2019   R. Repka    Initial version
  student version
  
  valgrind --tool=memcheck --leak-check=yes --track-origins=yes
---------------------------------------------------------------------------*/
#include<stdio.h>
#include <stdlib.h>  
#include "Timers.h"

void free_matrix_space(double **M, int rows);

/* Dynamically Allocated Arrays */  
int main(int argc, char *argv[]) {    
   // row/index counters and row/col sizes
   int i,j; 
   int rows=ROWS,cols=COLS;

   // The key trick to a 2D matrix
   double **A = NULL; 

DECLARE_TIMER(TimerA)
START_TIMER(TimerA)
DECLARE_REPEAT_VAR(REPEAT_VAR)
BEGIN_REPEAT_TIMING(REPEAT_NUM,REPEAT_VAR)
   // Allocate space for array of pointers
   A = malloc( rows * sizeof(double *));
   
   // Allocate space for matrix dat elements  
   for (i=0; i< rows; i++){ 
      A[i] = malloc(cols * sizeof(double) );      
   }

#ifndef EN_TIME   
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
#endif 
   free_matrix_space(A,rows);
END_REPEAT_TIMING
PRINT_TIMER(TimerA)
PRINT_RTIMER(TimerA, REPEAT_NUM)   
 
   // The simple return of space
   //free(A);
   
   // Complex return of space

  return 0;
}

/*---------------------------------------------------------------------------
  This function frees a 2D matrix generated using individual row allocations
  
  where:  double **M - Point to an array of pointers to free  
          int row    - The number of array row elments in M
  Returns: nothing
  Error handling: none
---------------------------------------------------------------------------*/
void free_matrix_space(double **M, int rows) {
 for (int i=0; i<rows; i++) {
	free(M[i]);
	M[i] = NULL;
}
free(M);
M = NULL;
}
