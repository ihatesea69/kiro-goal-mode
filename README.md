# kiro-goal-mode

Autonomous goal-driven workflow for [Kiro IDE](https://kiro.dev) — inspired by Claude Code's `/goal` command.

Set a goal in your chat message, and Kiro will keep working toward it automatically until the condition is met.

## How it works

1. You state your goal in the first message (e.g., "Goal: all tests in src/auth pass and lint is clean")
2. Kiro works toward it
3. After each agent turn, the `agentStop` hook fires and evaluates whether your goal has been achieved
4. If NOT achieved → agent automatically continues working
5. If achieved → agent announces completion and stops

## Installation

Copy the hook and steering files into your workspace's `.kiro/` directory:

```bash
# Clone this repo
git clone https://github.com/YOUR_USERNAME/kiro-goal-mode.git

# Copy files to your workspace
cp kiro-goal-mode/.kiro/hooks/goal-evaluator.hook.json YOUR_PROJECT/.kiro/hooks/
cp kiro-goal-mode/.kiro/steering/goal-mode.md YOUR_PROJECT/.kiro/steering/
```

Or manually copy the files from this repo's `.kiro/` directory.

## Usage

In Kiro chat, start your message with a clear goal statement:

```
Goal: all unit tests pass and there are no TypeScript errors

The auth module needs refactoring to use the new token validation library.
```

Kiro will:
- Parse your goal from the conversation
- Work on the task
- Auto-evaluate after each turn
- Continue until the goal condition is satisfied

## Goal writing tips

Write goals that are **verifiable from conversation output**:

| Good | Bad |
|------|-----|
| "all tests pass (npm test exits 0)" | "code is clean" |
| "no TypeScript errors in src/" | "everything works" |
| "API responds 200 for all endpoints in test suite" | "API is fast" |
| "file count in src/modules/ is under 10" | "code is organized" |

Include:
- A measurable end state (test result, build exit code, file count)
- How to verify it (which command to run)
- Constraints (what must NOT change)

## Disabling

To temporarily disable goal mode:
- Delete or rename `goal-evaluator.hook.json`
- Or set the hook file content to have `"disabled": true` (not yet supported, just remove the file)

## Limitations

- No separate evaluator model — the same agent evaluates its own progress
- No built-in turn counter or token spend tracking
- Goal must be stated in conversation (not set via command)
- No `/goal clear` equivalent — start a new conversation to reset
- Evaluation quality depends on context window size

## How it compares to Claude Code's /goal

| Feature | Claude Code | kiro-goal-mode |
|---------|-------------|----------------|
| Set goal dynamically | `/goal condition` | State in chat message |
| Separate evaluator | Yes (Haiku) | No (same agent) |
| Status indicator | ◎ with timer | No |
| Clear goal | `/goal clear` | New conversation |
| Non-interactive mode | `claude -p "/goal ..."` | Not supported |
| Turn/token tracking | Yes | No |
| Auto-continue | Yes | Yes (via agentStop hook) |

## License

MIT
