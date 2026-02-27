# Example 1: Hello World

## Overview
This is the classic "Hello World" program written in x86 assembly language. It demonstrates the most basic form of output in DOS programming using interrupt 21H.

## What You'll Learn
- COM file format and `org 100h` directive
- DOS interrupt 21H for I/O operations
- String definition and termination
- Basic register usage (AH, DX)

## Code Explanation

### Program Structure
```assembly
org 100h                    ; COM file starts at offset 100h
```
The `org 100h` directive tells the assembler that this is a COM file, which loads at offset 100h in memory.

### Displaying the Message
```assembly
MOV DX, OFFSET msg          ; Load address of message
MOV AH, 9H                  ; Function 09h - Display String
INT 21H                     ; Call DOS interrupt
```

**Step by step:**
1. `MOV DX, OFFSET msg` - Loads the memory address of our message into the DX register
2. `MOV AH, 9H` - Sets AH to 9, which is the DOS function for "Display String"
3. `INT 21H` - Calls DOS interrupt 21H to execute the function

### String Definition
```assembly
msg DB "Hi there! This is an example of 8086 assembly code.$"
```
- `DB` = Define Byte (declares a string of bytes)
- `$` = String terminator required by DOS function 09h

## How to Run

### Using DOSBox
1. Start DOSBox
2. Mount the directory:
   ```
   mount c /path/to/examples/01-hello-world
   c:
   ```
3. Assemble and run:
   ```
   masm hello.asm
   link hello.obj
   hello.exe
   ```

### Using emu8086
1. Open `hello.asm` in emu8086
2. Press F5 to compile and emulate
3. Click "Run" to execute

### Using NASM
```bash
nasm -f bin hello.asm -o hello.com
dosbox hello.com
```

## Expected Output
```
Hi there! This is an example of 8086 assembly code. I'm Yunus E.V.
```

## Key Concepts

### DOS Interrupt 21H, Function 09H
- **Purpose:** Display a string to the screen
- **Input:** 
  - AH = 09h
  - DX = Offset of string (must end with '$')
- **Output:** String displayed to screen

### Registers Used
- **AH:** Holds the function number for INT 21H
- **DX:** Points to the string to be displayed

## Exercises
1. Modify the message to display your own text
2. Add multiple messages and display them sequentially
3. Try using different DOS functions (like 02h for single character output)

## Next Steps
After mastering this example, move on to:
- [Example 2: Addition with Input](../02-addition/) - Learn about user input and arithmetic

## Resources
- [DOS Interrupt Reference](../../docs/INTERRUPT_REFERENCE.md)
- [Register Guide](../../docs/REGISTER_GUIDE.md)
