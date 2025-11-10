#!/bin/bash

# =============================================================================
# Agent Doc Creator Base Installation Script
# Installs Agent Doc Creator to your system
# =============================================================================

set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Default installation directory
INSTALL_DIR="$HOME/agent-doc-creator"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_status() {
    echo -e "${BLUE}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_section() {
    echo ""
    echo -e "${BLUE}=== $1 ===${NC}"
    echo ""
}

# -----------------------------------------------------------------------------
# Parse Arguments
# -----------------------------------------------------------------------------

FORCE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --install-dir)
            INSTALL_DIR="$2"
            shift 2
            ;;
        --force)
            FORCE=true
            shift
            ;;
        -h|--help)
            cat << EOF
Usage: $0 [OPTIONS]

Install Agent Doc Creator to your system.

Options:
    --install-dir DIR    Installation directory (default: ~/agent-doc-creator)
    --force              Force reinstall if already exists
    -h, --help           Show this help message

Examples:
    $0
    $0 --install-dir ~/tools/agent-doc-creator
    $0 --force

EOF
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run with --help for usage information"
            exit 1
            ;;
    esac
done

# -----------------------------------------------------------------------------
# Main Installation
# -----------------------------------------------------------------------------

print_section "Agent Doc Creator Base Installation"

# Check if already installed
if [ -d "$INSTALL_DIR" ] && [ "$FORCE" != "true" ]; then
    print_warning "Agent Doc Creator is already installed at $INSTALL_DIR"
    echo "Use --force to reinstall"
    exit 0
fi

# Create installation directory
print_status "Installing to: $INSTALL_DIR"

if [ -d "$INSTALL_DIR" ]; then
    print_status "Removing existing installation..."
    rm -rf "$INSTALL_DIR"
fi

mkdir -p "$INSTALL_DIR"

# Copy files
print_status "Copying files..."

cp -r "$REPO_DIR/profiles" "$INSTALL_DIR/"
cp -r "$REPO_DIR/scripts" "$INSTALL_DIR/"
cp "$REPO_DIR/config.yml" "$INSTALL_DIR/"
cp "$REPO_DIR/README.md" "$INSTALL_DIR/"
cp "$REPO_DIR/LICENSE" "$INSTALL_DIR/"

print_success "Files copied"

# Make scripts executable
print_status "Making scripts executable..."
chmod +x "$INSTALL_DIR/scripts"/*.sh
print_success "Scripts are executable"

# Create project installation command
PROJECT_INSTALL_CMD="$INSTALL_DIR/scripts/project-install.sh"

print_section "Installation Complete!"

echo "Agent Doc Creator has been installed to:"
echo "  $INSTALL_DIR"
echo ""
echo "To install into a project, run:"
echo "  $PROJECT_INSTALL_CMD"
echo ""
echo "Or create an alias for convenience:"
echo "  alias agent-doc-install='$PROJECT_INSTALL_CMD'"
                echo ""
print_success "Base installation successful!"
