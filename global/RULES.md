# Agent rules

> Universal operating rules for AI coding agents (Claude Code, Antigravity, and
> any tool that reads CLAUDE.md / GEMINI.md / AGENTS.md). Installed globally by
> `install.ps1` / `install.sh`. The Core sections below are tool-agnostic and
> good for anyone. The Preferences section at the end is where you put your own
> style. Edit freely and re-run the installer.

## The session loop (how every project remembers itself)

Each kit-enabled repo has a committed `.agent/` folder:

- `.agent/STATE.md`     current status, next steps, open questions, active plan
- `.agent/DECISIONS.md` append-only log of locked-in decisions and the WHY
- `.agent/sessions/`    dated handover notes (the history)

Rules:

- **At session start, run `/start`.** Read STATE, DECISIONS, and the active plan
  ONLY. Do not scan the whole repo to rebuild context. Those files exist so you
  do not start from scratch and do not burn tokens re-deriving what is known.
- **At session close, run `/handover`.** Rewrite STATE, append a session note,
  and sweep for decisions not yet logged.
- **Treat every DECISIONS entry as in force.** Never re-litigate or re-derive a
  logged decision. To change one, append a new entry that supersedes the old.

## Decision capture (standing rule)

When a real decision is settled or a fact is locked in during work, proactively
say so and offer to append it to `.agent/DECISIONS.md` (decision plus why). The
user confirms. The user can also force an entry with `/decide`. A decision
without a recorded WHY is not durable, so always capture the reasoning.

## Working principles

- **Verify before claiming.** Run it, read the output, then state the result. Do
  not claim a fix works without seeing it work.
- **Guides are not records.** What a plan or guide says should happen is not
  evidence that it happened. The authoritative state is the code, the logs, and
  `.agent/STATE.md` / `.agent/DECISIONS.md`. Verify there before relying on a claim.
- **Write state to files, not just chat.** Decisions go in DECISIONS.md; status
  goes in STATE.md. Context windows end; files persist.
- **Plans are living.** When execution deviates from the plan, edit the plan and
  note why. If the change is a locked choice, also record it with `/decide`.
- **Be concise in output, thorough in reasoning.**

## Data safety

- Never put sensitive, private, or licensed data into any `.agent/` file or
  commit. STATE, DECISIONS, and session notes hold decisions, status, and
  aggregates only.
- Honor each repo's protected-path rules (see its AGENTS.md / CLAUDE.md).

## Preferences (customize this section, then re-run the installer)

These are the repo owner's personal preferences. If you forked this kit, change
them to your own.

- Writing style: avoid em dashes and en dashes (the long horizontal bars, or
  `--`, or `---`). Use commas, colons, parentheses, or separate sentences.
- No filler openers or closers.
