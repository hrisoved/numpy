  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

      LDR R3, [R0, R1, LSL #2]
      MOV R4, R2
      CMP R2, R1
      BHS while2

while1:

      CMP R4, R1
      BHI End_Main
      LDR R5, [R0, R4, LSL #2]
      STR R3, [R0, R4, LSL #2]
      MOV R3, R5
      ADD R4, R4, #1
      B   while1


while2:

      CMP R4, R1
      BLT End_Main 
      LDR R5, [R0, R4, LSL #2]
      STR R3, [R0, R4, LSL #2]
      MOV R3, R5
      SUB R4, R4, #1
      B   while2



  @ End of program ... check your result

End_Main:
  BX    lr

  