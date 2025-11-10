#!/bin/bash

# =============================================================================
# Agent Doc Creator Project Installation Script
# Installs Agent Doc Creator into a project's codebase
# =============================================================================

set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(pwd)"

# Source common functions
source "$SCRIPT_DIR/common-functions.sh"

# -----------------------------------------------------------------------------
# Default Values
# -----------------------------------------------------------------------------

DRY_RUN="false"
VERBOSE="false"
PROFILE="default"
CLAUDE_CODE_COMMANDS="true"
USE_CLAUDE_CODE_SUBAGENTS="true"
AGENT_DOC_CREATOR_COMMANDS="false"

# -----------------------------------------------------------------------------
# Help Function
# -----------------------------------------------------------------------------

show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Install Agent Doc Creator into the current project directory.

Options:
    --profile PROFILE                        Use specified profile (default: default)
    --claude-code-commands [BOOL]            Install Claude Code commands (default: true)
    --use-claude-code-subagents [BOOL]       Use Claude Code subagents (default: true)
    --agent-doc-creator-commands [BOOL]      Install agent-doc-creator commands (default: false)
    --dry-run                                Show what would be done without doing it
    --verbose                                Show detailed output
    -h, --help                               Show this help message

Examples:
    $0
    $0 --profile custom
    $0 --claude-code-commands true --use-claude-code-subagents true
    $0 --dry-run

EOF
    exit 0
}

# -----------------------------------------------------------------------------
# Parse Command Line Arguments
# -----------------------------------------------------------------------------

    while [[ $# -gt 0 ]]; do
    case $1 in
            --profile)
                PROFILE="$2"
                shift 2
                ;;
            --claude-code-commands)
            CLAUDE_CODE_COMMANDS="$2"
            shift 2
                ;;
            --use-claude-code-subagents)
            USE_CLAUDE_CODE_SUBAGENTS="$2"
            shift 2
            ;;
        --agent-doc-creator-commands)
            AGENT_DOC_CREATOR_COMMANDS="$2"
            shift 2
                ;;
            --dry-run)
                DRY_RUN="true"
                shift
                ;;
            --verbose)
                VERBOSE="true"
                shift
                ;;
            -h|--help)
                show_help
                ;;
            *)
                print_error "Unknown option: $1"
            echo "Run with --help for usage information"
            exit 1
                ;;
        esac
    done

# -----------------------------------------------------------------------------
# Validate Environment
# -----------------------------------------------------------------------------

print_section "Agent Doc Creator Project Installation"

# Check if in a git repository
if [ ! -d ".git" ]; then
    print_warning "Not in a git repository. Agent Doc Creator works best with git."
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if profile exists
PROFILE_DIR="$BASE_DIR/profiles/$PROFILE"
if [ ! -d "$PROFILE_DIR" ]; then
    print_error "Profile '$PROFILE' not found at $PROFILE_DIR"
    exit 1
fi

print_status "Using profile: $PROFILE"
print_status "Project directory: $PROJECT_DIR"

if [ "$DRY_RUN" == "true" ]; then
    print_warning "DRY RUN MODE - No changes will be made"
fi

# -----------------------------------------------------------------------------
# Installation Functions
# -----------------------------------------------------------------------------

