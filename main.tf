resource "github_repository" "this" {
  name                        = module.this.name
  description                 = var.description
  visibility                  = var.visibility
  auto_init                   = true
  vulnerability_alerts        = true
  has_issues                  = true
  has_projects                = true
  has_wiki                    = true
  allow_merge_commit          = true
  allow_squash_merge          = true
  allow_rebase_merge          = true
  delete_branch_on_merge      = true
  allow_auto_merge            = true
  web_commit_signoff_required = true
  allow_update_branch         = true
  archive_on_destroy          = var.archive_on_destroy

  dynamic "template" {
    for_each = var.template == null ? toset([]) : toset([1])
    content {
      owner                = var.template.owner
      repository           = var.template.repository
      include_all_branches = var.template.include_all_branches
    }
  }

}

resource "github_branch_default" "main" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_branch_protection" "main" {
  repository_id  = github_repository.this.node_id
  pattern        = "main"
  enforce_admins = true
  dynamic "required_status_checks" {
    for_each = var.status_checks_contexts == null ? toset([]) : toset([1])
    content {
      strict   = true
      contexts = var.status_checks_contexts
    }
  }
  dynamic "required_pull_request_reviews" {
    for_each = var.required_pull_request_reviews == null ? toset([]) : toset([1])
    content {
      dismiss_stale_reviews           = true
      require_code_owner_reviews      = var.required_pull_request_reviews.require_code_owner_reviews
      required_approving_review_count = var.required_pull_request_reviews.required_approving_review_count
      require_last_push_approval      = true
    }
  }
  required_linear_history = true
  require_signed_commits  = true
  allows_deletions        = false
  allows_force_pushes     = false
}
#resource "github_branch_protection_v3" "main" {
#  depends_on                      = [github_repository.this, github_branch_default.main]
#  count                           = var.enable_branch_protection ? 1 : 0
#  repository                      = github_repository.this.name
#  branch                          = github_branch_default.main.branch
#  enforce_admins                  = true
#  require_signed_commits          = true
#  require_conversation_resolution = true
#  dynamic "required_status_checks" {
#    for_each = var.status_checks_contexts == null ? toset([]) : toset([1])
#    content {
#      strict = true
#      checks = var.status_checks_contexts
#    }
#  }
#
#  dynamic "required_pull_request_reviews" {
#    for_each = var.required_pull_request_reviews == null ? toset([]) : toset([1])
#    content {
#      dismiss_stale_reviews           = var.required_pull_request_reviews.dismiss_stale_reviews
#      require_code_owner_reviews      = var.required_pull_request_reviews.require_code_owner_reviews
#      required_approving_review_count = var.required_pull_request_reviews.required_approving_review_count
#      dismissal_teams                 = var.required_pull_request_reviews.dismissal_teams
#      dismissal_users                 = var.required_pull_request_reviews.dismissal_users
#    }
#  }
#
#  dynamic "restrictions" {
#    for_each = var.restrictions == null ? toset([]) : toset([1])
#    content {
#      users = var.restrictions.users
#      teams = var.restrictions.teams
#      apps  = var.restrictions.apps
#    }
#  }
#}
resource "github_repository_environment" "this" {
  environment = module.this.environment
  repository  = github_repository.this.name
  #  deployment_branch_policy {
  #    protected_branches     = true
  #    custom_branch_policies = false
  #  }
}

#resource "github_repository_deployment_branch_policy" "this" {
#  depends_on = [github_repository_environment.this]
#
#  repository       = github_repository.this.name
#  environment_name = github_repository_environment.this.environment
#  name             = "main"
#}

resource "github_actions_environment_secret" "this" {
  for_each        = var.secrets
  environment     = github_repository_environment.this.environment
  secret_name     = each.key
  encrypted_value = each.value
  repository      = github_repository.this.name
}

resource "github_dependabot_secret" "this" {
  for_each        = github_repository_environment.this.environment == "sandbox" ? var.secrets : {}
  secret_name     = each.key
  encrypted_value = each.value
  repository      = github_repository.this.name
}


resource "github_repository_ruleset" "this" {
  repository  = github_repository.this.name
  enforcement = "active"
  name        = "main"
  target      = "branch"
  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }
  rules {
    creation                = true
    update                  = true
    deletion                = true
    required_linear_history = true
    required_signatures     = true
    pull_request {
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = var.required_pull_request_reviews.require_code_owner_reviews
      required_approving_review_count   = var.required_pull_request_reviews.required_approving_review_count
      require_last_push_approval        = true
      required_review_thread_resolution = true
    }
    required_deployments {
      required_deployment_environments = var.required_deployment_environments
    }
    required_status_checks {
      dynamic "required_check" {
        for_each = var.status_checks_contexts
        content {
          context = required_check.value
        }
      }
      strict_required_status_checks_policy = true
    }
  }
}
