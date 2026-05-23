.DEFAULT_GOAL := help
SHELL         := /usr/bin/env bash

.PHONY: help lint fmt-check secrets-scan-staged lefthook-bootstrap lefthook-install hooks setup install-act ci-local

PLATFORM_STANDARDS_SHA := 1d2cb70b8228d4aee82bd863ae95dcd689c8781a  # main as of 2026-05-23
PLATFORM_STANDARDS_RAW := https://raw.githubusercontent.com/FelipeFuhr/ffreis-platform-standards

help: ## Show available targets
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

lint: ## Lint all workflow YAML with actionlint
	@command -v actionlint >/dev/null 2>&1 || { \
		echo "ERROR: actionlint not found. Install from https://github.com/rhysd/actionlint"; exit 1; }
	actionlint .github/workflows/*.yml workflow-templates/*.yml

fmt-check: ## Validate workflow YAML syntax
	@command -v actionlint >/dev/null 2>&1 && actionlint .github/workflows/*.yml workflow-templates/*.yml || \
	  python3 -c "import glob, yaml; [yaml.safe_load(open(f)) for f in glob.glob('.github/workflows/*.yml') + glob.glob('workflow-templates/*.yml')]; print('YAML valid')"

secrets-scan-staged: ## Scan staged files for secrets
	@command -v gitleaks >/dev/null 2>&1 || { \
		echo "ERROR: gitleaks not found."; exit 1; }
	gitleaks protect --staged --redact

lefthook-bootstrap: ## Download lefthook binary to .bin/
	bash ./scripts/bootstrap_lefthook.sh

lefthook-install: ## Install git hooks via lefthook
	lefthook install

hooks: lefthook-bootstrap lefthook-install ## Bootstrap and install all git hooks

setup: hooks ## Install hooks and verify required tools
	@command -v actionlint >/dev/null 2>&1 || { \
		echo "ACTION REQUIRED: install actionlint from https://github.com/rhysd/actionlint"; exit 1; }
	@python3 -m pip install --quiet pyyaml 2>/dev/null || true
	@echo "Dev environment ready."

install-act: ## Download pinned act binary into .bin/
	@mkdir -p scripts
	@curl -fsSL "$(PLATFORM_STANDARDS_RAW)/$(PLATFORM_STANDARDS_SHA)/scripts/install_act.sh" \
		-o scripts/install_act.sh && chmod +x scripts/install_act.sh
	@bash ./scripts/install_act.sh

ci-local: ## Run workflows locally via act (GH Actions quota fallback). Args via ARGS=...
	@mkdir -p scripts
	@curl -fsSL "$(PLATFORM_STANDARDS_RAW)/$(PLATFORM_STANDARDS_SHA)/scripts/run-ci-local.sh" \
		-o scripts/run-ci-local.sh && chmod +x scripts/run-ci-local.sh
	@PATH="$(CURDIR)/.bin:$(PATH)" bash ./scripts/run-ci-local.sh $(ARGS)
