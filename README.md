# kn-standard-prd

A production-grade PRD skill for generating clear, measurable, and execution-ready Product Requirements Documents.

## What This Skill Provides

- Rigorous discovery workflow before drafting
- PRD modes: `standard`, `lean`, `one-pager`, `technical`, `ai-feature`
- Reusable templates and question banks
- Deterministic validation via `scripts/validate_prd.sh`

## Repository Structure

- `SKILL.md`: Main skill instructions and workflow
- `references/`: Templates, checklists, and guidance files
- `scripts/`: Validation script and automation utilities
- `AGENTS.md`: Contributor instructions for human/AI agents

## Quick Start

1. Read `SKILL.md`.
2. Pick a PRD mode using `references/mode_selection_matrix.md`.
3. Draft using the corresponding template.
4. Validate:
   ```bash
   bash scripts/validate_prd.sh <prd_file.md> --mode <standard|lean|one-pager|technical|ai-feature>
   ```

## Compatibility

- The validator is implemented in Bash and should be run with Bash.
- If Bash is unavailable, use `references/prd_review_checklist.md` for manual validation.

## Included References

- `references/prd_template_standard.md`
- `references/prd_template_lean.md`
- `references/discovery_question_bank.md`
- `references/metrics_framework_selector.md`
- `references/mode_selection_matrix.md`
- `references/user_story_examples.md`
- `references/prd_review_checklist.md`

## License

MIT
