# Agent Doc Creator

**FAANG-quality documentation generator for modern software projects.**

Agent Doc Creator automatically scans your repository and generates **concise, actionable, scannable** documentation. Built for developers who value quality over quantity.

**Key Differentiator**: Generates 200-line docs, not 2000-line docs. Every file is concise, every section is actionable.

## What It Does

Agent Doc Creator transforms your codebase into living documentation by:

✅ **Scanning your repository** to discover components, services, and dependencies

✅ **Generating architecture documentation** with Mermaid diagrams and component details

✅ **Creating ADRs** (Architecture Decision Records) from detected technical decisions

✅ **Drafting RFCs** for identified refactoring opportunities

✅ **Building runbooks** for operational procedures and troubleshooting

✅ **Documenting ML models** with model cards, datasets, and evaluation metrics

✅ **Maintaining references** for configuration files and environment variables

## Why Agent Doc Creator?

### 📏 Concise by Design
- **Target**: 150-300 lines per file
- **No bloat**: Every word earns its place
- **Scannable**: Tables, bullets, code examples
- **Actionable**: Copy-paste ready commands

### 🎯 FAANG-Quality Standards
- **Progressive disclosure**: Overview → details
- **No duplication**: Link instead of rewrite
- **Code examples**: Always included
- **Tables for comparisons**: Not walls of text

### 🔄 Git-Based Workflow
- All changes via pull requests
- Human review required
- Clear AI disclaimers
- Respects CODEOWNERS

### ✅ Built-in Validation
- Broken link detection
- Code syntax checking
- Duplicate content detection
- Length enforcement (no 1000-line docs!)

### 📊 Incremental Updates
- Only regenerate what changed
- Preserve human edits
- Track documentation freshness

## Documentation Types

- **Architecture Docs**: System overview, component diagrams, data flows, tech stack
- **ADRs**: Architecture Decision Records following standard format
- **RFCs**: Request for Comments drafts for major changes
- **Runbooks**: Operational procedures, deployment guides, troubleshooting
- **ML Documentation**: Model cards, dataset descriptions, evaluation metrics
- **References**: Configuration indexes, environment variables, API references

## Installation

### Base Installation

Install Agent Doc Creator to your system:

```bash
cd ~
curl -sSL https://raw.githubusercontent.com/yourusername/agent-doc-creator/main/scripts/base-install.sh | bash
```

This creates `~/agent-doc-creator/` with:
- Configuration files
- Documentation agents
- Workflow templates
- Standards and conventions

### Project Installation

Install into your project repository:

```bash
cd /path/to/your/project
~/agent-doc-creator/scripts/project-install.sh
```

This will:
1. Detect or bootstrap Docusaurus in your project
2. Install documentation generation agents
3. Set up Claude Code commands (if using Claude Code)
4. Configure Git workflow for documentation PRs

## Usage

### With Claude Code

Run commands directly in Claude Code:

- `generate-docs` - Full documentation generation
- `refresh-architecture` - Update architecture docs only
- `create-adr` - Generate a new ADR
- `draft-rfc` - Create an RFC draft
- `update-runbooks` - Refresh operational documentation
- `bootstrap-docusaurus` - Initialize Docusaurus if needed

### With Other AI Coding Tools

Use the workflow files in your project's `agent-doc-creator/workflows/` directory as prompts for your AI coding assistant.

## Configuration

Edit `config.yml` in your base installation to customize:

```yaml
version: 1.0.0
docs_root: docs
bootstrap_docusaurus: true
use_mdx: true
sections:
  - architecture
  - adrs
  - rfcs
  - playbooks
  - ml
  - references
create_pr: true
branch_prefix: ai/docs-architect
run_docusaurus_build_check: true
respect_human_edits: true
```

### Per-Project Configuration

Add `docs.agent.config.json` to your project root for project-specific settings.

## Roadmap

- **v1.0**: Single-repo docs generation ✓
- **v1.1**: Incremental updates (only regenerate changed docs) ✓
- **v1.2**: Doc validation (link checking, code example verification) ✓
- **v1.3**: Preserve human edits (don't overwrite manual improvements) ✓
- **v2.0**: Multi-repo support with cross-references (planned)
- **v2.1**: Metrics/observability dashboard (planned)
- **v2.2**: Integration with Jira, PagerDuty, Slack (planned)

## How It Works

1. **Scan**: The repo-scanner agent analyzes your codebase structure
2. **Generate**: Specialized agents create documentation for each section
3. **Validate**: The doc-validator checks links, code examples, and diagrams
4. **Preserve**: Human edits are detected and preserved during regeneration
5. **PR**: All changes are submitted as a pull request for review

## Requirements

- Git repository
- Node.js 18+ (for Docusaurus)
- Claude Code, Cursor, or similar AI coding tool
- Bash shell (for installation scripts)

## Documentation

Full documentation available in the [docs](docs/) directory:

- [Installation Guide](docs/installation.md)
- [Configuration Reference](docs/configuration.md)
- [Agent Specifications](docs/agents.md)
- [Workflow Guide](docs/workflows.md)
- [Customization](docs/customization.md)

## Contributing

Contributions welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Support

- GitHub Issues: Report bugs and request features
- Discussions: Ask questions and share ideas
- Documentation: Check the docs directory for guides

---

**Built for teams that value great documentation.**
