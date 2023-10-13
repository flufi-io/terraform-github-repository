resource "github_repository" "this" {
  name                   = module.this.name
  description            = var.description
  visibility             = "private"
  auto_init              = true
  vulnerability_alerts   = true
  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  has_issues             = true
  has_projects           = true
  has_wiki               = true
  delete_branch_on_merge = true
  archive_on_destroy     = var.archive_on_destroy
  allow_update_branch    = true

  #### TEMPLATE ####
  is_template = var.is_template
  dynamic "template" {
    for_each = var.template_repository == null ? toset([]) : toset([1])
    content {
      repository           = var.template_repository.name
      owner                = var.template_repository.owner
      include_all_branches = try(var.template_repository.include_all_branches, true)
    }
  }
}

resource "github_branch_default" "main" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_branch_protection_v3" "main" {
  depends_on                      = [github_repository.this, github_branch_default.main]
  repository                      = github_repository.this.name
  branch                          = github_branch_default.main.branch
  enforce_admins                  = true
  require_signed_commits          = true
  require_conversation_resolution = true
  dynamic "required_status_checks" {
    for_each = var.required_status_checks != null ? toset([]) : toset([1])
    content {
      strict = true
      checks = var.required_status_checks
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = var.required_pull_request_reviews != null ? toset([]) : toset([1])
    content {
      dismiss_stale_reviews           = var.required_pull_request_reviews.dismiss_stale_reviews
      require_code_owner_reviews      = var.required_pull_request_reviews.require_code_owner_reviews
      required_approving_review_count = var.required_pull_request_reviews.required_approving_review_count
      dismissal_teams                 = var.required_pull_request_reviews.dismissal_teams
      dismissal_users                 = var.required_pull_request_reviews.dismissal_users
      dynamic "bypass_pull_request_allowances" {
        for_each = length(var.required_pull_request_reviews.bypass_pull_request_allowances) == 0 ? toset([]) : toset([
          1
        ])
        content {
          users = var.required_pull_request_reviews.bypass_pull_request_allowances[0].users
          teams = var.required_pull_request_reviews.bypass_pull_request_allowances[0].teams
          apps  = var.required_pull_request_reviews.bypass_pull_request_allowances[0].apps
        }
      }
    }
  }

  dynamic "restrictions" {
    for_each = length(var.restrictions) == 0 ? toset([]) : toset([1])
    content {
      users = var.restrictions.users
      teams = var.restrictions.teams
      apps  = var.restrictions.apps
    }
  }
}


resource "github_actions_secret" "this" {
  for_each        = var.action_secrets
  repository      = github_repository.this.name
  secret_name     = each.key
  encrypted_value = each.value
}


#### ENVIRONMENTS ####
resource "time_sleep" "wait" {
  depends_on      = [github_repository.this]
  create_duration = "5s"
}


resource "github_repository_environment" "this" {
  depends_on  = [time_sleep.wait]
  environment = module.this.environment
  repository  = github_repository.this.name
  #  dynamic "reviewers" {
  #    for_each = length(var.repository_environment.reviewers.users) == 0 ? toset([]) : toset([1])
  #    content {
  #      users = var.repository_environment.reviewers.users
  #      teams = var.repository_environment.reviewers.teams
  #    }
  #  }
  #  dynamic "deployment_branch_policy" {
  #    for_each = var.repository_environment.deployment_branch_policy.protected_branches == null ? toset([]) : toset([1])
  #    content {
  #      protected_branches     = var.repository_environment.deployment_branch_policy.protected_branches
  #      custom_branch_policies = var.repository_environment.deployment_branch_policy.custom_branch_policies
  #    }
  #  }
}
