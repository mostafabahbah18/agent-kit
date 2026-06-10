---
name: decide
description: Append a timestamped, locked-in decision (the decision plus the WHY) to .agent/DECISIONS.md so it is never re-derived or re-litigated. Use when a real choice is settled, or invoke as /decide <text>.
---

# /decide: record a locked-in decision

Goal: make a settled decision permanent and portable across sessions and tools.

Entry format (append to `.agent/DECISIONS.md`, newest at the bottom):

```
## YYYY-MM-DD: <one-line decision>
**Decision:** <what was decided, stated as fact>
**Why:** <the reasoning, evidence, or source>
**Scope:** <where it applies, if not obvious>
```

Steps:

1. If invoked as `/decide <text>`, use that as the decision. Otherwise summarize
   the decision under discussion.
2. Ask for or infer the WHY. A decision without a why is not durable; prompt for
   it if missing.
3. Use the date the user states. Do not invent a date.
4. Append only. Never edit or delete prior entries. If a decision is superseded,
   add a NEW entry that says so and references the old one.
