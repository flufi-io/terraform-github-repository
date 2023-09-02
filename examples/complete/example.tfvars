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
