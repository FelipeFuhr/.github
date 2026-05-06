.DEFAULT_GOAL := help
SHELL         := /usr/bin/env bash

.PHONY: help lint fmt-check secrets-scan-staged lefthook-bootstrap lefthook-install hooks setup

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
