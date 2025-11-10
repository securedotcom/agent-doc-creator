---
name: quality-guidelines
description: Quality guidelines for generating FAANG-level documentation
---

# Documentation Quality Guidelines

These guidelines ensure Agent Doc Creator generates concise, actionable, FAANG-quality documentation.

## Core Principles

### 1. Conciseness Over Comprehensiveness
- **Target**: 150-300 lines per file
- **Maximum**: 300 lines (hard limit)
- **Minimum**: 100 lines (ensure substance)

**Why**: Developers scan, they don't read. Respect their time.

### 2. Actionable Content
Every document must answer: **"What can I do with this information?"**

**Good**:
```markdown
## Deployment

\`\`\`bash
# Release new version
git tag v1.2.3
git push origin v1.2.3
\`\`\`
```

**Bad**:
```markdown
## Deployment
The deployment process involves creating tags and pushing them to the remote repository.
```

### 3. Scannable Structure
Use:
- **Clear headings** (H2, H3 max)
- **Bullet points** for lists
- **Tables** for comparisons
- **Code blocks** for examples
- **Callouts** for important notes

### 4. No Duplication
- Link to existing docs instead of rewriting
- Single source of truth per topic
- If it's in README, don't repeat it

## File Length Targets

| Doc Type | Target Lines | Max Lines | Rationale |
|----------|--------------|-----------|-----------|
| Architecture Overview | 200-250 | 300 | High-level only, link to components |
| ADR | 150-200 | 250 | Decision + context, not implementation |
| RFC | 150-200 | 250 | Proposal + impact, not full spec |
| Runbook | 200-250 | 300 | Practical procedures only |
| Config Reference | 250-300 | 300 | Tables + examples, minimal prose |
| Component Doc | 100-150 | 200 | Brief description + links |

## Content Structure

### Every Doc Must Have:

1. **Frontmatter** with metadata
2. **AI Disclaimer** (if AI-generated)
3. **Purpose** (1-2 sentences)
4. **Content** (structured, scannable)
5. **References** (links to code, related docs)

### Optional Sections:

- **TL;DR** (for docs >200 lines)
- **Quick Start** (for how-to guides)
- **Troubleshooting** (for runbooks)
- **Examples** (always good!)

## Writing Style

### Do:
- ✅ Use active voice ("Deploy the app" not "The app should be deployed")
- ✅ Use present tense ("The system processes" not "The system will process")
- ✅ Use simple words ("use" not "utilize", "help" not "facilitate")
- ✅ Use code examples liberally
- ✅ Use tables for comparisons
- ✅ Use callouts for warnings/tips

### Don't:
- ❌ Use passive voice
- ❌ Use jargon without explanation
- ❌ Write walls of text (break into sections)
- ❌ Duplicate content from other docs
- ❌ Include implementation details in overview docs

## Code Examples

### Requirements:
- Must be **copy-paste ready**
- Must include **comments** for clarity
- Must show **before/after** for fixes
- Must be **syntax-highlighted**

### Example:

```markdown
## Fix SQL Injection

\`\`\`python
# Before (vulnerable)
query = f"SELECT * FROM users WHERE id = {user_id}"

# After (secure)
query = "SELECT * FROM users WHERE id = ?"
cursor.execute(query, (user_id,))
\`\`\`
```

## Tables

Use tables for:
- **Comparisons** (Option A vs Option B)
- **Configuration** (Parameter | Description | Default)
- **Metrics** (Metric | Target | Current)
- **Status** (Feature | Status | ETA)

### Example:

```markdown
| Provider | Cost/Run | Quality | Recommendation |
|----------|----------|---------|----------------|
| Claude | $0.30 | Excellent | ✅ Use this |
| GPT-4 | $0.90 | Good | ⚠️ 3x cost |
| Ollama | $0.00 | Fair | 🧪 Dev only |
```

## Progressive Disclosure

Start with overview, link to details:

```markdown
# Architecture Overview

The system has 3 main components:
- **API Gateway**: Routes requests ([details](./api-gateway.md))
- **Auth Service**: Handles authentication ([details](./auth-service.md))
- **Database**: PostgreSQL 14 ([details](./database.md))

For deployment procedures, see [Deployment Runbook](../playbooks/deployment.md).
```

## Validation Checklist

Before generating a doc, verify:

- [ ] File is 100-300 lines
- [ ] Has clear purpose statement
- [ ] Has actionable content (code examples, commands, procedures)
- [ ] Uses scannable structure (headings, bullets, tables)
- [ ] No duplication with existing docs
- [ ] Links to related docs
- [ ] Code examples are copy-paste ready
- [ ] AI disclaimer present (if AI-generated)
- [ ] Frontmatter complete

## Anti-Patterns to Avoid

### ❌ Verbose Explanations
```markdown
The system utilizes a sophisticated multi-layered architecture that facilitates
the processing of incoming requests through a series of interconnected components...
```

### ✅ Concise Description
```markdown
The system processes requests through 3 layers: API → Service → Database.
```

---

### ❌ Theoretical Content
```markdown
## Security Considerations
Security is important. You should consider implementing authentication and authorization.
```

### ✅ Actionable Guidance
```markdown
## Security Setup

\`\`\`bash
# Enable authentication
export AUTH_ENABLED=true
export JWT_SECRET=$(openssl rand -base64 32)
\`\`\`
```

---

### ❌ Duplicate Content
```markdown
# Getting Started (in both README and docs/intro.md with identical content)
```

### ✅ Link to Source
```markdown
# Getting Started
See [README](../README.md#getting-started) for installation and setup.
```

## Quality Metrics

Track these for continuous improvement:

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Avg file length | 200 lines | Count lines per file |
| Files >300 lines | 0% | Flag violations |
| Code example coverage | 80%+ | % of docs with examples |
| Broken links | 0 | Run link checker |
| Duplicate content | <5% | Similarity analysis |

## References

- [Google Documentation Style Guide](https://developers.google.com/style)
- [Stripe API Documentation](https://stripe.com/docs/api) (best-in-class example)
- [Divio Documentation System](https://documentation.divio.com/)

