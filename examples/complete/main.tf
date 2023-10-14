module "repository" {
  source                        = "../../"
  context                       = module.this.context
  description                   = var.description
  required_pull_request_reviews = var.required_pull_request_reviews
  restrictions                  = var.restrictions
  status_checks_contexts        = var.status_checks_contexts
  action_secrets                = var.action_secrets
  dependabot_secrets            = var.dependabot_secrets
  environment_secrets           = var.environment_secrets
  archive_on_destroy            = var.archive_on_destroy
  template_repository           = var.template_repository
  is_template                   = var.is_template
  merge_commit_title            = var.merge_commit_title
  required_status_checks        = var.required_status_checks
  squash_merge_commit_message   = var.squash_merge_commit_message
  repository_environment        = var.repository_environment
}
