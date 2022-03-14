  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Main
  .global Init_Test

  .equ    length_testAray, (size_testArray >> 2)


  .section  .text


Main:
  STMFD   SP!, {LR}

  @ write a program here to test your arrdel subroutine
  @ the start address of the array is referenced by the label testArray
  @ the length of the array is references by the label length_testAray

End_Main:
  LDMFD   SP!, {PC}


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  BL      InitRam                       @ utility subroutine to initialise RAM from ROM

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
init_testArray:
  .word  49, 37, 15, 44, 3, 17, 26, 3, 81, 15
  .equ   size_testArray, .-init_testArray
init_end:


  .section  .data
data_start:
testArray:
  .space  size_testArray   @ enough space for the initial array contents above

.end
