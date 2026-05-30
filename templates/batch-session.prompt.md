# Prompt: Weekly Batch Session

**Trigger:** "Do the batch for this week" / "Add the new stuff."

1. Find the most recent `batch_*` tag in Anki to learn the last processed date.
2. Identify lessons after that date (via Fireflies, by date).
3. For each unprocessed lesson, run the lesson-processing flow (transcript → doc →
   Notion check → preview → OK → Notion update → cards).
4. Use one `batch_YYYY-MM-DD` tag (today) across all cards pushed in this session.
5. Add a Lessons Log row with Type = "Batch session."
6. Set "In Anki" = true and fill "Anki Tags" on the Recurring Mistakes rows you carded.
7. Sync at the end. Run the quiet end checks.

**Prereqs the learner must have done:** Anki Desktop open + ngrok tunnel running.
If a tool call returns `Session terminated`, retry once.
