  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @
  @ You can use either
  @
  @   The System stack (R13/SP) with PUSH and POP operations
  @
  @   or
  @
  @   A user stack (R12 has been initialised for this purpose)
  @

  @ R13 - SP!
  @ R0 - result
  @ R1 - string

  LDR R2, =0            @ index = 0;
  LDR R5, =0            @ value = 0;
  LDR R7, =10           @ multiplier = 10;

While:                  @ while(value != NULL){
  //LDR R2, =0          @ index = 0;
  LDRB R3,[R1, R2]      @ stringValue = address[index];
  CMP R3, #0            @ if( stringValue != 0 )
  BEQ storeResult       @ 
  ADD R2, #1            @ index++;

  CMP R3, '0'           @ if( stringValue >= 0 )
  BLT space             @

  CMP R5, 0             @ if( value != 0)
  BEQ singleDigit       @ 
  MUL R5, R7            @ value = value * multiplier;
singleDigit:            @ }
  SUB R3, 0x30          @ stringValue = stringValue - '0';
  ADD R5, R3            @ value = value + stringValue;
  B While               @ }

space:                  @ while(stringValue != 0){

  CMP R3, ' '           @ if(stringValue == ' ')
  BNE operator          @ {
  PUSH {R5}             @ push { value };
  LDR R5, =0            @ value = 0;
operator:               @ }

  CMP R3, '+'           @ if(stringValue == '+')
  BNE sub               @ {
  POP {R3, R4}          @ pop {firstValue, secondValue}
  ADD R5, R3, R4        @ value = firstValue + secondValue
sub:                    @ }

  CMP R3, '-'           @ if(stringValue == '-')
  BNE mul               @ {
  POP {R3, R4}          @ pop {firstValue, secondValue}
  SUB R5, R4, R3        @ value = secondValue - firstValue
mul:                    @ }

  CMP R3, '*'           @ if(stringValue == '*')
  BNE Branch            @  {
  POP {R3, R4}          @ pop {firstValue, secondValue};
  MUL R5, R3, R4        @ value = firstValue * secondValue;
Branch:                 @  }
 B While                @ }
storeResult:            @}

 MOV R0, R5             @ result = value;
                          
@ End of program ... check your result

End_Main:
  BX    lr

