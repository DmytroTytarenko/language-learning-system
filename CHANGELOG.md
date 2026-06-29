# Changelog

All notable changes to the system's **logic and infrastructure** are recorded here.
This file is how an existing user knows what changed and whether they need to act.

Format: [version] — date. Each entry says what changed and, if relevant, an
**"Action for existing installs"** line telling current users what to do to adopt it.

The version is also shown in `README.md`. When the logic changes, bump the version,
add an entry here, and re-push (see `PUSH_TO_GITHUB.md`).

---

## [1.1.0] — 2026-06-29

- Migrated Anki tunnel from ngrok to the built-in **Cloud Tunnel** in AnkiMCP Server v0.21.1+
  (OAuth device login via ankimcp.ai, URL `https://tunnel.ankimcp.ai/<id>`, no credentials needed).
- Cloud Tunnel is now the recommended Option A in SETUP Phase 5; ngrok remains as Option B.
- Added `--host-header=rewrite` requirement for ngrok with AnkiMCP v0.21.1+ (without it,
  all requests fail with 421 Misdirected Request).
- Updated `docs/architecture.md`, `docs/troubleshooting.md`, `templates/system-architecture.template.md`
  to reflect two-option tunnel setup.
- Unified `{{TUNNEL_URL}}` placeholder for Cloud Tunnel URL across all docs.

**Action for existing installs:** If you are on ngrok and want to stay there, add
`--host-header=rewrite` to your ngrok command immediately (prevents 421 errors on v0.21.1+).
To switch to Cloud Tunnel: click "Connect Tunnel" in the AnkiMCP Server add-on config,
complete the ankimcp.ai OAuth login, copy the new URL, disconnect your old connector in Claude,
and add a new custom connector with `{{TUNNEL_URL}}` — no credentials needed.

---

## [1.0.0] — 2026-05-29

Initial public template.

- Four-tool architecture: Fireflies (transcripts) + Notion (mistake/lesson tracking) +
  Anki (cards via MCP add-on `124672614` + ngrok tunnel) + Claude (orchestrator).
- Interactive `SETUP.md` (8 phases) with a "Second learner" section.
- Methodology: Core/Stretch/Skip bucketing, mistake lifecycle, monthly level reviews,
  quiet end-of-processing checks.
- Templates with `{{PLACEHOLDER}}` syntax for course context, architecture, level.
- Paste-ready Claude Project instructions.
- `setup-check.sh`, `PUSH_TO_GITHUB.md`, troubleshooting.

**Action for existing installs:** none (first version).

<!--
TEMPLATE for future entries — copy this when you change the logic:

## [1.1.0] — YYYY-MM-DD

- <what changed in the logic/infrastructure>

**Action for existing installs:** <e.g. "Re-paste .github/PROJECT_INSTRUCTIONS.md into
your Claude Project" / "Add a new field X to the Notion Lessons Log" / "No action needed —
only affects new installs.">
-->
