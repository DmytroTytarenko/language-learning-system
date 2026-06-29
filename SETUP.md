# 🛠️ Interactive Setup Guide

**This file is written for Claude to follow with the user, step by step.**
If you are Claude and the user just shared this repo and asked to set up the system,
start at Phase 0 and walk them through each phase. Do one phase at a time. After each
step that the user must do themselves (install an app, create an account, run a command),
**wait for them to confirm**, then verify before moving on.

If you are a human reading this: you can just paste the repo link to Claude and say
*"Help me set this up."* You don't have to read this whole file.

---

## ⚠️ The hard boundary (Claude, internalize this)

You **can**: read this repo, create/fill config files, create Notion databases and Anki
decks through connectors, search Fireflies, verify wiring, and give exact instructions.

You **cannot** and must **direct the user to do themselves**:
- Installing desktop software (Anki, ngrok, Homebrew)
- Running terminal commands on their machine
- Creating accounts on any service
- Entering passwords, payment info, or 2FA codes
- Authorizing/connecting connectors inside Claude's settings (the user clicks "Connect")

When you hit one of these, give the **exact** command or click-path, then say
"Run this and tell me what you see," and verify the output they report back.

Never claim you've done something on their machine that you can't do. There has been
real past confusion here (people expect Claude to push to GitHub or run `git` directly —
you cannot in this chat context). Be explicit about the boundary up front.

---

## Phase 0 — Orientation (2 min)

Tell the user, briefly:
- What the system does (one paragraph).
- That setup takes ~45–90 min, mostly account creation.
- That they'll need: this computer, a Claude account, and ~30 min of teacher-lesson
  recordings to test with later.
- Ask: **"Are you setting this up for yourself, or replicating it for someone else
  (e.g. a partner)?"** — if the latter, also read the "Second learner" section at the bottom.

Then ask which OS they're on (macOS / Windows / Linux). The transcript+Notion+Claude
parts are OS-independent; only the Anki-tunnel part differs.

---

## Phase 1 — Claude Project (5 min)

1. Have the user create a new **Project** in Claude (left sidebar → Projects → New).
2. Have them open `.github/PROJECT_INSTRUCTIONS.md` from this repo, copy its contents,
   and paste it into the Project's "Instructions" / custom instructions field.
   (Claude: offer to print the contents so they can copy directly from chat.)
3. Later (Phase 6) they'll upload the three filled-in context files into the Project.

---

## Phase 2 — Fireflies: lesson transcripts (10 min)

**Why:** Fireflies records and transcribes lessons and exposes them to Claude via a connector.

1. User creates a Fireflies account at fireflies.ai (they do this — you cannot create accounts).
2. Have them add the Fireflies notetaker to their lesson calls (Google Meet / Zoom).
   For Google Meet, Fireflies joins via calendar integration or the Meet add-on.
