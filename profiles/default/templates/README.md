# Documentation Templates

This directory contains templates used by Agent Doc Creator when generating documentation.

## Templates

- `architecture-overview.md` - System architecture overview template
- `component.md` - Component documentation template
- `adr.md` - Architecture Decision Record template
- `rfc-draft.md` - RFC draft template
- `runbook.md` - Operational runbook template
- `model-card.md` - ML model card template
- `config-reference.md` - Configuration reference template
- `pr-template.md` - Pull request description template

## Usage

These templates are used by the documentation generation agents. They provide structure and ensure consistency across all generated documentation.

## Customization

You can customize these templates by:
1. Creating a new profile: `scripts/create-profile.sh my-profile`
2. Editing the templates in `profiles/my-profile/templates/`
3. Using your profile: `scripts/project-install.sh --profile my-profile`



