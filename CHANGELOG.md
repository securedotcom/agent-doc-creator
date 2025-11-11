# Changelog

All notable changes to Agent Doc Creator will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-11-07

### Added

#### Core Features
- **Automatic Documentation Generation**: Scan repositories and generate comprehensive Docusaurus-based documentation
- **Multiple Documentation Types**: Support for architecture docs, ADRs, RFCs, runbooks, ML documentation, and configuration references
- **Git-Based Workflow**: All documentation changes submitted as pull requests for human review
- **AI Transparency**: Clear disclaimers on all AI-generated content

#### Priority 1 Features (Must Have)
- **Incremental Updates**: Only regenerate documentation for components that have changed
- **Change Detection**: Track file hashes and dependencies in `.docs-metadata.json`
- **Doc Validation**: Automated checking of links, code examples, and Mermaid diagrams
- **Human Edit Preservation**: Detect and preserve manually edited sections during regeneration
- **Edit Tracking**: Store human-edited sections in `.human-edits.json`
- **Protected Content Markers**: HTML comment markers to protect human content from regeneration

#### Priority 2 Features (Should Have)
- **Multi-Repo Support**: Generate cross-repository architecture views and dependency graphs
- **Metrics Dashboard**: Track documentation coverage, staleness, and quality scores
- **External Integrations**: Support for Jira (ADR/RFC linking), PagerDuty (runbook metadata), and Slack/Teams (PR notifications)

#### Agents
- `repo-scanner.md` - Analyzes codebase to discover components and dependencies
- `architecture-writer.md` - Generates architecture overview with Mermaid diagrams
- `adr-generator.md` - Creates Architecture Decision Records from detected decisions
- `rfc-drafter.md` - Drafts RFC documents for refactoring opportunities
- `runbook-creator.md` - Generates operational runbooks and troubleshooting guides
- `ml-doc-generator.md` - Creates ML/AI model documentation with model cards
- `reference-builder.md` - Builds configuration and environment variable references
- `docusaurus-manager.md` - Manages Docusaurus config and sidebars
- `doc-validator.md` - Validates links, code examples, and diagrams
- `human-edit-detector.md` - Identifies and preserves manual edits
- `cross-repo-analyzer.md` - Analyzes dependencies across multiple repositories

#### Workflows
- `scan-repository.md` - Repository scanning and analysis workflow
- `bootstrap-docusaurus.md` - Initialize Docusaurus in projects
- `generate-architecture-docs.md` - Architecture documentation generation
- `generate-adrs.md` - ADR creation workflow
- `generate-rfcs.md` - RFC drafting workflow
- `generate-runbooks.md` - Runbook generation workflow
- `generate-ml-docs.md` - ML documentation workflow
- `update-sidebars.md` - Sidebar management workflow
- `create-docs-pr.md` - Pull request creation workflow
- `validate-docs.md` - Documentation validation workflow
- `detect-changes.md` - Incremental update change detection

#### Standards
- `doc-style.md` - Documentation writing style guide
- `mermaid-diagrams.md` - Standards for Mermaid diagram creation
- `adr-format.md` - ADR template and formatting conventions
- `rfc-format.md` - RFC template and formatting conventions
- `ai-disclaimer.md` - Required disclaimer for AI-generated content
- `frontmatter-standards.md` - Frontmatter conventions for documentation

#### Templates
- `architecture-overview.md` - Architecture overview template
- `component.md` - Component documentation template
- `adr.md` - ADR template following standard format
- `rfc-draft.md` - RFC template with AI disclaimer
- `runbook.md` - Runbook template with operational procedures
- `model-card.md` - ML model card template
- `config-reference.md` - Configuration documentation template
- `pr-template.md` - Pull request description template

#### Commands (Claude Code)
- `generate-docs` - Run full documentation generation
- `refresh-architecture` - Update architecture docs only
- `create-adr` - Generate a new ADR
- `draft-rfc` - Create an RFC draft
- `update-runbooks` - Refresh operational documentation
- `bootstrap-docusaurus` - Initialize Docusaurus setup

#### Installation Scripts
- `base-install.sh` - Install Agent Doc Creator to user's system
- `project-install.sh` - Install into target project repository
- `common-functions.sh` - Shared utilities for scripts
- `create-profile.sh` - Create custom documentation profiles

#### Configuration
- `config.yml` - Base configuration with all documentation settings
- `docs.agent.config.json` - Example per-project agent configuration

### Changed
- N/A (Initial release)

### Deprecated
- N/A (Initial release)

### Removed
- N/A (Initial release)

### Fixed
- N/A (Initial release)

### Security
- **Secret Redaction**: Automatically redact potential secrets from configuration references
- **No Direct Commits**: All changes go through PR review process

---

## Future Releases

### [2.0.0] - Planned
- Enhanced multi-repo support with workspace management
- Real-time documentation metrics dashboard
- Advanced integration APIs for enterprise tools

### [2.1.0] - Planned
- Machine learning for documentation quality scoring
- Automated documentation drift detection
- Smart suggestions for missing documentation

---

[1.0.0]: https://github.com/securedotcom/agent-doc-creator/releases/tag/v1.0.0
