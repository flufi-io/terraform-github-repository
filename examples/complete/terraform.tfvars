name        = "testing-template-repository-jkshdbjk"
visibility  = "public"
description = "testing template repository"
template_files = [
  "../../.config/.terraform-docs.yml",

  "../../.github/workflows/tfsec.yml",

  "../../.gitignore",
  "../../main.tf",
  "../../variables.tf",
  "../../versions.tf",
  "../../outputs.tf",
  "../../README.md",

  "../../examples/complete/main.tf",
  "../../examples/complete/variables.tf",
  "../../examples/complete/versions.tf",
  "../../examples/complete/outputs.tf",
  "../../examples/complete/terraform.tfvars",
  "../../examples/complete/providers.tf",

  "../../tests/complete/complete_test.go",
]
template_files_prefix = "../../"

restrictions = {
  teams = ["@flufi-io/devops-engineers"]
  users = ["pipo-flufi"]
  apps  = []
}
required_pull_request_reviews = {
  dismissal_teams                 = ["@flufi-io/devops-engineers"]
  dismissal_users                 = ["pipo-flufi"]
  dismiss_stale_reviews           = true
  require_code_owner_reviews      = true
  required_approving_review_count = 1
}
status_checks_contexts = ["terratest"]
