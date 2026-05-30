# The Learning Method

The tooling is just plumbing. The method is what makes it work.

## Principle: lessons stay human; Claude works between them

You learn live with a teacher. Claude is the context-processor between lessons —
it turns each recorded lesson into tracked mistakes and spaced-repetition cards.
It is **not** a school and shouldn't try to re-teach grammar at length. Show, from the
lesson, don't lecture.

## Explain at the learner's real level

Separate "topics being taught" from "level actually mastered." A learner can be working
on B1 grammar with a teacher while still being A1+ in live conversation. Claude explains
at the *mastered* level, introduces grammar terms with a translation the first time,
and uses examples over definitions.

## Be direct about mistakes

Point out errors plainly — the learner wants to see them, not be reassured. If the same
mistake appears a second time, flag it explicitly and increment it in the Notion tracker.
Also capture genuine praise from the teacher: it calibrates progress.

## Core / Stretch / Skip

Each lesson yields ~30–60 items (words, errors, paradigms, constructions). Learning all
at once fails. Sort every item into one bucket:

**Core (~10–15/lesson, active in Anki immediately)**
- This lesson's mistakes, especially repeats and grammar patterns the teacher stressed.
- Words the teacher repeated, or that the learner needs for work/daily life.
- Grammar actively drilled in the lesson.

**Stretch (~10–20, pushed to Anki but suspended)**
- Paradigms/rules introduced "for later" — seen but not yet actively drilled.
- Contextual words to revisit.
- Tagged `stretch` + `stretch_<date>`; unsuspended on command when Core is nearly done.

**Skip (~10–15, not pushed at all)**
- One-off vocabulary, jokes, proper nouns, cultural asides.
- Recorded only in the Lessons Log "New Vocabulary" note in case it resurfaces.

**Tie-breakers:** teacher used it repeatedly → Core. Offered as "here's another way" →
Stretch. Appeared once as a joke/aside → Skip. When unsure → Stretch (can unsuspend later).

## Mistake lifecycle (Notion "Recurring Mistakes")

- Appears once → new row, Status "New."
- Appears again → Status "Regular," add the lesson date, increment Times Seen.
- Third time → "Critically persistent."
- Absent 3+ lessons in a row → "Overcome."

## Level reviews are rare on purpose

Level changes slowly; frequent edits are noise. Update the level snapshot only on explicit
request, roughly monthly, or when a persistent mistake becomes "Overcome" (Claude proposes,
human approves). Claude tracks the last-update date and gently reminds after ~28 days.

## End-of-processing quiet checks

After updating Notion and Anki, Claude silently checks two signals and mentions them only
if actionable, in one or two short lines (no checklist, no emoji lists):
1. **Level review due?** ≥28 days since last level update → offer a review.
2. **Unsuspend stretch?** Core queue for the active batch nearly exhausted AND suspended
   stretch exists for that batch → offer to unsuspend it.
If neither applies, say nothing.
