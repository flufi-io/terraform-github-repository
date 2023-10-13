namespace   = "flufi"
environment = "development"
stage       = "module"
label_order = ["namespace", "stage", "name", "environment", "attributes"]

name        = "repository"
description = "This is a repository module"


archive_on_destroy = false


restrictions = {
  teams = ["@flufi-io/devops-engineers"]
  users = ["mnsanfilippo"]
  apps  = ["github-actions"]
}
required_pull_request_reviews = {
  dismissal_teams                 = ["@flufi-io/devops-engineers"]
  dismissal_users                 = ["pipo-flufi"]
  dismiss_stale_reviews           = true
  require_code_owner_reviews      = true
  required_approving_review_count = 1
}
status_checks_contexts = ["terratest"]

action_secrets = {
  new_secret = "bmV3X3NlY3JldAo="
}

repository_environment = {

  required_pull_request_reviews = {
    dismissal_teams                 = ["@flufi-io/devops-engineers"]
    dismissal_users                 = ["pipo-flufi"]
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }
  reviewers = {
    teams = ["@flufi-io/devops-engineers"]
    users = ["mnsanfilippo"]
  }
  deployment_branch_policy = {
    protected_branches     = true
    custom_branch_policies = false
  }
  status_checks_contexts = ["terratest"]

}
#### TEMPLATE REPOSITORY ####
is_template = false
template_repository = {
  name                 = "terraform-module-template"
  include_all_branches = true
  owner                = "flufi-io"
}
