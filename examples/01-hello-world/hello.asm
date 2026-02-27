;==============================================================================
; Program: Hello World
; Description: Displays a greeting message to the screen using DOS interrupt
; Author: Yunus Emre Vurgun
; Date: 2022 (Enhanced 2026)
; Assembler: MASM/TASM/emu8086
; Platform: DOS/DOSBox
;==============================================================================

org 100h                    ; COM file format - program starts at offset 100h

;------------------------------------------------------------------------------
; Main Program
;------------------------------------------------------------------------------
main:
    MOV DX, OFFSET msg      ; Load offset address of message into DX
    MOV AH, 9H              ; DOS function 09h - Display String
    INT 21H                 ; Call DOS interrupt
    ret                     ; Return to DOS

;------------------------------------------------------------------------------
; Data Section
;------------------------------------------------------------------------------
msg DB "Hi there! This is an example of 8086 assembly code. I'm Yunus E.V.$"
    ; DB = Define Byte
    ; $ = String terminator for DOS function 09h

;==============================================================================
; Register Usage:
;   AH = Function number for INT 21H
;   DX = Pointer to string to display
;
; DOS Interrupt 21H, Function 09H:
;   Input:  AH = 09h
;           DX = Offset of string (terminated with '$')
;   Output: String displayed to screen
;==============================================================================
