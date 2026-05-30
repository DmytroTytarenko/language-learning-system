# Troubleshooting

## Anki / MCP / ngrok

**`Session terminated` on the first call after adding the connector.**
Normal. The MCP session re-establishes on the next call. Retry once.

**Claude says it can't reach Anki.**
Check, in order: (1) Anki Desktop is open; (2) the Anki MCP add-on is installed
(Tools → Add-ons should list it) and Anki was restarted after install; (3) the ngrok
terminal is still running and shows the tunnel online; (4) the connector URL in Claude
matches your current domain *and* current Basic-Auth password.

**Changed the Basic-Auth password and now it fails.**
Claude can't edit an existing connector's URL. Disconnect it and add a new custom
connector with the updated `https://USER:NEWPASSWORD@your-domain.ngrok-free.dev`.

**ngrok shows a warning/interstitial page on curl tests.**
Add the header `ngrok-skip-browser-warning: true`. Claude as an MCP client already
sends correct headers, so this only affects your manual curl checks.

**Cards aren't showing up to review.**
Anki defaults to 20 new cards/day. The rest wait by design. Raise via Custom Study →
"Increase today's new card limit" only if you genuinely want a faster pace.

**Pushed a card but it didn't appear.**
Confirm the deck name matches exactly, then run a sync. Check for a duplicate-blocked
note (Anki skips exact duplicates of the first field).

## Fireflies

**Claude can't find a lesson.**
Confirm the call was actually recorded (it appears in your Fireflies dashboard) and you
gave the right date. Try a date range of ±1 day. If the lesson is very recent, give
Fireflies a few minutes to finish processing.

**The summary looks wrong.**
Expected — the auto-summary hallucinates. Claude works from the raw transcript, not the summary.

**Wrong language detected / poor quality.**
Multi-language auto-detect is a paid-tier feature. On the free tier, non-English lessons
transcribe poorly.

## Notion

**Claude can't create the databases.**
Make sure the parent page is shared with the Notion connector, and that the connector has
write access. Fallback: create the two databases by hand from `templates/notion-databases.md`
and have Claude read them back to capture the IDs.

**Duplicate mistake rows piling up.**
Claude should read existing Recurring Mistakes before writing, and increment rather than
insert. If duplicates appear, ask Claude to dedupe by the Mistake title.

## Claude / connectors

**A connector won't connect.**
Disconnect and re-add. Connecting/authorizing is something only the user can click —
Claude can't do it for you.

**Claude claims it pushed to GitHub / ran a command.**
It can't, in this chat context. GitHub pushes and terminal commands are run by you;
Claude provides the exact commands and reads back your results. See `PUSH_TO_GITHUB.md`.
