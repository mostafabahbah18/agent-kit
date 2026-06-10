# agent-kit

A small, tool-agnostic operating layer for research work. It makes every project
remember itself across sessions and across tools (Claude Code and Antigravity),
and it saves tokens by resuming from a few committed files instead of re-reading
the whole repo.

The idea borrowed from apexyard: keep governance and state as plain markdown in
git, separate from the AI tool, so you can swap the tool without losing the system.

## Layout

```
agent-kit/
  global/
    RULES.md            single source of the universal rules
    skills/             the three workflows: start, handover, decide
  project-kit/          drop into any repo to make it kit-aware
    AGENTS.md           canonical project context (template)
    CLAUDE.md           one line: @AGENTS.md
    .agent/             STATE.md, DECISIONS.md, sessions/
  install.ps1
```

## Install (global layer)

```
pwsh ./install.ps1
```

This generates `~/.claude/CLAUDE.md` and `~/.gemini/GEMINI.md` from
`global/RULES.md`, and copies the three skills into `~/.claude/skills/` and
`~/.gemini/skills/`. Re-run after editing `global/RULES.md` or any skill.

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
   the existing CLAUDE.md as the canonical manual. This is how EGYMOD adopts it.

## The loop

```
/start      resume from .agent/ state (cheap, no repo scan)
...work...  decisions get captured into .agent/DECISIONS.md as they happen
/handover   rewrite STATE, append a session note, sweep for unlogged decisions
```

Commit the `.agent/` changes so the next session, in either tool, sees them.

## Why committed markdown, not the tools' native memory

Claude Code's file-memory and Antigravity's Knowledge Items do not cross the tool
boundary. A `.agent/DECISIONS.md` committed in one tool is read verbatim by the
other. The native memory stores are useful caches, but the committed markdown is
the source of truth.
