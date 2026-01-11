## TypeScript

- Look for which package manager to use instead of defaulting to npm. If the root contains:
  - `bun.lock` - use bun
  - `pnpm-lock.yaml` - use pnpm
  - `package-lock.json` - use npm

## Bash

The following tools are installed and available to you:

- **fd** - Fast file finder (alternative to `find`)
- **fzf** - Fuzzy file finder
- **ripgrep (rg)** - Fast text search (alternative to `grep`)
- **ast-grep** - Structural code search using AST patterns
- **jq** - JSON processor for parsing and transforming JSON
- **gh** - GitHub CLI for issues, PRs, and repo management

## Code Quality

Avoid AI generated slop such as:

- Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted / validated codepaths)
- Variables or functions that are only used a single time right after declaration, prefer inlining the rhs/function.
- Redundant checks/casts inside a function that the caller also already takes care of.
- Any other style that is inconsistent with the file, including using types when the file doesn't.

## Comment Policy

### Unacceptable Comments

- Comments that repeat what code codes
- Commented out code (delete it)
- Obvious comments ("increment counter")
- Comments instead of good naming
- Comments about updates to old code ("<- now supportx xyz")

Code should be self-documenting. If you need a comment to explain WHAT the code does, consider refactoring to make it clearer.
