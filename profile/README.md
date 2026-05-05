# FelipeFuhr

Personal and professional projects by Felipe Fuhr. Mostly Go, Python, Rust,
and Terraform, plus the infrastructure that ties them together.

## Fleet overview

| Area | Key repos |
|---|---|
| **Platform tooling** | [`ffreis-platform-standards`](../ffreis-platform-standards) — shared Renovate presets, lefthook hooks, golangci config |
| **Website fleet** | `ffreis-website` · `flemming-website` — static sites built by [`ffreis-website-compiler`](../ffreis-website-compiler) |
| **CI/CD libraries** | `ffreis-workflows-go` · `ffreis-workflows-python` · `ffreis-workflows-rust` · `ffreis-workflows-terraform` · `ffreis-workflows-general` |
| **ML** | `ffreis-python-model-serving` · `ffreis-rust-onnx-model-serving` · `ffreis-runner-comparison` |
| **AI tooling** | [`ffreis-workflow-ai-standardizer`](../ffreis-workflow-ai-standardizer) — AI-assisted repo maintenance |
| **Infrastructure** | `ffreis-platform-org` · `ffreis-platform-shared-infra` · `ffreis-flemming-infra` |
| **Stock** | `ffreis-stock-simulator` · `ffreis-agents-runtime` |

## Standards

- Dependency updates: [Renovate](../ffreis-platform-standards) (presets per language stack)
- Git hooks: [lefthook](../ffreis-platform-standards) (shared configs, inlined scripts)
- Go linting: golangci-lint v2 (standard config in platform-standards)
- CI: reusable workflows from the `ffreis-workflows-*` library repos
- Commits: [Conventional Commits](https://www.conventionalcommits.org/)
