# x86 Assembly Language Learning Guide

A comprehensive guide for beginners learning x86 assembly language programming.

## 📖 Table of Contents
1. [Introduction](#introduction)
2. [Understanding the Basics](#understanding-the-basics)
3. [Registers](#registers)
4. [Memory Addressing](#memory-addressing)
5. [Instructions](#instructions)
6. [DOS Interrupts](#dos-interrupts)
7. [Program Structure](#program-structure)
8. [Common Patterns](#common-patterns)
9. [Debugging Tips](#debugging-tips)
10. [Practice Exercises](#practice-exercises)

## 🎯 Introduction

### What is Assembly Language?
Assembly language is a low-level programming language that provides direct control over computer hardware. Each assembly instruction corresponds to a machine code instruction that the CPU can execute.

### Why Learn Assembly?
- **Understand how computers work** at the hardware level
- **Optimize performance-critical code**
- **Reverse engineering** and security research
- **Embedded systems** programming
- **Operating system** development

### Prerequisites
- Basic understanding of binary and hexadecimal numbers
- Familiarity with basic programming concepts
- Patience and attention to detail

## 🔧 Understanding the Basics

### Number Systems

#### Binary (Base 2)
```
1010b = 10 decimal
```

#### Hexadecimal (Base 16)
```
0Ah = 10 decimal
FFh = 255 decimal
```

#### Conversion Table
| Decimal | Binary | Hexadecimal |
|---------|--------|-------------|
| 0       | 0000   | 0           |
| 1       | 0001   | 1           |
| 10      | 1010   | A           |
| 15      | 1111   | F           |
| 255     | 11111111 | FF        |

### Data Sizes
- **Byte:** 8 bits (0-255 or -128 to 127)
- **Word:** 16 bits (0-65535 or -32768 to 32767)
- **Double Word:** 32 bits

## 📦 Registers

### General Purpose Registers (16-bit)

#### AX - Accumulator
- Primary register for arithmetic operations
- **AH:** High byte (bits 8-15)
- **AL:** Low byte (bits 0-7)
```assembly
MOV AX, 1234h    ; AX = 1234h
MOV AH, 12h      ; AH = 12h, AL unchanged
MOV AL, 34h      ; AL = 34h, AH unchanged
```

#### BX - Base Register
- Used for addressing memory
- Can hold memory addresses
```assembly
MOV BX, OFFSET data
MOV AL, [BX]     ; Load byte from memory at BX
```

#### CX - Counter Register
- Used for loop counters
- Automatically decremented by LOOP instruction
```assembly
MOV CX, 10       ; Loop 10 times
LOOP_START:
    ; ... code ...
LOOP LOOP_START  ; Decrement CX, jump if CX != 0
```

#### DX - Data Register
- Used for I/O operations
- Holds data for multiplication/division
```assembly
MOV DX, OFFSET message
MOV AH, 9
INT 21H          ; Display string at DX
```

### Segment Registers
- **CS:** Code Segment
- **DS:** Data Segment
- **SS:** Stack Segment
- **ES:** Extra Segment

### Index Registers
- **SI:** Source Index (for string operations)
- **DI:** Destination Index (for string operations)

### Pointer Registers
- **SP:** Stack Pointer
- **BP:** Base Pointer

## 🗺️ Memory Addressing

### Immediate Addressing
```assembly
MOV AL, 5        ; AL = 5 (immediate value)
```

### Register Addressing
```assembly
MOV AL, BL       ; AL = BL (register to register)
```

### Direct Addressing
```assembly
MOV AL, [1234h]  ; AL = byte at memory address 1234h
```

### Indirect Addressing
```assembly
MOV BX, 1234h
MOV AL, [BX]     ; AL = byte at address in BX
```

### Indexed Addressing
```assembly
MOV AL, [BX+SI]  ; AL = byte at address (BX + SI)
```

## 📝 Instructions

### Data Movement

#### MOV - Move Data
```assembly
MOV destination, source
MOV AX, 1234h    ; AX = 1234h
MOV BX, AX       ; BX = AX
```

#### LEA - Load Effective Address
```assembly
LEA DX, message  ; DX = offset of message
```

#### XCHG - Exchange
```assembly
XCHG AX, BX      ; Swap AX and BX
```

### Arithmetic Operations

#### ADD - Addition
```assembly
ADD AL, 5        ; AL = AL + 5
ADD AX, BX       ; AX = AX + BX
```

#### SUB - Subtraction
```assembly
SUB AL, 3        ; AL = AL - 3
```

#### MUL - Unsigned Multiplication
```assembly
MOV AL, 5
MOV BL, 3
MUL BL           ; AX = AL * BL = 15
```

#### DIV - Unsigned Division
```assembly
MOV AX, 15
MOV BL, 3
DIV BL           ; AL = quotient (5), AH = remainder (0)
```

#### INC/DEC - Increment/Decrement
```assembly
INC AL           ; AL = AL + 1
DEC BX           ; BX = BX - 1
```

### Logical Operations

#### AND - Bitwise AND
```assembly
AND AL, 0Fh      ; Mask upper 4 bits
```

#### OR - Bitwise OR
```assembly
OR AL, 80h       ; Set bit 7
```

#### XOR - Bitwise XOR
```assembly
XOR AL, AL       ; AL = 0 (fast way to clear)
```

#### NOT - Bitwise NOT
```assembly
NOT AL           ; Invert all bits
```

### Control Flow

#### JMP - Unconditional Jump
```assembly
JMP label        ; Jump to label
```

#### Conditional Jumps
```assembly
CMP AL, 5        ; Compare AL with 5
JE equal         ; Jump if equal
JNE not_equal    ; Jump if not equal
JG greater       ; Jump if greater
JL less          ; Jump if less
```

#### LOOP - Loop Control
```assembly
MOV CX, 10
loop_start:
    ; ... code ...
LOOP loop_start  ; Decrement CX, jump if CX != 0
```

### Stack Operations

#### PUSH - Push onto Stack
```assembly
PUSH AX          ; Push AX onto stack
```

#### POP - Pop from Stack
```assembly
POP BX           ; Pop top of stack into BX
```

## 🖥️ DOS Interrupts

### INT 21H - DOS Services

#### Function 01h - Read Character
```assembly
MOV AH, 01h
INT 21H          ; AL = character read
```

#### Function 02h - Display Character
```assembly
MOV DL, 'A'
MOV AH, 02h
INT 21H          ; Display 'A'
```

#### Function 09h - Display String
```assembly
LEA DX, message
MOV AH, 09h
INT 21H          ; Display string at DX (ends with '$')
```

#### Function 4Ch - Exit Program
```assembly
MOV AH, 4Ch
INT 21H          ; Terminate program
```

## 🏗️ Program Structure

### COM File Format
```assembly
org 100h         ; COM files start at offset 100h

; Code here
MOV DX, OFFSET msg
MOV AH, 9
INT 21H
ret

msg DB "Hello$"
```

### EXE File Format (SMALL Model)
```assembly
.MODEL SMALL
.STACK 100H

.DATA
    message DB "Hello, World!$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, message
    MOV AH, 9
    INT 21H
    
    MOV AH, 4Ch
    INT 21H
MAIN ENDP
END MAIN
```

## 🎨 Common Patterns

### ASCII to Number Conversion
```assembly
; Convert ASCII digit to number
SUB AL, 48       ; or SUB AL, '0'
; '5' (53) becomes 5
```

### Number to ASCII Conversion
```assembly
; Convert number to ASCII digit
ADD AL, 48       ; or ADD AL, '0'
; 5 becomes '5' (53)
```

### String Length Calculation
```assembly
LEA SI, string
MOV CX, 0
count_loop:
    MOV AL, [SI]
    CMP AL, '$'
    JE done
    INC SI
    INC CX
    JMP count_loop
done:
    ; CX = length
```

### Multi-Digit Number Display
```assembly
; Display number in AX
MOV BX, 10
MOV CX, 0
convert:
    MOV DX, 0
    DIV BX           ; Divide by 10
    PUSH DX          ; Save remainder
    INC CX
    CMP AX, 0
    JNE convert
    
display:
    POP DX
    ADD DL, 48       ; Convert to ASCII
    MOV AH, 2
    INT 21H
    LOOP display
```

## 🐛 Debugging Tips

### Common Mistakes

1. **Forgetting to initialize DS**
```assembly
; Wrong
.MODEL SMALL
.CODE
MAIN PROC
    LEA DX, message  ; DS not initialized!
    
; Correct
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, message
```

2. **String not terminated with '$'**
```assembly
; Wrong
msg DB "Hello"

; Correct
msg DB "Hello$"
```

3. **Division by zero**
```assembly
; Always check divisor
CMP BL, 0
JE skip_division
DIV BL
skip_division:
```

### Debugging Tools
- **emu8086:** Built-in debugger with step-through
- **DOSBox Debugger:** Command-line debugging
- **TD (Turbo Debugger):** Professional DOS debugger

## 📚 Practice Exercises

### Beginner
1. Display your name
2. Add two numbers and display result
3. Display numbers 1-10
4. Calculate factorial of a number

### Intermediate
5. Reverse a string
6. Check if a number is prime
7. Convert decimal to binary
8. Implement a simple calculator

### Advanced
9. Sort an array of numbers
10. Implement string search
11. Create a simple text editor
12. Write a file copy program

## 🎓 Next Steps

1. Complete all examples in this repository
2. Try the practice exercises
3. Read the [Interrupt Reference](INTERRUPT_REFERENCE.md)
4. Study the [Instruction Cheatsheet](INSTRUCTION_CHEATSHEET.md)
5. Build your own projects

## 📖 Additional Resources

- [Intel x86 Manual](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- [Art of Assembly Language](http://www.plantation-productions.com/Webster/)
- [x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)
- [OSDev Wiki](https://wiki.osdev.org/)

---

**Happy Learning! Keep practicing and experimenting! 🚀**
