
<!-- BEGIN_TF_DOCS -->
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
# Examples
## Complete
```hcl
## main.tf
module "repository" {
  source              = "../../"
  description         = var.description
  environment_secrets = var.environment_secrets
  environment_variables = {
    "TERRAFORM" = "true"
  }
  dependabot_environment = var.dependabot_environment
  #checkov:skip=CKV_GIT_1:"Ensure GitHub repository is Private"
  visibility                       = var.visibility
  archive_on_destroy               = var.archive_on_destroy
  context                          = module.this.context
  status_checks_contexts           = var.status_checks_contexts
  required_pull_request_reviews    = var.required_pull_request_reviews
  required_deployment_environments = var.required_deployment_environments
  commit_author_email_pattern      = var.commit_author_email_pattern
  collaborators_users              = [{ username = "mnsanfilippo", permission = "admin" }]
}
```
```hcl
## terraform.tfvars
description = "This is a test repository"
environment = "sandbox"
label_order = ["namespace", "stage", "name", "environment"]
name        = "repository"
namespace   = "flufi"
stage       = "module"


required_deployment_environments = ["sandbox"]
archive_on_destroy               = "false"
visibility                       = "public"
status_checks_contexts           = ["terratest"]
commit_author_email_pattern      = "@flufi.io"

dependabot_environment = "sandbox"
required_pull_request_reviews = {
  dismissal_apps                    = ["codiumai-pr-agent-pro"]
  dismissal_users                   = ["mnsanfilippo"]
  dismiss_stale_reviews             = true
  require_code_owner_reviews        = true
  required_approving_review_count   = 1
  require_last_push_approval        = true
  required_review_thread_resolution = true
  bypass_pull_request_allowances = {
    users = ["mnsanfilippo"]
    apps  = ["codiumai-pr-agent-pro"]
  }
}
```
## Resources

