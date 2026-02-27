;==============================================================================
; Program: Two-Digit Addition Calculator
; Description: Takes two single-digit numbers as input and displays their sum
; Author: Yunus Emre Vurgun
; Date: 2022 (Enhanced 2026)
; Assembler: MASM/TASM
; Platform: DOS/DOSBox
;==============================================================================

.MODEL SMALL                ; Memory model - 64KB code, 64KB data
.STACK 100H                 ; Stack size - 256 bytes

;------------------------------------------------------------------------------
; Data Segment
;------------------------------------------------------------------------------
.DATA
    MSG3  DB 10,13, 10,13, 'Enter first number: $'
    MSG4  DB 10,13, 'Enter second number: $'
    MSG8  DB 10,13, 10,13, '- Yunus Emre Vurgun 2022 | Result: $'
    
    NUM1   DB ?             ; First number storage
    NUM2   DB ?             ; Second number storage
    RESULT DB ?             ; Result storage

;------------------------------------------------------------------------------
; Code Segment
;------------------------------------------------------------------------------
.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA           ; Load data segment address
    MOV DS, AX              ; Set DS register
    
    ; Get menu choice (simplified - assumes user enters 1 for addition)
    MOV AH, 1               ; DOS function 01h - Read character
    INT 21H                 ; Read input
    MOV BH, AL              ; Store in BH
    SUB BH, 48              ; Convert ASCII to number (48 = '0')
    
    CMP BH, 1               ; Check if user selected addition
    JE ADD_NUMBERS          ; Jump to addition routine
    
;------------------------------------------------------------------------------
; Addition Routine
;------------------------------------------------------------------------------
ADD_NUMBERS:
    ; Display prompt for first number
    LEA DX, MSG3            ; Load address of message 3
    MOV AH, 9               ; DOS function 09h - Display string
    INT 21H
    
    ; Get first number
    MOV AH, 1               ; DOS function 01h - Read character
    INT 21H
    MOV BL, AL              ; Store first number in BL
    
    ; Display prompt for second number
    LEA DX, MSG4            ; Load address of message 4
    MOV AH, 9               ; DOS function 09h - Display string
    INT 21H
    
    ; Get second number
    MOV AH, 1               ; DOS function 01h - Read character
    INT 21H
    MOV CL, AL              ; Store second number in CL
    
    ; Perform addition
    ADD AL, BL              ; Add BL to AL (second + first)
    MOV AH, 0               ; Clear AH for AAA instruction
    AAA                     ; ASCII Adjust After Addition
                            ; Converts binary result to unpacked BCD
    
    ; Convert result to ASCII for display
    MOV BX, AX              ; Move result to BX
    ADD BH, 48              ; Convert tens digit to ASCII
    ADD BL, 48              ; Convert ones digit to ASCII
    
    ; Display result message
    LEA DX, MSG8            ; Load address of result message
    MOV AH, 9               ; DOS function 09h - Display string
    INT 21H
    
    ; Display tens digit
    MOV AH, 2               ; DOS function 02h - Display character
    MOV DL, BH              ; Load tens digit
    INT 21H
    
    ; Display ones digit
    MOV AH, 2               ; DOS function 02h - Display character
    MOV DL, BL              ; Load ones digit
    INT 21H
    
EXIT:
    MOV AH, 4CH             ; DOS function 4Ch - Terminate program
    INT 21H
    
MAIN ENDP
END MAIN

;==============================================================================
; Register Usage:
;   AX = Accumulator for arithmetic and I/O
;   BX = Stores result and intermediate values
;   CX = Stores second input number
;   DX = Pointer for string operations
;
; Key Instructions:
;   AAA  = ASCII Adjust After Addition (converts to BCD)
;   LEA  = Load Effective Address
;   INT  = Software Interrupt
;
; DOS Interrupts Used:
;   INT 21H, AH=01h - Read character from keyboard
;   INT 21H, AH=02h - Display character
;   INT 21H, AH=09h - Display string
;   INT 21H, AH=4Ch - Terminate program
;==============================================================================
