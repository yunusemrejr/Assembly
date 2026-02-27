;==============================================================================
; Program: Single-Digit Multiplication
; Description: Multiplies two single-digit numbers and displays the result
; Author: Yunus Emre Vurgun
; Date: 2026
; Assembler: MASM/TASM
; Platform: DOS/DOSBox
;==============================================================================

.MODEL SMALL
.STACK 100H

.DATA
    msg1   DB 'Enter first number (0-9): $'
    msg2   DB 10,13,'Enter second number (0-9): $'
    result DB 10,13,'Result: $'

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Get first number
    LEA DX, msg1
    MOV AH, 9
    INT 21H
    
    MOV AH, 1                   ; Read character
    INT 21H
    SUB AL, 48                  ; Convert ASCII to number
    MOV BL, AL                  ; Store in BL
    
    ; Get second number
    LEA DX, msg2
    MOV AH, 9
    INT 21H
    
    MOV AH, 1                   ; Read character
    INT 21H
    SUB AL, 48                  ; Convert ASCII to number
    
    ; Multiply
    MUL BL                      ; AX = AL * BL
    MOV BX, AX                  ; Store result in BX
    
    ; Display result message
    LEA DX, result
    MOV AH, 9
    INT 21H
    
    ; Convert result to decimal and display
    MOV AX, BX                  ; Move result to AX
    MOV CX, 0                   ; Digit counter
    MOV BX, 10                  ; Divisor
    
CONVERT_LOOP:
    MOV DX, 0                   ; Clear DX for division
    DIV BX                      ; Divide AX by 10
    PUSH DX                     ; Push remainder (digit) onto stack
    INC CX                      ; Increment digit counter
    
    CMP AX, 0                   ; Check if quotient is 0
    JNE CONVERT_LOOP            ; If not, continue
    
DISPLAY_LOOP:
    POP DX                      ; Pop digit from stack
    ADD DL, 48                  ; Convert to ASCII
    MOV AH, 2                   ; Display character
    INT 21H
    LOOP DISPLAY_LOOP           ; Loop for all digits
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN

;==============================================================================
; Key Concepts:
;   - MUL instruction (unsigned multiplication)
;   - Division for decimal conversion
;   - Stack operations (PUSH/POP) for digit reversal
;   - Multi-digit number display
;
; Register Usage:
;   AL = First operand for MUL
;   BL = Second operand for MUL
;   AX = Result of multiplication (AL * BL)
;   CX = Digit counter
;   DX = Remainder in division
;
; MUL Instruction:
;   - MUL reg8:  AX = AL * reg8
;   - MUL reg16: DX:AX = AX * reg16
;==============================================================================
