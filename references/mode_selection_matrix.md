# PRD Mode Selection Matrix

Use this matrix to choose the right PRD depth before drafting.

| Context | Recommended Mode | Why | Typical Length |
|---|---|---|---|
| New product / large cross-team initiative | `standard` | Needs full alignment, risks, and phased rollout | 6-15 pages |
| Small/medium feature in agile team | `lean` | Keeps focus on outcomes and deliverables | 1-4 pages |
| Leadership decision memo | `one-pager` | Fast decision and prioritization support | 1 page |
| Infra/platform/architecture heavy initiative | `technical` | Emphasizes NFRs, dependencies, and constraints | 4-10 pages |
| LLM/copilot/AI behavior feature | `ai-feature` | Requires eval strategy, safety, fallback design | 4-12 pages |

## Decision Heuristics

Choose `standard` if 2+ teams need sign-off.
Choose `lean` if delivery target is under one sprint.
Choose `technical` if non-functional requirements are primary risk.
Choose `ai-feature` if model behavior quality is core to user value.
