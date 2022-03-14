  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  LDR R5, =0                      @ ind =0;              
  SUB R5, R1, R3                  @ ind = biggerS#ize - smallerSize;
  LDR R8, =0                      @ indexA = 0
  LDR R9, =0                      @ indexB = 0
  LDR R7, =0                      @ collumnCounterA
  LDR R4, =0                      @ collumnCounterB
  MUL R6, R3, R3                  @ maximumIndexB = rowB^2
  MUL R12, R1, R1                 @ maxIndexA = rowA^2
  While:
  LDR R10, [R2, R9 , LSL #2]      @ elemtnOfB = addressB[indB];
  LDR R11, [R0, R8 , LSL #2]      @ elemtnOfA = addressB[indA];
  CMP R10, R11                    @ if (elemtnOfA == elemtnOfB)
  BNE Next_Element_A              @ {
  ADD R9, #1                      @ indexB++
  CMP R9, R6
  BGE endWhileIfTrue
  ADD R8, #1                      @ indexA++
  ADD R7, #1                      @ collumnTrackerA++
  ADD R4, #1                      @ collumnTrackerB++
  CMP R4, R3                      @ if (collumnTrackerB <= sizeB)
  BEQ Wrap_Around_A               @ 
  B While
Next_Element_A:
  LDR R4, =0
  LDR R9, =0
  ADD R8, #1
  ADD R7, #1
  CMP R7, R5
  BLE skip
  ADD R8, R3 
  LDR R4, =0
  SUB R8, #1
  LDR R7, =0
skip:
  CMP R8, R12
  BGE endWhileIfFalse
  B While 
Wrap_Around_A:
  ADD R4, R5                       @ collumnTrackerB
  SUB R4, R1
  ADD R8, R5
  B While
endWhileIfTrue:
  LDR R0, =1
  B End_Main
endWhileIfFalse:
  LDR R0, =0
End_Main:

  BX    lr