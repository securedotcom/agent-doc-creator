# Data Flow, Privacy & Security

**Last Updated**: 2024-11-11
**Status**: Current implementation analysis

> This document provides complete transparency about what data is collected, where it goes, and what privacy/security risks exist.

## Executive Summary

🔴 **HIGH RISK**: Agent Doc Creator sends your **entire codebase** to Anthropic's API (external service). This includes:
- Source code
- Configuration files
- Environment variable names (not values, unless hardcoded)
- Comments and documentation
- File structure and names

**If your code contains**:
- Trade secrets
- Proprietary algorithms
- Customer data
- Hardcoded credentials
- Sensitive business logic

**DO NOT USE** this tool until local model support is added.

## Detailed Data Flow

### 1. What Data Is Collected

| Data Type | Collected? | Sent to API? | Purpose |
|-----------|------------|--------------|---------|
| **Source Code** | ✅ Yes | ✅ Yes | Analyze architecture, generate docs |
| **File Names** | ✅ Yes | ✅ Yes | Understand project structure |
| **Directory Structure** | ✅ Yes | ✅ Yes | Map components and services |
| **Git History** | ✅ Yes (metadata) | ❌ No | Create branch, commit, PR |
| **Dependencies** | ✅ Yes | ✅ Yes | Document tech stack |
| **Config Files** | ✅ Yes | ✅ Yes | Generate configuration reference |
| **Environment Variables** | ✅ Names only | ✅ Names only | Document required config |
| **Comments** | ✅ Yes | ✅ Yes | Understand intent |
| **README** | ✅ Yes | ✅ Yes | Understand project purpose |
| **Tests** | ✅ Yes | ✅ Yes | Understand usage patterns |
| **Credentials** | ⚠️ If hardcoded | ⚠️ If hardcoded | **RISK**: No secret detection |

### 2. Data Flow Diagram

```mermaid
flowchart TD
    A[Your Repository] -->|1. Read Files| B[Cursor IDE]
    B -->|2. Load into Memory| C[Claude Context]
    C -->|3. API Call| D[Anthropic API]
    D -->|4. Process| E[Anthropic Servers]
    E -->|5. Generate Docs| D
    D -->|6. Return| C
    C -->|7. Write Files| F[Local Docs]
    F -->|8. Git Commit| G[GitHub]
    
    style D fill:#ff9999,stroke:#cc0000
    style E fill:#ff6666,stroke:#cc0000
    style A fill:#99ccff
    style F fill:#99ff99
    style G fill:#99ff99
    
    subgraph "Your Infrastructure"
        A
        B
        C
        F
    end
    
    subgraph "External Services (Data Leaves Your Control)"
        D
        E
        G
    end
```

**Legend**:
- 🔵 **Blue**: Your infrastructure (you control)
- 🔴 **Red**: External API (data leaves your control)
- 🟢 **Green**: Output (you review before merge)

### 3. Step-by-Step Data Flow

#### Step 1: Repository Scan

```
User: "Generate docs for /path/to/repo"
  ↓
Cursor reads:
  - README.md (sent to API)
  - package.json / pyproject.toml (sent to API)
  - docker-compose.yml (sent to API)
  - src/**/*.py (sent to API)
  - config/**/*.yml (sent to API)
  
Estimated data sent: 50-500 KB per repository
```

#### Step 2: Code Analysis

```
Claude (via Anthropic API):
  - Receives all file contents
  - Analyzes architecture patterns
  - Identifies components and services
  - Infers design decisions
  
Processing location: Anthropic's servers (US-based)
Data retention: Per Anthropic's policy (see below)
```

#### Step 3: Documentation Generation

```
Claude generates:
  - Architecture overview (includes code snippets from your repo)
  - Best practices (includes your code examples)
  - ADRs (references your design choices)
  - Configuration (lists your env vars)
  
Output: 1,000-2,000 lines of markdown
Includes: Excerpts and references to your code
```

#### Step 4: Local Write & Git Push

```
Docs written to: /path/to/repo/docs/
Git commit: Includes generated docs
Git push: Sends to GitHub (another external service)
PR created: Visible to repo collaborators
```

## Privacy Policy Compliance

### Anthropic's Data Handling

