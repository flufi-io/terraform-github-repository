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

#resource "github_repository_file" "this" {
#  for_each = local.template_files_list
#  file       = each.value
#  repository = github_repository.this.name
#  content = data.github_repository_file.template[each.value].content
#}


#resource "github_branch_protection_v3" "main" {
#  depends_on                      = [github_repository.this, github_branch_default.main]
#  repository                      = github_repository.this.name
#  branch                          = github_branch_default.main.branch
#  enforce_admins                  = true
#  require_signed_commits          = true
#  require_conversation_resolution = true
#  dynamic "required_status_checks" {
#    for_each = var.required_status_checks != null ? toset([]) : toset([1])
#    content {
#      strict = true
#      checks = var.required_status_checks
#    }
#  }
#
#  dynamic "required_pull_request_reviews" {
#    for_each = var.required_pull_request_reviews != null ? toset([]) : toset([1])
#    content {
#      dismiss_stale_reviews           = var.required_pull_request_reviews.dismiss_stale_reviews
#      require_code_owner_reviews      = var.required_pull_request_reviews.require_code_owner_reviews
#      required_approving_review_count = var.required_pull_request_reviews.required_approving_review_count
#      dismissal_teams                 = var.required_pull_request_reviews.dismissal_teams
#      dismissal_users                 = var.required_pull_request_reviews.dismissal_users
#      dynamic "bypass_pull_request_allowances" {
#        for_each = length(var.required_pull_request_reviews.bypass_pull_request_allowances) == 0 ? toset([]) : toset([
#          1
#        ])
#        content {
#          users = var.required_pull_request_reviews.bypass_pull_request_allowances[0].users
#          teams = var.required_pull_request_reviews.bypass_pull_request_allowances[0].teams
#          apps  = var.required_pull_request_reviews.bypass_pull_request_allowances[0].apps
#        }
#      }
#    }
#  }
#
#  dynamic "restrictions" {
#    for_each = length(var.restrictions) == 0 ? toset([]) : toset([1])
#    content {
#      users = var.restrictions.users
#      teams = var.restrictions.teams
#      apps  = var.restrictions.apps
#    }
#  }
#}




#resource "github_actions_secret" "this" {
#  for_each        = var.action_secrets
#  repository      = github_repository.this.name
#  secret_name     = each.key
#  encrypted_value = each.value
#}


#### ENVIRONMENTS ####
#resource "github_repository_environment" "this" {
#  depends_on  = [time_sleep.wait]
#  environment = module.this.environment
#  repository  = github_repository.this.name
#  #  dynamic "reviewers" {
#  #    for_each = each.value.reviewers
#  #    content {
#  #      users = each.value.reviewers.users[*]
#  #      teams = each.value.reviewers.teams[*]
#  #    }
#  #  }
#  #  dynamic "deployment_branch_policy" {
#  #    for_each = each.value.deployment_branch_policy == null ? toset([]) : toset([1])
#  #    content {
#  #      protected_branches     = each.value.deployment_branch_policy.protected_branches
#  #      custom_branch_policies = each.value.deployment_branch_policy.custom_branch_policies
#  #    }
#  #  }
#}


#resource "github_branch" "template_files" {
#  depends_on = [
#    github_repository.this,
#    github_branch_default.main,
#    #    github_branch_protection_v3.main
#  ]
#  count      = length(var.template_files) == 0 ? 0 : 1
#  repository = github_repository.this.name
#  branch     = "template_files"
#}

#resource "github_repository_file" "template_files" {
#  depends_on = [
#    github_repository.this,
#    github_branch_default.main,
#    #    github_branch_protection_v3.main,
#    github_branch.template_files
#  ]
#  for_each            = length(var.template_files) == 0 ? toset([]) : toset(var.template_files)
#  repository          = github_repository.this.name
#  branch              = github_branch.template_files[0].branch
#  file                = each.value
#  content             = file("${var.template_files_prefix}/${each.value}")
#  commit_message      = "Managed by Terraform"
#  overwrite_on_create = true
#}
#
#resource "github_repository_pull_request" "template_files" {
#  depends_on = [
#    github_repository.this,
#    github_branch_default.main,
#    #    github_branch_protection_v3.main,
#    github_branch.template_files,
#    github_repository_file.template_files
#  ]
#  count           = length(var.template_files) == 0 ? 0 : 1
#  base_repository = github_repository.this.name
#  base_ref        = github_branch_default.main.branch
#  head_ref        = github_branch.template_files[0].branch
#  title           = "Added Template Files"
#  body            = "Merge this PR"
#}
