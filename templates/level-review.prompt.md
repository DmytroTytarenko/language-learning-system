# Prompt: Monthly Level Review

**Trigger:** "Review my level" / "update the level" — or proactively after ~28 days
(remind only; don't auto-edit).

1. Read `current-level.md` header "Last updated"; compute days since.
2. Review Recurring Mistakes over the period (filter by Last Seen):
   - What moved to "Overcome," what's "Critically persistent."
3. Read Lessons Log → Focus to see what the teacher covered systematically.
4. Propose a **diff** to `current-level.md`:
   - Add to "mastered," update "in progress," "weak spots," "strengths."
5. On approval, also:
   - Update the header: "Last updated" = today; "Next review" = today + 28 days.
   - Add a Lessons Log row, Type = "Level review."
6. The learner updates the actual `current-level.md` file in their Project (Claude can't
   edit Project files directly — it provides the new content to paste).

**Special case:** if a persistent mistake just became "Overcome," that's a signal part of
the level snapshot may be stale — offer a review (don't force one).
