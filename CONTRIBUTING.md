# Contributing to osinsight

Thank you for your interest in contributing to **osinsight**! We welcome contributions to improve our detection, policy, and incident response queries.

## Query Philosophy

Our queries follow a strict "Signal-to-Noise" philosophy:
1.  **Zero Results by Default**: Detection queries should return 0 rows during normal, expected system behavior. Any results returned should be worthy of an alert.
2.  **Breadth over Depth**: We prefer queries that catch classes of behavior (e.g., "Unexpected Shell Parents") over specific, brittle IOCs (e.g., a single file hash).
3.  **Cross-Platform**: While many queries are platform-specific (macOS or Linux), we strive for parity where applicable.

## Developing Queries

### The `exception_key` Pattern

For complex queries where false positives are common, we use an `exception_key` to manage exclusions. This is typically a concatenation of fields that uniquely identifies a "safe" behavior.

Example:
```sql
SELECT
  ...,
  p0.name || ',' || p1.name AS exception_key
FROM processes p0
JOIN processes p1 ON p0.parent = p1.pid
WHERE exception_key NOT IN (
  'bash,login',
  'zsh,iterm2'
);
```

### Verification with `ossentry`

We use [ossentry](https://github.com/khulnasoft-lab/ossentry) to verify that queries are performant and safe. Before submitting a PR, ensure your query:
*   Does not exceed a 16s wall-clock duration.
*   Does not consume excessive CPU.
*   Correctly uses `strftime` filters for event-based tables (e.g., `pe.time > (strftime('%s', 'now') - 180)`).

## Submission Process

1.  **Fork the repository**.
2.  **Create a new SQL file** in the appropriate directory (`detection/`, `policy/`, `vulnerabilities/`, or `incident_response/`).
3.  **Add Metadata**: Every file MUST start with comments containing:
    *   Description of the query.
    *   References (links to blogs, CVEs, etc.).
    *   `tags`: (e.g., `persistent state process`).
    *   `platform`: (`darwin`, `linux`, or `posix`).
4.  **Run `make packs`** to ensure your query is correctly formatted and included in the output packs.
5.  **Submit a Pull Request**.

## False Positives

If you encounter a false positive for an existing query, please submit a PR adding the specific `exception_key` or `WHERE` clause exclusion, along with a comment explaining what the software is.