- resource.github_actions_environment_secret.this (main.tf#88)
- resource.github_actions_environment_variable.this (main.tf#97)
- resource.github_branch_default.main (main.tf#28)
- resource.github_branch_protection_v3.main (main.tf#33)
- resource.github_dependabot_secret.this (main.tf#106)
- resource.github_repository.this (main.tf#1)
- resource.github_repository_collaborators.collaborators (main.tf#195)
- resource.github_repository_deployment_branch_policy.this (main.tf#80)
- resource.github_repository_environment.this (main.tf#71)
- resource.github_repository_ruleset.tag (main.tf#158)
- resource.github_repository_ruleset.this (main.tf#113)
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
## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider_github) | 6.2.1 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional_tag_map](#input_additional_tag_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br/>This is for some rare cases where resources want additional configuration of tags<br/>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_allow_auto_merge"></a> [allow_auto_merge](#input_allow_auto_merge) | Allow auto-merge on pull requests. | `bool` | `true` | no |
| <a name="input_allow_merge_commit"></a> [allow_merge_commit](#input_allow_merge_commit) | Allow merge commits for pull requests. | `bool` | `true` | no |
| <a name="input_allow_rebase_merge"></a> [allow_rebase_merge](#input_allow_rebase_merge) | Allow rebase merging for pull requests. | `bool` | `false` | no |
| <a name="input_allow_squash_merge"></a> [allow_squash_merge](#input_allow_squash_merge) | Allow squash merging for pull requests. | `bool` | `false` | no |
| <a name="input_allow_update_branch"></a> [allow_update_branch](#input_allow_update_branch) | Allow branch updates before merging pull requests. | `bool` | `true` | no |
| <a name="input_archive_on_destroy"></a> [archive_on_destroy](#input_archive_on_destroy) | Set to true to archive the repository instead of deleting it. | `bool` | `false` | no |
| <a name="input_attributes"></a> [attributes](#input_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_auto_init"></a> [auto_init](#input_auto_init) | Automatically initialize the repository with a README file. | `bool` | `true` | no |
| <a name="input_collaborators_teams"></a> [collaborators_teams](#input_collaborators_teams) | List of teams to add as collaborators | `list(object({ slug = string, permission = string }))` | `[]` | no |
| <a name="input_collaborators_users"></a> [collaborators_users](#input_collaborators_users) | List of users to add as collaborators | `list(object({ username = string, permission = string }))` | `[]` | no |
| <a name="input_commit_author_email_pattern"></a> [commit_author_email_pattern](#input_commit_author_email_pattern) | The pattern that the author email of the commits must match to be accepted. | `string` | `""` | no |
| <a name="input_context"></a> [context](#input_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes, tags, and additional_tag_map, which are merged. | `any` | <pre>{<br/>  "additional_tag_map": {},<br/>  "attributes": [],<br/>  "delimiter": null,<br/>  "descriptor_formats": {},<br/>  "enabled": true,<br/>  "environment": null,<br/>  "id_length_limit": null,<br/>  "label_key_case": null,<br/>  "label_order": [],<br/>  "label_value_case": null,<br/>  "labels_as_tags": [<br/>    "unset"<br/>  ],<br/>  "name": null,<br/>  "namespace": null,<br/>  "regex_replace_chars": null,<br/>  "stage": null,<br/>  "tags": {},<br/>  "tenant": null<br/>}</pre> | no |
| <a name="input_delete_branch_on_merge"></a> [delete_branch_on_merge](#input_delete_branch_on_merge) | Delete branches after merging pull requests. | `bool` | `true` | no |
| <a name="input_delimiter"></a> [delimiter](#input_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_dependabot_environment"></a> [dependabot_environment](#input_dependabot_environment) | The environment to enable dependabot for | `string` | `"sandbox"` | no |
| <a name="input_description"></a> [description](#input_description) | Description of the repository | `string` | `""` | no |
| <a name="input_descriptor_formats"></a> [descriptor_formats](#input_descriptor_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>   format = string<br/>   labels = list(string)<br/>}`<br/>(Type is `any` so the map values can later be enhanced to provide additional options.)<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_environment_secrets"></a> [environment_secrets](#input_environment_secrets) | Secrets to be stored in the repository for the environment | `map(string)` | `{}` | no |
| <a name="input_environment_variables"></a> [environment_variables](#input_environment_variables) | Variables to be stored in the repository for the environment | `map(string)` | `{}` | no |
| <a name="input_has_issues"></a> [has_issues](#input_has_issues) | Enable issues for the repository. | `bool` | `true` | no |
| <a name="input_has_projects"></a> [has_projects](#input_has_projects) | Enable projects for the repository. | `bool` | `true` | no |
| <a name="input_has_wiki"></a> [has_wiki](#input_has_wiki) | Enable wiki for the repository. | `bool` | `true` | no |
| <a name="input_id_length_limit"></a> [id_length_limit](#input_id_length_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` for keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label_key_case](#input_label_key_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label_order](#input_label_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label_value_case](#input_label_value_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels_as_tags](#input_labels_as_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>**Notes:**<br/>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br/>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br/>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br/>  "default"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex_replace_chars](#input_regex_replace_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_required_deployment_environments"></a> [required_deployment_environments](#input_required_deployment_environments) | The list of environments that must be deployed to from this branch before it can be merged into the destination branch. | `list(string)` | `[]` | no |
| <a name="input_required_pull_request_reviews"></a> [required_pull_request_reviews](#input_required_pull_request_reviews) | Branch protection options to require PR reviews. | <pre>object({<br/>    dismissal_teams                   = optional(list(string))<br/>    dismissal_users                   = optional(list(string))<br/>    dismissal_apps                    = optional(list(string))<br/>    dismiss_stale_reviews             = optional(bool)<br/>    require_code_owner_reviews        = optional(bool)<br/>    required_approving_review_count   = optional(number)<br/>    require_last_push_approval        = optional(bool, false)<br/>    required_review_thread_resolution = optional(bool)<br/>    bypass_pull_request_allowances = optional(object({<br/>      users = optional(list(string))<br/>      teams = optional(list(string))<br/>      apps  = optional(list(string))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_stage"></a> [stage](#input_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_status_checks_contexts"></a> [status_checks_contexts](#input_status_checks_contexts) | Contexts for the status_checks branch protection | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_template"></a> [template](#input_template) | Template repository to use for this repository | <pre>object({<br/>    owner                = string<br/>    repository           = string<br/>    include_all_branches = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_tenant"></a> [tenant](#input_tenant) | ID element _(Rarely used, not included by default)_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_visibility"></a> [visibility](#input_visibility) | Visibility of the repository | `string` | `"private"` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability_alerts](#input_vulnerability_alerts) | Enable vulnerability alerts for the repository. | `bool` | `true` | no |
| <a name="input_web_commit_signoff_required"></a> [web_commit_signoff_required](#input_web_commit_signoff_required) | Require contributors to sign off on commits made through the web interface. | `bool` | `true` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_name"></a> [repository_name](#output_repository_name) | The name of the repository |
| <a name="output_repository_url"></a> [repository_url](#output_repository_url) | The URL of the repository |
# MIT License

## Copyright (c) [2024] Flufi LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included insa
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
<!-- END_TF_DOCS -->
