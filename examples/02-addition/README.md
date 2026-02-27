# Example 2: Addition with User Input

## Overview
This program demonstrates interactive input/output in assembly language. It prompts the user for two single-digit numbers, adds them together, and displays the result.

## What You'll Learn
- User input handling with INT 21H
- ASCII to numeric conversion
- BCD (Binary Coded Decimal) arithmetic
- AAA (ASCII Adjust After Addition) instruction
- Multi-digit result handling
- SMALL memory model structure

## Code Explanation

### Memory Model
```assembly
.MODEL SMALL                ; 64KB code, 64KB data
.STACK 100H                 ; 256 bytes stack
```
The SMALL model is suitable for programs with less than 64KB of code and data.

### Data Segment
```assembly
.DATA
    MSG3  DB 10,13, 10,13, 'Enter first number: $'
    MSG4  DB 10,13, 'Enter second number: $'
    MSG8  DB 10,13, 10,13, '- Yunus Emre Vurgun 2022 | Result: $'
```
- `10` = Line Feed (LF)
- `13` = Carriage Return (CR)
- Together they create a new line

### Getting User Input
```assembly
MOV AH, 1                   ; Function 01h - Read character
INT 21H                     ; Read from keyboard
MOV BL, AL                  ; Store in BL
```
DOS function 01h reads a single character and stores it in AL register.

### ASCII Adjustment
```assembly
SUB BH, 48                  ; Convert ASCII to number
```
When you press '5' on the keyboard, DOS returns ASCII value 53 (decimal). Subtracting 48 gives us the actual number 5.

### The AAA Instruction
```assembly
ADD AL, BL                  ; Add the two numbers
MOV AH, 0                   ; Clear AH
AAA                         ; ASCII Adjust After Addition
```

**What AAA does:**
- Converts the binary sum to unpacked BCD format
- If the sum is > 9, it adjusts AH (tens) and AL (ones)
- Example: 7 + 8 = 15 → AH=1, AL=5

### Converting Back to ASCII
```assembly
MOV BX, AX                  ; Move result to BX
ADD BH, 48                  ; Convert tens to ASCII
ADD BL, 48                  ; Convert ones to ASCII
```
Adding 48 converts numbers back to ASCII for display.

## How to Run

### Using MASM/TASM
```bash
# Assemble
masm addition.asm;
# Link
link addition.obj;
# Run in DOSBox
dosbox addition.exe
```

### Using emu8086
1. Open `addition.asm`
2. Press F5 to compile
3. Click "Run"
4. Enter '1' when prompted for operation
5. Enter two single-digit numbers

## Sample Execution

```
1                           (User enters 1 for addition)

Enter first number: 7       (User enters 7)
Enter second number: 8      (User enters 8)

- Yunus Emre Vurgun 2022 | Result: 15
```

## Key Concepts

### DOS Functions Used
| Function | Purpose | Input | Output |
|----------|---------|-------|--------|
| AH=01h | Read character | None | AL = ASCII character |
| AH=02h | Display character | DL = character | Character displayed |
| AH=09h | Display string | DX = string offset | String displayed |
| AH=4Ch | Exit program | AL = return code | Program terminates |

### Registers Used
- **AX:** Accumulator for arithmetic operations
- **BX:** Stores result and intermediate values
- **CX:** Stores second input number
- **DX:** Pointer for string operations

### Important Instructions
- **AAA:** ASCII Adjust After Addition
- **LEA:** Load Effective Address
- **ADD:** Addition operation
- **CMP:** Compare values
- **JE:** Jump if Equal

## Limitations
- Only works with single-digit numbers (0-9)
- Result must be less than 100
- No error handling for invalid input

## Exercises
1. Modify to handle two-digit numbers
2. Add error checking for non-numeric input
3. Implement subtraction, multiplication, or division
4. Create a menu system for multiple operations

## Next Steps
- [Example 3: String Operations](../03-string-operations/)
- [Example 4: Control Flow](../04-control-flow/)

## Resources
- [AAA Instruction Details](../../docs/INSTRUCTION_CHEATSHEET.md#aaa)
- [DOS Interrupt Reference](../../docs/INTERRUPT_REFERENCE.md)
- [BCD Arithmetic Guide](../../docs/LEARNING_GUIDE.md#bcd-arithmetic)
