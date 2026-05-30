# Prompt: Process a Lesson

**Trigger:** the learner says "I had a lesson on {{DATE}}" (or "process the lesson").

Steps:
1. **Find transcript** via Fireflies, searching around {{DATE}} (try ±1 day if needed).
2. **Read the full transcript.** Work from raw text, not the auto-summary.
3. **Read the teacher's doc** (if configured) for {{DATE}}'s section.
4. **Query Notion:**
   - Recurring Mistakes — load current rows so repeats get *updated*, not duplicated.
   - Lessons Log — confirm {{DATE}} isn't already logged.
5. **Present in chat (not Notion yet):**
   - Short summary in the learner's language.
   - New words/phrases, each tagged **Core / Stretch / Skip** (see methodology).
   - This lesson's mistakes: new / repeated-from-[dates] / critical.
   - A diff vs. Recurring Mistakes: what to add, what to increment/advance.
   - Teacher praise, if present.
6. **Wait for OK.** Then update Notion:
   - Add a Lessons Log row (Type = Lesson).
   - Create new Recurring Mistakes (Status = New); update existing (increment Times Seen,
     add the date to Lessons, advance Status if warranted).
7. **Generate Anki cards** as a preview artifact. After OK, push via the Anki connector:
   - Core → active; Stretch → suspended, tagged `stretch` + `stretch_{{DATE}}`.
   - Apply required tags (`lesson_`, `batch_`), category, and any subtags.
   - Run a sync at the end.
8. **Quiet end checks** (mention only if actionable, 1–2 lines): level review due (≥28 days)?
   stretch ready to unsuspend (Core nearly exhausted + suspended stretch exists)?
