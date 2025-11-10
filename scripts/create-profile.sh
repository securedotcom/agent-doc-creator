#!/bin/bash

# =============================================================================
# Agent Doc Creator Profile Creation Script
# Creates a new documentation profile
# =============================================================================

set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

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

print_error() {
    echo -e "${YELLOW}✗ $1${NC}"
}

# -----------------------------------------------------------------------------
# Parse Arguments
# -----------------------------------------------------------------------------

if [ $# -eq 0 ]; then
    echo "Usage: $0 <profile-name>"
    echo ""
    echo "Creates a new documentation profile by copying the default profile."
    echo ""
    echo "Example:"
    echo "  $0 my-custom-profile"
    exit 1
fi

PROFILE_NAME="$1"
PROFILE_DIR="$BASE_DIR/profiles/$PROFILE_NAME"

# Check if profile already exists
if [ -d "$PROFILE_DIR" ]; then
    print_error "Profile '$PROFILE_NAME' already exists at $PROFILE_DIR"
    exit 1
fi

# -----------------------------------------------------------------------------
# Create Profile
# -----------------------------------------------------------------------------

print_status "Creating profile: $PROFILE_NAME"

# Copy default profile
cp -r "$BASE_DIR/profiles/default" "$PROFILE_DIR"

print_success "Profile created at: $PROFILE_DIR"

echo ""
echo "Customize your profile by editing files in:"
echo "  • $PROFILE_DIR/agents/ - Documentation agents"
echo "  • $PROFILE_DIR/workflows/ - Documentation workflows"
echo "  • $PROFILE_DIR/standards/ - Documentation standards"
echo "  • $PROFILE_DIR/commands/ - Claude Code commands"
echo ""
echo "To use this profile:"
echo "  $SCRIPT_DIR/project-install.sh --profile $PROFILE_NAME"
