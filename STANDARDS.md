# Documentation Standards

**Last Updated**: 2024-11-11
**Status**: Draft - Being Implemented

> This document defines the specific documentation patterns and quality metrics Agent Doc Creator aims to implement. These are based on real documentation standards from Google, Stripe, AWS, and other leading tech companies.

## Overview

"FAANG-quality" is aspirational marketing. This document defines what we actually mean by "quality documentation" with specific, measurable standards.

## Guiding Principles

### 1. Progressive Disclosure (Google's Pattern)

**Source**: [Google Developer Documentation Style Guide](https://developers.google.com/style/api-reference-comments)

**Pattern**: Start with high-level overview, progressively reveal details.

**Implementation**:
```markdown
# Component Name

**Purpose**: One-sentence description (what it does)

## Quick Start (3-5 steps to working example)

## Common Use Cases (3-5 scenarios with examples)

## Architecture (detailed design)

## API Reference (complete details)
```

**Example from Google Cloud**:
- Overview: "Cloud Storage stores objects in buckets"
- Quick Start: 3 commands to upload a file
- Use Cases: Static website hosting, data lakes, backups
- Architecture: Consistency model, storage classes, lifecycle
- API: Complete method reference

**Our Target**: Every doc starts with purpose + quick start, links to details.

### 2. Scannable Structure (Stripe's Pattern)

**Source**: [Stripe API Documentation](https://stripe.com/docs/api)

**Pattern**: Tables, code examples, visual hierarchy.

**Implementation**:
- **Tables for comparisons** (not paragraphs)
- **Code examples** for every concept
- **Bullets** for lists (not prose)
- **Headings** every 5-10 lines
- **Bold** for key terms

**Example from Stripe**:
```markdown
| Parameter | Type | Description |
|-----------|------|-------------|
| amount | integer | Amount in cents |
| currency | string | Three-letter ISO code |
```

**Our Target**: 
- Max 10 lines of prose without a heading, table, or code block
- Every API/config has a table
- Every workflow has a code example

### 3. Actionable Content (AWS's Pattern)

**Source**: [AWS Documentation](https://docs.aws.amazon.com/)

**Pattern**: Copy-paste ready commands, specific examples.

**Implementation**:
- **Complete commands** (not partial snippets)
- **Real values** (not placeholders like `<your-value>`)
- **Expected output** shown
- **Troubleshooting** for common errors

**Example from AWS**:
```bash
# ✅ Good: Complete, runnable
aws s3 cp myfile.txt s3://my-bucket/myfile.txt
# Expected output: upload: ./myfile.txt to s3://my-bucket/myfile.txt

# ❌ Bad: Incomplete
aws s3 cp <file> <bucket>
```

**Our Target**: Every command is copy-paste ready with real examples.

### 4. No Duplication (React's Pattern)

**Source**: [React Documentation](https://react.dev/)

**Pattern**: Link instead of rewrite.

**Implementation**:
- **Write once** - Single source of truth per concept
- **Link generously** - Cross-reference related concepts
- **Summarize + link** - Brief summary, link to full details

**Example from React**:
```markdown
# useState Hook

For managing state in class components, see [Component State](./component-state.md).

(Full useState documentation here)
```

**Our Target**: No concept explained twice. Use "See [X](link)" liberally.

## Measurable Quality Metrics

### 1. Readability

**Metric**: Flesch Reading Ease Score
- **Target**: 60-70 (Plain English)
- **Tool**: `textstat` Python library
- **Calculation**: Based on sentence length and syllables per word

**Benchmark**:
- 90-100: Very Easy (5th grade)
- 60-70: Plain English (8th-9th grade) ← **Our Target**
- 30-50: Difficult (College)
- 0-30: Very Difficult (Graduate)

**Why 60-70**: Technical docs need precision, but should be accessible to most developers.

### 2. Conciseness

**Metric**: Lines per file
- **Target**: 200 lines (ideal)
- **Max**: 300 lines (hard limit)
- **Rationale**: Fits on 2-3 screens, quick to scan

**Benchmark**:
- Google Cloud docs: 150-400 lines per page
- Stripe API docs: 100-300 lines per endpoint
- AWS docs: 200-500 lines per service

**Our Target**: Stricter than industry (200-300 vs 200-500).

### 3. Time to First Action

**Metric**: Lines until first runnable example
- **Target**: <50 lines
- **Max**: 100 lines
- **Measurement**: Count lines from start of doc to first complete code example

**Benchmark**:
- Stripe: ~20 lines to first API call
- Next.js: ~30 lines to "Hello World"
- Django: ~40 lines to first view

**Our Target**: <50 lines (within industry best).

### 4. Code-to-Prose Ratio

**Metric**: Lines of code / lines of prose
- **Target**: 0.3-0.5 (30-50% code examples)
- **Rationale**: Developers learn by doing, not reading

**Benchmark**:
- Stripe API docs: ~40% code
- MDN Web Docs: ~30% code
- AWS SDK docs: ~20% code

**Our Target**: 30-50% code (high end of industry).

### 5. Link Density

**Metric**: Internal links per 100 lines
- **Target**: 5-10 links per 100 lines
- **Rationale**: Progressive disclosure requires linking

**Benchmark**:
- Wikipedia: ~15 links per 100 lines
- MDN: ~8 links per 100 lines
- Google Cloud: ~5 links per 100 lines

**Our Target**: 5-10 links (match Google Cloud).

## Specific Patterns by Document Type

### Architecture Overview

**Structure** (from Google Cloud Architecture Center):
```markdown
# System Name

## Purpose (1-2 sentences)

## Architecture Diagram (Mermaid)

## Core Components (table)

| Component | Purpose | Technology |
|-----------|---------|------------|

## Data Flow (numbered steps with diagram)

## Technology Stack (table)

## Next Steps (links to deep dives)
```

**Metrics**:
- Length: 200-300 lines
- Diagram: 1 high-level Mermaid diagram
- Tables: 2-3 (components, tech stack)
- Code examples: 0-1 (architecture docs are visual)

### Best Practices Guide

**Structure** (from Stripe's Best Practices):
```markdown
# Best Practices

## Quick Start (3 steps)

## Common Use Cases (5 scenarios)

### 1. Use Case Name
**Problem**: What user wants to do
**Solution**: How to do it
**Example**: Complete code

## Configuration (table)

## Performance (specific metrics)

## Security (specific recommendations)

## Troubleshooting (table)

| Issue | Cause | Solution |
```

**Metrics**:
- Length: 250-300 lines
- Use cases: 3-5 with complete examples
- Tables: 3-4 (config, troubleshooting)
- Code examples: 5-10

### ADR (Architecture Decision Record)

**Structure** (from Michael Nygard's ADR format):
```markdown
# ADR-NNNN: Decision Title

**Status**: Accepted | Rejected | Deprecated
**Date**: YYYY-MM-DD

## Context (problem statement)

## Decision (what we decided)

## Rationale (why we decided)

### Benefits
### Drawbacks

## Consequences

### Positive
### Negative

## Alternatives Considered

### Alternative 1
**Pros**:
**Cons**:
**Decision**: Why rejected

## Success Metrics (measurable)

| Metric | Target | Actual | Status |
```

**Metrics**:
- Length: 200-250 lines
- Alternatives: 2-3 with pros/cons
- Success metrics: 3-5 measurable outcomes

### Configuration Reference

**Structure** (from AWS Config Reference):
```markdown
# Configuration Reference

## Environment Variables (table)

| Variable | Required | Default | Description | Example |

## Configuration Files

### File Name
**Purpose**: What it configures
**Format**: JSON | YAML | TOML
**Example**:
```json
{complete example}
```

## Recommended Configurations

### Development
### Staging
### Production
```

**Metrics**:
- Length: 250-300 lines
- Tables: 1-2 (env vars, options)
- Examples: 3 (dev, staging, prod)

## Validation Checklist

Before marking documentation as "complete", verify:

### Content Quality
- [ ] **Purpose statement** in first 2 sentences
- [ ] **Quick start** within first 50 lines
- [ ] **Code examples** are complete and runnable
- [ ] **No placeholders** like `<your-value>` (use real examples)
- [ ] **Tables** for all comparisons (not prose)
- [ ] **Links** to related concepts (5-10 per 100 lines)
- [ ] **No duplication** (each concept explained once)

### Readability
- [ ] **Flesch score** 60-70 (run `textstat.flesch_reading_ease()`)
- [ ] **Max 10 lines** of prose without heading/table/code
- [ ] **Headings** every 5-10 lines
- [ ] **Bullets** for lists (not numbered unless order matters)

### Metrics
- [ ] **Length** 200-300 lines (run `wc -l`)
- [ ] **Time to first action** <50 lines
- [ ] **Code-to-prose ratio** 0.3-0.5
- [ ] **Link density** 5-10 per 100 lines

### Technical Accuracy
- [ ] **Commands tested** (actually run them)
- [ ] **Links valid** (no 404s)
- [ ] **Code syntax** correct (run through linter)
- [ ] **Examples work** (copy-paste and verify)

## Implementation Status

| Standard | Status | Notes |
|----------|--------|-------|
| Progressive disclosure | ✅ Implemented | All docs start with purpose + quick start |
| Scannable structure | ✅ Implemented | Heavy use of tables, bullets, code blocks |
| Actionable content | ✅ Implemented | All examples are complete and runnable |
| No duplication | ✅ Implemented | Cross-linking used extensively |
| Flesch score 60-70 | ❌ Not measured | Need to add textstat validation |
| 200-300 lines | ✅ Implemented | Hard limit enforced |
| Time to first action <50 | ✅ Implemented | Quick starts within 50 lines |
| Code-to-prose 0.3-0.5 | ❌ Not measured | Need to add calculation |
| Link density 5-10 | ❌ Not measured | Need to add link counting |
| Commands tested | ❌ Manual | Need automated testing |
| Links valid | ❌ Not implemented | Need broken link checker |
| Code syntax | ❌ Not implemented | Need linter integration |

## Next Steps

1. **Add automated validation** for Flesch score, code-to-prose ratio, link density
2. **Implement broken link checker** (crawl all internal links)
3. **Add code syntax validation** (run examples through linters)
4. **Create quality dashboard** showing metrics for each doc
5. **Benchmark against real FAANG docs** (side-by-side comparisons)

## References

- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Stripe API Documentation](https://stripe.com/docs/api)
- [AWS Documentation Best Practices](https://docs.aws.amazon.com/)
- [React Documentation](https://react.dev/)
- [Michael Nygard's ADR Format](https://github.com/joelparkerhenderson/architecture-decision-record)
- [Flesch Reading Ease](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests)

