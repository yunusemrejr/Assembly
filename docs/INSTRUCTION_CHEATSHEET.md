# x86 Assembly Instruction Cheatsheet

Quick reference for common x86 assembly instructions.

## 📋 Categories
- [Data Movement](#data-movement)
- [Arithmetic](#arithmetic)
- [Logical Operations](#logical-operations)
- [Shift and Rotate](#shift-and-rotate)
- [Control Flow](#control-flow)
- [String Operations](#string-operations)
- [Stack Operations](#stack-operations)
- [Miscellaneous](#miscellaneous)

---

## 📦 Data Movement

### MOV - Move Data
```assembly
MOV dest, source     ; dest = source
```
**Examples:**
```assembly
MOV AX, 1234h       ; AX = 1234h
MOV BX, AX          ; BX = AX
MOV [1000h], AL     ; Memory[1000h] = AL
MOV CL, [BX]        ; CL = Memory[BX]
```
**Restrictions:**
- Cannot move memory to memory
- Cannot move segment to segment
- Cannot move immediate to segment

---

### LEA - Load Effective Address
```assembly
LEA dest, source     ; dest = address of source
```
**Examples:**
```assembly
LEA BX, array       ; BX = offset of array
LEA SI, [BX+4]      ; SI = BX + 4
```

---

### XCHG - Exchange
```assembly
XCHG op1, op2       ; Swap op1 and op2
```
**Examples:**
```assembly
XCHG AX, BX         ; Swap AX and BX
XCHG AL, [SI]       ; Swap AL and memory
```

---

### XLAT - Translate
```assembly
XLAT                ; AL = [BX + AL]
```
**Example:**
```assembly
LEA BX, table
MOV AL, 5
XLAT                ; AL = table[5]
```

---

## ➕ Arithmetic

### ADD - Addition
```assembly
ADD dest, source    ; dest = dest + source
```
**Flags:** CF, ZF, SF, OF, AF, PF

**Examples:**
```assembly
ADD AL, 5           ; AL = AL + 5
ADD AX, BX          ; AX = AX + BX
ADD [SI], CL        ; Memory[SI] = Memory[SI] + CL
```

---

### ADC - Add with Carry
```assembly
ADC dest, source    ; dest = dest + source + CF
```
**Use:** Multi-precision arithmetic

**Example:**
```assembly
; Add 32-bit numbers
ADD AX, BX          ; Low word
ADC DX, CX          ; High word (with carry)
```

---

### SUB - Subtraction
```assembly
SUB dest, source    ; dest = dest - source
```
**Flags:** CF, ZF, SF, OF, AF, PF

**Examples:**
```assembly
SUB AL, 3           ; AL = AL - 3
SUB AX, BX          ; AX = AX - BX
```

---

### SBB - Subtract with Borrow
```assembly
SBB dest, source    ; dest = dest - source - CF
```

---

### INC - Increment
```assembly
INC dest            ; dest = dest + 1
```
**Note:** Does not affect CF

**Examples:**
```assembly
INC AL              ; AL = AL + 1
INC BX              ; BX = BX + 1
INC BYTE PTR [SI]   ; Memory[SI] = Memory[SI] + 1
```

---

### DEC - Decrement
```assembly
DEC dest            ; dest = dest - 1
```
**Examples:**
```assembly
DEC CX              ; CX = CX - 1
DEC WORD PTR [BX]   ; Memory[BX] = Memory[BX] - 1
```

---

### MUL - Unsigned Multiplication
```assembly
MUL source          ; AX = AL * source (8-bit)
                    ; DX:AX = AX * source (16-bit)
```
**Examples:**
```assembly
; 8-bit: AX = AL * source
MOV AL, 5
MOV BL, 3
MUL BL              ; AX = 15

; 16-bit: DX:AX = AX * source
MOV AX, 1000
MOV BX, 2000
MUL BX              ; DX:AX = 2,000,000
```

---

### IMUL - Signed Multiplication
```assembly
IMUL source         ; Same as MUL but signed
```

---

### DIV - Unsigned Division
```assembly
DIV source          ; AL = AX / source, AH = remainder (8-bit)
                    ; AX = DX:AX / source, DX = remainder (16-bit)
```
**Examples:**
```assembly
; 8-bit: AL = quotient, AH = remainder
MOV AX, 17
MOV BL, 5
DIV BL              ; AL = 3, AH = 2

; 16-bit: AX = quotient, DX = remainder
MOV DX, 0
MOV AX, 1000
MOV BX, 30
DIV BX              ; AX = 33, DX = 10
```

---

### IDIV - Signed Division
```assembly
IDIV source         ; Same as DIV but signed
```

---

### NEG - Negate (Two's Complement)
```assembly
NEG dest            ; dest = -dest
```
**Example:**
```assembly
MOV AL, 5
NEG AL              ; AL = -5 (FBh)
```

---

### CMP - Compare
```assembly
CMP op1, op2        ; Performs op1 - op2, sets flags
```
**Note:** Result is discarded, only flags are set

**Examples:**
```assembly
CMP AL, 5           ; Compare AL with 5
JE equal            ; Jump if AL == 5
JG greater          ; Jump if AL > 5
```

---

## 🔣 Logical Operations

### AND - Bitwise AND
```assembly
AND dest, source    ; dest = dest & source
```
**Use:** Masking bits

**Examples:**
```assembly
AND AL, 0Fh         ; Keep lower 4 bits
AND AX, AX          ; Test if AX is zero (sets ZF)
```

---

### OR - Bitwise OR
```assembly
OR dest, source     ; dest = dest | source
```
**Use:** Setting bits

**Examples:**
```assembly
OR AL, 80h          ; Set bit 7
OR AX, AX           ; Test if AX is zero
```

---

### XOR - Bitwise XOR
```assembly
XOR dest, source    ; dest = dest ^ source
```
**Use:** Toggling bits, clearing registers

**Examples:**
```assembly
XOR AL, AL          ; AL = 0 (fast clear)
XOR AL, 0FFh        ; Invert all bits
```

---

### NOT - Bitwise NOT
```assembly
NOT dest            ; dest = ~dest
```
**Example:**
```assembly
MOV AL, 10101010b
NOT AL              ; AL = 01010101b
```

---

### TEST - Logical Compare
```assembly
TEST op1, op2       ; Performs op1 & op2, sets flags
```
**Note:** Result is discarded

**Examples:**
```assembly
TEST AL, 01h        ; Test if bit 0 is set
JNZ bit_set         ; Jump if bit is set
```

---

## 🔄 Shift and Rotate

### SHL/SAL - Shift Left
```assembly
SHL dest, count     ; Shift left, fill with 0
```
**Examples:**
```assembly
SHL AL, 1           ; Multiply by 2
SHL BX, CL          ; Shift BX left CL times
```

---

### SHR - Shift Right (Logical)
```assembly
SHR dest, count     ; Shift right, fill with 0
```
**Examples:**
```assembly
SHR AL, 1           ; Divide by 2 (unsigned)
SHR AX, CL          ; Shift AX right CL times
```

---

### SAR - Shift Right (Arithmetic)
```assembly
SAR dest, count     ; Shift right, preserve sign bit
```
**Use:** Signed division by powers of 2

---

### ROL - Rotate Left
```assembly
ROL dest, count     ; Rotate left through carry
```

---

### ROR - Rotate Right
```assembly
ROR dest, count     ; Rotate right through carry
```

---

### RCL - Rotate Left through Carry
```assembly
RCL dest, count     ; Rotate left including CF
```

---

### RCR - Rotate Right through Carry
```assembly
RCR dest, count     ; Rotate right including CF
```

---

## 🔀 Control Flow

### JMP - Unconditional Jump
```assembly
JMP label           ; Jump to label
JMP SHORT label     ; Short jump (-128 to +127)
JMP FAR label       ; Far jump (different segment)
```

---

### Conditional Jumps

#### Unsigned Comparisons
```assembly
JE/JZ   label       ; Jump if Equal / Zero (ZF=1)
JNE/JNZ label       ; Jump if Not Equal / Not Zero (ZF=0)
JA/JNBE label       ; Jump if Above (CF=0 and ZF=0)
JAE/JNB label       ; Jump if Above or Equal (CF=0)
JB/JNAE label       ; Jump if Below (CF=1)
JBE/JNA label       ; Jump if Below or Equal (CF=1 or ZF=1)
```

#### Signed Comparisons
```assembly
JG/JNLE label       ; Jump if Greater (ZF=0 and SF=OF)
JGE/JNL label       ; Jump if Greater or Equal (SF=OF)
JL/JNGE label       ; Jump if Less (SF≠OF)
JLE/JNG label       ; Jump if Less or Equal (ZF=1 or SF≠OF)
```

#### Flag-Based Jumps
```assembly
JC  label           ; Jump if Carry (CF=1)
JNC label           ; Jump if No Carry (CF=0)
JS  label           ; Jump if Sign (SF=1)
JNS label           ; Jump if No Sign (SF=0)
JO  label           ; Jump if Overflow (OF=1)
JNO label           ; Jump if No Overflow (OF=0)
JP/JPE label        ; Jump if Parity Even (PF=1)
JNP/JPO label       ; Jump if Parity Odd (PF=0)
```

---

### LOOP - Loop Control
```assembly
LOOP label          ; CX = CX - 1, jump if CX ≠ 0
LOOPE/LOOPZ label   ; Loop while Equal/Zero
LOOPNE/LOOPNZ label ; Loop while Not Equal/Not Zero
```

**Example:**
```assembly
MOV CX, 10
loop_start:
    ; ... code ...
LOOP loop_start     ; Repeat 10 times
```

---

### CALL - Call Procedure
```assembly
CALL procedure      ; Push IP, jump to procedure
CALL FAR procedure  ; Push CS:IP, jump to procedure
```

---

### RET - Return from Procedure
```assembly
RET                 ; Pop IP
RET n               ; Pop IP, add n to SP
RETF                ; Pop IP and CS (far return)
```

---

## 📝 String Operations

**Direction:** Controlled by DF flag (CLD=increment, STD=decrement)

### MOVSB/MOVSW - Move String
```assembly
MOVSB               ; [ES:DI] = [DS:SI], adjust SI/DI
MOVSW               ; Move word
```
**With REP:**
```assembly
MOV CX, 100
REP MOVSB           ; Copy 100 bytes
```

---

### LODSB/LODSW - Load String
```assembly
LODSB               ; AL = [DS:SI], adjust SI
LODSW               ; AX = [DS:SI], adjust SI
```

---

### STOSB/STOSW - Store String
```assembly
STOSB               ; [ES:DI] = AL, adjust DI
STOSW               ; [ES:DI] = AX, adjust DI
```
**Example (Fill memory):**
```assembly
MOV AL, 0
MOV CX, 100
REP STOSB           ; Fill 100 bytes with 0
```

---

### CMPSB/CMPSW - Compare String
```assembly
CMPSB               ; Compare [DS:SI] with [ES:DI]
CMPSW               ; Compare words
```
**With REPE:**
```assembly
MOV CX, 100
REPE CMPSB          ; Compare while equal
```

---

### SCASB/SCASW - Scan String
```assembly
SCASB               ; Compare AL with [ES:DI]
SCASW               ; Compare AX with [ES:DI]
```
**Example (Find character):**
```assembly
MOV AL, 'A'
MOV CX, 100
REPNE SCASB         ; Scan until 'A' found
```

---

### REP Prefixes
```assembly
REP                 ; Repeat while CX ≠ 0
REPE/REPZ           ; Repeat while Equal/Zero
REPNE/REPNZ         ; Repeat while Not Equal/Not Zero
```

---

## 📚 Stack Operations

### PUSH - Push onto Stack
```assembly
PUSH source         ; SP = SP - 2, [SS:SP] = source
```
**Examples:**
```assembly
PUSH AX
PUSH BX
PUSH [SI]
```

---

### POP - Pop from Stack
```assembly
POP dest            ; dest = [SS:SP], SP = SP + 2
```
**Examples:**
```assembly
POP AX
POP BX
```

---

### PUSHF - Push Flags
```assembly
PUSHF               ; Push FLAGS register
```

---

### POPF - Pop Flags
```assembly
POPF                ; Pop FLAGS register
```

---

## 🔧 Miscellaneous

### NOP - No Operation
```assembly
NOP                 ; Do nothing (1 byte)
```

---

### CLC/STC - Clear/Set Carry
```assembly
CLC                 ; CF = 0
STC                 ; CF = 1
CMC                 ; CF = ~CF
```

---

### CLD/STD - Clear/Set Direction
```assembly
CLD                 ; DF = 0 (increment SI/DI)
STD                 ; DF = 1 (decrement SI/DI)
```

---

### CLI/STI - Clear/Set Interrupt
```assembly
CLI                 ; IF = 0 (disable interrupts)
STI                 ; IF = 1 (enable interrupts)
```

---

### INT - Software Interrupt
```assembly
INT n               ; Call interrupt n
```
**Examples:**
```assembly
INT 21H             ; DOS services
INT 10H             ; BIOS video services
```

---

### AAA/AAS - ASCII Adjust
```assembly
AAA                 ; ASCII Adjust After Addition
AAS                 ; ASCII Adjust After Subtraction
AAM                 ; ASCII Adjust After Multiplication
AAD                 ; ASCII Adjust Before Division
```

**Example:**
```assembly
MOV AL, '7'         ; AL = 37h
SUB AL, '0'         ; AL = 07h
MOV BL, '8'
SUB BL, '0'         ; BL = 08h
ADD AL, BL          ; AL = 0Fh
AAA                 ; AH = 01h, AL = 05h (15 in BCD)
```

---

### DAA/DAS - Decimal Adjust
```assembly
DAA                 ; Decimal Adjust After Addition
DAS                 ; Decimal Adjust After Subtraction
```

---

### CBW/CWD - Convert Byte/Word
```assembly
CBW                 ; Convert Byte to Word (AL → AX)
CWD                 ; Convert Word to Double (AX → DX:AX)
```

---

## 📊 Quick Reference Table

| Category | Instructions |
|----------|-------------|
| **Data** | MOV, LEA, XCHG, XLAT |
| **Arithmetic** | ADD, SUB, INC, DEC, MUL, DIV, NEG, CMP |
| **Logical** | AND, OR, XOR, NOT, TEST |
| **Shift** | SHL, SHR, SAR, ROL, ROR, RCL, RCR |
| **Jump** | JMP, JE, JNE, JG, JL, JA, JB, LOOP |
| **Call** | CALL, RET |
| **String** | MOVS, LODS, STOS, CMPS, SCAS |
| **Stack** | PUSH, POP, PUSHF, POPF |
| **Control** | INT, CLC, STC, CLD, STD, CLI, STI |

---

**Print this cheatsheet and keep it handy while coding! 🚀**
