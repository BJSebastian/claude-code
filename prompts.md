# Claude Code 

## Useful Slash Commands
 
- `/ide` — Connects Claude Code to your IDE (e.g. VS Code). Once linked, things like git diffs open directly in your editor with proper syntax highlighting and side-by-side diff views, rather than displaying as plain text in the terminal.
- `/help` — Displays all available slash commands and how to use them. A good starting point when you're not sure what's available — type `/` followed by any letters to filter the list.
- `/clear` — Wipes the conversation history and resets the context window, essentially starting a fresh session. Best used when switching to a completely different task and you don't want prior context carried over.
- `/compact` — Summarizes the current conversation and replaces older messages with a compressed version, freeing up context window space. Useful before starting a long task to make sure Claude has room to work without forgetting earlier details.

---
 
## Prompts

> `give me an overview of the codebase`

> `how are these documents processed`

> `start the servers (frontend + backend)`

> `trace the process of handling a user's query from frontend to backend`

> `draw a diagram to illustrate this flow`

> `how do I run the application?`

> `add and commit these changes`

> `based on this conversation, can you update Claude.md so this doesn't happen again.`

> `update my Claude.md to remove anything that's no longer needed, contradictory, duplicate information or unnecessary bloat impacting effectiveness`

> `please go back and verify all your work so far. Make sure you used best practices, were efficient, and didn't introduce any issues.`

> `based on the project I'm working on, what Claude skills should I create?`

---

## Note: "Add to Memory" and `#` in Claude Code

Your notepad includes two related annotations:

- **"Add to memory"** — In Claude Code, you can ask it to remember something by saying something like *"remember this"* or *"add this to memory."* Claude Code stores that information in a special file called **`CLAUDE.md`** in your project root. It then reads that file automatically at the start of every session, so persistent preferences, project context, or reminders carry over without you having to repeat them.

- **`#` ← update active file** — In Claude Code, prefixing a message with `#` is a shortcut that tells Claude the message should be saved to `CLAUDE.md` (the memory file) rather than acted on immediately. So instead of asking Claude to "remember X," you can just type `# X` and it gets written to memory directly.

Together, these let you build up a living project brief that Claude Code always has access to.