**Source**: [Anthropic Privacy Policy](https://www.anthropic.com/legal/privacy)

| Aspect | Policy |
|--------|--------|
| **Data Retention** | 30 days for abuse detection, then deleted |
| **Training Data** | API data NOT used for model training (as of 2024) |
| **Data Location** | US-based servers (AWS) |
| **Encryption** | In-transit (TLS), at-rest (AES-256) |
| **Access** | Anthropic employees (for abuse/safety) |
| **Sharing** | Not shared with third parties (except subprocessors) |
| **GDPR** | Compliant (EU users have data rights) |
| **SOC 2** | Type II certified |

**Key Takeaway**: Your code is stored for 30 days, then deleted. Not used for training.

### GitHub's Data Handling

**Source**: [GitHub Privacy Statement](https://docs.github.com/en/site-policy/privacy-policies/github-privacy-statement)

| Aspect | Policy |
|--------|--------|
| **Data Retention** | Indefinite (until repo deleted) |
| **Training Data** | Public repos MAY be used for Copilot training |
| **Data Location** | US-based (with global CDN) |
| **Access** | Repo collaborators, GitHub employees (for support) |
| **Sharing** | Public repos visible to everyone |

**Key Takeaway**: Generated docs in GitHub are permanent (until you delete them).

## Security Risks

### 1. Code Exfiltration (HIGH RISK)

**Risk**: Entire codebase sent to external API.

**Threat Scenarios**:
- Anthropic data breach → your code leaked
- Rogue Anthropic employee → accesses your code
- Government subpoena → Anthropic forced to share your code
- Man-in-the-middle attack → code intercepted (unlikely with TLS)

**Mitigation**:
- ✅ Use only on open-source or non-sensitive repos
- ✅ Review Anthropic's SOC 2 report
- ❌ No local model support (coming in future)
- ❌ No data residency controls (e.g., EU-only processing)

### 2. Credential Exposure (HIGH RISK)

**Risk**: Hardcoded credentials sent to API.

**Examples**:
```python
# ❌ This gets sent to Anthropic API
AWS_SECRET_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
DATABASE_URL = "postgresql://user:password@host:5432/db"
```

**Mitigation**:
- ✅ Use environment variables (names sent, values not)
- ✅ Use secret managers (AWS Secrets Manager, HashiCorp Vault)
- ❌ No automatic secret detection (coming in future)
- ❌ No redaction before sending to API

### 3. Dependency Vulnerabilities (MEDIUM RISK)

**Risk**: Generated docs may reference vulnerable packages.

**Example**:
```markdown
# Technology Stack
- Express 4.16.0 (VULNERABLE: CVE-2022-24999)
```

**Mitigation**:
- ✅ Run `npm audit` or `pip-audit` separately
- ❌ No automatic vulnerability scanning in generated docs

### 4. Intellectual Property Leakage (HIGH RISK)

**Risk**: Proprietary algorithms or business logic sent to API.

**Example**:
```python
# Your secret sauce algorithm
def calculate_pricing(customer, product):
    # Proprietary pricing logic
    return price
```

**Mitigation**:
- ✅ Only use on non-proprietary codebases
- ✅ Review generated docs before merging (may contain code snippets)
- ❌ No automatic IP detection

## Token Usage & Costs

### Estimated Token Usage

| Repository Size | Input Tokens | Output Tokens | Total Cost |
|-----------------|--------------|---------------|------------|
| **Small** (<10K LOC) | 30-50K | 5-10K | $3-8 |
| **Medium** (10-50K LOC) | 50-100K | 10-15K | $8-18 |
| **Large** (50-100K LOC) | 100-200K | 15-20K | $18-35 |
| **Very Large** (>100K LOC) | 200K+ | 20-30K | $35-60+ |

**Pricing** (as of Nov 2024):
- Input: $3 per million tokens
- Output: $15 per million tokens

**Example** (secure_data_retrieval_agent):
- Input: 50K tokens × $3/M = $0.15
- Output: 30K tokens × $15/M = $0.45
- **Total**: $0.60 per run

**Note**: Costs add up if you regenerate docs multiple times.

### Token Breakdown

| Phase | Input Tokens | Output Tokens |
|-------|--------------|---------------|
| Repository scan | 20-30K | 0 |
| Architecture generation | 10K | 5-8K |
| Best practices generation | 10K | 5-8K |
| ADR generation (2x) | 10K | 4-6K |
| Configuration generation | 5K | 3-5K |

## Compliance Considerations

### GDPR (EU)

**Applies if**: Your code contains EU personal data.

**Requirements**:
- ✅ Data Processing Agreement with Anthropic (available)
- ✅ Right to deletion (Anthropic deletes after 30 days)
- ✅ Data encryption (TLS + AES-256)
- ❌ Data residency (no EU-only processing option)

**Recommendation**: Get legal review if processing EU personal data.

### HIPAA (Healthcare)

**Applies if**: Your code contains Protected Health Information (PHI).

**Requirements**:
- ❌ Anthropic is NOT HIPAA compliant for API usage
- ❌ Do NOT use on healthcare codebases with PHI

### SOC 2 (Enterprise)

**Applies if**: Your company requires SOC 2 compliance from vendors.

**Status**:
- ✅ Anthropic is SOC 2 Type II certified
- ✅ Request SOC 2 report from Anthropic

### PCI DSS (Payment Card Industry)

**Applies if**: Your code handles credit card data.

**Requirements**:
- ❌ Do NOT use on codebases with cardholder data
- ❌ Anthropic API is not PCI DSS compliant for code processing

## Recommendations by Use Case

### ✅ Safe to Use

- **Open-source projects** (already public)
- **Internal tools** (no sensitive data)
- **Learning projects** (no production use)
- **Proof-of-concepts** (no proprietary logic)

### ⚠️ Use with Caution

- **Closed-source projects** (review Anthropic's privacy policy)
- **SaaS products** (no customer data in code)
- **Enterprise tools** (get legal approval)

### ❌ Do NOT Use

- **Healthcare apps** (HIPAA data)
- **Financial apps** (PCI DSS data)
- **Government projects** (classified/sensitive)
- **Code with hardcoded secrets** (credential exposure)
- **Proprietary algorithms** (IP leakage)

## Future Improvements

### Phase 1: Secret Detection

```bash
agent-doc-creator --scan-secrets
# Detects and redacts:
# - API keys
# - Passwords
# - Private keys
# - Tokens
```

**Implementation**: Use `truffleHog` or `gitleaks` before sending to API.

### Phase 2: Local Model Support

```bash
agent-doc-creator --model ollama/llama3
# Runs entirely offline:
# - No external API calls
# - No data exfiltration
# - Full privacy control
```

**Implementation**: Integrate Ollama or llama.cpp.

### Phase 3: Allowlist Mode

```bash
agent-doc-creator --allowlist "src/public/**"
# Only sends specified files to API
# Excludes sensitive directories
```

**Implementation**: File filtering before API calls.

### Phase 4: Data Residency

```bash
agent-doc-creator --region eu-west-1
# Process data only in EU
# GDPR compliance
```

**Implementation**: Requires Anthropic to offer regional endpoints.

## Audit Trail

### What to Log

For compliance, log:
- ✅ When docs were generated (timestamp)
- ✅ What files were sent to API (file list)
- ✅ Who initiated generation (user)
- ✅ Token usage (input/output)
- ✅ Cost (estimated)

**Implementation**: Not currently implemented. Coming in future.

## Contact & Reporting

### Security Issues

If you discover a security vulnerability:
1. **DO NOT** open a public issue
2. Email: [security@securedotcom.com](mailto:security@securedotcom.com)
3. Include: Description, impact, reproduction steps

### Privacy Concerns

For privacy questions:
1. Review [Anthropic's Privacy Policy](https://www.anthropic.com/legal/privacy)
2. Contact Anthropic: privacy@anthropic.com
3. Contact us: [privacy@securedotcom.com](mailto:privacy@securedotcom.com)

## References

- [Anthropic Privacy Policy](https://www.anthropic.com/legal/privacy)
- [Anthropic Security](https://www.anthropic.com/security)
- [GitHub Privacy Statement](https://docs.github.com/en/site-policy/privacy-policies/github-privacy-statement)
- [GDPR Compliance](https://gdpr.eu/)
- [SOC 2 Overview](https://www.aicpa.org/interestareas/frc/assuranceadvisoryservices/aicpasoc2report)

