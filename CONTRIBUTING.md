# Contributing

## Before you change anything

Read the repo's `AGENTS.md`. Every repo has one at its root. It documents
non-obvious constraints, cross-repo dependencies, and conventions that are
not derivable from the code. Ignoring it is the most common source of
broken PRs.

## Getting started

```bash
make setup          # install lefthook + verify required tools
make fmt-check      # check formatting
make lint           # run linters
```

## Commit format

All commits must follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): short description

type  →  feat | fix | chore | refactor | test | ci | docs | perf | build | revert
scope →  optional, lowercase, hyphenated
```

This is enforced by the pre-commit hook and by CI on every PR title.

## Opening a PR

- One concern per PR. Split unrelated changes.
- Fill in the PR template — particularly the test plan.
- PR titles must follow the same Conventional Commits format as commit messages.
- CI must be green before requesting review.

## Finding repo-specific instructions

If you're working on a specific repo and something here conflicts with
`AGENTS.md`, the `AGENTS.md` wins. It reflects the local state of that repo.

## Questions

Open an issue — see [SUPPORT.md](SUPPORT.md).
