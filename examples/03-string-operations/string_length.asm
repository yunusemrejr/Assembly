;==============================================================================
; Program: String Length Calculator
; Description: Calculates and displays the length of a string
; Author: Yunus Emre Vurgun
; Date: 2026
; Assembler: MASM/TASM
; Platform: DOS/DOSBox
;==============================================================================

.MODEL SMALL
.STACK 100H

.DATA
    input_msg  DB 'Enter a string (max 50 chars): $'
    result_msg DB 10,13,'String length: $'
    buffer     DB 51 DUP('$')    ; Buffer for input string
    length     DB 0               ; Store length

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Display input prompt
    LEA DX, input_msg
    MOV AH, 9
    INT 21H
    
    ; Read string from user
    LEA SI, buffer              ; SI points to buffer
    MOV CX, 0                   ; Counter for length
    
READ_LOOP:
    MOV AH, 1                   ; Read character
    INT 21H
    
    CMP AL, 13                  ; Check for Enter key (CR)
    JE CALCULATE_LENGTH         ; If Enter, stop reading
    
    MOV [SI], AL                ; Store character in buffer
    INC SI                      ; Move to next position
    INC CX                      ; Increment counter
    
    CMP CX, 50                  ; Check max length
    JL READ_LOOP                ; Continue if less than 50
    
CALCULATE_LENGTH:
    MOV length, CL              ; Store length
    
    ; Display result message
    LEA DX, result_msg
    MOV AH, 9
    INT 21H
    
    ; Convert length to ASCII and display
    MOV AL, length
    MOV AH, 0
    MOV BL, 10
    DIV BL                      ; Divide by 10
    
    ; Display tens digit
    ADD AL, 48                  ; Convert to ASCII
    MOV DL, AL
    MOV AH, 2
    INT 21H
    
    ; Display ones digit
    MOV DL, AH                  ; Remainder in AH
    ADD DL, 48                  ; Convert to ASCII
    MOV AH, 2
    INT 21H
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN

;==============================================================================
; Key Concepts:
;   - String input using buffered approach
;   - Loop counter for length calculation
;   - Division for multi-digit number display
;   - SI register for string indexing
;==============================================================================
