# TODO: replace data source with proper resource to manage actual repository
data "github_repository" "repository" {
  name = var.name
}

resource "github_repository_collaborators" "collaborators" {
  repository = data.github_repository.repository.name

  dynamic "team" {
    for_each = var.collaborator_teams
    content {
      team_id    = team.value.name
      permission = team.value.permission
    }
  }
}

resource "github_repository_ruleset" "ruleset" {
  for_each = { for ruleset in var.rulesets : ruleset.name => ruleset }

  repository  = data.github_repository.repository.name
  name        = each.value.name
  target      = each.value.target
  enforcement = each.value.enforcement

  dynamic "conditions" {
    for_each = each.value.conditions != null ? [each.value.conditions] : []
    content {
      dynamic "ref_name" {
        for_each = conditions.value.ref_name != null ? [conditions.value.ref_name] : []
        content {
          include = ref_name.value.include
          exclude = ref_name.value.exclude
        }
      }
    }
  }

  rules {
    deletion            = each.value.rules.deletion
    non_fast_forward    = each.value.rules.non_fast_forward
    required_signatures = each.value.rules.required_signatures

    dynamic "pull_request" {
      for_each = each.value.rules.pull_request != null ? [each.value.rules.pull_request] : []
      content {
        required_approving_review_count = pull_request.value.required_approving_review_count
        require_code_owner_review       = pull_request.value.require_code_owner_review
        dismiss_stale_reviews_on_push   = pull_request.value.dismiss_stale_reviews_on_push
        require_last_push_approval      = pull_request.value.require_last_push_approval
        allowed_merge_methods           = pull_request.value.allowed_merge_methods
      }
    }

    dynamic "required_status_checks" {
      for_each = each.value.rules.required_status_checks != null ? [each.value.rules.required_status_checks] : []
      content {
        strict_required_status_checks_policy = required_status_checks.value.strict_required_status_checks_policy

        dynamic "required_check" {
          for_each = required_status_checks.value.required_check
          content {
            context        = required_check.value.context
            integration_id = required_check.value.integration_id
          }
        }
      }
    }
  }
}
