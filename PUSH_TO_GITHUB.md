# 📤 Pushing your copy to GitHub

> **Boundary reminder:** Claude cannot run `git` or push to GitHub from this chat.
> You run these commands yourself on your Mac. Claude can write the exact commands,
> read errors you paste back, and tell you the fix — but the terminal is yours.

You'd do this if you've filled in your own context files and want your personalized
copy in your own GitHub repo (e.g. to share with a family member).

---

## One-time: tools

- Git: macOS usually has it (`git --version`). If not: `xcode-select --install`.
- (Optional) GitHub CLI: `brew install gh`, then `gh auth login`.

---

## Option A — brand-new repo with GitHub CLI (easiest)

```bash
cd /path/to/your/copy
git init
git add .
git commit -m "My language learning system"
gh repo create my-language-system --private --source=. --push
```

`--private` keeps it private; use `--public` to make it shareable by link to anyone.
For a family member, `--private` plus adding them as a collaborator is the safer choice.

---

## Option B — brand-new repo, no CLI

1. Create an empty repo on github.com (no README, no .gitignore).
2. Then:
```bash
cd /path/to/your/copy
git init
git add .
git commit -m "My language learning system"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

---

## Option C — overwrite / replace an existing repo

If the repo already exists and you want to force your local copy as the new truth:

```bash
cd /path/to/your/copy
git init
git add .
git commit -m "Replace with updated system"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u --force origin main
```

> `--force` overwrites remote history. Only do this on a repo you own and intend to replace.

---

## ⚠️ Before you push: secrets check

Do **not** commit real secrets. Keep these out of the repo (the templates use
placeholders on purpose):
- ngrok authtoken
- Basic-Auth password embedded in the tunnel URL
- Any connector URL with credentials in it
- Personal emails/phone numbers you'd rather not publish (fine in a private repo)

A `.gitignore` is included that ignores common local/secret files. Review your filled-in
`system-architecture.md` and replace any real password with `{{PASSWORD}}` before pushing
to a **public** repo.

---

## Sharing the link

- **Public repo:** anyone with the link can clone. Good for a generic template.
- **Private repo:** invite the person as a collaborator (repo → Settings → Collaborators),
  or share within your org. Better when the files contain personal context.

The recipient then opens Claude, pastes the link, and says
*"Help me set up this language learning system from scratch."*
