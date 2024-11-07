# Makefile for terraform-github-repository

# List of required packages
REQUIRED_TOOLS := jq go terraform-docs pre-commit trivy checkov tflint tfenv

# Check if all required tools are installed
.PHONY: check-tools
check-tools:
	@missing_tools=0; \
	for tool in $(REQUIRED_TOOLS); do \
		if ! command -v $$tool &> /dev/null; then \
			echo "$$tool is not installed."; \
			missing_tools=1; \
		fi \
	done; \
	if [ $$missing_tools -eq 0 ]; then \
		echo "All required tools are installed."; \
	else \
		echo "Please run 'make install-tools' to install the missing tools."; \
		exit 1; \
	fi

# Install required tools using Homebrew
.PHONY: install-tools
install-tools:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install $(REQUIRED_TOOLS)

# Run pre-commit checks
.PHONY: pre-commit
pre-commit:
	pre-commit autoupdate &&  pre-commit run -a

# Run tests and clean up after
.PHONY: test
test:
	# run pre-commit first
	pre-commit run -a
	(cd tests/complete && \
		export GOOS=darwin CGO_ENABLED=0 GOARCH=amd64 && \
		TIME_TO_DESTROY=10 go test -v -timeout 120m -count=1)
