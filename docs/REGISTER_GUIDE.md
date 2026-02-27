# x86 Register Reference Guide

Complete guide to x86 registers and their usage in assembly programming.

## 📋 Table of Contents
- [Register Overview](#register-overview)
- [General Purpose Registers](#general-purpose-registers)
- [Segment Registers](#segment-registers)
- [Index and Pointer Registers](#index-and-pointer-registers)
- [Flags Register](#flags-register)
- [Register Usage Conventions](#register-usage-conventions)

## 🎯 Register Overview

The 8086/8088 processor has 14 registers, each 16 bits wide. These registers can be grouped into four categories:

1. **General Purpose Registers** (AX, BX, CX, DX)
2. **Segment Registers** (CS, DS, SS, ES)
3. **Index and Pointer Registers** (SI, DI, BP, SP)
4. **Special Registers** (IP, FLAGS)

### Register Diagram
```
┌─────────────────────────────────────────┐
│        General Purpose Registers        │
├──────────┬──────────┬──────────┬────────┤
│    AX    │    BX    │    CX    │   DX   │
│  AH│AL   │  BH│BL   │  CH│CL   │ DH│DL  │
└──────────┴──────────┴──────────┴────────┘

┌─────────────────────────────────────────┐
│         Segment Registers               │
├──────────┬──────────┬──────────┬────────┤
│    CS    │    DS    │    SS    │   ES   │
└──────────┴──────────┴──────────┴────────┘

┌─────────────────────────────────────────┐
│      Index & Pointer Registers          │
├──────────┬──────────┬──────────┬────────┤
│    SI    │    DI    │    BP    │   SP   │
└──────────┴──────────┴──────────┴────────┘

┌─────────────────────────────────────────┐
│         Special Registers               │
├──────────┬──────────────────────────────┤
│    IP    │          FLAGS               │
└──────────┴──────────────────────────────┘
```

## 🔧 General Purpose Registers

### AX - Accumulator Register
**Size:** 16 bits (AH = high byte, AL = low byte)

**Primary Uses:**
- Arithmetic operations
- I/O operations
- Function return values
- Multiplication and division

**Special Properties:**
- Required for MUL, DIV, IN, OUT instructions
- Used by many DOS interrupts

**Examples:**
```assembly
; Arithmetic
MOV AX, 10
ADD AX, 5        ; AX = 15

; Multiplication
MOV AL, 5
MOV BL, 3
MUL BL           ; AX = AL * BL = 15

; Division
MOV AX, 15
MOV BL, 3
DIV BL           ; AL = quotient (5), AH = remainder (0)

; I/O
MOV AH, 01h      ; DOS function
INT 21H          ; AL = character read

; Accessing high/low bytes
MOV AX, 1234h
MOV BL, AH       ; BL = 12h
MOV CL, AL       ; CL = 34h
```

---

### BX - Base Register
**Size:** 16 bits (BH = high byte, BL = low byte)

**Primary Uses:**
- Base pointer for memory addressing
- General purpose calculations
- Array indexing

**Special Properties:**
- Can be used in memory addressing: [BX], [BX+SI], [BX+DI]
- Often holds memory addresses

**Examples:**
```assembly
; Memory addressing
LEA BX, array
MOV AL, [BX]     ; AL = first element
INC BX
MOV AL, [BX]     ; AL = second element

; Array access
MOV BX, OFFSET data
MOV SI, 5
MOV AL, [BX+SI]  ; AL = data[5]

; General purpose
MOV BX, 100
ADD BX, 50       ; BX = 150
```

---

### CX - Counter Register
**Size:** 16 bits (CH = high byte, CL = low byte)

**Primary Uses:**
- Loop counter
- Shift/rotate count
- String operation count

**Special Properties:**
- Automatically decremented by LOOP instruction
- Used by REP prefix for string operations
- CL used for shift/rotate count

**Examples:**
```assembly
; Loop counter
MOV CX, 10
loop_start:
    ; ... code ...
LOOP loop_start  ; Decrement CX, jump if CX != 0

; String operations
MOV CX, 100      ; Repeat 100 times
LEA SI, source
LEA DI, dest
REP MOVSB        ; Copy 100 bytes

; Shift count
MOV AL, 10101010b
MOV CL, 3
SHL AL, CL       ; Shift left 3 times
```

---

### DX - Data Register
**Size:** 16 bits (DH = high byte, DL = low byte)

**Primary Uses:**
- I/O port addressing
- Extended arithmetic (with AX)
- String pointers for DOS functions

**Special Properties:**
- Used with AX for 32-bit operations
- Required for IN/OUT instructions
- Holds string addresses for INT 21H

**Examples:**
```assembly
; DOS string output
LEA DX, message
MOV AH, 09h
INT 21H

; Character output
MOV DL, 'A'
MOV AH, 02h
INT 21H

; 32-bit multiplication
MOV AX, 1000
MOV BX, 2000
MUL BX           ; DX:AX = AX * BX (32-bit result)

; Port I/O
MOV DX, 3F8h     ; COM1 port
IN AL, DX        ; Read from port
```

---

## 🗂️ Segment Registers

### Memory Segmentation
The 8086 uses segmented memory architecture. Physical address = (Segment × 16) + Offset

```
Physical Address = (Segment << 4) + Offset
Example: DS=1000h, Offset=0050h
Physical = (1000h × 16) + 0050h = 10000h + 50h = 10050h
```

### CS - Code Segment
**Purpose:** Points to the segment containing program code

**Properties:**
- Cannot be directly modified
- Used with IP to form instruction address
- Changed by FAR jumps and calls

**Example:**
```assembly
; CS:IP points to current instruction
; Cannot do: MOV CS, AX (invalid)
```

---

### DS - Data Segment
**Purpose:** Points to the segment containing program data

**Properties:**
- Must be initialized in .EXE programs
- Used for data access by default
- Can be changed to access different segments

**Example:**
```assembly
.MODEL SMALL
.CODE
MAIN PROC
    MOV AX, @DATA    ; Get data segment address
    MOV DS, AX       ; Initialize DS
    
    ; Now can access data
    MOV AL, [variable]
MAIN ENDP
```

---

### SS - Stack Segment
**Purpose:** Points to the segment containing the stack

**Properties:**
- Used with SP and BP
- Automatically used by PUSH, POP, CALL, RET
- Should not be changed during execution

**Example:**
```assembly
; SS:SP points to top of stack
PUSH AX          ; [SS:SP] = AX, SP decremented
POP BX           ; BX = [SS:SP], SP incremented
```

---

### ES - Extra Segment
**Purpose:** Additional segment for data access

**Properties:**
- Used for string operations (destination)
- Can be set to access different memory areas
- Used with DI for string destinations

**Example:**
```assembly
; String copy using ES
MOV AX, @DATA
MOV ES, AX
LEA DI, destination
LEA SI, source
MOV CX, 100
REP MOVSB        ; Copy from DS:SI to ES:DI
```

---

## 📍 Index and Pointer Registers

### SI - Source Index
**Size:** 16 bits

**Primary Uses:**
- Source pointer for string operations
- Array indexing
- General purpose pointer

**Examples:**
```assembly
; String operations
LEA SI, source
LODSB            ; AL = [DS:SI], SI incremented

; Array access
LEA SI, array
MOV AL, [SI]     ; First element
INC SI
MOV AL, [SI]     ; Second element
```

---

### DI - Destination Index
**Size:** 16 bits

**Primary Uses:**
- Destination pointer for string operations
- Array indexing
- General purpose pointer

**Examples:**
```assembly
; String operations
LEA DI, destination
STOSB            ; [ES:DI] = AL, DI incremented

; Array filling
LEA DI, buffer
MOV CX, 100
MOV AL, 0
REP STOSB        ; Fill 100 bytes with 0
```

---

### BP - Base Pointer
**Size:** 16 bits

**Primary Uses:**
- Stack frame pointer
- Accessing function parameters
- Local variable access

**Properties:**
- Uses SS segment by default
- Common in function prologues/epilogues

**Examples:**
```assembly
; Function with stack frame
PROC MyFunction
    PUSH BP
    MOV BP, SP       ; Set up stack frame
    SUB SP, 4        ; Allocate 4 bytes for locals
    
    ; Access parameters
    MOV AX, [BP+4]   ; First parameter
    MOV BX, [BP+6]   ; Second parameter
    
    ; Access locals
    MOV [BP-2], CX   ; First local variable
    
    MOV SP, BP       ; Restore stack
    POP BP
    RET
ENDP
```

---

### SP - Stack Pointer
**Size:** 16 bits

**Primary Uses:**
- Points to top of stack
- Automatically managed by PUSH/POP
- Modified by CALL/RET

**Properties:**
- Decrements on PUSH, increments on POP
- Should not be directly modified (except for stack frame setup)

**Examples:**
```assembly
; Stack grows downward
PUSH AX          ; SP = SP - 2, [SS:SP] = AX
PUSH BX          ; SP = SP - 2, [SS:SP] = BX
POP CX           ; CX = [SS:SP], SP = SP + 2
POP DX           ; DX = [SS:SP], SP = SP + 2
```

---

## 🚩 Flags Register

The FLAGS register contains status and control flags.

### Flag Bits
```
15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
 │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  │
 │  │  │  │  │  │  │  │  │  │  │  │  │  │  │  └─ CF - Carry Flag
 │  │  │  │  │  │  │  │  │  │  │  │  │  │  └──── (reserved)
 │  │  │  │  │  │  │  │  │  │  │  │  │  └─────── PF - Parity Flag
 │  │  │  │  │  │  │  │  │  │  │  │  └────────── (reserved)
 │  │  │  │  │  │  │  │  │  │  │  └───────────── AF - Auxiliary Carry
 │  │  │  │  │  │  │  │  │  │  └──────────────── (reserved)
 │  │  │  │  │  │  │  │  │  └─────────────────── ZF - Zero Flag
 │  │  │  │  │  │  │  │  └────────────────────── SF - Sign Flag
 │  │  │  │  │  │  │  └───────────────────────── TF - Trap Flag
 │  │  │  │  │  │  └──────────────────────────── IF - Interrupt Flag
 │  │  │  │  │  └─────────────────────────────── DF - Direction Flag
 │  │  │  │  └────────────────────────────────── OF - Overflow Flag
 └──└──└──└───────────────────────────────────── (reserved)
```

### Status Flags

#### CF - Carry Flag (bit 0)
- Set if arithmetic operation generates carry/borrow
- Used for unsigned arithmetic overflow

```assembly
MOV AL, 255
ADD AL, 1        ; CF = 1 (overflow)
```

#### ZF - Zero Flag (bit 6)
- Set if result is zero

```assembly
MOV AL, 5
SUB AL, 5        ; ZF = 1 (result is 0)
```

#### SF - Sign Flag (bit 7)
- Set if result is negative (bit 7 = 1)

```assembly
MOV AL, -1       ; SF = 1
```

#### OF - Overflow Flag (bit 11)
- Set if signed arithmetic overflow occurs

```assembly
MOV AL, 127
ADD AL, 1        ; OF = 1 (signed overflow)
```

#### PF - Parity Flag (bit 2)
- Set if result has even number of 1 bits

#### AF - Auxiliary Carry Flag (bit 4)
- Set if carry from bit 3 to bit 4
- Used for BCD arithmetic

### Control Flags

#### DF - Direction Flag (bit 10)
- Controls string operation direction
- 0 = increment SI/DI, 1 = decrement SI/DI

```assembly
CLD              ; Clear DF (increment)
STD              ; Set DF (decrement)
```

#### IF - Interrupt Flag (bit 9)
- Enables/disables interrupts

```assembly
CLI              ; Clear IF (disable interrupts)
STI              ; Set IF (enable interrupts)
```

---

## 📚 Register Usage Conventions

### DOS Function Calls
| Register | Usage |
|----------|-------|
| AH | Function number |
| AL | Subfunction / Return value |
| BX | File handle / Pointer |
| CX | Count / Length |
| DX | Pointer / Data |

### Function Parameters (Common Convention)
| Register | Usage |
|----------|-------|
| AX | First parameter / Return value |
| BX | Second parameter |
| CX | Third parameter |
| DX | Fourth parameter |

### Preserved Registers
Registers that should be preserved across function calls:
- BP
- SI
- DI
- DS
- ES

**Example:**
```assembly
MyFunction PROC
    PUSH BP
    PUSH SI
    PUSH DI
    
    ; Function code
    
    POP DI
    POP SI
    POP BP
    RET
MyFunction ENDP
```

### Scratch Registers
Registers that can be freely modified:
- AX
- BX
- CX
- DX

---

## 🎯 Quick Reference Table

| Register | Size | Primary Use | Can Split? |
|----------|------|-------------|------------|
| AX | 16-bit | Accumulator, I/O | Yes (AH/AL) |
| BX | 16-bit | Base pointer | Yes (BH/BL) |
| CX | 16-bit | Counter | Yes (CH/CL) |
| DX | 16-bit | Data, I/O | Yes (DH/DL) |
| SI | 16-bit | Source index | No |
| DI | 16-bit | Destination index | No |
| BP | 16-bit | Base pointer | No |
| SP | 16-bit | Stack pointer | No |
| CS | 16-bit | Code segment | No |
| DS | 16-bit | Data segment | No |
| SS | 16-bit | Stack segment | No |
| ES | 16-bit | Extra segment | No |
| IP | 16-bit | Instruction pointer | No |
| FLAGS | 16-bit | Status/Control flags | No |

---

**Master these registers and you'll master x86 assembly! 🚀**