3. **Connect Fireflies to Claude:** user goes to Claude → Settings → Connectors →
   browse/add **Fireflies**, clicks Connect, and authorizes. (User clicks; you can't.)
4. **Verify:** once connected, you (Claude) call the Fireflies tool to list recent
   transcripts. If the user has at least one recorded call, confirm you can see it by date.
   If they have none yet, that's fine — note it and move on; you'll test in Phase 8.

**Notes carried over from the original setup:**
- A paid tier (~$19/mo) gives multi-language auto-detect, which matters for non-English lessons.
- Fireflies' auto-summary tends to hallucinate — **work from the raw transcript**, not the summary.

---

## Phase 3 — Notion: mistake & lesson tracking (15 min)

**Why:** Notion holds the two living databases — Recurring Mistakes and Lessons Log.

1. User creates/has a Notion account.
2. **Connect Notion to Claude:** Claude → Settings → Connectors → Notion → Connect → authorize.
3. Have the user create one parent page (e.g. "🇪🇸 [Language]") and give Claude access to it.
4. **You (Claude) create the two databases** inside that page via the Notion connector,
   using the exact schema in `templates/notion-databases.md`. Create them, then report back
   the database URLs and data-source IDs so they can be pasted into the context files.
   - If the connector can't create databases in this workspace, fall back: give the user
     the schema and have them create the two databases manually, then read them back to
     capture the IDs.
5. **Verify:** read both databases back and confirm the fields match the schema.

---

## Phase 4 — Anki + AnkiWeb: flashcards (15 min)

**Why:** Anki stores and schedules the flashcards. Claude pushes cards in via an MCP plugin.

1. User installs **Anki Desktop** (apps.ankiweb.net) — user does this.
2. User creates a free **AnkiWeb** account (ankiweb.net) and signs in inside Anki Desktop,
   then runs one Sync to confirm the link.
3. User installs the **Anki MCP** add-on:
   Anki → Tools → Add-ons → Get Add-ons → paste code **`124672614`** → restart Anki.
   - ⚠️ Do **not** install "AnkiApp" or lookalikes — not real Anki, incompatible.
   - The MCP server starts automatically with Anki on `127.0.0.1:3141`.
4. **Mobile (optional):** AnkiWeb in Safari is free and works immediately. Native
   **AnkiMobile (iOS, ~$24.99 one-time)** is nicer (offline, gestures) — buy only after
   a week if Safari feels clunky. AnkiDroid (Android) is free.

---

## Phase 5 — Anki tunnel (15 min)

**Why:** Claude's connector reaches the Anki MCP server (on localhost) through a tunnel.
AnkiMCP Server v0.21.1+ ships a built-in Cloud Tunnel — that is **Option A** and the
recommended path. ngrok (**Option B**) still works but requires an extra flag.

### Option A — Cloud Tunnel (recommended)

1. With Anki Desktop open, go to **Tools → Add-ons → AnkiMCP Server → Config**
   (or click the AnkiMCP toolbar button, depending on your version).
2. Click **"Connect Tunnel"**. The plugin opens a browser tab for OAuth device login —
   sign in with your **ankimcp.ai account** (separate from AnkiWeb) when prompted.
   If you don't have one yet, register at ankimcp.ai first.
3. After login, the plugin shows a tunnel URL of the form
   `https://tunnel.ankimcp.ai/<id>` — copy it.
4. **Connect to Claude:** Claude → Settings → Connectors → Add custom connector → paste the URL.
   No username or password needed — authentication is handled by the device login session.
5. **Verify:** with Anki Desktop open + tunnel active, you (Claude) call `list_decks`.
   Then create the main deck (e.g. "Spanish").
   - First call after adding the connector may return `Session terminated` — normal, retry once.

The tunnel stays active while Anki Desktop is open and reconnects automatically on restart.
The URL (`{{TUNNEL_URL}}`) stays the same between sessions for the same install — save it
in `system-architecture.template.md` during Phase 6.

### Option B — ngrok (alternative)

Use this only if you prefer to self-host the tunnel or already have ngrok set up.

> ⚠️ **v0.21.1+ breaking change:** AnkiMCP Server now enforces strict Host header matching.
> You **must** add `--host-header=rewrite` to the ngrok command, or all requests will fail
> with **421 Misdirected Request**.

1. Install ngrok (ngrok.com/download; on macOS `brew install ngrok` if you have Homebrew).
2. Create a free ngrok account, copy your authtoken, and run:
   `ngrok config add-authtoken <TOKEN>` — user does this; Claude can't see the token.
3. Reserve a **static domain** (ngrok dashboard → Domains) so the URL doesn't change.
4. **Run the tunnel** (user runs in a terminal, leave it open during sessions):
   ```bash
   ngrok http 3141 --url={{NGROK_DOMAIN}} --host-header=rewrite --basic-auth="{{TUNNEL_USER}}:{{TUNNEL_PASSWORD}}"
   ```
   Pick a username + password for Basic Auth and store them in a password manager.
5. **Connect to Claude:** Claude → Settings → Connectors → Add custom connector.
   Claude doesn't support separate Basic-Auth fields, so embed credentials in the URL:
   ```
   https://{{TUNNEL_USER}}:{{TUNNEL_PASSWORD}}@{{NGROK_DOMAIN}}
   ```
6. **Verify:** same as Option A — `list_decks` with Anki open.

**Windows/Linux note:** same flow for both options. Homebrew is macOS-only — use the ngrok installer.

---

## Phase 6 — Fill in the context files (10 min)

Copy each `templates/*.template.md` to a working file, and you (Claude) interview the
user to fill the placeholders (`{{LIKE_THIS}}`):

- `course-context.template.md` → learner, teacher, schedule, source-of-truth links
- `system-architecture.template.md` → their tunnel URL, ports, tags, connector details
- `current-level.template.md` → honest starting level snapshot

Ask the questions conversationally, one cluster at a time. When done, have the user
**upload the three filled files into their Claude Project** (Phase 1).

---

## Phase 7 — Wire the prompts (5 min)

The Project instructions reference the workflow. Confirm the user knows the three commands:
- **"I had a lesson on [date]"** → lesson processing (`templates/lesson-processing.prompt.md`)
- **"Do the batch for this week"** → batch session (`templates/batch-session.prompt.md`)
- **"Review my level"** → monthly review (`templates/level-review.prompt.md`)

These prompts are already encoded in the Project instructions; the files are the reference.

---

## Phase 8 — End-to-end test (10 min)

1. Make sure Anki Desktop is open and the tunnel is active (Cloud Tunnel connects automatically; for ngrok, start it in a terminal first).
2. Have the user say **"I had a lesson on [a real recorded date]."**
3. You run the full lesson-processing flow: find transcript → read it → check Notion →
   show preview (summary, vocab Core/Stretch/Skip, mistakes) → on OK, update Notion +
   push cards to Anki with tags → run a sync.
4. Confirm cards appear in Anki and rows appear in Notion. 🎉

If anything fails, see `docs/troubleshooting.md`.

---

## Updating an existing install (when the template gets a new version)

The system has a version (top of `README.md`) and a `CHANGELOG.md`. Two situations:

**A) Fresh setup from the latest version** — just follow Phases 0–8 above. You always
get the current logic.

**B) Already using it, a new version is out** — you do *not* redo setup. Instead:
1. Open `CHANGELOG.md` and read entries newer than your installed version.
2. Do only each entry's **"Action for existing installs"** line. Typical actions:
   - Re-paste `.github/PROJECT_INSTRUCTIONS.md` into your Claude Project (if the
     orchestration logic changed).
   - Add/rename a field in a Notion database (if the schema changed) — Claude can do
     this for you via the connector; just ask.
   - Re-copy a changed `templates/*.prompt.md` reference (if a workflow changed).
3. Nothing about your accounts, tunnel, decks, or existing cards is touched.

If you maintain your own filled-in copy: pull the new template, re-apply your
`{{placeholders}}`, and re-push (see `PUSH_TO_GITHUB.md`). Or just tell Claude
"update my system to the latest logic" and it walks you through the diff.

---

## Second learner (replicating for a partner)

Three options, cheapest first:
1. **Same computer, separate Anki profile** (Anki → File → Switch Profile), separate
   AnkiWeb account, one tunnel reused. Free.
2. **AnkiWeb in Safari on their own tablet** — free, independent of your laptop; you
   prepare their content via profile switching on your desktop.
3. **Full separate install on their device** — repeat Phases 4–5 on that machine.

For any option, create a **separate Claude Project** for them with their own
context files, a separate Notion parent page, and (if option 3) their own tunnel/domain.
Run this same SETUP.md from Phase 1 with their details.
