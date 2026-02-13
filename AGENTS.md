# AGENTS.md

## Purpose

This repository contains the `kn-standard-prd` skill. Contributions must preserve quality, clarity, and deterministic behavior for PRD generation workflows.

## Working Rules

- Keep `SKILL.md` concise and workflow-first.
- Prefer adding detailed guidance under `references/` instead of bloating `SKILL.md`.
- Maintain measurable requirement language (no vague terms like "fast" or "intuitive" without targets).
- Preserve explicit scope boundaries (`in-scope` and `out-of-scope`).

## Scripts and Environment

- `scripts/validate_prd.sh` requires Bash.
- Execute with:
  ```bash
  bash scripts/validate_prd.sh <prd_file.md> --mode <mode>
  ```
- If Bash is not available, use `references/prd_review_checklist.md` for manual checks.

## Change Guidelines

- When adding a new PRD mode, update:
  - `SKILL.md`
  - `references/mode_selection_matrix.md`
  - `scripts/validate_prd.sh`
- When changing metrics guidance, keep examples and thresholds concrete.
- Do not remove existing references unless replaced by equivalent or better coverage.

## Verification Before Completion

- Validate templates with `scripts/validate_prd.sh` using the relevant mode.
- Ensure no broken internal links or missing referenced files.
