# Notion Databases — Exact Schema

Two databases live inside one parent page. Claude creates them via the Notion connector
(or you create them by hand and Claude reads back the IDs).

## 1) Recurring Mistakes

One row per mistake. Repeats update the row; they don't add new rows.

| Field | Type | Values / notes |
|-------|------|----------------|
| Mistake | Title | Short description of the error |
| Status | Select | New / Regular / Critically persistent / Overcome |
| Category | Select | vocab / grammar / error / expression / collocation |
| Lessons | Multi-select | Lesson dates where it appeared (YYYY-MM-DD) |
| First Seen | Date | First appearance |
| Last Seen | Date | Most recent appearance |
| Times Seen | Number | Increment on each repeat |
| In Anki | Checkbox | True once a card exists |
| Anki Tags | Multi-select | Tags applied to the card(s) |
| Notes | Rich text | Examples, explanation, mnemonic |

**Lifecycle:** New → (repeat) Regular, add date, +1 Times Seen → (3rd time) Critically
persistent → (absent 3+ lessons) Overcome.

## 2) Lessons Log

One row per lesson, batch session, infra event, or monthly level review.

| Field | Type | Values / notes |
|-------|------|----------------|
| Lesson | Title | e.g. "Lesson 2026-05-19" |
| Date | Date | |
| Type | Select | Lesson / Batch session / Infrastructure / Level review |
| Duration | Text or Number | minutes |
| Focus | Rich text | What the lesson centered on |
| Key Mistakes | Rich text | Summary of this lesson's errors |
| New Vocabulary | Rich text | Includes Skip items (recorded here, not in Anki) |
| Praise | Rich text | Teacher praise, if any |
| Transcript URL | URL | Fireflies link |
| Doc Section | Text | Pointer into the teacher doc |
| Anki Status | Select | Pending / Pushed / N/A |
| Batch Tag | Text | `batch_YYYY-MM-DD` |

## After creating
Record the two database URLs and their data-source IDs in `course-context.md`
(`{{NOTION_*}}` placeholders).
