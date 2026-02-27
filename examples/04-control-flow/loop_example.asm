;==============================================================================
; Program: Loop and Counter Example
; Description: Displays numbers from 1 to 10 using a loop
; Author: Yunus Emre Vurgun
; Date: 2026
; Assembler: MASM/TASM
; Platform: DOS/DOSBox
;==============================================================================

.MODEL SMALL
.STACK 100H

.DATA
    header_msg DB 'Counting from 1 to 10:', 10,13,'$'
    space_char DB ' $'

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Display header
    LEA DX, header_msg
    MOV AH, 9
    INT 21H
    
    ; Initialize counter
    MOV CX, 10                  ; Loop 10 times
    MOV BL, 1                   ; Start from 1
    
DISPLAY_LOOP:
    ; Display current number
    MOV DL, BL                  ; Move number to DL
    ADD DL, 48                  ; Convert to ASCII
    MOV AH, 2                   ; Display character function
    INT 21H
    
    ; Display space
    LEA DX, space_char
    MOV AH, 9
    INT 21H
    
    ; Increment counter
    INC BL                      ; BL = BL + 1
    
    ; Loop control
    LOOP DISPLAY_LOOP           ; Decrement CX and jump if CX != 0
    
    ; New line
    MOV DL, 10                  ; Line feed
    MOV AH, 2
    INT 21H
    MOV DL, 13                  ; Carriage return
    MOV AH, 2
    INT 21H
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN

;==============================================================================
; Key Concepts:
;   - LOOP instruction (decrements CX and jumps if CX != 0)
;   - Counter-controlled loops
;   - INC instruction for incrementing
;   - Conditional loop termination
;
; Register Usage:
;   CX = Loop counter (automatically decremented by LOOP)
;   BL = Current number to display
;   DL = Character to display
;==============================================================================
