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
