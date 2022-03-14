  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

@
@ bubblesort exercise
@ See the Exercises discussion board on Blackboard
@

Main:

@
@ write your bubblesort program here
@
DoWhileStart:                @do{
  MOV R8, #0                 @    swapped = false;
  MOV R9, #1                 @    for(i = 1;
ForLoopStart:                @    i< N; i++)  {
  CMP R9, R2                 @
  BGE EndOfForLoop           @
  LDR R4, [R1, R9, LSL #2]   @ load[i]
  SUB R10, R9, #1            @ 
  LDR R5, [R1, R10, LSL #2]  @ load[i-1]
   CMP R5, R4                @ if( array[i-1] > array[i]) {
   BLT NoSwap
      MOV R11, R5            @ tmpswap = array[i-1];
      MOV R5, R4             @ array[i-1] = array[i];
      MOV R4, R11            @ array[i] = tmpswap;
      MOV R8, #1             @ swapped = true;
  NoSwap:                    @
    STR R4, [R1, R9, LSL #2] @   Bytes[address, i * 4] = array[i];
    STR R5, [R1, R10, LSL #2]@   Bytes[address, i * 4] = array[i - 1];
    ADD R9, R9, #1           @ i++;
    B ForLoopStart           @   }
EndOfForLoop:
  CMP R8, #1                 @ } while ( swapped );
  BEQ DoWhileStart           @
End_Main:                    @

  BX      LR

  .end