## [2024-11-07]

## Added
- Introduced a Makefile for tool management and testing.
- Added SOPS encryption/decryption script for managing secrets.
- Included new variables for repository configuration, such as auto-init and collaborator settings.
## Changed
- Updated dependencies and pre-commit hooks to newer versions.
- Modified repository settings to be configurable via variables.
## Fixed
- Corrected visibility settings and added missing configurations for repository management.

## [2024-06-05]

## Added

- Added support for environment-specific secrets and variables.
- Introduced `dependabot_environment` variable for enabling dependabot in specific environments.
- Enhanced branch protection options with additional settings for pull request reviews.
- Added support for GitHub Actions environment variables.

## Changed

- Updated GitHub provider version to 6.2.1.
- Renamed `secrets` variable to `environment_secrets`.
-
## 2024-06-05

### Added
- Added TFLint configuration file with various rules enabled.
- Introduced new pre-commit hooks for `terraform_providers_lock` and `terraform_trivy`.
- Added default values for various variables in `variables.tf` and example configurations.
- Added `commit_author_email_pattern` variable for repository ruleset.

### Changed
- Updated branch protection rules to use `github_branch_protection_v3`.
- Modified secrets handling to use `nonsensitive` function.
- Updated example configurations and variable definitions.
- Updated `terraform_precommit` and `terratest` workflows to use the `terratest` branch.
- Updated pre-commit configuration to the latest versions and added new hooks.
- Updated `terraform.tfvars` format in examples.
- Updated `terraform-docs` configuration for better documentation generation.

### Removed
- Removed execution of secrets script from tests.
- Commented out `restrictions` variable and deployment branch policy resource.

## 2024-06-05

### Added
- Added TFLint configuration file with various rules enabled.
- Introduced new pre-commit hooks for `terraform_providers_lock` and `terraform_trivy`.
- Added default values for various variables in `variables.tf` and example configurations.
- Added `commit_author_email_pattern` variable for repository ruleset.

### Changed
- Updated branch protection rules to use `github_branch_protection_v3`.
- Modified secrets handling to use `nonsensitive` function.
- Updated example configurations and variable definitions.
- Updated `terraform_precommit` and `terratest` workflows to use the `terratest` branch.
- Updated pre-commit configuration to the latest versions and added new hooks.
- Updated `terraform.tfvars` format in examples.
- Updated `terraform-docs` configuration for better documentation generation.

### Removed
- Removed execution of secrets script from tests.
- Commented out `restrictions` variable and deployment branch policy resource.