install_agents() {
    print_status "Installing documentation agents..."
    
    local target_dir="$PROJECT_DIR/.agent-doc-creator/agents"
    
    if [ "$DRY_RUN" == "true" ]; then
        print_status "[DRY RUN] Would create: $target_dir"
        return
    fi
    
    mkdir -p "$target_dir"
    cp -r "$PROFILE_DIR/agents"/* "$target_dir/"
    
    print_success "Agents installed"
}

install_workflows() {
    print_status "Installing workflows..."
    
    local target_dir="$PROJECT_DIR/.agent-doc-creator/workflows"
    
    if [ "$DRY_RUN" == "true" ]; then
        print_status "[DRY RUN] Would create: $target_dir"
        return
    fi

    mkdir -p "$target_dir"
    cp -r "$PROFILE_DIR/workflows"/* "$target_dir/"
    
    print_success "Workflows installed"
}

install_standards() {
    print_status "Installing documentation standards..."
    
    local target_dir="$PROJECT_DIR/.agent-doc-creator/standards"
    
    if [ "$DRY_RUN" == "true" ]; then
        print_status "[DRY RUN] Would create: $target_dir"
        return
    fi
    
    mkdir -p "$target_dir"
    cp -r "$PROFILE_DIR/standards"/* "$target_dir/"
    
    print_success "Standards installed"
}

install_claude_code_commands() {
    if [ "$CLAUDE_CODE_COMMANDS" != "true" ]; then
        return
    fi
    
    print_status "Installing Claude Code commands..."
    
    local target_dir="$PROJECT_DIR/.claude/commands/agent-doc-creator"
    
    if [ "$DRY_RUN" == "true" ]; then
        print_status "[DRY RUN] Would create: $target_dir"
        return
    fi
    
    mkdir -p "$target_dir"
    cp -r "$PROFILE_DIR/commands"/* "$target_dir/"
    
    print_success "Claude Code commands installed"
}

install_claude_code_agents() {
    if [ "$USE_CLAUDE_CODE_SUBAGENTS" != "true" ] || [ "$CLAUDE_CODE_COMMANDS" != "true" ]; then
        return
    fi
    
    print_status "Installing Claude Code subagents..."
    
    local target_dir="$PROJECT_DIR/.claude/agents/agent-doc-creator"
    
    if [ "$DRY_RUN" == "true" ]; then
        print_status "[DRY RUN] Would create: $target_dir"
        return
    fi
    
    mkdir -p "$target_dir"
    cp -r "$PROFILE_DIR/agents"/* "$target_dir/"
    
    print_success "Claude Code subagents installed"
}

install_commands() {
    if [ "$AGENT_DOC_CREATOR_COMMANDS" != "true" ]; then
        return
    fi
    
    print_status "Installing agent-doc-creator commands..."
    
    local target_dir="$PROJECT_DIR/agent-doc-creator/commands"
    
    if [ "$DRY_RUN" == "true" ]; then
        print_status "[DRY RUN] Would create: $target_dir"
        return
    fi
    
    mkdir -p "$target_dir"
    cp -r "$PROFILE_DIR/commands"/* "$target_dir/"
    
    print_success "Commands installed"
}

create_config_example() {
    print_status "Creating configuration example..."
    
    local config_file="$PROJECT_DIR/docs.agent.config.json"
    
    if [ -f "$config_file" ] && [ "$DRY_RUN" != "true" ]; then
        print_warning "Configuration file already exists: $config_file"
        return
    fi
    
    if [ "$DRY_RUN" == "true" ]; then
        print_status "[DRY RUN] Would create: $config_file"
        return
    fi
    
    cat > "$config_file" << 'EOF'
{
  "docs_root": "docs",
  "bootstrap_docusaurus": true,
  "use_mdx": true,
  "sections": [
    "architecture",
    "adrs",
    "rfcs",
    "playbooks",
    "ml",
    "references"
  ],
  "create_pr": true,
  "branch_prefix": "ai/docs-architect",
  "target_branch": "main",
  "run_docusaurus_build_check": true,
  "validate_links": true,
  "respect_human_edits": true,
  "incremental_updates": true
}
EOF
    
    print_success "Configuration example created"
}

# -----------------------------------------------------------------------------
# Main Installation
# -----------------------------------------------------------------------------

print_section "Installing Components"

install_agents
install_workflows
install_standards
install_claude_code_commands
install_claude_code_agents
install_commands
create_config_example

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------

print_section "Installation Complete!"

if [ "$DRY_RUN" == "true" ]; then
    print_warning "This was a DRY RUN. No changes were made."
    print_status "Run without --dry-run to perform actual installation."
else
    print_success "Agent Doc Creator has been installed to this project!"
    echo ""
    echo "What was installed:"
    echo "  • Documentation agents in .agent-doc-creator/agents/"
    echo "  • Workflows in .agent-doc-creator/workflows/"
    echo "  • Standards in .agent-doc-creator/standards/"
    
    if [ "$CLAUDE_CODE_COMMANDS" == "true" ]; then
        echo "  • Claude Code commands in .claude/commands/agent-doc-creator/"
    fi
    
    if [ "$USE_CLAUDE_CODE_SUBAGENTS" == "true" ]; then
        echo "  • Claude Code subagents in .claude/agents/agent-doc-creator/"
    fi
    
    if [ "$AGENT_DOC_CREATOR_COMMANDS" == "true" ]; then
        echo "  • Commands in agent-doc-creator/commands/"
    fi
    
    echo "  • Configuration example: docs.agent.config.json"
    echo ""
    echo "Next steps:"
    echo "  1. Review and customize docs.agent.config.json"
    echo "  2. Run 'generate-docs' command in Claude Code (or your AI tool)"
    echo "  3. Review the generated documentation PR"
    echo ""
    print_success "Ready to generate documentation!"
fi
