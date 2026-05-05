# Agent Context

**This repo:** `FelipeFuhr/.github` — GitHub organisation defaults repository.
Community health files placed here apply automatically to **every** `FelipeFuhr`
repo that does not have its own copy.

## Non-obvious facts

1. **Only community health files propagate as org defaults.** Files that propagate:
   `PULL_REQUEST_TEMPLATE.md`, `ISSUE_TEMPLATE/`, `CONTRIBUTING.md`, `SECURITY.md`,
   `SUPPORT.md`. Workflows in `.github/.github/workflows/` run on THIS repo only.

2. **`workflow-templates/`** files appear under "Actions → New workflow" in every
   `FelipeFuhr` repo. Each `.yml` must have a matching `.properties.json` sibling.

3. **`profile/README.md`** is displayed on the public `FelipeFuhr` org page on GitHub.

4. **To override the PR template in a specific repo:** add
   `.github/PULL_REQUEST_TEMPLATE.md` to that repo. It shadows this org default.

5. **`gh pr create --body "..."` bypasses the template.** Batch tooling scripts
   (like `create_prs.sh`) will not auto-populate from the template; contributors
   opening PRs via the GitHub web UI will.

6. **Renovate here** tracks `.github/workflows/` action SHA pins via the
   `github-actions` preset from `ffreis-platform-standards`.

## Structure

```
PULL_REQUEST_TEMPLATE.md    ← universal PR template (org default)
ISSUE_TEMPLATE/             ← bug report + feature request (org defaults)
CONTRIBUTING.md             ← fleet-wide contributing guide (org default)
SECURITY.md                 ← vulnerability reporting (org default)
SUPPORT.md                  ← where to get help (org default)
profile/README.md           ← displayed on the FelipeFuhr org page
workflow-templates/         ← "New workflow" picker templates for all org repos
.github/workflows/          ← CI/security for THIS repo only (not propagated)
lefthook.yml                ← pre-commit hooks (base + actionlint)
Makefile                    ← lint, fmt-check, setup, hooks targets
renovate.json               ← track own action SHA pins
```

## Keeping this file current

- **If you discover a fact not reflected here:** add it before finishing your task.
- **If something here is wrong or outdated:** correct it in the same commit.
- **If you rename a file, command, or concept referenced here:** update the reference.
