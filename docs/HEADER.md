# terraform-github-repository

## Makefile Usage

A Makefile is included in this repository to simplify validation, installation, pre-commit checks, and testing.

### Makefile Commands

* `make check-tools`

    This command verifies that all required tools are installed. If any tools are missing, it will notify you and suggest running make install-tools.
* `make install-tools`

  This command installs all necessary tools using Homebrew.
* `make pre-commit`

  Runs pre-commit hooks to check the code for formatting, style, and other issues. It will also install and update hooks as needed.
* `make test`

    Runs tests in a local environment. This command sets up the Go environment, initializes the Go module in the test directory, and executes tests with a timeout and single count.

## Install and configure the tools
````shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install jq
brew install go
brew install terraform-docs
brew install pre-commit
brew install trivy
brew install checkov
brew install tflint
brew install tfenv
````


## How to test
### Local test
#### MacOs and Linux

```shell
# inside a test folder like /terraform-module-template/tests/complete
export GOOS=darwin CGO_ENABLED=0 GOARCH=amd64
# TIME_TO_DESTROY is the time in seconds between terraform apply and terraform destroy
go mod init test
go mod tidy
TIME_TO_DESTROY=10 go test -v  -timeout 120m -count=1
```

## How to use pre-commit

```shell
# in the root of the module
pre-commit autoupdate
pre-commit install --install-hooks
pre-commit run -a
```
