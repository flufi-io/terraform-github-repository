[![terratest](https://github.com/flufi-io/terraform-module-template/actions/workflows/terratest.yml/badge.svg)](https://github.com/flufi-io/terraform-module-template/actions/workflows/terratest.yml)
[![infracost](https://github.com/flufi-io/terraform-module-template/actions/workflows/infracost.yml/badge.svg)](https://github.com/flufi-io/terraform-module-template/actions/workflows/infracost.yml)
[![terraform pre-commit](https://github.com/flufi-io/terraform-module-template/actions/workflows/terraform_precommit.yaml/badge.svg)](https://github.com/flufi-io/terraform-module-template/actions/workflows/terraform_precommit.yaml)

# terraform-module-template

<!-- BEGIN_TF_DOCS -->
# Examples
```hcl
module "repository" {
  source      = "../../"
  context     = module.this.context
  description = var.description
  #  visibility                    = var.visibility
  #  template_files                = var.template_files
  #  template_files_prefix         = var.template_files_prefix
  #  required_pull_request_reviews = var.required_pull_request_reviews
  #  restrictions = var.restrictions
  #  status_checks_contexts        = var.status_checks_contexts
  #  action_secrets                = var.action_secrets
  archive_on_destroy  = var.archive_on_destroy
  template_repository = var.template_repository
  is_template         = var.is_template
  #  merge_commit_title            = var.merge_commit_title
  #  required_status_checks        = var.required_status_checks
  #  squash_merge_commit_message   = var.squash_merge_commit_message
}
namespace   = "flufi"
environment = "development"
stage       = "module"
label_order = ["namespace", "stage", "name", "environment", "attributes"]


name        = "repository"
description = "This is a repository module"
#is_template                 = false
#squash_merge_commit_message = "PR_TITLE"
#merge_commit_title          = "PR_BODY"
archive_on_destroy = false
#template_files = [
#  ".config/.terraform-docs.yml",
#  ".gitignore",
#  "main.tf",
#  "variables.tf",
#  "versions.tf",
#  "outputs.tf",
#  "README.md",
#
#]
#template_files_prefix = "../.."

#restrictions = {
#  teams = ["@flufi-io/devops-engineers"]
#  users = ["mnsanfilippo"]
#  apps  = ["github-actions"]
#}
#required_pull_request_reviews = {
#  dismissal_teams                 = ["@flufi-io/devops-engineers"]
#  dismissal_users                 = ["pipo-flufi"]
#  dismiss_stale_reviews           = true
#  require_code_owner_reviews      = true
#  required_approving_review_count = 1
#}
#status_checks_contexts = ["terratest"]

#action_secrets = {
#  new_secret = "bmV3X3NlY3JldAo="
#}

#environments = {
#  development = {
#    required_pull_request_reviews = {
#      dismissal_teams                 = ["@flufi-io/devops-engineers"]
#      dismissal_users                 = ["pipo-flufi"]
#      dismiss_stale_reviews           = true
#      require_code_owner_reviews      = true
#      required_approving_review_count = 1
#    }
#    reviewers = {
#      teams = ["@flufi-io/devops-engineers"]
#      users = ["mnsanfilippo"]
#    }
#    deployment_branch_policy = {
#      protected_branches = ["main"]
#      enforce_admins     = true
#    }
#    status_checks_contexts = ["terratest"]
#  }
#}
#### TEMPLATE REPOSITORY ####
is_template = false
template_repository = {
  name                 = "terraform-module-template"
  include_all_branches = true
  owner                = "flufi-io"
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 5.33.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | Set to false to prevent the repository from being archived when destroyed | `bool` | `true` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the repository | `string` | n/a | yes |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | Whether the repository acts as a template that can be used to generate new repositories | `bool` | `false` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_template_repository"></a> [template\_repository](#input\_template\_repository) | The repository to use as a template | <pre>object({<br>    owner                = string<br>    name                 = string<br>    include_all_branches = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name) | The full name of the repository |
## Resources

- resource.github_branch_default.main (main.tf#29)
- resource.github_repository.this (main.tf#1)
<!-- END_TF_DOCS -->


MIT License

Copyright (c) [2023] Flufi LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
