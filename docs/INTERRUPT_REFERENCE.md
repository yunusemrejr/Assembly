# DOS Interrupt Reference

Complete reference for DOS interrupts commonly used in x86 assembly programming.

## 📋 Table of Contents
- [INT 21H - DOS Services](#int-21h---dos-services)
- [INT 10H - Video Services](#int-10h---video-services)
- [INT 16H - Keyboard Services](#int-16h---keyboard-services)
- [INT 13H - Disk Services](#int-13h---disk-services)
- [Common Usage Examples](#common-usage-examples)

## INT 21H - DOS Services

The primary interrupt for DOS system calls.

### Character I/O Functions

#### AH = 01h - Read Character with Echo
**Description:** Reads a character from keyboard and displays it.

**Input:**
- AH = 01h

**Output:**
- AL = ASCII character read

**Example:**
```assembly
MOV AH, 01h
INT 21H
; AL now contains the character
```

**Notes:**
- Waits for user input
- Echoes character to screen
- Ctrl+C terminates program

---

#### AH = 02h - Display Character
**Description:** Displays a single character to the screen.

**Input:**
- AH = 02h
- DL = ASCII character to display

**Output:**
- None

**Example:**
```assembly
MOV DL, 'A'
MOV AH, 02h
INT 21H
; Displays 'A'
```

**Special Characters:**
- 07h = Bell (beep)
- 08h = Backspace
- 09h = Tab
- 0Ah = Line Feed
- 0Dh = Carriage Return

---

#### AH = 06h - Direct Console I/O
**Description:** Direct character I/O without echo or special key handling.

**Input:**
- AH = 06h
- DL = Character to output (or FFh for input)

**Output:**
- If DL = FFh: ZF = 1 if no character, AL = character if available

**Example (Output):**
```assembly
MOV DL, 'X'
MOV AH, 06h
INT 21H
```

**Example (Input):**
```assembly
MOV DL, 0FFh
MOV AH, 06h
INT 21H
JZ no_key
; AL contains character
no_key:
```

---

#### AH = 08h - Read Character without Echo
**Description:** Reads character without displaying it.

**Input:**
- AH = 08h

**Output:**
- AL = ASCII character

**Example:**
```assembly
MOV AH, 08h
INT 21H
; AL contains character (not displayed)
```

**Use Cases:**
- Password input
- Game controls
- Menu selection

---

#### AH = 09h - Display String
**Description:** Displays a string terminated with '$'.

**Input:**
- AH = 09h
- DX = Offset of string

**Output:**
- None

**Example:**
```assembly
.DATA
    msg DB "Hello, World!$"
.CODE
    LEA DX, msg
    MOV AH, 09h
    INT 21H
```

**Important:**
- String MUST end with '$' character
- '$' is not displayed
- Use LEA or MOV DX, OFFSET to load address

---

#### AH = 0Ah - Buffered Input
**Description:** Reads a string of characters into a buffer.

**Input:**
- AH = 0Ah
- DX = Offset of input buffer

**Buffer Structure:**
```assembly
buffer DB 20        ; Maximum length
       DB ?         ; Actual length (filled by DOS)
       DB 20 DUP(?) ; Input characters
```

**Example:**
```assembly
.DATA
    input_buf DB 50
              DB ?
              DB 50 DUP(?)
.CODE
    LEA DX, input_buf
    MOV AH, 0Ah
    INT 21H
```

---

### File Operations

#### AH = 3Ch - Create File
**Description:** Creates a new file or truncates existing file.

**Input:**
- AH = 3Ch
- CX = File attributes
- DX = Offset of filename (ASCIIZ string)

**Output:**
- CF = 0 if successful, AX = file handle
- CF = 1 if error, AX = error code

**Example:**
```assembly
.DATA
    filename DB "output.txt", 0
.CODE
    LEA DX, filename
    MOV CX, 0        ; Normal file
    MOV AH, 3Ch
    INT 21H
    JC error
    MOV [handle], AX
```

---

#### AH = 3Dh - Open File
**Description:** Opens an existing file.

**Input:**
- AH = 3Dh
- AL = Access mode (0=read, 1=write, 2=read/write)
- DX = Offset of filename

**Output:**
- CF = 0 if successful, AX = file handle
- CF = 1 if error

**Example:**
```assembly
LEA DX, filename
MOV AL, 0        ; Read-only
MOV AH, 3Dh
INT 21H
```

---

#### AH = 3Eh - Close File
**Description:** Closes an open file.

**Input:**
- AH = 3Eh
- BX = File handle

**Output:**
- CF = 0 if successful
- CF = 1 if error

**Example:**
```assembly
MOV BX, [handle]
MOV AH, 3Eh
INT 21H
```

---

#### AH = 3Fh - Read from File
**Description:** Reads data from a file.

**Input:**
- AH = 3Fh
- BX = File handle
- CX = Number of bytes to read
- DX = Offset of buffer

**Output:**
- CF = 0 if successful, AX = bytes read
- CF = 1 if error

**Example:**
```assembly
MOV BX, [handle]
MOV CX, 100
LEA DX, buffer
MOV AH, 3Fh
INT 21H
```

---

#### AH = 40h - Write to File
**Description:** Writes data to a file.

**Input:**
- AH = 40h
- BX = File handle (1=stdout, 2=stderr)
- CX = Number of bytes to write
- DX = Offset of data

**Output:**
- CF = 0 if successful, AX = bytes written
- CF = 1 if error

**Example:**
```assembly
MOV BX, [handle]
MOV CX, 13
LEA DX, data
MOV AH, 40h
INT 21H
```

---

### Program Control

#### AH = 4Ch - Terminate Program
**Description:** Exits program and returns to DOS.

**Input:**
- AH = 4Ch
- AL = Return code (0 = success)

**Output:**
- Program terminates

**Example:**
```assembly
MOV AL, 0        ; Return code 0
MOV AH, 4Ch
INT 21H
```

---

### Date and Time

#### AH = 2Ah - Get System Date
**Description:** Gets current system date.

**Input:**
- AH = 2Ah

**Output:**
- CX = Year (1980-2099)
- DH = Month (1-12)
- DL = Day (1-31)
- AL = Day of week (0=Sunday)

**Example:**
```assembly
MOV AH, 2Ah
INT 21H
; CX = year, DH = month, DL = day
```

---

#### AH = 2Ch - Get System Time
**Description:** Gets current system time.

**Input:**
- AH = 2Ch

**Output:**
- CH = Hour (0-23)
- CL = Minutes (0-59)
- DH = Seconds (0-59)
- DL = Hundredths (0-99)

**Example:**
```assembly
MOV AH, 2Ch
INT 21H
; CH = hour, CL = minutes
```

---

## INT 10H - Video Services

BIOS video services for screen control.

### AH = 00h - Set Video Mode
**Input:**
- AH = 00h
- AL = Video mode

**Common Modes:**
- 00h = 40x25 text, B&W
- 03h = 80x25 text, color
- 13h = 320x200 graphics, 256 colors

**Example:**
```assembly
MOV AL, 03h      ; 80x25 color text
MOV AH, 00h
INT 10H
```

---

### AH = 02h - Set Cursor Position
**Input:**
- AH = 02h
- BH = Page number (usually 0)
- DH = Row (0-24)
- DL = Column (0-79)

**Example:**
```assembly
MOV DH, 10       ; Row 10
MOV DL, 20       ; Column 20
MOV BH, 0        ; Page 0
MOV AH, 02h
INT 10H
```

---

### AH = 03h - Get Cursor Position
**Input:**
- AH = 03h
- BH = Page number

**Output:**
- DH = Row
- DL = Column
- CH = Cursor start line
- CL = Cursor end line

---

### AH = 06h - Scroll Window Up
**Input:**
- AH = 06h
- AL = Lines to scroll (0 = clear window)
- BH = Attribute for blank lines
- CH, CL = Upper left corner (row, col)
- DH, DL = Lower right corner (row, col)

**Example (Clear Screen):**
```assembly
MOV AH, 06h
MOV AL, 0        ; Clear entire window
MOV BH, 07h      ; White on black
MOV CX, 0        ; Upper left (0,0)
MOV DH, 24       ; Lower right row
MOV DL, 79       ; Lower right column
INT 10H
```

---

### AH = 0Eh - Teletype Output
**Input:**
- AH = 0Eh
- AL = Character to display
- BH = Page number
- BL = Foreground color (graphics mode)

**Example:**
```assembly
MOV AL, 'A'
MOV AH, 0Eh
INT 10H
```

---

## INT 16H - Keyboard Services

### AH = 00h - Read Keystroke
**Input:**
- AH = 00h

**Output:**
- AH = Scan code
- AL = ASCII character

**Example:**
```assembly
MOV AH, 00h
INT 16H
; AL = character, AH = scan code
```

---

### AH = 01h - Check for Keystroke
**Input:**
- AH = 01h

**Output:**
- ZF = 1 if no key available
- ZF = 0 if key available (AH = scan code, AL = ASCII)

**Example:**
```assembly
MOV AH, 01h
INT 16H
JZ no_key
; Key is available
no_key:
```

---

## Common Usage Examples

### Example 1: Display String with Newline
```assembly
.DATA
    msg DB "Hello, World!", 10, 13, "$"
.CODE
    LEA DX, msg
    MOV AH, 09h
    INT 21H
```

### Example 2: Read and Echo Character
```assembly
MOV AH, 01h      ; Read with echo
INT 21H
; AL contains character
```

### Example 3: Clear Screen
```assembly
MOV AH, 06h      ; Scroll up
MOV AL, 0        ; Clear entire screen
MOV BH, 07h      ; White on black
MOV CX, 0        ; Upper left
MOV DH, 24       ; Lower right row
MOV DL, 79       ; Lower right col
INT 10H

; Reset cursor to top
MOV DH, 0
MOV DL, 0
MOV BH, 0
MOV AH, 02h
INT 10H
```

### Example 4: Read String
```assembly
.DATA
    buffer DB 50
           DB ?
           DB 50 DUP(?)
.CODE
    LEA DX, buffer
    MOV AH, 0Ah
    INT 21H
```

---

## Error Codes

Common error codes returned in AX when CF = 1:

| Code | Description |
|------|-------------|
| 01h  | Invalid function |
| 02h  | File not found |
| 03h  | Path not found |
| 04h  | Too many open files |
| 05h  | Access denied |
| 06h  | Invalid handle |

---

**For more details, consult the official DOS and BIOS interrupt documentation.**
