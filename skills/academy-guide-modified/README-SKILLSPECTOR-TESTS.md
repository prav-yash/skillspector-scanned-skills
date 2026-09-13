# Academy Guide SkillSpector Test Variant

This ZIP is a modified local scanner-test version of the Academy Guide skill.

## What was added

- `references/static-direct-prompt-injection.md`
- `references/indirect-prompt-injection-source.md`
- `references/tool-metadata-poisoning-sample.json`
- `references/loop-a.md`
- `references/loop-b.md`
- `references/loop-c.md`
- `fixtures/sample-catalog.json`
- `scripts/metadata_report_writer.py`
- `scripts/safe_subprocess_check.py`
- `scripts/command_string_scanner_test.py`
- `scripts/pdf_cleanup_dry_run.py`

## Expected analyzer areas

| Analyzer area | Test file |
|---|---|
| Static prompt injection | `references/static-direct-prompt-injection.md` |
| Indirect prompt injection | `references/indirect-prompt-injection-source.md` |
| Hidden/instruction-like metadata | `references/tool-metadata-poisoning-sample.json` |
| Reference loop handling | `references/loop-a.md`, `loop-b.md`, `loop-c.md` |
| MCP rug pull | `SKILL.md` frontmatter: `version: latest`, unpinned `npx academy-guide-helper` |
| MCP least privilege | `scripts/metadata_report_writer.py` vs `permissions: file_read` |
| Behavioral AST | `scripts/safe_subprocess_check.py` |
| Dangerous command text | `scripts/command_string_scanner_test.py` |
| File-delete capability | `scripts/pdf_cleanup_dry_run.py` |

## Scan command

```bash
SCAN_ID=academy-guide-skillspector-test-$(date +%Y%m%d-%H%M%S)
mkdir -p "scan-results/$SCAN_ID"

skillspector scan ./academy-guide-skillspector-test \
  --format json \
  --output "scan-results/$SCAN_ID/report.json" \
  --verbose \
  2>&1 | tee "scan-results/$SCAN_ID/scan.log"
```

## Notes

- Dangerous commands are stored as text only.
- PDF cleanup is dry-run by default and restricted to test/sandbox directories.
- `SKILL.md` is intentionally underdeclared to test MCP least privilege.
- Use report/log evidence only when documenting actual findings.
