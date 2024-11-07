variable "description" {
  type        = string
  description = "Description of the repository"
  default     = ""
}

variable "visibility" {
  type        = string
  description = "Visibility of the repository"
  default     = "private"
}

variable "auto_init" {
  description = "Automatically initialize the repository with a README file."
  type        = bool
  default     = true
}

variable "vulnerability_alerts" {
  description = "Enable vulnerability alerts for the repository."
  type        = bool
  default     = true
}

variable "has_issues" {
  description = "Enable issues for the repository."
  type        = bool
  default     = true
}

variable "has_projects" {
  description = "Enable projects for the repository."
  type        = bool
  default     = true
}

variable "has_wiki" {
  description = "Enable wiki for the repository."
  type        = bool
  default     = true
}

variable "allow_merge_commit" {
  description = "Allow merge commits for pull requests."
  type        = bool
  default     = true
}

variable "allow_squash_merge" {
  description = "Allow squash merging for pull requests."
  type        = bool
  default     = false
}

variable "allow_rebase_merge" {
  description = "Allow rebase merging for pull requests."
  type        = bool
  default     = false
}

variable "delete_branch_on_merge" {
  description = "Delete branches after merging pull requests."
  type        = bool
  default     = true
}

variable "allow_auto_merge" {
  description = "Allow auto-merge on pull requests."
  type        = bool
  default     = true
}

variable "allow_update_branch" {
  description = "Allow branch updates before merging pull requests."
  type        = bool
  default     = true
}

variable "web_commit_signoff_required" {
  description = "Require contributors to sign off on commits made through the web interface."
  type        = bool
  default     = true
}

variable "status_checks_contexts" {
  default     = []
  type        = list(string)
  description = "Contexts for the status_checks branch protection"
}
variable "required_pull_request_reviews" {
  default = null
  type = object({
    dismissal_teams                   = optional(list(string))
    dismissal_users                   = optional(list(string))
    dismissal_apps                    = optional(list(string))
    dismiss_stale_reviews             = optional(bool)
    require_code_owner_reviews        = optional(bool)
    required_approving_review_count   = optional(number)
    require_last_push_approval        = optional(bool, false)
    required_review_thread_resolution = optional(bool)
    bypass_pull_request_allowances = optional(object({
      users = optional(list(string))
      teams = optional(list(string))
      apps  = optional(list(string))
    }))
  })
  description = "Branch protection options to require PR reviews."
}
# variable "restrictions" {
#   type = object({
#     teams = optional(list(string))
#     users = optional(list(string))
#     apps  = optional(list(string))
#   })
#   default     = null
#   description = "Branch protection,require restrictions (is only available for organization-owned repositories)."
# }

variable "environment_secrets" {
  description = "Secrets to be stored in the repository for the environment"
  type        = map(string)
  sensitive   = true
  default     = {}
}
variable "environment_variables" {
  description = "Variables to be stored in the repository for the environment"
  type        = map(string)
  default     = {}
}
variable "template" {
  description = "Template repository to use for this repository"
  default     = null
  type = object({
    owner                = string
    repository           = string
    include_all_branches = optional(bool, false)
  })
}
variable "archive_on_destroy" {
  type        = bool
  description = "Set to true to archive the repository instead of deleting it."
  default     = false
}
variable "required_deployment_environments" {
  default     = []
  type        = list(string)
  description = "The list of environments that must be deployed to from this branch before it can be merged into the destination branch."
}
variable "commit_author_email_pattern" {
  type        = string
  description = "The pattern that the author email of the commits must match to be accepted."
  default     = ""
}

variable "dependabot_environment" {
  type        = string
  description = "The environment to enable dependabot for"
  default     = "sandbox"
}
