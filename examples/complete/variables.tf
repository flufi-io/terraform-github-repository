variable "description" {
  type        = string
  description = "Description of the repository"
}
variable "visibility" {
  type        = string
  description = "Visibility of the repository"
  default     = "private"
}
variable "secrets" {
  default = {}
  type    = map(string)
}
variable "archive_on_destroy" {
  type        = bool
  description = "Set to true to archive the repository instead of deleting it."
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
  type        = list(string)
  description = "The list of environments that must be deployed to from this branch before it can be merged into the destination branch."
}
