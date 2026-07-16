variable "name" {
  description = "The name of the repository"
  type        = string
}

variable "description" {
  description = "A description of the repository"
  type        = string
  default     = null
}

variable "homepage_url" {
  description = "URL of a page describing the repository"
  type        = string
  default     = null
}

variable "topics" {
  description = "A list of topics for the repository"
  type        = list(string)
  default     = null
}

variable "pages_enabled" {
  description = "Whether to enable GitHub Pages for the repository"
  type        = bool
  default     = false
  nullable    = false
}

variable "visibility" {
  description = "The visibility of the repository (public or private)"
  type        = string
  default     = "private"
  nullable    = false

  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "Visibility must be either 'public' or 'private'."
  }
}

variable "default_branch" {
  description = "The default branch of the repository"
  type        = string
  default     = "main"
  nullable    = false
}

variable "collaborator_teams" {
  description = "List of teams with access to the repository, each with a team name and permission level"
  type = list(object({
    name       = string
    permission = string
  }))
  default  = []
  nullable = false

  validation {
    condition     = alltrue([for team in var.collaborator_teams : contains(["pull", "triage", "push", "maintain", "admin"], team.permission)])
    error_message = "Each team permission must be one of: 'pull', 'triage', 'push', 'maintain', or 'admin'."
  }
}

variable "rulesets" {
  description = "List of repository rulesets to apply"
  type = list(object({
    name        = string
    target      = optional(string, "branch") # branch | tag | push
    enforcement = optional(string, "active") # disabled | active | evaluate

    conditions = optional(object({
      ref_name = optional(object({
        include = optional(list(string), [])
        exclude = optional(list(string), [])
      }))
    }))

    rules = object({
      deletion            = optional(bool)
      non_fast_forward    = optional(bool)
      required_signatures = optional(bool)

      pull_request = optional(object({
        required_approving_review_count = optional(number)
        require_code_owner_review       = optional(bool)
        dismiss_stale_reviews_on_push   = optional(bool)
        require_last_push_approval      = optional(bool)
        allowed_merge_methods           = optional(list(string))
      }))

      required_status_checks = optional(object({
        strict_required_status_checks_policy = optional(bool)
        required_check = list(object({
          context        = string
          integration_id = optional(number)
        }))
      }))
    })
  }))
  default  = []
  nullable = false

  validation {
    condition     = alltrue([for r in var.rulesets : contains(["branch", "tag", "push"], r.target)])
    error_message = "Each ruleset target must be one of: 'branch', 'tag', or 'push'."
  }

  validation {
    condition     = alltrue([for r in var.rulesets : contains(["disabled", "active", "evaluate"], r.enforcement)])
    error_message = "Each ruleset enforcement must be one of: 'disabled', 'active', or 'evaluate'."
  }
}
