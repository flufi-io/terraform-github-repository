##### REPOSITORY #####
variable "description" {
  type        = string
  description = "Description of the repository"
}
variable "archive_on_destroy" {
  type        = bool
  default     = true
  description = "Set to false to prevent the repository from being archived when destroyed"
}
#variable "visibility" {
#  type        = string
#  description = "Visibility of the repository"
#  default     = "private"
#}


#variable "status_checks_contexts" {
#  default     = []
#  type        = list(string)
#  description = "Contexts for the status_checks branch protection"
#}

#variable "restrictions" {
#  type = object({
#    teams = list(string)
#    users = list(string)
#    apps  = list(string)
#  })
#  description = "Branch protection,require restrictions (is only available for organization-owned repositories)."
#}

#variable "action_secrets" {
#  default = {}
#  type    = map(string)
#}

#variable "required_status_checks" {
#  type = list(object({
#    strict = bool
#    checks = list(string)
#  }))
#  default     = []
#  description = "A list of status checks to require in order to merge into the main branch"
#}


#variable "squash_merge_commit_message" {
#  description = "The commit message to use for squash merges"
#  default     = "PR_TITLE"
#  type        = string
#}
#variable "merge_commit_title" {
#  description = "The commit title to use for merge commits"
#  type        = string
#  default     = "PR_TITLE"
#}

#variable "required_pull_request_reviews" {
#  type = object({
#    dismissal_teams                 = optional(list(string))
#    dismissal_users                 = optional(list(string))
#    dismiss_stale_reviews           = optional(bool)
#    require_code_owner_reviews      = optional(bool)
#    required_approving_review_count = optional(number)
#    bypass_pull_request_allowances = optional(object({
#      users = optional(list(string))
#      teams = optional(list(string))
#      apps  = optional(list(string))
#      })
#    )
#  })
#  default = {
#    dismiss_stale_reviews           = true
#    require_code_owner_reviews      = true
#    required_approving_review_count = 1
#    bypass_pull_request_allowances = {
#      users = []
#      teams = []
#      apps  = []
#    }
#  }
#  description = "Branch protection options to require PR reviews."
#}


#variable "environments" {
#  type = map(object({
#    reviewers = optional(object({
#      users = optional(list(string))
#      teams = optional(list(string))
#    }))
#    deployment_branch_policy = optional(object({
#      protected_branches     = optional(bool)
#      custom_branch_policies = optional(bool)
#    }))
#  }))
#  description = "A map of environments to create"
#  default     = null
#}
variable "is_template" {
  default     = false
  description = "Whether the repository acts as a template that can be used to generate new repositories"
  type        = bool
}

#### FROM TEMPLATE ####
#
variable "template_repository" {
  type = object({
    owner                = string
    name                 = string
    include_all_branches = optional(bool)
  })
  description = "The repository to use as a template"
  default     = null
}
#variable "template_files" {
#  type        = list(string)
#  description = "A list of files to include in the repository"
#  default     = []
#}
