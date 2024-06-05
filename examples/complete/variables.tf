variable "description" {
  type        = string
  description = "Description of the repository"
  default     = "This is a test repository"
}
variable "visibility" {
  type        = string
  description = "Visibility of the repository"
  default     = "private"
}
variable "environment_secrets" {
  description = "Secrets to be stored in the repository secrets"
  type        = map(string)
  sensitive   = true
  default     = {}
}
variable "environment_variables" {
  description = "Variables to be stored in the repository for the environment"
  type        = map(string)
  default     = {}
  sensitive   = true
}
variable "archive_on_destroy" {
  type        = bool
  description = "Set to true to archive the repository instead of deleting it."
  default     = true # this is an example
}
variable "status_checks_contexts" {
  default     = []
  type        = list(string)
  description = "Contexts for the status_checks branch protection"
}
variable "required_pull_request_reviews" {
  default = null
  type = object({
    dismissal_teams                 = optional(list(string))
    dismissal_users                 = optional(list(string))
    dismiss_stale_reviews           = optional(bool)
    require_code_owner_reviews      = optional(bool)
    required_approving_review_count = optional(number)
  })
  description = "Branch protection options to require PR reviews."
}
#variable "restrictions" {
#  type = object({
#    teams = optional(list(string))
#    users = optional(list(string))
#    apps  = optional(list(string))
#  })
#  default     = null
#  description = "Branch protection,require restrictions (is only available for organization-owned repositories)."
#}

variable "required_deployment_environments" {
  default     = ["sandbox"]
  type        = list(string)
  description = "The list of environments that must be deployed to from this branch before it can be merged into the destination branch."
}


variable "commit_author_email_pattern" {
  type        = string
  description = "The pattern that the author email of the commits must match to be accepted."
  default     = "@flufi.io"
}

variable "github_token" {
  type        = string
  description = "Github Personal Access Token"
  sensitive   = true
}

variable "dependabot_environment" {
  type        = string
  description = "The environment to enable dependabot for"
  default     = "sandbox"
}
