# terraform-module-template
<!-- BEGIN_TF_DOCS -->
# Examples
```hcl
module "repository" {
  source      = "../../"
  name        = var.name
  description = var.description
  #checkov:skip=CKV_GIT_1: The repository must be public
  visibility            = var.visibility
  template_files        = var.template_files
  template_files_prefix = var.template_files_prefix
  #checkov:skip=CKV_GIT_5: Only one approving reviews for PRs
  required_pull_request_reviews = var.required_pull_request_reviews
  restrictions                  = var.restrictions
  status_checks_contexts        = var.status_checks_contexts
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >=4.25.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the repository | `string` | n/a | yes |
| <a name="input_enable_branch_protection"></a> [enable\_branch\_protection](#input\_enable\_branch\_protection) | Enable the branch protection for the default(main) branch | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the repository | `string` | n/a | yes |
| <a name="input_required_pull_request_reviews"></a> [required\_pull\_request\_reviews](#input\_required\_pull\_request\_reviews) | Branch protection options to require PR reviews. | <pre>object({<br>    dismissal_teams                 = list(string)<br>    dismissal_users                 = list(string)<br>    dismiss_stale_reviews           = bool<br>    require_code_owner_reviews      = bool<br>    required_approving_review_count = number<br>  })</pre> | n/a | yes |
| <a name="input_restrictions"></a> [restrictions](#input\_restrictions) | Branch protection,require restrictions (is only available for organization-owned repositories). | <pre>object({<br>    teams = list(string)<br>    users = list(string)<br>    apps  = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_status_checks_contexts"></a> [status\_checks\_contexts](#input\_status\_checks\_contexts) | Contexts for the status\_checks branch protection | `list(string)` | `[]` | no |
| <a name="input_template_files"></a> [template\_files](#input\_template\_files) | List of the paths of the files that will be added in the new repo | `list(string)` | `[]` | no |
| <a name="input_template_files_prefix"></a> [template\_files\_prefix](#input\_template\_files\_prefix) | Prefix of the file path to be removed in the new repo | `string` | `""` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Visibility of the repository | `string` | `"private"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name) | n/a |
## Resources

- resource.github_branch.template_files (main.tf#53)
- resource.github_branch_default.main (main.tf#9)
- resource.github_branch_protection_v3.main (main.tf#14)
- resource.github_repository.repo (main.tf#1)
- resource.github_repository_file.template_files (main.tf#60)
- resource.github_repository_pull_request.template_files (main.tf#76)
<!-- END_TF_DOCS -->
