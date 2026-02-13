# Standard PRD

![KN Standard PRD Header](Standard_PRD_Header.png)

Production-grade PRD skill to create measurable, execution-ready Product Requirements Documents with mandatory discovery and quality validation.

Repository: `kn-standard-prd`

## What this skill does

`kn-standard-prd` provides a standardized PRD workflow:

- Runs a discovery interview before drafting
- Supports PRD modes: `standard`, `lean`, `one-pager`, `technical`, `ai-feature`
- Enforces measurable requirements and explicit scope boundaries
- Validates document quality with `scripts/validate_prd.sh`

Source of truth: `SKILL.md`.

## Repository structure

- `SKILL.md`: Core workflow, output contract, and quality rules
- `references/`: Templates, question banks, metrics guidance, and checklists
- `scripts/validate_prd.sh`: Bash validator with mode-specific checks
- `AGENTS.md`: Contributor guidance for human/AI collaborators
- `.gitignore`: Local environment exclusions

## Quick usage

Typical flow:

1. Read `SKILL.md`.
2. Choose a mode with `references/mode_selection_matrix.md`.
3. Draft from `references/prd_template_standard.md` or `references/prd_template_lean.md`.
4. Validate:

```bash
bash scripts/validate_prd.sh <prd_file.md> --mode <standard|lean|one-pager|technical|ai-feature>
```

## Compatibility

- Validator requires Bash.
- If Bash is unavailable, run a manual review with `references/prd_review_checklist.md`.

## Included references

- `references/discovery_question_bank.md`
- `references/metrics_framework_selector.md`
- `references/mode_selection_matrix.md`
- `references/prd_review_checklist.md`
- `references/prd_template_lean.md`
- `references/prd_template_standard.md`
- `references/user_story_examples.md`

## Contributing

1. Keep `SKILL.md` concise and workflow-first.
2. Add detailed material under `references/` when possible.
3. Preserve measurable language and explicit out-of-scope coverage.
4. Validate any PRD examples with `scripts/validate_prd.sh` before finalizing changes.

## License

MIT
