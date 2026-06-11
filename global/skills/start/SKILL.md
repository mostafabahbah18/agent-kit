---
name: start
description: Open a work session by loading committed state (.agent/STATE.md, .agent/DECISIONS.md, and the active plan) and summarizing where things stand, WITHOUT re-scanning the whole repo. Use at the beginning of every session.
---

# /start: resume a session from committed state

Goal: reconstruct context cheaply and state where we are, what is next, and what
is already decided. Do NOT scan the codebase first.

Scope resolution (monorepos and subprojects): the active `.agent/` is the
NEAREST one, found by checking the current working directory first and then
walking up parent directories. The first `.agent/` found is the ONLY scope you
load. If a parent directory also has a `.agent/`, do not read or summarize it;
at most note in one line that a parent scope exists. The user is working in the
nearest scope; parent-level status is noise here.

Steps:

1. Resolve the nearest `.agent/` as above, then read its `STATE.md` (current
   status, next steps, open questions, active plan link). If no `.agent/`
   exists anywhere up the tree, say so and offer to create one from the kit
   template in the current directory.
2. Read `DECISIONS.md` from the same `.agent/` (locked-in decisions plus why).
   Treat every entry as in force. Do not re-litigate.
3. If STATE links an active plan, read only that plan file.
4. Summarize in 5 to 10 lines: where we are, the next planned action, open
   questions, and any decisions that constrain the work.
5. Stop and wait. Only read further files once the user names a task.

Token discipline: the three state files plus one plan are enough to resume.
Reading the repo wholesale defeats the purpose.
