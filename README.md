# x86 Assembly Language Examples 🖥️

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Assembly](https://img.shields.io/badge/Language-x86%20Assembly-blue.svg)](https://en.wikipedia.org/wiki/X86_assembly_language)
[![Platform](https://img.shields.io/badge/Platform-DOS%20%7C%20DOSBox-green.svg)](https://www.dosbox.com/)

A comprehensive collection of x86 assembly language examples for learning and education. This repository contains well-documented code samples ranging from basic I/O operations to more complex arithmetic and string manipulation.

## 📚 Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Examples](#examples)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Learning Resources](#learning-resources)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

This repository is designed to help beginners and intermediate programmers learn x86 assembly language through practical, hands-on examples. Each example is thoroughly commented and includes explanations of:

- Register usage and manipulation
- DOS interrupts (INT 21H)
- Memory addressing modes
- Arithmetic operations
- Input/Output operations
- Control flow structures

## 🚀 Getting Started

### Prerequisites

To run these assembly programs, you'll need:

- **DOSBox** - DOS emulator for running 16-bit programs
  - Download: [https://www.dosbox.com/](https://www.dosbox.com/)
- **Assembler** - One of the following:
  - **MASM** (Microsoft Macro Assembler)
  - **TASM** (Turbo Assembler)
  - **NASM** (Netwide Assembler)
  - **emu8086** - Beginner-friendly emulator with built-in assembler

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yunusemrejr/x86-assembly-examples.git
   cd x86-assembly-examples
   ```

2. **Install DOSBox:**
   - **Linux:** `sudo apt-get install dosbox`
   - **macOS:** `brew install dosbox`
   - **Windows:** Download from [dosbox.com](https://www.dosbox.com/)

3. **Install an assembler:**
   - For beginners, we recommend **emu8086** (Windows)
   - For advanced users, install NASM: `sudo apt-get install nasm`

## 📖 Examples

### Example 1: Hello World
**Location:** `examples/01-hello-world/`

A simple program that displays a message to the screen using DOS interrupt 21H.

```assembly
org 100h
MOV DX, OFFSET msg
MOV AH, 9H
INT 21H    
ret
msg DB "Hello, Assembly World!$"
```

**Key Concepts:**
- `org 100h` - COM file format origin
- `INT 21H` - DOS interrupt for I/O operations
- `AH=9H` - Display string function
- `$` - String terminator

### Example 2: Addition with User Input
**Location:** `examples/02-addition/`

An interactive program that takes two single-digit numbers as input and displays their sum.

**Key Concepts:**
- User input handling
- ASCII to numeric conversion
- BCD arithmetic (AAA instruction)
- Multi-digit result handling

### Example 3: String Manipulation
**Location:** `examples/03-string-operations/`

Demonstrates string operations including length calculation, reversal, and comparison.

### Example 4: Loops and Conditionals
**Location:** `examples/04-control-flow/`

Shows how to implement loops, conditional jumps, and decision-making structures.

## 🛠️ Usage

### Using DOSBox

1. **Start DOSBox:**
   ```bash
   dosbox
   ```

2. **Mount your directory:**
   ```
   mount c ~/path/to/x86-assembly-examples
   c:
   ```

3. **Assemble and run:**
   ```
   cd examples\01-hello-world
   masm hello.asm
   link hello.obj
   hello.exe
   ```

### Using emu8086

1. Open emu8086
2. Load the `.asm` file
3. Click "Emulate" or press F5
4. Click "Run" to execute

### Using NASM (Modern Approach)

```bash
# Assemble
nasm -f bin program.asm -o program.com

# Run in DOSBox
dosbox program.com
```

## 📁 Project Structure

```
x86-assembly-examples/
├── examples/
│   ├── 01-hello-world/
│   │   ├── hello.asm
│   │   ├── README.md
│   │   └── demo.mp4
│   ├── 02-addition/
│   │   ├── addition.asm
│   │   ├── README.md
│   │   └── demo.mp4
│   ├── 03-string-operations/
│   ├── 04-control-flow/
│   ├── 05-multiplication/
│   └── 06-file-operations/
├── docs/
│   ├── LEARNING_GUIDE.md
│   ├── INTERRUPT_REFERENCE.md
│   ├── REGISTER_GUIDE.md
│   └── INSTRUCTION_CHEATSHEET.md
├── tools/
│   ├── build.sh
│   ├── Makefile
│   └── dosbox.conf
├── .vscode/
│   └── settings.json
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## 📚 Learning Resources

### Documentation in This Repository
- [Learning Guide](docs/LEARNING_GUIDE.md) - Step-by-step tutorial for beginners
- [Interrupt Reference](docs/INTERRUPT_REFERENCE.md) - DOS interrupt documentation
- [Register Guide](docs/REGISTER_GUIDE.md) - x86 register reference
- [Instruction Cheatsheet](docs/INSTRUCTION_CHEATSHEET.md) - Quick reference

### External Resources
- [x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)
- [Art of Assembly Language](http://www.plantation-productions.com/Webster/)
- [Intel x86 Documentation](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- [OSDev Wiki](https://wiki.osdev.org/Main_Page)

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### Ways to Contribute
- Add new examples
- Improve documentation
- Fix bugs or typos
- Translate documentation
- Share learning resources

## 👨‍💻 Author

**Yunus Emre Vurgun**
- GitHub: [@yunusemrejr](https://github.com/yunusemrejr)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Thanks to the assembly language community
- Inspired by classic DOS programming
- Built for educational purposes

## 📞 Support

If you have questions or need help:
- Open an [issue](https://github.com/yunusemrejr/x86-assembly-examples/issues)
- Check the [Learning Guide](docs/LEARNING_GUIDE.md)
- Review existing examples

---

**Happy Coding! 🚀**

*Learn assembly, understand computers at the lowest level.*
