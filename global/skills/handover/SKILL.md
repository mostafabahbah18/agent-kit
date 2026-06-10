---
name: handover
description: Close a work session by rewriting .agent/STATE.md, appending a dated note to .agent/sessions/, and sweeping the conversation for decisions not yet logged in .agent/DECISIONS.md. Use at the end of every session.
---

# /handover: save session state for next time

Goal: leave the repo so the next session, in any tool, can resume from `/start`
alone.

Steps:

1. Rewrite `.agent/STATE.md`: Where we are, Next steps, Open questions, Active
   plan (link). Keep it current and short. It is a summary, not a log.
2. Append a dated note `.agent/sessions/YYYY-MM-DD-<slug>.md` capturing what
   changed this session and what is next. Use the date the user states. Do not
   invent a date.
3. Sweep the conversation for decisions or locked-in facts NOT yet in
   `.agent/DECISIONS.md`. List them and offer to append each (in the /decide
   format). Append the ones the user confirms.
4. Never write protected or sensitive data into any `.agent/` file. Decisions,
   status, and aggregates only.
5. Report the files you touched so the user can commit.
