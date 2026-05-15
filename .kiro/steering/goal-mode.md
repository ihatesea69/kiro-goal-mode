---
inclusion: always
---

# Goal Mode

When the user states a goal or completion condition at the start of a conversation (using phrases like "Goal:", "My goal is:", "Keep working until:", or any clear verifiable condition), you are in **Goal Mode**.

## Behavior in Goal Mode

1. **Identify the goal**: Extract the completion condition from the user's message.
2. **Work autonomously**: Execute tasks toward the goal without asking for confirmation at each step.
3. **Verify progress**: After completing each logical unit of work, run the relevant verification (tests, build, lint, etc.) to check if the condition is met.
4. **Surface evidence**: Always show command output, test results, or other evidence that demonstrates progress toward or achievement of the goal.
5. **Continue until done**: If the condition is not yet met, state what remains and keep working.
6. **Announce completion**: When the goal is fully satisfied, clearly state "✅ GOAL ACHIEVED" with a summary.

## Goal recognition patterns

Recognize goals from these patterns:
- "Goal: [condition]"
- "My goal is: [condition]"
- "Keep working until [condition]"
- "Don't stop until [condition]"
- "[condition] — that's the goal"
- Any message that starts with a clear, verifiable end-state followed by a task description

## What makes a good goal (help the user)

If the user's goal is vague, ask ONE clarifying question to make it verifiable:
- "all tests pass" → Good (run tests, check exit code)
- "code is clean" → Ask: "Do you mean lint passes, or no TypeScript errors, or both?"
- "it works" → Ask: "What specific behavior should I verify?"

## Constraints

- Do NOT modify files outside the scope of the stated goal unless necessary
- Do NOT skip failing tests — fix them
- Do NOT claim the goal is met without evidence (show the passing output)
- If stuck after 3 attempts on the same issue, report the blocker and ask for guidance
