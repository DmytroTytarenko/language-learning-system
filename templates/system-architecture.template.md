# Technical Architecture (your filled-in copy)

> Copy to `system-architecture.md`, fill `{{PLACEHOLDERS}}`, upload into the Project.
> **Do not put a real password in a public repo** — keep `{{TUNNEL_PASSWORD}}` as a placeholder
> and store the real one in your password manager.

## Data sources

### Fireflies (transcripts) — primary
- **Plan:** {{FIREFLIES_PLAN}}
- **Connector:** connected in Claude Settings → Connectors.
- **Search:** autonomous by date; summary hallucinates — use raw transcript.

### Teacher's doc (optional)
- **Doc ID / link:** {{TEACHER_DOC}}
- **Access:** Google Drive connector. Supplementary, not primary.

### Calendar (optional)
- **Access:** Google Calendar connector. For lesson time + doc link.

## Flashcards

### Anki Desktop + AnkiWeb
- **Installed on:** {{COMPUTER_OS}}
- **AnkiWeb account:** {{ANKIWEB_EMAIL}} (sync verified: {{ANKIWEB_SYNC_DATE}})
- **Main deck:** {{DECK_NAME}}
- **Mobile:** {{MOBILE_CHOICE}}  (AnkiWeb/Safari, AnkiMobile, AnkiDroid)

### Anki MCP plugin
- Add-on code: `124672614` (Anki MCP). Auto-starts with Anki on `127.0.0.1:3141`.
- Not using AnkiConnect.

### Tunnel: Cloud Tunnel (Option A — recommended)
- **Tunnel URL:** {{TUNNEL_URL}}
- **Auth:** ankimcp.ai account (OAuth device login — separate from AnkiWeb).
- **Connector in Claude:** paste `{{TUNNEL_URL}}` as a custom connector — no credentials needed.
- Tunnel is active while Anki Desktop is open; URL is stable across sessions.

### Tunnel: ngrok (Option B — alternative)
- **Static domain:** {{NGROK_DOMAIN}}
- **Authtoken:** stored locally in ngrok config (never committed).
- **Basic Auth user:** {{TUNNEL_USER}} / password: {{TUNNEL_PASSWORD}} (in password manager)
- **Run command** (⚠️ `--host-header=rewrite` required for v0.21.1+, else 421 error):
  ```bash
  ngrok http 3141 --url={{NGROK_DOMAIN}} --host-header=rewrite --basic-auth="{{TUNNEL_USER}}:{{TUNNEL_PASSWORD}}"
  ```
- **Connector in Claude** (credentials embedded in URL):
  `https://{{TUNNEL_USER}}:{{TUNNEL_PASSWORD}}@{{NGROK_DOMAIN}}`
- Changing the password = re-create the connector (Disconnect → re-add).

## Card tagging rules
Required: `lesson_YYYY-MM-DD`, `batch_YYYY-MM-DD`.
Category (one): `vocab` / `grammar` / `error` / `expression` / `collocation`.
Optional subtags: `recurring_error`, `anglicism`, `preposition`, `articles`, `pronouns`,
tense tags, `irregular`, `{{REGION_CONTEXT_TAG}}`.
Source: `source_fireflies`, `source_doc`, `needs_review`.
Stretch: pushed suspended, tagged `stretch` + `stretch_<date>`.

## Batch workflow
1. Open Anki Desktop. Cloud Tunnel (Option A) connects automatically.
   ngrok (Option B): run the tunnel command in a terminal and leave it open.
2. Tell Claude: "Do the batch for this week" / "I had a lesson on [date]" / "Add the new stuff."
3. Claude fetches transcript → reads doc → checks tags for dupes → previews cards →
   on OK runs add_notes with tags → syncs.
4. Quit Anki. (Cloud Tunnel stops with Anki; Ctrl-C ngrok terminal if using Option B.)

## Gotchas
- First call after re-adding connector → `Session terminated` is normal; retry once.
- ngrok (Option B): add header `ngrok-skip-browser-warning: true` for manual curl checks.
- ngrok (Option B) + AnkiMCP v0.21.1+: omitting `--host-header=rewrite` causes 421 errors.
- New-cards/day default is 20 — leave it unless you want a faster pace.

## Open questions for this learner
- {{OPEN_QUESTIONS}}  (e.g. one deck vs. split by type; mobile app purchase; etc.)
