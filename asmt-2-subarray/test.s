  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global arrayA
  .global arrayB

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  BL      InitRam         @ utility subroutine to initialise RAM from ROM

  LDR     R0, =arrayA     @ start address of arrayA
  LDR     R1, =8          @ size of arrayA (rows/cols)
  LDR     R2, =arrayB     @ start address of arrayB
  LDR     R3, =3          @ size of arrayB (rows/cols)

  LDMFD   SP!, {PC}


@
@ Utility subroutine to initialise RAM from ROM
@
InitRam:

  STMFD   SP!, {R4-R7,LR}
  
  LDR   R4, =init_start    @ start address of initialisation data
  LDR   R5, =init_end      @ end address of initialisation data
  LDR   R6, =data_start    @ start oddress of RAM data

whInit:
  CMP   R4, R5            @ copy word-by-word from init_start
  BHS   ewhInit           @   to init_end in ROM, storing in RAM
  LDR   R7, [R4], #4      @   starting at data_start
  STR   R7, [R6], #4      @
  B     whInit            @
ewhInit:                  @

  LDMFD SP!, {R4-R7,PC}   @ return


  .section  .rodata

init_start:
init_arrayA:
  .word   3,  6, 12,  9,  0, 17,  2,  8 @ we should not start checking for b if we start at 2... there 
  .word  14, 45,  8, 13, 19, 23, 31,  3 @ wont be enough space without wrapping around, makes sense?
  .word   5, 16, 37, 32, 74,  1, 66, 43 @ so we should start at 8?, nope if we dont have match at 17, then we start
  .word   9, 13, 53, 27, 72, 43, 17, 19 @new line @ y at 17?
  .word  15, 33, 65, 22,  4, 13, 12,  8 @ we made that code... but we wrap around too much... so we would like
  .word  48, 16, 32, 96,  8,  4, 48,  0 @ like to decrement the wrap around by 1 try to find where the 
  .word  27, 88, 92, 14,  6, 22, 77, 39
  .word  60, 71, 40, 91, 83, 22, 17, 13
  .equ   size_arrayA, .-init_arrayA

init_arrayB: // understand?
  .word  4, 48,  0 @  this is what i mean... if you look at this example, it is technciallly in A
  .word 22, 77, 39 @  but it is ont he edge... so we say it isnt, we have this code working, what we do...
  .word 22, 17, 12 // we dont start looking for the first element of b if we go to far on the collumns
  .equ   size_arrayB, .-init_arrayB // eventually... and then it wont find the next until
init_end: // it reaches next element in a that matches the 3rd row...  Do you know 
// Do you know what im saying?
// Yeah so it will find that, then it will go to next row (65) it wont find 
// and it will keep going through A, but because B didnt reset it will look for 13
//makes sense 
// the issue is.... if the next row isnt in the arrayA where it should be, but it 
@ somewhere else, it will take it that B is in A, when B is not in A as it should be.
@ the Array B example rn, is not in Array A, it should not be... but i am cetain if 
@ if we run the code, it will say it is
// make  b reset after it fids the last element in b in the first row? wait so
  .section  .data
data_start:

arrayA:
  .space  size_arrayA    @ enough space for the initial arrayA contents above

arrayB:
  .space  size_arrayB    @ enough space for the initial arrayB contents above

.end
