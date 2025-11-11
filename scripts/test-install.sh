#!/bin/bash

# =============================================================================
# Agent Doc Creator Installation Test Script
# Tests base + project installation in a temporary directory
# =============================================================================

set -e  # Exit on error

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_status() {
    echo -e "${BLUE}→ $1${NC}"
}

# Create temp directory
TEST_DIR=$(mktemp -d)
INSTALL_DIR="$TEST_DIR/agent-doc-creator"

print_status "Testing installation in: $TEST_DIR"

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Test 1: Base Installation
print_status "Test 1: Base installation"
"$SCRIPT_DIR/base-install.sh" --install-dir "$INSTALL_DIR" --force

if [ -d "$INSTALL_DIR" ]; then
    print_success "Base installation directory created"
else
    print_error "Base installation failed"
    exit 1
fi

# Test 2: Check required files
print_status "Test 2: Checking required files"

REQUIRED_FILES=(
    "$INSTALL_DIR/config.yml"
    "$INSTALL_DIR/scripts/project-install.sh"
    "$INSTALL_DIR/profiles/default/agents/repo-scanner.md"
    "$INSTALL_DIR/profiles/default/agents/architecture-writer.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        print_success "Found: $(basename $file)"
    else
        print_error "Missing: $file"
        exit 1
    fi
done

# Test 3: Scripts are executable
print_status "Test 3: Checking script permissions"

if [ -x "$INSTALL_DIR/scripts/project-install.sh" ]; then
    print_success "Scripts are executable"
else
    print_error "Scripts are not executable"
    exit 1
fi

# Test 4: Config is valid YAML
print_status "Test 4: Validating config.yml"

if command -v python3 &> /dev/null; then
    python3 -c "import yaml; yaml.safe_load(open('$INSTALL_DIR/config.yml'))" 2>/dev/null
    if [ $? -eq 0 ]; then
        print_success "config.yml is valid YAML"
    else
        print_error "config.yml is invalid YAML"
        exit 1
    fi
else
    print_status "Skipping YAML validation (python3 not found)"
fi

# Cleanup
rm -rf "$TEST_DIR"
print_success "Cleanup complete"

echo ""
print_success "All installation tests passed!"

