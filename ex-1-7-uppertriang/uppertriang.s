  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ An upper triangular matrix is a square matrix in which all
  @  entries below the main diagonal (top-left to bottom right)
  @  are zero

  @ result = TRUE;
  @ for (r = 1; r < N; r++)
  @ {
  @   for (c = 0; c < r; c++)
  @   {
  @     elem = matrix[r][c];
  @     if (elem != 0)
  @     {
  @       result = FALSE;
  @     }
  @   }
  @ }

  @
  @ implement your own solution here
  @

End_Main:
  BX      LR

  .end