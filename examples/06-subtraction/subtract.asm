;==============================================================================
; Program: Single-Digit Subtraction
; Description: Subtracts two single-digit numbers and displays the result
; Author: Yunus Emre Vurgun
; Date: 2026
; Assembler: MASM/TASM
; Platform: DOS/DOSBox
;==============================================================================

.MODEL SMALL
.STACK 100H

.DATA
    msg1     DB 'Enter first number (0-9): $'
    msg2     DB 10,13,'Enter second number (0-9): $'
    result   DB 10,13,'Result: $'
    negative DB '-$'

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
    MOV CL, AL                  ; Store in CL
    
    ; Display result message
    LEA DX, result
    MOV AH, 9
    INT 21H
    
    ; Subtract
    MOV AL, BL                  ; Move first number to AL
    SUB AL, CL                  ; AL = AL - CL
    
    ; Check if result is negative
    JNS POSITIVE_RESULT         ; Jump if not signed (positive)
    
    ; Handle negative result
    LEA DX, negative
    MOV AH, 9
    INT 21H
    
    NEG AL                      ; Make AL positive for display
    
POSITIVE_RESULT:
    ; Display result
    ADD AL, 48                  ; Convert to ASCII
    MOV DL, AL
    MOV AH, 2
    INT 21H
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN

;==============================================================================
; Key Concepts:
;   - SUB instruction (subtraction)
;   - Signed number handling
;   - JNS (Jump if Not Signed) conditional jump
;   - NEG instruction (two's complement negation)
;
; Register Usage:
;   AL = Accumulator for subtraction
;   BL = First number (minuend)
;   CL = Second number (subtrahend)
;   DL = Character to display
;
; Flags Affected by SUB:
;   SF (Sign Flag) = 1 if result is negative
;   ZF (Zero Flag) = 1 if result is zero
;   CF (Carry Flag) = 1 if borrow occurred
;==============================================================================
