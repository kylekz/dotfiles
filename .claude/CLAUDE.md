## General

- Make use of the AskUserQuestion tool to clarify ambiguity. There's no harm in asking questions.
- When interfacing with GitHub PRs, do not make comments on reviews unless explicitly asked to do so.
- When working on refactors, if the plan is not explicit, ask the user for clarification regarding preserving backward compatibility or not.
- When writing functions, always include a 1-2 sentence docblock comment.

## Bash

The following tools are installed and available to you:

- **fd** - Fast file finder (alternative to `find`)
- **fzf** - Fuzzy file finder
- **ripgrep (rg)** - Fast text search (alternative to `grep`)
- **ast-grep** - Structural code search using AST patterns
- **jq** - JSON processor for parsing and transforming JSON
- **gh** - GitHub CLI for issues, PRs, and repo management

## TypeScript

- Before running any package manager commands, check the `packageManager` field in the `package.json`
- If there's no `packageManager` field, fallback to checking lockfiles:
  - `bun.lock` - use bun
  - `pnpm-lock.yaml` - use pnpm
  - `package-lock.json` - use npm
- When dealing with npm package versions, use the package manager to find the latest: `[bun pm|pnpm|npm] view <package> version`
- Never compromise type safety: No any, no non-null assertion operator (!), no type assertions (as Type) — prefer `satisfies` for type validation
- Make illegal states unrepresentable: Model domain with ADTs/discriminated unions; parse inputs at boundaries into typed structures; if state can't exist, code can't mishandle it
- Use the LSP tool instead of assuming what properties exist
- When writing comments, do not include JSDoc. TypeScript already defines the types, we only need the comment.

## Code Quality

Avoid AI generated slop such as:

- Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted / validated codepaths)
- Variables or functions that are only used a single time right after declaration, prefer inlining the rhs/function.
- Redundant checks/casts inside a function that the caller also already takes care of.
- Any other style that is inconsistent with the file, including using types when the file doesn't.

This codebase will outlive you. Every shortcut becomes someone else's burden. Every hack compounds into technical debt that slows the whole team down.
The patterns you establish will be copied. The corners you cut will be cut again. Leave the codebase better than you found it.

Avoid slop comments such as:

- Comments that repeat what code codes
- Commented out code (delete it)
- Obvious comments ("increment counter")
- Comments instead of good naming
- Comments about updates to old code ("<- now supports xyz")

Code should be self-documenting. If you need a comment to explain WHAT the code does, consider refactoring to make it clearer.
