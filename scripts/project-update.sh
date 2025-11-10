#!/bin/bash

# =============================================================================
# Agent Doc Creator Project Update Script
# Updates Agent Doc Creator installation in a project
# =============================================================================

set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------

echo -e "${BLUE}=== Agent Doc Creator Project Update ===${NC}"
    echo ""

# Check if Agent Doc Creator is installed
if [ ! -d ".agent-doc-creator" ]; then
    print_warning "Agent Doc Creator is not installed in this project."
    echo "Run project-install.sh to install it first."
    exit 1
fi

print_status "Updating Agent Doc Creator..."
        echo ""
print_warning "This will reinstall Agent Doc Creator with current settings."
echo "Your custom configurations in docs.agent.config.json will be preserved."
        echo ""

read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Update cancelled."
        exit 0
    fi

# Run project install (which will update existing installation)
"$SCRIPT_DIR/project-install.sh" "$@"

print_success "Update complete!"
