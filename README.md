# Claude Code Dev Flow

Custom slash commands and workflows for building features with Claude Code.

---

## Commands

| Command | Description |
|---|---|
| [`/spec`](#spec) | Turn a short feature idea into a branch, a spec file, and a plan |
| [`/commit-message`](#commit-message) | Analyse staged changes and propose a conventional commit message |

---

## `/spec`

A three-phase workflow that takes a feature idea all the way from spec to implementation.

```
  Feature Idea
       │
       ▼
  ┌─────────────┐
  │  /spec ...  │  ── Parses idea, creates branch, writes _specs/<slug>.md
  └─────────────┘
       │
       ▼
  ┌─────────────────────────┐
  │  Plan Mode              │  ── Claude reads spec, drafts implementation plan
  │  "let's plan this spec" │
  └─────────────────────────┘
       │
       ├── Review & iterate on plan
       │
       ▼
  ┌────────────────────────────────────┐
  │  "save the plan to _plans folder"  │  ── Plan saved as _plans/<slug>.md
  └────────────────────────────────────┘
       │
       ▼
  ┌──────────────────────────────────────────┐
  │  Accept Edits ON                         │
  │  "let's implement this plan"             │  ── Claude executes the plan
  └──────────────────────────────────────────┘
       │
       ▼
  ┌──────────────┐
  │  Code merged │
  └──────────────┘
```

### Step-by-Step

**1. Run `/spec`**

Invoke the command with a short description of the feature you want to build.

```
/spec let's spec out the 'create policy' form in @app/(dashboard)/policy/create/page.tsx.
When the form is submitted, it should create a new policy document in a firestore policy
collection, and then redirect the user to the /policy page. Codenames and user ids can be
fetched from the users collection, so that users can assign the policy to other users.
Use the CreatePolicyInput interface for input fields. createAt and deadline values added
programatically.
```

Claude will:
- Derive a `feature_title` and `feature_slug` from your description
- Check for uncommitted changes (aborts if any are found — commit or stash first)
- Create and switch to a new branch: `claude/feature/<slug>`
- Write a detailed spec to `_specs/<slug>.md` using the project's spec template
- Print a short summary:

```
Branch:    claude/feature/create-policy-form
Spec file: _specs/create-policy-form.md
Title:     Create Policy Form
```

**2. Switch to Plan Mode — `let's plan this spec`**

Claude reads the spec file, analyses the codebase, and drafts a step-by-step implementation plan. Review it, ask questions, and iterate until you're satisfied.

**3. Save the Plan — `save the plan to the _plans folder`**

Claude saves the plan to `_plans/<slug>.md`. Plans are version-controlled alongside your code, so the whole team can review them on the branch.

**4. Implement — `let's implement this plan`**

Turn on **Accept Edits** in Claude Code. Claude reads the saved plan and executes it — creating files, editing code, and running commands according to what was agreed in the planning step.

### Directory Structure

```
_specs/
  template.md           ← spec template (customise this)
  create-policy-form.md ← generated specs live here

_plans/
  create-policy-form.md ← generated plans live here
```

Each generated spec follows the sections defined in `_specs/template.md`:

| Section | Purpose |
|---|---|
| **Summary** | One-paragraph description of the feature |
| **Functional Requirements** | What the feature must do |
| **Figma Design Reference** | Design file / component link (omitted if not applicable) |
| **Possible Edge Cases** | Scenarios Claude should consider during planning |
| **Acceptance Criteria** | Definition of done |
| **Open Questions** | Unresolved decisions to address before or during implementation |
| **Testing Guidelines** | Guidance for test coverage in `./tests` |

### Customising `/spec`

The command file is at `.claude/commands/spec.md` — it is plain markdown, open it and tailor it to your workflow.

| Behaviour | Where to change it |
|---|---|
| Skip automatic branch creation | Remove or comment out **Step 3** in `spec.md` |
| Change the branch prefix (e.g. `feat/` instead of `claude/feature/`) | Edit the `branch_name` format in **Step 2** |
| Enforce a different spec structure | Update `_specs/template.md` |
| Allow/restrict which tools the command can use | Edit the `allowed-tools` frontmatter line |
| Add project-specific rules (naming conventions, libraries) | Add them to `CLAUDE.md` — the command inherits those rules automatically |

> **Note:** The automatic branch creation step is optional but highly recommended. It keeps spec, plan, and implementation work isolated on a dedicated branch, making PRs and reviews much cleaner.

### Tips

- **Commit or stash before running `/spec`.** The command checks for a clean working tree and aborts if it finds uncommitted changes.
- **Be as specific as you like in the prompt.** Reference file paths (`@path/to/file.tsx`), interfaces, collections, redirects — the more context you give, the more accurate the spec.
- **Iterate in plan mode before saving.** You can go back and forth with Claude to refine the plan without writing any files. Only save when you're happy.
- **Plans are just markdown.** You can edit `_plans/<slug>.md` by hand before telling Claude to implement it.

---

## `/commit-message`

Analyses your staged changes and proposes a conventional commit message — with an emoji prefix and a focus on *why* the change was made, not just *what* changed.

```
  git add <files>
       │
       ▼
  ┌──────────────────┐
  │ /commit-message  │  ── Reads git status + staged diff
  └──────────────────┘
       │
       ▼
  ┌──────────────────────────────────┐
  │  Summary of staged changes       │
  │  Proposed commit message         │  ── Claude proposes, waits for approval
  │  "looks good?" / "tweak X"       │
  └──────────────────────────────────┘
       │
       ▼
  ┌──────────────┐
  │  Committed   │  ── Only commits after explicit user confirmation
  └──────────────┘
```

### Usage

Stage the files you want to commit, then run:

```
/commit-message
```

Claude will show a summary of what's staged and propose a message in this format:

```
✨ feat: add deadline field to policy creation form

Ensures policies always have an explicit deadline so downstream
notification logic has a reliable date to work with.
```

Approve it, ask for a tweak, or reject it — Claude will not commit until you say so.

### Commit Types

| Emoji | Type | When to use |
|---|---|---|
| ✨ | `feat` | New feature |
| 🐛 | `fix` | Bug fix |
| 🔨 | `refactor` | Restructuring without behaviour change |
| 📝 | `docs` | Documentation only |
| 🎨 | `style` | Formatting / styling |
| ✅ | `test` | Tests |
| ⚡ | `perf` | Performance improvement |

### Customising `/commit-message`

The command file is at `.claude/commands/commit-message.md`.

| Behaviour | Where to change it |
|---|---|
| Add or remove commit types | Edit the emoji/type list in `commit-message.md` |
| Change the message format | Edit the **Format** section in `commit-message.md` |
| Allow auto-commit without confirmation | Remove the `DO NOT auto-commit` instruction (not recommended) |
