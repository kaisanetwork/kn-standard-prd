#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${BASH_VERSION:-}" ]]; then
  echo "ERROR: This validator requires Bash."
  echo "Run it with: bash scripts/validate_prd.sh <prd_file.md> --mode <mode>"
  exit 2
fi

usage() {
  cat <<USAGE
Usage: $0 <prd_file.md> [--mode standard|lean|one-pager|technical|ai-feature] [--verbose]
USAGE
  exit 1
}

if [[ $# -lt 1 ]]; then
  usage
fi

FILE="$1"
shift
MODE="standard"
VERBOSE="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode)
      MODE="${2:-}"
      shift 2
      ;;
    --verbose)
      VERBOSE="true"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
done

if [[ ! -f "$FILE" ]]; then
  echo "ERROR: File not found: $FILE"
  exit 1
fi

case "$MODE" in
  standard|lean|one-pager|technical|ai-feature) ;;
  *) echo "ERROR: invalid --mode '$MODE'"; exit 1 ;;
esac

PASS=0
WARN=0
FAIL=0

ok() { echo "[PASS] $1"; PASS=$((PASS + 1)); }
warn() { echo "[WARN] $1"; WARN=$((WARN + 1)); }
fail() { echo "[FAIL] $1"; FAIL=$((FAIL + 1)); }

has_header() {
  local pattern="$1"
  if rg -qi "^#{1,3} .*${pattern}" "$FILE"; then
    return 0
  fi
  return 1
}

require_section() {
  local name="$1"
  local pattern="$2"
  if has_header "$pattern"; then ok "$name section"; else fail "$name section missing"; fi
}

recommend_section() {
  local name="$1"
  local pattern="$2"
  if has_header "$pattern"; then ok "$name section"; else warn "$name section missing"; fi
}

# Required in all modes
require_section "Problem" "Problem"
require_section "Goals" "Goals|Objectives|Outcome"
require_section "User stories/requirements" "User Stories|Requirements"
require_section "Success metrics" "Success Metrics|Metrics"
require_section "Scope" "Scope"

# Common quality checks
if rg -n "\[[^\]]+\]" "$FILE" >/dev/null; then warn "Bracket placeholders remain (e.g. [todo])"; else ok "No bracket placeholders"; fi
if rg -n "\b(TBD|TODO|lorem ipsum)\b" -i "$FILE" >/dev/null; then warn "TBD/TODO placeholders remain"; else ok "No TBD/TODO placeholders"; fi
if rg -n "As a " "$FILE" >/dev/null && rg -n "I want " "$FILE" >/dev/null && rg -n "So that " "$FILE" >/dev/null; then
  ok "User story format present"
else
  fail "No properly formatted user story found"
fi
if rg -n "Acceptance Criteria|Given .* when .* then" "$FILE" >/dev/null; then ok "Acceptance criteria present"; else fail "Acceptance criteria missing"; fi
if rg -n "[0-9]+%|[0-9]+\s*(ms|s|sec|seconds|minutes|hours|days)|p95|p99|<=|>=|<|>" "$FILE" >/dev/null; then ok "Quantified targets present"; else warn "No clear quantified targets found"; fi

if rg -qi "in scope|in-scope" "$FILE"; then ok "In-scope defined"; else warn "In-scope not explicit"; fi
if rg -qi "out of scope|out-of-scope|non-goals" "$FILE"; then ok "Out-of-scope/non-goals defined"; else fail "Out-of-scope/non-goals missing"; fi

# Mode-specific checks
case "$MODE" in
  standard)
    recommend_section "Risks" "Risks"
    recommend_section "Dependencies" "Dependencies|Assumptions"
    recommend_section "Timeline/Rollout" "Timeline|Rollout|Milestones"
    ;;
  lean)
    recommend_section "Risks/Dependencies" "Risk|Dependencies"
    ;;
  one-pager)
    recommend_section "Executive Summary" "Executive Summary"
    ;;
  technical)
    require_section "Technical considerations" "Technical|Architecture"
    require_section "Non-functional requirements" "Non-Functional|NFR|Performance|Security"
    ;;
  ai-feature)
    require_section "AI requirements" "AI|Model|Evaluation"
    require_section "Safety/Privacy" "Safety|Privacy|Guardrail"
    if rg -qi "benchmark|eval|dataset|pass rate|accuracy" "$FILE"; then ok "Evaluation plan present"; else fail "Evaluation plan missing"; fi
    ;;
esac

WORDS=$(wc -w < "$FILE" | tr -d ' ')
if [[ "$WORDS" -lt 250 ]]; then
  warn "Document seems too short for most PRDs ($WORDS words)"
else
  ok "Word count looks reasonable ($WORDS words)"
fi

echo ""
echo "Summary: PASS=$PASS WARN=$WARN FAIL=$FAIL"

if [[ "$VERBOSE" == "true" ]]; then
  echo "Mode: $MODE"
fi

if [[ "$FAIL" -gt 0 ]]; then
  exit 1
fi
exit 0
