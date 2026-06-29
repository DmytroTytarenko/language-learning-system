# Technical Architecture

This describes how the four tools connect. Your filled-in copy lives in
`system-architecture.md` (from the template); this doc explains the *why*.

## Data sources

### Fireflies (lesson transcripts) — the primary source
- Records and transcribes lessons; Claude reaches it via the Fireflies connector.
- Tools Claude uses: a transcript search (by date/keyword) and a full-transcript fetch.
- Claude can find a lesson autonomously by date — no link needed.
- Paid tier enables multi-language auto-detect (important for non-English lessons).
- **Quirk:** the auto-generated summary hallucinates. Always work from the raw transcript.

### Teacher's shared doc (optional, secondary)
- If the teacher keeps a Google Doc, Claude reads it via Google Drive for extra context.
- The link typically lives in the Google Calendar event description.
- Teachers don't always write in it — treat it as supplementary, not authoritative.

### Calendar (optional)
- Google Calendar via connector: find lesson time, event description, attached doc link.

## Flashcards

### Anki Desktop + AnkiWeb
- Anki Desktop stores/edits/holds the deck; AnkiWeb sync mirrors it to mobile.
- Mobile access: AnkiWeb in Safari (free, immediate) or native AnkiMobile (one-time paid).
- ⚠️ Avoid "AnkiApp" and other lookalikes — not the real Anki, incompatible.

### Anki MCP integration
- Plugin: **Anki MCP** add-on, code `124672614`.
- The MCP server runs inside Anki, starts automatically, listens on `127.0.0.1:3141`.
- ~27 tools (list_decks, create_deck, add_note, add_notes, find_notes, notes_info,
  tag_management, get_fsrs_params, filtered_deck, etc.).
- We do **not** use AnkiConnect (a different add-on) — the Anki MCP plugin replaces it.

### Tunnel: Cloud Tunnel (built-in, recommended)
- Available in AnkiMCP Server v0.21.1+. Enabled via **"Connect Tunnel"** in the add-on config.
- OAuth device login through ankimcp.ai (separate account from AnkiWeb).
- URL format: `https://tunnel.ankimcp.ai/<id>` — stable between sessions for the same install.
- No Basic Auth credentials needed; the session token from device login handles authentication.
- The tunnel stays active while Anki Desktop is open and reconnects automatically on restart.

### Tunnel: ngrok (alternative)
- Use if you prefer to self-host the tunnel or already have ngrok set up.
- ⚠️ **v0.21.1+ breaking change:** `--host-header=rewrite` is now required. Without it,
  every request fails with **421 Misdirected Request**.
- Authtoken stored locally in ngrok's config; never commit it.
- A reserved static domain keeps the URL stable between sessions.
- Protected with Basic Auth (a username + a password kept in a password manager).
- Run command:
  ```bash
  ngrok http 3141 --url={{NGROK_DOMAIN}} --host-header=rewrite --basic-auth="{{TUNNEL_USER}}:{{TUNNEL_PASSWORD}}"
  ```
- Free-tier limits (tens of thousands of requests/month) are far more than this use needs.

### Connecting in Claude
- Add a custom connector in Settings → Connectors.
- **Cloud Tunnel:** paste `{{TUNNEL_URL}}` directly — no credentials in the URL.
- **ngrok:** Claude doesn't take separate Basic-Auth fields, so credentials embed in the URL:
  `https://{{TUNNEL_USER}}:{{TUNNEL_PASSWORD}}@{{NGROK_DOMAIN}}`
- Changing the ngrok Basic-Auth password means re-creating the connector (Disconnect → re-add),
  because Claude doesn't let you edit an existing connector's URL.

## Card tagging rules

Every note gets tags so Claude can identify which lesson/batch it belongs to and find
the last processed lesson when you say "add the new stuff."

**Required**
- `lesson_YYYY-MM-DD` — the lesson(s) where the word/error appeared (both dates if it recurred).
- `batch_YYYY-MM-DD` — the date the card was pushed into Anki (always exactly one).

**Category (pick one)**
- `vocab`, `grammar`, `error`, `expression`, `collocation`

**Optional thematic subtags**
- `recurring_error`, `anglicism`, `preposition`, `articles`, `pronouns`,
  tense tags (e.g. `indefinido` / `perfecto` / `imperfecto`), `irregular`, plus any
  language/region-specific context tag you want.

**Optional source tags**
- `source_fireflies`, `source_doc`, `needs_review` (Claude unsure — ask the human).

**Core/Stretch split**
- Stretch cards are pushed but immediately suspended, tagged `stretch` + `stretch_<date>`.
- "Unsuspend the stretch from [date]" finds them by tag and activates them.

## Batch-session workflow (weekly or on request)

1. Open Anki Desktop (plugin auto-starts; Cloud Tunnel connects automatically).
   If using ngrok (Option B): run the tunnel command in a terminal and leave it open.
2. Tell Claude one of: "Do the batch for this week" / "I had a lesson on [date]" / "Add the new stuff."
3. Claude: fetches the transcript, reads the teacher doc if present, checks existing
   notes by tag to avoid duplicates, shows a card preview, and on OK runs `add_notes`
   with correct tags, then runs a sync.
4. When done: quit Anki. (Cloud Tunnel stops with Anki; Ctrl-C the ngrok terminal if using Option B.)

## What we deliberately do NOT do
- Don't duplicate transcripts into Notion/Drive — they live in Fireflies, read on demand.
- Don't try to drill cards inside the Claude chat — that's Anki's job.

## Gotchas
- First tool call after re-creating a connector may return `Session terminated` — normal,
  recovers on the next call.
- ngrok (Option B): add header `ngrok-skip-browser-warning: true` for manual curl checks
  (Claude as an MCP client already sends correct headers).
- ngrok (Option B) + AnkiMCP v0.21.1+: omitting `--host-header=rewrite` causes 421 errors on every request.
- Anki shows 20 new cards/day by default — a healthy pace; raise it via Custom Study only if needed.
