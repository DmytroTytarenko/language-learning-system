# 🇪🇸 Language Learning System — Replicable Template

**Version 1.1.0** · see [`CHANGELOG.md`](CHANGELOG.md) for what changed between versions.

A complete, AI-assisted language-learning system built around four tools:
**Fireflies** (lesson transcripts) + **Notion** (mistake & lesson tracking) +
**Anki** (spaced-repetition flashcards) + **Claude** (the orchestrator that ties them together).

This repository is a **template you clone to set up your own copy of the system.**
It was originally built for learning Spanish in Valencia, but nothing here is
Spanish-specific — it works for any language with a live teacher and recorded lessons.

---

## 🚀 How to start (read this first)

You don't need to understand the whole system before starting. The setup is **interactive** —
you'll paste this repo's link to Claude, and Claude will walk you through every step,
checking your progress and telling you exactly what to do when it can't do something itself.

**To begin:**

1. Open Claude (claude.ai or the desktop app).
2. Create a new Project (or open a chat) and paste this repository's GitHub link.
3. Say: **"Help me set up this language learning system from scratch."**
4. Follow along. Claude reads `SETUP.md` and guides you account by account, step by step.

> **Important boundary:** Claude can read this repo, generate your config files,
> create Anki decks and Notion databases *through connectors*, and check that things
> are wired correctly. But Claude **cannot** install desktop apps, run terminal commands
> on your machine, create accounts for you, or type passwords. For those, Claude gives you
> the exact command or click-path and waits while you do it, then verifies the result.

---

## 🧩 What the system does

After every lesson you say *"I had a lesson on [date]"* and Claude:

1. Finds the lesson transcript in **Fireflies** (by date, automatically).
2. Reads your teacher's shared notes doc (optional, via Google Drive).
3. Cross-checks your **Notion** "Recurring Mistakes" database so repeated errors get
   *incremented*, not duplicated.
4. Shows you a preview: summary, new vocabulary (sorted Core / Stretch / Skip),
   this lesson's mistakes (new vs. repeated), and any praise from your teacher.
5. After your OK, updates Notion and pushes flashcards into **Anki** with correct tags.

Weekly "batch" sessions and monthly level reviews are built in too.

---

## 📂 What's in this repo

| Path | What it is |
|------|------------|
| `README.md` | This file |
| `CHANGELOG.md` | Version history; what existing users must do per update |
| `SETUP.md` | The master interactive setup guide Claude follows with you |
| `PUSH_TO_GITHUB.md` | How to push your own filled-in copy back to GitHub |
| `docs/architecture.md` | Full technical architecture (connectors, tunnel, tagging) |
| `docs/methodology.md` | The learning method (Core/Stretch/Skip, mistake tracking) |
| `docs/troubleshooting.md` | Common problems and fixes |
| `templates/course-context.template.md` | Your learner/teacher/schedule context (fill in) |
| `templates/system-architecture.template.md` | Your infra details (fill in) |
| `templates/current-level.template.md` | Your starting level snapshot (fill in) |
| `templates/lesson-processing.prompt.md` | The prompt Claude uses to process a lesson |
| `templates/batch-session.prompt.md` | The prompt for weekly batch sessions |
| `templates/level-review.prompt.md` | The prompt for monthly level reviews |
| `templates/notion-databases.md` | Exact schema for the two Notion databases |
| `scripts/setup-check.sh` | A script that checks what's installed/configured |
| `.github/PROJECT_INSTRUCTIONS.md` | Paste-ready Claude Project instructions |

---

## ✅ Prerequisites (Claude will check these with you)

- A computer (the desktop Anki + tunnel parts assume **macOS**; notes for Windows/Linux included)
- A **Claude** account (Pro or higher recommended for Projects + connectors)
- Accounts you'll create during setup: **Fireflies**, **Notion**, **Anki/AnkiWeb**, **ankimcp.ai** (for the built-in Cloud Tunnel); **ngrok** is optional if you prefer to self-host the tunnel
- Optional: **Google account** if your teacher shares a Google Doc / uses Google Calendar

---

## 🔁 Replicating for someone else (e.g. a family member)

That's exactly what this template is for. On the second computer (or second profile),
you paste this same link to Claude and run the setup again with the *new* learner's details.
The two setups stay independent — separate Notion pages, separate Anki profiles/decks,
separate tunnels. `SETUP.md` has a dedicated **"Second learner"** section.

---

## 📜 License

MIT — use it, fork it, adapt it for any language.
