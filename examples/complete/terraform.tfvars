archive_on_destroy = "false"

description = "This is a test repository"

environment = "sandbox"

label_order = ["namespace", "stage", "name", "environment"]

name = "repository"

namespace = "flufi"

required_deployment_environments = ["sandbox"]


stage = "module"

visibility                  = "public"
status_checks_contexts      = ["terratest"]
commit_author_email_pattern = "@flufi.io"

dependabot_environment = "sandbox"
required_pull_request_reviews = {
  dismissal_apps                    = ["codiumai-pr-agent-pro"]
  dismissal_users                   = ["mnsanfilippo"]
  dismiss_stale_reviews             = true
  require_code_owner_reviews        = true
  required_approving_review_count   = 1
  require_last_push_approval        = true
  required_review_thread_resolution = true
  bypass_pull_request_allowances = {
    users = ["mnsanfilippo"]
    apps  = ["codiumai-pr-agent-pro"]
  }
}
