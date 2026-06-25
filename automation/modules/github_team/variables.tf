variable "name" {
  description = "The name of the team"
  type        = string
}

variable "description" {
  description = "A description of the team"
  type        = string
  default     = null
}

variable "privacy" {
  description = "The level of privacy for the team (secret or closed)"
  type        = string
  default     = "closed"
  nullable    = false

  validation {
    condition     = contains(["secret", "closed"], var.privacy)
    error_message = "Privacy must be either 'secret' or 'closed'"
  }
}

variable "notification_setting" {
  description = "The notification setting for the team (notifications_enabled or notifications_disabled)"
  type        = string
  default     = "notifications_enabled"
  nullable    = false

  validation {
    condition     = contains(["notifications_enabled", "notifications_disabled"], var.notification_setting)
    error_message = "Notification setting must be either 'notifications_enabled' or 'notifications_disabled'."
  }
}

variable "members" {
  description = "List of team members with their role (member or maintainer)"
  type = list(object({
    username = string
    role     = optional(string, "member")
  }))

  validation {
    condition     = alltrue([for member in var.members : contains(["member", "maintainer"], member.role)])
    error_message = "Each member role must be either 'member' or 'maintainer'."
  }
}
