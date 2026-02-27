#!/bin/bash

# Build script for x86 assembly examples
# Supports multiple assemblers: NASM, MASM, TASM

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Function to detect available assembler
detect_assembler() {
    if command -v nasm &> /dev/null; then
        echo "nasm"
    elif command -v masm &> /dev/null; then
        echo "masm"
    elif command -v tasm &> /dev/null; then
        echo "tasm"
    else
        echo "none"
    fi
}

# Function to build with NASM
build_nasm() {
    local file=$1
    local output="${file%.asm}.com"
    
    print_warning "Building with NASM: $file"
    nasm -f bin "$file" -o "$output"
    
    if [ $? -eq 0 ]; then
        print_success "Built: $output"
        return 0
    else
        print_error "Build failed: $file"
        return 1
    fi
}

# Function to build with MASM
build_masm() {
    local file=$1
    local basename="${file%.asm}"
    
    print_warning "Building with MASM: $file"
    masm "$file"
    link "${basename}.obj"
    
    if [ $? -eq 0 ]; then
        print_success "Built: ${basename}.exe"
        return 0
    else
        print_error "Build failed: $file"
        return 1
    fi
}

# Function to build with TASM
build_tasm() {
    local file=$1
    local basename="${file%.asm}"
    
    print_warning "Building with TASM: $file"
    tasm "$file"
    tlink "${basename}.obj"
    
    if [ $? -eq 0 ]; then
        print_success "Built: ${basename}.exe"
        return 0
    else
        print_error "Build failed: $file"
        return 1
    fi
}

# Main build function
build_file() {
    local file=$1
    local assembler=$(detect_assembler)
    
    if [ ! -f "$file" ]; then
        print_error "File not found: $file"
        return 1
    fi
    
    case $assembler in
        nasm)
            build_nasm "$file"
            ;;
        masm)
            build_masm "$file"
            ;;
        tasm)
            build_tasm "$file"
            ;;
        none)
            print_error "No assembler found. Please install NASM, MASM, or TASM."
            echo ""
            echo "To install NASM:"
            echo "  Linux: sudo apt-get install nasm"
            echo "  macOS: brew install nasm"
            echo "  Windows: Download from https://www.nasm.us/"
            return 1
            ;;
    esac
}

# Build all files in a directory
build_all() {
    local dir=${1:-.}
    local count=0
    local success=0
    
    print_warning "Building all .asm files in: $dir"
    echo ""
    
    while IFS= read -r -d '' file; do
        ((count++))
        if build_file "$file"; then
            ((success++))
        fi
        echo ""
    done < <(find "$dir" -name "*.asm" -type f -print0)
    
    echo ""
    print_success "Build complete: $success/$count files built successfully"
}

# Show help
show_help() {
    echo "x86 Assembly Build Script"
    echo ""
    echo "Usage:"
    echo "  $0 <file.asm>           Build a specific file"
    echo "  $0 --all [directory]    Build all .asm files in directory"
    echo "  $0 --help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 examples/01-hello-world/hello.asm"
    echo "  $0 --all examples/"
    echo ""
    echo "Supported assemblers: NASM, MASM, TASM"
    echo "Current assembler: $(detect_assembler)"
}

# Main script logic
main() {
    if [ $# -eq 0 ]; then
        show_help
        exit 0
    fi
    
    case $1 in
        --help|-h)
            show_help
            ;;
        --all|-a)
            build_all "${2:-.}"
            ;;
        *)
            build_file "$1"
            ;;
    esac
}

main "$@"
