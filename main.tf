resource "github_repository" "repo" {
  name                 = var.name
  description          = var.description
  visibility           = var.visibility
  auto_init            = true
  vulnerability_alerts = true
}

resource "github_branch_default" "main" {
  repository = github_repository.repo.name
  branch     = "main"
}

resource "github_branch_protection_v3" "main" {
  depends_on                      = [github_repository.repo, github_branch_default.main]
  count                           = var.enable_branch_protection ? 1 : 0
  repository                      = github_repository.repo.name
  branch                          = github_branch_default.main.branch
  enforce_admins                  = true
  require_signed_commits          = true
  require_conversation_resolution = true

  dynamic "required_status_checks" {
    for_each = length(var.status_checks_contexts) == 0 ? toset([]) : toset([1])
    content {
      strict   = true
      contexts = var.status_checks_contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = length(var.required_pull_request_reviews) == 0 ? toset([]) : toset([1])
    content {
      dismiss_stale_reviews           = var.required_pull_request_reviews.dismiss_stale_reviews
      require_code_owner_reviews      = var.required_pull_request_reviews.require_code_owner_reviews
      required_approving_review_count = var.required_pull_request_reviews.required_approving_review_count
      dismissal_teams                 = var.required_pull_request_reviews.dismissal_teams
      dismissal_users                 = var.required_pull_request_reviews.dismissal_users
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


resource "github_branch" "template_files" {
  depends_on = [github_repository.repo, github_branch_default.main, github_branch_protection_v3.main]
  count      = length(var.template_files) == 0 ? 0 : 1
  repository = github_repository.repo.name
  branch     = "template_files"
}

resource "github_repository_file" "template_files" {
  depends_on = [
    github_repository.repo,
    github_branch_default.main,
    github_branch_protection_v3.main,
    github_branch.template_files
  ]
  for_each            = length(var.template_files) == 0 ? toset([]) : toset(var.template_files)
  repository          = github_repository.repo.name
  branch              = github_branch.template_files[0].branch
  file                = trimprefix(each.value, var.template_files_prefix)
  content             = file(each.value)
  commit_message      = "Managed by Terraform"
  overwrite_on_create = true
}

resource "github_repository_pull_request" "template_files" {
  depends_on = [
    github_repository.repo,
    github_branch_default.main,
    github_branch_protection_v3.main,
    github_branch.template_files,
    github_repository_file.template_files
  ]
  count           = length(var.template_files) == 0 ? 0 : 1
  base_repository = github_repository.repo.name
  base_ref        = github_branch_default.main.branch
  head_ref        = github_branch.template_files[0].branch
  title           = "Added Template Files"
  body            = "Merge this PR"
}
