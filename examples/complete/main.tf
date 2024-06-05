module "repository" {
  source                           = "../../"
  description                      = var.description
  secrets                          = var.secrets
  visibility                       = var.visibility
  archive_on_destroy               = var.archive_on_destroy
  context                          = module.this.context
  status_checks_contexts           = var.status_checks_contexts
  required_pull_request_reviews    = var.required_pull_request_reviews
  required_deployment_environments = var.required_deployment_environments
  commit_author_email_pattern      = var.commit_author_email_pattern
}
