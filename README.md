# agent-kit

A small, tool-agnostic operating layer for AI coding agents. It makes every
project **remember itself across sessions and across tools** (Claude Code and
Google Antigravity), and it **saves tokens** by resuming from a few committed
files instead of re-reading the whole repo.

No project is required to use it, and nothing in this repo is tied to any
particular project. Drop it into anything: research code, an app, infrastructure,
notes.

## Why

AI coding sessions forget. Each new session re-reads the codebase, re-derives
decisions you already made, and re-litigates settled questions, which wastes
tokens and drifts. Heavyweight frameworks exist, but most bolt onto one tool.

`agent-kit` takes one durable idea: **keep state and rules as plain markdown in
git, separate from the AI tool.** That separation is what lets the same memory
work in Claude Code today and Antigravity tomorrow. Committed markdown crosses
the boundary that neither tool's native memory does.

## What you get

- **Global rules** for both tools, generated from a single `RULES.md`.
- **Three workflows** (`/start`, `/handover`, `/decide`) installed into both tools.
- **A project kit** you copy into any repo: a committed `.agent/` folder that is
  the cross-session, cross-tool memory.

## The loop

```
/start      resume from .agent/ state (cheap, no full repo scan)
...work...  decisions get captured into .agent/DECISIONS.md as they happen
/handover   rewrite STATE, append a session note, sweep for unlogged decisions
```

Commit the `.agent/` changes so the next session, in either tool, sees them.

## Layout

```
agent-kit/
  global/
    RULES.md            single source of the universal rules
    skills/             the three workflows: start, handover, decide
  project-kit/          copy into any repo to make it kit-aware
    AGENTS.md           canonical project context (template)
    CLAUDE.md           one line: @AGENTS.md
    .agent/             STATE.md, DECISIONS.md, sessions/
  install.ps1           Windows / PowerShell installer
  install.sh            macOS / Linux installer
```

## Install (global layer)

Windows (PowerShell 7+):

```powershell
pwsh ./install.ps1
```

macOS / Linux:

```bash
./install.sh
```

This generates `~/.claude/CLAUDE.md` and `~/.gemini/GEMINI.md` from
`global/RULES.md`, and copies the three skills into `~/.claude/skills/` and
`~/.gemini/skills/`. If you already have a global `CLAUDE.md` or `GEMINI.md` that
the kit did not write, it is backed up to `*.bak.<timestamp>` first. Re-run after
editing `global/RULES.md` or any skill. The installer overwrites skills named
`start`, `handover`, and `decide` in those skill dirs.

Why `~/.gemini`: Antigravity shares the Gemini config root. Its global rules file
is `~/.gemini/GEMINI.md` and its global skills live in `~/.gemini/skills/`. The
`~/.gemini/antigravity*` subfolders are Antigravity's own runtime stores
(Knowledge Items, conversations); the kit does not touch those.

## Adopt in a repo

Two modes:

1. **Fresh repo (canonical mode):** copy `project-kit/AGENTS.md`,
   `project-kit/CLAUDE.md`, and `project-kit/.agent/` into the repo root. Fill in
   AGENTS.md. AGENTS.md is the canonical context; CLAUDE.md is one line
   (`@AGENTS.md`).
2. **Repo that already has a rich CLAUDE.md (bridge mode):** add a short AGENTS.md
   that tells non-Claude tools to read CLAUDE.md, plus the `.agent/` folder. Keep
   the existing CLAUDE.md as the canonical manual. Use this when a repo already
   has a detailed manual you do not want to move.

## Subprojects (monorepos)

A repo can hold more than one `.agent/`. Give any subproject its own
`.agent/` folder (copy `project-kit/.agent/` into it) and the workflows scope
themselves automatically: `/start`, `/handover`, and `/decide` always use the
NEAREST `.agent/`, found from the current working directory walking up. Open
your session inside the subproject folder and only that subproject's state
loads; the repo-root `.agent/` keeps tracking the repo-wide picture without
leaking into focused work.

## Customize

`global/RULES.md` is the single source of the rules. The Core sections suit
anyone; the Preferences section at the end is for your own style. Edit it and
re-run the installer. Add your own workflows by dropping a directory with a
`SKILL.md` into `global/skills/` and re-running the installer.

## How it works across tools

| Layer | Claude Code | Antigravity | Single source |
|---|---|---|---|
| Project rules | `CLAUDE.md` | `AGENTS.md` | `AGENTS.md`; CLAUDE.md is `@AGENTS.md` |
| Global rules | `~/.claude/CLAUDE.md` | `~/.gemini/GEMINI.md` | `global/RULES.md` |
| Skills | `~/.claude/skills/` | `~/.gemini/skills/` | `global/skills/` |
| Memory | file-memory | Knowledge Items | committed `.agent/` markdown |

## License

MIT. See `LICENSE`.
