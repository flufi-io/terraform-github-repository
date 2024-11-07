module "repository" {
  source              = "../../"
  description         = var.description
  environment_secrets = var.environment_secrets
  environment_variables = {
    "TERRAFORM" = "true"
  }
  dependabot_environment = var.dependabot_environment
  #checkov:skip=CKV_GIT_1:"Ensure GitHub repository is Private"
  visibility                       = var.visibility
  archive_on_destroy               = var.archive_on_destroy
  context                          = module.this.context
  status_checks_contexts           = var.status_checks_contexts
  required_pull_request_reviews    = var.required_pull_request_reviews
  required_deployment_environments = var.required_deployment_environments
  commit_author_email_pattern      = var.commit_author_email_pattern
  collaborators_users              = [{ username = "mnsanfilippo", permission = "admin" }]
}
