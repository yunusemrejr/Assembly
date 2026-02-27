# Makefile for x86 Assembly Examples
# Supports NASM assembler for modern development

# Assembler
ASM = nasm
ASMFLAGS = -f bin

# Directories
EXAMPLES_DIR = ../examples
BUILD_DIR = build

# Find all .asm files
SOURCES = $(shell find $(EXAMPLES_DIR) -name "*.asm")
TARGETS = $(patsubst %.asm,%.com,$(SOURCES))

# Colors for output
GREEN = \033[0;32m
YELLOW = \033[0;33m
NC = \033[0m # No Color

.PHONY: all clean help list

# Default target
all: help

# Help message
help:
	@echo "$(GREEN)x86 Assembly Build System$(NC)"
	@echo ""
	@echo "Available targets:"
	@echo "  $(YELLOW)make list$(NC)          - List all assembly files"
	@echo "  $(YELLOW)make build-all$(NC)     - Build all examples"
	@echo "  $(YELLOW)make build FILE=path$(NC) - Build specific file"
	@echo "  $(YELLOW)make clean$(NC)         - Remove all .com files"
	@echo "  $(YELLOW)make help$(NC)          - Show this help message"
	@echo ""
	@echo "Example usage:"
	@echo "  make build FILE=examples/01-hello-world/hello.asm"
	@echo ""

# List all assembly files
list:
	@echo "$(GREEN)Available assembly files:$(NC)"
	@find $(EXAMPLES_DIR) -name "*.asm" -type f | sort

# Build all examples
build-all: $(TARGETS)
	@echo "$(GREEN)All examples built successfully!$(NC)"

# Build specific file
build:
ifndef FILE
	@echo "$(YELLOW)Error: Please specify FILE=path/to/file.asm$(NC)"
	@exit 1
endif
	@echo "$(GREEN)Building $(FILE)...$(NC)"
	$(ASM) $(ASMFLAGS) $(FILE) -o $(FILE:.asm=.com)
	@echo "$(GREEN)Built: $(FILE:.asm=.com)$(NC)"

# Pattern rule for building .com files from .asm files
%.com: %.asm
	@echo "$(GREEN)Building $<...$(NC)"
	@$(ASM) $(ASMFLAGS) $< -o $@

# Clean build artifacts
clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@find $(EXAMPLES_DIR) -name "*.com" -type f -delete
	@find $(EXAMPLES_DIR) -name "*.lst" -type f -delete
	@find $(EXAMPLES_DIR) -name "*.obj" -type f -delete
	@echo "$(GREEN)Clean complete!$(NC)"

# Install NASM (Linux)
install-nasm-linux:
	@echo "$(GREEN)Installing NASM on Linux...$(NC)"
	sudo apt-get update
	sudo apt-get install -y nasm

# Install NASM (macOS)
install-nasm-mac:
	@echo "$(GREEN)Installing NASM on macOS...$(NC)"
	brew install nasm

# Check if NASM is installed
check-nasm:
	@which nasm > /dev/null || (echo "$(YELLOW)NASM not found. Install with 'make install-nasm-linux' or 'make install-nasm-mac'$(NC)" && exit 1)
	@echo "$(GREEN)NASM is installed: $$(nasm -v)$(NC)"
