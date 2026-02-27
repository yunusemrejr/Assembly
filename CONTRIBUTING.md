# Contributing to x86 Assembly Examples

Thank you for your interest in contributing! This document provides guidelines for contributing to this educational repository.

## 🎯 Ways to Contribute

### 1. Add New Examples
- Create well-documented assembly programs
- Focus on educational value
- Include detailed comments
- Add a README.md explaining the example

### 2. Improve Documentation
- Fix typos or unclear explanations
- Add more detailed comments to existing code
- Translate documentation to other languages
- Create tutorials or guides

### 3. Fix Bugs
- Report bugs in existing code
- Submit fixes with clear explanations
- Test your fixes in DOSBox or emu8086

### 4. Enhance Existing Examples
- Add better error handling
- Improve code efficiency
- Add more features
- Modernize assembly syntax

## 📋 Contribution Guidelines

### Code Standards

#### Assembly Code
- **Comments:** Add comprehensive comments explaining:
  - What the code does
  - Why specific instructions are used
  - Register usage
  - Memory layout
- **Formatting:** Use consistent indentation (4 spaces or 1 tab)
- **Labels:** Use descriptive label names
- **Structure:** Include header comments with metadata

#### Example Header Format
```assembly
;==============================================================================
; Program: [Program Name]
; Description: [Brief description]
; Author: [Your Name]
; Date: [Year]
; Assembler: [MASM/TASM/NASM/etc.]
; Platform: [DOS/DOSBox/etc.]
;==============================================================================
```

#### Documentation
- Use clear, beginner-friendly language
- Include code examples
- Add "What You'll Learn" sections
- Provide step-by-step explanations
- Include expected output

### File Organization

```
examples/
├── XX-example-name/
│   ├── program.asm          # Main assembly file
│   ├── README.md            # Detailed explanation
│   ├── demo.mp4             # Optional demo video
│   └── output.txt           # Expected output
```

### Naming Conventions
- **Directories:** Use lowercase with hyphens (e.g., `05-multiplication`)
- **Files:** Use lowercase with underscores (e.g., `string_length.asm`)
- **Labels:** Use UPPERCASE or PascalCase (e.g., `MAIN_LOOP` or `MainLoop`)
- **Variables:** Use lowercase with underscores (e.g., `user_input`)

## 🔄 Submission Process

### 1. Fork the Repository
```bash
git clone https://github.com/yunusemrejr/x86-assembly-examples.git
cd x86-assembly-examples
```

### 2. Create a Branch
```bash
git checkout -b feature/your-feature-name
```

### 3. Make Your Changes
- Write your code
- Add documentation
- Test thoroughly

### 4. Test Your Code
- Assemble with MASM/TASM/NASM
- Run in DOSBox or emu8086
- Verify output matches expectations
- Check for errors or warnings

### 5. Commit Your Changes
```bash
git add .
git commit -m "Add: Brief description of changes"
```

**Commit Message Format:**
- `Add:` for new features or examples
- `Fix:` for bug fixes
- `Docs:` for documentation changes
- `Refactor:` for code improvements
- `Test:` for test additions

### 6. Push and Create Pull Request
```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with:
- Clear title describing the change
- Detailed description of what was added/changed
- Screenshots or output examples (if applicable)
- Reference to any related issues

## ✅ Pull Request Checklist

Before submitting, ensure:
- [ ] Code assembles without errors
- [ ] Code runs correctly in DOSBox/emu8086
- [ ] All files include proper headers and comments
- [ ] README.md is included for new examples
- [ ] Code follows the style guidelines
- [ ] Documentation is clear and accurate
- [ ] No unnecessary files are included (build artifacts, etc.)

## 🐛 Reporting Bugs

When reporting bugs, include:
- **Description:** Clear description of the issue
- **Steps to Reproduce:** Detailed steps to recreate the bug
- **Expected Behavior:** What should happen
- **Actual Behavior:** What actually happens
- **Environment:** Assembler, OS, DOSBox version
- **Code Sample:** Minimal code that reproduces the issue

## 💡 Suggesting Enhancements

For feature requests or enhancements:
- Check if the feature already exists
- Explain the use case and benefits
- Provide examples if possible
- Be open to discussion and feedback

## 📚 Example Topics We're Looking For

- **Basic Operations:** More arithmetic examples
- **String Manipulation:** Reverse, compare, search
- **File I/O:** Reading and writing files
- **Graphics:** Simple VGA graphics
- **Sound:** PC speaker programming
- **Advanced:** Protected mode, interrupts, TSR programs
- **Games:** Simple text-based or graphics games
- **Utilities:** Practical tools and utilities

## 🤝 Code of Conduct

### Our Standards
- Be respectful and inclusive
- Welcome newcomers and beginners
- Provide constructive feedback
- Focus on education and learning
- Be patient with questions

### Unacceptable Behavior
- Harassment or discrimination
- Trolling or insulting comments
- Publishing others' private information
- Other unprofessional conduct

## 📞 Getting Help

If you need help:
- Open an issue with the `question` label
- Check existing documentation
- Review similar examples
- Ask in the discussions section

## 🙏 Recognition

Contributors will be:
- Listed in the project README
- Credited in their contributed files
- Acknowledged in release notes

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for helping make assembly language more accessible to learners worldwide! 🚀**
