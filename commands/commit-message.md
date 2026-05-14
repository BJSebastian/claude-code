---
description: Create a commit message by analyzing git diffs
allowed-tools: Bash(git commit:*), Bash(git -C:*), Bash(.claude/scripts/git-staged.sh:*)
---

## Context

Staged changes across repos:
!`.claude/scripts/git-staged.sh $ARGUMENTS`

## Your task:

Analyze the staged git changes above. There may be one or multiple repositories shown.

For each repository that has staged changes, propose a commit message using the format below.
If changes span multiple repositories, provide a separate commit message for each, clearly labeled with the repo path.

When committing:
- Root repo: `git commit -m "..."`
- Sub-directory repo: `git -C <repo_path> commit -m "..."`

## Commit types with emojis:
Only use the following emojis:

- ✨ `feat:` - New feature
- 🐛 `fix:` - Bug fix
- 🔨 `refactor:` - Refactoring code
- 📝 `docs:` - Documentation
- 🎨 `style:` - Styling/formatting
- ✅ `test:` - Tests
- ⚡ `perf:` - Performance

## Format:

```
<emoji> <type>: <concise_description>
<optional_body_explaining_why>
```

## Output:

1. Show summary of staged changes (per repo if multiple)
2. Propose commit message(s) with appropriate emoji
3. Ask for confirmation before committing

DO NOT auto-commit - wait for user approval, and only commit if the user says so.
