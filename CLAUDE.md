# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A personal Claude Code toolkit — slash commands, skills, scripts, and saved prompts that Bryan uses across projects. Nothing in this repo runs as an application. There is no build step, no test suite, and no package manager.

## How to Use This Repo in a Project

Copy assets from this repo into a target project's `.claude/` folder:

```bash
# Slash commands
cp commands/spec.md your-project/.claude/commands/spec.md
cp commands/commit-message.md your-project/.claude/commands/commit-message.md

# Supporting script (required by /commit-message)
mkdir -p your-project/.claude/scripts
cp scripts/git-staged.sh your-project/.claude/scripts/git-staged.sh
chmod +x your-project/.claude/scripts/git-staged.sh

# Spec template (required by /spec)
mkdir -p your-project/_specs
cp _specs/template.md your-project/_specs/template.md
```

## Slash Commands

| Command | File | What it does |
|---|---|---|
| `/spec` | `commands/spec.md` | Checks for a clean working tree, creates a `claude/feature/<slug>` branch, and writes a spec to `_specs/<slug>.md` from the template |
| `/commit-message` | `commands/commit-message.md` | Reads staged diff via `scripts/git-staged.sh`, proposes a conventional commit message with emoji prefix, and waits for explicit approval before committing |

`/commit-message` supports multi-repo setups — `git-staged.sh` scans up to two levels deep for repos with staged changes when not run from a git root.

## Skills

Skills live under `skills/` and are organized by category. Each skill folder contains a `SKILL.md` entry point plus supporting context files.

| Path | Purpose |
|---|---|
| `skills/engineering/grill-with-docs/` | Interrogates code against ADR or context docs |
| `skills/engineering/improve-codebase-architecture/` | Architecture review with interface design and language guidance |
| `skills/engineering/tdd/` | TDD workflow with modules on mocking, refactoring, and test design |
| `skills/engineering/to-issues/` | Converts discussion or analysis into GitHub issues |
| `skills/engineering/to-prd/` | Converts a feature idea into a PRD |
| `skills/productivity/grill-me/` | Socratic Q&A skill for exploring a topic or decision |

## Key Files

- `prompts.md` — Saved prompts and slash command quick-reference notes for day-to-day Claude Code use
- `settings.local.json` — Baseline permissions template (copy to a project's `.claude/settings.local.json` and trim to what's needed)
- `_specs/template.md` — Spec structure used by `/spec`; customize this per project
- `CLAUDE.global.md` — Bryan's personal global preferences (mirrored from `~/.claude/CLAUDE.md`; not active in Claude Code sessions)
