# <PROJECT NAME>: agent context

> Canonical operating manual for this repo. Antigravity reads this file natively.
> Claude Code reads it through the one-line `CLAUDE.md` (`@AGENTS.md`).

## What this project is

<one paragraph: what it is, the deliverable, the stack>

## How to work here

- At session start, run `/start`: read `.agent/STATE.md`, `.agent/DECISIONS.md`,
  and the active plan before scanning the repo.
- At session close, run `/handover`: rewrite `.agent/STATE.md` and append a dated
  note to `.agent/sessions/`.
- When a decision is locked, it goes in `.agent/DECISIONS.md` (use `/decide` or
  accept the proactive offer). Never re-litigate a logged decision.

## Where state lives

- `.agent/STATE.md`     current status and next steps (always current)
- `.agent/DECISIONS.md` append-only decision log (plus the why)
- `.agent/sessions/`    dated handover notes (history)

## Conventions

<fill in: naming, branch rules, output formats, anything an agent must follow>

## Guardrails

- Never put sensitive or protected data in `.agent/` files. Decisions, status,
  and aggregates only.
- <list any protected paths here>
